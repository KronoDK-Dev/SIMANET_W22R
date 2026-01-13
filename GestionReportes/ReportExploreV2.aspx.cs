using Aspose.Cells;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.Controles;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.WebRequestMethods;
using ClosedXML.Excel;
using Newtonsoft.Json;
using EasyControlWeb.InterConecion;

namespace SIMANET_W22R.GestionReportes
{
    public partial class ReportExploreV2 : ReporteBase,IPaginaBase
    {
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
            this.ibtn.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconExcel.ToString();
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



        protected void prExportarExcel(object sender, ImageClickEventArgs e)
        {

            
            EasyDataInterConect oEasyDataInterConect = (EasyDataInterConect)Session["objRpt"] ;
            string UrlApp = EasyUtilitario.Helper.Pagina.PathSite();// (string)Session["UrlApp"] ;
            
            // traemos la data
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

            ExportDataTableToExcel(ds);

        }

        public void ExportDataTableToExcel(DataSet ds)
        {
            int iHojas=0;
            iHojas = ds.Tables.Count;
            DataTable my_dataTable = new DataTable();
            if (iHojas == 1) 
            {
                 my_dataTable = ds.Tables[0];
            }
            

            using (var workbook = new XLWorkbook())
            {
                // Capturar la fecha actual del sistema
                DateTime dfecha = DateTime.Now;
                string sfecha = dfecha.ToString().Replace("/","_").Replace(":","-")  ;

                if (iHojas == 1)
                {
                    var worksheet = workbook.Worksheets.Add("Datos_Sima");
                    worksheet.Cell(1, 1).InsertTable(my_dataTable);
                }
                else // para varias tablas
                {
                    for (int i = 1; i <= iHojas; i++) 
                    {
                        var worksheet = workbook.Worksheets.Add("Datos_Sima"+ iHojas  );
                        worksheet.Cell(1, 1).InsertTable(ds.Tables[i-1]);
                    }
                    
                }


                // Configuración del Response para descargar el archivo
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=RpExcel_"+ sfecha+".xlsx");
                using (var memoryStream = new System.IO.MemoryStream())
                {
                    workbook.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }

    }
}