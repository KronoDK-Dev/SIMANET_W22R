using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIMANET_W22R.HelpDesk.BandejaEntrada;
using System.Data;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.HelpDesk.Requerimiento;
using EasyControlWeb.Form.Base;
using SIMANET_W22R.GestionReportes;

namespace SIMANET_W22R.HelpDesk.Atencion
{
    public partial class AdministrarAtenciondeRequerimiento : HelpDeskBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!Page.IsPostBack)
                {
                    this.RegistrarLib(Page.Header, TipoLibreria.Style, (new AdministrarReporte()).StyleBase, true);
                    this.RegistrarLib(Page.Header, TipoLibreria.Script, (new AdministrarReporte()).ScriptBase, true);
                    this.LlenarGrilla();
                }
            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;

                this.LanzarException(NombreMetodo, ex);
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
            throw new NotImplementedException();
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {
            EasyGridView1.DataInterconect = ObtenerDatos("0");
            EasyGridView1.LoadData();
        }
        EasyDataInterConect ObtenerDatos(string IdRqrPadre)
        {
            EasyDataInterConect odic = new EasyDataInterConect();
            odic.ConfigPathSrvRemoto = "PathBaseWSCore";
            odic.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odic.UrlWebService = "/HelpDesk/AdministrarHD.asmx";
            odic.Metodo = "RequerimientoAsignados_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdPersonal";
            oParam.Paramvalue = this.DatosUsuario.CodPersonal;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);
            return odic;
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            throw new NotImplementedException();
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

        protected void EasyGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                e.Row.Cells[2].Controls.Add((new AdministrarAtencion()).HTMLSolicitante(dr));
                e.Row.Cells[4].Controls.Add((new AdministrarAtencion()).ControlPath(dr["PATHSERVICE"].ToString()));

                EasyProgressbarBase oEasyProgressBar = new EasyProgressbarBase();
                oEasyProgressBar.Progreso = Convert.ToInt32(dr["PORCAVANCE"].ToString());
                e.Row.Cells[7].Controls.Add(oEasyProgressBar);
                //Buscar Codigo de Personal que registro el requerimiento

                Image oImagen = new Image();
                oImagen.Attributes["src"] = dr["CMEDIA"].ToString();
                oImagen.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "AdministrarAtenciondeRequerimiento.CambiarEstado()";
                e.Row.Cells[8].Controls.Add(oImagen);

                //Responsables de atencion
                e.Row.Cells[6].Style.Add("padding-left", "20px");
                e.Row.Cells[6].Style.Add("padding-top", "8px");
                e.Row.Cells[6].Controls.Add((new AdministrarAtencion()).HtmlResponsable(dr["ID_REQU"].ToString()));


            }
        }

        protected void EasyGridView1_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            switch (oEasyGridButton.Id)
            {

                case "btnAgregarRqr":
                    oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                    oEasyNavigatorBE.Texto = "Detalle de Requerimiento";
                    oEasyNavigatorBE.Descripcion = "Registro de requerimiento";
                    oEasyNavigatorBE.Pagina = "/HelpDesk/Requerimiento/DetalleRequerimiento.aspx";

                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarAtenciondeRequerimiento.KEYIDREQUERIMIENTO, "0"));
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarAtenciondeRequerimiento.KEYIDREQUERIMIENTOPADRE, Recodset["ID_REQU"]));
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.N.ToString()));
                    this.IrA(oEasyNavigatorBE, EasyGridView1);
                    break;
                case "btnActividad":
                    oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                    oEasyNavigatorBE.Texto = "Plan de Trabajo";
                    oEasyNavigatorBE.Descripcion = "Plan de Trabajo";
                    oEasyNavigatorBE.Pagina = "/HelpDesk/Atencion/AdministrarPlandeTrabajo.aspx";

                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarAtenciondeRequerimiento.KEYIDREQUERIMIENTO, Recodset["ID_REQU"]));
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarAtenciondeRequerimiento.KEYIDPERSONAL, this.DatosUsuario.CodPersonal));
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarAtenciondeRequerimiento.KEYIDRESPONSABLEATE, Recodset["ID_RESP_ATE"]));
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarAtenciondeRequerimiento.KEYIDUSUARIOREQ, Recodset["IDUSUARIOREQ"]));
                    this.IrA(oEasyNavigatorBE, EasyGridView1);
                    break;

            }
        }

        protected void EasyGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            LlenarGrilla();
        }
    }
}