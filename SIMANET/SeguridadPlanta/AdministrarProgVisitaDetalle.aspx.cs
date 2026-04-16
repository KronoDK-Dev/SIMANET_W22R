using EasyControlWeb;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class AdministrarProgVisitaDetalle : PaginaBase  // para usar funcionalidad PathFotosPersonal debe heredarse de PaginaBase
    {


        // PROPIEDADES - PARAMETROS RECIBIDOS DESDE REQUEST
        // =====================================================

        protected string ReqUsuario => Request.Params[AdministrarProgVisita.KEYQUSUARIO];
        protected string ReqIdArea  => Request.Params[AdministrarProgVisita.KEYQIDAREA];
        protected string ReqArea => Request.Params[AdministrarProgVisita.KEYQAREA];
        protected string ReqIdCentroOperativo => Request.Params[AdministrarProgVisita.KEYQCENTROOPERATIVO];
        protected string ReqTipoPrograma => Request.Params[AdministrarProgVisita.KEYQTIPOPROGRAMA];
        protected string ReqTipoVisita => Request.Params[AdministrarProgVisita.KEYQTIPOVISITA];
        protected string ReqPeriodo => Request.Params[AdministrarProgVisita.KEYQPERIODO];


        protected void Page_Load(object sender, EventArgs e)
        {
            DatosIniciales();
        }

        protected void DatosIniciales() {
          try
          {

                eDDLTipoVisita.LoadData(); 
            eDDLTipoVisita.SetValue(ReqTipoVisita);
            acAreaTrab.GetData();
            acAreaTrab.SetValue( ReqArea.ToString(), "2123");
            acAreaTrab.txtText.Text  = ReqArea.ToString();
                /*
                 * para que funciones PathFotosPersonal debe heredarse de PaginaBase
                string Foto = this.PathFotosPersonal + drSol["NRODOCDNI"].ToString() + ".jpg";
                HtmlImage oImg = EasyUtilitario.Helper.HtmlControlsDesign.CrearImagen(Foto, "ms-n2 rounded-circle img-fluid");
                
                */
                dpcFechaIni.Text = DateTime.Now.ToString("dd/MM/yyyy");
                dpcFechaFin.Text = DateTime.Now.ToString("dd/MM/yyyy");
                dtHora.Value = DateTime.Now.ToString("HH:mm");
            }
            catch (Exception ex)
            {
                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);

            }

        }
    }
}