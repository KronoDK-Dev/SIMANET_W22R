using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.srvGestionReportes;
using System;
using System.Data;
using System.Web;
using CrystalDecisions.Shared;
using System.IO;
using CrystalDecisions.ReportAppServer;
using CrystalDecisions.CrystalReports.Engine;
using static System.Net.Mime.MediaTypeNames;
using iTextSharp.text.pdf;
using System.Collections.Generic;
using System.Drawing;
using iTextSharp.text;
using static SIMANET_W22R.GestionReportes.GenerarPdf;
using System.Runtime.Remoting.Contexts;
using System.Web.UI;
using EasyControlWeb.Form.Controls;
using iTextSharp.text.pdf.qrcode;
using PdfSharp.Pdf;
using static iTextSharp.text.pdf.PdfCopy;
using System.Runtime.InteropServices.ComTypes;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.EasyUtilitario;
using System.Drawing.Printing;
using CrystalDecisions.ReportAppServer.CommonObjectModel;
using static EasyControlWeb.EasyUtilitario.Helper;
using EasyControlWeb.InterConecion;
using static iTextSharp.text.pdf.AcroFields;
using System.Linq;
using static EasyControlWeb.EasyUtilitario.Enumerados.MessageBox;
using System.Security.Cryptography;
using static EasyControlWeb.EasyUtilitario.Constantes.Formato;
//using CrystalDecisions.ReportAppServer.DataDefModel;

namespace SIMANET_W22R.GestionReportes
{
    public partial class GenerarPdf : PaginaBase
    {
        /*
                  foreach (CrystalDecisions.CrystalReports.Engine.ParameterFieldDefinition pField in (ParameterFieldDefinitions)_rpt.DataDefinition.ParameterFields)
                  {
                      if (pField.ParameterType == ParameterType.StoreProcedureParameter){_rpt.SetParameterValue(pField.ParameterFieldName, "");}
                      if (pField.ParameterType == ParameterType.ReportParameter){string dd = pField.ParameterFieldName;}
                  }
                  */
        public class ReporteBE: BaseBE{ 
            public string IdReporte { get; set; }
            public string SourceRpt { get; set; }
           // public string UserName { get; set; }
            public string GUID { get; set; }

            public string Extension { get; set; }
            public string PathLocalDestino{ get; set; }
            public string WebService { get; set; }
            public string Metodo { get; set; }
            public string Parametros { get; set; }
            public string Criterios { get; set; }
            public string Nombre { get; set; }

