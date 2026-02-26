using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SIMANET_W22R.srvGestionProduccion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProduccion.Mob
{
    /// <summary>
    /// Descripción breve de ManoObra
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class ManoObra : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Vacaciones(string D_PERIODO, string V_CO, string V_ROL, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_vacaciones(D_PERIODO, V_CO, V_ROL, UserName);
            //dt.TableName = "PKG_ACTIVO_FIJO.SP_BIENES_TOMA_INVENTARIO;1";
            dt.TableName = "SP_Vacaciones";
            return dt;
        }
        [WebMethod]
        public DataTable NovedadesPlanilla(string N_CEO, string V_CODUNS, string V_PERIODO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_novedades_paus(N_CEO, V_CODUNS, V_PERIODO, UserName);
            //dt.TableName = "PKG_ACTIVO_FIJO.SP_BIENES_TOMA_INVENTARIO;1";
            dt.TableName = "SP_Novedades_pAus";
            return dt;
        }

        [WebMethod]
        public DataTable MobxFecha(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            DataTable dt = new DataTable("SP_Mob_X_Fecha");
            DataTable dtError = new DataTable("SP_Mob_X_Fecha");
            DateTime fechaIni, fechaFin;
            dtError.TableName = "SP_Mob_X_Fecha";
            dtError.Columns.Add("CENTRO_OPERATIVO", typeof(string));
            dtError.Columns.Add("DES_DET", typeof(string)); // el campo se toma de reporte crystal
            try
            {
                // -----validamos datos Obligatorios ----
                if (N_CEO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["DES_DET"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (string.IsNullOrWhiteSpace(D_FECHAINI))
                {
                    DataRow row = dtError.NewRow();
                    row["DES_DET"] = "La fecha inicial es obligatoria.";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                if (!DateTime.TryParseExact(D_FECHAINI, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaIni))
                {
                    DataRow row = dtError.NewRow();
                    row["PDES_DET"] = "La fecha inicial no tiene un formato válido. Formato correcto: dd/MM/yyyy";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (string.IsNullOrWhiteSpace(D_FECHAFIN))
                {
                    DataRow row = dtError.NewRow();
                    row["DES_DET"] = "La fecha Final es obligatoria.";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                if (!DateTime.TryParseExact(D_FECHAFIN, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaIni))
                {
                    DataRow row = dtError.NewRow();
                    row["DES_DET"] = "La fecha final no tiene un formato válido. Formato correcto: dd/MM/yyyy";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                // ----------------------------------------------------
                dt = oPD.Listar_mob_x_fecha(D_FECHAFIN, D_FECHAINI, N_CEO, UserName);

                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_Mob_X_Fecha";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Mob_X_Fecha";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["PDES_DET"] = "No existen registros para los parámetros consultados: " + N_CEO + " " + D_FECHAINI + " " + D_FECHAFIN;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["DES_DET"] = "No existen registros para los parámetros consultados: " + N_CEO + " " + D_FECHAINI + " " + D_FECHAFIN;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["DES_DET"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    { oPD.Abort(); }
                }
            }

        }

        [WebMethod]
        public DataTable MobxFecha2(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();

            try
            {
                if (string.IsNullOrEmpty(N_CEO) || N_CEO == "-1")
                    throw new Exception("El campo CENTRO_OPERATIVO es obligatorio.");

                String xmlData = oPD.Listar_mob_x_fecha2(D_FECHAFIN, D_FECHAINI, N_CEO, UserName);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                DataTable dt = ds.Tables["SP_Mob_X_Fecha"];


                if (dt == null)
                    throw new Exception("No se devolvieron resultados.");

                dt.TableName = "SP_Mob_X_Fecha";
                return dt;
            }
            catch (Exception ex)
            {
                //  Siempre devuelve un DataTable válido con el mensaje de error
                DataTable errorTable = new DataTable("SP_Mob_X_Fecha");
                errorTable.Columns.Add("CENTRO_OPERATIVO", typeof(bool));
                errorTable.Columns.Add("PROYECTO", typeof(string));
                errorTable.Rows.Add(false, ex.Message);
                return errorTable;
            }
        }

        [WebMethod]
        public DataTable MobxFecha_DesdeJson2(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string UserName)
        {
            DataTable dtError = new DataTable("SP_Mob_X_Fecha");
            dtError.Columns.Add("CENTRO_OPERATIVO", typeof(bool));
            dtError.Columns.Add("PROYECTO", typeof(string));

            ProduccionSoapClient oPD = new ProduccionSoapClient();

            try
            {
                // ----- Validaciones de parámetros -----
                if (string.IsNullOrEmpty(N_CEO) || N_CEO == "-1")
                {
                    dtError.Rows.Add(false, "El campo CENTRO_OPERATIVO es obligatorio.");
                    return dtError;
                }
                if (string.IsNullOrEmpty(D_FECHAINI))
                {
                    dtError.Rows.Add(false, "El campo FECHA INICIAL es obligatorio.");
                    return dtError;
                }
                if (string.IsNullOrEmpty(D_FECHAFIN))
                {
                    dtError.Rows.Add(false, "El campo FECHA FINAL es obligatorio.");
                    return dtError;
                }
                if (string.IsNullOrEmpty(UserName))
                {
                    dtError.Rows.Add(false, "El campo UserName es obligatorio.");
                    return dtError;
                }

                // ----- Llamada directa al servicio JSON vía HTTP -----
                string baseUrl = oPD.Endpoint.Address.Uri.ToString().TrimEnd('/');
                string url = $"{baseUrl}/Listar_mob_x_fecha_json?" +
                             $"D_FECHAFIN={Uri.EscapeDataString(D_FECHAFIN)}&" +
                             $"D_FECHAINI={Uri.EscapeDataString(D_FECHAINI)}&" +
                             $"N_CEO={Uri.EscapeDataString(N_CEO)}&" +
                             $"UserName={Uri.EscapeDataString(UserName)}";

                string jsonData;
                using (var client = new HttpClient())
                {
                    client.Timeout = TimeSpan.FromMinutes(20);
                    var response = client.GetAsync(url).Result;
                    response.EnsureSuccessStatusCode();
                    jsonData = response.Content.ReadAsStringAsync().Result;
                }

                if (string.IsNullOrEmpty(jsonData))
                {
                    dtError.Rows.Add(false, "No se devolvieron resultados del servicio.");
                    return dtError;
                }

                /**** Se añadió: Manejo robusto para XML y SOAP Fault ****/
                if (jsonData.TrimStart().StartsWith("<"))
                {
                    try
                    {
                        var xmlDoc = new System.Xml.XmlDocument();
                        xmlDoc.LoadXml(jsonData);

                        // Buscar si hay un nodo con JSON (ej. <string>...</string>)
                        var jsonNode = xmlDoc.SelectSingleNode("//*[local-name()='string']");
                        if (jsonNode != null && !string.IsNullOrWhiteSpace(jsonNode.InnerText))
                        {
                            jsonData = jsonNode.InnerText.Trim();
                        }
                        else
                        {
                            // Si no hay JSON, buscar error SOAP
                            var faultNode = xmlDoc.SelectSingleNode("//*[local-name()='faultstring']");
                            if (faultNode != null)
                            {
                                dtError.Rows.Add(false, "Error SOAP: " + faultNode.InnerText);
                                return dtError;
                            }

                            // Si no hay nada, devolver error genérico
                            dtError.Rows.Add(false, "El servicio devolvió XML sin contenido JSON válido.");
                            return dtError;
                        }
                    }
                    catch (Exception exXml)
                    {
                        dtError.Rows.Add(false, "Error procesando XML: " + exXml.Message);
                        return dtError;
                    }
                }

                /**** Se añadió: Manejo de error al parsear JSON ****/
                JObject jObj;
                try
                {
                    jObj = JsonConvert.DeserializeObject<JObject>(jsonData);
                }
                catch (Exception exJson)
                {
                    dtError.Rows.Add(false, "Error procesando JSON: " + exJson.Message);
                    return dtError;
                }

                // ----- Validar estructura JSON -----
                if (jObj["success"] == null || !(bool)jObj["success"])
                {
                    string msg = jObj["errorMessage"]?.ToString() ?? "Error desconocido en el servicio JSON.";
                    dtError.Rows.Add(false, msg);
                    return dtError;
                }

                var dataArray = jObj["data"] as JArray;
                if (dataArray == null || dataArray.Count == 0)
                {
                    dtError.Rows.Add(false, "No existen registros para los parámetros consultados: " +
                                            N_CEO + " " + D_FECHAINI + " " + D_FECHAFIN);
                    return dtError;
                }

                // ----- Crear DataTable dinámicamente -----
                DataTable dt = new DataTable("SP_Mob_X_Fecha");
                JObject firstRow = (JObject)dataArray[0];
                foreach (var prop in firstRow.Properties())
                    dt.Columns.Add(prop.Name, typeof(string));

                // ----- Procesar en bloques para controlar memoria -----
                int blockSize = 500;
                int totalBlocks = (int)Math.Ceiling((double)dataArray.Count / blockSize);

                for (int i = 0; i < totalBlocks; i++)
                {
                    long memBefore = GC.GetTotalMemory(true);

                    var block = dataArray.Skip(i * blockSize).Take(blockSize);

                    foreach (JObject row in block)
                    {
                        DataRow dr = dt.NewRow();
                        foreach (var prop in row.Properties())
                        {
                            string value = prop.Value?.ToString() ?? string.Empty;
                            value = value.Replace("\r", "").Replace("\n", "").Replace("\t", " ").Trim();
                            dr[prop.Name] = value;
                        }
                        dt.Rows.Add(dr);
                    }

                    block = null;
                    GC.Collect();
                    GC.WaitForPendingFinalizers();

                    long memAfter = GC.GetTotalMemory(true);
                    Debug.WriteLine($"Bloque {i + 1}/{totalBlocks} procesado. Memoria usada por bloque: {(memAfter - memBefore) / 1024 / 1024} MB");
                }

                return dt;
            }
            catch (Exception ex)
            {
                dtError.Rows.Add(false, "Error en servicio: " + ex.Message);
                return dtError;
            }
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    {
                        oPD.Abort();
                    }
                }
            }
        }


        [WebMethod]
        public DataTable MobxFecha_DesdeJson(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string UserName)
        {

            return MobxFecha_DesdeJsonAsync(D_FECHAFIN, D_FECHAINI, N_CEO, UserName).GetAwaiter().GetResult();
        }

        [WebMethod]
        public async Task<DataTable> MobxFecha_DesdeJsonAsync2(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string UserName)
        {
            DataTable dtError = new DataTable("SP_Mob_X_Fecha");
            dtError.Columns.Add("CENTRO_OPERATIVO", typeof(bool));
            dtError.Columns.Add("PROYECTO", typeof(string));

            ProduccionSoapClient oPD = new ProduccionSoapClient();

            try
            {
                // ----- Validaciones de parámetros -----
                if (string.IsNullOrEmpty(N_CEO) || N_CEO == "-1")
                {
                    dtError.Rows.Add(false, "El campo CENTRO_OPERATIVO es obligatorio.");
                    return dtError;
                }
                if (string.IsNullOrEmpty(D_FECHAINI))
                {
                    dtError.Rows.Add(false, "El campo FECHA INICIAL es obligatorio.");
                    return dtError;
                }
                if (string.IsNullOrEmpty(D_FECHAFIN))
                {
                    dtError.Rows.Add(false, "El campo FECHA FINAL es obligatorio.");
                    return dtError;
                }
                if (string.IsNullOrEmpty(UserName))
                {
                    dtError.Rows.Add(false, "El campo UserName es obligatorio.");
                    return dtError;
                }

                // ----- Llamada al servicio JSON -----
                string baseUrl = oPD.Endpoint.Address.Uri.ToString().TrimEnd('/');
                string url = $"{baseUrl}/Listar_mob_x_fecha_json?" +
                             $"D_FECHAFIN={Uri.EscapeDataString(D_FECHAFIN)}&" +
                             $"D_FECHAINI={Uri.EscapeDataString(D_FECHAINI)}&" +
                             $"N_CEO={Uri.EscapeDataString(N_CEO)}&" +
                             $"UserName={Uri.EscapeDataString(UserName)}";

                string jsonData;

                using (var client = new HttpClient())
                {
                    client.Timeout = TimeSpan.FromMinutes(20);
                    var response = await client.GetAsync(url).ConfigureAwait(false);
                    response.EnsureSuccessStatusCode();
                    jsonData = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                }

                // Si el servicio devuelve XML con JSON dentro, lo limpiamos
                if (jsonData.TrimStart().StartsWith("<?xml"))
                {
                    var xmlDoc = new System.Xml.XmlDocument();
                    xmlDoc.LoadXml(jsonData);
                    jsonData = xmlDoc.InnerText; // Extrae el JSON puro
                }


                if (string.IsNullOrEmpty(jsonData))
                {
                    dtError.Rows.Add(false, "No se devolvieron resultados del servicio.");
                    return dtError;
                }

                // ----- Parsear JSON -----
                var jObj = JsonConvert.DeserializeObject<JObject>(jsonData);

                if (jObj["success"] == null || !(bool)jObj["success"])
                {
                    string msg = jObj["errorMessage"]?.ToString() ?? "Error desconocido en el servicio JSON.";
                    dtError.Rows.Add(false, msg);
                    return dtError;
                }

                var dataArray = jObj["data"] as JArray;
                if (dataArray == null || dataArray.Count == 0)
                {
                    dtError.Rows.Add(false, $"No existen registros para los parámetros consultados: {N_CEO} {D_FECHAINI} {D_FECHAFIN}");
                    return dtError;
                }

                // ----- Crear DataTable dinámicamente -----
                DataTable dt = new DataTable("SP_Mob_X_Fecha");
                JObject firstRow = (JObject)dataArray[0];
                foreach (var prop in firstRow.Properties())
                    dt.Columns.Add(prop.Name, typeof(string));

                // ----- Procesar en bloques asincrónicos -----
                int blockSize = 500;
                int totalBlocks = (int)Math.Ceiling((double)dataArray.Count / blockSize);

                for (int i = 0; i < totalBlocks; i++)
                {
                    var block = dataArray.Skip(i * blockSize).Take(blockSize);

                    await Task.Run(() =>
                    {
                        foreach (JObject row in block)
                        {
                            DataRow dr = dt.NewRow();
                            foreach (var prop in row.Properties())
                            {
                                string value = prop.Value?.ToString() ?? string.Empty;
                                value = value.Replace("\r", "").Replace("\n", "").Replace("\t", " ").Trim();
                                dr[prop.Name] = value;
                            }
                            dt.Rows.Add(dr);
                        }
                    });

                    // Liberar memoria del bloque
                    block = null;
                    GC.Collect();
                    GC.WaitForPendingFinalizers();

                    Debug.WriteLine($"Bloque {i + 1}/{totalBlocks} procesado.");
                }

                return dt;
            }
            catch (Exception ex)
            {
                dtError.Rows.Add(false, "Error en servicio: " + ex.Message);
                return dtError;
            }
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    {
                        oPD.Abort();
                    }
                }
            }
        }

        [WebMethod]
        public async Task<DataTable> MobxFecha_DesdeJsonAsync(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string UserName)
        {
            DataTable dtError = new DataTable("SP_Mob_X_Fecha");
            dtError.Columns.Add("CENTRO_OPERATIVO", typeof(bool));
            dtError.Columns.Add("PROYECTO", typeof(string));

            ProduccionSoapClient oPD = new ProduccionSoapClient();

            try
            {
                // ----- Validaciones -----
                if (string.IsNullOrEmpty(N_CEO) || N_CEO == "-1")
                {
                    dtError.Rows.Add(false, "El campo CENTRO_OPERATIVO es obligatorio.");
                    return dtError;
                }
                if (string.IsNullOrEmpty(D_FECHAINI))
                {
                    dtError.Rows.Add(false, "El campo FECHA INICIAL es obligatorio.");
                    return dtError;
                }
                if (string.IsNullOrEmpty(D_FECHAFIN))
                {
                    dtError.Rows.Add(false, "El campo FECHA FINAL es obligatorio.");
                    return dtError;
                }
                if (string.IsNullOrEmpty(UserName))
                {
                    dtError.Rows.Add(false, "El campo UserName es obligatorio.");
                    return dtError;
                }

                // ----- Llamada al servicio JSON -----
                string baseUrl = oPD.Endpoint.Address.Uri.ToString().TrimEnd('/');
                string url = $"{baseUrl}/Listar_mob_x_fecha_json?" +
                             $"D_FECHAFIN={Uri.EscapeDataString(D_FECHAFIN)}&" +
                             $"D_FECHAINI={Uri.EscapeDataString(D_FECHAINI)}&" +
                             $"N_CEO={Uri.EscapeDataString(N_CEO)}&" +
                             $"UserName={Uri.EscapeDataString(UserName)}";

                string jsonData;
                using (var client = new HttpClient())
                {
                    client.Timeout = TimeSpan.FromMinutes(20);
                    var response = await client.GetAsync(url).ConfigureAwait(false);
                    response.EnsureSuccessStatusCode();
                    jsonData = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                }

                // Si el servicio devuelve XML con JSON dentro, lo limpiamos
                if (jsonData.TrimStart().StartsWith("<?xml"))
                {
                    var xmlDoc = new System.Xml.XmlDocument();
                    xmlDoc.LoadXml(jsonData);
                    jsonData = xmlDoc.InnerText;
                }

                if (string.IsNullOrEmpty(jsonData))
                {
                    dtError.Rows.Add(false, "No se devolvieron resultados del servicio.");
                    return dtError;
                }

                // ----- Calcular tamaño del JSON -----
                long sizeInBytes = System.Text.Encoding.UTF8.GetByteCount(jsonData);
                double sizeInMB = sizeInBytes / (1024.0 * 1024.0);

                var jObj = JsonConvert.DeserializeObject<JObject>(jsonData);
                if (jObj["success"] == null || !(bool)jObj["success"])
                {
                    string msg = jObj["errorMessage"]?.ToString() ?? "Error desconocido en el servicio JSON.";
                    dtError.Rows.Add(false, msg);
                    return dtError;
                }

                var dataArray = jObj["data"] as JArray;
                if (dataArray == null || dataArray.Count == 0)
                {
                    dtError.Rows.Add(false, $"No existen registros para los parámetros consultados: {N_CEO} {D_FECHAINI} {D_FECHAFIN}");
                    return dtError;
                }

                // ----- Leer rutas desde ConfigBase -----
                var configSection = ConfigurationManager.GetSection("ConfigBase") as System.Collections.Hashtable;
                if (configSection == null)
                {
                    dtError.Rows.Add(false, "No se pudo leer la sección ConfigBase del web.config.");
                    return dtError;
                }

                string basePath = configSection["PathFileRpt"]?.ToString();
                string baseHttpPath = configSection["PathFileRptHttp"]?.ToString();

                if (string.IsNullOrEmpty(basePath) || string.IsNullOrEmpty(baseHttpPath))
                {
                    dtError.Rows.Add(false, "Las rutas no están configuradas correctamente en web.config.");
                    return dtError;
                }

                string userFolder = Path.Combine(basePath, UserName);
                if (!Directory.Exists(userFolder))
                    Directory.CreateDirectory(userFolder);

                // ----- Si el tamaño es mayor a 30 MB -----
                if (sizeInMB > 30)
                {
                    string csvFileName = $"MobxFecha_{DateTime.Now:yyyyMMddHHmmss}.csv";
                    string csvPath = Path.Combine(userFolder, csvFileName);
                    string csvUrl = $"{baseHttpPath}{UserName}/{csvFileName}";

                    using (var writer = new StreamWriter(csvPath, false, System.Text.Encoding.UTF8))
                    {
                        var firstRow = (JObject)dataArray[0];
                        var headers = string.Join(",", firstRow.Properties().Select(p => p.Name));
                        await writer.WriteLineAsync(headers);

                        foreach (JObject row in dataArray)
                        {
                            var values = row.Properties().Select(p =>
                                (p.Value?.ToString() ?? "").Replace(",", " ").Replace("\r", "").Replace("\n", ""));
                            await writer.WriteLineAsync(string.Join(",", values));
                        }
                    }

                    // Crear DataTable config
                    DataTable dtConfig = new DataTable("config");
                    dtConfig.Columns.Add("ModoCarga", typeof(string));
                    dtConfig.Columns.Add("RutaArchivo", typeof(string));
                    dtConfig.Columns.Add("UrlArchivo", typeof(string));
                    dtConfig.Rows.Add("CSV", csvPath, csvUrl);

                    return dtConfig;
                }

                // ----- Si el tamaño es menor, procesar normalmente -----
                DataTable dt = new DataTable("SP_Mob_X_Fecha");
                JObject firstRowObj = (JObject)dataArray[0];
                foreach (var prop in firstRowObj.Properties())
                    dt.Columns.Add(prop.Name, typeof(string));

                int blockSize = 500;
                int totalBlocks = (int)Math.Ceiling((double)dataArray.Count / blockSize);

                for (int i = 0; i < totalBlocks; i++)
                {
                    var block = dataArray.Skip(i * blockSize).Take(blockSize);
                    await Task.Run(() =>
                    {
                        foreach (JObject row in block)
                        {
                            DataRow dr = dt.NewRow();
                            foreach (var prop in row.Properties())
                            {
                                string value = prop.Value?.ToString() ?? string.Empty;
                                value = value.Replace("\r", "").Replace("\n", "").Replace("\t", " ").Trim();
                                dr[prop.Name] = value;
                            }
                            dt.Rows.Add(dr);
                        }
                    });

                    block = null;
                    GC.Collect();
                }

                return dt;
            }
            catch (Exception ex)
            {
                dtError.Rows.Add(false, "Error en servicio: " + ex.Message);
                return dtError;
            }
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    {
                        oPD.Abort();
                    }
                }
            }
        }

        [WebMethod]
        public DataTable Listar_mob_x_fecha_xProy2(string N_CEO, string V_PROYECTO, string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();

            try
            {
                if (string.IsNullOrEmpty(N_CEO) || N_CEO == "-1")
                    throw new Exception("El parámetro CENTRO_OPERATIVO es obligatorio.");
                if (string.IsNullOrEmpty(V_PROYECTO) || V_PROYECTO == "-1")
                    throw new Exception("El parámetro Proyecto es obligatorio. Debe buscar y seleccionar.");

                String xmlData = oPD.Listar_mob_x_fecha_xProy2(N_CEO, V_PROYECTO, D_FECHAINI, D_FECHAFIN, UserName);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                DataTable dt = ds.Tables["SP_Mob_X_Fecha_X_Proy"];


                if (dt == null)
                    throw new Exception("No se devolvieron resultados.");

                dt.TableName = "SP_Mob_X_Fecha_X_Proy";
                return dt;
            }
            catch (Exception ex)
            {
                //  Siempre devuelve un DataTable válido con el mensaje de error
                DataTable errorTable = new DataTable("SP_Mob_X_Fecha_X_Proy");
                errorTable.Columns.Add("CENTRO_OPERATIVO", typeof(bool));
                errorTable.Columns.Add("PROYECTO", typeof(string));
                errorTable.Rows.Add(false, ex.Message);
                return errorTable;
            }
        }

        //SP_Lista_Saldo_MO
        [WebMethod]
        public DataTable ListaSaldoMo(string N_CEO, string V_CATVCRV, string V_CODDIV, string V_CODPROY, string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_lista_saldo_mo(N_CEO, V_CATVCRV, V_CODDIV, V_CODPROY, V_NROOTS, UserName);
            //dt.TableName = "PKG_ACTIVO_FIJO.SP_BIENES_TOMA_INVENTARIO;1";
            dt.TableName = "SP_Lista_Saldo_MO";
            return dt;
        }
        //*******************
        [WebMethod]
        public DataTable Listar_Lista_mob_pago(string V_rol, string V_tiphex, string V_CentroCostoDesde, string V_CentroCostoHasta, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_Lista_mob_pago(V_rol, V_tiphex, V_CentroCostoDesde, V_CentroCostoHasta, UserName);
            dt.TableName = "SP_Lista_mob_pago";
            return dt;
        }
        //------ metodo con cadena xml -----------------
        [WebMethod(Description = "2.Lista_mob_pago. UTILIZACION DE MOB EN TALLERES vers2")]
        public DataTable Listar_Lista_mob_pago2(string V_rol, string V_tiphex, string V_CentroCostoDesde, string V_CentroCostoHasta, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            DataTable dtError = new DataTable("SP_Lista_mob_pago");

            // Configura estructura tabla de error // Los campos se toman de las etiquetas de reporte crystal
            dtError.TableName = "SP_Lista_mob_pago";
            dtError.Columns.Add("ROL", typeof(string));
            dtError.Columns.Add("CentroCostos", typeof(string));
            try
            {

                if (V_tiphex == "-1")
            { V_tiphex = ""; }


            string xmlData = oPD.Listar_Lista_mob_pago2(V_rol, V_tiphex, V_CentroCostoDesde, V_CentroCostoHasta, UserName);


            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

                if (ds!= null)
                { 
                     // Extraer el DataTable del DataSet
                      dt = ds.Tables["SP_Lista_mob_pago"];
                }
                //  return dt;
                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_Lista_mob_pago";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Lista_mob_pago";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["CentroCostos"] = "No existen registros para los parámetros consultados: " + V_rol + " " + V_CentroCostoDesde + V_CentroCostoHasta + " " + V_tiphex;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["CentroCostos"] = "No existen registros para los parámetros consultados: " + V_rol + " " + V_CentroCostoDesde + V_CentroCostoHasta + " " + V_tiphex;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["CentroCostos"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    { oPD.Abort(); }
                }
            }
        }

        //*******************
        [WebMethod]
        public DataTable Listar_Res_Lista_mob_pago(string V_tiphex, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            DataTable dtError = new DataTable("SP_Res_Lista_mob_pago");
           
            // Configura estructura tabla de error // Los campos se toman de las etiquetas de reporte crystal
            dtError.TableName = "SP_Res_Lista_mob_pago";
            //dtError.Columns.Add("COD_PRY", typeof(string));
            dtError.Columns.Add("ULTIMO_MES_CIERRE", typeof(string));
            try
            {
                // -----validamos datos Obligatorios ----
                if (V_tiphex == "-1")
                {
                    V_tiphex = "";
                }

                
                dt = oPD.Listar_Res_Lista_mob_pago(V_tiphex, UserName);
                //dt.TableName = "SP_Res_Lista_mob_pago";
                // return dt;
                if (dt != null)  // valida vacio
                {
                    
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Res_Lista_mob_pago";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["ULTIMO_MES_CIERRE"] = "No existen registros para los parámetros consultados: " + V_tiphex;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["ULTIMO_MES_CIERRE"] = "No existen registros para los parámetros consultados: " + V_tiphex;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["ULTIMO_MES_CIERRE"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    { oPD.Abort(); }
                }
            }
        }

        [WebMethod]
        public DataTable Listar_mob(string D_AÑO, string D_MESINI, string D_MESFIN, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            DataTable dtError = new DataTable("SP_mob");
    
            // Configura estructura tabla de error // Los campos se toman de las etiquetas de reporte crystal / /4_MOB.rpt
            dtError.TableName = "SP_mob";
            dtError.Columns.Add("NOMBRE TRABAJADOR", typeof(string));
            try
            {

                // -----validamos datos Obligatorios ----
                if (D_AÑO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Debe ingressr el año, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (D_MESINI=="" || D_MESINI == "-1")
                {
                    D_MESINI = "01";
                }
                if (D_MESFIN == "" || D_MESFIN == "-1")
                {
                    D_MESFIN = DateTime.Now.Month.ToString("00"); 
                }

                dt = oPD.Listar_mob(D_AÑO, D_MESINI, D_MESFIN, UserName);
            //dt.TableName = "SP_mob";
               
                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_mob";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_mob";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["NOMBRE TRABAJADOR"] = "No existen registros para los parámetros consultados: " + D_AÑO + " " + D_MESINI  + " " + D_MESFIN;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["NOMBRE TRABAJADOR"] = "No existen registros para los parámetros consultados: " + D_AÑO + " " + D_MESINI  + " " + D_MESFIN;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["NOMBRE TRABAJADOR"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    { oPD.Abort(); }
                }
            }
        }

        [WebMethod]
        public DataTable Listar_MobXFechaOt(string v_Centro_Operativo, string v_Division, string v_OT, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();



            DataTable dtError = new DataTable("SP_MobXFechaOt");

            dtError.TableName = "SP_MobXFechaOt";
            dtError.Columns.Add("COD_DIV", typeof(string));
            dtError.Columns.Add("PROYECTO", typeof(string)); // el campo se toma de reporte crystal
            try
            {
                // -----validamos datos Obligatorios ----
                if (v_Centro_Operativo == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["PROYECTO"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (v_OT == "-1" || v_OT == "")
                {
                    DataRow row = dtError.NewRow();
                    row["PROYECTO"] = "Seleccione una OT , es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (v_Division == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["DPROYECTO"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                // ----------------------------------------------------
                dt = oPD.Listar_MobXFechaOt(v_Centro_Operativo, v_Division, v_OT, UserName);


                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_MobXFechaOt";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_MobXFechaOt";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["PROYECTO"] = "No existen registros para los parámetros consultados: " + v_Centro_Operativo + " " + v_Division + v_OT;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["PROYECTO"] = "No existen registros para los parámetros consultados: " + v_Centro_Operativo + " " + v_Division + v_OT;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["DPROYECTO"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    { oPD.Abort(); }
                }
            }



        }
        [WebMethod]
        public DataTable Listar_detalle_mob(string V_CO, string V_DIVISION, string V_OT, string d_fechaini, string d_fecha_fin, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            DataTable dtError = new DataTable("SP_detalle_mob");
            DateTime fechaIni, fechaFin;
            // Configura estructura tabla de error // Los campos se toman de las etiquetas de reporte crystal
            dtError.TableName = "SP_detalle_mob";
            //dtError.Columns.Add("COD_RCS", typeof(string));
            dtError.Columns.Add("ATV", typeof(string));
            try
            {
                // -----validamos datos Obligatorios ----
                if (V_CO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["ATV"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_DIVISION == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["ATV"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (string.IsNullOrWhiteSpace(d_fechaini))
                {
                    DataRow row = dtError.NewRow();
                    row["ATV"] = "La fecha inicial es obligatoria.";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (!DateTime.TryParseExact(d_fechaini, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaIni))
                {
                    DataRow row = dtError.NewRow();
                    row["ATV"] = "La fecha inicial no tiene un formato válido. Formato correcto: dd/MM/yyyy";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (string.IsNullOrWhiteSpace(d_fecha_fin))
                {
                    DataRow row = dtError.NewRow();
                    row["ATV"] = "La fecha inicial es obligatoria.";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (!DateTime.TryParseExact(d_fecha_fin, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaIni))
                {
                    DataRow row = dtError.NewRow();
                    row["ATV"] = "La fecha Final no tiene un formato válido. Formato correcto: dd/MM/yyyy";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                dt = oPD.Listar_detalle_mob(V_CO, V_DIVISION, V_OT, d_fechaini, d_fecha_fin, UserName);
                // dt.TableName = "SP_detalle_mob";
                // return dt;
                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_detalle_mob";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_detalle_mob";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["ATV"] = "No existen registros para los parámetros consultados: " + V_CO + " " + V_DIVISION + " " + d_fechaini + " " + d_fecha_fin;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["ATV"] = "No existen registros para los parámetros consultados: " + V_CO + " " + V_DIVISION + " " + d_fechaini + " " + d_fecha_fin;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["ATV"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    { oPD.Abort(); }
                }
            }
        }

        [WebMethod]
        public DataTable Listar_DETALLE_GASTO_PRY_OT_MOBSU(string N_CEO, string V_CODDIV, string V_CODPRY,
            string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_DETALLE_GASTO_PRY_OT_MOBSU(N_CEO, V_CODDIV, V_CODPRY, D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_DETALLE_GASTO_PRY_OT_MOBSU";
            return dt;
        }
    }
}
