using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.Controles;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionReportes
{
    public partial class ReportExplore :PaginaBase,IPaginaBase
    {
        public string[,] StyleBase
        {
            get
            {
                return new string[1, 2]{
                                            {"fancytreeCss",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/skin-vista/ui.fancytree.css" }
                                            /*,{ "jquery.ui.all","https://davidsekar.github.io/jQuery-UI-ScrollTabs/css/ui-lightness/jquery.ui.all.css" }
                                            ,{ "ScrollTabs","https://davidsekar.github.io/jQuery-UI-ScrollTabs/css/style.css"}*/
                                        };
            }
        }

        public string[,] ScriptBase
        {
            get
            {
                return new string[2, 2]{ 
                                         { "fancytreeJs", "http://wwwendt.de/tech/fancytree/src/jquery.fancytree.js"}
                                        ,{ "prettifyJs","http://wwwendt.de/tech/fancytree/lib/prettify.js"}
                                        /*,{ "scrolltabs","https://davidsekar.github.io/jQuery-UI-ScrollTabs/js/jquery.ui.scrolltabs.js"}*/
                                       };

            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Header.RegistrarLibs(Page.Header, Header.TipoLib.Style, this.StyleBase, true);
                Header.RegistrarLibs(Page.Header, Header.TipoLib.Script, this.ScriptBase, true);
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
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