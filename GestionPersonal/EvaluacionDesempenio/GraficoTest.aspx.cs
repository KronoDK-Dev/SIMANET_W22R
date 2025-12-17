using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;


namespace SIMANET_W22R.GestionPersonal.EvaluacionDesempenio
{
    public partial class GraficoTest : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvDatos.DataSource = new List<dynamic>
                {
                    new { Nombre = "Juan", Puntaje = 80 },
                    new { Nombre = "Ana", Puntaje = 90 },
                    new { Nombre = "Luis", Puntaje = 70 }
                };
                gvDatos.DataBind();
            }

        }

        protected void gvDatos_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Datos que vamos a mostrar en el gráfico (simulados)
            var lista = new List<object>
            {
                new { Competencia = "Trabajo en equipo", Resultado = 80 },
                new { Competencia = "Comunicación", Resultado = 70 },
                new { Competencia = "Liderazgo", Resultado = 60 }
            };

            string json = new JavaScriptSerializer().Serialize(lista);

            // INYECTAR el JSON y ejecutar la función con los datos desde el servidor.
            string script = $"drawCompetenciasChart({json});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "drawChart", script, true);

            // (Opcional) para comprobar que el evento se ejecutó:
            // ScriptManager.RegisterStartupScript(this, this.GetType(), "dbg", "console.log('SelectedIndexChanged en servidor.');", true);
        }


    }
}