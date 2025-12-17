using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.srvGestionReportes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using static EasyControlWeb.EasyUtilitario.Enumerados;

//*********************
/*
Session["objRpt"] = oEasyDataInterConect; EasyDataInterConect oEasyDataInterConect = new EasyDataInterConect();
Session["DataXLS"] = ds;        DataSet ds = new DataSet();
*/
//******************
namespace SIMANET_W22R.GestionReportes
{
    public partial class GenerarPdf : PaginaBase
    {
        string CadenadeFiltro = "";
        bool terminoOK = false;
        string DataObjeto = "";
        string sPto_Error = "";

        public class ReporteBE : BaseBE
        {
            public string IdReporte { get; set; }

            public string SourceRpt { get; set; }

            // public string UserName { get; set; }
            public string GUID { get; set; }

            public string Extension { get; set; }
            public string PathLocalDestino { get; set; }
            public string WebService { get; set; }
            public string Metodo { get; set; }
            public string Parametros { get; set; }
            public string Criterios { get; set; }
            public string Nombre { get; set; }

            public string getNomFileGenerado()
            {
                //return this.IdReporte + "_" + this.GUID + this.Extension;
                return this.GUID + this.Extension;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public override void ProcessRequest(HttpContext context)
        {
            int IdReporte = Convert.ToInt32(context.Request.Params["IdReporte"]);
            string UserName = context.Request.Params["UserName"].ToString();
            string UrlApp = context.Request.Params["UrlApp"].ToString();

            try
            {
                EasyDataInterConect oEasyDataInterConect = new EasyDataInterConect();
                EasyFiltroParamURLws oParam;
                context.Response.Buffer = true;
                context.Response.Clear();
                //Inicia la Instancia de los datos del reporte
                ReporteBE oReporteBE = new ReporteBE();
                oReporteBE = PefildelReporte(IdReporte, UserName);
                oEasyDataInterConect.MetodoConexion =
                    EasyDataInterConect.MetododeConexion.WebServiceInterno; //Agregado 08-03-2024
                oEasyDataInterConect.UrlWebService = oReporteBE.WebService;
                oEasyDataInterConect.Metodo = oReporteBE.Metodo;

                string[] ObjetosParam =
                    context.Request.Params["oEasyFiltroParamURLws"].Split('@'); //Formato:{Parametro:valor,etc..}@
                string tipoImpresora = "A4";
                object[] param = new object[ObjetosParam.Length];
                int i = 0;

                foreach (string objParam in ObjetosParam)
                {
                    sPto_Error =
                        "obteniendo parámetros con valores"; // SI LOS DATOS TIENES COMAS CAUSARÁ ERROR AL INTENTAR RECORTAR LOS VALORES
                    Dictionary<string, string> oEntity = EasyUtilitario.Helper.Data.SeriaizedDiccionario(objParam);
                    string ParamName = oEntity.Keys.ElementAt(0);
                    string ParamValue = oEntity[ParamName];
                    //Cadena de Filtro
                    CadenadeFiltro += oEntity["FiltroText"] + EasyUtilitario.Constantes.Caracteres.SignoIgual +
                                      oEntity["FiltroValor"] + Environment.NewLine;

                    if (ParamName == "V_IMPRESORA")
                    {
                        tipoImpresora = ParamValue;
                    }


                    EasyFiltroParamURLws easyParam = new EasyFiltroParamURLws();
                    easyParam.ParamName = ParamName;
                    easyParam.Paramvalue = ParamValue;
                    easyParam.TipodeDato =
                        (TiposdeDatos)System.Enum.Parse(typeof(TiposdeDatos), oEntity["TipoDato"].ToString());
                    oEasyDataInterConect.UrlWebServicieParams.Add(easyParam);

                    i++;
                }

                object objResult = EasyWebServieHelper.InvokeWebService2(UrlApp, oEasyDataInterConect);

                Session["objRpt"] = oEasyDataInterConect;
                DataSet ds1 = new DataSet();
                if (objResult.GetType() == typeof(DataSet))
                {
                    ds1 = (DataSet)objResult;
                }
                else
                {
                    DataTable dt = (DataTable)objResult;
                    ds1.Tables.Add(dt);
                }

                string NomFileRpt = CrystalGeneraPdf(oReporteBE, ds1);
                //----------------------------------
                string
                    nombre = System.IO.Path
                        .GetFileName(NomFileRpt); // tomamos el nombre generado anteriormente para guardar relacion
                string NomFileRptxls = CrystalGeneraXlsx(oReporteBE, ds1, nombre);

                #region Footer report

                //----------------------------Init Reporte Footer---------------------------------------------------
                //Obtener datos del reporte y sus caracteristicas de gestion
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                DataTable dtInfoFooterReport = ogReports.ListarCabeceradeReporte(IdReporte, UserName);
                DataSet ds = new DataSet();
                ds = new DataSet();
                dtInfoFooterReport.TableName = "RPT_uspNTADDetalleReporte;1";

                dtInfoFooterReport.Rows[0]["Criterios"] = CadenadeFiltro;
                // 10.03.2025 COLOCAMOS AL USUARIO COMO QUIEN SOLICITA Y CREA EL REPORTE
                string sUsuario;
                dtInfoFooterReport.Rows[0]["IdUsuarioSolicitante1"] =
                    ((EasyUsuario)EasyUtilitario.Helper.Sessiones.Usuario.get()).IdUsuario;
                sUsuario = ((EasyUsuario)EasyUtilitario.Helper.Sessiones.Usuario.get()).ApellidosyNombres;
                if (string.IsNullOrEmpty(sUsuario))
                {
                    sUsuario = UserName;
                }

                dtInfoFooterReport.Rows[0]["UsuarioSolicitante"] = sUsuario;

                dtInfoFooterReport.AcceptChanges();
                ds.Tables.Add(dtInfoFooterReport);

                //Cambia algunos datos para el nuevo reporte
                oReporteBE.SourceRpt = EasyUtilitario.Helper.Configuracion.Leer(
                    EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFileRptFooter");
                oReporteBE.GUID = GenerarGUId();

                //==== 31.07.2025  se Copia el archivo para permitir que al archivo rpt footer sea usado en otro proceso
                string GuidRPTFooter = GenerarGUId();
                string rptFooterTmp = oReporteBE.PathLocalDestino + EasyUtilitario.Constantes.Caracteres.BackSlash +
                                      GuidRPTFooter + ".rpt";
                File.Copy(oReporteBE.SourceRpt, rptFooterTmp, overwrite: true);
                oReporteBE.SourceRpt =
                    rptFooterTmp; //Reeplaza el nombre del archivo base por el tempral generado para ser incrustado
                //=================================================================

                string PathUrlFooter = CrystalGeneraPdf(oReporteBE, ds);


                //----------------------------Fin Footer---------------------------------------------------


                //-----------------------------------Init File Report Final con Merge----------------------------------------------------------
                oReporteBE.GUID = GenerarGUId();
                string ReportFileFinal = oReporteBE.IdReporte + "_" + oReporteBE.getNomFileGenerado();
                string FilePDFReport = oReporteBE.PathLocalDestino + "\\" + ReportFileFinal;
                string[] lst = new string[2]
                {
                    oReporteBE.PathLocalDestino + "\\" + NomFileRpt, oReporteBE.PathLocalDestino + "\\" + PathUrlFooter
                };
                MergePdf(FilePDFReport, lst);

                // despues de unir los pdf podemos crear el xls ya que recien le dará un Nombre final   21.08.2025
                //  string nombre1 = System.IO.Path.GetFileName(ReportFileFinal); // tomamos el nombre generado anteriormente para guardar relacion
                //  string NomFileRptxls1 = CrystalGeneraXlsx(oReporteBE, ds1, nombre1);


                string directorio = Path.GetDirectoryName(FilePDFReport); // C:\AppWebs\AppTest\Archivos\HomeRptGen\user
                string nombreSinExtension =
                    Path.GetFileNameWithoutExtension(ReportFileFinal); // 248_55a2a6feeaf243ceb487ec95964a00ad
                string nuevoArchivo =
                    Path.Combine(directorio, nombreSinExtension + ".xlsx"); // Construir nueva ruta con extensión .xlsx
                string AnteriorPath = Path.Combine(directorio, NomFileRptxls);
                sPto_Error = "rename file";
                File.Move(AnteriorPath, nuevoArchivo); // Renombrar el archivo

                Session["NombreArchivo"] = nuevoArchivo;

                //==== 31.07.2025  redimensiona la lista
                Array.Resize(ref lst, 3);
                lst[2] = oReporteBE.SourceRpt;
                //==========================================
                sPto_Error = "Limpiando file";
                //Elimina listas  temporales
                foreach (string f in lst)
                {
                    File.Delete(f);
                }

                //-----------------------------------FinFile Report Final con Merge----------------------------------------------------------

                #endregion

                string PathUrl = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRptHttp") +
                                 oReporteBE.UserName + "/" + ReportFileFinal;

                context.Response.Write("{Estado:'OK',Descripcion:'Completado',PathFile:'" + PathUrl + "'}");
                terminoOK = true;
                context.Response.Flush();
                // context.Response.End();
                HttpContext.Current.ApplicationInstance
                    .CompleteRequest(); //Se utriliza en lugar de context.Response.End(), para evitar conflito de tareas

            }
            catch (Exception ex)
            {
                if (terminoOK == false)
                {
                    DataObjeto += "ERROR:=" + ex.Message + " " + sPto_Error;
                    context.Response.Write("{Estado:'ERROR',Descripcion:'" + DataObjeto +
                                           "',PathFile:'GenerarPdf.aspx/ProcessRequest'}");
                    context.Response.Flush();
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                    // mandamos alerta de error empleando: SweetAlert2, para saber que esta pasando, esto como parte del CONCEPTO UX (User Experience) 
                    var result = "" + ex.Message;
                    string scriptSuccess = $"Swal.fire('Error', 'GenerarPDF - ProcessRequest(): {result}', 'error');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
                }
            }
        }

        public ReporteBE PefildelReporte(int IdReporte, string UserName)
        {
            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            DataTable dtInfoReport = ogReports.ListarInformacionReporte(IdReporte.ToString(), UserName);
            DataRow drInfo = dtInfoReport.Rows[0];

            ReporteBE oReporteBE = new ReporteBE();
            oReporteBE.SourceRpt =
                EasyUtilitario.Helper.Configuracion.Leer(
                    EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFileSourceRpts") +
                drInfo["Ref1"].ToString();
            oReporteBE.IdReporte = IdReporte.ToString();
            oReporteBE.UserName = UserName;
            oReporteBE.Extension = drInfo["Ref4"].ToString();
            oReporteBE.GUID = GenerarGUId();
            oReporteBE.PathLocalDestino = CrearHome(oReporteBE.UserName);
            oReporteBE.WebService = drInfo["Ref2"].ToString();
            ;
            oReporteBE.Metodo = drInfo["Ref3"].ToString();
            oReporteBE.Descripcion = drInfo["Descripcion"].ToString();
            oReporteBE.Nombre = drInfo["Nombre"].ToString();

            return oReporteBE;
        }

        public ReporteBE PefildelReporte(int IdReporte, string UserName, string Tipoimpresora)
        {
            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            DataTable dtInfoReport = ogReports.ListarInformacionReporte(IdReporte.ToString(), UserName);
            DataRow drInfo = dtInfoReport.Rows[0];
            ReporteBE oReporteBE = new ReporteBE();
            if (Tipoimpresora == "A4")
            {
                oReporteBE.SourceRpt = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFileSourceRpts") + drInfo["Ref1"].ToString();
            }
            else
            {
                oReporteBE.SourceRpt = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFileSourceRpts") + drInfo["Ref1"].ToString().Substring(0, (drInfo["Ref1"].ToString().Length) - 4) + Tipoimpresora + Path.GetExtension(drInfo["Ref1"].ToString());
            }

            oReporteBE.IdReporte = IdReporte.ToString();
            oReporteBE.UserName = UserName;
            oReporteBE.Extension = drInfo["Ref4"].ToString();
            oReporteBE.GUID = GenerarGUId();
            oReporteBE.PathLocalDestino = CrearHome(oReporteBE.UserName);
            oReporteBE.WebService = drInfo["Ref2"].ToString(); ;
            oReporteBE.Metodo = drInfo["Ref3"].ToString();
            oReporteBE.Descripcion = drInfo["Descripcion"].ToString();
            oReporteBE.Nombre = drInfo["Nombre"].ToString();

            return oReporteBE;
        }

        public string GenerarGUId()
        {
            Guid miGuid = Guid.NewGuid();
            string token = miGuid.ToString().Replace("-", string.Empty);
            return token;
        }

        public string CrystalGeneraPdf(ReporteBE oReporteBE, DataSet ds)
        {
            string Linea = "";
            string NombreArchivo = oReporteBE.getNomFileGenerado();
            string NombreArchivoEncript = GenerarGUId();
            string RutayArchivo = oReporteBE.PathLocalDestino + "\\" + NombreArchivo;

            try
            {
                /***** 
                      * Verificar si existe la tabla CONFIG
                      *****/
                if (ds.Tables.Contains("config"))
                {
                    /***** 
                     * 1. Leer datos de la tabla CONFIG
                     *****/
                    string tipoObjeto = ds.Tables["config"].Rows[0][0].ToString();
                    string rutaCsv = ds.Tables["config"].Rows[0][1].ToString();
                    string urlVirtualExcel = ds.Tables["config"].Rows[0][2].ToString();

                    /***** 
                     * 2. Convertir CSV a Excel
                     *****/
                    string rutaExcel = rutaCsv.Replace(".csv", ".xlsx");
                    ConvertirCsvAExcel(rutaCsv, rutaExcel);

                    /***** 
                     * 3. Generar PDF desde Excel con URL en cabecera
                     *****/
                    string rutaPdf = Path.Combine(oReporteBE.PathLocalDestino, NombreArchivo);
                    CrearPdfDesdeExcel(rutaExcel, rutaPdf, urlVirtualExcel);

                    return NombreArchivo; // Devuelve el nombre del PDF generado
                }
                else
                {
                    /***** 
                     * Lógica original con Crystal Reports
                     *****/

                    //CrystalDecisions.CrystalReports.Engine.ReportDocument _rpt = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                    ReportDocument _rpt = new ReportDocument();
                    Linea = "oReporteBE.SourceRpt";
                    _rpt.Load(oReporteBE.SourceRpt);
                    Linea = "_rpt.SetDataSource";
                    _rpt.SetDataSource(ds);

                    Linea = "crDiskFileDestinationOptions";

                    DiskFileDestinationOptions crDiskFileDestinationOptions = new DiskFileDestinationOptions();

                    Linea = oReporteBE.PathLocalDestino + "\\" + NombreArchivo;

                    crDiskFileDestinationOptions.DiskFileName = oReporteBE.PathLocalDestino + "\\" + NombreArchivo;
                    Linea = "crExportOptions";
                    CrystalDecisions.Shared.ExportOptions crExportOptions = _rpt.ExportOptions;
                    Linea = "DestinationOptions";
                    crExportOptions.DestinationOptions = crDiskFileDestinationOptions;
                    Linea = "ExportDestinationType";
                    crExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
                    Linea = "ExportFormatType";


                    crExportOptions.ExportFormatType = ((oReporteBE.Extension.ToUpper().Equals(".PDF")) ? ExportFormatType.PortableDocFormat : ExportFormatType.Excel);
                    _rpt.Export();
                    /*---------------------------*/

                    Session["DataXLS"] = ds;
                }
            }
            catch (Exception ex)
            {
                NombreArchivo = "Error.pdf";
                CrearPdfDefault(oReporteBE.PathLocalDestino + "\\" + NombreArchivo, ex.Message + "\n" + Linea);
                //-----------
                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = "GenerarPdf.aspx";
                string methodName = "CrystalGeneraPdf";
                //this.LanzarException(methodName, ex); // error para el log
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }

            /*Proteger el archivo*/
            /*  using (Stream input = new FileStream(oReporteBE.PathLocalDestino + "\\" + NombreArchivo, FileMode.Open, FileAccess.Read, FileShare.Read))
              using (Stream output = new FileStream(oReporteBE.PathLocalDestino + "\\" + NombreArchivoEncript, FileMode.Create, FileAccess.Write, FileShare.None))
              {
                  PdfReader reader = new PdfReader(input);
                  PdfEncryptor.Encrypt(reader, output, true, "secret", "secret", PdfWriter.AllowFillIn| PdfWriter.AllowScreenReaders);


              }
              //Eliminar El archivo base
              oReporteBE.GUID = NombreArchivoEncript;
              return NombreArchivoEncript;*/


            return NombreArchivo;
        }

        public string CrystalGeneraXlsx(ReporteBE oReporteBE, DataSet ds, string NombreArchivo)
        {
            string Linea = "";
            //   string NombreArchivo = oReporteBE.getNomFileGenerado().Replace(".pdf",".xlsx") ;
            NombreArchivo = NombreArchivo.Replace(".pdf", ".xlsx");
            string NombreArchivoEncript = GenerarGUId();
            string RutayArchivo = oReporteBE.PathLocalDestino + "\\" + NombreArchivo;

            try
            {
                //CrystalDecisions.CrystalReports.Engine.ReportDocument _rpt = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                ReportDocument _rpt = new ReportDocument();
                Linea = "oReporteBE.SourceRpt";
                _rpt.Load(oReporteBE.SourceRpt);
                Linea = "_rpt.SetDataSource";
                _rpt.SetDataSource(ds);

                Linea = "crDiskFileDestinationOptions";

                DiskFileDestinationOptions crDiskFileDestinationOptions = new DiskFileDestinationOptions();

                Linea = oReporteBE.PathLocalDestino + "\\" + NombreArchivo;

                crDiskFileDestinationOptions.DiskFileName = oReporteBE.PathLocalDestino + "\\" + NombreArchivo;
                Linea = "crExportOptions";
                CrystalDecisions.Shared.ExportOptions crExportOptions = _rpt.ExportOptions;
                Linea = "DestinationOptions";
                crExportOptions.DestinationOptions = crDiskFileDestinationOptions;
                Linea = "ExportDestinationType";
                crExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
                Linea = "ExportFormatType";


                /*---------------------------*/
                crExportOptions.ExportFormatType = ExportFormatType.ExcelWorkbook;
                _rpt.Export();

                Session["DataXLS"] = ds;


                string filePath = crDiskFileDestinationOptions.DiskFileName; // Ruta del archivo generado
                string fileName = NombreArchivo; // Nombre que verá el usuario

                Session["archivoDescarga"] = filePath;
                Session["NombreArchivo"] = NombreArchivo;

            }
            catch (Exception ex)
            {
                NombreArchivo = "Error.pdf";
                CrearPdfDefault(oReporteBE.PathLocalDestino + "\\" + NombreArchivo, ex.Message + "\n" + Linea);
                //-----------
                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = "GenerarPdf.aspx";
                string methodName = "CrystalGeneraPdf";
                //this.LanzarException(methodName, ex); // error para el log
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
            /*Proteger el archivo*/
            /*  using (Stream input = new FileStream(oReporteBE.PathLocalDestino + "\\" + NombreArchivo, FileMode.Open, FileAccess.Read, FileShare.Read))           
              using (Stream output = new FileStream(oReporteBE.PathLocalDestino + "\\" + NombreArchivoEncript, FileMode.Create, FileAccess.Write, FileShare.None))
              {
                  PdfReader reader = new PdfReader(input);
                  PdfEncryptor.Encrypt(reader, output, true, "secret", "secret", PdfWriter.AllowFillIn| PdfWriter.AllowScreenReaders);


              }
              //Eliminar El archivo base
              oReporteBE.GUID = NombreArchivoEncript;
              return NombreArchivoEncript;*/


            return NombreArchivo;
        }

        /***** 
         * Método para convertir CSV a Excel usando EPPlus Install-Package EPPlus -Version 4.5.3.2
         *****/
        private void ConvertirCsvAExcel(string rutaCsv, string rutaExcel)
        {
            using (var package = new ExcelPackage())
            {
                var worksheet = package.Workbook.Worksheets.Add("Datos");
                var lines = File.ReadAllLines(rutaCsv);
                for (int i = 0; i < lines.Length; i++)
                {
                    var values = lines[i].Split(',');
                    for (int j = 0; j < values.Length; j++)
                    {
                        worksheet.Cells[i + 1, j + 1].Value = values[j];
                    }
                }
                package.SaveAs(new FileInfo(rutaExcel));
            }
        }

        /***** 
         * Método para crear PDF desde Excel e incrustar la URL en la cabecera
         *****/
        private void CrearPdfDesdeExcel(string rutaExcel, string rutaPdf, string urlVirtual)
        {
            using (FileStream fs = new FileStream(rutaPdf, FileMode.Create, FileAccess.Write, FileShare.None))
            {
                Document doc = new Document(PageSize.A4);
                PdfWriter writer = PdfWriter.GetInstance(doc, fs);
                doc.Open();

                // Cabecera con la URL virtual
                var fontHeader = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12);
                doc.Add(new Paragraph("Descargar Excel: " + urlVirtual, fontHeader));
                doc.Add(new Paragraph(" "));

                // Leer el Excel y crear tabla en PDF
                using (var package = new ExcelPackage(new FileInfo(rutaExcel)))
                {
                    var worksheet = package.Workbook.Worksheets[0];
                    int rows = worksheet.Dimension.Rows;
                    int cols = worksheet.Dimension.Columns;

                    PdfPTable table = new PdfPTable(cols);
                    table.WidthPercentage = 100;

                    // Encabezados
                    for (int j = 1; j <= cols; j++)
                    {
                        PdfPCell cellHeader = new PdfPCell(new Phrase(worksheet.Cells[1, j].Text));
                        cellHeader.BackgroundColor = BaseColor.LIGHT_GRAY;
                        table.AddCell(cellHeader);
                    }

                    // Filas
                    for (int i = 2; i <= rows; i++)
                    {
                        for (int j = 1; j <= cols; j++)
                        {
                            table.AddCell(new Phrase(worksheet.Cells[i, j].Text));
                        }
                    }

                    doc.Add(table);
                }

                doc.Close();
            }
        }

        public void PrintPrevioWatermark(int IdReporte, string NombreNuevo, string watermarkTemplatePath, string UserName, DataSet ds, params object[] LstCtrl)
        {
            ReporteBE oReporteBE = PefildelReporte(IdReporte, UserName);
            string NomFileRpt = (new GenerarPdf()).CrystalGeneraPdf(oReporteBE, ds);
            string FileRpt = oReporteBE.UserName + "[.]" + NombreNuevo;

            //Sella el archivo 
            EasyUtilitario.Helper.Archivo.PDF.AddTextWatermark(oReporteBE.PathLocalDestino + "\\" + NomFileRpt, watermarkTemplatePath);

            if (File.Exists(oReporteBE.PathLocalDestino + "\\" + NombreNuevo))
            {
                File.Delete(oReporteBE.PathLocalDestino + "\\" + NombreNuevo);
            }
            System.IO.File.Move(oReporteBE.PathLocalDestino + "\\" + NomFileRpt, oReporteBE.PathLocalDestino + "\\" + NombreNuevo);

            // EasyUtilitario.Helper.Pagina.DEBUG(FileRpt);
            PrintPrevio(oReporteBE.Nombre, oReporteBE.Descripcion, FileRpt, LstCtrl);
        }

        public void PrintPrevio(int IdReporte, string NombreNuevo, string UserName, DataSet ds, params object[] LstCtrl)
        {
            ReporteBE oReporteBE = PefildelReporte(IdReporte, UserName);
            string NomFileRpt = (new GenerarPdf()).CrystalGeneraPdf(oReporteBE, ds);
            string FileRpt = oReporteBE.UserName + "[.]" + NombreNuevo;

            if (File.Exists(oReporteBE.PathLocalDestino + "\\" + NombreNuevo))
            {
                File.Delete(oReporteBE.PathLocalDestino + "\\" + NombreNuevo);
            }
            System.IO.File.Move(oReporteBE.PathLocalDestino + "\\" + NomFileRpt, oReporteBE.PathLocalDestino + "\\" + NombreNuevo);

            // EasyUtilitario.Helper.Pagina.DEBUG(FileRpt);
            PrintPrevio(oReporteBE.Nombre, oReporteBE.Descripcion, FileRpt, LstCtrl);
        }

        public void PrintPrevio(int IdReporte, string UserName, DataSet ds, params object[] LstCtrl)
        {
            try
            {
                ReporteBE oReporteBE = PefildelReporte(IdReporte, UserName);
                string NomFileRpt = (new GenerarPdf()).CrystalGeneraPdf(oReporteBE, ds);
                string FileRpt = oReporteBE.UserName + "[.]" + NomFileRpt;
                //EasyUtilitario.Helper.Pagina.DEBUG(FileRpt);
                PrintPrevio(oReporteBE.Nombre, oReporteBE.Descripcion, FileRpt, LstCtrl);
            }
            catch (Exception ex)
            {


            }
        }
        public void PrintPrevio(string Titulo, string Descripcion, string HttpPathReport, params object[] LstCtrl)
        {
            //string FileRpt = oReporteBE.UserName + "[.]" + NomFileRpt;
            string FileRpt = HttpPathReport;
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            //Llama a la interface del reporte para una vizualizacion previa
            oEasyNavigatorBE.Texto = Titulo;
            oEasyNavigatorBE.Descripcion = Descripcion;
            oEasyNavigatorBE.Pagina = "/GestionReportes/ReportPrevio.aspx";


            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("kQSeccion", "ConfigBase"));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("kQPathRpt", "PathFileRptHttp"));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("RutaWebRpt", FileRpt));

            this.IrA(oEasyNavigatorBE, LstCtrl);
        }
        public void PrintPrevio(string Titulo, string HttpPathReport, string ConfigSeccion, string ConfigKey, params object[] LstCtrl)
        {
            string FileRpt = this.UsuarioLogin + "[.]" + HttpPathReport;
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            //Llama a la interface del reporte para una vizualizacion previa
            oEasyNavigatorBE.Texto = Titulo;
            oEasyNavigatorBE.Descripcion = "";
            oEasyNavigatorBE.Pagina = "/GestionReportes/ReportPrevio.aspx";


            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("kQSeccion", ConfigSeccion));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("kQPathRpt", ConfigKey));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("RutaWebRpt", FileRpt));

