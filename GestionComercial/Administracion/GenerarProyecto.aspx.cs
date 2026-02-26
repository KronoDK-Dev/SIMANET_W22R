using DocumentFormat.OpenXml.Drawing.Diagrams;
using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.GestionProyecto;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvCliente;
using SIMANET_W22R.srvGeneral;
// servicios
using SIMANET_W22R.srvGestionComercial;
using SIMANET_W22R.srvGestionProyecto;
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
    public partial class GenerarProyecto : BaseComercial , IPaginaBase
    {
        DataTable dt;
        ProyectoSoapClient servicio = new ProyectoSoapClient("ProyectoSoap");
        srvGestionProyecto.ProyectoSoapClient oProyectos = new srvGestionProyecto.ProyectoSoapClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["codPry"]==null || Session["codPry"].ToString() == String.Empty)
            {
                txtModo.Value = "N";
            }
            else
            {
                txtModo.Value = "M";
                txtCodProyecto.Text = Session["codPry"].ToString();
            }

            // Request.QueryString[]
            if (!IsPostBack) // Cargar datos solo en la primera carga
            {
                this.LlenarDatos();
            }
           
            if (hfMostrarPopup.Value == "1")
            {
              //  ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirPopup", "epuColaboradores.Show();", true); //mostrarPopup()
                hfMostrarPopup.Value = "0"; // Reinicia para que no se muestre en postbacks siguientes
            }

            if (IsPostBack && hfMostrarPopup.Value == "1")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mantenerPopup", "epuColaboradores.Show();", true);
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
                lblSubtitulo.Text = ex.Message;
            }


        }
        public void CargarModoNuevo()
        {
            try
            {
                ltMoneda.LoadData();
                ltPopMoneda.LoadData();
                ltEstadoPr.LoadData();
                EDDLcategoria.LoadData();

                lblTitulo.Text = "Nuevo Proyecto";
                lblSubtitulo.Text = "";
           
                if (eDDLCentros.Items.Count == 0)
                {
                    eDDLCentros.LoadData();

                    //------- COLOCAMOS DATOS POR DEFECTO SEGUN USUARIO ---
                    if (this.DatosUsuario.NroCentroOperativo.ToString() == null)
                    {
                        eDDLCentros.SelectedIndex = 1; // cargamos el primer registro para la busqueda del control asociado
                        ltTipoPry.LoadData();
                    }
                    else
                    {
                        if (this.DatosUsuario.NroCentroOperativo.ToString() != "9")
                        { eDDLCentros.SelectedValue = this.DatosUsuario.NroCentroOperativo.ToString(); ltTipoPry.LoadData(); } // cargamos para lo que tienen un solo centro
                        else
                        { eDDLCentros.SelectedIndex = 1; ltTipoPry.LoadData(); } // linea para los que tienen acceso a varios centros operativos
                    }


                    if (eDDLCentros.Items.Count > 1)
                    {

                        if (eDDLUnidadO.Items.Count == 0)
                        {
                            eDDLUnidadO.LoadData();

                            if (eDDLCentros.SelectedValue == "3")
                            {
                                eDDLUnidadO.Visible = true;
                                lblUO.Visible = true;
                                //eDDLSubLineasN.Visible = true;
                                //lblSublinea.Visible = true;

                            }
                            else
                            {
                                if (eDDLCentros.SelectedValue == "1" && eDDLUnidadO.Items.Count > 1)
                                {
                                    eDDLUnidadO.SelectedIndex = 1;
                                }
                                eDDLUnidadO.Visible = true;
                                lblUO.Visible = true;
                                // eDDLSubLineasN.Visible = false;
                                //  lblSublinea.Visible = false;
                            }
                        }

                        // existe registro de centros
                        eDDLLineasN.LoadData();
                        if (eDDLLineasN.Items.Count > 0)
                        {
                            dt = (new SolicitudSoapClient()).Lista_lineas_Usuario(this.DatosUsuario.Login, this.DatosUsuario.Login);
                            if (dt != null)
                            {
                                if (dt.Rows.Count == 1)
                                {
                                    eDDLLineasN.SelectedValue = dt.Rows[0][0].ToString(); // linea
                                    // clase
                                    if (dt.Rows[0][1] != DBNull.Value && !string.IsNullOrEmpty(dt.Rows[0][1].ToString()))
                                    {
                                        // Personalizacion de búsqueda ---
                                        //etbCriterio.Text = "CLASE> " + dt.Rows[0][1].ToString();
                                        Session["Clase"] = dt.Rows[0][1].ToString();
                                    }
                                }

                            }

                            eDDLSubLineasN.LoadData();

                        }

                    }
                }

                //---si es nuevo aun no tiene adendas ni ots, recien se van a crear ---------------------------
                //EasyGridOtsProyecto.LoadData("");
                // EasyGridAdendas.LoadData("");
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
            try
            {
                ProyectoSoapClient oProyecto = new ProyectoSoapClient();

                if (!string.IsNullOrWhiteSpace((txtCodProyecto.Text)))
                {
                    txtCodProyecto.Text= Session["codPry"].ToString();
                }
                
                ProyectoBE oProyectoBE = oProyecto.ListarProyectoPorId(txtCodProyecto.Text, this.UsuarioLogin);
                lblTitulo.Text = oProyectoBE.DES_PRY;               
                lblSubtitulo.Text = oProyectoBE.COD_PRY;
                lblTotalProy.Text = "Total Proyecto (inc. Adendas) = ";


                txtCodProyecto.Text= oProyectoBE.COD_PRY;
                eDDLCentros.LoadData();
                eDDLCentros.SetValue(oProyectoBE.COD_CEO);
                eDDLUnidadO.LoadData();

                if (oProyectoBE.COD_CEO == "1")
                {
                    eDDLUnidadO.SelectedIndex = 1;
                }
                else
                {
                    eDDLUnidadO.SetValue(oProyectoBE.V_PRY_UNDOPER);
                }
                    
                eDDLUnidadO.SetValue(oProyectoBE.V_PRY_UNDOPER);
                eDDLLineasN.LoadData();
                eDDLLineasN.SetValue(oProyectoBE.COD_DIV);
               // if (eDDLLineasN.Items.Count > 0)
              //  { eDDLLineasN.SelectedValue = oProyectoBE.COD_DIV; } // se requier igual el valor para permitir en la siguiente busqueda resultados correctos
                eDDLSubLineasN.LoadData();
                eDDLSubLineasN.SetValue(oProyectoBE.V_PRY_SUBLINEA);
                ltEstadoPr.LoadData();
                ltPopMoneda.LoadData();
                ltMoneda.LoadData();
                ltTipoPry.LoadData();
                EDDLcategoria.LoadData();
                //acCliente.SetValue(oProyectoBE.V_CLIENTE_ID);
                txtCorreo.SetValue(oProyectoBE.CORREO);
                dpcFechaIni.Text =string.IsNullOrEmpty(oProyectoBE.FECINI_PRY) ? "" : DateTime.Parse(oProyectoBE.FECINI_PRY).ToString("dd/MM/yyyy") ;
                dpcFechaFin.Text =string.IsNullOrEmpty(oProyectoBE.FECFIN_PRY) ? "" : DateTime.Parse(oProyectoBE.FECFIN_PRY).ToString("dd/MM/yyyy") ;
                txtMontoContr.SetValue(oProyectoBE.N_PRY_MONTO_SINIMP);
                txtAlias.SetValue(oProyectoBE.PRY_JDE);
                ltMoneda.SetValue(oProyectoBE.V_PRY_CODMONEDA);
               
                txtNumeroCasco.SetValue(oProyectoBE.NROCASCO);
                txtDescripcion.SetValue(oProyectoBE.DES_PRY);
                //txtEstadoPry.SetValue(oProyectoBE.EST_PRY);
                ltEstadoPr.SetValue(oProyectoBE.EST_ATL);
                txtEslora.SetValue(oProyectoBE.N_PRY_ESLORA);
                
                ltTipoPry.SetValue(oProyectoBE.TIPO_PRY);
                txtManga.SetValue(oProyectoBE.N_PRY_MANGA);
                txtPuntal.SetValue(oProyectoBE.N_PRY_PUNTAL);
                txtBodega.SetValue(oProyectoBE.N_PRY_BODEGA);
                txtObservacion.SetValue(oProyectoBE.V_PRY_OBSERVACIONES);
                txtConvenio.SetValue(oProyectoBE.V_PRY_Convenio);
                // Controles autocomplete se les pasa dos valores 
                if (!string.IsNullOrWhiteSpace(oProyectoBE.V_CLIENTE_ID))
                { 
                acCliente.SetValue(oProyectoBE.CLIENTE,oProyectoBE.V_CLIENTE_ID); // setea data

                    if (!string.IsNullOrEmpty(acCliente.GetText()?.ToString().Trim()))
                    {
                        acCliente.SetReadOnly(); // bloquea data llenada solo si hay
                    }
                    
                }

                if (!string.IsNullOrWhiteSpace(oProyectoBE.V_PRY_COD_JEFEPROY))
                {
                    EAC_usuarios.SetValue(oProyectoBE.V_JEFEPROY, oProyectoBE.V_PRY_COD_JEFEPROY);
                }

                try
                {
                    EasyGridOtsProyecto.LoadData("");
                                        
                    
                    DataView dv = (DataView)EasyGridOtsProyecto.DataSource;
                    DataTable dt = dv.ToTable();
                    int totalFilas = dt.Rows.Count;
                    lblTituloOT.Text = "Lista de Ordenes de Trabajo (" + totalFilas.ToString() + ")";

                    EasyGridAdendas.LoadData("");
                }
                catch { }

                eDDLCentros.Enabled = false;
                eDDLUnidadO.Enabled = false;
                if (oProyectoBE.COD_DIV != "-1")
                { 
                     eDDLLineasN.Enabled = false;
                
                }


                if (oProyectoBE.V_PRY_SUBLINEA != null)
                {
                    eDDLSubLineasN.Enabled = false;
                }


                EGVPresupuesto.LoadData("");



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
                lblSubtitulo.Text = ex.Message;
            }

        }
        protected void RegistrarProyecto(object sender, EventArgs e)
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
                string cli_auditoria = "Centro=" + eDDLCentros.SelectedItem.Text + "Descripcion="+ txtDescripcion.Text.Trim() + "UniOpera=" + eDDLUnidadO.SelectedItem.Text + "Linea=" + eDDLLineasN.SelectedItem.Text + "Sublinea=" + eDDLSubLineasN.SelectedItem.Text + "Cliente=" + acCliente.GetValue() + "FechaIni=" + dpcFechaIni.Text.Trim() + "FechaFin=" + dpcFechaFin.Text + "Monto=" + txtMontoContr.Text; //Auditoria
   
                try
                {
                    string resultado;

                    if (txtModo.Value == "N")
                    {
                        string cliente_id = acCliente.GetValue().ToString();
                        decimal monto;
                        int i_decimal = 0;
                        if (txtMontoContr.Text.Contains("."))
                        { i_decimal = 1; }
                        else
                        { i_decimal = 0; }

                        string valorLimpio = txtMontoContr.Text.Replace(".", "").Replace(",", "").Replace("'", "").Replace("’", "");
                        if (i_decimal == 1)
                        { monto = Convert.ToDecimal(valorLimpio) / 100; }
                        else
                        { monto = Convert.ToDecimal(valorLimpio); }

                        txtMontoContr.Text = monto.ToString();


                        // lblSubtitulo.Text (ANTES)
                        resultado = (new ProyectoSoapClient()).InsertarProyecto(eDDLCentros.SelectedValue, txtCodProyecto.Text, ((eDDLCentros.SelectedValue == "1") ? "" : txtCodProyecto.Text), 
                                                                eDDLLineasN.SelectedValue, txtDescripcion.Text,"", ltEstadoPr.Text, txtCodProyecto.Text, this.UsuarioLogin, txtAlias.Text  ,txtEstadoPry.Text, ltTipoPry.SelectedValue, 
                                                                dpcFechaIni.Text, dpcFechaFin.Text, eDDLUnidadO.SelectedValue, 
                                                                eDDLSubLineasN.SelectedValue, acCliente.GetValue().ToString(), EAC_usuarios.GetValue().ToString(), txtMontoContr.Text, ltMoneda.SelectedValue,
                                                                txtEslora.Text,txtManga.Text,txtPuntal.Text,txtBodega.Text, ip, cli_auditoria.Substring(0, cli_auditoria.Length < 200 ? cli_auditoria.Length : 200), txtObservacion.Text,txtCorreo.Text,txtNumeroCasco.Text, txtConvenio.Text, 
                                                                "1");
                        
                                             
                       // resultado = "0";
                        if (resultado == "0")
                        {
                            string script = "<script>";
                            script += "toastr.error('No se pudo registrar el proyecto','Requerido');";
                            // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                            script += "</script>";
                            // ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                        }
                        else if (resultado == "1")
                        {
                            string script = "<script>";
                            script += "toastr.error('Ya existe un proyecto con el mismo nombre','Requerido');";
                            // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                            script += "</script>";
                            //ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                        }
                        else if (resultado != null && resultado != "0")
                        {
                            //InsertarDetallesEmbarcacion(resultado, dpFechaRegistro.Text);

                            //hdnReload.Value = resultado;
                            txtProyectoID.Value = resultado;
                            lblSubtitulo.Text = resultado;
                            txtModo.Value = "M";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", $"mostrarMensajeExito('Registro exitoso','{resultado}');", true);
                            lblTitulo.Text = txtDescripcion.Text;
                        }
                    }
                    else if (txtModo.Value == "M")
                    {

                        decimal monto;
                        int  i_decimal=0;
                        if (txtMontoContr.Text.Contains("."))
                           {i_decimal = 1;}
                        else 
                           { i_decimal = 0; }

                          string valorLimpio = txtMontoContr.Text.Replace(".", "").Replace(",", "").Replace("'", "").Replace("’", "");
                        if (i_decimal == 1)
                         { monto = Convert.ToDecimal(valorLimpio)/100; }
                        else
                        {
                            if (!string.IsNullOrEmpty(valorLimpio))
                            { monto = Convert.ToDecimal(valorLimpio); }
                            else
                            { monto = 0; }
                        }



                        txtMontoContr.Text = monto.ToString();
                        // MODIFICAR
                                      resultado = (new ProyectoSoapClient()).InsertarProyecto(eDDLCentros.SelectedValue, lblSubtitulo.Text, ((eDDLCentros.SelectedValue == "1") ? "" : lblSubtitulo.Text),
                                        eDDLLineasN.SelectedValue, txtDescripcion.Text, "", ltEstadoPr.Text, lblSubtitulo.Text, this.UsuarioLogin,  txtAlias.Text  , ltEstadoPr.Text, ltTipoPry.SelectedValue,
                                        dpcFechaIni.Text, dpcFechaFin.Text, eDDLUnidadO.SelectedValue,
                                        eDDLSubLineasN.SelectedValue, acCliente.GetValue().ToString(), EAC_usuarios.GetValue().ToString(), txtMontoContr.Text, ltMoneda.SelectedValue,
                                        txtEslora.Text, txtManga.Text, txtPuntal.Text, txtBodega.Text, ip, cli_auditoria.Substring(0, cli_auditoria.Length < 200 ? cli_auditoria.Length : 200), txtObservacion.Text, txtCorreo.Text, txtNumeroCasco.Text, txtConvenio.Text,
                                        "2");

                        // resultado = "0";
                        if (resultado == "0")
                        {
                            string script = "<script>";
                            script += "toastr.error('No se pudo actualizar el proyecto','Requerido');";
                            // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                            script += "</script>";
                            // ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                        }/*
                        else if (resultado == "1")
                        {
                            string script = "<script>";
                            script += "toastr.error('Ya existe una embarcacion con el mismo nombre','Requerido');";
                            // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                            script += "</script>";
                            //ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);//
                        }*/
                        else if (resultado != null && resultado != "0")
                        {
                            //InsertarDetallesEmbarcacion(resultado, dpFechaRegistro.Text);

                            //hdnReload.Value = resultado;
                            Session["codPry"] = resultado;

                            txtProyectoID.Value = resultado;
                            lblSubtitulo.Text = resultado;
                            txtModo.Value = "M";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopupImmediate", $"mostrarMensajeExito('Actualizacion exitosa','{resultado}');", true);
                            lblTitulo.Text = txtDescripcion.Text;
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
                this.LanzarException("RegistrarProyecto()", ex);
                var result = "" + ex.Message;
                string scriptSuccess = $"Swal.fire('Error', 'Cliente - RegistrarProyecto(): {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Atras();
        }
        protected void fnRefrescaUO(object sender, EventArgs e)
        {
            try
            {
                ltTipoPry.LoadData();
                if (eDDLCentros.SelectedValue == "3")
                {
                    eDDLUnidadO.Visible = true;
                    lblUO.Visible = true;
                    eDDLUnidadO.ClearSelection();
                    eDDLUnidadO.LoadData();
                    eDDLLineasN.ClearSelection();
                    eDDLLineasN.LoadData();
                    eDDLSubLineasN.ClearSelection();
                    eDDLSubLineasN.LoadData();
                    lblSublinea.Visible = true;
                    eDDLSubLineasN.Visible = true;
                }
                else
                {
                    eDDLUnidadO.ClearSelection();
                    eDDLUnidadO.LoadData(); ;


                    if(eDDLCentros.SelectedValue == "1" && eDDLUnidadO.Items.Count > 1)
                    {
                        eDDLUnidadO.SelectedIndex = 1;
                    }
                    eDDLLineasN.ClearSelection();
                    eDDLLineasN.LoadData();

                    eDDLUnidadO.Visible = true;
                    lblUO.Visible = true;

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
        protected void fnRefrescaLN2(object sender, EventArgs e)
        {

            try
            {
                if (eDDLUnidadO.SelectedValue != "-1")
                {
                    eDDLLineasN.LoadData();
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
                eDDLSubLineasN.ClearSelection(); 
                eDDLSubLineasN.LoadData();

                // validamos que carga datos sino, cargamos por esta lado
                if (eDDLSubLineasN.Items.Count <  1)
                {
                    dt = (new GeneralSoapClient()).ListaSubLinea_Trabajo(this.eDDLUnidadO.SelectedValue   ,   this.eDDLLineasN.SelectedValue  , this.DatosUsuario.Login);
                    if(dt != null)
                    {
                        eDDLSubLineasN.DataSource = dt;
                        eDDLSubLineasN.DataBind();
                    }
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


        protected void GenProyectoId(object sender, EventArgs e)
        {
            //luego de seleccionar el cliente del control acCliente se ejecuta  esta función del lado del cliente: fnOnSelected="GenerarCodigoProyecto" 
            // esta fuccion javascript activa el evento del boton  function GenerarCodigoProyecto(value, itemBE){ ... document.getElementById('btnGenProyectoID').click();
            // ese boton "btnGenProyectoID" hace referencia a este metodo que se ejecuta en un clic OnClick="GenProyectoId": GenProyectoId 


            try
            {
                string resultado;
                resultado = (new ProyectoSoapClient()).GEN_PROYECTO_ID(eDDLCentros.SelectedValue,(eDDLUnidadO.SelectedValue=="C") ? "SC": eDDLUnidadO.SelectedValue, eDDLLineasN.SelectedValue, eDDLSubLineasN.SelectedValue, acCliente.GetValue());
                if (!string.IsNullOrEmpty(resultado))
                {
                    if(txtModo.Value  =="N")
                    { 
                    lblSubtitulo.Visible = true;
                    lblSubtitulo.Text = "Cod. Proyecto";
                    txtCodProyecto.Visible = true;
                    txtCodProyecto.Text = resultado;
                    }
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
        protected void EasyGridOTsProyecto_PageIndexChanged(object sender, EventArgs e)
        {
            this.LlenarGrilla("");

            // Mantener el acordeón abierto
            ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirAcordeonOT", "$('#collapseOT').collapse('show');", true);

        }

        #region Adenda  
        protected void EasyGridAdendas_PageIndexChanged(object sender, EventArgs e)
            {
                //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
                // this.LlenarGrilla("");
            }
            protected void EasyGridOTsProyecto_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
            {
                try
                {
                    switch (oEasyGridButton.Id)
                    {
                    
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
            protected void EasyGridAdendas_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
            {      
                try
                {
                    string resultado;
                    string script;
                    switch (oEasyGridButton.Id)
                    {                
                        case "btnAgregarAdenda":

                        if (!string.IsNullOrEmpty(txtCodProyecto.Text))
                        {
                            if (string.IsNullOrEmpty(txtMontoContr.Text) && ltMoneda.SelectedValue == "-1" )
                            {
                                script = "<script>";
                                script += "Swal.fire({title: 'Alerta Adenda',text:'Se requiere colocar Monto del Proyecto y/o Moneda', icon: 'error', confirmButtonText: 'Aceptar', confirmButtonColor: '#3085d6', allowOutsideClick: false});";
                                script += "</script>";
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);

                            }
                                
                                    script = "<script>";
                                    script += "epuAdenda.Show();";
                                    script += "</script>";
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "MostrarPopupAdenda", script, false);
                                
                            
                                txtPopMontoContractual.Text = "";
                                ltPopMoneda.LoadData();
                                ltPopMoneda.SetValue("-1");
                                txtFlag.Value = "1";
                                txtPopcodProyecto.Value = txtCodProyecto.Text;

                            
                        }
                        else
                        {
                            script = "<script>";
                            script += "Swal.fire({title: 'Alerta en Adenda',text:'Se requiere colocar código de Proyecto', icon: 'success', confirmButtonText: 'Aceptar', confirmButtonColor: '#3085d6', allowOutsideClick: false});";
                            script += "</script>";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);
                        }
                                break;
                        case "btnEliminarAdenda":
                            if (Recodset.Count == 0)
                            {
                                 script = "<script>";
                                script += "toastr.error('Debe seleccionar el registro a eliminar', 'Requerido');";
                                script += "</script>";
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);

                            }
                            else
                            {
                                resultado = (new ProyectoSoapClient()).DEL_ADENDAPROYECTO(Recodset["V_PROYADE_CODPRY"], Recodset["N_PROYADE_NROADENDA"],this.UsuarioLogin);

                                if (resultado == "1")
                                {
                                    script = "<script>";
                                    script += "Swal.fire({title: 'Exito',text:'Adenda eliminada', icon: 'success', confirmButtonText: 'Aceptar', confirmButtonColor: '#3085d6', allowOutsideClick: false});";
                                    script += "</script>";
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);
                                    EasyGridAdendas.LoadData("");
                                }
                                else
                                {
                                     script = "<script>";
                                    script += "toastr.error('Error al interntar eliminar adenda', 'Requerido');";
                                    script += "</script>";
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Validaciones", script, false);
                                }



                            }
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

            protected void ActualizarGrillaAdendas(object sender, EventArgs e)
            {
                try
                {
                    EasyGridAdendas.LoadData("");
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
        #endregion

        #region Personal    
        protected void btnPersonal_Click(object sender, EventArgs e)
        {
            try
            {
              
                //this.epuColaboradores.ViewStateMode = ViewStateMode.Enabled; // para que se mantenga el estado de la ventana emergente
              //  epuColaboradores.Visible = true;
                EasyGridColaboradores.LoadData("");
             //   hfMostrarPopup.Value = "1"; // Indica que debe mostrarse el popup en el PreRender
                                            //pnlColaboradores.Style["display"] = "block";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirPopup", "mostrarPopup();", true);


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

        protected void btnAgregarColaborador_Click(object sender, EventArgs e)
        {
           

            int accion = ViewState["accion"] != null && ViewState["accion"].ToString() == "2" ? 2 : 1;
            lblmensaje.Text = "";
            string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

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
                    ip = Request.UserHostAddress;
                    // Si falla la resolución de DNS, se utiliza la IP
                }
            }
             
            var colaborador = new ColaboradorProyectoBE
            {
                N_ACCION = accion, // Puedes cambiar a 2 si ya existe
                Sucursal = string.IsNullOrEmpty(this.IdCentroOperativo) ? eDDLCentros.SelectedValue : this.IdCentroOperativo,
                V_COLPROY_SUCURSAL = string.IsNullOrEmpty(this.IdCentroOperativo) ? eDDLCentros.SelectedValue : this.IdCentroOperativo,
                V_COLPROY_PROYECTO = lblSubtitulo.Text.Trim(),
                DT_COLPROY_INGRESO = DateTime.TryParse(dtFechaIngreso.Text.Trim(), out DateTime f) ? f.ToString("dd/MM/yyyy") : "" ,
                V_COLPROY_PR = txtPR.Text.Trim(),
                V_COLPROY_CODTRA = txtCodTra.Text.Trim(),
                DT_COLPROY_CESE = DateTime.TryParse(dtFechaCese.Text.Trim(), out DateTime f1) ? f1.ToString("dd/MM/yyyy") : "" ,
                UserName = this.UsuarioLogin, // Reemplazar con usuario real
                Estacion = ip
            };

            string resultado = servicio.Ins_upd_ColaboradorProy(colaborador);
            // Puedes mostrar mensaje si deseas
            lblmensaje.Text = resultado;

            // Recargar grilla
            EasyGridColaboradores.LoadData("");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirPopup", "mostrarPopup();", true);
            //btnPersonal_Click(null, null);
        }


        /*
        protected void gvColaboradores_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "SelectFila")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvColaboradores.Rows[index];

                txtPR.Text = row.Cells[0].Text;
                txtCodTra.Text = row.Cells[1].Text.Trim();
                dtFechaIngreso.Text = row.Cells[2].Text.Trim();
                dtFechaCese.Text = row.Cells[3].Text.Trim();

                // Si deseas que el botón agregar funcione como actualizar, puedes guardar una bandera o cambiar N_ACCION
                ViewState["accion"] = "2"; // Luego lo usas en btnAgregarColaborador
            }
            else if (e.CommandName == "Eliminar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvColaboradores.Rows[index];

                string pr = row.Cells[0].Text;
                string codTra = row.Cells[1].Text;
                string fecIngreso = row.Cells[2].Text;

                var servicio = new ProyectoSoapClient();
                var colaborador = new ColaboradorProyectoBE
                {
                    Sucursal = "1",
                    V_COLPROY_SUCURSAL = "1",
                    V_COLPROY_PROYECTO = lblSubtitulo.Text.Trim(),
                    DT_COLPROY_INGRESO = fecIngreso,
                    V_COLPROY_PR = pr,
                    V_COLPROY_CODTRA = codTra,
                    UserName = "admin",
                    Estacion = Request.UserHostAddress
                };

                string resultado = servicio.Del_ColaboradorProy(colaborador);

                // Recargar grilla
                btnPersonal_Click(null, null);
            }
        }

        */
        #endregion

        #region Metodos_generales


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
        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            
            try
            {
                EasyGridOtsProyecto.LoadData("");
                // Script que hace scroll hacia el control
                string script = $"document.getElementById('{lblTituloOT.ClientID}').scrollIntoView();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollToLabel", script, true);

                // /GestionComercial/Proceso.asmx/ListarProyectos  .PKG_GERENCIAL.PR_GET_PROYECTOS
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

                if (string.IsNullOrWhiteSpace(txtDescripcion.Text))
                {
                    script += "toastr.error('Debe completar el campo descripcion.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtDescripcion.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtDescripcion.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }

                if (string.IsNullOrWhiteSpace(eDDLCentros.SelectedValue) || eDDLCentros.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe  seleccionar un valor en el campo centro operativo.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + eDDLCentros.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + eDDLCentros.ClientID + "').focus();"; // Poner el foco en el campo

                    esValido = false;
                }
                if (string.IsNullOrWhiteSpace(txtCodProyecto.Text))
                {
                    script += "toastr.error('No se genero el codigo de proyecto.', 'Requerido');";
                    // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                    script += "document.getElementById('" + txtCodProyecto.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtCodProyecto.ClientID + "').focus();"; // Poner el foco en el campo

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

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }




        #endregion

        protected void EasyGridColProyecto_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
            try
            {
                var opc = oEasyGridButton.Id.ToString();
                var servicio = new ProyectoSoapClient();
                switch (opc)
                {
               
                    case "btnAgregar":
                        
                        break;
                    case "btnInfoRel":
                        break;
                    case "btnEliminarCol":
                        string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

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
                                ip = Request.UserHostAddress;
                                // Si falla la resolución de DNS, se utiliza la IP
                            }
                        }

                        var colaborador = new ColaboradorProyectoBE
                        {
                            N_ACCION = 3, // Puedes cambiar a 2 si ya existe
                            Sucursal = string.IsNullOrEmpty(this.IdCentroOperativo) ? eDDLCentros.SelectedValue : this.IdCentroOperativo,
                            V_COLPROY_SUCURSAL = string.IsNullOrEmpty(this.IdCentroOperativo) ? eDDLCentros.SelectedValue : this.IdCentroOperativo,
                            V_COLPROY_PROYECTO = lblSubtitulo.Text.Trim(),
                            DT_COLPROY_INGRESO = DateTime.TryParse(dtFechaIngreso.Text.Trim(), out DateTime f) ? f.ToString("dd/MM/yyyy") : "",
                            V_COLPROY_PR = txtPR.Text.Trim(),
                            V_COLPROY_CODTRA = txtCodTra.Text.Trim(),
                            DT_COLPROY_CESE = DateTime.TryParse(dtFechaCese.Text.Trim(), out DateTime f1) ? f1.ToString("dd/MM/yyyy") : "",
                            UserName = this.UsuarioLogin, // Reemplazar con usuario real
                            Estacion = ip
                        };

                        string resultado = servicio.Del_ColaboradorProy(colaborador);
                        // Puedes mostrar mensaje si deseas
                        lblmensaje.Text = (resultado == "1") ? "Registro eliminado" : resultado;

                        // Recargar grilla
                        EasyGridColaboradores.LoadData("");
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirPopup", "mostrarPopup();", true);

                        break;
                    case "btnImprimir":
                        break;
                    default:
                        this.txtPR.Text = Recodset["V_COLPROY_PR"];
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

        protected void EasyGridColProyecto_PageIndexChanged(object sender, GridViewPageEventArgs e)
        {

        }

        protected void EGV_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {
            try { 
            string V_COLPROY_PROYECTO = Recodset["V_COLPROY_PROYECTO"].ToString();
            string DT_COLPROY_INGRESO = Recodset["DT_COLPROY_INGRESO"].ToString(); 
            string V_COLPROY_PR = Recodset["V_COLPROY_PR"].ToString(); 
            string V_COLPROY_CODTRA = Recodset["V_COLPROY_CODTRA"].ToString(); 
            string DT_COLPROY_CESE = Recodset["DT_COLPROY_CESE"].ToString(); 
            string PERSONAL = Recodset["PERSONAL"].ToString();

                lblmensaje.Text = ""; 
            lblSubtitulo.Text = V_COLPROY_PROYECTO;
            dtFechaIngreso.Text = DateTime.TryParse(DT_COLPROY_INGRESO.Trim(), out DateTime f) ? f.ToString("dd/MM/yyyy") : "" ;
            txtPR.Text = V_COLPROY_PR;
            txtCodTra.Text = V_COLPROY_CODTRA;
            dtFechaCese.Text = DateTime.TryParse(DT_COLPROY_CESE.Trim(), out DateTime g) ? g.ToString("dd/MM/yyyy") : "";
            lblTrabajador.Text = PERSONAL;
                if (!string.IsNullOrEmpty(txtPR.Text))
                    { 
                      ViewState["accion"] = "2";
                  }
                Dictionary<string, string> RowSelectd = EasyGridColaboradores.getDataItemSelected();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirPopup", "mostrarPopup();", true);
                 
                
                
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
        protected void EGVP_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {
            try
            {
                // CAPTURAMOS VALORES DE LA GRILLA
                string DT_FTPRESUPUESTO_FECHA   = Recodset["DT_FTPRESUPUESTO_FECHA"].ToString();
                string N_FTPRESUPUESTO_COSTOMOB = Recodset["N_FTPRESUPUESTO_COSTOMOB"].ToString();
                string N_FTPRESUPUESTO_COSTOMAT = Recodset["N_FTPRESUPUESTO_COSTOMAT"].ToString();
                string N_FTPRESUPUESTO_COSTOSER = Recodset["N_FTPRESUPUESTO_COSTOSER"].ToString();
                string N_FTPRESUPUESTO_COSTOIND = Recodset["N_FTPRESUPUESTO_COSTOIND"].ToString();
                

                lblmensaje.Text = "";
                ViewState["accionP"] = "2"; // MODO EDICION
                txtCostoDMAT.Text = N_FTPRESUPUESTO_COSTOMAT;   
                txtCostoDMOB.Text = N_FTPRESUPUESTO_COSTOMOB;   
                txtCostoDSER.Text = N_FTPRESUPUESTO_COSTOSER;
                txtCostoIND.Text = N_FTPRESUPUESTO_COSTOIND;
                txtfechaCP.Text = DT_FTPRESUPUESTO_FECHA;

                //Dictionary<string, string> RowSelectd = EasyGridColaboradores.getDataItemSelected();


                // En el code-behind (GenerarProyecto.aspx.cs), por ejemplo al final del handler:
                hfCollapseOne2Open.Value = "true";

                // Y, si el postback es parcial dentro de UpdatePanel, inyecta re-apertura explícita:
                ScriptManager.RegisterStartupScript(
                    this,
                    this.GetType(),
                    "keepCollapseOne2Open",
                    "$('#collapseOne2').collapse('show'); $('[data-target=\"#collapseOne2\"]').attr('aria-expanded','true');",
                    true
                );

                txtCostoDMAT.Focus();  

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

        protected void btnCerrarPopup_Click(object sender, EventArgs e)
        {
            ViewState["accion"] = "1";
        }

        protected void btnGaleria_Click(object sender, EventArgs e)
        {

        }
        protected void btnCostos_Click(object sender, EventArgs e)
        {
            string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

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

            string fecha = txtfechaCP.Text.Trim();

            string sauditoria =
                (string.IsNullOrEmpty(fecha) ? "" : fecha + " - ") +
                "Inserta Presupuesto de proyecto - ficha técnica - btnCostos_Click " +
                DateTime.Now;


            string s_accion = ViewState["accionP"] as string ?? "1";


            string result = oProyectos.InsUpdDel_ProyectoPresupuesto(s_accion, txtCodProyecto.Text , eDDLCentros.SelectedValue, txtCostoDMOB.Text, txtCostoDMAT.Text, txtCostoDSER.Text, txtCostoIND.Text,
                this.UsuarioLogin, ip, sauditoria);

            if (result != null)
            {
                if (result != "result")
                {
                    string scriptSuccess = $"Swal.fire('Éxito', 'Costos Registrados: {result}', 'success');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertSuccess", scriptSuccess, true);
                    CargarModoModificar(); // luego de registrar nuevo debe cargarse el modo de modificar para evitar duplicidad

                }
                else
                {
                    string scriptSuccess = $"Swal.fire('Éxito', 'Costos No registrados: {result}', 'success');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertSuccess", scriptSuccess, true);
                }

            }
            else
            {
                string scriptSuccess = $"Swal.fire('Éxito', 'Costos No registrados: {result}', 'success');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertSuccess", scriptSuccess, true);
            }

            EGVPresupuesto.LoadData("");

            // En el code-behind (GenerarProyecto.aspx.cs), por ejemplo al final del handler:
            hfCollapseOne2Open.Value = "true";

            // Y, si el postback es parcial dentro de UpdatePanel, inyecta re-apertura explícita:
            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "keepCollapseOne2Open",
                "$('#collapseOne2').collapse('show'); $('[data-target=\"#collapseOne2\"]').attr('aria-expanded','true');",
                true
            );

            txtCostoDMAT.Focus();
        }
        protected void btnDocumentos_Click(object sender, EventArgs e)
        {

        }

        protected void BtnBuscar_Colaborador(object sender, EventArgs e)
        {
            try
            { 

            string scentro = Session["IdCentro"].ToString() ;
            string codigo = string.IsNullOrWhiteSpace(txtPR.Text) ? txtCodTra.Text : txtPR.Text;
                lblmensaje.Text = "";
                dt = servicio.Buscar_Colaborador_xCod(scentro, codigo);
                if (dt != null && dt.Rows.Count > 0)
                {
                    // Accedemos a la primera fila
                    string nombre = dt.Rows[0]["NOMBRES"].ToString();
                    string fingreso = dt.Rows[0]["FEC_INILAB"].ToString();
                    string fcese = dt.Rows[0]["FEC_TERLAB"].ToString();
                    string Codtra = dt.Rows[0]["CODTRA"].ToString();
                    string PR = dt.Rows[0]["PR"].ToString();
                    lblTrabajador.Text = nombre;
                    dtFechaIngreso.Text = DateTime.TryParse(fingreso.Trim(), out DateTime f) ? f.ToString("dd/MM/yyyy") : "";
                    dtFechaCese.Text    = DateTime.TryParse(fcese.Trim(), out DateTime g) ? g.ToString("dd/MM/yyyy") : "";
                    txtCodTra.Text = Codtra;
                    txtPR.Text = PR;
                }
                else
                {
                    // Si no hay datos
                    lblTrabajador.Text = "No se encontró colaborador";
                    string scriptInfo = "Swal.fire('Atención', 'No se encontró ningún colaborador con el código ingresado.', 'info');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertInfo", scriptInfo, true);
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirPopup", "mostrarPopup();", true);
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