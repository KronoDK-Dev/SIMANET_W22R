using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvProyectos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class DetalleProyecto : PaginaCalidadBase, IPaginaMantenimento,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.LlenarDatos();
                this.CargarModoPagina();    
                
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
            ProyectoBE oProyectoBE=(new ProyectosSoapClient()).DetalleProyectosSIMA("0", this.UsuarioLogin);
            EasyAcBuscarProy.SetValue(oProyectoBE.Nombre, oProyectoBE.IdProyecto.ToString());
            EasyACCodigo.SetValue(oProyectoBE.CodigoProy, oProyectoBE.CodigoProy);
            ddlLineNegocio.SetValue("", oProyectoBE.IdLN.ToString());
            EasyAcCliente.SetValue(oProyectoBE.ClienteRazonSocial, oProyectoBE.IdCliente.ToString());
            txtDescripcion.Text = oProyectoBE.Descripcion;
        }

        public void CargarModoNuevo()
        {
           
        }


        public void CargarModoPagina()
        {
            switch (this.ModoPagina)
            {
                case EasyUtilitario.Enumerados.ModoPagina.N:
                    this.CargarModoNuevo();
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
            ddlLineNegocio.LoadData();
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