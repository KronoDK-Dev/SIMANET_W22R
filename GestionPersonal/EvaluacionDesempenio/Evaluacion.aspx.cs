using SIMANET_W22R.GestionComercial;
using SIMANET_W22R.GestionContabilidad.Estados;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SIMANET_W22R.GestionPersonal.EvaluacionDesempenio
{
    public partial class Evaluacion :  PaginaBase
    {
        string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;
        string usuarioSesion = string.Empty;
        #region "Metodos generales"

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

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

        public void LlenarDatos()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
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
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }
        #endregion

        private string ObtenerUsuarioSesion()
        {
            // 1️⃣ Primero busca en Session["Usuario"]
            if (Session["Usuario"] != null)
                return Session["Usuario"].ToString();

            // 2️⃣ Luego busca en this.DatosUsuario.Login si existe
            if (this.DatosUsuario != null && !string.IsNullOrEmpty(this.DatosUsuario.Login))
                return this.DatosUsuario.Login;

            // 3️⃣ Luego busca en Session["Login"]
            if (Session["Login"] != null)
                return Session["Login"].ToString();

            // 4️⃣ Si no encuentra nada, devuelve cadena vacía
            return string.Empty;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
         try { 

                  usuarioSesion = ObtenerUsuarioSesion();
           
            }
               catch (Exception ex)
                    {
                    string mensaje = ex.Message.Replace("'", "\\'");
                      ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
            }
        }



        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarEvaluadorPorDni(txtDNI.Text.Trim());
        }

        private void BuscarEvaluadorPorDni(string dni)
        {
            try { 

            if (string.IsNullOrEmpty(dni))
                return;

            string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ObtenerEvaluadorPorDNI", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Dni", dni);


                    //string usuarioSesion = Session["Usuario"] != null ? Session["Usuario"].ToString() : this.DatosUsuario.Login;
                    usuarioSesion = ObtenerUsuarioSesion();
                    cmd.Parameters.AddWithValue("@UsuarioSesion", usuarioSesion);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet dsevalua = new DataSet();

                try
                {
                    da.Fill(dsevalua);

                    // --- Tabla 0: Datos del evaluador ---
                    if (dsevalua.Tables.Count > 0 && dsevalua.Tables[0].Rows.Count > 0)
                    {
                        DataRow row = dsevalua.Tables[0].Rows[0];

                        txtNombresyApellidos.Text = row["NombresyApellidos"].ToString();
                        txtCargo.Text = row["Cargo"].ToString();
                        txtArea.Text = row["Area"].ToString();
                        txtGrado.Text = row["Grado"].ToString();
                    }
                    else
                    {
                        LimpiarCampos();
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "Swal.fire({ icon: 'warning', title: 'Atención', text: 'Evaluador no encontrado.' });", true);
                    }

                    // --- Tabla 1: Datos de los evaluados ---
                    if (dsevalua.Tables.Count > 1 && dsevalua.Tables[1].Rows.Count > 0)
                    {
                        gvEvaluados.DataSource = dsevalua.Tables[1];
                        gvEvaluados.DataBind();
                    }
                    else
                    {
                        gvEvaluados.DataSource = null;
                        gvEvaluados.DataBind();
                    }

                    Session["dsevalua"] = dsevalua;
                }
                catch (Exception ex)
                {
                    string mensaje = ex.Message.Replace("'", "\\'");
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
                }
            }

            txtDNI.Enabled = false;
        }
           catch (Exception ex)
                {
                string mensaje = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
            }
        }

        private void LimpiarCampos()
        {
            txtNombresyApellidos.Text = "";
            txtCargo.Text = "";
            txtArea.Text = "";
            txtGrado.Text = "";
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


        protected void btnmguardar_Click(object sender, EventArgs e)
        {
            // GUARDAR OBJETIVOS 
            List<ObjetivoEvaluado> lista = (List<ObjetivoEvaluado>)Session["ListaObjetivos"];

            for (int i = 0; i < gvEvaluadosdetail1.Rows.Count; i++)
            {
                GridViewRow fila = gvEvaluadosdetail1.Rows[i];
                DropDownList ddlCalificacion = (DropDownList)fila.FindControl("ddlCalificacion");

                if (ddlCalificacion != null && lista.Count > i)
                {
                    lista[i].Puntuacion = ddlCalificacion.SelectedValue;
                }
            }

            int idUsuarioLogeado = Convert.ToInt32(Session["idusuario"]);

            string cadenaConexion = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cadenaConexion))
            {
                conn.Open();

                foreach (var objetivo in lista)
                {
                    using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ActualizarEvaluacionObjetivos", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Dni_EvaObj", objetivo.DNI_Evaluado);
                        cmd.Parameters.AddWithValue("@Id_Obj", Convert.ToInt32(objetivo.Id_Obj));
                        cmd.Parameters.AddWithValue("@Puntuacion", Convert.ToString(objetivo.Puntuacion));
                        cmd.Parameters.AddWithValue("@IdUsuario", idUsuarioLogeado);
                        cmd.ExecuteNonQuery();
                    }
                }

                conn.Close();
            }

            Session["ListaObjetivos"] = lista;
            gvEvaluadosdetail1.DataSource = lista;
            gvEvaluadosdetail1.DataBind();
            BuscarEvaluadorPorDni(txtDNI.Text.Trim()); // para refrescar datos ADD. 18.10.25 by v.y.r

            cabecera();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal", "$('#PanelModal').modal('show');", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "initSelect", "$('.selectpicker').selectpicker('refresh');", true);
        }


        protected void btnm2guardar_Click(object sender, EventArgs e)
        {
            // --- ACTUALIZA COMPETENCIAS ---
            List<EvaluadoCompetencia> listaFiltrada = (List<EvaluadoCompetencia>)Session["listaFiltrada"];

            for (int i = 0; i < gvCompetenciasdetail.Rows.Count; i++)
            {
                GridViewRow fila = gvCompetenciasdetail.Rows[i];
                DropDownList ddlCalificacion = (DropDownList)fila.FindControl("ddlCalificacion");

                if (ddlCalificacion != null && listaFiltrada.Count > i)
                {
                    listaFiltrada[i].Puntuacion = ddlCalificacion.SelectedValue;
                }
            }

            int idUsuarioLogeado = Convert.ToInt32(Session["idusuario"]);

            string connectionString = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();


                foreach (var competencia in listaFiltrada)
                {
                    using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ActualizarEvaluacionCompetencia", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Dni", competencia.DNI_Evaluado);
                        cmd.Parameters.AddWithValue("@Id", Convert.ToInt32(competencia.Id_Comp));
                        cmd.Parameters.AddWithValue("@Puntuacion",Convert.ToString(competencia.Puntuacion));
                        cmd.Parameters.AddWithValue("@IdUsuario", idUsuarioLogeado);

                        cmd.ExecuteNonQuery();

                    }
                }
                conn.Close();
            }

            gvCompetenciasdetail.DataSource = listaFiltrada;
            gvCompetenciasdetail.DataBind();
            BuscarEvaluadorPorDni(txtDNI.Text.Trim()); // para refrescar datos ADD. 18.10.2025 BY V.Y.R

            cabecera();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal", "$('#PanelModal2').modal('show');", true);

            Session["listaFiltrada"] = listaFiltrada;
        }

        protected void chkSeleccionar_CheckedChanged(object sender, EventArgs e)
        {
           try { 
                    CheckBox chkSeleccionado = (CheckBox)sender;
                    GridViewRow filaSeleccionada = (GridViewRow)chkSeleccionado.NamingContainer;

                    foreach (GridViewRow fila in gvEvaluados.Rows)
                    {
                        CheckBox chk = (CheckBox)fila.FindControl("chkSeleccionar");

                        if (chk != chkSeleccionado)
                        {
                            chk.Checked = false;
                            fila.BackColor = System.Drawing.Color.White;
                        }
                    }

                    if (chkSeleccionado.Checked)
                    {
                        filaSeleccionada.BackColor = System.Drawing.Color.LightGreen;
                    }
                    else
                    {
                        filaSeleccionada.BackColor = System.Drawing.Color.White;
                    }

                }
               catch (Exception ex)
                    {
                    string mensaje = ex.Message.Replace("'", "\\'");
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                      $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
                    }
    }

        public class ObjetivoEvaluado
        {
            public string DNI_Evaluado { get; set; }
            public string Id_Obj { get; set; }
            public string Objetivo { get; set; }
            public string Puntuacion { get; set; }
            public int Estado { get; set; }
        }

        public class EvaluadoCompetencia
        {
            public string DNI_Evaluado { get; set; }
            public string Id_Comp { get; set; }
            public string Competencia { get; set; }
            public string Comportamiento { get; set; }
            public string Puntuacion { get; set; }
            public int EstadoC { get; set; }
        }

        protected void btncompetencias_Click(object sender, EventArgs e)
        {
            bool encontrado = false;

            DataSet dsevalua = (DataSet)Session["dsevalua"];

            if (dsevalua != null && dsevalua.Tables.Count > 0)
            {
                DataTable dt = dsevalua.Tables[1];

                foreach (GridViewRow fila in gvEvaluados.Rows)
                {
                    CheckBox chk = (CheckBox)fila.FindControl("chkSeleccionar");
                    if (chk != null && chk.Checked)
                    {
                        string dni = fila.Cells[3].Text.Trim();

                        DataRow[] resultado = dt.Select("DNI_Evaluado = '" + dni + "'");

                        if (resultado.Length > 0)
                        {
                            txtm2dni.Text = resultado[0]["DNI_Evaluado"].ToString();
                            txtm2nombresyapellidos.Text = resultado[0]["NombresyApellidos"].ToString();
                            txtm2cargo.Text = resultado[0]["Cargo_Estructural"].ToString();
                            txtm2area.Text = resultado[0]["Area"].ToString();
                            txtm2categoria.Text = resultado[0]["Categoria"].ToString();

                            string estadoc = resultado[0]["EstadoC"].ToString();
                            if (estadoc == "1" ||  estadoc == "True" )
                            {
                                btnm2guardar.Enabled = true;
                                btnm2guardar.Text = "Guardar";
                                btnm2guardar.CssClass = "btn btn-success"; // verde
                            }
                            else
                            {
                                btnm2guardar.Enabled = false;
                                btnm2guardar.Text = "Guardado";
                                btnm2guardar.CssClass = "btn btn-secondary"; // gris
                            }


                            string cadenaConexion = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

                            List<EvaluadoCompetencia> listaFiltrada = new List<EvaluadoCompetencia>();

                            using (SqlConnection conn = new SqlConnection(cadenaConexion))
                            {
                                SqlDataAdapter da = new SqlDataAdapter("RRHHevaluacion.sp_ObtenerEvaCompetenciasporDni", conn);
                                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                                DataTable dtSP = new DataTable();
                                da.Fill(dtSP);

                                foreach (DataRow filaSP in dtSP.Rows)
                                {
                                    if (filaSP["Dni_EvaComp"].ToString() == txtm2dni.Text)
                                    {
                                        listaFiltrada.Add(new EvaluadoCompetencia
                                        {
                                            DNI_Evaluado = filaSP["Dni_EvaComp"].ToString(),
                                            Id_Comp = filaSP["Id_Comp"].ToString(),
                                            Competencia = filaSP["Competencia"].ToString(),
                                            Comportamiento = filaSP["Comportamiento"].ToString(),
                                            Puntuacion = filaSP["Puntuacion"].ToString(),
                                        });
                                    }
                                }
                            }

                            gvCompetenciasdetail.DataSource = listaFiltrada;
                            gvCompetenciasdetail.DataBind();

                            Session["listaFiltrada"] = listaFiltrada;

                            ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal2", "$('#PanelModal2').modal('show');", true);

                            encontrado = true;
                            break;
                        }
                    }
                }
            }

            if (!encontrado)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alerta", "alert('Debe seleccionar un evaluado.');", true);
            }


        }

        protected void btnm2Terminar_Click(object sender, EventArgs e)
        {
            string dni = txtm2dni.Text;

            if (!string.IsNullOrEmpty(dni))
            {
                int estadoActual = ActualizarEstadoC(dni, 0); // actualiza y devuelve estado

                ConfigurarBotonGuardarC(estadoActual);

                cabecera();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "mostrarModal", "$('#PanelModal2').modal('show');", true);
            }
        }

        private int ActualizarEstadoC(string dni, int? nuevoEstado = null)
        {
            

            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();

                if (nuevoEstado.HasValue)
                {
                    using (SqlCommand cmdUpdate = new SqlCommand(
                        "UPDATE RRHHevaluacion.Evaluados SET EstadoC = @EstadoC WHERE DNI_Evaluado = @Dni", cn)) // @Estado
                    {
                        cmdUpdate.Parameters.AddWithValue("@EstadoC", nuevoEstado.Value);  // Estado
                        cmdUpdate.Parameters.AddWithValue("@Dni", dni);
                        cmdUpdate.ExecuteNonQuery();
                    }
                }

                using (SqlCommand cmdSelect = new SqlCommand(
                    "SELECT EstadoC FROM RRHHevaluacion.Evaluados WHERE DNI_Evaluado = @Dni", cn))
                {
                    cmdSelect.Parameters.AddWithValue("@Dni", dni);
                    object result = cmdSelect.ExecuteScalar();
                    return result != null ? Convert.ToInt32(result) : -1;
                }
            }
        }

        private int ObtenerEstadoDesdeBDC(string dni)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection cn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("SELECT EstadoC FROM RRHHevaluacion.Evaluados WHERE DNI_Evaluado = @Dni", cn))
            {
                cmd.Parameters.AddWithValue("@Dni", dni);
                cn.Open();

                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToInt32(result) : -1;
            }
        }

        private void ConfigurarBotonGuardarC(int estadoC)
        {
            if (estadoC == 1)
            {
                btnm2guardar.Text = "Guardar";
                btnm2guardar.CssClass = "btn btn-primary";
                btnm2guardar.Enabled = true;
            }
            else if (estadoC == 0)
            {
                btnm2guardar.Text = "Finalizado";
                btnm2guardar.CssClass = "btn btn-success";
                btnm2guardar.Enabled = false;
            }
            else
            {
                btnm2guardar.Text = "Otro Estado";
                btnm2guardar.CssClass = "btn btn-secondary";
                btnm2guardar.Enabled = false;
            }
        }

        protected void btnobjetivos_Click(object sender, EventArgs e)
        {
            bool encontrado = false;

            DataSet dsevalua = (DataSet)Session["dsevalua"];

            if (dsevalua != null && dsevalua.Tables.Count > 0)
            {
                DataTable dt = dsevalua.Tables[1];

                foreach (GridViewRow fila in gvEvaluados.Rows)
                {
                    CheckBox chk = (CheckBox)fila.FindControl("chkSeleccionar");
                    if (chk != null && chk.Checked)
                    {
                        string dni = fila.Cells[3].Text.Trim();

                        DataRow[] resultado = dt.Select("DNI_Evaluado = '" + dni + "'");

                        if (resultado.Length > 0)
                        {
                            txtmdni.Text = resultado[0]["DNI_Evaluado"].ToString();
                            txtmnombresyapellidos.Text = resultado[0]["NombresyApellidos"].ToString();
                            txtmcargo.Text = resultado[0]["Cargo_Estructural"].ToString();
                            txtmarea.Text = resultado[0]["Area"].ToString();
                            txtmcategoria.Text = resultado[0]["Categoria"].ToString();


                            // habilita boton de objetivos 
                            string estado = resultado[0]["EstadoO"].ToString();
                            if (estado == "1" || estado == "True")
                            {
                                btnmguardar.Enabled = true;
                                btnmguardar.Text = "Guardar";
                                btnmguardar.CssClass = "btn btn-success"; // verde
                            }
                            else
                            {
                                btnmguardar.Enabled = false;
                                btnmguardar.Text = "Guardado";
                                btnmguardar.CssClass = "btn btn-secondary"; // gris
                            }

                            string cadenaConexion = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;


                            List<ObjetivoEvaluado> listaFiltrada = new List<ObjetivoEvaluado>();

                            using (SqlConnection conn = new SqlConnection(cadenaConexion))
                            {
                                SqlDataAdapter da = new SqlDataAdapter("RRHHevaluacion.sp_ObtenerEvaObjetivosporDni", conn);
                                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                                DataTable dtSP = new DataTable();
                                da.Fill(dtSP);

                                foreach (DataRow filaSP in dtSP.Rows)
                                {
                                    if (filaSP["Dni_EvaObj"].ToString() == txtmdni.Text)
                                    {
                                        listaFiltrada.Add(new ObjetivoEvaluado
                                        {
                                            DNI_Evaluado = filaSP["Dni_EvaObj"].ToString(),
                                            Id_Obj = filaSP["Id_Obj"].ToString(),
                                            Objetivo = filaSP["Objetivo"].ToString(),
                                            Puntuacion = filaSP["Puntuacion"].ToString(),
                                        });
                                    }
                                }

                                Session["ListaObjetivos"] = listaFiltrada;
                            }

                            gvEvaluadosdetail1.DataSource = listaFiltrada;
                            gvEvaluadosdetail1.DataBind();

                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "activarSelect", "$('.selectpicker').selectpicker('refresh');", true);

                            ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "$('#PanelModal').modal('show');", true);
                            encontrado = true;
                            break;

                        }


                    }
                }

            }

            if (!encontrado)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alerta", "alert('Debe seleccionar un evaluado.');", true);
            }
        }

        protected void btnTerminar_Click(object sender, EventArgs e)
        {
            string dni = txtmdni.Text;

            if (!string.IsNullOrEmpty(dni))
            {
                int estadoActual = ActualizarEstadoEnBD(dni, 0); // actualiza y devuelve estado

                ConfigurarBotonGuardar(estadoActual);

                cabecera();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "mostrarModal", "$('#PanelModal').modal('show');", true);
            }
        }

        private int ActualizarEstadoEnBD(string dni, int? nuevoEstado = null)
        {
            
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();

                // Si viene nuevoEstado, hacemos UPDATE
                if (nuevoEstado.HasValue)
                {
                    using (SqlCommand cmdUpdate = new SqlCommand(
                        "UPDATE RRHHevaluacion.Evaluados SET EstadoO = @EstadoO WHERE DNI_Evaluado = @Dni", cn)) // SET EstadoO = @Estado
                    {
                        cmdUpdate.Parameters.AddWithValue("@EstadoO", nuevoEstado.Value); //@Estado
                        cmdUpdate.Parameters.AddWithValue("@Dni", dni);
                        cmdUpdate.ExecuteNonQuery();
                    }
                }

                // Siempre devolvemos el estado actual desde la BD
                using (SqlCommand cmdSelect = new SqlCommand(
                    "SELECT Estado FROM RRHHevaluacion.Evaluados WHERE DNI_Evaluado = @Dni", cn))
                {
                    cmdSelect.Parameters.AddWithValue("@Dni", dni);
                    object result = cmdSelect.ExecuteScalar();
                    return result != null ? Convert.ToInt32(result) : -1;
                }
            }
        }


        private int ObtenerEstadoDesdeBD(string dni)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection cn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("SELECT Estado FROM RRHHevaluacion.Evaluados WHERE DNI_Evaluado = @Dni", cn))
            {
                cmd.Parameters.AddWithValue("@Dni", dni);
                cn.Open();

                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToInt32(result) : -1;
            }
        }

        private void ConfigurarBotonGuardar(int estadoO)
        {
            if (estadoO == 1)
            {
                btnmguardar.Text = "Guardar";
                btnmguardar.CssClass = "btn btn-primary";
                btnmguardar.Enabled = true;
            }
            else if (estadoO == 0)
            {
                btnmguardar.Text = "Finalizado";
                btnmguardar.CssClass = "btn btn-success";
                btnmguardar.Enabled = false;
            }
            else
            {
                btnmguardar.Text = "Otro Estado";
                btnmguardar.CssClass = "btn btn-secondary";
                btnmguardar.Enabled = false;
            }

        }

        protected void gvEvaluados_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           try { 

                if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView rowView = (DataRowView)e.Row.DataItem;
                int metaObjetivo = Convert.ToInt32(rowView["MetaObjetivos"]);
                int competencias = Convert.ToInt32(rowView["Competencias"]);

                Image imgo = (Image)e.Row.FindControl("imgObjetivo");
                Image imgc = (Image)e.Row.FindControl("imgCompetencias");

                if (imgo != null)
                {
                    if (metaObjetivo == 1)
                    {
                        imgo.ImageUrl = "~/Recursos/img/ojito-verde.png";
                        imgo.ToolTip = "Objetivo completado";

                        //deshabilitarGuardar = true;
                    }
                    else
                    {
                        imgo.ImageUrl = "~/Recursos/img/ojito-rojo.png";
                        imgo.ToolTip = "Objetivo no completado";
                    }
                }

                if (imgc != null)
                {
                    if (competencias == 1)
                    {
                        imgc.ImageUrl = "~/Recursos/img/ojito-verde.png";
                        imgc.ToolTip = "Competencia completado";
                    }
                    else
                    {
                        imgc.ImageUrl = "~/Recursos/img/ojito-rojo.png";
                        imgc.ToolTip = "Competencia no completado";
                    }
                }
            }
                }
                 catch (Exception ex)
                        {
                            string mensaje = ex.Message.Replace("'", "\\'");
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
                        }
        }

       protected void gvEvaluadosdetail1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlCalificacion = (DropDownList)e.Row.FindControl("ddlCalificacion");

                if (ddlCalificacion != null)
                {
                    ddlCalificacion.Items.Clear();

                    ddlCalificacion.Items.Add(new ListItem("", ""));

                    for (int i = 0; i <= 100; i += 5)
                    {
                        ddlCalificacion.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    }

                    string puntuacion = DataBinder.Eval(e.Row.DataItem, "Puntuacion")?.ToString();

                    if (!string.IsNullOrEmpty(puntuacion))
                    {
                        ListItem item = ddlCalificacion.Items.FindByValue(puntuacion);
                        if (item != null)
                        {
                            ddlCalificacion.ClearSelection();
                            item.Selected = true;
                        }
                    }

                }

            }

        }

        protected void gvCompetenciasdetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlCalificacion = (DropDownList)e.Row.FindControl("ddlCalificacion");

                if (ddlCalificacion != null)
                {
                    ddlCalificacion.Items.Clear();

                    ddlCalificacion.Items.Add(new ListItem("", ""));

                    for (int i = 0; i <= 100; i += 5)
                    {
                        ddlCalificacion.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    }

                    string puntuacion = DataBinder.Eval(e.Row.DataItem, "Puntuacion")?.ToString();

                    if (!string.IsNullOrEmpty(puntuacion))
                    {
                        ListItem item = ddlCalificacion.Items.FindByValue(puntuacion);
                        if (item != null)
                        {
                            ddlCalificacion.ClearSelection();
                            item.Selected = true;
                        }
                    }
                }
            }
        }

        private void cabecera()
        {
            if (gvEvaluados.HeaderRow != null)
            {
                gvEvaluados.UseAccessibleHeader = true;
                gvEvaluados.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            if (gvEvaluadosdetail1.HeaderRow != null)
            {
                gvEvaluadosdetail1.UseAccessibleHeader = true;
                gvEvaluadosdetail1.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            if (gvCompetenciasdetail.HeaderRow != null)
            {
                gvCompetenciasdetail.UseAccessibleHeader = true;
                gvCompetenciasdetail.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }
        /*
        protected void lnkExcel_Command(object sender, CommandEventArgs e)
        {
            try { 
                    string dni = e.CommandArgument?.ToString();
                    if (string.IsNullOrEmpty(dni)) return;

                    // Reusar la lógica de GenerarExcel: obtener DataSet y generar byte[] fileBytes
                    byte[] fileBytes = GenerarBytesExcel(dni); // crea un método que devuelva el array
                    string fileName = $"Reporte_{dni}_{DateTime.Now:yyyyMMddHHmm}.xlsx";

                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("Content-Disposition", $"attachment; filename=\"{fileName}\"");
                    Response.BinaryWrite(fileBytes);
                    Response.Flush();
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                }
               catch (Exception ex)
                    {
                    string mensaje = ex.Message.Replace("'", "\\'");
                     ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
                    }

        }

        */
    }
}

