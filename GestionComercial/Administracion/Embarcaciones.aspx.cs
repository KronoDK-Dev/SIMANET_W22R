using EasyControlWeb;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionComercial.Administracion
{
    public partial class Embarcaciones : PaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Cargar datos solo en la primera carga
            {
                LlenarGrilla("");
            }
        }

        private void LlenarGrilla(string strFilter)
        {
            //var pr = new Proceso();

            //DataTable dt = pr.ListarSolicitudTrabajo("T", "", "1", "", "01/01/2023", "01/01/2025", "mnunez"); // Reemplaza con el método correcto

            //// Asignar el DataTable al GridView
            //EasyGridView1.DataSource = dt;
            GrillaEmbarcaciones.LoadData("");
        }
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            this.LlenarGrilla("");
        }

        protected void GrillaEmbarcaciones_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {
            var embarcacionid = Recodset["V_EMBARCACION_ID"].ToString();
            Session["V_EMBARCACION_ID"] = embarcacionid;
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            oEasyNavigatorBE.Texto = "Detalle de embarcacion";
            oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de embarcación";
            oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/GenerarEmbarcacion2.aspx";

            this.IrA(oEasyNavigatorBE, GrillaEmbarcaciones);
            //oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("V_CLIENTE_ID", Recodset["V_CLIENTE_ID"]));
            //oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("COD_CLIENTE", Recodset["cod.comercialh"]));
            //oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.M.ToString()));

            /*
            List<EasyNavigatorBE> oEasyNavigatorBElst = new List<EasyNavigatorBE>();
            try
            {
                string s = "";
                oEasyNavigatorBElst = (List<EasyNavigatorBE>)Session[EasyUtilitario.Constantes.Sessiones.Historial];
                foreach (EasyNavigatorBE onbe in oEasyNavigatorBElst)
                {
                    s += onbe.LstCtrlValue;
                }
                SIMAExceptionSeguridadAccesoForms ex = new SIMAExceptionSeguridadAccesoForms(s);
                ErrorDisplay(ex);
            }
            catch (Exception ex)
            {
                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                this.LanzarException(methodName, ex); // error para el log
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
            */


        }
        protected void GrillaEmbarcaciones_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
            switch (oEasyGridButton.Id)
            {
                case "btnAgregar":
                    // usamos un control de navegación colocando el titulo de la siguiente página y su ruta de la página a abrir
                    EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                    oEasyNavigatorBE.Texto = "Generar Embarcacion";
                    oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de Embarcaciones";
                    oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/GenerarEmbarcacion2.aspx";

                    // configuramos los parámetros del control de navagacion, colocando el id del registro actual, el modo de edición que tendrá
                    //verDetalledeInspeccion(EasyUtilitario.Enumerados.ModoPagina.N,"", "");
                    // oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), Modo.ToString()));
                    //oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.N.ToString()));  // N= NUEVO

                    Session["V_EMBARCACION_ID"] = string.Empty;
                    this.IrA(oEasyNavigatorBE, GrillaEmbarcaciones); //EasyGestorFiltro1*/

                    break;
            }
        }
        protected void EasyGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
            this.LlenarGrilla("");
        }
    }
}