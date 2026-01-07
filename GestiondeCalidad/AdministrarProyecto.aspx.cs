using CrystalDecisions.ReportAppServer.DataDefModel;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvProyectos;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class AdministrarProyecto : PaginaCalidadBase,IPaginaBase
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

        public int Agregar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
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
            
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            try
            {

                DataTable dt =  (new ProyectosSoapClient()).ListarProyectosSIMA("0", this.UsuarioLogin);

                DataView dv = dt.DefaultView;
                if (strFilter.Length > 0)
                {
                    dv.RowFilter = strFilter;
                }
                EasyGridProy.DataSource = dv;
                EasyGridProy.DataBind();
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
        }

        public int Modificar()
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

        protected void EasyPopupDetalleProy_Click()
        {
            LlenarGrilla("");
        }

        protected void EasyGridProy_PageIndexChanged(object sender, EventArgs e)
        {
            LlenarGrilla("");
        }
    }
}