using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using EasyControlWeb;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static SIMANET_W22R.GestionReportes.GenerarPdf;
using SIMANET_W22R.srvGestionReportes;
using static EasyControlWeb.EasyUtilitario.Enumerados.Configuracion.SeccionKey;
using Aspose.Cells;



namespace SIMANET_W22R.GestionReportes
{
    public partial class AdministrarMapeoCampos : ReporteBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Exportar();
                this.LlenarDatos();
                this.LlenarJScript();
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }

        }

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
            /*Workbook wb = new Workbook();

            // Cuando crea un nuevo Workbook, se agrega una "Hoja1" predeterminada al Workbook.
            Worksheet sheet = wb.Worksheets[0];

            // Accede a la celda "A1" de la hoja.
            Cell cell = sheet.Cells["A1"];

            // Ingrese el "¡Hola mundo!" texto en la celda "A1".
            cell.PutValue("Hello World!");

            // Guarde el Excel como archivo .xlsx.
            wb.Save("C:\\AppWebs\\AppTest\\Archivos\\Excel.xlsx", SaveFormat.Xlsx);

            */

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
            MapeoCampos(this.IdObjeto, EasyUtilitario.Helper.Pagina.PathSite(), this.Param("ParamRpt"), this.UsuarioLogin);
        }

        public void MapeoCampos(int IdReporte, string UrlApp, string ParamRpt, string UserName)
        {
            GenerarPdf oGenerarPdf = new GenerarPdf();

            EasyDataInterConect oEasyDataInterConect = new EasyDataInterConect();
            EasyFiltroParamURLws oParam;
            //Inicia la Instancia de los datos del reporte
            ReporteBE oReporteBE = new ReporteBE();
            oReporteBE = oGenerarPdf.PefildelReporte(IdReporte, UserName);
            oEasyDataInterConect.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceInterno;//Agregado 08-03-2024
            oEasyDataInterConect.UrlWebService = oReporteBE.WebService;
            oEasyDataInterConect.Metodo = oReporteBE.Metodo;

            string[] ObjetosParam = ParamRpt.Replace("[", "{").Replace("]", "}").Replace("|", ":").Replace(";", ",").Split('@');//Formato:{Parametro:valor,etc..}@

            object[] param = new object[ObjetosParam.Length]; int i = 0;

            foreach (string objParam in ObjetosParam)
            {

                Dictionary<string, string> oEntity = EasyUtilitario.Helper.Data.SeriaizedDiccionario(objParam);
                string ParamValue = oEntity[oEntity.Keys.ElementAt(0)];

                //modelo de trama:={param1:17844,FiltroText:Nombre Proyecto,FiltroValor:CONSTRUCCION DE EMBARCACION PESQUERA "GRACIELA" 400 M3 BOD PROY 093,TipoDato:String}

                switch ((TiposdeDatos)System.Enum.Parse(typeof(TiposdeDatos), oEntity["TipoDato"].ToString()))
                {
                    case TiposdeDatos.String:
                        param[i] = ParamValue;
                        break;
                    case TiposdeDatos.Int:
                        param[i] = Convert.ToInt32(ParamValue);
                        break;
                    case TiposdeDatos.Double:
                        param[i] = Convert.ToDouble(ParamValue);
                        break;
                }
                i++;
            }

            DataSet ds = new DataSet();
            string PathApp = UrlApp + oEasyDataInterConect.UrlWebService;
            object objResult = EasyWebServieHelper.InvokeWebService(PathApp, "", oEasyDataInterConect.Metodo, param);

            if (objResult.GetType() == typeof(DataSet))
            {
                ds = (DataSet)objResult;
            }
            else
            {
                System.Data.DataTable dt = (System.Data.DataTable)objResult;
                ds.Tables.Add(dt);
            }

            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;

            int idtbl = 0;
            int idCL = 0;
            Dictionary<string, string> dicData = new Dictionary<string, string>();
            string Icono = "";
            string Check = "";
            //Datos configurados del rpt
            System.Data.DataTable dtField = (new AdministrarReportesSoapClient()).MapearDatosListarTodos(this.IdObjeto, this.UsuarioLogin);

            string dataBE = "{IdDataField:'0'}";
            string scriptDataTree = @"[{ id: -1, name:" + cmll + "Data Explore" + cmll + ",open: true, iconSkin:" + cmll + "pIcon01" + cmll + @", noR: true,Data:" + cmll + dataBE + cmll + ", children:[";
            if (ds.Tables.Count > 0)
            {
                foreach (System.Data.DataTable dt in ds.Tables)
                {
                    //Buscar 
                    dicData = FindItem(dtField, dt.TableName);
                    dataBE = EasyUtilitario.Helper.Data.SeriaizedDiccionario(dicData).Replace(cmll, "'");
                    idCL = 0;
                    Check = "false";
                    if (dicData["IdDataField"].ToString() != "")
                    {
                        Check = ((dicData["IdEstado"].ToString() == "0") ? "false" : "true");
                    }
                    scriptDataTree += ((idtbl == 0) ? "" : ",") + " {id: " + cmll + dt.TableName + cmll + " ,checked:" + Check + ", pId: -1, name: " + cmll + dt.TableName + cmll + ", open: false, noR: true, isParent: true,IdTipo:1,Data:" + cmll + dataBE.Replace("[", "{").Replace("]", "}") + cmll + ",children:[ ";
                    foreach (DataColumn dc in dt.Columns)
                    {
                        dicData = FindItem(dtField, dc.ColumnName);
                        dataBE = EasyUtilitario.Helper.Data.SeriaizedDiccionario(dicData).Replace(cmll, "'");
                        Icono = "SIMA.Utilitario.Constantes.ImgDataURL.IconField2";
                        Check = "false";
                        if (dicData["IdDataField"].ToString() != "")
                        {
                            Icono = ((dicData["IdEstado"].ToString() == "0") ? "SIMA.Utilitario.Constantes.ImgDataURL.IconField2" : "SIMA.Utilitario.Constantes.ImgDataURL.IconFieldFx"); ;
                            Check = ((dicData["IdEstado"].ToString() == "0") ? "false" : "true");
                        }
                        scriptDataTree += ((idCL == 0) ? "" : ",") + " {id: " + cmll + dc.ColumnName + cmll + ",checked:" + Check + ", pId: " + cmll + dt.TableName + cmll + ", icon: " + Icono + " , name: " + cmll + dc.ColumnName + cmll + ",IdTipo:2,Data:" + cmll + dataBE.Replace("[", "{").Replace("]", "}") + cmll + " }";

                        idCL++;
                    }
                    scriptDataTree += "]}";
                    idtbl++;
                }
                scriptDataTree += "]}";
                scriptDataTree = "arrData= " + scriptDataTree + "];";
                Page.Controls.Add(new LiteralControl("<script>" + scriptDataTree + ";AdministrarMapeoCampos.Navigator.Init();</script>"));
            }
        }

        Dictionary<string, string> FindItem(System.Data.DataTable dtContent, string Nombre)
        {
            Dictionary<string, string> DataBE = new Dictionary<string, string>();
            DataRow[] drFind = dtContent.Select("Nombre ='" + Nombre + "'");
            if (drFind.Length > 0)
            {
                DataRow drExist = drFind[0];
                foreach (DataColumn dc in dtContent.Columns)
                {
                    DataBE.Add(dc.ColumnName, drExist[dc.ColumnName].ToString());
                }
            }
            else
            {
                foreach (DataColumn dc in dtContent.Columns)
                {
                    DataBE.Add(dc.ColumnName, "");
                }
            }
            return DataBE;
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
            ObjetoMapeoExportBE oObjetoMapeoExportBE = new ObjetoMapeoExportBE();
            this.EntityInJavascriptFromServer(oObjetoMapeoExportBE.GetType());
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
    }
}