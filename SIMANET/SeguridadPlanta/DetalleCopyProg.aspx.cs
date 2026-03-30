using EasyControlWeb.InterConecion;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class DetalleCopyProg : SeguridadPlantaBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarDatos();
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
            EasyBaseEntityBE oEasyBaseEntityBE = (new DetalleProgramacion()).CargarDetalle(this.IdProgramacion, this.Año);
            this.cellNroProg.InnerText = this.Año + "-" + this.IdProgramacion;
            this.cellRSocial.InnerText = oEasyBaseEntityBE.GetValue("RazonSocial");
            this.CFIni.Text=oEasyBaseEntityBE.GetValue("FechaInicio").Substring(0, 10);
            this.CTimeIni.SetValue(oEasyBaseEntityBE.GetValue("HoraInicio"));
            this.CTimeFin.SetValue(oEasyBaseEntityBE.GetValue("HoraTermino"));

            ViewState["Codigo"] = "erosales";
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