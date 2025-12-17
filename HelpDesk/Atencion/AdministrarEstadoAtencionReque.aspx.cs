using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Atencion
{
    public partial class AdministrarEstadoAtencionReque : HelpDeskBase,IPaginaBase,IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try {
                this.LlenarJScript();
                this.CargarModoPagina();
            }
            catch (Exception ex){ }
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
            this.ImgEstado.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconFind.ToString();
            this.ImgEstado.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] ="AdministrarEstadoAtencionReque.PopupEstados()";
            this.hIdestado.Style.Add("display", "none");

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
            if (this.ModoPagina == EasyUtilitario.Enumerados.ModoPagina.M)
            {
                this.CargarModoModificar();
            }
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        DataTable DetalleAprobacion(){
                EasyDataInterConect odi = new EasyDataInterConect();
                odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
                odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
                odi.Metodo = "RequerimientoResponsableAtencionEst_Lst";

                EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
                oParam.ParamName = "IdResponsableAtencion";
                oParam.Paramvalue = this.IdResponsableAtencion;
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
            DataRow dr = DetalleAprobacion().Rows[0];
            this.EasyTxtEstado.SetValue(dr["abrev"].ToString());
            this.EasyTxtObsEstado.SetValue(dr["DESCRIPCION"].ToString());
            this.hIdestado.SetValue(dr["IDESTADO"].ToString());
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