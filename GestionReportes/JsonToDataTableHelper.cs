
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace SIMANET_W22R.GestionReportes
{
    /// <summary>
    /// Helper genérico para:
    /// - Invocar endpoints (ASMX/REST) que devuelven JSON (con o sin wrapper XML <string>).
    /// - Convertir arreglos JSON de objetos (lista de diccionarios) a DataTable.
    /// - Soporta GET/POST, parámetros dinámicos, y rutas de propiedades configurables para success/data/error.
    /// </summary>
    public static class JsonToDataTableHelper
    {
        // HttpClient reusable (singleton) para toda la app.
        private static readonly HttpClient _http = new HttpClient
        {
            Timeout = TimeSpan.FromMinutes(5)
        };

        /// <summary>
        /// Invoca un endpoint y devuelve un DataTable a partir del arreglo JSON encontrado en dataPath.
        /// </summary>
        /// <param name="baseUrl">Ej: "https://api-netsuite.sima.com.pe:449/Core/SeguridadPlanta/Visitas.asmx"</param>
        /// <param name="methodName">Ej: "Listar_mob_x_fecha_json"</param>
        /// <param name="httpMethod">GET o POST</param>
        /// <param name="parameters">Parámetros dinámicos (nombre → valor)</param>
        /// <param name="successPath">Ruta JSON a la bandera de éxito (por defecto "success"). Ej: "meta.ok"</param>
        /// <param name="dataPath">
        /// Ruta JSON al arreglo de datos (por defecto "data"). Ej: "payload.items".
        /// Si el JSON raíz YA es un arreglo, pasa dataPath = "".
        /// </param>
        /// <param name="errorMessagePath">Ruta JSON a mensaje de error (por defecto "error.message" o "errorMessage").</param>
        /// <param name="inferTypes">Si true, intenta tipar columnas (DateTime/decimal/int/bool). Si false, todo string.</param>
        /// <param name="tableName">Nombre del DataTable resultante.</param>
        /// <param name="extraHeaders">Headers HTTP opcionales (Authorization, etc.).</param>
        public static async Task<DataTable> CallAndConvertAsync(
            string baseUrl,
            string methodName,
            HttpMethod httpMethod,
            IDictionary<string, string> parameters,
            string successPath = "success",
            string dataPath = "data",
            string errorMessagePath = "error.message|errorMessage",
            bool inferTypes = false,
            string tableName = "Table", // estandar es Table , no colocar Result
            IDictionary<string, string> extraHeaders = null)
        {
            if (string.IsNullOrWhiteSpace(baseUrl))
                return BuildErrorTable("baseUrl vacío.", tableName);

            var url = $"{baseUrl.TrimEnd('/')}/{methodName}";
            string raw;

            try
            {
                using (var req = await BuildHttpRequestAsync(url, httpMethod, parameters, extraHeaders))
                using (var resp = await _http.SendAsync(req).ConfigureAwait(false))
                {
                    resp.EnsureSuccessStatusCode();
                    raw = await resp.Content.ReadAsStringAsync().ConfigureAwait(false);
                }
            }
            catch (Exception exHttp)
            {
                return BuildErrorTable("Error HTTP: " + exHttp.Message, tableName);
            }

            if (string.IsNullOrWhiteSpace(raw))
                return BuildErrorTable("Respuesta vacía del servicio.", tableName);

            // Si viene XML con <string>JSON</string>, extrae JSON.
            var json = TryExtractJsonFromXmlWrapper(raw, out var xmlErr);
            if (json == null)
                return BuildErrorTable(xmlErr ?? "El servicio devolvió XML sin contenido JSON válido.", tableName);

            return ConvertJsonToDataTable(
                json, successPath, dataPath, errorMessagePath, inferTypes, tableName
            );
        }

        /// <summary>
        /// Convierte un JSON (string) en DataTable, buscando success/data según las rutas configuradas.
        /// </summary>
        public static DataTable ConvertJsonToDataTable(
        string json,
        string successPath = "success",
        string dataPath = "data",
        string errorMessagePath = "error.message|errorMessage",
        bool inferTypes = false,
        string tableName = "Table")   // estandar es Table , no colocar Result
        {
            if (string.IsNullOrWhiteSpace(json))
                return BuildErrorTable("JSON vacío.", tableName);

            JToken rootToken;
            try
            {
                rootToken = JsonConvert.DeserializeObject<JToken>(json);
            }
            catch (Exception ex)
            {
                return BuildErrorTable("Error procesando JSON: " + ex.Message, tableName);
            }

            // Caso 1: el JSON raíz ya es un arreglo → convertir directo
            var arrRootDirect = rootToken as JArray;
            if (arrRootDirect != null)
                return FromJArray(arrRootDirect, inferTypes, tableName);

            // Caso 2: el JSON raíz es objeto → aplicar envelope (success/data/error)
            var root = rootToken as JObject;
            if (root == null)
                return BuildErrorTable("Estructura JSON no soportada (no es objeto ni arreglo).", tableName);

            // Validar success si fue configurado
            if (!string.IsNullOrWhiteSpace(successPath))
            {
                var successToken = SelectTokenSafe(root, successPath);
                if (successToken != null && successToken.Type != JTokenType.Null)
                {
                    bool ok;
                    try { ok = successToken.Value<bool>(); }
                    catch { ok = false; }

                    if (!ok)
                    {
                        string msg = ExtractFirstNonEmpty(root, errorMessagePath) ?? "El servicio indicó 'success=false'.";
                        return BuildErrorTable(msg, tableName);
                    }
                }
                // Si no hay success, continuamos; algunos endpoints no lo incluyen.
            }

            // Localizar data
            if (string.IsNullOrWhiteSpace(dataPath))
            {
                // dataPath vacío => buscar el PRIMER arreglo en cualquier parte del objeto
                var firstArray = root.Descendants().FirstOrDefault(t => t is JArray);
                var arrGuess = firstArray as JArray;
                if (arrGuess != null)
                    return FromJArray(arrGuess, inferTypes, tableName);

                return BuildErrorTable("No se encontró un arreglo JSON en la respuesta.", tableName);
            }
            else
            {
                var dataToken = SelectTokenSafe(root, dataPath);
                if (dataToken == null || dataToken.Type == JTokenType.Null)
                    return BuildErrorTable("No se encontró la ruta de datos '" + dataPath + "' en el JSON.", tableName);

                var arr = dataToken as JArray;
                if (arr != null)
                    return FromJArray(arr, inferTypes, tableName);

                var objOne = dataToken as JObject;
                if (objOne != null)
                    return FromJArray(new JArray(objOne), inferTypes, tableName);

                return BuildErrorTable("La ruta '" + dataPath + "' no es un arreglo ni un objeto JSON.", tableName);
            }
        }
        /// <summary>
        /// Convierte un JArray de objetos en DataTable.
        /// </summary>
        public static DataTable FromJArray(JArray array, bool inferTypes = false, string tableName = "Table") // el nombre de tabla es Table no es Result
        {
            var dt = new DataTable(tableName);

            if (array == null || array.Count == 0)
                return dt;

            // Recolectar todas las columnas (union de propiedades)
            var allColumns = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            foreach (JObject row in array.OfType<JObject>())
                foreach (var p in row.Properties())
                    allColumns.Add(p.Name);

            // Inferencia de tipos (opcional). Si no, todo string.
            var columnTypes = new Dictionary<string, Type>(StringComparer.OrdinalIgnoreCase);
            foreach (var col in allColumns)
            {
                var type = inferTypes ? InferType(array, col) : typeof(string);
                dt.Columns.Add(col, type);
                columnTypes[col] = type;
            }

            // Poblar filas
            foreach (JObject row in array.OfType<JObject>())
            {
                var dr = dt.NewRow();
                foreach (var col in allColumns)
                {
                    var token = row[col];
                    if (token == null || token.Type == JTokenType.Null)
                    {
                        dr[col] = DBNull.Value;
                        continue;
                    }

                    var targetType = columnTypes[col];

                    // Convertir según el tipo de columna elegido
                    try
                    {
                        if (targetType == typeof(string))
                        {
                            var s = token.ToString();
                            s = s.Replace("\r", "").Replace("\n", "").Replace("\t", " ").Trim();
                            dr[col] = s;
                        }
                        else if (targetType == typeof(DateTime))
                        {
                            // Soporta ISO 8601 (ya generas "yyyy-MM-ddTHH:mm:ssZ")
                            dr[col] = token.Type == JTokenType.Date
                                      ? token.Value<DateTime>()
                                      : DateTime.Parse(token.ToString(), CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal);
                        }
                        else if (targetType == typeof(int))
                        {
                            dr[col] = token.Type == JTokenType.Integer ? token.Value<int>() : Convert.ToInt32(token.ToString(), CultureInfo.InvariantCulture);
                        }
                        else if (targetType == typeof(long))
                        {
                            dr[col] = token.Type == JTokenType.Integer ? token.Value<long>() : Convert.ToInt64(token.ToString(), CultureInfo.InvariantCulture);
                        }
                        else if (targetType == typeof(decimal))
                        {
                            dr[col] = token.Type == JTokenType.Float || token.Type == JTokenType.Integer
                                      ? token.Value<decimal>()
                                      : Convert.ToDecimal(token.ToString(), CultureInfo.InvariantCulture);
                        }
                        else if (targetType == typeof(double))
                        {
                            dr[col] = token.Type == JTokenType.Float || token.Type == JTokenType.Integer
                                      ? token.Value<double>()
                                      : Convert.ToDouble(token.ToString(), CultureInfo.InvariantCulture);
                        }
                        else if (targetType == typeof(bool))
                        {
                            dr[col] = token.Type == JTokenType.Boolean ? token.Value<bool>() : Convert.ToBoolean(token.ToString(), CultureInfo.InvariantCulture);
                        }
                        else
                        {
                            // Cualquier otro tipo → string por seguridad
                            dr[col] = token.ToString();
                        }
                    }
                    catch
                    {
                        // Ante error de conversión → almacena string
                        dr[col] = token.ToString();
                    }
                }

                dt.Rows.Add(dr);
            }

            return dt;
        }

        /// <summary>
        /// Construye un HttpRequestMessage para GET/POST con parámetros dinámicos.
        /// POST → FormUrlEncodedContent (compatible ASMX/legacy).
        /// GET  → querystring.
        /// </summary>
        private static async Task<HttpRequestMessage> BuildHttpRequestAsync(
            string url,
            HttpMethod method,
            IDictionary<string, string> parameters,
            IDictionary<string, string> extraHeaders)
        {
            var req = new HttpRequestMessage(method, url);

            // Headers opcionales
            if (extraHeaders != null)
            {
                foreach (var kv in extraHeaders)
                    req.Headers.TryAddWithoutValidation(kv.Key, kv.Value);
            }

            if (method == HttpMethod.Get)
            {
                if (parameters != null && parameters.Count > 0)
                {
                    var qs = string.Join("&", parameters.Select(kv => $"{Uri.EscapeDataString(kv.Key)}={Uri.EscapeDataString(kv.Value ?? string.Empty)}"));
                    req.RequestUri = new Uri(url + (url.Contains("?") ? "&" : "?") + qs);
                }
            }
            else
            {
                // POST con form-urlencoded (ASMX-friendly)
                var form = parameters ?? new Dictionary<string, string>();
                req.Content = new FormUrlEncodedContent(form);
            }

            // Pequeño delay awaitable para cumplir firma async (si nada más es async)
            await Task.Yield();
            return req;
        }

        /// <summary>
        /// Intenta extraer JSON desde un XML wrapper típico de ASMX: <string>JSON</string>.
        /// Si no es XML, retorna la entrada original.
        /// </summary>
        private static string TryExtractJsonFromXmlWrapper(string raw, out string error)
        {
            error = null;
            var s = raw?.TrimStart();
            if (string.IsNullOrWhiteSpace(s)) return raw;
            if (!s.StartsWith("<")) return raw; // No parece XML → se asume JSON directo

            try
            {
                var xml = new XmlDocument();
                xml.LoadXml(raw);

                // Busca <string>...</string>
                var jsonNode = xml.SelectSingleNode("//*[local-name()='string']");
                if (jsonNode != null && !string.IsNullOrWhiteSpace(jsonNode.InnerText))
                    return jsonNode.InnerText.Trim();

                // SOAP fault
                var faultNode = xml.SelectSingleNode("//*[local-name()='faultstring']");
                if (faultNode != null)
                {
                    error = "Error SOAP: " + faultNode.InnerText;
                    return null;
                }

                error = "XML recibido pero no se encontró nodo con JSON.";
                return null;
            }
            catch (Exception ex)
            {
                error = "Error procesando XML: " + ex.Message;
                return null;
            }
        }

        /// <summary>
        /// Selecciona un token usando una ruta con puntos. Soporta múltiples alternativas separadas por '|'.
        /// Ej: "data.items|payload.rows".
        /// </summary>
        private static JToken SelectTokenSafe(JObject root, string dottedPathWithAlternatives)
        {
            if (root == null || string.IsNullOrWhiteSpace(dottedPathWithAlternatives))
                return null;

            var alternatives = dottedPathWithAlternatives.Split('|');
            foreach (var path in alternatives)
            {
                var token = SelectTokenByPath(root, path.Trim());
                if (token != null) return token;
            }
            return null;
        }

        private static JToken SelectTokenByPath(JToken token, string dottedPath)
        {
            if (string.IsNullOrWhiteSpace(dottedPath)) return token;
            var parts = dottedPath.Split('.');
            JToken current = token;

            foreach (var p in parts)
            {
                if (current == null) return null;
                current = current[p];
            }
            return current;
        }

        private static DataTable BuildErrorTable(string message, string tableName = "Error")
        {
            var dt = new DataTable(tableName);
            dt.Columns.Add("success", typeof(bool));
            dt.Columns.Add("message", typeof(string));
            dt.Rows.Add(false, message ?? "Error");
            return dt;
        }

        /// <summary>
        /// Inferencia simple de tipo de columna examinando varias filas.
        /// </summary>
        private static Type InferType(JArray array, string columnName)
        {
            // Analiza hasta N valores no nulos de la columna
            const int SAMPLE = 200;
            var samples = array.OfType<JObject>()
                               .Select(o => o[columnName])
                               .Where(t => t != null && t.Type != JTokenType.Null)
                               .Take(SAMPLE)
                               .ToList();

            if (samples.Count == 0) return typeof(string);

            bool allInt = true, allLong = true, allDec = true, allDouble = true, allBool = true, allDate = true;

            foreach (var t in samples)
            {
                var s = t.Type == JTokenType.String ? t.Value<string>() : t.ToString();

                // Boolean
                bool b;
                if (!bool.TryParse(s, out b) && t.Type != JTokenType.Boolean)
                    allBool = false;

                // Int / Long
                long lv;
                if (!long.TryParse(s, NumberStyles.Integer, CultureInfo.InvariantCulture, out lv) && t.Type != JTokenType.Integer)
                {
                    allInt = false; allLong = false;
                }
                else
                {
                    // si excede rango int
                    if (lv < int.MinValue || lv > int.MaxValue) allInt = false;
                }

                // Decimal / Double
                decimal dv;
                if (!decimal.TryParse(s, NumberStyles.Float, CultureInfo.InvariantCulture, out dv) &&
                    t.Type != JTokenType.Float && t.Type != JTokenType.Integer)
                {
                    allDec = false; allDouble = false;
                }

                // DateTime (ISO 8601 preferente)
                DateTime dtv;
                if (!(t.Type == JTokenType.Date || DateTime.TryParse(s, CultureInfo.InvariantCulture,
                        DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal, out dtv)))
                    allDate = false;
            }

            if (allBool) return typeof(bool);
            if (allInt) return typeof(int);
            if (allLong) return typeof(long);
            if (allDec) return typeof(decimal);
            if (allDouble) return typeof(double);
            if (allDate) return typeof(DateTime);

            return typeof(string);
        }

        /// <summary>
        /// Recorre rutas alternativas separadas por '|' y devuelve el primer token no vacío como string.
        /// Ej: "error.message|errorMessage|meta.error.text"
        /// </summary>
        private static string ExtractFirstNonEmpty(JObject root, string dottedPathWithAlternatives)
        {
            if (root == null || string.IsNullOrWhiteSpace(dottedPathWithAlternatives))
                return null;

            var alternatives = dottedPathWithAlternatives.Split('|');
            foreach (var path in alternatives)
            {
                var token = SelectTokenByPath(root, path.Trim());
                if (token == null || token.Type == JTokenType.Null)
                    continue;

                var s = token.Type == JTokenType.String ? token.Value<string>() : token.ToString();
                if (!string.IsNullOrWhiteSpace(s))
                    return s.Trim();
            }
            return null;
        }

    }
}
