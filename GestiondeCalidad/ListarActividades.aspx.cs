using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.Filtro;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using SIMANET_W22R.Exceptiones;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class ListarActividades : PaginaCalidadBase, IPaginaBase
    {
        EasyMessageBox oeasyMessageBox = new EasyMessageBox();

        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarJScript();
                    this.LlenarDatos();
                    this.LlenarGrilla();
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
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                DataTable dt = oCalidad.ListarProyectosActividadSIMA( this.IdProyecto, this.UsuarioLogin);

                EasyGridViewActividades.DataSource = dt;
                EasyGridViewActividades.DataBind();
            }
            catch (Exception ex)
            {
                string dd = "ss";
            }
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            TxtUserName.Style.Add("display", "none");
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

        protected void EasyGridViewActividades_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
            }
        }
    }
}