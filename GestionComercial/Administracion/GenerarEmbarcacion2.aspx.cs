using EasyControlWeb.Form.Controls;
using SIMANET_W22R.srvCliente;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionComercial.Administracion
{
    public partial class GenerarEmbarcacion2 : PaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["V_EMBARCACION_ID"].ToString() == String.Empty)
            {
                txtModo.Value = "N";
            }
            else
            {
                txtModo.Value = "M";
                txtEmbarcacionID.Value = Session["V_EMBARCACION_ID"].ToString();
            }

            // Request.QueryString[]
            if (!IsPostBack) // Cargar datos solo en la primera carga
            {
                this.LlenarDatos();
            }
        }

        public void LlenarDatos()
        {
            try
            {
                switch (txtModo.Value)
                {
                    case "N":
                        CargarModoNuevo();
                        break;
                    case "M":
                        CargarModoModificar();
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
        public void CargarModoNuevo()
        {
            try
            {

                ltTipo.LoadData();
                ltTipoEmbarc.LoadData();
                ltIdMaterial.LoadData();
                ltEstado.LoadData();
                dpFechaRegistro.Text = DateTime.Now.ToString("dd/MM/yyyy");
                ltSistPesca.LoadData();
                ltUm1.LoadData();
                ltUm2.LoadData();
                ltUm3.LoadData();
                ltUm4.LoadData();
                ltUm5.LoadData();
                ltUm6.LoadData();
                ltUm7.LoadData();
                eDDLCentros.LoadData();
                eDDLUnidadO.Visible = false;
                lblUnidOpera.Visible = false;
                ltEstado.SelectedIndex = 1;
                lblTitulo.Text = "Embarcación";
                lblSubtitulo.Text = "Generar Embarcación";
                txtMotor.Text = "No especificado";
                txtObservacion.Text = "Ninguno";
                txtAstillero.Text = "No Especificado";
                ltTipoEmbarc.SetValue("PES");
                ltIdMaterial.SetValue("1");
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
            lblSubtitulo.Text = "Modificar Embarcación";
            ltTipo.LoadData();
            ltTipoEmbarc.LoadData();
            ltIdMaterial.LoadData();
            ltEstado.LoadData();
            ltSistPesca.LoadData();
            ltUm1.LoadData();
            ltUm1.LoadData();
            ltUm2.LoadData();
            ltUm3.LoadData();
            ltUm4.LoadData();
            ltUm5.LoadData();
            ltUm6.LoadData();
            ltUm7.LoadData();
            try
            {
                ClienteSoapClient oCliente = new ClienteSoapClient();
                EmbarcacionBE oEmbarcacionBE = oCliente.ListarEmbarcacionPorId(txtEmbarcacionID.Value, this.UsuarioLogin);
                lblTitulo.Text = "EMBARCACION " + oEmbarcacionBE.NOM_UND;
                txtNombre.SetValue(oEmbarcacionBE.NOM_UND);
                dpFechaRegistro.Text = (oEmbarcacionBE.FEC_INGRESO == "" ? "" : DateTime.Parse(oEmbarcacionBE.FEC_INGRESO).ToString("dd/MM/yyyy"));
                acCliente.SetValue(oEmbarcacionBE.CLIENTE, oEmbarcacionBE.V_CLIENTE_ID.ToString());
                txtNombreAnterior.SetValue(oEmbarcacionBE.NOMBREANTERIOR);
                ltTipo.LoadData();
                ltTipo.SetValue(oEmbarcacionBE.TIPO);
                txtAstillero.SetValue(oEmbarcacionBE.ASTILLERO_CONSTRUCTOR);
                txtMatricula.SetValue(oEmbarcacionBE.MATRICULA);
                ltTipoEmbarc.LoadData();
                txtBarcoId.SetValue(oEmbarcacionBE.V_EMBARCACION_ID);
                ltTipoEmbarc.SetValue(oEmbarcacionBE.TIP_UND);
                //txtToMatricula.SetValue(oEmbarcacionBE.matr)
                ltIdMaterial.LoadData();
                ltIdMaterial.SetValue(oEmbarcacionBE.ID_MATERIAL);
                ltEstado.LoadData();
                ltEstado.SetValue(oEmbarcacionBE.EST_ATL);
                ltSistPesca.LoadData();
                ltSistPesca.SetValue(oEmbarcacionBE.SISTEMAPESCA);
                txtMotor.SetValue(oEmbarcacionBE.MOTOR);
                txtObservacion.SetValue(oEmbarcacionBE.OBSERVACION);
                eDDLCentros.LoadData();
                lbCod_Und.Text = oEmbarcacionBE.COD_UND;
                lblId_Embarcacion.Text = oEmbarcacionBE.ID_EMBARCACION;

                if (oEmbarcacionBE.CODCOPE == " ")
                {
                    eDDLCentros.SetValue("1");
                    eDDLUnidadO.Visible = false;
                    lblUnidOpera.Visible = false;
                    lbCod_Und.Visible = true;
                    lblId_Embarcacion.Visible = false;
                }
                else
                {
                    eDDLUnidadO.Visible = true;
                    lblUnidOpera.Visible = true;
                    eDDLCentros.SetValue("3");
                    eDDLUnidadO.LoadData();
                    eDDLUnidadO.SetValue(oEmbarcacionBE.CODCOPE);
                    lbCod_Und.Visible = false;
                    lblId_Embarcacion.Visible = true;
                }

                DataTable dt = oCliente.ListarDetalleDeEmbarcacionPorID(txtEmbarcacionID.Value);

                // Inicializa los 7 campos de tu página
                TextBox[] camposValor = { txtEslora, txtManga, txtPuntal, txtTRB, txtTRN, txtBodega, txtAreaConst };
                EasyDropdownList[] camposUM = { ltUm1, ltUm2, ltUm3, ltUm4, ltUm5, ltUm6, ltUm7 };

                // Limpia los campos (por si hay menos de 7 filas en la tabla)
                for (int i = 0; i < 7; i++)
                {
                    camposValor[i].Text = "0.00";
                    camposUM[i].SelectedValue = "-1";
                }

                // Rellena los campos con los datos del DataTable
                foreach (DataRow row in dt.Rows)
                {
                    int idArea = Convert.ToInt32(row["N_IDAREA"]); // Obtiene el N_IDAREA de la fila
                    camposValor[idArea - 1].Text = Convert.ToDecimal(row["N_VALOR"]).ToString("0.00"); // Asigna el valor correspondiente
                    camposUM[idArea - 1].SelectedValue = row["C_UM"].ToString();       // Asigna la unidad correspondiente

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
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Atras();
        }

        protected void RegistrarEmbarcacion(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarDatos())
                {
                    // Si hay errores, detener el procesamiento
                    return;
                }

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

                string cli_auditoria = "Tipo=" + ltTipo.SelectedItem.Text + "Cliente=" + acCliente.GetValue() + "Nombre=" + txtNombre.Text.Trim() + "Matricula=" + txtMatricula.Text.Trim() + "TipoEmbar=" + ltTipoEmbarc.SelectedItem.Text + "Material=" + ltIdMaterial.SelectedItem.Text + "SistemaPesca=" + ltSistPesca.SelectedItem.Text; //Auditoria
                string copCope;
                if (eDDLCentros.SelectedValue == "3")
                {
                    copCope = eDDLUnidadO.SelectedValue;
                }
                else
                {
                    copCope = "";
                }

                try
                {
                    string resultado;

                    if (txtModo.Value == "N")
                    {

                        resultado = (new ClienteSoapClient()).InsertarEmbarcacion(txtNombre.Text.Trim(), ltTipoEmbarc.SelectedValue, ltEstado.SelectedValue, this.UsuarioLogin, copCope, txtNombreAnterior.Text, ltTipo.SelectedValue,
                                                            txtAstillero.Text.Trim(), txtMatricula.Text.Trim(), ltIdMaterial.SelectedValue, dpFechaRegistro.Text, txtObservacion.Text.Trim(),
                                                              txtEslora.Text.Trim(), txtManga.Text.Trim(), txtPuntal.Text.Trim(), txtBodega.Text.Trim(),
                                                              ltSistPesca.SelectedValue, txtMotor.Text.Trim(), "", acCliente.GetValue(), "1");
                        if (resultado == "0")
                        {
                            string script = "<script>";
                            script += "toastr.error('No se pudo registrar la embarcación','Requerido');";
                            // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                            script += "</script>";
                            // ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                        }
                        else if (resultado == "1")
                        {
                            string script = "<script>";
                            script += "toastr.error('Ya existe una embarcacion con el mismo nombre','Requerido');";
                            // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                            script += "</script>";
                            //ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                        }
                        else if (resultado != null && resultado != "0")
                        {
                            InsertarDetallesEmbarcacion(resultado, dpFechaRegistro.Text);
                            //hdnReload.Value = resultado;
                            txtEmbarcacionID.Value = resultado;
                            txtModo.Value = "M";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", $"mostrarMensajeExito('Registro exitoso','{resultado}');", true);
                            lblTitulo.Text = "EMBARCACION " + txtNombre.Text;
                        }
                    }
                    else if (txtModo.Value == "M")
                    {

                        resultado = (new ClienteSoapClient()).InsertarEmbarcacion(txtNombre.Text.Trim(), ltTipoEmbarc.SelectedValue, ltEstado.SelectedValue, this.UsuarioLogin, copCope, txtNombreAnterior.Text, ltTipo.SelectedValue,
                                                                                    txtAstillero.Text.Trim(), txtMatricula.Text.Trim(), ltIdMaterial.SelectedValue, DateTime.Parse(dpFechaRegistro.Text).ToString("dd/MM/yyyy"), txtObservacion.Text.Trim(),
                                                                                      txtEslora.Text.Trim(), txtManga.Text.Trim(), txtPuntal.Text.Trim(), txtBodega.Text.Trim(),
                                                                                      ltSistPesca.SelectedValue, txtMotor.Text.Trim(), txtEmbarcacionID.Value, acCliente.GetValue(), "2");

                        if (resultado == "0")
                        {
                            string script = "<script>";

                            script += "toastr.error('No se pudo actualizar la embarcación','Requerido');";
                            // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                            script += "</script>";
                            //ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                        }
                        else if (resultado == "1")
                        {
                            string script = "<script>";

                            script += "toastr.error('Ya existe una embarcacion con el mismo nombre','Requerido');";
                            // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                            script += "</script>";
                            //ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                        }
                        else if (resultado != null && resultado != "0")
                        {

                            //hdnReload.Value = resultado;

                            Session["V_EMBARCACION_ID"] = resultado;
                            txtEmbarcacionID.Value = resultado;
                            txtModo.Value = "M";
                            lblTitulo.Text = "EMBARCACION " + txtNombre.Text;
                            txtBarcoId.Text = resultado;

                            ClienteSoapClient oCliente = new ClienteSoapClient();
                            EmbarcacionBE oEmbarcacionBE = oCliente.ListarEmbarcacionPorId(resultado, this.UsuarioLogin);
                            lbCod_Und.Text = oEmbarcacionBE.COD_UND;
                            lblId_Embarcacion.Text = oEmbarcacionBE.ID_EMBARCACION;
                            InsertarDetallesEmbarcacion(resultado, dpFechaRegistro.Text);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", $"mostrarMensajeExito('Actualizacion exitosa','{resultado}');", true);
                        }
                    }

                }
                catch (Exception ex)
                {

                    StackTrace stack = new StackTrace();
                    string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                    string script = "<script>";
                    script += "toastr.error('Error al realizar la transaccion. Error en: \"NombreMetodo\".', 'Requerido');";
                    script += "</script>";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                                                                                                             // ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);

                }
            }
            catch (Exception ex)
            {
                this.LanzarException("RegistrarEmbarcacion()", ex);
                var result = "" + ex.Message;
                string scriptSuccess = $"Swal.fire('Error', 'Cliente - RegistrarCliente(): {result}', 'error');";
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
                    lblUnidOpera.Visible = true;
                    eDDLUnidadO.LoadData();
                    eDDLUnidadO.SetValue("-1");

                    lbCod_Und.Visible = false;
                    lblId_Embarcacion.Visible = true;
                    /*
                    if (eDDLUnidadO.Items.Count <= 1)
                    { eDDLUnidadO.LoadData(); } */
                }
                else
                {
                    eDDLUnidadO.Visible = false;
                    lblUnidOpera.Visible = false;
                    lbCod_Und.Visible = true;
                    lblId_Embarcacion.Visible = false;
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
        protected void InsertarDetallesEmbarcacion(string X_EMBARCACION_ID, string X_FECHAREGISTRO)
        {
            // Valores de ejemplo para los campos X_VALOR (valores de los TextBox)
            string[] valores = {
                    txtEslora.Text,
                    txtManga.Text,
                    txtPuntal.Text,
                    txtTRB.Text,
                    txtTRN.Text,
                    txtBodega.Text,
                    txtAreaConst.Text,
                };

            // Valores de ejemplo para los campos X_UM (valores de los TextBox)
            string[] unidades = {
                    ltUm1.SelectedValue,
                    ltUm2.SelectedValue,
                    ltUm3.SelectedValue,
                    ltUm4.SelectedValue,
                    ltUm5.SelectedValue,
                    ltUm6.SelectedValue,
                    ltUm7.SelectedValue,
                };


            ClienteSoapClient cliente = new ClienteSoapClient();

            // Validación para asegurar que ambos arreglos tengan la misma cantidad de elementos
            if (valores.Length != unidades.Length)
            {
                return;
            }

            // Recorremos los valores de ambos arreglos y realizamos la inserción
            for (int i = 0; i < valores.Length; i++)
            {
                string X_IDAREA = (i + 1).ToString(); // IDAREA empieza en 1 y se incrementa
                string X_VALOR = valores[i]; // Valor del campo de texto actual (X_VALOR)
                string X_UM = unidades[i]; // Valor del campo de texto actual (X_UM)

                // Validar que no estén vacíos
                if (X_VALOR == "0.00" || string.IsNullOrWhiteSpace(X_UM))
                {
                    // Console.WriteLine($"Campos vacíos en fila {X_IDAREA}. No se insertará.");
                    continue;
                }

                // Llamada al servicio para insertar cada registro
                string resultado = cliente.InsertarDetalleEmbarcacion(
                    X_EMBARCACION_ID,
                    X_IDAREA,
                    X_VALOR,
                    X_FECHAREGISTRO,
                    X_UM
                );

                // Validar el resultado si es necesario
                if (!resultado.Equals("OK", StringComparison.OrdinalIgnoreCase))
                {
                    // Manejar errores en caso de que la inserción falle
                    Console.WriteLine($"Error al insertar registro con IDAREA {X_IDAREA}: {resultado}");
                }
            }
        }
        public bool ValidarDatos()
        {
            bool esValido = true;
            string script = "<script>";
            try
            {
                //Validar 
                if (string.IsNullOrEmpty(acCliente.GetValue()))
                {
                    script += "toastr.error('Debe seleccionar el campo Cliente .', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + acCliente.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + acCliente.ClientID + "').focus();"; // Poner el foco en el campo
                    esValido = false;
                }

                if (string.IsNullOrWhiteSpace(txtNombre.Text))
                {
                    script += "toastr.error('Debe completar el campo Nombre.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtNombre.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtNombre.ClientID + "').focus();"; // Poner el foco en el campo

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
                if (string.IsNullOrWhiteSpace(txtMatricula.Text))
                {
                    script += "toastr.error('Debe completar el campo Matricula.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtMatricula.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtMatricula.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                if (string.IsNullOrWhiteSpace(ltTipoEmbarc.SelectedValue) || ltTipoEmbarc.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar un valor en el campo Tipo Embarcacion.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltTipoEmbarc.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltTipoEmbarc.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                if (string.IsNullOrWhiteSpace(ltIdMaterial.SelectedValue) || ltIdMaterial.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar un valor en el campo Material.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltIdMaterial.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltIdMaterial.ClientID + "').focus();"; // Poner el foco en el campo

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

                if (string.IsNullOrWhiteSpace(ltSistPesca.SelectedValue) || ltSistPesca.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar un valor en el campo Sistema de Pesca.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltSistPesca.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltSistPesca.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                if (txtEslora.Text == "0.00")
                {
                    script += "toastr.error('Debe llenar  el campo Eslora.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtEslora.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtEslora.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }
                if (txtManga.Text == "0.00")
                {
                    script += "toastr.error('Debe llenar  el campo Manga.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtManga.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtManga.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }
                if (txtPuntal.Text == "0.00")
                {
                    script += "toastr.error('Debe llenar  el campo Puntal.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtPuntal.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtPuntal.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }
                if (txtBodega.Text == "0.00")
                {
                    script += "toastr.error('Debe llenar  el campo Puntal.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtBodega.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtBodega.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }
                if (string.IsNullOrWhiteSpace(ltUm1.SelectedValue) || ltUm1.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar una unidad de medida en el campo Eslora.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltUm1.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltUm1.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }
                if (string.IsNullOrWhiteSpace(ltUm2.SelectedValue) || ltUm2.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar una unidad de medida en el campo Manga.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltUm2.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltUm2.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }
                if (string.IsNullOrWhiteSpace(ltUm3.SelectedValue) || ltUm3.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar una unidad de medida en el campo Manga.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltUm3.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltUm3.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }
                if (string.IsNullOrWhiteSpace(ltUm6.SelectedValue) || ltUm6.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar una unidad de medida en el campo Bodega.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + ltUm6.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltUm6.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }
                script += "</script>";
                if (!esValido)
                {
                    // Registrar el script para que se ejecute en el cliente
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                                                                                                             // ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
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