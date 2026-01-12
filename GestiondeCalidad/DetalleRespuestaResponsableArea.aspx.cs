using EasyControlWeb;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.General;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class DetalleRespuestaResponsableArea : PaginaCalidadBase,IPaginaMantenimento,IPaginaBase
    {
        string scriptDefEstado = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                     this.CargarModoPagina();
                     this.LlenarJScript();
                    //Graba en el Log la acción ejecutada
                    /*   LogAplicativo.GrabarLogAplicativoArchivo(new LogAplicativo(CNetAccessControl.GetUserName(), "Secretaria - Directorio", this.ToString(), "Se consultó las Actas de Sesión de Directorio.", Enumerados.NivelesErrorLog.I.ToString()));
                    */
                    

                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
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
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                ResponsableAreaDetalleBE oResponsableAreaDetalleBE = oCalidad.DetallePorReponsabledeAreaRpt(this.IdDetalleRepuestaResposableArea, this.UsuarioLogin);
                this.txtFechaRpt.Text = oResponsableAreaDetalleBE.FechaRpta.ToShortDateString();
                this.txtFechaEnvio.Text = oResponsableAreaDetalleBE.FechaEnvio.ToShortDateString();
                this.txtFechaLectura.Text = oResponsableAreaDetalleBE.FechaLectura.ToShortDateString();
                this.txtAnotacion.Text = oResponsableAreaDetalleBE.Observacion;
                this.ImgEstadoAct.Attributes["src"] = oResponsableAreaDetalleBE.ImgEstado;
                this.ImgEstadoAct.Attributes["IdEstado"] = oResponsableAreaDetalleBE.IdEstado.ToString();
                this.lblEstado.Text= oResponsableAreaDetalleBE.NombreEstado;

                scriptDefEstado= this.GetPageName() + ".IdEstado="+ oResponsableAreaDetalleBE.IdEstado.ToString();
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }

        }

        public void CargarModoNuevo()
        {
            txtFechaRpt.Text = DateTime.Now.ToShortDateString();

            DataRow dr= (new TablasGenerales()).ListarItems("687", this.UsuarioLogin).Select("Codigo='1'")[0];//Selecciona el registro de estado inicial

            this.ImgEstadoAct.Attributes["src"] = dr["var5"].ToString();
            this.ImgEstadoAct.Attributes["IdEstado"] = dr["Codigo"].ToString();
            this.lblEstado.Text = dr["var1"].ToString();

            scriptDefEstado = this.GetPageName() + ".IdEstado=" + dr["Codigo"].ToString(); ;
        }

        public void CargarModoPagina()
        {
            switch (this.ModoPagina)
            {
                case EasyUtilitario.Enumerados.ModoPagina.N:
                    CargarModoNuevo();
                    break;
                case EasyUtilitario.Enumerados.ModoPagina.M:
                    CargarModoModificar();
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
            //Registra el estado del registro
            Page.Controls.Add(new LiteralControl("<script>\n" + scriptDefEstado + "</script>\n"));
           
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