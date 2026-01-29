using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb;
using SIMANET_W22R.HelpDesk.ITIL;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.HelpDesk.Requerimiento;
using System.Collections.Specialized;

namespace SIMANET_W22R.HelpDesk.Atencion
{
    public partial class AdministrarPlandeTrabajo : HelpDeskBase,IPaginaBase, IPaginaMantenimento
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                CargarRequerimiento();
                CargarPlan();
            }
            catch (Exception ex)
            {
            }
        }
        public EasyDataInterConect ObtenerPlanPorRequerimiento(string IdRqr) {

            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "PlandeTrabajo_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            oParam.Paramvalue = IdRqr;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            return odi;
        }

        void CargarPlan()
        {
            string cmll = "\"";
            int i=0;
            EasyTabItem oTab = null;
            foreach (DataRow dr in ObtenerPlanPorRequerimiento(this.IdRequerimiento).GetDataTable().Rows)
            {

                oTab = new EasyTabItem();
                oTab.Id = "SH" + dr["ID_PLAN"].ToString();
                string htmlTab = "<table><tr><td>" + dr["NOMBRE"].ToString() + "</td><td onclick=" + cmll + "AdministrarPlandeTrabajo.DetallePlan('" + dr["ID_PLAN"].ToString() + "');" + cmll+"><i class='fa fa-pencil' aria-hidden='true'></i></td></tr></table>";
                oTab.Text = htmlTab;
                oTab.TipoDisplay = TipoTab.UrlLocal;
                oTab.Value = "/HelpDesk/Atencion/AdministraGantt.aspx";
                oTab.DataCollection = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);
                if (i == 0)
                {
                    oTab.Selected = true;
                    oTab.AccionRefresh = false;
                }

                EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = AdministrarPlandeTrabajo.KEYIDREQUERIMIENTO;
                    oParam.Paramvalue = this.IdRequerimiento;
                    oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);

                    oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = AdministrarPlandeTrabajo.KEYIDPERSONAL;
                    oParam.Paramvalue = this.IdPersonal;
                    oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);

                    oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = AdministrarPlandeTrabajo.KEYIDPLANTRABAJO;
                    oParam.Paramvalue = dr["ID_PLAN"].ToString();
                    oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                    oTab.UrlParams.Add(oParam);


                oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = AdministrarPlandeTrabajo.KEYIDRESPONSABLEATE;
                    oParam.Paramvalue = this.IdResponsableAtencion;
                    oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);

                EasyTabPlan.TabCollections.Add(oTab);

                i++;
            }

        }


        void CargarRequerimiento() {
            EasyBaseEntityBE oEasyBaseEntityBE = (new DetalleRequerimiento()).CargarDetalle(this.IdUsuarioRequerimiento,this.IdRequerimiento);
            this.EasytxtTicket.SetValue(oEasyBaseEntityBE.GetValue("NroTicket"));
            HServicioArea.Value = oEasyBaseEntityBE.GetValue("IdServicioArea");
            string[] PathItem = oEasyBaseEntityBE.GetValue("PathServicio").ToString().Split('|');
            List<string> list = PathItem.ToList();
            list.Reverse();
            foreach (string str in list)
            {
                EasyPathItem oEasyPathItem = new EasyPathItem();
                oEasyPathItem.Id = str.Replace(" ", "");
                oEasyPathItem.ClassName = "fa fa-venus-mars";
                oEasyPathItem.Descripcion = "";
                oEasyPathItem.Titulo = str;

                this.EasyPathHistory1.PathCollections.Add(oEasyPathItem);
            }
            this.EasyPathHistory1.PathHome = true;
            this.EasyPathHistory1.TipoPath = PathStyle.Tradicional;
            this.EasyTxtDescripcion.SetValue(oEasyBaseEntityBE.GetValue("Descripcion"));

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

        public void Agregar()
        {
            throw new NotImplementedException();
        }

        public void Modificar()
        {
            throw new NotImplementedException();
        }

        public void Eliminar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoPagina()
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

        public void CargarModoConsulta()
        {
            throw new NotImplementedException();
        }

        public bool ValidarCampos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarCamposRequeridos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarExpresionesRegulares()
        {
            throw new NotImplementedException();
        }
    }
}