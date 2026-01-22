using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionComercial;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionComercial.Administracion
{
    public partial class GenerarSolicitud : BaseComercial, IPaginaBase
    {
        readonly string s_Ambiente = ConfigurationManager.AppSettings["Ambiente"];

        protected void Page_Load(object sender, EventArgs e)
        {
            // this.IdGeneral es una propiedad de la clase PaginaBase.cs
            if (this.ModoPagina.ToString().Equals("M") && !string.IsNullOrEmpty(this.IdGeneral))
            {
                nroSOL.InnerText = "N° SOLICITUD: " + this.IdGeneral;
                CargarModoModificar(this.IdGeneral);
                if (!IsPostBack) // Cargar datos solo en la primera carga
                {
                    CargarModoModificar(this.IdGeneral);
                }
            }
            else
            {
                CargarModoNuevo();
            }

            if (this.IdCentroOperativo != "1")
            {
                secAlojamiento.Visible = false;
                secInfoOperativa.Visible = false;
                secMantenimiento.Visible = false;
                ctrlASolicitante.Visible = false;
            }
            else
            {
                ctrlSublinea.Visible = true;  //ltSubLinea
                ltUnidadOpe.Visible = false;
                lblUnidadOpera.Visible = false;

            }
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
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

        public void CargarModoNuevo()
        {
            try
            {
                // en caso el usuario tenga la opcion de administador para registrar en varios centros operativos


                if (eDDLCentros.Items.Count == 0)
                {
                    int idcentro;
                    eDDLCentros.LoadData();
                    //-- VERIFICA QUE CARGUE
                    if (eDDLCentros.Items.Count == 0)
                    {


                    }

                    /*
                    switch (int.Parse(this.IdCentroOperativo))
                    {
                        case 3:
                            idcentro = 2;
                            break;
                        case 2:
                            idcentro = 3;
                            break;
                        default:
                            idcentro = int.Parse(this.IdCentroOperativo); // Si no es 2 ni 3, mantener el valor original
                            break;
                    }

                    eDDLCentros.SelectedIndex = idcentro;
                    */
                    eDDLCentros.SelectedValue = this.IdCentroOperativo;
                }

                if (this.IdCentroOperativo == "1")
                {
                    string LN, CLSTR, SUBLN;
                    eDDLCentros.SelectedValue = this.IdCentroOperativo;

                    //llena el combo  de LINEAS
                    //   var dt = new GeneralSoapClient().SP_ListaLineas_NegxCEO(this.IdCentroOperativo, "", this.UsuarioLogin);
                    var dt = new GeneralSoapClient().ListaLineasNegxCEOxUO(this.IdCentroOperativo, "", this.UsuarioLogin);

                    ltLineas.DataSource = dt;
                    ltLineas.DataTextField = "NOMBRE";
                    ltLineas.DataValueField = "CODIGO";
                    ltLineas.DataBind();
                    ltLineas.Attributes.Add("data-required", "true");
                    //------------------------------
                    LN = Request.QueryString["LnNeg"];   // CAPTURA EL CODIGO DE LINEA ENVIADO
                    SUBLN = Request.QueryString["SUBLnNeg"];
                    CLSTR = Request.QueryString["ClaseT"];
                    if (LN != null)
                    {
                        ltLineas.SelectedValue = LN;
                    }
                    if (SUBLN != null)
                    {
                        if (ltSubLinea.Items.Count == 0)
                        {
                            var dt2 = new GeneralSoapClient().ListaSubLineasNegxCEOxUOxL(this.IdCentroOperativo, "", LN, this.UsuarioLogin);
                            ltSubLinea.DataSource = dt2;
                            ltSubLinea.DataTextField = "NOMBRE";
                            ltSubLinea.DataValueField = "CODIGO";
                            ltSubLinea.DataBind();
                            ltSubLinea.Attributes.Add("data-required", "true");
                        }
                        ltSubLinea.SelectedValue = SUBLN;
                        ltSubLinea.Visible = true;
                    }


                    acEmbarcacion.Attributes.Add("data-required", "true");
                    acCliente.Attributes.Add("data-required", "true");
                    if (ltTipoSolicitud.Items.Count < 2)
                    {
                        ltTipoSolicitud.LoadData();
                        ltTipoSolicitud.Attributes.Add("data-required", "true");
                    }

                    ltTipoTrabajo.LoadData();
                    ltTipoTrabajo.Attributes.Add("data-required", "true");


                    ltAreaSolicitante.LoadData();
                    ltAreaSolicitante.Attributes.Add("data-required", "true");

                    txtActividad.Attributes.Add("data-required", "true");
                    txtObservaciones.Attributes.Add("data-required", "true");

                    ltClaseTrabajo.Attributes.Add("data-required", "true");
                    ltClaseTrabajo.LoadData();

                    ltDiques.LoadData();

                    ltTarifas.LoadData();
                    ltTarifas.Attributes.Add("data-required", "true");

                    if (string.IsNullOrEmpty(txtNroSolMgp.Text) && string.IsNullOrEmpty(ltTipoSolicitud.SelectedValue))
                    {
                        if (ltTipoSolicitud.SelectedValue == "STR")
                        {
                            txtNroSolMgp.Attributes.Add("data-required", "true");
                        }
                    }
                    // DATOS POR DEFECTO
                    CargaDefault(SUBLN, CLSTR);

                }
                else // no es centro operativo 1
                {
                    eDDLCentros.SelectedValue = this.IdCentroOperativo;

                    ltUnidadOpe.LoadData(); // ListaUnidad_OpexCEO

                    // LINEAS
                    var dt = new GeneralSoapClient().SP_ListaLineas_NegxCEO(this.IdCentroOperativo, "", this.UsuarioLogin);


                    if (dt == null || dt.Rows.Count == 0)
                    {
                        // Crear un DataTable con un mensaje
                        System.Data.DataTable dtMensaje = new System.Data.DataTable();
                        dtMensaje.Columns.Add("NOMBRE", typeof(string));
                        dtMensaje.Columns.Add("CODIGO", typeof(string));

                        DataRow row = dtMensaje.NewRow();
                        row["NOMBRE"] = "El usuario no tiene centro operativo asignado";
                        row["CODIGO"] = "-1"; // Valor por defecto
                        dtMensaje.Rows.Add(row);

                        ltLineas.DataSource = dtMensaje;
                    }
                    else
                    {
                        ltLineas.DataSource = dt;
                    }

                    ltLineas.DataTextField = "NOMBRE";
                    ltLineas.DataValueField = "CODIGO";
                    ltLineas.DataBind();
                    ltLineas.Attributes.Add("data-required", "true");




                }

            }
            catch (Exception ex)
            {

                var result = "" + ex.Message;
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                this.LanzarException(methodName, ex);
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }

        public void CargaDefault(string s_Linea, string s_clase = "")
        {
            // DATOS POR DEFECTO
            if (s_Linea == "RN")
            {
                ltTipoSolicitud.SelectedIndex = 2;
                ltTipoTrabajo.SelectedIndex = 4;
                if (s_clase != "")
                { ltClaseTrabajo.SelectedValue = (s_clase); }
                else
                { ltClaseTrabajo.SelectedIndex = 5; }
                ltTarifas.SelectedIndex = 1;
            }
            else if (s_Linea == "DQ")
            {
                ltTipoSolicitud.SelectedIndex = 10;
                ltTipoTrabajo.SelectedIndex = 1;
                ltClaseTrabajo.SelectedIndex = 6;

                if (ltDiques.Items.Count <= 1)  // cargamos valores
                {
                    var dt = new GeneralSoapClient().ListaDiques(this.IdCentroOperativo, this.UsuarioLogin);
                    if (dt != null)
                    {
                        ltDiques.DataSource = dt;
                        ltDiques.DataTextField = "NOMBRE";
                        ltDiques.DataValueField = "CODIGO";
                        ltDiques.DataBind();
                        ltDiques.Attributes.Add("data-required", "true");
                    }
                }
            }
            else
            {
                ltTipoSolicitud.LoadData();
                ltTipoTrabajo.LoadData();

            }

            acEmbarcacion.Focus();
        }

        public void CargarModoModificar()
        {
            try
            {
                acEmbarcacion.SetReadOnly();
                acCliente.SetReadOnly();
                if (ltAreaSolicitante.Items.Count < 2)
                { ltAreaSolicitante.LoadData(); }

                ltAreaSolicitante.Enabled = false;
                ltLineas.AutoPostBack = false;
                if (ltLineas.Items.Count == 0)
                {
                    var dt = new GeneralSoapClient().SP_ListaLineas_NegxCEO(this.IdCentroOperativo, ltUnidadOpe.SelectedValue, this.UsuarioLogin);

                    ltLineas.DataSource = dt;
                    ltLineas.DataTextField = "NOMBRE";
                    ltLineas.DataValueField = "CODIGO";
                    ltLineas.DataBind();
                }


                if (ltSubLinea.Items.Count < 2)
                { ltSubLinea.LoadData(); }


                if (ltTipoSolicitud.Items.Count < 2)
                { ltTipoSolicitud.LoadData(); }

                if (ltTipoTrabajo.Items.Count < 2)
                { ltTipoTrabajo.LoadData(); }

                if (ltClaseTrabajo.Items.Count < 2)
                { ltClaseTrabajo.LoadData(); }

                if (ltDiques.Items.Count < 2)
                {
                    ltDiques.LoadData();

                }

                if (ltTarifas.Items.Count < 2)
                { ltTarifas.LoadData(); }

                if (ltUnidadOpe.Items.Count < 2)
                { ltUnidadOpe.LoadData(); } // 07.01.2025 


            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.ToString()); // 21.01.2026
                var result = "" + ex.Message;
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                this.LanzarException(methodName, ex);
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }

        public void CargarModoModificar(string v_solicitud)
        {
            string LN = "", SUBLN = "";
            try
            {
                var dt = (new SolicitudSoapClient()).DetalleSolicitud(this.IdCentroOperativo, this.IdGeneral, this.LineaNegocio, this.UsuarioLogin);

                //string sr = dt.Rows[0]["N° SOLICITUD"].ToString();
                lblnroSOL.Text = dt.Rows[0]["N° SOLICITUD"].ToString();

                // 07.01.2025 se adiciona mas campos en el sp PR_GET_DET_SOLICITUD
                if (eDDLCentros.Items.Count < 2)
                { eDDLCentros.LoadData(); }
                if (eDDLCentros.Items.Count > 1)
                { eDDLCentros.SelectedValue = this.IdCentroOperativo; }
                try
                {
                    if (ltUnidadOpe.Items.Count < 2)
                    { ltUnidadOpe.LoadData(); }
                    if (ltUnidadOpe.Items.Count > 1)
                    { ltUnidadOpe.SelectedValue = dt.Rows.Count > 0 && dt.Rows[0]["UND_OPE"] != DBNull.Value ? dt.Rows[0]["UND_OPE"].ToString().Trim() : string.Empty; }
                    else
                    { ltUnidadOpe.SelectedValue = dt.Rows.Count > 0 && dt.Rows[0]["UND_OPE"] != DBNull.Value ? dt.Rows[0]["UND_OPE"].ToString().Trim() : "-1"; }
                }
                catch { }
                lblestado.Text = dt.Rows[0]["EST_ATL"].ToString();

                if (!new[] { "SOL", "VAL", "EST", "PES", "TES" }.Contains(lblestado.Text))
                {
                    btnAgregar1.Visible = false;
                    btnAgregar.Visible = false;
                }

                //-----------------


                if (ltLineas.Items.Count < 2)
                { ltLineas.LoadData(); }
                SUBLN = dt.Rows[0]["LINEA"].ToString().Trim();

                var dt3 = new GeneralSoapClient().ListaLineaxCEOxSubLinea(this.IdCentroOperativo, SUBLN, this.UsuarioLogin);
                if (dt3 != null)
                {
                    if (dt3.Rows.Count > 0)
                    {
                        LN = dt3.Rows[0]["CODIGO"].ToString().Trim();
                    }
                    else
                    {
                        var result = "No se ha configurado las lineas de negocio para el usuario actual!";  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                        string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                        string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                        string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
                    }
                }

                ltLineas.SelectedValue = LN; // El valor de linea en realidad es sublinea pero para el sistema unsisys se trabaja como linea
                if (ltSubLinea.Items.Count == 0)
                {
                    var dt2 = new GeneralSoapClient().ListaSubLineasNegxCEOxUOxL(this.IdCentroOperativo, "", LN, this.UsuarioLogin);
                    ltSubLinea.DataSource = dt2;
                    ltSubLinea.DataTextField = "NOMBRE";
                    ltSubLinea.DataValueField = "CODIGO";
                    ltSubLinea.DataBind();
                    ltSubLinea.Attributes.Add("data-required", "true");
                }
                ltSubLinea.SelectedValue = SUBLN;

                if (ltDiques.Items.Count <= 1)  // cargamos valores
                {
                    var dt2 = new GeneralSoapClient().ListaDiques(this.IdCentroOperativo, this.UsuarioLogin);
                    if (dt2 != null)
                    {

                        // Crear una nueva fila, YA QUE NORMALMENTE LO CARGA EL CONTROL PERSONALIZADO
                        DataRow row = dt2.NewRow();
                        row["CODIGO"] = -1;
                        row["NOMBRE"] = "[Seleccionar...]";

                        // Insertar al inicio de la tabla
                        dt2.Rows.InsertAt(row, 0);

                        ltDiques.DataSource = dt2;
                        ltDiques.DataTextField = "NOMBRE";
                        ltDiques.DataValueField = "CODIGO";
                        ltDiques.DataBind();

                    }
                }

                if (ltTipoSolicitud.Items.Count < 2)
                { ltTipoSolicitud.LoadData(); }
                ltTipoSolicitud.SelectedValue = dt.Rows[0]["COD. TIP. SOL"].ToString();

                acEmbarcacion.SetValue((dt.Rows[0]["EMBARCACION / PROYECTO"].ToString()), dt.Rows[0]["COD. EMBPROY"].ToString());
                acCliente.SetValue((dt.Rows[0]["CLIENTE"].ToString()), dt.Rows[0]["COD. CLIENTE"].ToString());

                if (ltTipoTrabajo.Items.Count < 2)
                { ltTipoTrabajo.LoadData(); }

                ltTipoTrabajo.SelectedValue = dt.Rows[0]["COD. TIP. TBJ"].ToString();



                if (this.IdCentroOperativo == "1")
                {
                    if (ltAreaSolicitante.Items.Count < 2)
                    {
                        ltAreaSolicitante.LoadData();
                    }

                    if (!string.IsNullOrEmpty(dt.Rows[0]["A. SOLICITANTE"].ToString())) // (dt.Rows[0]["A. SOLICITANTE"].ToString() != null)
                    {
                        // ltAreaSolicitante.SelectedValue = dt.Rows[0]["A. SOLICITANTE"].ToString();
                        // Verificar si el valor existe en la lista de opciones del DropDownList
                        if (ltAreaSolicitante.Items.FindByValue(dt.Rows[0]["A. SOLICITANTE"].ToString()) != null)
                        {
                            ltAreaSolicitante.SelectedValue = dt.Rows[0]["A. SOLICITANTE"].ToString();
                        }
                        else
                        {
                            // Opcional: Si el valor no existe, podrías asignar un valor predeterminado o manejar el caso
                            if (ltAreaSolicitante.Items.Count > 0)
                            {
                                // si esta cerrada a ot de esta solicitud y estamos consultando un valor que ya no existe, lo debemos cargar
                                if (new[] { "TER", "ACC" }.Contains(lblestado.Text) && ltAreaSolicitante.SelectedValue == "-1")
                                {
                                    ltAreaSolicitante.Items.Add(new ListItem(dt.Rows[0]["A. SOLICITANTE"].ToString(), dt.Rows[0]["A. SOLICITANTE"].ToString()));
                                }
                                else
                                { ltAreaSolicitante.SelectedIndex = -1; } // Esto deselecciona cualquier opción
                            }

                        }
                    }
                }

                txtReferencia.SetValue(dt.Rows[0]["REFERENCIA"].ToString());
                dtFecReferencia.Text = dt.Rows[0]["D. REFERENCIA"] != DBNull.Value ? Convert.ToDateTime(dt.Rows[0]["D. REFERENCIA"]).ToString("dd/MM/yyyy") : "";
                txtActividad.Text = dt.Rows[0]["ACTIVIDAD"].ToString();
                txtObservaciones.Text = dt.Rows[0]["OBSERVACIONES"].ToString();



                if (!string.IsNullOrEmpty(dt.Rows[0]["CLS. TBJ"].ToString())) // (dt.Rows[0]["A. SOLICITANTE"].ToString() != null)
                {
                    // ltClaseTrabajo.SelectedValue = dt.Rows[0]["CLS. TBJ"].ToString();
                    // Verificar si el valor existe en la lista de opciones del DropDownList
                    if (ltClaseTrabajo.Items.Count < 2)
                    {
                        ltClaseTrabajo.LoadData();
                    }
                    try
                    {
                        ltClaseTrabajo.SelectedValue = dt.Rows[0]["CLS. TBJ"].ToString();
                    }
                    catch
                    {
                        ltClaseTrabajo.SelectedIndex = -1; // Esto deselecciona cualquier opción
                    }
                }


                if (ltDiques.Items.Count < 2)
                {
                    ltDiques.LoadData();

                }

                try
                {
                    ltDiques.SelectedValue = dt.Rows[0]["DIQUE"].ToString();
                }
                catch
                {
                    ltDiques.SelectedIndex = -1; // Esto deselecciona cualquier opción
                }


                if (ltTarifas.Items.Count < 2)
                {
                    ltTarifas.LoadData();
                }
                if (!string.IsNullOrEmpty(dt.Rows[0]["TARIFA"].ToString().Trim())) // (dt.Rows[0]["A. SOLICITANTE"].ToString() != null)
                {
                    // ltTarifas.SelectedValue = dt.Rows[0]["CLS. TBJ"].ToString();
                    // Verificar si el valor existe en la lista de opciones del DropDownList
                    if (ltTarifas.Items.FindByValue(ltTarifas.SelectedValue = dt.Rows[0]["TARIFA"].ToString().Trim()) != null)
                    {
                        // ltTarifas.SelectedValue = dt.Rows[0]["TARIFA"].ToString();
                        ltTarifas.SelectedValue = dt.Rows[0]["TARIFA"].ToString().Trim();
                    }
                    else
                    {
                        // Opcional: Si el valor no existe, podrías asignar un valor predeterminado o manejar el caso
                        if (ltTarifas.Items.Count > 0)
                        {
                            ltTarifas.SelectedIndex = -1; // Esto deselecciona cualquier opción
                        }

                    }
                }

                dtFecRecepcion1.Value = dt.Rows[0]["RECEPCION"] != DBNull.Value ? Convert.ToDateTime(dt.Rows[0]["RECEPCION"]).ToString("yyyy-MM-ddTHH:mm") : "";
                txtNroSolMgp.Text = dt.Rows[0]["NRO. SOL MGP"].ToString();

                if (dt.Rows[0]["FEC. SOL MGP"].ToString() != "")
                {
                    dtFecSolMgp.Text = Convert.ToDateTime(dt.Rows[0]["FEC. SOL MGP"]).ToString("dd/MM/yyyy");
                }

                txtEquipo.Text = dt.Rows[0]["EQUIPO"].ToString();
                txtUbicacion.Text = dt.Rows[0]["UBC. BIEN"].ToString();

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.ToString()); // 21.01.2026
                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                this.LanzarException(methodName, ex); // error para el log
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para ver en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }

        public bool ValidarDatos()
        {
            bool esValido = true;
            string script = "<script>";

            if (this.IdCentroOperativo == "1")
            {
                // Validar campo ltLineas
                if (string.IsNullOrEmpty(ltLineas.SelectedValue) || ltLineas.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe seleccionar una Línea de Negocio.', 'Requerido');";
                    script += "document.getElementById('" + ltLineas.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltLineas.ClientID + "').focus();";
                    esValido = false;
                }

                // Validar campo acEmbarcacion
                if (string.IsNullOrEmpty(acEmbarcacion.GetValue()) && ltLineas.SelectedValue != "SE")
                {
                    script += "toastr.error('El campo Embarcación/Proyecto es requerido.', 'Requerido');";
                    script += "document.getElementById('" + acEmbarcacion.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + acEmbarcacion.ClientID + "').focus();";
                    esValido = false;
                }

                // Validar campo acCliente
                if (string.IsNullOrEmpty(acCliente.GetValue()))
                {
                    script += "toastr.error('Debe seleccionar un cliente.', 'Requerido');";
                    script += "document.getElementById('" + acCliente.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + acCliente.ClientID + "').focus();";

                    esValido = false;
                }

                // Validar campo ltTipoSolicitud
                if (string.IsNullOrEmpty(ltTipoSolicitud.SelectedValue) || ltTipoSolicitud.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe seleccionar un Tipo de Solicitud.', 'Requerido');";
                    script += "document.getElementById('" + ltTipoSolicitud.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltTipoSolicitud.ClientID + "').focus();";

                    esValido = false;
                }

                // Validar campo ltTipoTrabajo
                if (string.IsNullOrEmpty(ltTipoTrabajo.SelectedValue) || ltTipoTrabajo.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe seleccionar un Tipo de Trabajo.', 'Requerido');";
                    script += "document.getElementById('" + ltTipoTrabajo.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltTipoTrabajo.ClientID + "').focus();";

                    esValido = false;
                }

                // Validar campo ltAreaUsuaria
                if (string.IsNullOrEmpty(ltAreaSolicitante.SelectedValue) || ltAreaSolicitante.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe seleccionar un AreaSolicitante.', 'Requerido');";
                    script += "document.getElementById('" + ltAreaSolicitante.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltAreaSolicitante.ClientID + "').focus();";
                    ltAreaSolicitante.Focus();
                    esValido = false;
                }

                //Validar campo txtActividad
                if (string.IsNullOrEmpty(txtActividad.Text))
                {
                    script += "toastr.error('Debe agregar valores al campo Actividad.', 'Requerido');";
                    script += "document.getElementById('" + txtActividad.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtActividad.ClientID + "').focus();";

                    esValido = false;
                }

                //Validar campo txtObservacion
                if (string.IsNullOrEmpty(txtObservaciones.Text))
                {
                    script += "toastr.error('Debe agregar valores al campo Observacion.', 'Requerido');";
                    script += "document.getElementById('" + txtObservaciones.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtObservaciones.ClientID + "').focus();";

                    esValido = false;
                }

                //Validar campo ltClaseTrabajo
                if (string.IsNullOrEmpty(ltClaseTrabajo.SelectedValue) || ltClaseTrabajo.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe Seleccionar Clase Trabajo.', 'Requerido');";
                    script += "document.getElementById('" + ltClaseTrabajo.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltClaseTrabajo.ClientID + "').focus();";

                    esValido = false;
                }

                //Validar campo ltTarifas
                if ((string.IsNullOrEmpty(ltTarifas.SelectedValue) || ltTarifas.SelectedValue == "-1") && ltLineas.SelectedValue == "DQ")
                {
                    script += "toastr.error('Debe Seleccionar Tarifa.', 'Requerido');";
                    script += "document.getElementById('" + ltTarifas.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltTarifas.ClientID + "').focus();";

                    esValido = false;
                }
                // validar nro solicitud MGP
                if (string.IsNullOrEmpty(txtNroSolMgp.Text) && string.IsNullOrEmpty(ltTipoSolicitud.SelectedValue))
                {
                    if (ltTipoSolicitud.SelectedValue == "STR")
                    {
                        script += "toastr.error('Debe agregar valores al campo Nro solicitud MGP.', 'Requerido');";
                        script += "document.getElementById('" + txtNroSolMgp.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                        script += "document.getElementById('" + txtNroSolMgp.ClientID + "').focus();";

                        esValido = false;
                    }
                }
                // Equipo  o bien
                if (string.IsNullOrEmpty(txtEquipo.Text) && ltLineas.SelectedValue == "SE")
                {
                    script += "toastr.error('Debe agregar valores al campo Equipo.', 'Requerido');";
                    script += "document.getElementById('" + txtEquipo.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtEquipo.ClientID + "').focus();";

                    esValido = false;
                }
                // unicacion del bien, en caso ingreso equipo
                if (string.IsNullOrEmpty(txtUbicacion.Text) && ltLineas.SelectedValue == "SE")
                {
                    script += "toastr.error('Debe agregar valores al campo Ubicación.', 'Requerido');";
                    script += "document.getElementById('" + txtUbicacion.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtUbicacion.ClientID + "').focus();";

                    esValido = false;
                }
            }
            else
            {
                if (string.IsNullOrEmpty(ltLineas.SelectedValue) || ltLineas.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe seleccionar una Línea de Negocio.', 'Requerido');";
                    script += "document.getElementById('" + ltLineas.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltLineas.ClientID + "').focus();";
                    esValido = false;
                }

                // Validar campo acEmbarcacion
                if (string.IsNullOrEmpty(acEmbarcacion.GetValue()))
                {
                    script += "toastr.error('El campo Embarcación/Proyecto es requerido.', 'Requerido');";
                    script += "document.getElementById('" + acEmbarcacion.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + acEmbarcacion.ClientID + "').focus();";
                    esValido = false;
                }

                // Validar campo acCliente
                if (string.IsNullOrEmpty(acCliente.GetValue()))
                {
                    script += "toastr.error('Debe seleccionar un cliente.', 'Requerido');";
                    script += "document.getElementById('" + acCliente.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + acCliente.ClientID + "').focus();";

                    esValido = false;
                }

                // Validar campo ltTipoSolicitud
                if (string.IsNullOrEmpty(ltTipoSolicitud.SelectedValue) || ltTipoSolicitud.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe seleccionar un Tipo de Solicitud.', 'Requerido');";
                    script += "document.getElementById('" + ltTipoSolicitud.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltTipoSolicitud.ClientID + "').focus();";

                    esValido = false;
                }

                // Validar campo ltTipoTrabajo
                if (string.IsNullOrEmpty(ltTipoTrabajo.SelectedValue) || ltTipoTrabajo.SelectedValue == "-1")
                {
                    script += "toastr.error('Debe seleccionar un Tipo de Trabajo.', 'Requerido');";
                    script += "document.getElementById('" + ltTipoTrabajo.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + ltTipoTrabajo.ClientID + "').focus();";

                    esValido = false;
                }

                // Validar campo ltAreaUsuaria
                //if (string.IsNullOrEmpty(ltAreaSolicitante.SelectedValue) || ltAreaSolicitante.SelectedValue == "-1")
                //{
                //    if (this.IdCentroOperativo == "1")
                //    {
                //        script += "toastr.error('Debe seleccionar un Tipo de Trabajo.', 'Requerido');";
                //        script += "document.getElementById('" + ltAreaSolicitante.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                //        script += "document.getElementById('" + ltAreaSolicitante.ClientID + "').focus();";

                //        esValido = false;
                //    }

                //}

                //Validar campo txtActividad
                if (string.IsNullOrEmpty(txtActividad.Text))
                {
                    script += "toastr.error('Debe agregar valores al campo Actividad.', 'Requerido');";
                    script += "document.getElementById('" + txtActividad.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtActividad.ClientID + "').focus();";

                    esValido = false;
                }

                //Validar campo txtObservacion
                if (string.IsNullOrEmpty(txtObservaciones.Text))
                {
                    script += "toastr.error('Debe agregar valores al campo Observacion.', 'Requerido');";
                    script += "document.getElementById('" + txtObservaciones.ClientID + "').style.borderColor = 'red';"; // Cambiar borde a rojo
                    script += "document.getElementById('" + txtObservaciones.ClientID + "').focus();";

                    esValido = false;
                }
            }

            script += "</script>";

            if (!esValido)
            {
                // Registrar el script para que se ejecute en el cliente
                ClientScript.RegisterStartupScript(this.GetType(), "Validaciones", script);
            }

            return esValido;
        }

        protected void fnLineaNegocio(object sender, EventArgs e)  // evento de ltUniOper_
        {
            // capturamos los valores de este control unidad operativa
            DropDownList ddl = sender as DropDownList; // Casteamos el sender a DropDownList
            if (ddl != null)
            {
                string selectedValue = ddl.SelectedValue; // Obtenemos el valor seleccionado
                string selectedText = ddl.SelectedItem.Text; // Obtenemos el texto seleccionado

                // solo otros centros
                if (this.IdCentroOperativo != "1")
                {

                    if (ltLineas.Items.Count <= 1)
                    {
                        var dt = new GeneralSoapClient().SP_ListaLineas_NegxCEO(this.IdCentroOperativo, selectedValue, this.UsuarioLogin);


                        if (dt == null || dt.Rows.Count == 0)
                        {
                            // Crear un DataTable con un mensaje
                            System.Data.DataTable dtMensaje = new System.Data.DataTable();
                            dtMensaje.Columns.Add("NOMBRE", typeof(string));
                            dtMensaje.Columns.Add("CODIGO", typeof(string));

                            DataRow row = dtMensaje.NewRow();
                            row["NOMBRE"] = "El usuario no tiene centro operativo asignado";
                            row["CODIGO"] = "-1"; // Valor por defecto
                            dtMensaje.Rows.Add(row);

                            ltLineas.DataSource = dtMensaje;
                        }
                        else
                        {
                            ltLineas.DataSource = dt;
                            ltLineas.DataBind();
                        }
                    }
                }


            }


        }

        protected void fnSubLineaNegocio(object sender, EventArgs e)  // evento de ltUniOper_
        {
            if (ltAreaSolicitante.Items.Count < 2)
            {
                ltAreaSolicitante.LoadData();
            }
            // capturamos los valores de este control unidad operativa
            DropDownList ddl = sender as DropDownList; // Casteamos el sender a DropDownList
            if (ddl != null)
            {
                string selectedValue = ddl.SelectedValue; // Obtenemos el valor seleccionado
                string selectedText = ddl.SelectedItem.Text; // Obtenemos el texto seleccionado

                ltSubLinea.LoadData();

                if (ltSubLinea.Items.Count <= 1)
                {
                    var dt2 = new GeneralSoapClient().ListaSubLineasNegxCEOxUOxL(this.IdCentroOperativo, "", selectedValue, this.UsuarioLogin);
                    ltSubLinea.DataSource = dt2;
                    ltSubLinea.DataTextField = "NOMBRE";
                    ltSubLinea.DataValueField = "CODIGO";
                    ltSubLinea.DataBind();
                    ltSubLinea.Attributes.Add("data-required", "true");
                }
                CargaDefault(selectedValue);
            }


        }

        protected void btn_Agregar_Post(object sender, EventArgs e)
        {
            SolicitudBE oSolicitudBE = new SolicitudBE();

            try
            {
                if (!ValidarDatos())
                {
                    // Si hay errores, detener el procesamiento
                    return;
                }

                //CAMPOS DE INICIO
                oSolicitudBE.X_NRO_STR = Convert.ToInt32(this.IdGeneral);
                if (Convert.ToInt32(this.IdGeneral) > 0)
                {
                    oSolicitudBE.X_NRO_VAL = Convert.ToInt32(this.IdGeneral);
                }

                oSolicitudBE.X_COD_CEO = this.IdCentroOperativo;//"1";
                oSolicitudBE.X_COD_DIV = ltSubLinea.SelectedValue == "-1" ? ltLineas.SelectedValue : ltSubLinea.SelectedValue; // validamos si no elige que envie vacio
                //oSolicitudBE.X_SUBLINEA = ltSubLinea.SelectedValue;

                //Embarcación/Proyecto y Cliente
                oSolicitudBE.X_COD_UND = Convert.ToInt32(acEmbarcacion.GetValue());
                oSolicitudBE.X_COD_CLI = Convert.ToInt32(acCliente.GetValue());

                ////Información de Solicitud
                oSolicitudBE.X_TIP_STR = ltTipoSolicitud.SelectedValue == "-1" ? string.Empty : ltTipoSolicitud.SelectedValue;
                oSolicitudBE.X_TIP_TBJ = ltTipoTrabajo.SelectedValue == "-1" ? string.Empty : ltTipoTrabajo.SelectedValue; ;
                oSolicitudBE.X_COD_AUS = ltAreaSolicitante.SelectedValue == "-1" ? string.Empty : ltAreaSolicitante.SelectedValue;

                //// Fecha, Presupuesto, Revisión
                oSolicitudBE.X_REF_STR = txtReferencia.Text;
                oSolicitudBE.X_FEC_REF = dtFecReferencia.Text;
                oSolicitudBE.X_COD_PRESUPUESTO = txtPresupuesto.Text;
                oSolicitudBE.X_NRO_REVISION = txtRevision.Text;

                //Actividad y Observaciones
                oSolicitudBE.X_DES_ABR = txtActividad.Text;
                oSolicitudBE.X_DES_DET = txtObservaciones.Text;

                //ESPECIFICACION DE ALOJAMIENTO
                oSolicitudBE.X_CLS_TBJ = ltClaseTrabajo.SelectedValue == "-1" ? string.Empty : ltClaseTrabajo.SelectedValue;
                oSolicitudBE.X_DIQUE = ltDiques.SelectedValue == "-1" ? string.Empty : ltDiques.SelectedValue; // validacion de valor -1 en listas

                oSolicitudBE.X_TIP_TAR = ltTarifas.SelectedValue == "-1" ? string.Empty : ltTarifas.SelectedValue; ;
                //--- 09.01.2025 solo si es nuevo registro coloco ese estado, sino dejo el actual --
                if (string.IsNullOrEmpty(this.lblnroSOL.Text))
                { oSolicitudBE.X_EST_ATL = "SOL"; }
                else
                { oSolicitudBE.X_EST_ATL = lblestado.Text.Trim(); }

                //INFORMACION OPERATIVA
                oSolicitudBE.X_FEC_RCP_STR = DateTime.Parse(dtFecRecepcion1.Value).ToString("dd/MM/yyyy");
                oSolicitudBE.X_HRA_RCP_STR = DateTime.Parse(dtFecRecepcion1.Value).ToString("dd/MM/yyyy HH:mm:ss"); // DD/MM/YYYY HH24:MI:SS  dtFecRecepcion.Text + " " + DateTime.Now.ToString("HH:mm:ss");
                oSolicitudBE.X_REF_STR_MGP = txtNroSolMgp.Text;
                oSolicitudBE.X_FEC_REF_MGP = dtFecSolMgp.Text;

                ////MANTENIMIENTO
                //oSolicitudBE.X_COD_EQP = Convert.ToInt32(txtEquipo.Text);
                oSolicitudBE.X_COD_EQP = int.TryParse(txtEquipo.Text.Trim(), out int equipoValue) ? equipoValue : 0;
                oSolicitudBE.X_UBC_EQP = txtUbicacion.Text;
                oSolicitudBE.X_FEC_STR = DateTime.Now.ToString("dd/MM/yyyy");

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

                oSolicitudBE.X_USR_REG = this.UsuarioLogin;
                oSolicitudBE.X_ESTACIONREGISTRO = ip;
                oSolicitudBE.ambiente = s_Ambiente;
                oSolicitudBE.V_AMBIENTE = s_Ambiente;
                // *********************PROCESAMIENTO****************************************************
                var result = (new SolicitudSoapClient()).InsertarSolicitud2(oSolicitudBE, this.UsuarioLogin);
                // *************************************************************************
                result = result.Replace("\n", "<br/>"); // Para que permita leer saltos
                if (Convert.ToInt32(this.IdGeneral) == 0)
                {

                    if (result.Contains("-:"))
                    {
                        string scriptSuccess = $"Swal.fire('Error', 'Solicitud NO Generada: {result}', 'error');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
                    }
                    else
                    {
                        if (result != null)
                        {
                            if (result != "result")
                            {
                                string scriptSuccess = $"Swal.fire('Éxito', 'Solicitud Generada: {result}', 'success');";
                                ScriptManager.RegisterStartupScript(this, GetType(), "alertSuccess", scriptSuccess, true);
                                CargarModoModificar(); // luego de registrar nuevo debe cargarse el modo de modificar para evitar duplicidad

                            }
                            else
                            {
                                string scriptSuccess = $"Swal.fire('Éxito', 'Solicitud NO Generada: {result}', 'success');";
                                ScriptManager.RegisterStartupScript(this, GetType(), "alertSuccess", scriptSuccess, true);
                            }

                        }
                        else
                        {
                            string scriptSuccess = $"Swal.fire('Éxito', 'Solicitud NO Generada: {result}', 'success');";
                            ScriptManager.RegisterStartupScript(this, GetType(), "alertSuccess", scriptSuccess, true);
                        }


                    }
                }
                else if ((Convert.ToInt32(this.IdGeneral) > 0 && result == "UPD") || result.Length > 10)
                {
                    if (!result.Contains("-:") && !result.Contains("FALLO"))
                    {
                        string scriptSuccess = $"Swal.fire('Éxito', 'La solicitud fue actualizada', 'success');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "alertSuccess", scriptSuccess, true);
                    }
                    else
                    {
                        string scriptError = $"Swal.fire('Error', 'Ocurrió un problema al guardar la solicitud.{result}', 'error');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptError, true);
                    }
                }
                else if (result == null || result == "null")
                {
                    string scriptError = "Swal.fire('Error', 'Ocurrió un problema al guardar la solicitud.', 'error');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptError, true);
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

        public void LlenarJScript()
        {
            throw new NotImplementedException();
        }

        public void RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }
    }
}