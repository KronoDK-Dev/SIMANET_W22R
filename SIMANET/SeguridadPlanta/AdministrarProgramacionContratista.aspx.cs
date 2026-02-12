using DocumentFormat.OpenXml.Drawing.Charts;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Windows.Media.Media3D;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class AdministrarProgramacionContratista : SeguridadPlantaBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarDatos();
                    this.LlenarJScript();
                    this.LlenarGrilla("");

                    //Graba en el Log la acción ejecutada
                    /*   LogAplicativo.GrabarLogAplicativoArchivo(new LogAplicativo(CNetAccessControl.GetUserName(), "Secretaria - Directorio", this.ToString(), "Se consultó las Actas de Sesión de Directorio.", Enumerados.NivelesErrorLog.I.ToString()));
                    */
                    //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());

                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }

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
          
        }

        public void LlenarGrilla()
        {
          
        }

        public void LlenarGrilla(string strFilter)
        {
              EasyDataInterConect odi = new EasyDataInterConect();
                odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
                odi.UrlWebService = this.PathNetCore + "/SIMANET/SeguridadPlanta/Contratista.asmx";
                odi.Metodo = "ProgramacionContratista_lst";

                    EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = "NroProgramacion";
                    oParam.Paramvalue = "0";
                    oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                    oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
                odi.UrlWebServicieParams.Add(oParam);

                    oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = "Periodo";
                    oParam.Paramvalue = "0";
                    oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                    oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
                odi.UrlWebServicieParams.Add(oParam);

                    oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = "IdUsuario";
                    oParam.Paramvalue = this.UsuarioId.ToString();
                    oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                    oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
                odi.UrlWebServicieParams.Add(oParam);


                    oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = "IdTipoProgramacion";
                    oParam.Paramvalue = "0";
                    oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                    oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
                odi.UrlWebServicieParams.Add(oParam);

                oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = "UserName";
                    oParam.Paramvalue = this.UsuarioLogin;
                    oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                    oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
                odi.UrlWebServicieParams.Add(oParam);

            EasyGRContrata.DataInterconect = odi;
            EasyGRContrata.LoadData();
        }

        public void LlenarJScript()
        {           
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

        protected void EasyGRContrata_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            HtmlTable tbl = new HtmlTable();
            if (e.Row.RowType == DataControlRowType.Header)
            {
                tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, 2);
                tbl.Style.Add("border-collapse", "collapse");
                tbl.Border = 0;
                tbl.Style.Add("width", "100%");
                tbl.Rows[0].Cells[0].InnerText = "FECHA";
                tbl.Rows[0].Cells[0].Align = "center";
                tbl.Rows[0].Cells[0].ColSpan = 2;
                tbl.Rows[0].Cells[1].Style.Add("display", "none");
                

                tbl.Rows[0].Cells[0].Attributes.Add("style", " border-bottom-style: solid;border-bottom-color: white;border-bottom-width: 1px;");

                tbl.Rows[1].Cells[0].InnerText = "INICIO";
                tbl.Rows[1].Cells[0].Align = "center";
                tbl.Rows[1].Cells[0].Style.Add("width", "50%");

                tbl.Rows[1].Cells[1].InnerText = "TERMINO";
                tbl.Rows[1].Cells[1].Align = "center";
                tbl.Rows[1].Cells[1].Attributes.Add("style", "border-Left-style: solid;border-Left-color:gray;border-Left-width: 1px;");
                tbl.Rows[1].Cells[1].Style.Add("width", "50%");

                e.Row.Cells[6].Controls.Add(tbl);
                e.Row.Cells[6].Style.Add("padding", "0");


                //Hora
                tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, 2);
                tbl.Style.Add("border-collapse", "collapse");
                tbl.Border = 0;
                tbl.Style.Add("width", "100%");
                tbl.Rows[0].Cells[0].InnerText = "HORA";
                tbl.Rows[0].Cells[0].Align = "center";
                tbl.Rows[0].Cells[0].ColSpan = 2;
                tbl.Rows[0].Cells[1].Style.Add("display", "none");


                tbl.Rows[0].Cells[0].Attributes.Add("style", " border-bottom-style: solid;border-bottom-color: white;border-bottom-width: 1px;");

                tbl.Rows[1].Cells[0].InnerText = "INICIO";
                tbl.Rows[1].Cells[0].Align = "center";
                tbl.Rows[1].Cells[0].Style.Add("width", "50%");

                tbl.Rows[1].Cells[1].InnerText = "TOLERANCIA";
                tbl.Rows[1].Cells[1].Align = "center";
                tbl.Rows[1].Cells[1].Attributes.Add("style", "border-Left-style: solid;border-Left-color:gray;border-Left-width: 1px;");
                tbl.Rows[1].Cells[1].Style.Add("width", "50%");

                e.Row.Cells[7].Controls.Add(tbl);
                e.Row.Cells[7].Style.Add("padding", "0");



            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
                tbl.Style.Add("border-collapse", "collapse");
                tbl.Border = 0;
                tbl.Style.Add("width", "100%");
                tbl.Rows[0].Style.Add("height", "100%");
                tbl.Rows[0].Cells[0].InnerText = dr["FechaInicio"].ToString().Substring(0,10);
                tbl.Rows[0].Cells[0].Style.Add("width", "50%");

                tbl.Rows[0].Cells[1].Attributes.Add("style", "border-Left-style: solid;border-Left-color:gray;border-Left-width: 1px;");
                tbl.Rows[0].Cells[1].InnerText = dr["FechaTermino"].ToString().Substring(0, 10);
                tbl.Rows[0].Cells[1].Style.Add("width", "50%");
                e.Row.Cells[6].Controls.Add(tbl);
                //HORA
                tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
                tbl.Style.Add("border-collapse", "collapse");
                tbl.Border = 0;
                tbl.Style.Add("width", "100%");
                tbl.Rows[0].Style.Add("height", "100%");
                tbl.Rows[0].Cells[0].InnerText = dr["HoraInicio"].ToString().Substring(0, 10);
                tbl.Rows[0].Cells[0].Style.Add("width", "50%");

                tbl.Rows[0].Cells[1].Attributes.Add("style", "border-Left-style: solid;border-Left-color:gray;border-Left-width: 1px;");
                tbl.Rows[0].Cells[1].InnerText = dr["HoraTermino"].ToString().Substring(0, 10);
                tbl.Rows[0].Cells[1].Style.Add("width", "50%");
                e.Row.Cells[7].Controls.Add(tbl);
            }
        }

        protected void EasyGRContrata_PageIndexChanged(object sender, EventArgs e)
        {
            this.LlenarGrilla("");
        }

        protected void EasyPopInfoGen_Click()
        {
            this.LlenarGrilla("");
        }
    }
}
