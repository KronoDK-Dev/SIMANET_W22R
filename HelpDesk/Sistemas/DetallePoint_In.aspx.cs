using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static EasyControlWeb.InterConeccion.EasyDataInterConect;
using System.Security.Cryptography;

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class DetallePoint_In : HelpDeskBase,IPaginaBase, IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try{
                this.LlenarJScript();
                this.CargarModoPagina();
            }
            catch(Exception ex){

            }
        }

        public void Agregar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoConsulta()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            EasyBaseEntityBE oEasyBaseEntityBE = CargarDetalle();
            this.EasyAcBuscarPuntoOut.SetValue(oEasyBaseEntityBE.GetValue("Nombre"), oEasyBaseEntityBE.GetValue("IdElemento"));
            this.EasyTxtDescripcion.SetValue(oEasyBaseEntityBE.GetValue("Descripcion"));
            string fncScriptViewPath = @"<script>
                                             ShowPathSource('" + oEasyBaseEntityBE.GetValue("PathSource") + @"')
                                             DetallePoint_In.IdActividadElemntoOrigen='" + oEasyBaseEntityBE.GetValue("IdActividadOrg") + @"';
                                         </script>
                                        ";
            Page.Controls.Add(new LiteralControl(fncScriptViewPath));
        }
        EasyBaseEntityBE CargarDetalle()
        {
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
            return odi.GetEntity();
        }
        public void CargarModoNuevo()
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

        public void Eliminar()
        {
            throw new NotImplementedException();
        }

        public void Modificar()
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

        public void LlenarJScript()
        {
            this.lblNombreElemento.InnerText = "NOMBRE DE " + this.NombreElemento.ToUpper();
            this.EasyAcBuscarPuntoOut.DataInterconect.UrlWebService = this.PathNetCore + "HelpDesk/Sistemas/GestionSistemas.asmx";
            this.EasyAcBuscarPuntoOut.NroCarIni = 2;
            this.EasyAcBuscarPuntoOut.DataInterconect.MetodoConexion = MetododeConexion.WebServiceExterno;
            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            if (this.IdTipoElemento == "2")//llamada de la opcion punto de ingreso
            {
                this.EasyAcBuscarPuntoOut.DataInterconect.Metodo = "ActividadElementos_Buscar";

                oParam = new EasyFiltroParamURLws();
                oParam.ParamName = "IdActividad";
                oParam.Paramvalue = this.IdActividad;
                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                this.EasyAcBuscarPuntoOut.DataInterconect.UrlWebServicieParams.Add(oParam);

                oParam = new EasyFiltroParamURLws();
                oParam.ParamName = "IdTipoElemento";
                oParam.Paramvalue = "4";//para buscar los items de puntos de salida
                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                this.EasyAcBuscarPuntoOut.DataInterconect.UrlWebServicieParams.Add(oParam);
             
            }
            else {
                this.EasyAcBuscarPuntoOut.DataInterconect.Metodo = "ActividadElementos_Buscar2";
            }
            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            this.EasyAcBuscarPuntoOut.DataInterconect.UrlWebServicieParams.Add(oParam);


           



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