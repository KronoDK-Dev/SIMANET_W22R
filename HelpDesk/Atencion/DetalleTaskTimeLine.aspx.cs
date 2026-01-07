using EasyControlWeb;
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
    public partial class DetalleTaskTimeLine : HelpDeskBase,IPaginaBase, IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarCombos();
                this.CargarModoPagina();
            }
            catch (Exception ex) { 
            }

        }
        public void Agregar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoConsulta()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            foreach (DataRow dr in  (new AdministrarTaskTimeLine()).ObtenerHistoriadeTarea(this.IdTareaItemCronograma).GetDataTable().Rows)
            {
                if (dr["ID_HISTORY"].ToString().Equals(this.IdTaskItemHistory)) {
                    this.EasyTxtAccionar.SetValue(dr["TITULOACCION"].ToString());
                    this.EasyTxtDescripcionTask.SetValue(dr["DESCRIPCION"].ToString());
                    this.EasyTxtValTiempo.SetValue(dr["VALTIME"].ToString());
                    this.EasyddlTipoAccion.SetValue(dr["IDTIPOACCION"].ToString());
                    this.EasyddlTipoTime.SetValue(dr["IDTIPOTIME"].ToString());
                }
            }
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoPagina()
        {
            if (this.ModoPagina == EasyUtilitario.Enumerados.ModoPagina.M) { 
                this.CargarModoModificar();
            }
        }

        public void Eliminar()
        {
            throw new NotImplementedException();
        }

        public void Modificar()
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

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarCombos()
        {
            this.EasyddlTipoAccion.DataInterconect = this.TablaGeneralItem("72", "DBOracle");
            this.EasyddlTipoAccion.CargaInmediata = true;
            this.EasyddlTipoAccion.LoadData();

            this.EasyddlTipoTime.DataInterconect = this.TablaGeneralItem("37", "DBOracle");
            this.EasyddlTipoTime.CargaInmediata = true;
            this.EasyddlTipoTime.LoadData();


        }

        public void LlenarDatos()
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

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void ConfigurarAccesoControles()
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
    }
}