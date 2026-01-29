using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using iTextSharp.text.pdf.parser;
using SIMANET_W22R.Controles;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.PublicClass;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvGestionReportes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static EasyControlWeb.EasyUtilitario.Enumerados.Configuracion.SeccionKey;
using static EasyControlWeb.EasyUtilitario.Helper;
using static System.Net.WebRequestMethods;

//using iTextSharp.text.pdf.parser;

namespace SIMANET_W22R.GestionReportes
{
    public partial class AdministrarReporte :ReporteBase,IPaginaBase
    {
        public string[,] StyleBase
        {
        //         { "dos","https://www.jqueryscript.net/demo/Powerful-Multi-Functional-jQuery-Folder-Tree-Plugin-zTree/css/zTreeStyle/zTreeStyle.css" }
            get
            {
                return new string[1, 2]{
                                            /*{"uno","https://www.jqueryscript.net/demo/Powerful-Multi-Functional-jQuery-Folder-Tree-Plugin-zTree/css/demo.cssz" }*/
                                            { "cssTree", EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/zTreeStyle.css" }
                                            /*,{ "tres","https://davidsekar.github.io/jQuery-UI-ScrollTabs/css/style.cssz"}*/
                                        };
                
            }
        }

        public string[,] ScriptBase
        {
            //{ "cuatro", "https://www.jqueryscript.net/demo/Powerful-Multi-Functional-jQuery-Folder-Tree-Plugin-zTree/js/jquery.ztree.core-3.5.js"}
            get
            {
                return new string[3, 2]{
                                         { "jsTree",  EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.core.js"}                                         
                                        ,{ "jsTree2",EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.exedit.js"}
                                        ,{ "jsTree3", EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.excheck.js"}
                                       };

            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //Header.RegistrarLibs(Page.Header, Header.TipoLib.Style, this.StyleBase, true);
                //Header.RegistrarLibs(Page.Header, Header.TipoLib.Script, this.ScriptBase, true);
                this.RegistrarLib(Page.Header, PaginaBase.TipoLibreria.Style , this.StyleBase, true);
                this.RegistrarLib(Page.Header, PaginaBase.TipoLibreria.Script, this.ScriptBase, true);

                this.LlenarJScript();
                this.LlenarCombos();
                this.LlenarDatos();
                this.LlenarGrilla();
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
          /*  sglGlobalData oGD = sglGlobalData.GetInstance();
           DataTable dt= oGD.ListarContactos(86);*/

        }

        public void LlenarDatos()
        {
        }

        public void LlenarGrilla()
        {
               
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            ObjetoBE oObjetoBE = new ObjetoBE();
            this.EntityInJavascriptFromServer(oObjetoBE.GetType());

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

        protected void EasyToolBarAdmRPT_onClick(EasyButton oEasyButton)
        {

        }
      

    }
}