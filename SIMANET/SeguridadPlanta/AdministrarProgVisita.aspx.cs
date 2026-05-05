using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using Microsoft.ReportingServices.ReportProcessing.ReportObjectModel;
using Org.BouncyCastle.Tls.Crypto.Impl.BC;
using SIMANET_W22R.GestionComercial;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.Caching;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class AdministrarProgVisita : PaginaBase
    {
        string stipoPrg="1";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack) // Cargar datos solo en la primera carga
                {
                    DatosIniciales();
                    LlenarGrilla(""); 
                }
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
            }
        }

        protected void DatosIniciales()
        {
            string s_valor = "";
            string mensaje = "";
            try
            {

                // ****** Datos en duro para carga de controles de pruebas ****
                string sid = "943";
                string suser = "vybanez";
                memoriacache.Guarda2params(sid, suser, minutos: 30);
                //***********************************************************


                // ********** CARGAMOS LAS VARIABLES DE LA URL **********
                // 1) Lee VARIABLES desde la querystring: TipoPrg 
                stipoPrg = Request.QueryString["TipoPrg"];
                int periodo = PaginaBase.Periodo_Actual;

                // 2) Normaliza: si viene vacío o null, pon un valor por defecto (p.ej. "1")
                if (string.IsNullOrWhiteSpace(stipoPrg))   stipoPrg = "1";

                // 3) Asigna a la variable session
                Session["S_TIPOPROGRA"] = stipoPrg;   // <-- clave que usará el filtro
                Session["S_PERIODO"] = periodo;   // <-- clave que usará el filtro


                //***********************************************************





                if (eDDLCentros.Items.Count == 0)
                {
                    eDDLCentros.LoadData();
                }
            
            }
            catch (Exception ex)
            {
                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "") + " " + mensaje;
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                this.LanzarException(methodName, ex); // error para el log
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }

        protected void fnRefrescaLN(object sender, EventArgs e)
        {
            try
            {
                if (eDDLCentros.SelectedValue == "3")
                {
                    eDDLUnidadO.Visible = true;
                    lblUO.Visible = true;
                    /*
                    if (eDDLUnidadO.Items.Count <= 1)
                    { eDDLUnidadO.LoadData(); }
                    */
                    eDDLUnidadO.LoadData();
                }
                else
                {
                    eDDLUnidadO.Visible = false;
                    lblUO.Visible = false;
                }
                // limpiamos los otros combox
                eDDLLineas.LoadData();
                eDDLSubLinea.LoadData();
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
        }

        protected void fnRefrescaSLN(object sender, EventArgs e)
        {
            try
            {
                eDDLLineas.LoadData();
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
        }

        protected void FnSublineas(object sender, EventArgs e)
        {
            try
            {
                eDDLSubLinea.LoadData();
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
        }

        private void LlenarGrilla(string strFilter)
        {
            string stitulo = "PROGRAMACIÓN";
            try
            {
              

                switch (stipoPrg)
                {
                    case "1":
                        stitulo = "PROGRAMACIÓN VISITAS GENERALES";
                        break;
                    case "4":
                        stitulo = "PROGRAMACIÓN VISITAS PROVEEDORES - ADMINISTRATIVOS";
                        break;
                    case "5":
                        stitulo = "PROGRAMACIÓN VISITAS CLIENTES";
                        break;
                    case "7":
                        stitulo = "PROGRAMACIÓN VISITAS PROVEEDORES - TÉCNICOS";
                        break;
                    case "8":
                        stitulo = "PROGRAMACIÓN VISITAS ARMADORES";
                        break;
                }
                EGVResultados.TituloHeader = stitulo;
                EGVResultados.LoadData("");
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
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                this.LlenarGrilla("");
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
        }

        protected void EasyGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            this.LlenarGrilla("");
        }

        protected void EGVResultados_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {
            // Botones de accion internos de la grilla para una fila o registro
            try
            {
                // usamos un control de navegación colocando el titulo de la siguiente página y su ruta de la página a abrir
                EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                oEasyNavigatorBE.Texto = "Detalle de Solicitud de Trabajo";
                oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de Solicitudes";
                oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/GenerarSolicitud.aspx";
                // configuramos los parámetros del control de navagacion, colocando el id del registro actual, el modo de edición que tendrá
                oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaBase.KEYQCENTROOPERATIVO, eDDLCentros.SelectedValue.ToString()));
                oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaBase.KEYIDGENERAL, Recodset["nroSolicitud"]));
                oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(BaseComercial.KEYLNNEGOCIO, Recodset["linea"]));
                oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(BaseComercial.KEYCLASETRAB, Convert.ToString(Session["Clase"])));
                oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), "M")); // M = MODIFICAR

                this.IrA(oEasyNavigatorBE, EGVResultados); //EasyGestorFiltro1
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

        }

        protected void EGVResultados_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
            // Botones del panel superior de la GRILLA
            try
            {
                switch (oEasyGridButton.Id)
                {
                    case "btnAgregar":
                        // usamos un control de navegación colocando el titulo de la siguiente página y su ruta de la página a abrir
                        EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                        oEasyNavigatorBE.Texto = "Registo de Solicitud de Trabajo";
                        oEasyNavigatorBE.Descripcion = "Registro de Solicitudes";
                        oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/GenerarSolicitud.aspx";
                        // configuramos los parámetros del control de navagacion, colocando el id del registro actual, el modo de edición que tendrá
                        oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaBase.KEYQCENTROOPERATIVO, eDDLCentros.SelectedValue.ToString()));
                        oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(BaseComercial.KEYLNNEGOCIO, eDDLLineas.SelectedValue.ToString()));       //   KEYLNNEGOCIO = "LnNeg";
                        oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(BaseComercial.KEYSUBLNNEGOCIO, eDDLSubLinea.SelectedValue.ToString())); //   KEYSUBLNNEGOCIO = "SUBLnNeg";
                        oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(BaseComercial.KEYCLASETRAB, Convert.ToString(Session["Clase"])));      //  KEYCLASETRAB = "ClaseT";
                        oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.N.ToString()));
                        oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), "N"));  // N= NUEVO
                        oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaBase.KEYIDGENERAL, "0"));

                        this.IrA(oEasyNavigatorBE, EGVResultados); //EasyGestorFiltro1

                        break;
                    case "btnDetCostos":
                        break;
                    case "btnDetMateriales":
                        break;
                    case "btnImprimir":

                        break;
                }
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
        }

    }


}