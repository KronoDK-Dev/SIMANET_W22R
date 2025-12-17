using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb;
using SIMANET_W22R.General;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EasyControlWeb.Form.Controls;
using System.IO.Packaging;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class DetalleAcciones : GobernanzaBase, IPaginaBase,IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarCombos();
                this.CargarModoPagina();
            }
            catch (Exception ex)
            {
                int i = 0;
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

        public void Agregar()
        {
            throw new NotImplementedException();
        }

        public void Modificar()
        {
            throw new NotImplementedException();
        }

        public void Eliminar()
        {
            throw new NotImplementedException();
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

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            DataTable dt = (new DetalleObjetivo()).ListarTodos(this.IdTablaGeneralRel, this.IdTablaGeneralItemsRel, this.UsuarioLogin);
            foreach (DataRow dr in dt.Rows) {
                if ((dr["IDTBL"].ToString() == this.IdTablaGeneral) && (dr["IDITEM"].ToString() == this.IdTablaGeneralItems)) {
                    this.SetData(dr);
                    this.txtCodigo.SetValue(dr["CODIGO"].ToString());
                    this.txtNombre.SetValue(dr["NOMBRE"].ToString());
                    this.txtDescripcion.SetValue(dr["DESCRIPCION"].ToString());
                }
            }
        }

        public void CargarModoConsulta()
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
    }
}