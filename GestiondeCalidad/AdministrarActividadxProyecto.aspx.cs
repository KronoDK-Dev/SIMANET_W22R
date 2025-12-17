using EasyControlWeb.Form.Controls;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvProyectos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class AdministrarActividadxProyecto : PaginaCalidadBase, IPaginaBase
    {
        EasyMessageBox oeasyMessageBox;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarDatos();
                    this.LlenarJScript();
                    this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
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
        }

        public void CargarModoNuevo()
        {
        }
        public void CargarModoModificar()
        {
        }
        public int Agregar()
        {
            return 0;
        }
        public int Modificar()
        {
            return 0;
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }
        public void LlenarGrilla(string strFilter)
        {
            try
            {
                DataTable dt = (new ProyectosSoapClient()).ListarProyectosSIMA("0", this.UsuarioLogin);

                DataView dv = dt.DefaultView;
                if (strFilter.Length > 0)
                {
                    dv.RowFilter = strFilter;
                }
                EasyGridView1.DataSource = dv;
                EasyGridView1.DataBind();
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.ErrorDisplay(ex);
            }
        }
        public void LlenarJScript()
        {
        }

        public void RegistrarJScript()
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

        protected void EasyGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
        }

        protected void EasyGestorFiltro1_ProcessCompleted(string FiltroResultante, List<EasyControlWeb.Filtro.EasyFiltroItem> lstEasyFiltroItem)
        {
            this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
        }
    }
}