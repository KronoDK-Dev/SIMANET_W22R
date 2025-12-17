using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using System.IO;
using CrystalDecisions.Shared;
using Table = CrystalDecisions.CrystalReports.Engine.Table;
using SIMANET_W22R.InterfaceUI;

namespace SIMANET_W22R.GestionPersonal.EvaluacionDesempenio
{
    public partial class FormCalibracion : PaginaBase
    {
        string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;
        string usuarioSesion = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                usuarioSesion = ObtenerUsuarioSesion();

            }
        }

        //protected void btnRetro_Click(object sender, EventArgs e)
        //{

        //    Response.Redirect("~/Evaluacion.aspx");

        //}
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
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string dni = txtDNI.Text.Trim();

            if (!string.IsNullOrEmpty(dni))
            {
                

                using (SqlConnection con = new SqlConnection(cadena))
                {
                    SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_obtenerevaluadorcalibracion", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Dni", dni);
                    // 18.11.2025
                    string usuarioSesion = Session["Usuario"] != null ? Session["Usuario"].ToString() : string.Empty;

                    if (string.IsNullOrEmpty(usuarioSesion))
                    {
                        usuarioSesion = ObtenerUsuarioSesion();
                    }
                    cmd.Parameters.AddWithValue("@UsuarioSesion", usuarioSesion);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet dscalibracion = new DataSet();

                    try
                    {
                        da.Fill(dscalibracion);

                        // Tabla 0: Datos del evaluador
                        if (dscalibracion.Tables.Count > 0 && dscalibracion.Tables[0].Rows.Count > 0)
                        {
                            DataRow row = dscalibracion.Tables[0].Rows[0];

                            txtNombresyApellidos.Text = row["NombresyApellidos"].ToString();
                            txtCargo.Text = row["Cargo"].ToString();
                            txtArea.Text = row["Area"].ToString();
                            txtCategoria.Text = row["Categoria"].ToString();
                        }
                        else
                        {
                            txtNombresyApellidos.Text = "";
                            txtCargo.Text = "";
                            txtArea.Text = "";
                            txtCategoria.Text = "";
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Evaluador no encontrado.');", true);
                        }


                        if (dscalibracion.Tables.Count > 1 && dscalibracion.Tables[1].Rows.Count > 0)
                        {
                            gvCalibracionEvaluados.DataSource = dscalibracion.Tables[1];
                            gvCalibracionEvaluados.DataBind();
                        }
                        else
                        {
                            gvCalibracionEvaluados.DataSource = null;
                            gvCalibracionEvaluados.DataBind();
                        }



                        //Session["dsevalua"] = dsevalua;
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                    }
                }
                txtDNI.Enabled = false;
            }

        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            txtDNI.Text = "";
            txtDNI.Enabled = true;
            txtNombresyApellidos.Text = "";
            txtCargo.Text = "";
            txtArea.Text = "";
            txtCategoria.Text = "";
            txtObservaciones.Text = "";

            this.gvCalibracionEvaluados.DataSource = null;
            this.gvCalibracionEvaluados.DataBind();

            this.gvResultadoCompetencias.DataSource = null;
            this.gvResultadoCompetencias.DataBind();

            this.gvResultadosObjetivos.DataSource = null;
            this.gvResultadosObjetivos.DataBind();

        }

        protected void gvCalibracionEvaluados_SelectedIndexChanged(object sender, EventArgs e)
        {
            string dni = ((LinkButton)gvCalibracionEvaluados.SelectedRow.FindControl("lnkDNI")).Text;

            // Llama al SP con ese DNI
          //DataSet dst = ObtenerDetallesDesdeSP(dni);
            DataSet ds = ObtenerDetallesDesdeSP(dni);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                gvResultadoCompetencias.DataSource = ds.Tables[0];
                gvResultadoCompetencias.DataBind();
                gvResultadoCompetencias.Visible = true;
            }
            else
            {
                gvResultadoCompetencias.Visible = false;

            }

            if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 1)
            {
                gvResultadosObjetivos.DataSource = ds.Tables[1];
                gvResultadosObjetivos.DataBind();
                gvResultadosObjetivos.Visible = true;
            }
            else
            {
                gvResultadosObjetivos.Visible = false;
            }

            if (ds.Tables.Count > 0 && ds.Tables[2].Rows.Count > 0 && ds.Tables[3].Rows.Count > 0)
            {
                decimal factorxpromediocom = Convert.ToDecimal(ds.Tables[2].Rows[0]["FactorxPromedioCom"]);

                decimal factorxpromedioobj = Convert.ToDecimal(ds.Tables[3].Rows[0]["FactorxPromedioObj"]);

                txtresultado.Text = (factorxpromediocom + factorxpromedioobj).ToString("0.00") + " %";
            }
            else
            {
                txtresultado.Text = string.Empty; // Limpia si no hay datos
            }

            if (ds.Tables.Count > 0 && ds.Tables[2].Rows.Count > 0 && ds.Tables[3].Rows.Count > 0)
            {
                decimal nuevoresultadocom = Convert.ToDecimal(ds.Tables[2].Rows[0]["NuevaPuntuacionTotal"]);

                decimal nuevoresultadoobj = Convert.ToDecimal(ds.Tables[3].Rows[0]["NuevaPuntuacionTotal"]);

                txtnuevoresultado.Text = (nuevoresultadocom + nuevoresultadoobj).ToString("0.00") + " %";
            }
            else
            {
                txtnuevoresultado.Text = string.Empty; // Limpia si no hay datos
            }

            try
            {
                if (ds != null && ds.Tables.Count > 4 && ds.Tables[4].Rows.Count > 0)
                {
                    txtObservaciones.Text = Convert.ToString(ds.Tables[4].Rows[0]["Observaciones"]);
                }
                else
                {
                    txtObservaciones.Text = string.Empty;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error cargando observaciones: " + ex.Message);
                txtObservaciones.Text = string.Empty;
            }



            Session["dscalibracion"] = ds;
        }



        private DataSet ObtenerDetallesDesdeSP(string dni)
        {
            DataSet ds = new DataSet();
            

            using (SqlConnection conn = new SqlConnection(cadena))
            using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.ObtenerEvaluadosCalibracion", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DNI", dni);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }

            return ds;
        }

        protected void btngrabar_Click(object sender, EventArgs e)
        {
            DataSet dscalibracion = (DataSet)Session["dscalibracion"];
            if (dscalibracion == null || dscalibracion.Tables.Count == 0) return;
            string conexionString = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;
         //   string conexionString = "Data Source=DESKTOP-6BA7R2F;Initial Catalog=veronica;Integrated Security=True;";

            using (SqlConnection conn = new SqlConnection(conexionString))
            {
                conn.Open();

                DataTable dtCompetencias = dscalibracion.Tables[0];
                for (int i = 0; i < gvResultadoCompetencias.Rows.Count; i++)
                {
                    if (i >= dtCompetencias.Rows.Count)
                        break;

                    GridViewRow row = gvResultadoCompetencias.Rows[i];
                    TextBox txtNueva = (TextBox)row.FindControl("txtncalificacion");
                    decimal nuevaPuntuacion = 0;
                    if (txtNueva != null && decimal.TryParse(txtNueva.Text, out decimal valor))
                        nuevaPuntuacion = valor;

                    dtCompetencias.Rows[i]["NuevaPuntuacion"] = nuevaPuntuacion;

                    string dni = dtCompetencias.Rows[i]["Dni_EvaComp"].ToString();
                    string idComp = dtCompetencias.Rows[i]["IdCompetencia"].ToString();
                    string evaluacion = dtCompetencias.Rows[i]["Evaluacion_Competencia"].ToString();
                    string resultado = dtCompetencias.Rows[i]["ResultadoPuntuacion"].ToString();

                    using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_UpdateInsertCalibracion", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Tipo", "COMPETENCIA");
                        cmd.Parameters.AddWithValue("@Dni", dni);
                        cmd.Parameters.AddWithValue("@IdItem", idComp);
                        cmd.Parameters.AddWithValue("@Evaluacion", evaluacion);
                        cmd.Parameters.AddWithValue("@Resultado", resultado);
                        cmd.Parameters.AddWithValue("@Nueva", nuevaPuntuacion);

                        cmd.ExecuteNonQuery();
                    }
                }

                // === 2. Guardar OBJETIVOS ===
                if (dscalibracion.Tables.Count > 1)
                {
                    DataTable dtObjetivos = dscalibracion.Tables[1];
                    for (int i = 0; i < gvResultadosObjetivos.Rows.Count; i++)
                    {
                        GridViewRow row = gvResultadosObjetivos.Rows[i];
                        TextBox txtNueva = (TextBox)row.FindControl("txtnpuntuacion");
                        decimal nuevaPuntuacion = 0;
                        if (txtNueva != null && decimal.TryParse(txtNueva.Text, out decimal valor))
                            nuevaPuntuacion = valor;

                        dtObjetivos.Rows[i]["NuevaPuntuacion"] = nuevaPuntuacion;

                        string dni = dtObjetivos.Rows[i]["dni_evaobj"].ToString();
                        string idObj = dtObjetivos.Rows[i]["id_obj"].ToString();
                        string evaluacion = dtObjetivos.Rows[i]["evaluacion_objetivos"].ToString();
                        string resultado = dtObjetivos.Rows[i]["Puntuacion"].ToString();

                        using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_UpdateInsertCalibracion", conn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue("@Tipo", "OBJETIVO");
                            cmd.Parameters.AddWithValue("@Dni", dni);
                            cmd.Parameters.AddWithValue("@IdItem", idObj);
                            cmd.Parameters.AddWithValue("@Evaluacion", evaluacion);
                            cmd.Parameters.AddWithValue("@Resultado", resultado);
                            cmd.Parameters.AddWithValue("@Nueva", nuevaPuntuacion);

                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                string observaciones = txtObservaciones.Text.Trim();
                if (gvResultadoCompetencias.Visible && gvResultadosObjetivos.Visible)
                {
                    using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_UpdateInsertCalibracion", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Tipo", "OBSERVACION");
                        string dniPrincipal = dscalibracion.Tables[0].Rows[0]["Dni_EvaComp"].ToString();
                        cmd.Parameters.AddWithValue("@Dni", dniPrincipal);
                        cmd.Parameters.AddWithValue("@IdItem", DBNull.Value);
                        cmd.Parameters.AddWithValue("@Evaluacion", DBNull.Value);
                        cmd.Parameters.AddWithValue("@Resultado", DBNull.Value);
                        cmd.Parameters.AddWithValue("@Nueva", DBNull.Value);
                        cmd.Parameters.AddWithValue("@Observaciones", observaciones);

                        
                        cmd.ExecuteNonQuery();
                    }
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Éxito','Observaciones guardadas correctamente','success');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Atención','No se puede guardar observaciones sin competencias y objetivos','warning');", true);
                }



            }

            // 18.11.2025 ADD BY V.Y.R
            btnBuscar_Click(null, EventArgs.Empty);

            string script = @"
                Swal.fire({
                    icon: 'success',
                    title: '¡Éxito!',
                    text: 'Datos guardados o actualizados correctamente',
                    confirmButtonText: 'OK'
                });
            ";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SweetAlert", script, true);
        }


    }

}