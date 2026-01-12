using EasyControlWeb;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIMANET_W22R.Controles;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.Filtro;
using SIMANET_W22R.GestionReportes;
using System.Data;
using EasyControlWeb.InterConeccion;
using static SIMANET_W22R.Controles.Header;
using System.Text;
using System.Web.UI.HtmlControls;


namespace SIMANET_W22R.HelpDesk.ITIL
{
    public partial class BaseServioAreaDisponibles : HelpDeskBase, IPaginaBase
    {
       


        protected void Page_Load(object sender, EventArgs e)
        {
            /*
             this.RegistrarLib(Page.Header,TipoLibreria.Style,(new AdministrarReporte()).StyleBase, true);
             this.RegistrarLib(Page.Header, TipoLibreria.Script, (new AdministrarReporte()).ScriptBase, true);
             */

            int idx = 0;
            EasyTabItem oTab = null;
            foreach (DataRow dr in ObtenerAreas().Rows)
            {


                oTab = new EasyTabItem();
                oTab.Id = "SA" + dr["COD_AREA"].ToString();
                oTab.Text = dr["NOM_AUS"].ToString();
                oTab.TipoDisplay = TipoTab.UrlLocal;
                oTab.Value = "/HelpDesk/Requerimiento/ListarServicioXAreaRQR.aspx";
                oTab.DataCollection = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);
                if (idx == 0)
                {
                    oTab.Selected = true;
                    oTab.AccionRefresh = false;
                }


                EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
                oParam.ParamName = BaseServioAreaDisponibles.KEYIDAREA;
                oParam.Paramvalue = dr["COD_AREA"].ToString();
                oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);
                EasyTabAreas.LoadSilent = true;
                EasyTabAreas.TabCollections.Add(oTab);
            }
        }

        DataTable ObtenerAreas() {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
            odi.Metodo = "Servicios_ListarAreas";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdContact";
            oParam.Paramvalue = this.IdContacto;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetDataTable();
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
    }
}