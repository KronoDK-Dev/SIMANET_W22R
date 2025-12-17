using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.IO.Packaging;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class DetalleSistema_Proceso : HelpDeskBase,IPaginaBase,IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                
                LlenarCombos();
                CargarModoPagina();
            }
            catch (Exception ex) { 

            }
        }
        public void CargarModoModificar()
        {
            EasyBaseEntityBE oEasyBaseEntityBE = CargarDetalle();
            this.EasyDdLTipo.SetValue(oEasyBaseEntityBE.GetValue("IdNivel"));
            this.EasyNombre.SetValue(oEasyBaseEntityBE.GetValue("Nombre"));
            this.EasyDescripcion.SetValue(oEasyBaseEntityBE.GetValue("Descripcion"));
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
            this.EasyDdLTipo.DataInterconect = this.TablaGeneralItem("50","DBOracle");
            this.EasyDdLTipo.LoadData();
            string []arOP = Page.Request.Params["rmOP"].Split(';');
            foreach (string str in arOP) {
                this.EasyDdLTipo.RemoveItem(str);
            }

        }
        EasyBaseEntityBE CargarDetalle()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
            odi.Metodo = "ListarSistemasyProcesosDet";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdSistema";
            oParam.Paramvalue = this.IdSistemaProcesoAct;
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
            if (this.ModoPagina == EasyUtilitario.Enumerados.ModoPagina.M) {

                this.CargarModoModificar();
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