using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionReportes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionReportes
{
    public partial class DetalleCarpeta :  ReporteBase,IPaginaMantenimento,IPaginaBase
    {
        EasyMessageBox oeasyMessageBox;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarJScript();
                this.CargarModoPagina();

            }
            catch (Exception ex)
            {
                int i = 0;
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
            try
            {
                string Nombre = "";
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                DataTable dt = ogReports.ListarCabeceradeReporte(this.IdObjeto, this.UsuarioLogin);
                DataRow dr = dt.Rows[0];

                this.txtNombreCarpeta.Text = dr["Nombre"].ToString();
                this.txtDescripcionCarpeta.Text = dr["Descripcion"].ToString();

            }
            catch (Exception ex)
            {
                oeasyMessageBox = new EasyMessageBox();
                oeasyMessageBox.ID = "msgb";
                oeasyMessageBox.Titulo = "Detalle de Reporte";
                oeasyMessageBox.Contenido = ex.Message;
                oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                Page.Controls.Add(oeasyMessageBox);

            }
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoPagina()
        {
            switch (this.ModoPagina)
            {
                case EasyUtilitario.Enumerados.ModoPagina.N:
                    break;
                case EasyUtilitario.Enumerados.ModoPagina.M:
                    this.CargarModoModificar();
                    break;
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
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            ObjetoBE oObjetoBE = new ObjetoBE();
            this.EntityInJavascriptFromServer(oObjetoBE.GetType());
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