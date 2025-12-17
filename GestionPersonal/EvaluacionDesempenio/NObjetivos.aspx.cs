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
    public partial class NObjetivos : System.Web.UI.Page
    {
        private DataTable dtObjetivos
        {
            get
            {
                if (ViewState["dtObjetivos"] == null)
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("dni");
                    dt.Columns.Add("id");
                    dt.Columns.Add("objetivo");
                    ViewState["dtObjetivos"] = dt;
                }
                return (DataTable)ViewState["dtObjetivos"];
            }
            set { ViewState["dtObjetivos"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvObjetivos.DataSource = dtObjetivos;
                gvObjetivos.DataBind();
            }


        }

        protected void btnAgregarObj_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtDNIOBJ.Text) || string.IsNullOrEmpty(txtObjetivo.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "Swal.fire('Atención','Complete los campos antes de agregar','warning');", true);
                return;
            }

            int nuevoId = ObtenerNuevoId(txtDNIOBJ.Text);


            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_InsertarObjetivos", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@dni_evaobj", txtDNIOBJ.Text);
                cmd.Parameters.AddWithValue("@objetivo", txtObjetivo.Text);
                cmd.ExecuteNonQuery();
            }

            CargarObjetivos(txtDNIOBJ.Text);

            txtObjetivo.Text = "";

            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "Swal.fire('Éxito','Objetivo agregado y guardado','success');", true);
        }


        private int ObtenerNuevoId(string dni)
        {
            int nuevoId = 1;
            string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("SELECT ISNULL(MAX(id_obj),0) + 1 FROM RRHHevaluacion.EvaObjetivos WHERE dni_evaobj = @dni", con);
                cmd.Parameters.AddWithValue("@dni", dni);
                con.Open();
                nuevoId = Convert.ToInt32(cmd.ExecuteScalar());
            }

            return nuevoId;
        }

        private void CargarObjetivos(string dni)
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_BuscarObjetivosEvaluados", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Dni", dni);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables.Count > 1)
                {
                    gvObjetivos.DataSource = ds.Tables[1];
                    gvObjetivos.DataBind();
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
                    SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_BuscarObjetivosEvaluados", con);
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
                            txtDNIOBJ.Text = txtDNI.Text;
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
                            dtObjetivos = dscalibracion.Tables[1]; // guardamos en ViewState
                            gvObjetivos.DataSource = dtObjetivos;
                            gvObjetivos.DataBind();
                        }
                        else
                        {
                            dtObjetivos = null; // limpiamos memoria
                            gvObjetivos.DataSource = null;
                            gvObjetivos.DataBind();
                        }


                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                    }
                }
                txtDNI.Enabled = false;
            }

        }
        /*
        protected void gvObjetivos_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                DataTable dt = dtObjetivos;
                dt.Rows.RemoveAt(index);

                gvObjetivos.DataSource = dt;
                gvObjetivos.DataBind();
            }
        }
        */
        // se adicionan 05 eventos
        protected void gvObjetivos_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvObjetivos.EditIndex = e.NewEditIndex;
            CargarObjetivos(txtDNIOBJ.Text); // Recarga la lista del evaluado actual
        }

        protected void gvObjetivos_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvObjetivos.EditIndex = -1;
            CargarObjetivos(txtDNIOBJ.Text);
        }

        protected void gvObjetivos_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string dni = gvObjetivos.DataKeys[e.RowIndex].Values["dni"].ToString();
            string id = gvObjetivos.DataKeys[e.RowIndex].Values["id"].ToString();

            TextBox txtObjetivo = (TextBox)gvObjetivos.Rows[e.RowIndex].FindControl("txtObjetivo");
            string nuevoObjetivo = txtObjetivo.Text.Trim();

            if (string.IsNullOrEmpty(dni) || string.IsNullOrEmpty(id))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    "Swal.fire('Error','No se encontró el DNI o ID del evaluado','error');", true);
                return;
            }

            ActualizarObjetivo(dni, id, nuevoObjetivo);

            gvObjetivos.EditIndex = -1;
            CargarObjetivos(txtDNIOBJ.Text);

            ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                "Swal.fire('Éxito','Objetivo actualizado correctamente','success');", true);
        }

        private void ActualizarObjetivo(string dni, string id, string objetivo)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ActualizarObjetivo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Dni", dni);
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@Objetivo", objetivo);
                cmd.ExecuteNonQuery();
            }
        }


        protected void gvObjetivos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string dni = gvObjetivos.DataKeys[e.RowIndex].Values["dni"].ToString();
                string id = gvObjetivos.DataKeys[e.RowIndex].Values["id"].ToString();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_EliminarObjetivo", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Dni", dni);
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.ExecuteNonQuery();
                }

                CargarObjetivos(txtDNIOBJ.Text);

                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    "Swal.fire('Eliminado','El objetivo fue eliminado correctamente','success');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    $"Swal.fire('Error','No se pudo eliminar: {ex.Message}','error');", true);
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

            txtDNIOBJ.Text = "";

            this.gvObjetivos.DataSource = null;
            this.gvObjetivos.DataBind();

        }


    }

}

