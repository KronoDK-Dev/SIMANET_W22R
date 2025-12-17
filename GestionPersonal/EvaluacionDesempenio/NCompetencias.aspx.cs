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
    public partial class NCompetencias : System.Web.UI.Page
    {
        private DataTable dtCompetencias
        {
            get
            {
                if (ViewState["dtCompetencias"] == null)
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("dni");
                    //dt.Columns.Add("id");
                    dt.Columns.Add("Competencia");
                    dt.Columns.Add("Comportamiento");
                    ViewState["dtCompetencia"] = dt;
                }
                return (DataTable)ViewState["dtCompetencias"];
            }
            set { ViewState["dtCompetencias"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvCompetencias.DataSource = dtCompetencias;
                gvCompetencias.DataBind();
            }

            CargaridCompetencias();
        }

        private void CargaridCompetencias()
        {

          if (ddlCompetencia.Items.Count <=1)
          { 
                string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("SELECT IdCompetencia, NombreCompetencia FROM RRHHevaluacion.Competencias", con);
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                ddlCompetencia.DataSource = dr;
                ddlCompetencia.DataTextField = "NombreCompetencia";
                ddlCompetencia.DataValueField = "IdCompetencia";
                ddlCompetencia.DataBind();

                ddlCompetencia.Items.Insert(0, new ListItem("-- Seleccione --", ""));


            }
          }
        }

        //
        protected void btnAgregarComp_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtDNICOMP.Text))

            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "Swal.fire('Atención','Complete los campos (DNI) antes para permitir agregar','warning');", true);
                txtDNICOMP.Focus ();
                return;
            }
            if ( string.IsNullOrEmpty(ddlCompetencia.SelectedValue) )
                
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "Swal.fire('Atención','Complete los campos (Seleccione Competencia) antes para permitir agregar','warning');", true);
                ddlCompetencia.Focus ();
                return;
            }

            if (string.IsNullOrEmpty(txtComportamiento.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "Swal.fire('Atención','Complete los campos (Comportamiento) antes para permitir agregar','warning');", true);
                txtComportamiento.Focus ();
                return;
            }
            string dni = txtDNICOMP.Text.Trim();
            int idCompetencia = Convert.ToInt32(ddlCompetencia.SelectedValue);
            string competencia = ddlCompetencia.SelectedItem.Text.Trim();
            string comportamiento = txtComportamiento.Text.Trim();

            int nuevoId = ObtenerNuevoId(dni);


            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_InsertarCompetencias", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@dni_evacomp", txtDNICOMP.Text);
                cmd.Parameters.AddWithValue("@idcompetencia", idCompetencia);
                cmd.Parameters.AddWithValue("@competencia", ddlCompetencia.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@comportamiento", txtComportamiento.Text);
                cmd.ExecuteNonQuery();
            }

            CargarCompetencias(txtDNICOMP.Text);

            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "Swal.fire('Éxito','Competencia agregada y guardada','success');", true);
        }

        private int ObtenerNuevoId(string dni)
        {
            int nuevoId = 1;
            try { 
                string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cadena))
                {
                    SqlCommand cmd = new SqlCommand("SELECT ISNULL(MAX(id_comp),0) + 1 FROM RRHHevaluacion.evaCompetencias WHERE dni_evaComp = @dni", con);
                    cmd.Parameters.AddWithValue("@dni", dni);
                    con.Open();
                    nuevoId = Convert.ToInt32(cmd.ExecuteScalar());
                }

                return nuevoId;
            }
            catch (Exception ex)
            {
                string mensaje = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                  $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
                return 1;
            }
        }

        private void CargarCompetencias(string dni)
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_BuscarCompetenciasEvaluados", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Dni", dni);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables.Count > 1)
                {
                    gvCompetencias.DataSource = ds.Tables[1];
                    gvCompetencias.DataBind();
                }
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string dni = txtDNI.Text.Trim();

            if (!string.IsNullOrEmpty(dni))
            {
                string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cadena))
                {
                    SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_BuscarCompetenciasEvaluados", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Dni", dni);

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
                            txtDNICOMP.Text = txtDNI.Text;
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
                            dtCompetencias = dscalibracion.Tables[1]; // guardamos en ViewState
                            gvCompetencias.DataSource = dtCompetencias;
                            gvCompetencias.DataBind();
                        }
                        else
                        {
                            dtCompetencias = null; // limpiamos memoria
                            gvCompetencias.DataSource = null;
                            gvCompetencias.DataBind();
                        }


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

        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            txtDNI.Text = "";
            txtDNI.Enabled = true;
            txtNombresyApellidos.Text = "";
            txtCargo.Text = "";
            txtArea.Text = "";
            txtCategoria.Text = "";

            txtDNICOMP.Text = "";

            this.gvCompetencias.DataSource = null;
            this.gvCompetencias.DataBind();

        }

        protected void gvCompetencias_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCompetencias.EditIndex = e.NewEditIndex;
            CargarCompetencias(txtDNICOMP.Text); // Recarga la lista del evaluado actual
        }

        protected void gvCompetencias_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCompetencias.EditIndex = -1;
            CargarCompetencias(txtDNICOMP.Text);
        }

        protected void gvCompetencias_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string dni = gvCompetencias.DataKeys[e.RowIndex].Values["dni"].ToString();
            string id = gvCompetencias.DataKeys[e.RowIndex].Values["id"].ToString();
            string idCompetencia = gvCompetencias.DataKeys[e.RowIndex].Values["IdCompetencia"].ToString();

            TextBox txtComportamiento = (TextBox)gvCompetencias.Rows[e.RowIndex].FindControl("txtComportamiento");
            string nuevoCompetencias = txtComportamiento.Text.Trim();

            if (string.IsNullOrEmpty(dni) || string.IsNullOrEmpty(id) || string.IsNullOrEmpty(idCompetencia))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    "Swal.fire('Error','No se encontró el DNI o ID del evaluado','error');", true);
                return;
            }

            ActualizarComportamiento(dni, id, idCompetencia, nuevoCompetencias);

            gvCompetencias.EditIndex = -1;
            CargarCompetencias(txtDNICOMP.Text);

            ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                "Swal.fire('Éxito','Comportamiento actualizado correctamente','success');", true);
        }

        private void ActualizarComportamiento(string dni, string id, string idCompetencia, string Comportamiento)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ActualizarComportamiento", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Dni", dni);
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@IdCompetencia", idCompetencia);
                cmd.Parameters.AddWithValue("@Comportamiento", Comportamiento);
                cmd.ExecuteNonQuery();
            }
        }


        protected void gvCompetencias_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string dni = gvCompetencias.DataKeys[e.RowIndex].Values["dni"].ToString();
                string id = gvCompetencias.DataKeys[e.RowIndex].Values["id"].ToString();
                string idCompetencia = gvCompetencias.DataKeys[e.RowIndex].Values["IdCompetencia"].ToString();


                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_EliminarComportamiento", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Dni", dni);
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Parameters.AddWithValue("@IdCompetencia", idCompetencia);
                    cmd.ExecuteNonQuery();
                }

                CargarCompetencias(txtDNICOMP.Text);

                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    "Swal.fire('Eliminado','El Comportamiento fue eliminado correctamente','success');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    $"Swal.fire('Error','No se pudo eliminar: {ex.Message}','error');", true);
            }
        }

        protected void gvCompetencias_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCompetencias.PageIndex = e.NewPageIndex;
            CargarCompetencias(txtDNICOMP.Text);

        }

        protected void gvObjetivos_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                DataTable dt = dtCompetencias;
                dt.Rows.RemoveAt(index);

                gvCompetencias.DataSource = dt;
                gvCompetencias.DataBind();
            }
        }

                            
      

    }
}