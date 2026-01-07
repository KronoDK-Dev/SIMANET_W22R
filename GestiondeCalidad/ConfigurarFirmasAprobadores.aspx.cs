using EasyControlWeb;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class ConfigurarFirmasAprobadores : PaginaCalidadBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarJScript();
                    this.LlenarDatos();
                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
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
            string backslash = "\\";
            this.txtPathFirma.Text = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "CalidadPathFirma").Replace(backslash, ".");
            this.imgUpLoad.Src = EasyUtilitario.Constantes.ImgDataURL.ImgLoadUp;
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
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble.ToString();
            this.txtPathFirma.Style.Add("display", "none");


            UsuarioBE oUsuarioBE = (new SeguridadSoapClient()).GetDatosUsuario(this.UsuarioId);

            string PathImgFirmas = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "CalidadHttpFirma");
            string Pagina = this.GetPageName();
          
            string FormCreateVar = @"setTimeout(function(){
                                                    " + Pagina + @".PathImagenFirmas = '" + PathImgFirmas + @"';
                                                    SIMA.Utilitario.Constantes.ImgDataURL.IconEnEspera=" + cmll + EasyUtilitario.Constantes.ImgDataURL.IconEnEspera + cmll + @";
                                            }, 500);";

            Page.RegisterClientScriptBlock("PathImgFirma", "<script>\n" + FormCreateVar + "\n" + "</script>");


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