using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using DocumentFormat.OpenXml.EMMA;
using EasyControlWeb.InterConecion;

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class DetalleElementos : HelpDeskBase, IPaginaBase,IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                LlenarJScript();
                this.CargarModoPagina();
            }
            catch (Exception ex) { 

            }
        }
        public void CargarModoModificar()
        {
            EasyBaseEntityBE oEasyBaseEntityBE = CargarDetalle();
            this.EasyAcBuscarElementos.SetValue(oEasyBaseEntityBE.GetValue("Nombre"), oEasyBaseEntityBE.GetValue("Id_Elem"));
            this.EasyTxtDescripcion.SetValue(oEasyBaseEntityBE.GetValue("Descripcion"));
        }

        EasyBaseEntityBE CargarDetalle() {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
            odi.Metodo = "ActividadElementos_Detalle";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdActElemento";
            oParam.Paramvalue = this.IdActividadElemento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return  odi.GetEntity();
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
            this.lblNombreElemento.InnerText = "NOMBRE DE "  + this.NombreElemento.ToUpper();
            this.EasyAcBuscarElementos.DataInterconect.UrlWebService = this.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
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
            if (this.ModoPagina == EasyControlWeb.EasyUtilitario.Enumerados.ModoPagina.M)
            {
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