            public string getNomFileGenerado() {
                //return this.IdReporte + "_" + this.GUID + this.Extension;
                return this.GUID + this.Extension;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
      
      
        public override void ProcessRequest(HttpContext context)
        {
            string CadenadeFiltro = "";
            bool terminoOK = false;
            string DataObjeto = "";
            /*  int IdReporte = Convert.ToInt32(EasyEncrypta.DesEncriptar(context.Request.Params["IdReporte"]));
              string UserName = EasyEncrypta.DesEncriptar(context.Request.Params["UserName"]);*/
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
                oEasyDataInterConect.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceInterno;//Agregado 08-03-2024
                oEasyDataInterConect.UrlWebService = oReporteBE.WebService;
                oEasyDataInterConect.Metodo = oReporteBE.Metodo;


                string []ObjetosParam = context.Request.Params["oEasyFiltroParamURLws"].Split('@');//Formato:{Parametro:valor,etc..}@
                
                object[] param = new object[ObjetosParam.Length]; int i = 0;

                foreach (string objParam in ObjetosParam) {

                    Dictionary<string, string> oEntity = EasyUtilitario.Helper.Data.SeriaizedDiccionario(objParam);
                    string ParamName = oEntity.Keys.ElementAt(0);
                    string ParamValue = oEntity[ParamName];
                    //Cadena de Filtro
                    CadenadeFiltro += oEntity["FiltroText"] + EasyUtilitario.Constantes.Caracteres.SignoIgual + oEntity["FiltroValor"] + Environment.NewLine;

                    EasyFiltroParamURLws easyParam = new EasyFiltroParamURLws();
                    easyParam.ParamName = ParamName;
                    easyParam.Paramvalue = ParamValue;
                    easyParam.TipodeDato = (TiposdeDatos)System.Enum.Parse(typeof(TiposdeDatos), oEntity["TipoDato"].ToString());
                    oEasyDataInterConect.UrlWebServicieParams.Add(easyParam);

                    i++;
                }

                Session["objRpt"] = oEasyDataInterConect;
                //Session["UrlApp"] = UrlApp;

                object objResult = EasyWebServieHelper.InvokeWebService(UrlApp, oEasyDataInterConect);

                DataSet ds = new DataSet();
                if (objResult.GetType() == typeof(DataSet))
                {
                    ds = (DataSet)objResult;
                }
                else
                {
                    DataTable dt = (DataTable)objResult;
                    ds.Tables.Add(dt);
                }
                string NomFileRpt = CrystalGeneraPdf(oReporteBE, ds);


                #region Footer report

                //----------------------------Init Reporte Footer---------------------------------------------------
                //Obtener datos del reporte y sus caracteristicas de gestion
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                  DataTable dtInfoFooterReport = ogReports.ListarCabeceradeReporte(IdReporte, UserName);

                  ds = new DataSet();     
                  dtInfoFooterReport.TableName = "RPT_uspNTADDetalleReporte;1";
                  
                  dtInfoFooterReport.Rows[0]["Criterios"] = CadenadeFiltro;
                  dtInfoFooterReport.AcceptChanges();

                  ds.Tables.Add(dtInfoFooterReport);

                  //Cambia algunos datos para el nuevo reporte
                  
                  oReporteBE.SourceRpt = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFileRptFooter");
                  oReporteBE.GUID = GenerarGUId();

                //Copia para permitir que al archivo rpt footer sea usado en otro proceso
                  string GuidRPTFooter = GenerarGUId();
                  string rptFooterTmp = oReporteBE.PathLocalDestino + EasyUtilitario.Constantes.Caracteres.BackSlash + GuidRPTFooter + ".rpt";
                  File.Copy(oReporteBE.SourceRpt, rptFooterTmp, overwrite: true);
                  oReporteBE.SourceRpt = rptFooterTmp;//Reeplaza el nombre del archivo base por el tempral generado para ser incrustado


                string PathUrlFooter = CrystalGeneraPdf(oReporteBE, ds);
                  //----------------------------Fin Footer---------------------------------------------------


                  //-----------------------------------Init File Report Final con Merge----------------------------------------------------------
                  oReporteBE.GUID = GenerarGUId();
                  string ReportFileFinal = oReporteBE.IdReporte + "_" + oReporteBE.getNomFileGenerado();
                  string FilePDFReport =  oReporteBE.PathLocalDestino + "\\" + ReportFileFinal;
                  string[] lst = new string[2] { oReporteBE.PathLocalDestino + "\\" + NomFileRpt, oReporteBE.PathLocalDestino + "\\" + PathUrlFooter };
                  MergePdf(FilePDFReport, lst);
                   Array.Resize(ref lst, 3);
                   lst[2] = oReporteBE.SourceRpt;
                  //Elimanalst los temporales
                  foreach (string f in lst)
                  {
                      File.Delete(f);
                  }
                //-----------------------------------FinFile Report Final con Merge----------------------------------------------------------
               
                #endregion

                string PathUrl = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRptHttp") +  oReporteBE.UserName + "/" + ReportFileFinal;

                context.Response.Write("{Estado:'OK',Descripcion:'Completado',PathFile:'" + PathUrl + "'}");
                terminoOK = true;
                context.Response.Flush();
                // context.Response.End();
                HttpContext.Current.ApplicationInstance.CompleteRequest();//Se utriliza en lugar de context.Response.End(), para evitar conflito de tareas

            }
            catch (Exception ex) {
                if (terminoOK == false)
                {
                    DataObjeto += "ERROR:=" + ex.Message;
                    context.Response.Write("{Estado:'ERROR',Descripcion:'" + DataObjeto + "',PathFile:'GenerarPdf.aspx/ProcessRequest'}");
                    context.Response.Flush();
                    HttpContext.Current.ApplicationInstance.CompleteRequest(); ;
                }
            }
        }

        


