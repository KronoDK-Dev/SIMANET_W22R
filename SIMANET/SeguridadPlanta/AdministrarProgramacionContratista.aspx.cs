using DocumentFormat.OpenXml.Drawing.Charts;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO.Packaging;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Windows.Media.Media3D;
using static EasyControlWeb.EasyUtilitario.Enumerados;

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

        protected void EasyPopInfoGen_Click(Dictionary<string, object> DataBE)
        {
            this.LlenarGrilla("");
        }

        protected void EasyGestorFiltro1_ProcessCompleted(string FiltroResultante, List<EasyFiltroItem> lstEasyFiltroItem)
        {
            this.LlenarGrilla(FiltroResultante);
        }

        protected void EasyGRContrata_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
            switch (oEasyGridButton.Id)
            {
                case "btnEliminar":
                    EliminarProgramacion(Convert.ToInt32(Recodset["Periodo"]), Convert.ToInt32(Recodset["NroProgramacion"]));
                    this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
                    break;
            }

        }

        void EliminarProgramacion(int Periodo,int IdProgramacion) {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "ProgramacionContratista_Del";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Periodo";
            oParam.Paramvalue = Periodo.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroProgramacion";
            oParam.Paramvalue = IdProgramacion.ToString();
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
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

           string rsult= odi.SendData();
        }

        protected void EasyPopupTrabEqui_Click(Dictionary<string, object> DataBE)
        {
            this.LlenarGrilla("");
            
        }

        protected void EasyPopupCopiar_Click(Dictionary<string, object> DataBE)
        {
            Dictionary<string ,string> drBE= EasyGRContrata.getDataItemSelected();
            string ProgNew = CopiarProgramacion(drBE["Periodo"].ToString(), drBE["NroProgramacion"].ToString());
            string []PerProg = ProgNew.Split('-');
            Modificar(PerProg[0].ToString(), PerProg[1].ToString(),DataBE);

            this.LlenarGrilla("");
        }

        void Modificar(string Periodo,string IdProgramacion, Dictionary<string, object> oDataBE) {
            EasyBaseEntityBE oEasyBaseEntityBE = (new DetalleProgramacion()).CargarDetalle(IdProgramacion, Periodo);


            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "ProgramacionContratista_act";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroProgramacion";
            oParam.Paramvalue = IdProgramacion;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Periodo";
            oParam.Paramvalue = Periodo;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdEntidad";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("IdEntidad");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdJefeProyecto"; 
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("IdJefeProyecto");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroRegistroIngreso";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("NroRegistroIngreso");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam); 

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroDocumentodeRef";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("NroDocumentodeRef");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "FechaInicio";
            oParam.Paramvalue = oDataBE["FechaIni"].ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "FechaTermino";
            oParam.Paramvalue = oDataBE["FechaFin"].ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "HoraInicio";
            oParam.Paramvalue = oDataBE["HoraIni"].ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "HoraTermino";
            oParam.Paramvalue = oDataBE["HoraFin"].ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdCIASeguros";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("IdCIASeguros");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "FechaInicioPoliza";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("FechaInicioPoliza");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;            
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "FechaTerminoPoliza";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("FechaTerminoPoliza");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroPensionPoliza";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("NroPensionPoliza");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroSaludPoliza";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("NroSaludPoliza");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "TrabajosARealizar";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("TrabajosARealizar");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdLugardeTrabajo";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("IdLugardeTrabajo");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NombreNave";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("NombreNave");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NombreContacto";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("NombreContacto");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Observaciones";
            oParam.Paramvalue = oEasyBaseEntityBE.GetValue("Observaciones");
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = this.UsuarioId.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            string result = odi.SendData();


        }


        string CopiarProgramacion(string Periodo,string IdProgramacion) {

            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "CopiarProgramacion";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Periodo";
            oParam.Paramvalue = Periodo;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroProgramacion";
            oParam.Paramvalue = IdProgramacion;
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
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            string result = odi.SendData();

            return result;
        }
    }
}
