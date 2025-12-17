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
    public partial class ListarReposanbleAprobacion : PaginaCalidadBase, IPaginaBase
    {
        EasyMessageBox oeasyMessageBox = new EasyMessageBox();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    //this.LlenarJScript();
                    //this.LlenarDatos();
                    //this.LlenarGrilla();
                }
            }
          /*  catch (HttpException ex)
            {
                this.LanzarException(ex);
            }*/
            catch (SIMAExceptionSeguridadAccesoForms ex2)
            {
                this.LanzarException(ex2);
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
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {
          
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            throw new NotImplementedException();
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

        protected void EasyGridViewAprobadores_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
            }
        }
    }
}