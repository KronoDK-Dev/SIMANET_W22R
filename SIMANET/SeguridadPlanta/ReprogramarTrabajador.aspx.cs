using DocumentFormat.OpenXml.Drawing.Charts;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class ReprogramarTrabajador : SeguridadPlantaBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarDatos();
            }
            catch (Exception ex) { }
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
            EasyBaseEntityBE oEasyBaseEntityBE = CargarDetalle();

            this.rpNombreTrab.InnerText = oEasyBaseEntityBE.GetValue("ApellidosyNombres");
            rpFIni.Text = oEasyBaseEntityBE.GetValue("FechaInicio").Substring(0, 10);
            rpFFin.Text = oEasyBaseEntityBE.GetValue("FechaTermino").Substring(0,10);
            rpHIni.SetValue(oEasyBaseEntityBE.GetValue("HoraInicio"));
            rpHFin.SetValue(oEasyBaseEntityBE.GetValue("HoraTermino"));

        }

        public EasyBaseEntityBE CargarDetalle()
        {

            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "ReProgramarTrabajador_Det";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Periodo";
            oParam.Paramvalue = this.Año;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroProgramacion";
            oParam.Paramvalue = this.IdProgramacion;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroDNI";
            oParam.Paramvalue = this.NroDocumento;
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