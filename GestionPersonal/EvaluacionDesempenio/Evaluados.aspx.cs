using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using SIMANET_W22R.InterfaceUI;

namespace SIMANET_W22R.GestionPersonal.EvaluacionDesempenio
{
    public partial class Evaluados : PaginaBase
    {
        string connStr = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

           

            if (!IsPostBack)
            {
                CargarAnios();
                CargarResultados();
            }
        }
        private void CargarAnios()
        {
            ddlAnio.Items.Clear();
            ddlAnio.Items.Add(new System.Web.UI.WebControls.ListItem("-- Seleccione --", ""));

            int anioActual = DateTime.Now.Year;
            for (int i = anioActual; i >= anioActual - 10; i--)
            {
                ddlAnio.Items.Add(new System.Web.UI.WebControls.ListItem(i.ToString(), i.ToString()));
            }
        }
        private void CargarResultados(string filtro = "")
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ListadoEvaluados", con);
                cmd.CommandType = CommandType.StoredProcedure;

                if (!string.IsNullOrEmpty(filtro))
                    cmd.Parameters.AddWithValue("@Filtro", filtro);
                else
                    cmd.Parameters.AddWithValue("@Filtro", DBNull.Value);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Enlazamos al Repeater en lugar del GridView
                rptEvaluados.DataSource = dt;
                rptEvaluados.DataBind();
            }
        }

        protected void ddlAnio_SelectedIndexChanged(object sender, EventArgs e)
        {
            string anio = ddlAnio.SelectedValue;
            CargarResultados(anio);
        }
        protected void btnInformes_Click(object sender, EventArgs e)
        {
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            oEasyNavigatorBE.Texto = "Informes de EDD";
            oEasyNavigatorBE.Descripcion = "Informes relacionados a la Evaluación de desempeño";
            oEasyNavigatorBE.Pagina = "/GestionPersonal/EvaluacionDesempenio/Informes.aspx";
            this.IrA(oEasyNavigatorBE); 
        }


    }
}
