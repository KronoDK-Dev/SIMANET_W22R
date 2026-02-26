using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using Microsoft.ReportingServices.ReportProcessing.ReportObjectModel;
using Org.BouncyCastle.Tls.Crypto.Impl.BC;
using SIMANET_W22R.ClasesExtendidas;
using SIMANET_W22R.General;
using SIMANET_W22R.GestionComercial;
using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionSeguridadPlanta;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.Caching;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static EasyControlWeb.EasyUtilitario;


namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class AdministrarProgVisita : PaginaBase
    {
        string stipoPrg="1";
        string sidTipoEntidad = "";
        VisitasSoapClient oVisitas     = new VisitasSoapClient();
        GeneralSoapClient oGeneral     = new GeneralSoapClient();
        SeguridadSoapClient oSeguridad = new SeguridadSoapClient();

        private static string BuildWaitForSwal(string pageName, string methodName, string result)
        {
            // 1) Sanitiza valores para inserción segura en JS (evita romper las comillas)
            var title = "Error";
            var text = $"Página: {pageName} - Método: {methodName}: {result}";
            title = HttpUtility.JavaScriptStringEncode(title);
            text = HttpUtility.JavaScriptStringEncode(text);

            // 2) Devuelve el script
            // Nota: uso string literal normal con \n y triple comillas en C# 11; si no tienes C# 11, usa concatenación con \n.
            var script = @"
                    (function(){
                      var title = '" + title + @"';
                      var text  = '" + text + @"';
                      var icon  = 'error';
                      var waited = 0;
                      var stepMs = 100;
                      var maxMs  = 5000; // espera hasta 5s por SweetAlert2
                      (function tick(){
                        if (window.Swal && typeof Swal.fire === 'function') {
                          Swal.fire(title, text, icon);
                        } else if ((waited += stepMs) < maxMs) {
                          setTimeout(tick, stepMs);
                        } else {
                          // último recurso si nunca cargó
                          alert(title + ' - ' + text);
                        }
                      })();
                    })();
                    ";
                            return script;
        }
        protected void Page_Load(object sender, EventArgs e)
            {
                try
                {
                    if (!IsPostBack) // Cargar datos solo en la primera carga
                    {
                        DatosIniciales();
                        LlenarDatos();
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
                                                                                   // string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";

                    var script = BuildWaitForSwal(pageName, methodName, result);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError_" + Guid.NewGuid(), script, true);

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
                    sidTipoEntidad = Request.QueryString["idTipoEntidad"]; // tipo visitante
                    int periodo = PaginaBase.Periodo_Actual;

                    // 2) Normaliza: si viene vacío o null, pon un valor por defecto (p.ej. "1")
                    if (string.IsNullOrWhiteSpace(stipoPrg))   stipoPrg = "1";

                    // 3) Asigna a la variable session
                Session["S_TIPOPROGRA"] = stipoPrg;
                Session["S_TIPOVISITA"] = sidTipoEntidad;
                Session["S_PERIODO"] = periodo;   


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
                                                                                   // string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                                                                                   // ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);

                    var script = BuildWaitForSwal(pageName, methodName, result);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError_" + Guid.NewGuid(), script, true);

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
                                                                                   // string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                                                                                   // ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);

                    var script = BuildWaitForSwal(pageName, methodName, result);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError_" + Guid.NewGuid(), script, true);

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

                    var script = BuildWaitForSwal(pageName, methodName, result);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError_" + Guid.NewGuid(), script, true);

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
                                                                                   //string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                                                                                   //ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);

                    var script = BuildWaitForSwal(pageName, methodName, result);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError_" + Guid.NewGuid(), script, true);

                }
            }

        private void LlenarGrilla(string strFilter)
            {
                string stitulo = "PROGRAMACIÓN";
                try
                {
                    // 1) Lee VARIABLES desde la querystring: TipoPrg 
                    stipoPrg = Request.QueryString["TipoPrg"];
                    sidTipoEntidad =  Request.QueryString["idTipoEntidad"];

                    switch (stipoPrg)
                    {
                        case "1":

                            switch (sidTipoEntidad)
                            {
                                case "5":
                                    stitulo = "PROGRAMACIÓN VISITAS GENERALES";
                                    break;

                                case "2":
                                    // Ajusta el texto si tu negocio lo llama distinto
                                    stitulo = "PROGRAMACIÓN VISITAS CONTRATISTAS";
                                    break;

                                default:
                                    // fallback si llega otro valor o vacío
                                    stitulo = "PROGRAMACIÓN VISITAS (PERSONAL)";
                                    break;
                            }

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
                    EGVResultados.LoadData(strFilter);
                }
                catch (Exception ex)
                {
                    var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                    result = result.Replace("'", "");
                    string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                    string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    this.LanzarException(methodName, ex); // error para el log
                    Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                                                                                   // string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                                                                                   // ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);

                    var script = BuildWaitForSwal(pageName, methodName, result);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError_" + Guid.NewGuid(), script, true);

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
                                                                                   //ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
                    // (en cada catch)
                    var script = BuildWaitForSwal(pageName, methodName, result);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError_" + Guid.NewGuid(), script, true);

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
                                                                                   // string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                                                                                   // ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);

                    var script = BuildWaitForSwal(pageName, methodName, result);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError_" + Guid.NewGuid(), script, true);

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
                                                                                   //  string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                                                                                   // ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
                    var script = BuildWaitForSwal(pageName, methodName, result);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError_" + Guid.NewGuid(), script, true);
                }
            }

        protected void EasyGestorFiltro1_ProcessCompleted(string FiltroResultante, List<EasyControlWeb.Filtro.EasyFiltroItem> lstEasyFiltroItem)
        { 
            this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
        }

        #region Metodos_version_anterior

        public void LlenarDatos()
        {
            // trae datos del usuario logueado, para mostrar en la parte superior de la página, como el nombre del usuario, su área, etc.
            // visualizacion 
            /* DATOS DEL PATRONIZADOR DE LA VISITA
            /* *****************************************  */

            string sUsuario, sIdArea;
            int iIdCentroOpera;

            // Recuperamos daotos de usuario desde la sesión
            var oUsuario = Session["UserBE"] as UsuarioBE;
            if (oUsuario == null)
            {
                // Si no existe (p.ej., sesión nueva o vencida), recarga desde el backend
                oUsuario = oSeguridad.GetDatosUsuario(this.UsuarioId);
                Session["UserBE"] = oUsuario; // Guarda nuevamente para siguientes usos
            }


            sUsuario = oUsuario.ApellidosyNombres;
            sIdArea = oUsuario.Area;
            iIdCentroOpera = oUsuario.IdCentroOperativo;
            
            //****************
            // tipo visitante
            //****************
            // 1) tipo de entidad (prioriza el parámetro y, si no, la sesión)
            var tipoEntidad = string.IsNullOrWhiteSpace(sidTipoEntidad)?Session["S_TIPOVISITA"] as string: sidTipoEntidad;
                tipoEntidad = tipoEntidad?.Trim();

            // 2) Validación si  hay valor
            if (!string.IsNullOrWhiteSpace(tipoEntidad))
            {
                // 3) Llamar una sola vez al catalogo tipo de visitante
                const string sCatalogoVisitantes = "705";
                string tipoVisitante = oGeneral.Buscar_Var1_DetalleCatologo(sCatalogoVisitantes, tipoEntidad, this.UsuarioId.ToString()  );

            }

            // ***** El control de datos adjuntos solo Se oculta para el caso de tipo de visitante PROVEEDOR.
             if (sidTipoEntidad == "1") // Proveedor
            {
             //   idUpLoad.Style.Add("display", "block");
            }
            else
            {
               // idUpLoad.Style.Add("display", "none");
            }

         //   EAC_Areas.DataInterconect.UrlWebService = this.PathNetCore + "/General/TablasGenerales.asmx";
        }

        public void CargarModoModificar()
        {
            /*
            CCTT_ProgramacionVisitaBE oCCTT_ProgramacionVisitaBE = (CCTT_ProgramacionVisitaBE)(new CCCTT_ProgramacionVisita()).ListarDetalleDescripcion(Convert.ToInt32(Page.Request.Params[KEYQIDPROG]), Convert.ToInt32(Page.Request.Params[KEYQPERIODO]), this.TipoProgramacion);

            this.Image1.ImageUrl = System.Configuration.ConfigurationSettings.AppSettings[Utilitario.Constantes.RUTAFOTOSP].ToString() + '/' + oCCTT_ProgramacionVisitaBE.NroPersonal + ".jpg";
            this.lblUsuario.Text = oCCTT_ProgramacionVisitaBE.UsuarioQueRegistra.ToString();
            this.txtBuscarEntidad.Text = oCCTT_ProgramacionVisitaBE.RazonSocial.ToString();

            this.hidTipoEntidad.Value = oCCTT_ProgramacionVisitaBE.IdTipoEntidad.ToString();
            this.hidEntidad.Value = oCCTT_ProgramacionVisitaBE.IdEntidad.ToString();
            this.txtArea.Text = oCCTT_ProgramacionVisitaBE.NombreArea.ToString();
            this.hidArea.Value = oCCTT_ProgramacionVisitaBE.IdArea.ToString();
            if ((Page.Request.Params[KEYQCOPYPROG] != null) && (Page.Request.Params[KEYQCOPYPROG] == "yes"))
            {
                this.CalFechaInicio.SelectedDate = Convert.ToDateTime(oCCTT_ProgramacionVisitaBE.FechaInicio).AddDays(1);
                this.CalFechaTermino.SelectedDate = Convert.ToDateTime(oCCTT_ProgramacionVisitaBE.FechaTermino).AddDays(1);
            }
            else
            {
                this.CalFechaInicio.SelectedDate = Convert.ToDateTime(oCCTT_ProgramacionVisitaBE.FechaInicio);
                this.CalFechaTermino.SelectedDate = Convert.ToDateTime(oCCTT_ProgramacionVisitaBE.FechaTermino);
            }
            //this.tmHoraInicio.SelectedTime = Convert.ToDateTime(oCCTT_ProgramacionVisitaBE.HoraInicio);

            string[] horaminute = oCCTT_ProgramacionVisitaBE.HoraInicio.Split(':');
            string min = horaminute[1].Substring(0, 2);

            DateTime fecha = new DateTime(oCCTT_ProgramacionVisitaBE.FechaInicio.Year, oCCTT_ProgramacionVisitaBE.FechaInicio.Month, oCCTT_ProgramacionVisitaBE.FechaInicio.Day, Convert.ToInt32(horaminute[0]), Convert.ToInt32(min), 0);
            this.tmHoraInicio.SelectedTime = fecha;

            //this.tmHoraTermino.SelectedTime  = Convert.ToDateTime(oCCTT_ProgramacionVisitaBE.HoraTermino);
            this.txtObservaciones.Text = oCCTT_ProgramacionVisitaBE.Observaciones.ToString();
            this.hidCIASeguros.Value = oCCTT_ProgramacionVisitaBE.IdCIASeguros.ToString();
            this.txtCIASeguros.Text = oCCTT_ProgramacionVisitaBE.NombreCIASeguros.ToString();
            this.txtNroPoliza.Text = oCCTT_ProgramacionVisitaBE.NroPoliza.ToString();
            Session["ESTADOPRG"] = oCCTT_ProgramacionVisitaBE.IdEstado.ToString();

            int Periodo = Convert.ToInt32(Page.Request.Params[KEYQPERIODO]);
            int NroProg = Convert.ToInt32(Page.Request.Params[KEYQIDPROG]);
            CtrlDestino(Periodo, NroProg);
            CtrlAnexos(Periodo, NroProg);

            this.hFechaInicio.Value = Convert.ToDateTime(oCCTT_ProgramacionVisitaBE.FechaInicio).ToString("dd-MM-yyyy");
            this.hFechaTermino.Value = Convert.ToDateTime(oCCTT_ProgramacionVisitaBE.FechaTermino).ToString("dd-MM-yyyy");
            */
        }

        #endregion 
    }


}