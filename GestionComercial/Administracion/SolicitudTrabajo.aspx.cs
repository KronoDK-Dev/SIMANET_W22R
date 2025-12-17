using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.srvGestionComercial;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionComercial.Administracion
{
    public partial class SolicitudTrabajo : PaginaBase
    {
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack) // Cargar datos solo en la primera carga
                {
                    DatosIniciales();
                    LlenarGrilla("");
                    //    RegistrarScriptCheckEnter(); // Llama al método que registra el script  

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

        private void LlenarGrilla(string strFilter)
        {
            try
            {
                EGVsolicitudes.LoadData("");
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

        protected void EasyGestorFiltro1_ProcessCompleted(string FiltroResultante, List<EasyFiltroItem> lstEasyFiltroItem)
        {
            this.LlenarGrilla(FiltroResultante);
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

        protected void DatosIniciales()
        {
            string s_valor = "";
            string mensaje = "";
            try
            {
                if (eDDLCentros.Items.Count == 0)
                {
                    eDDLCentros.LoadData();

                    if (eDDLCentros.Items.Count > 0)
                    {
                        //------- COLOCAMOS DATOS POR DEFECTO SEGUN USUARIO ---
                        if (this.DatosUsuario.NroCentroOperativo.ToString() == null)
                        {
                            eDDLCentros.SelectedIndex = 1; // cargamos el primer registro para la busqueda del control asociado
                        }
                        else
                        {
                            if (this.DatosUsuario.NroCentroOperativo.ToString() != "9")
                            { eDDLCentros.SelectedValue = this.DatosUsuario.NroCentroOperativo.ToString(); } // cargamos para lo que tienen un solo centro
                            else
                            { eDDLCentros.SelectedIndex = 1; } // linea para los que tienen acceso a varios centros operativos
                        }

                        if (eDDLCentros.Items.Count > 1)
                        {
                            //*****************UNIDAD OPERATIVA *****************
                            if (eDDLUnidadO.Items.Count == 0)
                            {
                                eDDLUnidadO.LoadData(); // cargamos la unidad operativa
                                if (new[] { "2", "3" }.Contains(eDDLCentros.SelectedValue))
                                {
                                    eDDLUnidadO.Visible = true; // visualizamos unidad operativa para chimbote e iquitos 
                                    lblUO.Visible = true;
                                    // CARGA DATA DE UNIDAD OPERATIVA ASIGNADA
                                    dt = (new SolicitudSoapClient()).Lista_lineas_Usuario(this.DatosUsuario.Login, this.DatosUsuario.Login);
                                    if (dt != null)
                                    {
                                        if (dt.Rows.Count >= 1) // total de accesos
                                        {
                                            // unidad operativa
                                            if (dt.Rows[0][4] != DBNull.Value && !string.IsNullOrEmpty(dt.Rows[0][4].ToString()))
                                            {
                                                eDDLUnidadO.SelectedValue = dt.Rows[0][4].ToString();
                                            }
                                        }
                                    }


                                }
                                else
                                {
                                    eDDLUnidadO.Visible = false;
                                    lblUO.Visible = false;
                                    // seleccionaremos por defecto callao
                                    if (eDDLUnidadO.Items.Count > 1)
                                    { eDDLUnidadO.SelectedIndex = 1; }

                                }
                            }
                            //***************** LINEAS DE NEGOCIO *****************
                            // existe registro de centros
                            eDDLLineas.LoadData();
                            if (eDDLLineas.Items.Count > 0)
                            {
                                //--------- BUSQUEDA DE LINEAS NEGOCIO ASIGNADA A USUARIO, esto en la tabla 11g de usuario_linea
                                dt = (new SolicitudSoapClient()).Lista_lineas_Usuario(this.DatosUsuario.Login, this.DatosUsuario.Login);
                                if (dt != null)
                                {
                                    if (dt.Rows.Count >= 1) // total de accesos
                                    {
                                        eDDLLineas.SelectedValue = dt.Rows[0][0].ToString(); // igualamos la linea
                                        // clase
                                        if (dt.Rows[0][1] != DBNull.Value && !string.IsNullOrEmpty(dt.Rows[0][1].ToString()))
                                        {
                                            if (!new[] { "A", "M" }.Contains(dt.Rows[0][4].ToString().Trim()))
                                            {
                                                // Personalizacion de búsqueda ---
                                                etbCriterio.Text = "CLASE> " + dt.Rows[0][1].ToString();
                                                Session["Clase"] = dt.Rows[0][1].ToString();
                                            }
                                        }
                                        // sublinea
                                        s_valor = dt.Rows[0][3].ToString();
                                        eDDLSubLinea.SelectedValue = s_valor;
                                    }
                                    else
                                    {
                                        mensaje = "No cuenta con Linea de Negocio Asignada";
                                    }

                                    //*********** SUBLINEA ******
                                    eDDLSubLinea.LoadData();
                                    if (eDDLSubLinea.Items.Count > 0 && dt.Rows.Count > 0)
                                    {
                                        if (string.IsNullOrEmpty(s_valor))
                                        { eDDLSubLinea.SelectedValue = dt.Rows[0][0].ToString(); } // igualamos lalinea
                                    }
                                    else
                                    {
                                        mensaje = mensaje.Trim() + ", No cuenta con Linea de Negocio Asignada";
                                    }

                                }
                                //--------------------- 
                            }
                        }
                    }
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

        protected void EGVsolicitudes_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {
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

                this.IrA(oEasyNavigatorBE, EGVsolicitudes); //EasyGestorFiltro1
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

        private void RegistrarScriptCheckEnter()
        {
            // Obtén el ID de cliente de btnBuscar y usa literales para insertarlo en el script
            string btnBuscarClientId = btnBuscar.ClientID;
            string script = $@"
                <script type='text/javascript'>
                    function checkEnter(event) {{
                        if (event.keyCode === 13) {{ // 13 es el código de la tecla Enter
                            document.getElementById('{btnBuscarClientId}').click();
                            event.preventDefault(); // Evita que el Enter genere un salto de línea
                        }}
                    }}
                </script>";

            // Registra el script para que se incluya en la página
            ClientScript.RegisterStartupScript(this.GetType(), "checkEnterScript", script, false);
        }

        protected void EGVsolicitudes_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
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

                        this.IrA(oEasyNavigatorBE, EGVsolicitudes); //EasyGestorFiltro1

                        break;
                    case "btnInfoRel":
                        break;
                    case "btnEliminar":
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
    }
}