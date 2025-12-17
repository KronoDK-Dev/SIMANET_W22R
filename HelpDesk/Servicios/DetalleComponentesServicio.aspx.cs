using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DocumentFormat.OpenXml.Drawing.Charts;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.InterfaceUI;

namespace SIMANET_W22R.HelpDesk.Servicios
{
    public partial class DetalleComponentesServicio : HelpDeskBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LlenarJScript();
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
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

        public void LlenarJScript()
        {
            EasyTabItem oTab = new EasyTabItem();

            oTab.Id = "Elem1";
            oTab.Text = "Actividades";
            oTab.TipoDisplay = TipoTab.UrlLocal;
            oTab.Value = "/HelpDesk/Servicios/DetalleComponentesServicio_Actividad.aspx";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdServicio";
            oParam.Paramvalue = this.IdServicio;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;

            oTab.UrlParams.Add(oParam);

            oTab.DataCollection = "";
            oTab.Selected = true;

            EasyTabControlServicio.TabCollections.Add(oTab);

            oTab = new EasyTabItem();
            oTab.Id = "Elem2";
            oTab.Text = "Areas";
            oTab.TipoDisplay = TipoTab.UrlLocal;
            oTab.Value = "/HelpDesk/Servicios/DetalleComponentesServicio_Area.aspx";

            EasyFiltroParamURLws oParam2 = new EasyFiltroParamURLws();
            oParam2.ParamName = "IdServicio";
            oParam2.Paramvalue = this.IdServicio;
            oParam2.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam2.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;

            oTab.UrlParams.Add(oParam2);

            oTab.DataCollection = "";

            EasyTabControlServicio.TabCollections.Add(oTab);

            oTab = new EasyTabItem();
            oTab.Id = "Elem3";
            oTab.Text = "StakeHolder";
            oTab.TipoDisplay = TipoTab.UrlLocal;
            oTab.Value = "/HelpDesk/Servicios/DetalleComponentesServicio_StakeHolder.aspx";

            EasyFiltroParamURLws oParam3 = new EasyFiltroParamURLws();
            oParam3.ParamName = "IdServicio";
            oParam3.Paramvalue = this.IdServicio;
            oParam3.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam3.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;

            oTab.UrlParams.Add(oParam3);

            oTab.DataCollection = "";

            EasyTabControlServicio.TabCollections.Add(oTab);
        }

        public void RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }

        public bool ValidarDatos()
        {
            throw new NotImplementedException();
        }
    }
}