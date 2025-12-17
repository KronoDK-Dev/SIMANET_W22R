using SIMANET_W22R;
using SIMANET_W22R.InterfaceUI;

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionPersonal.EvaluacionDesempenio
{
    public partial class Evaluador_Evaluado : PaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    CargarEvaluadores();
            //}

            btnAgregarTrabajador.Enabled = false;

        }

    

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string dni = txtDNI.Text.Trim();
            BuscarEvaluadorPorDNI(dni);
            txtDNI.Enabled = false;

        }

        private void BuscarEvaluadorPorDNI(string dni)
        {
            if (string.IsNullOrEmpty(dni))
                return;

            string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ConfigObtenerEvaluadorPorDNI", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Dni", dni);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet dsevalua = new DataSet();

                try
                {
                    da.Fill(dsevalua);

                    bool tieneEvaluador = dsevalua.Tables.Count > 0 && dsevalua.Tables[0].Rows.Count > 0;
                    bool tieneEvaluados = dsevalua.Tables.Count > 1 && dsevalua.Tables[1].Rows.Count > 0;

                    // ====== DATOS DEL EVALUADOR ======
                    if (tieneEvaluador)
                    {
                        DataRow row = dsevalua.Tables[0].Rows[0];

                        txtNombresyApellidos.Text = row["NombresyApellidos"].ToString();
                        txtCargo.Text = row["Cargo"].ToString();
                        txtArea.Text = row["Area"].ToString();
                        txtGrado.Text = row["Grado"].ToString();

                        btnAgregarTrabajador.Enabled = true;
                    }
                    else
                    {
                        txtNombresyApellidos.Text = "";
                        txtCargo.Text = "";
                        txtArea.Text = "";
                        txtGrado.Text = "";
                        btnAgregarTrabajador.Enabled = false;
                    }

                    // ====== LISTADO DE EVALUADOS ======
                    if (tieneEvaluados)
                    {
                        gvEvaluados.DataSource = dsevalua.Tables[1];
                        gvEvaluados.DataBind();
                    }
                    else
                    {
                        gvEvaluados.DataSource = null;
                        gvEvaluados.DataBind();
                    }

                    // ====== ALERTAS ======
                    if (!tieneEvaluador && !tieneEvaluados)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "Swal.fire({ icon: 'warning', title: 'No encontrado', text: 'No se encontraron datos del evaluador ni evaluados.' });", true);
                    }
                    else if (!tieneEvaluador && tieneEvaluados)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "Swal.fire({ icon: 'info', title: 'Evaluador no registrado', text: 'Se encontraron evaluados, pero no existe información del evaluador.' });", true);
                    }

                    Session["dsevalua1"] = dsevalua;
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        $"Swal.fire({{ icon: 'error', title: 'Error', text: '{ex.Message}' }});", true);
                }
            }
        }


        protected void btnBuscarEvaluador_Click(object sender, EventArgs e)
        {
            string dni = txtDNIE.Text.Trim();

            if (string.IsNullOrEmpty(dni))
            {
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_BuscarEvaluadorPorDNI", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DNI", dni);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtNuevoNombresE.Text = dr["Nombres"].ToString();
                    //txtNuevoApellidosE.Text = dr["Apellidos"].ToString();
                    if (dr["Apellidos"] != DBNull.Value && !string.IsNullOrWhiteSpace(dr["Apellidos"].ToString()))
                    {
                        txtNuevoApellidosE.Text = dr["Apellidos"].ToString();
                        txtNuevoApellidosE.Visible = true; // Mostrar el control
                        lblApellidos.Visible = true;
                    }
                    else
                    {
                        txtNuevoApellidosE.Visible = false; // Ocultar el control
                        lblApellidos.Visible = false;
                    }
                     
                    txtnuevoprE.Text = dr["PR"].ToString();
                    txtNuevoCargoE.Text = dr["Cargo"].ToString();
                    txtNuevoAreaE.Text = dr["Area"].ToString();
                    txtNuevoCategoriaE.Text = dr["Categoria"].ToString();
                    txtNuevoCentroOperativoE.Text = dr["CentroOperativo"].ToString();
                    txtUsuario.Text = dr["Usuario"].ToString();
                }
                else
                {
                    // Limpia campos si no se encuentra
                    txtNuevoNombresE.Text = "";
                    txtNuevoApellidosE.Text = "";
                    txtnuevoprE.Text = "";
                    txtNuevoCargoE.Text = "";
                    txtNuevoAreaE.Text = "";
                    txtNuevoCategoriaE.Text = "";
                    txtNuevoCentroOperativoE.Text = "";
                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModalE", "var myModalE = new bootstrap.Modal(document.getElementById('modalAgregarEvaluador')); myModalE.show();", true);

        }


        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            txtDNI.Text = "";
            txtDNI.Enabled = true;
            txtNombresyApellidos.Text = "";
            txtCargo.Text = "";
            txtArea.Text = "";
            txtGrado.Text = "";


            this.gvEvaluados.DataSource = null;
            this.gvEvaluados.DataBind();

        }


        protected void gvEvaluados_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chk = (CheckBox)e.Row.FindControl("chkSeleccionar");
                if (chk != null)
                {
                    int estado = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "EstadoEvaluado"));
                    chk.Checked = (estado == 0); // 👉 0 = activo = marcado
                }
            }
        }

        protected void chkSeleccionar_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chk.NamingContainer;

            string dniEvaluado = gvEvaluados.DataKeys[row.RowIndex]["DNI_Evaluado"].ToString();
            int nuevoEstado = chk.Checked ? 0 : 1;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ConfigObtenerEvaluadorPorDNI", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Dni", txtDNI.Text.Trim());
                    cmd.Parameters.AddWithValue("@DniEvaluado", dniEvaluado);
                    cmd.Parameters.AddWithValue("@EstadoEvaluado", nuevoEstado);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            CargarEvaluados();
        }


        private void CargarEvaluados()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
            {
                string dni = txtDNI.Text.Trim();
                BuscarEvaluadorPorDNI(dni);
                txtDNI.Enabled = false;

                using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ConfigObtenerEvaluadorPorDNI", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Dni", txtDNI.Text.Trim());

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    gvEvaluados.DataSource = ds.Tables[1];
                    gvEvaluados.DataBind();
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            txtNuevoDNI.Text = "";
            txtNuevoNombres.Text = "";
            //txtNuevoApellidos.Text = "";
            txtnuevopr.Text = "";
            txtNuevoCargo.Text = "";
            txtNuevoArea.Text = "";
            txtNuevoCategoria.Text = "";
            txtNuevoCentroOperativo.Text = "";
            btnAgregarTrabajador.Enabled = true;

            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal",
                        @"$('#modalAgregar').modal('hide'); 
              $('body').removeClass('modal-open');
              $('.modal-backdrop').remove();", true);

        }


        protected void btnCancelarEvaluador_Click(object sender, EventArgs e)
        {
            txtDNIE.Text = "";
            txtNuevoNombresE.Text = "";
            txtNuevoApellidosE.Text = "";
            txtnuevoprE.Text = "";
            txtNuevoCargoE.Text = "";
            txtNuevoAreaE.Text = "";
            txtNuevoCategoriaE.Text = "";
            txtNuevoCentroOperativoE.Text = "";

            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal",
                        @"$('#modalAgregarEvaluador').modal('hide');
              $('body').removeClass('modal-open');
              $('.modal-backdrop').remove();", true);




        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string dniEvaluador = txtDNI.Text.Trim();
            string dniNuevo = txtNuevoDNI.Text.Trim();
            string nombresNuevo = txtNuevoNombres.Text.ToUpper();
         // 06.10.25 se comenta por que se unira 
            //   string apellidosNuevo = txtNuevoApellidos.Text.Trim();
            string prnuevo = txtnuevopr.Text.Trim();
            string cargoNuevo = txtNuevoCargo.Text.Trim();
            string areaNueva = txtNuevoArea.Text.Trim();
            string categoriaNueva = txtNuevoCategoria.Text.Trim();
            string centrooperativo = txtNuevoCentroOperativo.Text.Trim();
            btnAgregarTrabajador.Enabled = true;

            txtNuevoDNI.Text = "";
            txtNuevoNombres.Text = "";
        //    txtNuevoApellidos.Text = "";
            txtnuevopr.Text = "";
            txtNuevoCargo.Text = "";
            txtNuevoArea.Text = "";
            txtNuevoCategoria.Text = "";
            txtNuevoCentroOperativo.Text = "";

            if (string.IsNullOrEmpty(dniEvaluador) || string.IsNullOrEmpty(dniNuevo))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                   "Swal.fire({ icon: 'warning', title: 'Atención', text: 'Debe ingresar un DNI válido.' });", true);
                return;
            }

            DataSet ds = Session["dsevalua1"] as DataSet;
            if (ds == null || ds.Tables.Count < 2)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                   "Swal.fire({ icon: 'warning', title: 'Atención', text: 'Debe buscar primero un evaluador.' });", true);
                return;
            }

            bool existeEvaluador = ds.Tables[0].Rows.Count > 0;
            if (!existeEvaluador)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                   "Swal.fire({ icon: 'error', title: 'Error', text: 'El evaluador no es válido.' });", true);
                return;
            }

            bool yaExiste = ds.Tables[1].AsEnumerable()
                .Any(r => r.Field<string>("DNI_Evaluado") == dniNuevo);

            if (yaExiste)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                    @"Swal.fire({
                        icon: 'warning',
                        title: 'Duplicado',
                        text: 'El trabajador ya está registrado para este evaluador.',
                        confirmButtonText: 'Aceptar'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $('#modalAgregar').modal('hide'); // ✅ Correcto para Bootstrap 4.5.2
                            $('body').removeClass('modal-open');
                            $('.modal-backdrop').remove();
                        }
                    });", true);

                return;


            }


            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ConfigInsertarEvaluadosPorDNI", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@DniEvaluador", dniEvaluador);
                    cmd.Parameters.AddWithValue("@DniEvaluado", dniNuevo);
                    cmd.Parameters.AddWithValue("@Nombres", nombresNuevo);
             // 06.10.25 Ya no esta separando lo apellidos 
                    cmd.Parameters.AddWithValue("@Apellidos", nombresNuevo);
                    cmd.Parameters.AddWithValue("@Pr", prnuevo);
                    cmd.Parameters.AddWithValue("@Cargo", cargoNuevo);
                    cmd.Parameters.AddWithValue("@Area", areaNueva);
                    cmd.Parameters.AddWithValue("@Categoria", categoriaNueva);
                    cmd.Parameters.AddWithValue("@CentroOperativo", centrooperativo);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        // ✅ Bootstrap 4 .modal('hide'); en la version 5 Funciona bootstrap.Modal.getInstance(...): por ello fallaria en algunos modales
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                           @"Swal.fire({
                            icon: 'success',
                            title: '¡Éxito!',
                            text: 'Trabajador agregado correctamente',
                            confirmButtonText: 'Aceptar'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                $('#modalAgregar').modal('hide');
                                $('body').removeClass('modal-open');
                                $('.modal-backdrop').remove();
                            }
                        });", true);


                        CargarEvaluados();
                      
                        // limpieza
                        txtNuevoDNI.Text = "";
                        txtNuevoNombres.Text = "";
                     //   txtNuevoApellidos.Text = "";
                        txtnuevopr.Text = "";
                        txtNuevoCargo.Text = "";
                        txtNuevoArea.Text = "";
                        txtNuevoCategoria.Text = "";
                        txtNuevoCentroOperativo.Text = "";

                        lblMensaje.Text = "";
                        
                       
                        //   ScriptManager.RegisterStartupScript(this, GetType(), "reloadPage", "location.reload();", true);
                    }
                    catch (Exception ex)
                    {
                        string mensaje = ex.Message.Replace("'", "").Replace(Environment.NewLine, " ");

                        string scriptError = $@"
                            Swal.fire({{
                                icon: 'error',
                                title: 'Error',
                                text: '{mensaje}'
                            }}).then(() => {{
                                // 🔹 Cierra el modal con jQuery (Bootstrap 4)
                                $('#modalAgregar').modal('hide');

                                // 🔹 Limpia backdrop y clases residuales
                                $('body').removeClass('modal-open');
                                $('.modal-backdrop').remove();

                                // 🔹 Espera a que se estabilice el DOM antes del focus
                                setTimeout(() => {{
                                    var btn = document.getElementById('{btnAgregarTrabajador.ClientID}');
                                    if (btn) btn.focus();
                                }}, 500);
                            }});
                        ";

                        ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptError, true);
                     
            

                        btnAgregarTrabajador.Focus(); 

                        /*
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            $@"Swal.fire({{
                            icon: 'error',
                            title: 'Error al guardar',
                            text: '{mensaje}',
                            confirmButtonText: 'Cerrar'
                        }}).then((result) => {{
                            var modalElement = document.getElementById('modalAgregar');
                            var modal = bootstrap.Modal.getInstance(modalElement) || new bootstrap.Modal(modalElement);
                            modal.hide();
                            document.body.classList.remove('modal-open');
                            document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
                    }});", true);
                        */
                    }

                }
            }

        }



        protected void btnGuardarEvaluador_Click(object sender, EventArgs e)
        {
            string dniEvaluadorN = txtDNIE.Text.Trim();
            string nombresN = txtNuevoNombresE.Text.Trim();
            string apellidosN = txtNuevoApellidosE.Text.Trim();  // usuario
            string prN = txtnuevoprE.Text.Trim();
            string cargoN = txtNuevoCargoE.Text.Trim();
            string areaN = txtNuevoAreaE.Text.Trim();
            string categoriaN = txtNuevoCategoriaE.Text.Trim();
            string centrooperativoN = txtNuevoCentroOperativoE.Text.Trim();
            string usuario = txtUsuario.Text.Trim();
            
            int idUsuarioLogeado = Convert.ToInt32(Session["idusuario"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ConfigInsertarEvaluadorPorDNI", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@DniEvaluador", dniEvaluadorN);
                    cmd.Parameters.AddWithValue("@Nombres", nombresN);
                    cmd.Parameters.AddWithValue("@Apellidos", apellidosN);  // usuario
                    cmd.Parameters.AddWithValue("@Pr", prN);
                    cmd.Parameters.AddWithValue("@Cargo", cargoN);
                    cmd.Parameters.AddWithValue("@Area", areaN);
                    cmd.Parameters.AddWithValue("@Categoria", categoriaN);
                    cmd.Parameters.AddWithValue("@CentroOperativo", centrooperativoN);
                    cmd.Parameters.AddWithValue("@Usuario", usuario); 

                    SqlParameter accionParam = new SqlParameter("@Accion", SqlDbType.VarChar, 20)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(accionParam);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        string accion = accionParam.Value.ToString();
                        con.Close();

                        string mensaje = accion == "INSERTADO" ?
                            "Evaluador agregado correctamente" :
                            "Evaluador actualizado correctamente";


                       // Se reemplaza:
                      // var modal = bootstrap.Modal.getInstance(document.getElementById('modalAgregarEvaluador'));
                       //  if (modal) { modal.hide(); }
                      //   por:
                      //  $('#modalAgregarEvaluador').modal('hide');

                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                             $@"Swal.fire({{
                                            icon: 'success',
                                            title: '¡Éxito!',
                                            text: '{mensaje}',
                                            confirmButtonText: 'Aceptar'
                                        }}).then((result) => {{
                                            if (result.isConfirmed) 
                                            {{
                                                $('#modalAgregarEvaluador').modal('hide');
                                                document.body.classList.remove('modal-open');
                                                document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
                                            }}
                                        }});", true);
                    }
                    catch (Exception ex)
                    {
                        string mensaje = ex.Message.Replace("'", "").Replace(Environment.NewLine, " ");
                        // Se reemplaza:
                        // var modal = bootstrap.Modal.getInstance(document.getElementById('modalAgregarEvaluador'));
                        //  if (modal) { modal.hide(); }
                        //   por:
                        //  $('#modalAgregarEvaluador').modal('hide');
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        $@"Swal.fire({{
                            icon: 'error',
                            title: 'Error al guardar',
                            text: '{mensaje}',
                            confirmButtonText: 'Cerrar'
                        }}).then((result) => {{
                            if (result.isConfirmed) {{
                                $('#modalAgregarEvaluador').modal('hide');
                                $('body').removeClass('modal-open');
                                $('.modal-backdrop').remove();
                            }}
                        }});", true);
                    }

                }
            }

        }



        protected void gvEvaluados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                string dniEvaluado = e.CommandArgument.ToString();

                DataSet ds = Session["dsevalua1"] as DataSet;
                if (ds != null && ds.Tables.Count > 1)
                {
                    DataRow row = ds.Tables[1].AsEnumerable()
                                    .FirstOrDefault(r => r.Field<string>("DNI_Evaluado") == dniEvaluado);

                    if (row != null)
                    {
                        txtEditDNI.Text = row["DNI_Evaluado"].ToString();
                        txtEditCO.Text = row["CO"].ToString();
                        txtEditNombres.Text = row["Nombres"].ToString();
                     // 06.10.2025 Comentado en esta version, se esta unificando
                        //   txtEditApellidos.Text = row["Apellidos"].ToString();
                        txtEditPR.Text = row["PR"].ToString();
                        txtEditCargo.Text = row["Cargo_Estructural"].ToString();
                        txtEditArea.Text = row["Area"].ToString();
                        txtEditCategoria.Text = row["Categoria"].ToString();

                        if (row.Table.Columns.Contains("Estado"))
                        {
                            int estadoObjetivos = Convert.ToInt32(row["EstadoO"]);
                            chkObjetivos.Checked = (estadoObjetivos == 0);
                        }

                        if (row.Table.Columns.Contains("EstadoC"))
                        {
                            int estadoCompetencia = Convert.ToInt32(row["EstadoC"]);
                            chkCompetencias.Checked = (estadoCompetencia == 0);
                        }

                        // Abrir el modal con JS
                        ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal",
                            "var modal = new bootstrap.Modal(document.getElementById('modalEditar')); modal.show();", true);
                    }
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                string dniEvaluado = e.CommandArgument.ToString();

                if (string.IsNullOrEmpty(dniEvaluado))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "Swal.fire({ icon: 'warning', title: 'Atención', text: 'No se pudo obtener el DNI del evaluado.', confirmButtonText: 'Aceptar' });",
                        true);
                    return;
                }

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ConfigEliminarEvaluadoPorDNI", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@DniEvaluado", dniEvaluado);

                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();

                            // Mensaje de éxito
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                @"Swal.fire({
                                                icon: 'success',
                                                title: '¡Eliminado!',
                                                text: 'El evaluado fue eliminado correctamente',
                                                confirmButtonText: 'Aceptar'
                                            });", true);

                            CargarEvaluados();
                        }
                        catch (Exception ex)
                        {
                            string mensaje = ex.Message.Replace("'", "").Replace(Environment.NewLine, " ");
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $@"Swal.fire({{
                            icon: 'error',
                            title: 'Error',
                            text: '{mensaje}',
                            confirmButtonText: 'Cerrar'
                        }});", true);
                        }
                    }
                }
            }

        }


        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ConfigActualizarEvaluadosPorDNI", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@DniEvaluado", txtEditDNI.Text.Trim());
                    // cmd.Parameters.AddWithValue("@NuevoEvaluador", ddlEditEvaluador.SelectedValue);
                    cmd.Parameters.AddWithValue("@Nombres", txtEditNombres.Text.Trim());
                   // 06.10.25 Se comenta este campo ya que se unificara en uno solo
                    // cmd.Parameters.AddWithValue("@Apellidos", txtEditApellidos.Text.Trim());
                    cmd.Parameters.AddWithValue("@Pr", txtEditPR.Text.Trim());
                    cmd.Parameters.AddWithValue("@CO", txtEditCO.Text.Trim());
                    cmd.Parameters.AddWithValue("@Cargo", txtEditCargo.Text.Trim());
                    cmd.Parameters.AddWithValue("@Area", txtEditArea.Text.Trim());
                    cmd.Parameters.AddWithValue("@Categoria", txtEditCategoria.Text.Trim());
                    cmd.Parameters.AddWithValue("@EstadoObjetivos", chkObjetivos.Checked ? 0 : 1);
                    cmd.Parameters.AddWithValue("@EstadoCompetencias", chkCompetencias.Checked ? 0 : 1);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        // Se reemplaza: bootstrap 5 por 4.5.2
                        // var modal = bootstrap.Modal.getInstance(document.getElementById('modalAgregarEvaluador'));
                        //  if (modal) { modal.hide(); }
                        //   por:
                        //  $('#modalAgregarEvaluador').modal('hide');

                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        @"Swal.fire({
                            icon: 'success',
                            title: '¡Éxito!',
                            text: 'Datos actualizados correctamente',
                            confirmButtonText: 'Aceptar'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                $('#modalEditar').modal('hide');
                                $('body').removeClass('modal-open');
                                $('.modal-backdrop').remove();
                            }
                        });", true);

                        // Refrescar la lista
                        CargarEvaluados();
                    }
                    catch (Exception ex)
                    {
                        string mensaje = ex.Message.Replace("'", "").Replace(Environment.NewLine, " ");
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        $@"Swal.fire({{
                            icon: 'error',
                            title: 'Error al actualizar',
                            text: '{mensaje}',
                            confirmButtonText: 'Cerrar'
                        }}).then((result) => {{
                            if (result.isConfirmed) {{
                                $('#modalEditar').modal('hide');
                                $('body').removeClass('modal-open');
                                $('.modal-backdrop').remove();
                            }}
                        }});", true);

                    }
                }
            }
        }


       

    }
}