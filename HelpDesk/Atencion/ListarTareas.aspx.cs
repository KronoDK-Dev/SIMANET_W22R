using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EasyControlWeb.InterConecion;

namespace SIMANET_W22R.HelpDesk.Atencion
{
    public partial class ListarTareas : HelpDeskBase, IPaginaBase,IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!Page.IsPostBack)
                {
                    this.LlenarCombos();
                    this.LlenarDatos();
                    this.CargarModoPagina();
                }
            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;

                this.LanzarException(NombreMetodo, ex);
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
            eddlTask.CargaInmediata = true;
            eddlTask.DataInterconect = ListarTareasdeActividad();
            eddlTask.DataValueField = "ID_ACCION";
            eddlTask.DataTextField = "NOMBRETAREA";
            eddlTask.LoadData();
        }
        public EasyDataInterConect ListarTareasdeActividad()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/ITIL/GestiondeConfiguracion.asmx";
            odi.Metodo = "ProcedimientoListarTareaPorActividad";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdActividad";
            oParam.Paramvalue = this.IdActividad;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi;
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
            if (ModoPagina == EasyUtilitario.Enumerados.ModoPagina.N)
            {
                this.CargarModoNuevo();
            }
            else
            {
                this.CargarModoModificar();
            }
        }

        public void CargarModoNuevo()
        {
            range3.Value = "0";
        }
        public EasyBaseEntityBE CargarDetalle(string IdItemCronograma, string IdTarea)
        {

            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "PlandeTrabajoTareas_Det";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdItem";
            oParam.Paramvalue = IdItemCronograma;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTarea";
            oParam.Paramvalue = IdTarea;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            return odi.GetEntity();
        }


        public void CargarModoModificar()
        {
            EasyBaseEntityBE oEasyBaseEntityBE = CargarDetalle(this.IdActividadCronograma, this.IdTareaItemCronograma);

            eddlTask.SetValue(oEasyBaseEntityBE.GetValue("IdAccionTarea"));
            EasyAccion.SetValue(oEasyBaseEntityBE.GetValue("Descripcion"));
            range3.Value = oEasyBaseEntityBE.GetValue("Avance");
            //EasyProgressAvance.SetValue(Convert.ToInt32(oEasyBaseEntityBE.GetValue("Avance")));


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