            this.IrA(oEasyNavigatorBE, LstCtrl);
        }



        public Dictionary<string, string> CrearArchivo(int IdReporte, string UserName, DataSet ds)
        {
            ReporteBE oReporteBE = PefildelReporte(IdReporte, UserName);
            string NomFileRpt = (new GenerarPdf()).CrystalGeneraPdf(oReporteBE, ds);
            string FileRpt = oReporteBE.UserName + "/" + NomFileRpt;

            Dictionary<string, string> DataBE = new Dictionary<string, string>();
            DataBE.Add("PathLocal", oReporteBE.PathLocalDestino);
            DataBE.Add("NombreGenerado", NomFileRpt);
            DataBE.Add("PathBasico", FileRpt);
            DataBE.Add("PathHTTPBase", EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRptHttp"));
            DataBE.Add("PathHTTPBaseUsr", EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRptHttp") + "/" + oReporteBE.UserName);
            DataBE.Add("PathHTTP", EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRptHttp") + "/" + FileRpt);

            return DataBE;
        }


        public static void AddPrintFunction(string pdfPath, Stream outputStream)
        {
            PdfReader reader = new PdfReader(pdfPath);
            int pageCount = reader.NumberOfPages;
            iTextSharp.text.Rectangle pageSize = reader.GetPageSize(1);

            // Set up Writer 
            //PdfSharp.Pdf.PdfDocument doc = new PdfSharp.Pdf.PdfDocument();
            Document doc = new Document();

            PdfWriter writer = PdfWriter.GetInstance(doc, outputStream);

            doc.Open();

            //Copy each page 
            PdfContentByte content = writer.DirectContent;

            for (int i = 0; i < pageCount; i++)
            {
                doc.NewPage();
                // page numbers are one based 
                PdfImportedPage page = writer.GetImportedPage(reader, i + 1);
                // x and y correspond to position on the page 
                content.AddTemplate(page, 0, 0);
            }

            // Inert Javascript to print the document after a fraction of a second to allow time to become visible.
            string jsText = "var res = app.setTimeOut(‘var pp = this.getPrintParams();pp.interactive = pp.constants.interactionLevel.full;this.print(pp);’, 200);";

            //string jsTextNoWait = “var pp = this.getPrintParams();pp.interactive = pp.constants.interactionLevel.full;this.print(pp);”;
            PdfAction js = PdfAction.JavaScript(jsText, writer);
            writer.AddJavaScript(js);

            doc.Close();

        }


        void MergePdf(string targetFile, string[] files)
        {
            /* using (var outputStream = new FileStream("C:\\AppWebs\\AppTest\\Archivos\\HomeRptGen\\erosales\\test.pdf", FileMode.CreateNew))
             {
                 AddPrintFunction(files[0], outputStream);
                 outputStream.Flush();
             }*/

            using (FileStream stream = new FileStream(targetFile, FileMode.OpenOrCreate))
            {
                Document pdfDoc = new Document(PageSize.A4_LANDSCAPE);
                PdfSmartCopy pdf = new PdfSmartCopy(pdfDoc, stream);
                pdfDoc.Open();
                foreach (string file in files)
                {
                    PdfReader reader = new PdfReader(file);
                    pdf.AddDocument(reader);
                    pdf.FreeReader(reader);
                    reader.Close();
                }
                pdfDoc.Close();
                stream.Close();
            }
        }


        public string CrearHome(string UserName)
        {
            string PathBase = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRpt");
            string path = PathBase + UserName;
            string PathHome = "";

            try
            {
                if (Directory.Exists(path))
                {
                    return path;
                }
                DirectoryInfo di = Directory.CreateDirectory(path);
                PathHome = path;
            }
            catch (Exception e)
            {
                Console.WriteLine("The process failed: {0}", e.ToString());
            }
            finally { }


            return PathHome;
        }

        void CrearPdfDefault(string NombreFile, string msg)
        {

            Document document = new Document(PageSize.A6.Rotate(), 5, 5, 5, 5);

            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(NombreFile, FileMode.Create, FileAccess.Write, FileShare.None));

            document.Open();

            document.AddTitle("Mi primer PDF");
            document.AddCreator("Rosales Azabache Eddy");

            document.Add(new Paragraph("ERROR:" + msg));

            document.Close();
            writer.Close();
        }

        void demopdf()
        {

            //  AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            //  DataTable dtInfoFooterReport = ogReports.ListarCabeceradeReporte(this.IdReporteInspeccion, this.UsuarioLogin);

            // DataRow dr = dtInfoFooterReport.Rows[0];


            Document document = new Document(PageSize.A6.Rotate(), 5, 5, 5, 5);

            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream("C:\\tmp\\erosales\\NombreDeTuArchivo.pdf", FileMode.Create, FileAccess.Write, FileShare.None));

            document.Open();

            document.AddTitle("Mi primer PDF");
            document.AddCreator("Rosales Azabache Eddy");

            document.Add(new Paragraph("demo"));

            PdfPTable tblPrueba = new PdfPTable(3);
            tblPrueba.WidthPercentage = 100;

            iTextSharp.text.Font _standardFont = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8, iTextSharp.text.Font.BOLD, BaseColor.BLACK);

            // Configuramos el título de las columnas de la tabla
            PdfPCell clAcercaDe = new PdfPCell(new Phrase("ACERCA DEl REPORTE", _standardFont));
            clAcercaDe.BorderWidth = 0;
            clAcercaDe.BorderWidthBottom = 0.75f;

            PdfPCell clFiltro = new PdfPCell(new Phrase("FILTRO", _standardFont));
            clFiltro.BorderWidth = 0;
            clFiltro.BorderWidthBottom = 0.75f;

            PdfPCell clSoporte = new PdfPCell(new Phrase("SOPORTE", _standardFont));
            clSoporte.BorderWidth = 0;
            clSoporte.BorderWidthBottom = 0.75f;


            // Añadimos las celdas a la tabla
            tblPrueba.AddCell(clAcercaDe);
            tblPrueba.AddCell(clFiltro);
            tblPrueba.AddCell(clSoporte);

            _standardFont = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 8, iTextSharp.text.Font.NORMAL, BaseColor.BLACK);

            // Llenamos la tabla con información
            clAcercaDe = new PdfPCell(new Phrase("", _standardFont));
            clAcercaDe.BorderWidth = 0;

            clFiltro = new PdfPCell(new Phrase("IdReporte=3asdqahsdqwieqweqwqnweqweijqwopeiqoweiqwrqkwerqlkjerqwejkqoeqoweqwoeqwopreqwrjqwejrqwejqejqwejqweqwkeoqeoqeoqeoqe", _standardFont));
            clFiltro.BorderWidth = 0;

            clSoporte = new PdfPCell(new Phrase("erosales@sima.com.pe", _standardFont));
            clSoporte.BorderWidth = 0;




            // Añadimos las celdas a la tabla
            tblPrueba.AddCell(clAcercaDe);
            tblPrueba.AddCell(clFiltro);
            tblPrueba.AddCell(clSoporte);


            // Llenamos la tabla con información
            clAcercaDe = new PdfPCell(new Phrase("..", _standardFont));
            clAcercaDe.BorderWidth = 0;

            clFiltro = new PdfPCell(new Phrase("..", _standardFont));
            clFiltro.BorderWidth = 0;


            clSoporte = new PdfPCell(new Phrase("rpuga@sima.com.pe", _standardFont));
            clSoporte.BorderWidth = 0;
            tblPrueba.AddCell(clAcercaDe);
            tblPrueba.AddCell(clFiltro);
            tblPrueba.AddCell(clSoporte);


            document.Add(tblPrueba);



            document.Close();
            writer.Close();
        }
    }
}