using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using iTextSharp.text.pdf;
using iTextSharp.text;
using SIMANET_W22R.Controles;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.GestionReportes;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvSeguridad;
using System.Net;
using System.Drawing;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.Form.Templates;


namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class AdministrarContratista : SeguridadPlantaBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarDatos();
                    this.LlenarJScript();
                    this.LlenarGrilla("");

                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
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

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            try
            {
                /*EasyDataInterConect odi = new EasyDataInterConect();
                odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
                odi.UrlWebService = "/SeguridadPlanta/Contratista.asmx";
                odi.Metodo = "ProgramacionContratista_lst";


                    EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = "NroProgramacion";
                    oParam.Paramvalue = "0";
                    oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                    oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
                odi.UrlWebServicieParams.Add(oParam);

                    oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = "Periodo";
                    oParam.Paramvalue = "0";
                    oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                    oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
                odi.UrlWebServicieParams.Add(oParam);



              oParam = new EasyFiltroParamURLws();
              oParam.ParamName = "IdUsuario";
              oParam.Paramvalue = this.UsuarioId.ToString();
              oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
              oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
              odi.UrlWebServicieParams.Add(oParam);



              oParam = new EasyFiltroParamURLws();
              oParam.ParamName = "IdTipoProgramacion";
              oParam.Paramvalue ="0";
              oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
              oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
              odi.UrlWebServicieParams.Add(oParam);



              oParam = new EasyFiltroParamURLws();
                    oParam.ParamName = "UserName";
                    oParam.Paramvalue = this.UsuarioLogin;
                    oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                    oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
                odi.UrlWebServicieParams.Add(oParam);

                */



                /* EasyGridContratista.DataInterconect = odi;

                 EasyGridContratista.LoadData();*/


                

            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;

                this.LanzarException(NombreMetodo, ex);
            }
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