        public ReporteBE PefildelReporte(int IdReporte,string UserName) {
            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            DataTable dtInfoReport = ogReports.ListarInformacionReporte(IdReporte.ToString(), UserName);
            DataRow drInfo = dtInfoReport.Rows[0];

            ReporteBE oReporteBE = new ReporteBE();
            oReporteBE.SourceRpt = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFileSourceRpts") + drInfo["Ref1"].ToString();
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

        public string GenerarGUId() {
            Guid miGuid = Guid.NewGuid();
            string token = miGuid.ToString().Replace("-", string.Empty);
            return token; 
        }

        // public string CrystalGeneraPdf(string IdReporte,string ReportSource,string UserName, string NombFileGenerado, string FileExtension,DataSet ds) {
        public string CrystalGeneraPdf(ReporteBE oReporteBE, DataSet ds)
        {
            string Linea = "";
            string NombreArchivo = oReporteBE.getNomFileGenerado();
            string NombreArchivoEncript = GenerarGUId(); 
            string RutayArchivo= oReporteBE.PathLocalDestino + "\\" + NombreArchivo;
            
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
                crExportOptions.ExportFormatType = ((oReporteBE.Extension.ToUpper().Equals(".PDF")) ? ExportFormatType.PortableDocFormat : ExportFormatType.Excel);
                /*---------------------------*/

                _rpt.Export();
            }
            catch (Exception ex) {
                NombreArchivo = "Error.pdf";
                CrearPdfDefault(oReporteBE.PathLocalDestino + "\\" + NombreArchivo, ex.Message + "\n" + Linea);
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

        public void PrintPrevio(int IdReporte, string NombreNuevo,string UserName, DataSet ds, params object[] LstCtrl)
        {
            ReporteBE oReporteBE = PefildelReporte(IdReporte, UserName);
            string NomFileRpt = (new GenerarPdf()).CrystalGeneraPdf(oReporteBE, ds);
            string FileRpt = oReporteBE.UserName + "[.]" + NombreNuevo;

            if (File.Exists(oReporteBE.PathLocalDestino + "\\" + NombreNuevo)){
                File.Delete(oReporteBE.PathLocalDestino + "\\" + NombreNuevo);
            }
            System.IO.File.Move(oReporteBE.PathLocalDestino +"\\" + NomFileRpt, oReporteBE.PathLocalDestino +"\\" + NombreNuevo);          

           // EasyUtilitario.Helper.Pagina.DEBUG(FileRpt);
            PrintPrevio(oReporteBE.Nombre, oReporteBE.Descripcion, FileRpt, LstCtrl);            
        }

        public void PrintPrevio(int IdReporte,string UserName, DataSet ds, params object[] LstCtrl) {
            try
            {
                ReporteBE oReporteBE = PefildelReporte(IdReporte, UserName);
                string NomFileRpt = (new GenerarPdf()).CrystalGeneraPdf(oReporteBE, ds);
                string FileRpt = oReporteBE.UserName + "[.]" + NomFileRpt;
                //EasyUtilitario.Helper.Pagina.DEBUG(FileRpt);
                PrintPrevio(oReporteBE.Nombre, oReporteBE.Descripcion, FileRpt, LstCtrl);
            }
            catch(Exception ex) {
                
                    
            }
        }
        public void PrintPrevio(string Titulo,string Descripcion, string HttpPathReport, params object[] LstCtrl) {
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
        public void PrintPrevio(string Titulo, string HttpPathReport,string ConfigSeccion,string ConfigKey, params object[] LstCtrl)
        {
            string FileRpt = this.UsuarioLogin +"[.]" + HttpPathReport;
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



        public Dictionary<string,string>  CrearArchivo(int IdReporte, string UserName, DataSet ds) {
            ReporteBE oReporteBE = PefildelReporte(IdReporte, UserName);
            string NomFileRpt = (new GenerarPdf()).CrystalGeneraPdf(oReporteBE, ds);
            string FileRpt = oReporteBE.UserName + "/" + NomFileRpt;

            Dictionary<string, string> DataBE = new Dictionary<string, string>();
            DataBE.Add("PathLocal", oReporteBE.PathLocalDestino);
            DataBE.Add("NombreGenerado", NomFileRpt);
            DataBE.Add("PathBasico", FileRpt);
            DataBE.Add("PathHTTPBase", EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRptHttp"));
            DataBE.Add("PathHTTPBaseUsr", EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRptHttp")+"/"+ oReporteBE.UserName);
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




        public string CrearHome(string UserName) {
            string PathBase = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRpt");
            string path = PathBase +  UserName;
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

        void CrearPdfDefault(string NombreFile,string msg) {

            Document document = new Document(PageSize.A6.Rotate(), 5, 5, 5, 5);

            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(NombreFile, FileMode.Create, FileAccess.Write, FileShare.None));

            document.Open();

            document.AddTitle("Mi primer PDF");
            document.AddCreator("Rosales Azabache Eddy");

            document.Add(new Paragraph("ERROR:" + msg));

            document.Close();
            writer.Close();
        }

        void demopdf() {

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