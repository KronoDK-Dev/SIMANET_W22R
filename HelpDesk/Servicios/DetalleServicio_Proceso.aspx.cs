using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvSeguridad;

namespace SIMANET_W22R.HelpDesk.Servicios
{
    public partial class DetalleServicio_Proceso : HelpDeskBase, IPaginaBase, IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //LlenarCombos();
                CargarModoPagina();
            }
            catch (Exception ex)
            {
                
            }
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

        EasyBaseEntityBE CargarDetalle()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "Helpdesk/ITIL/GestiondeConfiguracion.asmx";
            odi.Metodo = "ServicioDetalle";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdServicio";
            oParam.Paramvalue = this.IdServicio;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            return odi.GetEntity();
        }

        public void LlenarDatos()
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
            ltTipos.DataInterconect.UrlWebService = this.PathNetCore + "General/General.asmx";
            ltTipos.DataInterconect.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            ltTipos.DataInterconect.Metodo = "ListarTipoHD";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            ltTipos.DataInterconect.UrlWebServicieParams.Add(oParam);

            ltTipos.DataInterconect.GetEntity();

            if (this.ModoPagina == EasyUtilitario.Enumerados.ModoPagina.M)
            {
                this.CargarModoModificar();
            }
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            EasyBaseEntityBE oEasyBaseEntityBE = CargarDetalle();
            this.EasyNombre.SetValue(oEasyBaseEntityBE.GetValue("Nombre"));
            this.txtDescripcion.SetValue(oEasyBaseEntityBE.GetValue("Descripcion"));
            this.ltTipos.SetValue(oEasyBaseEntityBE.GetValue("Interno"));
            if (oEasyBaseEntityBE.GetValue("Producto") == "1")
            {
                chkServicio.Checked = true;
            }
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