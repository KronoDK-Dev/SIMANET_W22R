using Aspose.Cells;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using ClosedXML.Excel;
using OfficeOpenXml;
using OfficeOpenXml.Table;
using SIMANET_W22R.Controles;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.WebRequestMethods;
//*********************
/*
Session["objRpt"] = oEasyDataInterConect; EasyDataInterConect oEasyDataInterConect = (EasyDataInterConect)Session["objRpt"] ;
Session["DataXLS"] = ds;        DataSet ds = (DataSet)Session["DataXLS"];
*/
//******************

namespace SIMANET_W22R.GestionReportes
{
    public partial class ReportExploreV2 : ReporteBase, IPaginaBase
    {
        string s_Corregidos;
        string s_pto;
        public string[,] StyleBase
        {
            //         { "dos","https://www.jqueryscript.net/demo/Powerful-Multi-Functional-jQuery-Folder-Tree-Plugin-zTree/css/zTreeStyle/zTreeStyle.css" }
            get
            {
                return new string[1, 2]{
                                            /*{"uno","https://www.jqueryscript.net/demo/Powerful-Multi-Functional-jQuery-Folder-Tree-Plugin-zTree/css/demo.cssz" }*/
                                            { "cssTree", EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/zTreeStyle.css" }
                                            /*,{ "tres","https://davidsekar.github.io/jQuery-UI-ScrollTabs/css/style.cssz"}*/
                                        };

            }
        }

        public string[,] ScriptBase
        {
            //{ "cuatro", "https://www.jqueryscript.net/demo/Powerful-Multi-Functional-jQuery-Folder-Tree-Plugin-zTree/js/jquery.ztree.core-3.5.js"}
            get
            {
                return new string[2, 2]{
                                         { "jsTree",  EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.core.js"}
                                        /* { "jsTree",  EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.core-3.5.js"}*/
                                         ,{ "jsTree2",  EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.exedit.js"}
                                       };

            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Header.RegistrarLibs(Page.Header, Header.TipoLib.Style, this.StyleBase, true);
                Header.RegistrarLibs(Page.Header, Header.TipoLib.Script, this.ScriptBase, true);
                LlenarJScript();
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }
        }
        #region MetodosGenerales

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void LlenarCombos()
        {
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            this.ibtn.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconConfig.ToString();
        }

        public void RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        public bool ValidarDatos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }

        #endregion


        // exportar a excel ibtn

        protected void prExportarExcel(object sender, ImageClickEventArgs e)
        {
            string pathReporte = hdnPathRpt.Value?.Trim();
            string fileName = null;
            string filePath = null;

            try
            {
                if (!string.IsNullOrEmpty(pathReporte))
                {
                    // 🔹 1. Limpiar caracteres no imprimibles y espacios extra
                    pathReporte = System.Text.RegularExpressions.Regex.Replace(pathReporte, @"[^\u0020-\u007E]", "").Trim();

                    // 🔹 2. Obtener nombre seguro del archivo (sin caracteres invisibles)
                    fileName = Path.GetFileNameWithoutExtension(pathReporte);
                    fileName = System.Text.RegularExpressions.Regex.Replace(fileName ?? "", @"[^\u0020-\u007E]", "").Trim() + ".xlsx";

                    // 🔹 3. Convertir URL a ruta física
                    filePath = ConvertirUrlARutaFisica(pathReporte, ".xlsx");

                    // 🔹 4. Limpiar la ruta física final por si quedan caracteres extraños
                    filePath = System.Text.RegularExpressions.Regex.Replace(filePath ?? "", @"[^\u0020-\u007E]", "").Trim();
                }

                // 🔹 5. Si hay sesión con archivo generado previamente
                if (Session["archivoDescarga"] != null && !string.IsNullOrWhiteSpace(Session["archivoDescarga"].ToString()))
                {
                    filePath = Session["archivoDescarga"].ToString();
                    filePath = System.Text.RegularExpressions.Regex.Replace(filePath ?? "", @"[^\u0020-\u007E]", "").Trim();

                    fileName = Session["NombreArchivo"]?.ToString() ?? "archivo.xlsx";
                    fileName = System.Text.RegularExpressions.Regex.Replace(fileName ?? "", @"[^\u0020-\u007E]", "").Trim();
                }

                // 🔹 6. Validar existencia del archivo
                if (!string.IsNullOrEmpty(filePath) && System.IO.File.Exists(filePath))
                {
                    Response.Clear();
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("Content-Disposition", $"attachment; filename=\"{fileName}\"");
                    Response.TransmitFile(filePath);
                    Response.Flush();
                    Response.SuppressContent = true; // evita errores de Response.End()
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    // el nombre del archivo quizas no sea el correcto, probaremos con la variable de la session

                    if (!string.IsNullOrEmpty(filePath) && System.IO.File.Exists(fileName))
                    {
                        Response.Clear();
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("Content-Disposition", $"attachment; filename=\"{fileName}\"");
                        Response.TransmitFile(filePath);
                        Response.Flush();
                        Response.SuppressContent = true; // evita errores de Response.End()
                        HttpContext.Current.ApplicationInstance.CompleteRequest();
                    }
                    else
                    {
                        // ahora el nombre del archivo si existe pero al buscarlo no existe la ruta completa, asi que completariamos en duro la ruta

                        if (string.IsNullOrEmpty(filePath) && !System.IO.File.Exists(fileName) && !string.IsNullOrEmpty(fileName))
                        {
                            // armamos la ruta y validamos
                            string usuario = Session["Login"].ToString();  // HttpContext.Current.User.Identity.Name;
                            filePath = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRpt") + usuario + "\\" + fileName;
                            //--- validamos

                            Response.Clear();
                            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                            Response.AddHeader("Content-Disposition", $"attachment; filename=\"{fileName}\"");
                            Response.TransmitFile(filePath);
                            Response.Flush();
                            Response.SuppressContent = true; // evita errores de Response.End()
                            HttpContext.Current.ApplicationInstance.CompleteRequest();

                        }
                        else
                        {
                            string mensaje = $"Archivo no encontrado (prExportarExcel): {filePath} | URL original: {pathReporte}";
                            MostrarSweetAlert("Archivo no encontrado", mensaje, "warning");
                        }
                    }
                }

                ClientScript.RegisterStartupScript(this.GetType(), "logRuta",
                        $"console.log('Archivo generado: {filePath}');", true);
            }
            catch (Exception ex)
            {
                s_pto = ex.Message + " " + filePath;
                MostrarSweetAlert("Error:", s_pto, "warning");
                ClientScript.RegisterStartupScript(this.GetType(), "logRuta",
                        $"console.log('Archivo generado: {filePath}');", true);


            }
        }



        /// <summary>
        /// Convierte una URL (ej: https://.../SIMANET_W22R/Archivos/HomeRptGen/file.pdf)
        /// a la ruta física en el servidor, cambiando extensión si es necesario.
        /// </summary>

        private string ConvertirUrlARutaFisica(string url, string nuevaExtension = null)
        {
            try
            {
                // ✅ 1. Limpiar caracteres invisibles desde el inicio
                url = System.Text.RegularExpressions.Regex.Replace(url, @"[^\u0020-\u007E]", "").Trim();

                string relativeFromArchivos = "";

                // ✅ 2. Caso especial: debug local (URL contiene localhost o 127.0.0.1)
                if (!string.IsNullOrEmpty(url) && (url.Contains("localhost") || url.Contains("127.0.0.1")))
                {
                    int idx = url.IndexOf("/Archivos/", StringComparison.OrdinalIgnoreCase);
                    if (idx >= 0)
                    {
                        relativeFromArchivos = url.Substring(idx + "/Archivos/".Length);
                    }
                    else
                    {
                        throw new Exception("No se encontró la carpeta /Archivos/ en la URL local: " + url);
                    }
                }
                else if (Uri.IsWellFormedUriString(url, UriKind.Absolute))
                {
                    // ✅ 3. Procesar como URL absoluta
                    Uri uri = new Uri(url);
                    string absPath = uri.AbsolutePath;

                    int idx = absPath.IndexOf("/Archivos/", StringComparison.OrdinalIgnoreCase);
                    if (idx >= 0)
                    {
                        relativeFromArchivos = absPath.Substring(idx + "/Archivos/".Length);
                    }
                    else
                    {
                        throw new Exception("No se encontró la carpeta /Archivos/ en la URL: " + url);
                    }
                }
                else
                {
                    // ✅ 4. Caso: ya es una ruta relativa desde Archivos
                    relativeFromArchivos = url;
                    if (relativeFromArchivos.StartsWith("/Archivos/", StringComparison.OrdinalIgnoreCase))
                    {
                        relativeFromArchivos = relativeFromArchivos.Substring("/Archivos/".Length);
                    }
                }

                // ✅ 5. Normalizar separadores y limpiar caracteres invisibles otra vez
                relativeFromArchivos = System.Text.RegularExpressions.Regex.Replace(relativeFromArchivos, @"[^\u0020-\u007E]", "");
                relativeFromArchivos = relativeFromArchivos.Replace("\\", "/").Replace("//", "/").Trim();

                // ✅ 6. Eliminar querystring
                int q = relativeFromArchivos.IndexOf('?');
                if (q >= 0) relativeFromArchivos = relativeFromArchivos.Substring(0, q);

                // ✅ 7. Cambiar extensión si se indica
                if (!string.IsNullOrEmpty(nuevaExtension))
                {
                    int punto = relativeFromArchivos.LastIndexOf('.');
                    if (punto > 0)
                        relativeFromArchivos = relativeFromArchivos.Substring(0, punto) + nuevaExtension;
                }

                // ✅ 8. Obtener ruta base desde configuración
                string rutaBase = ConfigurationManager.AppSettings["RutaBaseReportes"];
                if (string.IsNullOrEmpty(rutaBase))
                    throw new Exception("No se encontró la clave 'RutaBaseReportes' en web.config.");

                // Normalizar ruta base
                rutaBase = rutaBase.TrimEnd('\\').TrimEnd('/') + "\\";

                // ✅ 9. Combinar usando Path.Combine (seguro)
                string physicalPath = Path.Combine(rutaBase, relativeFromArchivos.Replace("/", "\\"));

                // ✅ 10. Limpieza final (por si queda algo raro)
                physicalPath = System.Text.RegularExpressions.Regex.Replace(physicalPath, @"[^\u0020-\u007E]", "");

                // ✅ 11. Logs para depuración
                System.Diagnostics.Debug.WriteLine($"[DEBUG] URL original: {url}");
                System.Diagnostics.Debug.WriteLine($"[DEBUG] relativeFromArchivos limpio: '{relativeFromArchivos}'");
                System.Diagnostics.Debug.WriteLine($"[DEBUG] physicalPath final: '{physicalPath}'");

                return physicalPath;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[ConvertirUrlARutaFisica ERROR] {ex.Message} | URL: {url}");
                return null;
            }
        }






        protected void prExportarExcelDT(object sender, ImageClickEventArgs e)
        {
            EasyDataInterConect oEasyDataInterConect = (EasyDataInterConect)Session["objRpt"];
            string UrlApp = EasyUtilitario.Helper.Pagina.PathSite();// (string)Session["UrlApp"] ;
            object objResult;
            if (oEasyDataInterConect != null)
            {
                // traemos la data,
                // 05.05.2025 usamos el servicio con tiempo ampliado InvokeWebService2
                // debemos retulizar el proceso ya realizado para ahorar tiempo
                // Session["o_objResult"] variable de session llenada en la pantalla GenerarPDF.aspx metodo: ProcessRequest


                if (Session["o_objResult"] != null)
                {
                    // Ya existe un objeto en sesión
                    objResult = Session["o_objResult"];
                }
                else
                {
                    objResult = EasyWebServieHelper.InvokeWebService2(UrlApp, oEasyDataInterConect);
                    Session["o_objResult"] = objResult; // para la siguiente exportacion
                }


                DataSet ds = new DataSet();

                if (objResult is DataSet dataset)
                {
                    ds = dataset;
                }
                else if (objResult is DataTable datatable)
                {
                    ds.Tables.Add(datatable.Copy());
                }
                else
                {
                    // Error: tipo inesperado
                    throw new InvalidCastException("El resultado no es un DataSet ni un DataTable.");
                }

                ExportDataTableToExcel(ds);
            }
            else
            {
                if (Session["DataXLS"] != null)
                {
                    DataSet ds = (DataSet)Session["DataXLS"];
                    ExportDataTableToExcel(ds);
                }


            }
        }
        private void MostrarSweetAlert(string titulo, string mensaje, string icono)
        {
            string script = $"Swal.fire('{titulo}', '{mensaje}', '{icono}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "alerta", script, true);
        }

        public static bool EsFechaValidaParaExcel(string fechaStr, out DateTime fechaValida)
        {
            // Intentar convertir la cadena a DateTime
            if (DateTime.TryParse(fechaStr, out fechaValida))
            {
                DateTime fechaMinima = new DateTime(1900, 1, 1);
                DateTime fechaMaxima = new DateTime(9999, 12, 31);
                return fechaValida >= fechaMinima && fechaValida <= fechaMaxima;
            }
            return false; // Si no se puede convertir, la fecha no es válida
        }
        public void ExportDataTableToExcel1(DataSet ds)
        {
            try
            {
                int iHojas = 0;
                iHojas = ds.Tables.Count;
                var vHoja = "Datos_Sima";
                s_pto = "0";
                DataTable my_dataTable = new DataTable();
                if (iHojas == 1)
                {
                    my_dataTable = ds.Tables[0];
                }

                s_pto = "0.1";
                Console.WriteLine(System.Drawing.Graphics.FromHwnd(IntPtr.Zero).DpiX);
                System.Diagnostics.Debug.WriteLine("DPI: " + System.Drawing.Graphics.FromHwnd(IntPtr.Zero).DpiX);
                using (var workbook = new XLWorkbook())
                {
                    // Capturar la fecha actual del sistema
                    DateTime dfecha = DateTime.Now;
                    int itotal;
                    string sfecha = dfecha.ToString().Replace("/", "_").Replace(":", "-");
                    s_pto = "0.2";
                    // Suponiendo que ya tienes un DataTable llamado dt con los datos cargados
                    DataTable dt = (new GeneralSoapClient()).Lista_ColumnasExcel(my_dataTable.TableName);

                    if (iHojas == 1)
                    {

                        if (!string.IsNullOrEmpty(my_dataTable.TableName)) // el nombre se coloca en el metodo del servicio que trae la data, en caso se coloque se pobdrá por defecto "table"
                        {
                            s_pto = "1";
                            itotal = my_dataTable.TableName.Length;
                            if (itotal < 30)
                            {
                                vHoja = my_dataTable.TableName.Substring(0, itotal);
                            }

                            // Limitar el nombre a 30 caracteres
                            vHoja = vHoja.Length > 30 ? vHoja.Substring(0, 30) : vHoja;
                        }

                        var worksheet = workbook.Worksheets.Add(vHoja);

                        if (dt != null && dt.Rows.Count != 0)
                        {
                            // 27.02.2025 limpieza de datos anter de enviar al excel, esto por error en campos de tipo fecha, colocar los nombre de campos que dan error o corregir el espacio en el SP
                            // List<string> columnasFecha = new List<string> { "FEC_ADQ", "FEC_ACT", "FEC_ULT_INV", "FEC_CREACION", "FEC_MODIFICACION" };
                            s_pto = "2";
                            List<string> columnasFecha = new List<string>();
                            foreach (DataRow row in dt.Rows)
                            {
                                s_pto = "3";
                                if (row["COLUMNAFECHA"] != DBNull.Value)
                                {
                                    string columna_fecha = row["COLUMNAFECHA"].ToString();
                                    columnasFecha.Add(columna_fecha);
                                }
                            }
                            //25.03.2025 S. Hilario. Al generar el excel estas columnas se generan como  "Numero almacenado como texto" . El usuario quiere que las columnas sean numericas

                            //List<(int, string)> columnasNumericas = new List<(int, string)> { (19, "TOTAL_ESTIMADO"), (27, "FACTURADO"),(34, "TOTAL_A_FACTURAR") };
                            List<(int, string)> columnasNumericas = new List<(int, string)>();
                            foreach (DataRow row in dt.Rows)
                            {
                                s_pto = "4";
                                if (row["POSICION_N"] != DBNull.Value && row["COLUMNANUMERO"] != DBNull.Value)
                                {
                                    int posicionN = Convert.ToInt32(row["POSICION_N"]);
                                    string columnaNumero = row["COLUMNANUMERO"].ToString();
                                    columnasNumericas.Add((posicionN, columnaNumero));
                                }
                            }


                            Dictionary<int, List<int>> filasCorregidas = new Dictionary<int, List<int>>(); // Fila -> Lista de columnas corregidas
                            DataTable my_dataTableDepurado = my_dataTable.Copy(); // Crear copia para depuración


                            //Agregamos nuevas columnas al DataTable ,ya que en estas columnas guardaremos los valores en formato numerico
                            for (int colIndex = 0; colIndex < columnasNumericas.Count; colIndex++)
                            {
                                string col = columnasNumericas[colIndex].Item2;
                                s_pto = "5";
                                if (my_dataTable.Columns.Contains(col))
                                {
                                    string nuevaColumna = col + "decimal";
                                    my_dataTableDepurado.Columns.Add(nuevaColumna, typeof(decimal));
                                }
                            }


                            int filaIndex = 1; // Contador de filas (asumiendo que empieza en 1)
                            foreach (DataRow row in my_dataTableDepurado.Rows)
                            {
                                List<int> columnasModificadas = new List<int>(); // Lista para almacenar las columnas corregidas en esta fila
                                s_pto = "6";
                                for (int colIndex = 0; colIndex < columnasFecha.Count; colIndex++)
                                {
                                    string col = columnasFecha[colIndex];

                                    if (my_dataTable.Columns.Contains(col)) // Verificar si la columna existe en la tabla
                                    {
                                        var fechaValor = row[col]?.ToString().Trim(); // Obtener el valor como string

                                        if (string.IsNullOrWhiteSpace(fechaValor))
                                        {
                                            row[col] = new DateTime(1900, 1, 1); // Asignar 01/01/1900 para evitar errores en Excel
                                            columnasModificadas.Add(colIndex + 1); // Guardar el índice relativo de la columna
                                        }
                                        else
                                        {
                                            DateTime fecha;
                                            if (!DateTime.TryParse(fechaValor, out fecha) || !EsFechaValidaParaExcel(fechaValor, out DateTime fech))
                                            {
                                                row[col] = new DateTime(1900, 1, 1); // Si no es una fecha válida, asignar 01/01/1900
                                                columnasModificadas.Add(colIndex + 1);
                                            }
                                            else
                                            {
                                                row[col] = fecha; // Convertir correctamente a DateTime
                                            }
                                        }
                                    }
                                }

                                for (int colIndex = 0; colIndex < columnasNumericas.Count; colIndex++)
                                {
                                    string col = columnasNumericas[colIndex].Item2;
                                    s_pto = "7";
                                    if (my_dataTable.Columns.Contains(col)) // Verificar si la columna existe en la tabla
                                    {
                                        var textoValor = row[col]?.ToString().Trim(); // Obtener el texto como string

                                        if (string.IsNullOrWhiteSpace(textoValor))
                                        {
                                            row[col + "decimal"] = 0;
                                            columnasModificadas.Add(colIndex + 1); // Guardar el índice relativo de la columna
                                        }
                                        else
                                        {
                                            row[col + "decimal"] = Convert.ToDecimal(textoValor);
                                            columnasModificadas.Add(colIndex + 1);
                                        }
                                    }
                                }


                                if (columnasModificadas.Count > 0)
                                {
                                    s_pto = "8";
                                    filasCorregidas[filaIndex] = columnasModificadas; // Guardar la lista de columnas corregidas para esta fila
                                }

                                filaIndex++; // Incrementar el número de fila
                            }


                            for (int colIndex = 0; colIndex < columnasNumericas.Count; colIndex++)
                            {
                                string col = columnasNumericas[colIndex].Item2;
                                s_pto = "9";
                                if (my_dataTable.Columns.Contains(col))
                                {
                                    // Ahora eliminamos la columna original
                                    s_pto = "9.1";
                                    my_dataTableDepurado.Columns.Remove(col);

                                    // Finalmente, cambia el nombre de la nueva columna a col
                                    s_pto = "9.2";
                                    my_dataTableDepurado.Columns[col + "decimal"].ColumnName = col;
                                    //Cambiamos la posicion de la nueva columna en el DataTable
                                    s_pto = "9.3";
                                    my_dataTableDepurado.Columns[col].SetOrdinal(columnasNumericas[colIndex].Item1);
                                }
                            }

                            // Convertir el diccionario en el formato "1(3)(4), 4(1), 5(2)"
                            s_pto = "10";
                            s_Corregidos = string.Join(", ", filasCorregidas.Select(kvp => $"{kvp.Key}{string.Concat(kvp.Value.Select(v => $"({v})"))}"));
                            s_pto = "10.1";
                            if (!string.IsNullOrEmpty(s_Corregidos))
                            {
                                s_pto = "10.2";
                                s_Corregidos = "Fallo el SP: " + my_dataTable.TableName.ToString() + " " + s_Corregidos;
                            }
                            my_dataTableDepurado.AcceptChanges();

                            // Pasar solo el DataTable depurado a Excel
                            worksheet.Cell(1, 1).InsertTable(my_dataTableDepurado);
                        }
                        else
                        {
                            s_pto = "11";
                            worksheet.Cell(1, 1).InsertTable(my_dataTable);
                        }

                    }
                    else // para varias tablas
                    {
                        for (int i = 1; i <= iHojas; i++)
                        {
                            var worksheet = workbook.Worksheets.Add(vHoja + iHojas);
                            s_pto = "12";
                            worksheet.Cell(1, 1).InsertTable(ds.Tables[i - 1]);
                            // Aplicar formato a las celdas numéricas
                            FormatNumericCells(worksheet);
                        }

                    }


                    // Configuración del Response para descargar el archivo
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=RpExcel_" + sfecha + ".xlsx");
                    using (var memoryStream = new System.IO.MemoryStream())
                    {
                        workbook.SaveAs(memoryStream);
                        memoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        try
                        {
                            Response.End();
                        }
                        catch
                        {
                            HttpContext.Current.ApplicationInstance.CompleteRequest(); // ✅ Alternativa segura
                        }


                    }
                }

            }
            catch (Exception ex)
            {
                if (ex.Message != "Subproceso anulado.")
                {
                    var result = "" + ex.Message + " " + s_Corregidos;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                    result = result.Replace("'", "");
                    string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                    string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name + " pto=" + s_pto;
                    this.LanzarException(methodName, ex); // error para el log
                    Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                    string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
                    /// retornamos el error
                    ///  // Crear una tabla para almacenar el error
                    DataTable dtError = new DataTable("Error");
                    dtError.Columns.Add("Mensaje", typeof(string));
                    dtError.Columns.Add("StackTrace", typeof(string));

                    DataRow filaError = dtError.NewRow();
                    filaError["Mensaje"] = ex.Message;
                    filaError["StackTrace"] = ex.StackTrace;
                    dtError.Rows.Add(filaError);

                    // Agregar la tabla de error al DataSet
                    ds.Tables.Add(dtError);

                }
            }
        }


        /* using OfficeOpenXml;
        using OfficeOpenXml.Table;
        using System.IO;
        using System.Linq;
        EPPlus 4.5.3.2  OfficeOpenXml
         */


        public void ExportDataTableToExcel(DataSet ds)
        {
            try
            {
                int iHojas = ds.Tables.Count;
                string vHoja = "Datos_Sima";
                s_pto = "0";

                DataTable my_dataTable = iHojas == 1 ? ds.Tables[0] : new DataTable();
                s_pto = "0.1";

                using (var package = new ExcelPackage())
                {
                    DateTime dfecha = DateTime.Now;
                    string sfecha = dfecha.ToString().Replace("/", "_").Replace(":", "-");
                    s_pto = "0.2";
                    // Buscamos en la tabla de formatos si este conjunto de datos requiere formatear
                    DataTable dt = (new GeneralSoapClient()).Lista_ColumnasExcel(my_dataTable.TableName);

                    if (iHojas == 1)
                    {
                        if (!string.IsNullOrEmpty(my_dataTable.TableName))
                        {
                            s_pto = "1";
                            int itotal = my_dataTable.TableName.Length;
                            vHoja = itotal < 30 ? my_dataTable.TableName.Substring(0, itotal) : my_dataTable.TableName;
                            vHoja = vHoja.Length > 30 ? vHoja.Substring(0, 30) : vHoja;
                        }

                        var worksheet = package.Workbook.Worksheets.Add(vHoja);

                        if (dt != null && dt.Rows.Count != 0)
                        {
                            // Columnas de fecha
                            List<string> columnasFecha = new List<string>();
                            foreach (DataRow row in dt.Rows)
                                if (row["COLUMNAFECHA"] != DBNull.Value)
                                    columnasFecha.Add(row["COLUMNAFECHA"].ToString());

                            // Columnas numéricas
                            List<(int, string)> columnasNumericas = new List<(int, string)>();
                            foreach (DataRow row in dt.Rows)
                                if (row["POSICION_N"] != DBNull.Value && row["COLUMNANUMERO"] != DBNull.Value)
                                    columnasNumericas.Add((Convert.ToInt32(row["POSICION_N"]), row["COLUMNANUMERO"].ToString()));

                            Dictionary<int, List<int>> filasCorregidas = new Dictionary<int, List<int>>();
                            DataTable my_dataTableDepurado = my_dataTable.Copy();

                            // Agregar columnas decimales
                            foreach (var colInfo in columnasNumericas)
                                if (my_dataTable.Columns.Contains(colInfo.Item2))
                                    my_dataTableDepurado.Columns.Add(colInfo.Item2 + "decimal", typeof(decimal));

                            int filaIndex = 1;
                            foreach (DataRow row in my_dataTableDepurado.Rows)
                            {
                                List<int> columnasModificadas = new List<int>();

                                // Validar fechas
                                foreach (string col in columnasFecha)
                                {
                                    if (my_dataTable.Columns.Contains(col))
                                    {
                                        var fechaValor = row[col]?.ToString().Trim();
                                        if (string.IsNullOrWhiteSpace(fechaValor))
                                        {
                                            row[col] = new DateTime(1900, 1, 1);
                                            columnasModificadas.Add(columnasFecha.IndexOf(col) + 1);
                                        }
                                        else
                                        {
                                            DateTime fecha;
                                            if (!DateTime.TryParse(fechaValor, out fecha) || !EsFechaValidaParaExcel(fechaValor, out DateTime fech))
                                            {
                                                row[col] = new DateTime(1900, 1, 1);
                                                columnasModificadas.Add(columnasFecha.IndexOf(col) + 1);
                                            }
                                            else
                                            {
                                                if (fechaValor.Contains(":"))
                                                {
                                                    row[col] = fecha;
                                                }
                                                else
                                                {
                                                    row[col] = fecha.ToString("dd/MM/yyyy");
                                                }
                                            }
                                        }
                                    }
                                }

                                // Validar números
                                foreach (var colInfo in columnasNumericas)
                                {
                                    string col = colInfo.Item2;
                                    if (my_dataTable.Columns.Contains(col))
                                    {
                                        var textoValor = row[col]?.ToString().Trim();
                                        row[col + "decimal"] = string.IsNullOrWhiteSpace(textoValor) ? 0 : Convert.ToDecimal(textoValor);
                                        columnasModificadas.Add(colInfo.Item1);
                                    }
                                }

                                if (columnasModificadas.Count > 0)
                                    filasCorregidas[filaIndex] = columnasModificadas;

                                filaIndex++;
                            }

                            // Reemplazar columnas originales por decimales
                            foreach (var colInfo in columnasNumericas)
                            {
                                string col = colInfo.Item2;
                                if (my_dataTable.Columns.Contains(col))
                                {
                                    my_dataTableDepurado.Columns.Remove(col);
                                    my_dataTableDepurado.Columns[col + "decimal"].ColumnName = col;
                                    my_dataTableDepurado.Columns[col].SetOrdinal(colInfo.Item1);
                                }
                            }

                            my_dataTableDepurado.AcceptChanges();

                            // Insertar tabla en Excel
                            worksheet.Cells["A1"].LoadFromDataTable(my_dataTableDepurado, true, TableStyles.Medium9);
                        }
                        else
                        {
                            worksheet.Cells["A1"].LoadFromDataTable(my_dataTable, true, TableStyles.Medium9);
                        }
                    }
                    else
                    {
                        for (int i = 1; i <= iHojas; i++)
                        {
                            var worksheet = package.Workbook.Worksheets.Add(vHoja + iHojas);
                            worksheet.Cells["A1"].LoadFromDataTable(ds.Tables[i - 1], true, TableStyles.Medium9);
                        }
                    }

                    // Descargar archivo
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=RpExcel_" + sfecha + ".xlsx");

                    using (var memoryStream = new MemoryStream())
                    {
                        package.SaveAs(memoryStream);
                        memoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        try
                        {
                            Response.End();
                        }
                        catch
                        {
                            HttpContext.Current.ApplicationInstance.CompleteRequest();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores igual que tu código original
                if (ex.Message != "Subproceso anulado.")
                {
                    var result = "" + ex.Message + " " + s_Corregidos;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                    result = result.Replace("'", "");
                    string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                    string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name + " pto=" + s_pto;
                    this.LanzarException(methodName, ex); // error para el log
                    Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                    string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
                    /// retornamos el error
                    ///  // Crear una tabla para almacenar el error
                    DataTable dtError = new DataTable("Error");
                    dtError.Columns.Add("Mensaje", typeof(string));
                    dtError.Columns.Add("StackTrace", typeof(string));

                    DataRow filaError = dtError.NewRow();
                    filaError["Mensaje"] = ex.Message;
                    filaError["StackTrace"] = ex.StackTrace;
                    dtError.Rows.Add(filaError);

                    // Agregar la tabla de error al DataSet
                    ds.Tables.Add(dtError);

                }
            }
        }

        private void FormatNumericCells(IXLWorksheet worksheet)
        {
            // Iterar sobre cada celda en la hoja de cálculo
            foreach (var cell in worksheet.CellsUsed())
            {
                // Verificar si el valor de la celda es numérico
                if (double.TryParse(cell.GetValue<string>(), out double result))
                {
                    // Aplicar formato numérico a la celda
                    cell.Style.NumberFormat.Format = "#,##0.00"; // Ejemplo de formato numérico (2 decimales)
                    cell.SetValue(result); // Asegura que el valor sea tratado como número
                }
            }
        }

    }
}