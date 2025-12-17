using EasyControlWeb.Form.Controls;
using EasyControlWeb;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIMANET_W22R.srvGestionReportes;

namespace SIMANET_W22R.GestionReportes
{
    public partial class UsuarioCompartido : ReporteBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarGrilla();
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
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {

            UserShared.Controls.Add(ListarUsuarios());
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        EasyListView ListarUsuarios()
        {
            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            DataTable dt = ogReports.ListarUsuariosxReporteCompartido(this.IdObjeto, UsuarioLogin);



            EasyListView oListViewInspect = new EasyListView();
            oListViewInspect.TipoItem = TipoItemView.ImagenCircular;
            oListViewInspect.DataComplete.Add("IdUsuario", this.UsuarioId.ToString());

            oListViewInspect.AlertTitulo = "";
            oListViewInspect.AlertMensaje = "";
            oListViewInspect.ID = "LsvUsuariosComp";
            oListViewInspect.ClassName = "BaseItemSecond";
            oListViewInspect.Ancho = "100%";
            //oListViewInspect.FncItemOnCLick = "ListViewInspector_ItemClick";
            //oListViewInspect.FncItemOnMouseMove = "ListViewInspector_ItemMouseMove";
            oListViewInspect.TextAlign = EasyUtilitario.Enumerados.Ubicacion.Izquierda;


            foreach (DataRow drInspect in dt.Rows)
            {
                EasyListItem oEasyListItemInspect = new EasyListItem();
                oEasyListItemInspect = new EasyListItem();
                oEasyListItemInspect.Src = EasyUtilitario.Helper.Configuracion.PathFotos + drInspect["NroDocDni"].ToString() + ".jpg";
               // oEasyListItemInspect.Value = drInspect["IdUsuario"].ToString();
                oEasyListItemInspect.Text = drInspect["ApellidosyNombres"].ToString();
                Dictionary<string, string> dc = new Dictionary<string, string>();
                //dc.Add("IdPersonal", drInspect["IdPersonal"].ToString());
                oEasyListItemInspect.DataComplete = dc;
                oListViewInspect.ListItems.Add(oEasyListItemInspect);
            }
            return oListViewInspect;
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

       
    }
}