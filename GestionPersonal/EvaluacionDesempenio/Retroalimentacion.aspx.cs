using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Serialization;
using SIMANET_W22R.InterfaceUI;

namespace SIMANET_W22R.GestionPersonal.EvaluacionDesempenio
{
    public partial class FormRetroalimentacion : PaginaBase
    {
        string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;
        string usuarioSesion = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuarioSesion = ObtenerUsuarioSesion();

        }
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
                    SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ObtenerEvaluadorRetroalimentacion", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Dni", dni);

                    string usuarioSesion = Session["Usuario"] != null ? Session["Usuario"].ToString() : string.Empty;
                    if (string.IsNullOrEmpty(usuarioSesion))
                    { usuarioSesion = ObtenerUsuarioSesion(); }
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
                            gvRetroalimentacionEvaluados.DataSource = dscalibracion.Tables[1];
                            gvRetroalimentacionEvaluados.DataBind();
                        }
                        else
                        {
                            gvRetroalimentacionEvaluados.DataSource = null;
                            gvRetroalimentacionEvaluados.DataBind();
                        }

                        //Session["dsevalua"] = dsevalua;
                    }
                    catch (Exception ex)
                    {
                        //  ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                        string mensaje = ex.Message.Replace("'", "\\'");
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
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


            this.gvRetroalimentacionEvaluados.DataSource = null;
            this.gvRetroalimentacionEvaluados.DataBind();

            this.gvResultadoCompetencias.DataSource = null;
            this.gvResultadoCompetencias.DataBind();

            this.gvResultadosObjetivos.DataSource = null;
            this.gvResultadosObjetivos.DataBind();

        }

        protected string chartDataJson = "[]";

        protected void gvRetroalimentacionEvaluados_SelectedIndexChanged(object sender, EventArgs e)
        {
            string dni = ((LinkButton)gvRetroalimentacionEvaluados.SelectedRow.FindControl("lnkDNI")).Text;

            DataSet ds = ObtenerDetallesDesdeSP(dni);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                gvResultadoCompetencias.DataSource = ds.Tables[0];
                gvResultadoCompetencias.DataBind();
                gvResultadoCompetencias.Visible = true;

                //var chartData = ds.Tables[0].AsEnumerable()
                //   .Select(r => new
                //   {
                //       Competencia = r["Evaluacion_Competencia"].ToString(),
                //       Resultado = Convert.ToDecimal(r["ResultadoPuntuacion"])
                //   }).ToList();

                //chartDataJson = new JavaScriptSerializer().Serialize(chartData);

            }
            else
            {
                gvResultadoCompetencias.Visible = false;
                //chartDataJson = "[]";
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
                txtresultado.Text = string.Empty;
            }

            try
            {
                if (ds != null && ds.Tables.Count > 7 && ds.Tables[7].Rows.Count > 0)
                {
                    txtFortalezas.Text = Convert.ToString(ds.Tables[7].Rows[0]["Fortalezas"]);
                    txtOportunidadesMejora.Text = Convert.ToString(ds.Tables[7].Rows[0]["OportunidadesMejora"]);
                    txtObservaciones.Text = Convert.ToString(ds.Tables[7].Rows[0]["Observaciones"]);
                }
                else
                {
                    txtFortalezas.Text = string.Empty;
                    txtOportunidadesMejora.Text = string.Empty;
                    txtObservaciones.Text = string.Empty;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error cargando observaciones: " + ex.Message);
                txtObservaciones.Text = string.Empty;
            }

            Session["dsretroalimentacion"] = ds;
        }

        private DataSet ObtenerDetallesDesdeSP(string dni)
        {
            DataSet ds = new DataSet();
            string connectionString = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
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
            DataSet dsretroalimentacion = (DataSet)Session["dsretroalimentacion"];
            if (dsretroalimentacion == null || dsretroalimentacion.Tables.Count == 0) return;

            int idUsuarioLogeado = Convert.ToInt32(Session["idusuario"]);

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                conn.Open();

                string fortalezas = txtFortalezas.Text.Trim();
                string oportunidadesmejora = txtOportunidadesMejora.Text.Trim();
                string observaciones = txtObservaciones.Text.Trim();
                if (gvResultadoCompetencias.Visible && gvResultadosObjetivos.Visible)
                {
                    using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_UpdateInsertRetroalimentacionobs", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        string dniPrincipal = dsretroalimentacion.Tables[0].Rows[0]["Dni_EvaComp"].ToString();
                        cmd.Parameters.AddWithValue("@Dni", dniPrincipal);
                        cmd.Parameters.AddWithValue("@Fortalezas", fortalezas);
                        cmd.Parameters.AddWithValue("@Oportunidadesmejora", oportunidadesmejora);
                        cmd.Parameters.AddWithValue("@Observaciones", observaciones);
                        cmd.Parameters.AddWithValue("@IdUsuario", idUsuarioLogeado);

                        cmd.ExecuteNonQuery();
                    }
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Éxito','Observaciones guardadas correctamente','success');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Atención','No se puede guardar observaciones sin competencias y objetivos','warning');", true);
                }
            }

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