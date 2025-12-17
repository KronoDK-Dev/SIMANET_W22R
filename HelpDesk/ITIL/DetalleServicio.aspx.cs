using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionReportes;
using SIMANET_W22R.srvITIL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.ITIL
{
    public partial class DetalleServicio : HelpDeskBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarDatos();
                this.LlenarJScript();
            }
            catch (Exception) { 
            }
        }

        protected void EasyForm1_CommitTransaccion(EasyControlWeb.Form.Controls.EasyButton oEasyButton, EasyControlWeb.Form.EasyFormDataBE oEasyFormDataBE)
        {
            int i = 0;
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
            if (this.ModoPagina == EasyControlWeb.EasyUtilitario.Enumerados.ModoPagina.M) {
               ServicioBE oServicioBE =   (new GestiondeConfiguracionSoapClient()).ServicioDetalle(this.IdServicio, this.UsuarioLogin);
                this.EasyFormDetalleSrv.SetValue("aucServicio", oServicioBE.Nombre, oServicioBE.IdServicioProducto);
                this.EasyFormDetalleSrv.SetValue("chkInterno", ((oServicioBE.Interno)==1?true:false));
                this.EasyFormDetalleSrv.SetValue("chkSrvProd", ((oServicioBE.Producto) == 1 ? true: false));
                this.EasyFormDetalleSrv.SetValue("txtDescrip", oServicioBE.Descripcion);
            }
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            ServicioBE oServicioBE = new ServicioBE();
            this.EntityInJavascriptFromServer(oServicioBE.GetType());
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