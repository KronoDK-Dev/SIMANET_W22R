using EasyControlWeb;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIMANET_W22R.Controles;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.Filtro;
using SIMANET_W22R.GestionReportes;

namespace SIMANET_W22R.HelpDesk.ITIL
{
    public partial class AdministrarServicios : HelpDeskBase, IPaginaBase
    {
       /* public string[,] StyleBase
        {
            get
            {
                return new string[1, 2]{
                                            { "cssTree", EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/zTreeStyle.css" }
                                        };

            }
        }

        public string[,] ScriptBase
        {
            get
            {
                return new string[3, 2]{
                                         { "jsTree",  EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.core.js"}
                                        ,{ "jsTree2",EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.exedit.js"}
                                        ,{ "jsTree3", EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.excheck.js"}
                                       };

            }
        }*/

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

        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                Header.RegistrarLibs(Page.Header, Header.TipoLib.Style, (new AdministrarReporte()).StyleBase, true);
                Header.RegistrarLibs(Page.Header, Header.TipoLib.Script, (new AdministrarReporte()).ScriptBase, true);
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }
        }

        protected void EasyToolBarAdm_onClick(EasyControlWeb.Form.Controls.EasyButton oEasyButton)
        {


            switch (oEasyButton.Id)
            {
                case "btnActividad":
                    EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                    oEasyNavigatorBE.Texto = "Detalle de Actividad";
                    oEasyNavigatorBE.Descripcion = "Definición de procedimiento";
                    oEasyNavigatorBE.Pagina = "/HelpDesk/ITIL/AdministrarActividadProcedimiento.aspx";
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.N.ToString()));
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarServicios.KEYIDACTIVIDAD, "2024-1"));


                    this.IrA(oEasyNavigatorBE);
                    break;
                default:
                    break;
            }




        }
    }
}