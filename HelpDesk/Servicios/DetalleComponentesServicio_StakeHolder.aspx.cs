using EasyControlWeb;
using EasyControlWeb.Filtro;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Servicios
{
    public partial class DetalleComponentesServicio_StakeHolder : HelpDeskBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LlenarGrilla();
        }

        public void LlenarGrilla()
        {
            this.EasyGridView1.DataInterconect.ConfigPathSrvRemoto = "PathBaseWSCore";
            this.EasyGridView1.DataInterconect.UrlWebService = "/HelpDesk/ITIL/GestiondeConfiguracion.asmx";
            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws
            {
                ParamName = "IdServProd",
                Paramvalue = Page.Request.Params["IdServicio"],
                ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo,
                TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String
            };
            this.EasyGridView1.DataInterconect.UrlWebServicieParams.Add(oParam);
            EasyFiltroParamURLws oParamUser = new EasyFiltroParamURLws
            {
                ParamName = "UserName",
                Paramvalue = this.UsuarioLogin,
                ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo,
                TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String
            };
            this.EasyGridView1.DataInterconect.UrlWebServicieParams.Add(oParamUser);

            EasyGridView1.LoadData();
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
            throw new NotImplementedException();
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