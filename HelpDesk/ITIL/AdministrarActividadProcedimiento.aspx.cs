
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Data;
using System.Web.UI.HtmlControls;

namespace SIMANET_W22R.HelpDesk.ITIL
{
    public partial class AdministrarActividadProcedimiento : HelpDeskBase,IPaginaBase
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                LlenarJScript();
            }
            catch (Exception ex) { 

            }
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
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
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