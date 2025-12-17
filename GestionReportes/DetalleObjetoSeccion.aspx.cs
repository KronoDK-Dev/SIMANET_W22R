using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionReportes
{
    public partial class DetalleObjetoSeccion : ReporteBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.LlenarDatos();
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
            if (this.IdTipoObjeto == 9) {//TipoParmetro
                this.txtParametro.Text= this.NombreParam;
                this.txtParametro.ReadOnly = true;
                this.txtNombre.Text = this.NombreObjeto;
                if(this.ModoPagina==EasyUtilitario.Enumerados.ModoPagina.M){
                    this.txtDescripcion.Text = this.Descripcion;
                }
            }
            else{
                if (this.ModoPagina == EasyUtilitario.Enumerados.ModoPagina.N)
                {
                    this.txtParametro.Text = this.NombreParam;
                }
                else
                {
                    this.txtParametro.Text = this.NombreParam;
                    this.txtNombre.Text = this.NombreObjeto;
                    this.txtDescripcion.Text = this.Descripcion;
                }
                trParam.Attributes.Add("style", "display:none");

            }
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
    }
}