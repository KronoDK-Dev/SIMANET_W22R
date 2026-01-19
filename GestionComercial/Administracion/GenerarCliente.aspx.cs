using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.srvCliente;
using SIMANET_W22R.srvGeneral;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionComercial.Administracion
{
    public partial class GenerarCliente : PaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Cargar datos solo en la primera carga
            {
                this.LlenarDatos();
            }
        }

        public void LlenarDatos()
        {
            try
            {
                switch (this.ModoPagina)
                {
                    case EasyUtilitario.Enumerados.ModoPagina.N:
                        CargarModoNuevo();
                        break;
                    case EasyUtilitario.Enumerados.ModoPagina.M:
                        CargarModoModificar();
                        break;
                    case EasyUtilitario.Enumerados.ModoPagina.C:
                        CargarModoNuevo();
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

        protected async void buscarRuc(object sender, EventArgs e)
        {
            string ruc = txtRucDoc.Text;
            string sMensaje = null;
            var data = new
            {
                apiKey = "4cf48612e669cbdc292fd25d5a7ede97",
                dniUsuario = "18099233",
                rucEntidad = ruc
            };

            var response = await MakeHttpRequestAsync(data);

            if (response.IsSuccessStatusCode)
            {
                string jsonResponse = await response.Content.ReadAsStringAsync();

                // Eliminar espacios antes de los dos puntos
                string sanitizedJson = jsonResponse.Replace(" : ", ":");

                // Deserializar el JSON limpio
                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };

                var objeto = System.Text.Json.JsonSerializer.Deserialize<ResponseRuc>(sanitizedJson, options);

                sMensaje = objeto.Mensaje;
                //PROV. CONST. DEL CALLAO

                if (objeto.Status != "404" && objeto.Status != "500")
                {
                    string desc_ubigeo = objeto.Ubigeo.Replace("PROV. CONST. DEL CALLAO", "CALLAO");
                    string cod_ubc = (new GeneralSoapClient()).GetCodUbigeoByDesc(desc_ubigeo);

                    txtRazSoc.Text = objeto.Entidad;
                    txtDireccion.Text = objeto.Direccion;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", $"rellenarCampoPais('{cod_ubc}');", true);
                }
                else
                {
                    Console.WriteLine("Error en la solicitud: " + response.StatusCode);
                    this.LanzarException("buscarRuc()", null);
                    var result = "<br/>" + " " + sMensaje.Replace("\n", "").Replace("\t", "") + response.StatusCode;
                    string scriptSuccess = $"Swal.fire('Error', 'Cliente - buscarRuc(): {result}', 'error');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
                }

            }
            else
            {
                Console.WriteLine("Error en la solicitud: " + response.StatusCode);

                var result = "<br/>" + sMensaje + " " + response.StatusCode;
                string scriptSuccess = $"Swal.fire('Error', 'Cliente - buscarRuc(): {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }

        private async Task<HttpResponseMessage> MakeHttpRequestAsync(object data)
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    // Configura la URL del servidor
                    string url = "http://10.10.90.55:8080/sigedoc/api/pide/getEntidadByPide";

                    // Serializa el objeto de datos a formato JSON
                    string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(data);

                    // Crea el contenido de la solicitud con los datos en JSON
                    var content = new StringContent(jsonData, Encoding.UTF8, "application/json");

                    // Realiza la solicitud POST
                    return await client.PostAsync(url, content);
                }
            }
            catch (Exception ex)
            {
                this.LanzarException("MakeHttpRequestAsync()", ex);
                var result = "<br/>" + ex.Message + " " + ex.InnerException.Message;
                string scriptSuccess = $"Swal.fire('Error', 'Cliente - MakeHttpRequestAsync(): {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);

                // Devuelve una respuesta de error personalizada
                var errorResponse = new HttpResponseMessage
                {
                    StatusCode = System.Net.HttpStatusCode.InternalServerError,
                    ReasonPhrase = "Error en MakeHttpRequestAsync: " + ex.Message
                };
                return await Task.FromResult(errorResponse);
            }

        }

        public class ResponseRuc
        {
            public string Estado { get; set; }
            public string Entidad { get; set; }
            public string Direccion { get; set; }
            public string Ubigeo { get; set; }
            public string Mensaje { get; set; }
            public string Status { get; set; }
        }

        protected void Redirigir(object sender, EventArgs e)
        {
            try
            {
                EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                oEasyNavigatorBE.Texto = "Detalle de cliente";
                oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de cliente";
                oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/GenerarCliente.aspx";

                oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("V_CLIENTE_ID", hdnReload.Value));  // para su uso: Request.QueryString["V_CLIENTE_ID"];
                //oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("COD_CLIENTE", Recodset["cod.comercialh"]));
                oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.M.ToString()));


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

                this.IrA(oEasyNavigatorBE);

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

        protected void ActualizarGrillaContactos(object sender, EventArgs e)
        {
            try
            {
                EasyGridContacto.LoadData("");
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

        protected void EliminarContacto(object sender, EventArgs e)
        {
            try
            {
                string resultado;
                resultado = (new ClienteSoapClient()).EliminarContactoCliente(this.IDCLIENTE, txtIDContacto.Value);

                //Si retorna 1 entonces el contacto fue eliminado satisfactoriamente
                if (resultado == "1")
                {
                    EasyGridContacto.LoadData("");
                    //   ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", "epuContactos.Close();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", $"mensajeEiminarContacto('Contacto eliminado','success');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", $"mensajeEiminarContacto('Error, no se elimino contacto','error');", true);
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

        public void CargarModoNuevo()
        {
            try
            {
                //  UsuarioBE x = new UsuarioBE();
                //  int x = this.DatosUsuario.IdCentroOperativo;
                lblSubtitulo.Text = "Generar Cliente";
                ltTipo.LoadData();
                ltEstado.LoadData();
                ltPais.LoadData();
                ltCiiu.LoadData();

                ltProcedencia.LoadData();
                ltEntidad.LoadData();
                dpFechaRegistro.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtDoc.Visible = false;
                lblDoc.Visible = false;
                EasyGridContacto.Visible = false;

                // VALORES POR DEFECTO   19.12.2024
                ltTipo.SelectedIndex = 2;
                ltEstado.SelectedIndex = 1;
                ltPais.SelectedIndex = 102;
                ltCiiu.SelectedIndex = 4;
                ltDepartamento.LoadData();

                if (txtRucDoc.Visible == true)
                { txtRucDoc.Focus(); }

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

        public void CargarModoModificar()
        {
            string sIDCLIENTE_C;
            string sIDCLIENTE_CH;
            ClienteBE oClienteBE;
            try
            {

                lblSubtitulo.Text = "Modificar Cliente";
                ClienteSoapClient oCliente = new ClienteSoapClient();
                sIDCLIENTE_C = Request.QueryString["COD_UNISYS"];
                sIDCLIENTE_CH = Request.QueryString["COD_COMERCIAL"];

                if (this.IDCLIENTE != null && this.IDCLIENTE.ToString() != "0")
                {
                    oClienteBE = oCliente.ListarClientePorId(this.IDCLIENTE, this.UsuarioLogin);
                }
                else // SI NO OBTUVO EL CODIGO ESTANDARIZADO DE CLIENTE , BUSCAMOS POR EL CODIGO UNISYS
                {
                    oClienteBE = oCliente.ListarClientePorId(sIDCLIENTE_C, this.UsuarioLogin);
                }


                dpFechaRegistro.Enabled = false;
                txt_v_cliente_id.Text = oClienteBE.V_CLIENTE_ID.ToString();
                ltTipo.LoadData();
                ltProcedencia.LoadData();
                ltEntidad.LoadData();
                ltEstado.LoadData();
                ltPais.LoadData();
                ltCiiu.LoadData();
                ltCargo.LoadData();
                ltEnvios.LoadData();
                EasyGridContacto.LoadData("");


                if (Convert.ToInt32(oClienteBE.UBC_GEO.Substring(0, 2)) <= 25)
                {
                    ltPais.SetValue("702701"); //PERÚ
                    ltDepartamento.LoadData();
                    ltDepartamento.SetValue(oClienteBE.UBC_GEO.Substring(0, 2));
                    ltProvincia.LoadData();
                    ltProvincia.SetValue(oClienteBE.UBC_GEO.Substring(0, 4));
                    ltDistrito.LoadData();
                    ltDistrito.SetValue(oClienteBE.UBC_GEO);
                    txtDoc.Visible = false;
                    lblDoc.Visible = false;
                    lblRucDoc.Visible = true;
                    txtRucDoc.Visible = true;
                }
                else
                {
                    ltPais.SetValue(oClienteBE.UBC_GEO);
                    ltDepartamento.Enabled = false;
                    ltProvincia.Enabled = false;
                    ltDistrito.Enabled = false;
                    txtDoc.Visible = true;
                    lblDoc.Visible = true;
                    lblRucDoc.Visible = false;
                    txtRucDoc.Visible = false;
                }
                dpFechaRegistro.Text = oClienteBE.FEC_RGT.ToString("dd/MM/yyyy");
                ltTipo.SetValue(oClienteBE.TIP_CLI);
                ltCiiu.SetValue(oClienteBE.CIIU);
                txtRazSoc.SetValue(oClienteBE.NOM_APS);
                txtDoc.SetValue(oClienteBE.DOCUM_EXT.Trim());
                txtRucDoc.SetValue(oClienteBE.NRO_RUC.ToString().Trim());
                ltProcedencia.SetValue(oClienteBE.COD_PRC.ToString());
                ltEntidad.SetValue(oClienteBE.ENT_CLI);
                txtDireccion.SetValue(oClienteBE.DIR_LGL);
                ltEstado.SetValue(oClienteBE.EST_ATL);
                txtWebsite.SetValue(oClienteBE.TLX1);
                txtRedSocial.SetValue(oClienteBE.TLX2);
                EasyGridContacto.Visible = true;
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

        protected void SeleccionarCombosUbicacion(object sender, EventArgs e)
        {
            string argumentoAdicional = Request["__EVENTARGUMENT"];

            switch (argumentoAdicional.Substring(6, 2))
            {
                case "Pa":
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SeleccionarDepartamento",
                    $"rellenarCampoDepartamento('{argumentoAdicional.Substring(0, 6)}');", true);
                    break;
                case "De":
                    //  ltProvincia.LoadData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SeleccionarDepartamento",
                    $"rellenarCampoProvincia('{argumentoAdicional.Substring(0, 6)}');", true);
                    break;
                case "Pr":
                    ltProvincia.SelectedValue = argumentoAdicional.Substring(0, 4);
                    //   ltDistrito.LoadData();
                    ltDistrito.SelectedValue = argumentoAdicional.Substring(0, 6);
                    //Resaltamos todos los campos que se autocompletaron
                    string script = @"
                           document.getElementById('ltPais').style.borderColor = 'skyblue'; // Cambiar borde a skyblue
                           document.getElementById('ltPais').focus(); // Poner el foco en el campo
                           document.getElementById('ltDepartamento').style.borderColor = 'skyblue'; // Cambiar borde a skyblue
                           document.getElementById('ltDepartamento').focus(); // Poner el foco en el campo 
                           document.getElementById('ltProvincia').style.borderColor = 'skyblue'; // Cambiar borde a skyblue
                           document.getElementById('ltProvincia').focus(); // Poner el foco en el campo
                           document.getElementById('ltDistrito').style.borderColor = 'skyblue'; // Cambiar borde a skyblue
                           document.getElementById('ltDistrito').focus(); // Poner el foco en el campo  
                           document.getElementById('txtRazSoc').style.borderColor = 'skyblue'; // Cambiar borde a skyblue
                           document.getElementById('txtRazSoc').focus(); // Poner el foco en el campo  
                           document.getElementById('txtDireccion').style.borderColor = 'skyblue'; // Cambiar borde a skyblue
                           document.getElementById('txtDireccion').focus(); // Poner el foco en el campo  
                    ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Resaltar", script, true);
                    break;

            }

        }

        //Se ejecuta cada vez que se selecciona un PAIS, se refresca los combos Deapartamento,provicia
        protected void fnRefrescaDptPVC(object sender, EventArgs e)
        {
            try
            {
                if (ltPais.getValue() != "702701")  //Si selecciona una pais que no sea peru
                {
                    ltDepartamento.Enabled = false;
                    ltProvincia.Enabled = false;
                    ltDistrito.Enabled = false;
                    txtDoc.Visible = true;
                    lblDoc.Visible = true;
                    lblRucDoc.Visible = false;
                    txtRucDoc.Visible = false;
                    ltProvincia.SelectedIndex = -1;
                    ltDistrito.SelectedIndex = -1;
                    ltDepartamento.SelectedIndex = -1;
                }
                else
                {
                    txtDoc.Visible = false;
                    lblDoc.Visible = false;
                    lblRucDoc.Visible = true;
                    txtRucDoc.Visible = true;
                    ltDepartamento.Enabled = true;
                    ltProvincia.Enabled = true;
                    ltDistrito.Enabled = true;
                    ltDepartamento.LoadData();
                    //ltProvincia.LoadData();
                    txtRucDoc.Focus();

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

        //Se ejecuta cada vez que se selecciona un Departamento,se refresca los combos Provincia
        protected void fnRefrescaPvc(object sender, EventArgs e)
        {
            ltProvincia.LoadData();
        }

        protected void fnRefrescaDtto(object sender, EventArgs e)
        {
            ltDistrito.LoadData();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Atras();
        }

        protected void RegistrarCliente(object sender, EventArgs e)
        {
            try
            {

                string resultado;
                string pais = ltPais.SelectedItem.Text.Substring(0, 3);
                string UBC_GEO;
                if (!ValidarDatos())
                {
                    // Si hay errores, detener el procesamiento
                    return;
                }
                if (pais != "PER")
                {
                    UBC_GEO = ltPais.SelectedValue;
                }
                else
                {
                    UBC_GEO = ltDistrito.SelectedValue;
                }
                string webSiteM = txtWebsite.Text.Replace("http://", "").Replace("https://", "").Substring(0, Math.Min(50, txtWebsite.Text.Length)); ;
                string redSocialM = txtRedSocial.Text.Replace("http://", "").Replace("https://", "").Substring(0, Math.Min(50, txtRedSocial.Text.Length));

                string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]; //Auditoria

                if (string.IsNullOrEmpty(ip))
                {
                    ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

                    try
                    {
                        IPHostEntry hostEntry = Dns.GetHostEntry(ip);
                        ip = hostEntry.HostName;

                        if (ip.Contains("."))
                        {
                            ip = ip.Split('.')[0];
                        }
                    }
                    catch
                    {
                        // Si falla la resolución de DNS, se utiliza la IP
                    }
                }

                string cli_auditoria = "Tipo=" + ltTipo.SelectedItem.Text + "RazonSocial=" + txtRazSoc.Text.Trim() + "Ciiu=" + ltCiiu.SelectedItem.Text + "Pais=" + pais + "Doc=" + txtDoc.Text.Trim() + "RUC=" + txtRucDoc.Text.Trim() + "Proc=" + ltProcedencia.SelectedItem.Text + "Entidad=" + ltEntidad.SelectedItem.Text; //Auditoria
                try
                {

                    resultado = (new ClienteSoapClient()).InsertarCliente(ltTipo.SelectedValue.ToString(), txtRazSoc.Text.ToUpper(), ltCiiu.SelectedValue, pais, txtDoc.Text.Trim(),
                                           txtRucDoc.Text.Trim(), ltProcedencia.SelectedValue, ltEntidad.SelectedValue, UBC_GEO, txtDireccion.Text, ltEstado.SelectedValue,
                                           webSiteM, redSocialM, this.UsuarioLogin, ip, cli_auditoria.Substring(0, cli_auditoria.Length < 200 ? cli_auditoria.Length : 200), "1", this.IDCLIENTE);

                    if (resultado == "0" && pais != "PER")
                    {
                        string script = "<script>";

                        script += "toastr.error('Ya existe un cliente con el Nro de documento especificado ', 'Requerido');";
                        // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                        script += "document.getElementById('" + txtDoc.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                        script += "document.getElementById('" + txtDoc.ClientID + "').focus();"; // Poner el foco en el campo
                        script += "</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                    }
                    else if (resultado == "0" && pais == "PER")
                    {
                        string script = "<script>";

                        script += "toastr.error('Ya existe un cliente con el RUC especificado ', 'Requerido');";
                        // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                        script += "document.getElementById('" + txtRucDoc.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                        script += "document.getElementById('" + txtRucDoc.ClientID + "').focus();"; // Poner el foco en el campo
                        script += "</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                    }

                    if (resultado != null && resultado != "0")
                    {
                        hdnReload.Value = resultado;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", $"mostrarMensajeExito('Registro exitoso','{resultado}');", true);
                    }
                }
                catch (Exception ex)
                {

                    StackTrace stack = new StackTrace();
                    string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                    string script = "<script>";
                    //    script += "toastr.error('Error al realizar el registro. Error en:'+"NombreMetodo"+'.', 'Requerido');";
                    script += "toastr.error('Error al realizar el registro. Error en: \"NombreMetodo\".', 'Requerido');";
                    script += "</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                    script += "document.getElementById('" + txtRucDoc.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                }
            }
            catch (Exception ex)
            {
                this.LanzarException("RegistrarCliente()", ex);
                var result = "" + ex.Message;
                string scriptSuccess = $"Swal.fire('Error', 'Cliente - RegistrarCliente(): {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }

        protected void ActualizarCliente(object sender, EventArgs e)
        {
            try
            {
                string resultado;
                string pais = ltPais.SelectedItem.Text.Substring(0, 3);
                string UBC_GEO;

                if (!ValidarDatos())
                {
                    // Si hay errores, detener el procesamiento
                    return;
                }

                if (pais != "PER")
                {
                    UBC_GEO = ltPais.SelectedValue;
                }
                else
                {
                    UBC_GEO = ltDistrito.SelectedValue;
                }

                string webSiteM = txtWebsite.Text.Replace("http://", "").Replace("https://", "").Substring(0, Math.Min(50, txtWebsite.Text.Length));
                string redSocialM = txtRedSocial.Text.Replace("http://", "").Replace("https://", "").Substring(0, Math.Min(50, txtRedSocial.Text.Length));
                string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]; //Auditoria

                if (string.IsNullOrEmpty(ip))
                {
                    ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

                    try
                    {
                        IPHostEntry hostEntry = Dns.GetHostEntry(ip);
                        ip = hostEntry.HostName;
                        if (ip.Contains("."))
                        {
                            ip = ip.Split('.')[0];
                        }
                    }
                    catch
                    {
                        // Si falla la resolución de DNS, se utiliza la IP
                    }
                }

                string cli_auditoria = "Tipo=" + ltTipo.SelectedItem.Text + "RazonSocial=" + txtRazSoc.Text.Trim() + "Ciiu=" + ltCiiu.SelectedItem.Text + "Pais=" + pais + "Doc=" + txtDoc.Text.Trim() + "RUC=" + txtRucDoc.Text.Trim() + "Proc=" + ltProcedencia.SelectedItem.Text + "Entidad=" + ltEntidad.SelectedItem.Text; //Auditoria

                resultado = (new ClienteSoapClient()).InsertarCliente(ltTipo.SelectedValue.ToString(), txtRazSoc.Text.ToUpper(), ltCiiu.SelectedValue, pais, txtDoc.Text.Trim(),
                      txtRucDoc.Text.Trim(), ltProcedencia.SelectedValue, ltEntidad.SelectedValue, UBC_GEO, txtDireccion.Text, ltEstado.SelectedValue,
                      webSiteM, redSocialM, this.UsuarioLogin, ip, cli_auditoria.Substring(0, cli_auditoria.Length < 200 ? cli_auditoria.Length : 200), "2", this.IDCLIENTE);

                if (resultado == "0" && pais != "PER")
                {
                    string script = "<script>";

                    script += "toastr.error('Ya existe un cliente con el Nro de documento especificado ', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtDoc.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtDoc.ClientID + "').focus();"; // Poner el foco en el campo
                    script += "</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                }
                else if (resultado == "0" && pais == "PER")
                {
                    string script = "<script>";

                    script += "toastr.error('Ya existe un cliente con el RUC especificado ', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtRucDoc.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtRucDoc.ClientID + "').focus();"; // Poner el foco en el campo
                    script += "</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                }

                if (resultado != null && resultado != "0")
                {
                    hdnReload.Value = resultado;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", $"mostrarMensajeExito('Actualizacion exitosa','{resultado}');", true);
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

        /*---------------------------------------------------------------------------*/
        /*------Lo de abajo es para la grilla de contacttos del cliente---------------*/
        /*---------------------------------------------------------------------------*/
        protected void EasyGridContacto_PageIndexChanged(object sender, EventArgs e)
        {
            //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
            // this.LlenarGrilla("");
        }

        protected void EasyGridContacto_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {

        }

        protected void EasyGridContacto_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {

        }

        protected void EasyPopupContactosClientes_Click()
        {
            EasyGridContacto.LoadData("");
        }

        public bool ValidarDatos()
        {
            bool esValido = true;
            string script = "<script>";
            try
            {
                //Validar campo Razon social
                if (string.IsNullOrEmpty(txtRazSoc.Text))
                {
                    script += "toastr.error('Debe agregar valores al campo Razón Social.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtRazSoc.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtRazSoc.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                if (string.IsNullOrWhiteSpace(ltTipo.SelectedValue) || ltTipo.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar un valor en el campo Tipo.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltTipo.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltTipo.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;

                }

                if (string.IsNullOrWhiteSpace(ltPais.SelectedValue) || ltPais.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar un valor en el campo Pais.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltPais.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltPais.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                if (ltPais.getValue() == "702701")  //Si selecciona a peru como pais
                {

                    if (string.IsNullOrWhiteSpace(ltDepartamento.SelectedValue) || ltDepartamento.SelectedValue == "-1")
                    {
                        script += "toastr.error('Debe  seleccionar un valor en el campo Departamento.', 'Requerido');";
                        // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                        script += "document.getElementById('" + ltDepartamento.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                        script += "document.getElementById('" + ltDepartamento.ClientID + "').focus();"; // Poner el foco en el campo

                        esValido = false;
                    }

                    if (string.IsNullOrWhiteSpace(ltProvincia.SelectedValue) || ltProvincia.SelectedValue == "-1")
                    {
                        script += "toastr.error('Debe  seleccionar un valor en el campo Provincia.', 'Requerido');";
                        // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                        script += "document.getElementById('" + ltProvincia.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                        script += "document.getElementById('" + ltProvincia.ClientID + "').focus();"; // Poner el foco en el campo

                        esValido = false;
                    }

                    if (string.IsNullOrWhiteSpace(ltDistrito.SelectedValue) || ltDistrito.SelectedValue == "-1")
                    {
                        script += "toastr.error('Debe  seleccionar un valor en el campo Distrito.', 'Requerido');";
                        // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                        script += "document.getElementById('" + ltDistrito.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                        script += "document.getElementById('" + ltDistrito.ClientID + "').focus();"; // Poner el foco en el campo

                        esValido = false;
                    }

                    if (string.IsNullOrWhiteSpace(txtRucDoc.Text))
                    {
                        script += "toastr.error('Debe  completar el campo RUC/DOC.', 'Requerido');";
                        // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                        script += "document.getElementById('" + txtRucDoc.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                        script += "document.getElementById('" + txtRucDoc.ClientID + "').focus();"; // Poner el foco en el campo

                        esValido = false;
                    }

                }

                if (ltPais.getValue() != "702701" && ltPais.SelectedValue != "-1")
                {
                    if (string.IsNullOrWhiteSpace(txtDoc.Text))
                    {
                        script += "toastr.error('Debe  completar el campo  Doc Identificacion', 'Requerido');";
                        // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                        script += "document.getElementById('" + txtDoc.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                        script += "document.getElementById('" + txtDoc.ClientID + "').focus();"; // Poner el foco en el campo

                        esValido = false;
                    }
                }

                if (string.IsNullOrWhiteSpace(ltProcedencia.SelectedValue) || ltProcedencia.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar un valor en el campo Procedencia.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltProcedencia.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltProcedencia.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                if (string.IsNullOrWhiteSpace(ltEntidad.SelectedValue) || ltEntidad.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar un valor en el campo Entidad.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltEntidad.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltEntidad.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                if (string.IsNullOrWhiteSpace(ltEstado.SelectedValue) || ltEstado.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar un valor en el campo Estado.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltEstado.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltEstado.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                if (string.IsNullOrWhiteSpace(txtDireccion.Text))
                {
                    script += "toastr.error('Debe completar el campo Direccion.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtDireccion.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtDireccion.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                script += "</script>";
                if (!esValido)
                {
                    // Registrar el script para que se ejecute en el cliente
                    ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                }

                return esValido;
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
                return false;
            }
        }
    }
}