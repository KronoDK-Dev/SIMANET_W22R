using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.Reporting.Map.WebForms.BingMaps;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;


namespace SIMANET_W22R.GestionPersonal.EvaluacionDesempenio
{
    public partial class Informes : System.Web.UI.Page // BasePage
    {
        string cadena = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            string basePath = System.Configuration.ConfigurationManager.AppSettings["BasePath"];



            if (!IsPostBack)
            {
                CargarCentrosOperativos();
                CargarTiposEvaluacion();
                CargarEvaluadores();
                txtDesde.Text = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd");
                txtHasta.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        private void CargarCentrosOperativos()
        {
            using (SqlConnection conn = new SqlConnection(cadena))
            using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ReporteEvaluaciones", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Accion", "CENTROS");

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                ddlCentroOperativo.DataSource = dr;
                ddlCentroOperativo.DataTextField = "CentroOperativo";
                ddlCentroOperativo.DataValueField = "CentroOperativo";
                ddlCentroOperativo.DataBind();
            }
            ddlCentroOperativo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Todos --", ""));
        }

        private void CargarTiposEvaluacion()
        {
            using (SqlConnection conn = new SqlConnection(cadena))
            using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ReporteEvaluaciones", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Accion", "TIPOS");

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                ddlTipoEvaluacion.DataSource = dr;
                ddlTipoEvaluacion.DataTextField = "TipoEvaluacion";
                ddlTipoEvaluacion.DataValueField = "TipoEvaluacion";
                ddlTipoEvaluacion.DataBind();
            }
            ddlTipoEvaluacion.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Todos --", ""));
        }

        private void CargarEvaluadores()
        {
            using (SqlConnection conn = new SqlConnection(cadena))
            using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ReporteEvaluaciones", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Accion", "EVALUADORES");

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                ddlEvaluador.DataSource = dr;
                ddlEvaluador.DataTextField = "NombresyApellidosEvaluador";
                ddlEvaluador.DataValueField = "NombresyApellidosEvaluador";
                ddlEvaluador.DataBind();
            }
            ddlEvaluador.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Todos --", ""));
        }



        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            try
            {
                /*DataTable dt = ObtenerReporte();
                    if (dt != null)
                    {
                        gvReportes.DataSource = dt;
                        gvReportes.DataBind();
                    }
                */



                DataTable dt = ObtenerReporte();

                if (dt.Rows.Count == 0)
                {
                    gvReportes.DataSource = null;
                    gvReportes.DataBind();
                    return;
                }

                // Agregar columna correlativa
                DataColumn colCorrelativo = new DataColumn("N°", typeof(int));
                dt.Columns.Add(colCorrelativo);
                colCorrelativo.SetOrdinal(0);

                int contador = 1;
                foreach (DataRow row in dt.Rows)
                {
                    row["N°"] = contador++;
                }

                // Diccionario de alias (igual que en Excel)
                Dictionary<string, string> columnasAlias;
                columnasAlias = ObtenerAlias();

                gvReportes.DataSource = dt;
                gvReportes.DataBind();


            }

            catch (Exception ex)
            {
                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;

                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }



        protected void gvReportes_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                Dictionary<string, string> columnasAlias = ObtenerAlias();

                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    string originalHeader = e.Row.Cells[i].Text.Trim();
                    if (columnasAlias.ContainsKey(originalHeader))
                    {
                        e.Row.Cells[i].Text = columnasAlias[originalHeader];
                    }
                }
            }
        }



        private Dictionary<string, string> ObtenerAlias()
        {
            Dictionary<string, string> columnasAlias;

            if (!string.IsNullOrWhiteSpace(ddlTipoEvaluacion.SelectedValue) &&
                ddlTipoEvaluacion.SelectedItem.Text != "-- Todos --")
            {
                // Caso cuando hay un tipo de evaluación específico
                columnasAlias = new Dictionary<string, string>()
                    {
                        {"N°", "N°"},
                        {"DNIEVALUADOR", "DNI Evaluador"},
                        {"NombresyApellidosEvaluador", "Evaluador"},
                        {"CentroOperativo", "Centro Operativo"},
                        {"TIPOEVALUACION", "Tipo Evaluación"},
                        {"NombresyApellidos", "Evaluado"},
                        {"DNIEVALUADO", "DNI Evaluado"},
                        {"CASO", "Caso / Evaluación"},
                        {"Puntuacion", "Puntuación"},
                        {"FechaEvaluacion", "Fecha"}
                    };
            }
            else
            {
                // Caso general
                columnasAlias = new Dictionary<string, string>()
                {
                        {"N°", "N°"},
                        {"Area", "Área"},
                        {"NombresyApellidos", "Apellidos y Nombres"},
                        {"DNIEVALUADO", "DNI"},
                        {"Puesto", "Puesto"},
                        {"GERENCIA", "Gerencia"},
                        {"NIVEL_OCUPACIONAL", "Nivel Ocupacional"},
                        {"TIEMPO_EMPRESA", "Tiempo en la Empresa"},
                        {"Puntuacion_Obje", "Puntaje"},
                        {"Categoria_obj", "Escala"},
                        {"Puntuacion_compe", "Puntaje "},
                        {"Categoria_comp", "Escala "},
                        {"Puntuacion_final", "Puntaje  "},
                        {"Categoria_final", "Escala  "}
                };
            }

            return columnasAlias;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            ddlCentroOperativo.SelectedIndex = 0;
            ddlTipoEvaluacion.SelectedIndex = 0;
            ddlEvaluador.SelectedIndex = 0;
            txtDesde.Text = string.Empty;
            txtHasta.Text = string.Empty;
            txtBuscar.Text = string.Empty;

            gvReportes.DataSource = null;
            gvReportes.DataBind();

            gvReportes.PageIndex = 0;
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            string criterio = txtBuscar.Text.Trim();

            // Obtener datos desde la BD
            DataTable dt = ObtenerReporte();

            // Filtrar si hay texto
            if (!string.IsNullOrEmpty(criterio))
            {
                // Usamos DataView para filtrar sin modificar la consulta SQL
                DataView dv = dt.DefaultView;
                dv.RowFilter = $"NombresyApellidos LIKE '%{criterio}%' OR " +
                               $"NombresyApellidosEvaluador LIKE '%{criterio}%' OR " +
                               $"DNIEVALUADOR LIKE '%{criterio}%' OR " +
                               $"DNIEVALUADO LIKE '%{criterio}%'";
                gvReportes.DataSource = dv;
            }
            else
            {
                gvReportes.DataSource = dt;
            }

            gvReportes.DataBind();
        }

        protected void gvReportes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvReportes.PageIndex = e.NewPageIndex;

            // Recarga combos si es necesario
            CargarCentrosOperativos();
            CargarTiposEvaluacion();
            CargarEvaluadores();

            // Obtiene datos desde la BD
            DataTable dt = ObtenerReporte();

            // Si hay texto en el buscador, aplica filtro
            string criterio = txtBuscar.Text.Trim();
            if (!string.IsNullOrEmpty(criterio))
            {
                DataView dv = dt.DefaultView;
                dv.RowFilter = $"NombresyApellidos LIKE '%{criterio}%' OR " +
                               $"NombresyApellidosEvaluador LIKE '%{criterio}%' OR " +
                               $"DNIEVALUADOR LIKE '%{criterio}%' OR " +
                               $"DNIEVALUADO LIKE '%{criterio}%'";
                gvReportes.DataSource = dv;
            }
            else
            {
                gvReportes.DataSource = dt;
            }

            gvReportes.DataBind();
        }





        private DataTable ObtenerReporte()
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(cadena))
            using (SqlCommand cmd = new SqlCommand("RRHHevaluacion.sp_ReporteEvaluaciones", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Accion", "DATOS");

                cmd.Parameters.AddWithValue("@FechaInicio", string.IsNullOrEmpty(txtDesde.Text) ? (object)DBNull.Value : DateTime.Parse(txtDesde.Text));
                cmd.Parameters.AddWithValue("@FechaFin", string.IsNullOrEmpty(txtHasta.Text) ? (object)DBNull.Value : DateTime.Parse(txtHasta.Text));
                cmd.Parameters.AddWithValue("@CentroOperativo", ddlCentroOperativo.SelectedValue == "" ? (object)DBNull.Value : ddlCentroOperativo.SelectedValue);
                cmd.Parameters.AddWithValue("@TipoEvaluacion", ddlTipoEvaluacion.SelectedValue == "" ? (object)DBNull.Value : ddlTipoEvaluacion.SelectedValue);
                cmd.Parameters.AddWithValue("@Evaluador", string.IsNullOrEmpty(ddlEvaluador.SelectedValue) ? (object)DBNull.Value : ddlEvaluador.SelectedValue);

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            return dt;
        }



        protected void btnExportarExcel_Click(object sender, EventArgs e)
        {
            DataTable dt = ObtenerReporte();

            if (dt.Rows.Count == 0)
            {
                Response.Write("<script>alert('No hay datos para exportar.');</script>");
                return;
            }

            // Agregar columna correlativa
            DataColumn colCorrelativo = new DataColumn("N°", typeof(int));
            dt.Columns.Add(colCorrelativo);
            colCorrelativo.SetOrdinal(0);

            int contador = 1;
            foreach (DataRow row in dt.Rows)
            {
                row["N°"] = contador++;
            }

            // Diccionario de alias según condición
            Dictionary<string, string> columnasAlias;

            if (!string.IsNullOrWhiteSpace(ddlTipoEvaluacion.SelectedValue) &&
                ddlTipoEvaluacion.SelectedItem.Text != "-- Todos --")
            {
                columnasAlias = new Dictionary<string, string>()
                    {
                        {"N°", "N°"},
                        {"DNIEVALUADOR", "DNI E"},
                        {"NombresyApellidosEvaluador", "NOMBRES Y APELLIDOS E"},
                        {"CentroOperativo", "CENTRO OPERATIVO"},
                        {"TIPOEVALUACION", "TIPO EVALUACIÓN"},
                        {"NombresyApellidos", "NOMBRES Y APELLIDOS"},
                        {"DNIEVALUADO", "DNI"},
                        {"Evaluacion_Competencia", "EVALUACION"},
                        {"CASO", "CASO EVALUACION"},
                        {"Puntuacion", "PUNTUACIÓN"},
                        {"FechaEvaluacion", "FECHA EVALUACIÓN"}
                    };
            }
            else
            {
                columnasAlias = new Dictionary<string, string>()
                    {
                        {"N°", "N°"},
                        {"NombresyApellidos", "APELLIDOS Y NOMBRES"},
                        {"DNIEVALUADO", "DNI"},
                        {"Puesto", "PUESTO"},
                        {"Area", "AREA"},
                        {"GERENCIA", "GERENCIA"},
                        {"NIVEL_OCUPACIONAL", "NIVEL OCUPACIONAL"},
                        {"TIEMPO_EMPRESA", "TIEMPO EN LA EMPRESA"},
                        {"Puntuacion_Obje", "PUNTAJE"},
                        {"Categoria_obj", "ESCALA"},
                        {"Puntuacion_compe", "PUNTAJE "},
                        {"Categoria_comp", "ESCALA "},
                        {"Puntuacion_final", "PUNTAJE  "},
                        {"Categoria_final", "ESCALA  "}
                    };
            }


            // Filtrar columnas y aplicar alias
            foreach (DataColumn col in dt.Columns.Cast<DataColumn>().ToList())
            {
                if (!columnasAlias.ContainsKey(col.ColumnName))
                    dt.Columns.Remove(col);
            }

            foreach (DataColumn col in dt.Columns)
            {
                col.ColumnName = columnasAlias[col.ColumnName];
            }

            using (OfficeOpenXml.ExcelPackage pck = new OfficeOpenXml.ExcelPackage())
            {
                var ws = pck.Workbook.Worksheets.Add("Reporte Evaluaciones");

                // Logo opcional
                string logoPath = Server.MapPath("~/Recursos/img/logosima.JPG");
                if (File.Exists(logoPath))
                {
                    using (var imgStream = File.OpenRead(logoPath))
                    {
                        var pic = ws.Drawings.AddPicture("Logo", imgStream);
                        pic.SetPosition(0, 0, 0, 0);
                        pic.SetSize(90, 50);
                    }
                }

                // Título general
                ws.Cells["B2"].Value = "Reporte de Evaluaciones de Desempeño";
                ws.Cells["B2"].Style.Font.Size = 16;
                ws.Cells["B2"].Style.Font.Bold = true;
                ws.Cells["B2"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                ws.Cells[2, 2, 2, dt.Columns.Count].Merge = true;

                ws.Cells["B3"].Value = "Generado el: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm");
                ws.Cells["B3"].Style.Font.Italic = true;
                ws.Cells["B3"].Style.Font.Color.SetColor(System.Drawing.Color.Gray);
                ws.Cells[3, 2, 3, dt.Columns.Count].Merge = true;

                // Encabezado personalizado
                int headerRow0 = 4; // Fila para "DATOS DEL EVALUADO"
                int headerRow1 = 5; // Fila para títulos principales
                int headerRow2 = 6; // Fila para sub-títulos

                // Fila 0: título general del bloque
                ws.Cells[headerRow0, 1].Value = "DATOS DEL EVALUADO";
                ws.Cells[headerRow0, 1, headerRow0, dt.Columns.Count].Merge = true;
                ws.Cells[headerRow0, 1, headerRow0, dt.Columns.Count].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                ws.Cells[headerRow0, 1, headerRow0, dt.Columns.Count].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                ws.Cells[headerRow0, 1, headerRow0, dt.Columns.Count].Style.Font.Bold = true;

                // Fila 1: títulos principales
                ws.Cells[headerRow1, 1].Value = "N°";
                ws.Cells[headerRow1, 2].Value = "ÁREA";
                ws.Cells[headerRow1, 3].Value = "APELLIDOS Y NOMBRES";
                ws.Cells[headerRow1, 4].Value = "DNI";
                ws.Cells[headerRow1, 5].Value = "PUESTO";
                ws.Cells[headerRow1, 6].Value = "GERENCIA";
                ws.Cells[headerRow1, 7].Value = "NIVEL OCUPACIONAL";
                ws.Cells[headerRow1, 8].Value = "TIEMPO EN LA EMPRESA";

                // Agrupaciones
                ws.Cells[headerRow1, 9].Value = "RESULTADO DE EVALUACIÓN POR OBJETIVOS";
                ws.Cells[headerRow1, 9, headerRow1, 10].Merge = true;

                ws.Cells[headerRow1, 11].Value = "RESULTADO DE EVALUACIÓN POR COMPETENCIAS";
                ws.Cells[headerRow1, 11, headerRow1, 12].Merge = true;

                ws.Cells[headerRow1, 13].Value = "RESULTADO FINAL";
                ws.Cells[headerRow1, 13, headerRow1, 14].Merge = true;

                // Fila 2: sub-títulos (solo para las secciones)
                ws.Cells[headerRow2, 9].Value = "PUNTAJE";
                ws.Cells[headerRow2, 10].Value = "ESCALA";
                ws.Cells[headerRow2, 11].Value = "PUNTAJE";
                ws.Cells[headerRow2, 12].Value = "ESCALA";
                ws.Cells[headerRow2, 13].Value = "PUNTAJE";
                ws.Cells[headerRow2, 14].Value = "ESCALA";

                // Estilo para las tres filas
                using (var range = ws.Cells[headerRow0, 1, headerRow2, dt.Columns.Count])
                {
                    range.Style.Font.Bold = true;
                    range.Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                    range.Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(192, 0, 0)); // Rojo
                    range.Style.Font.Color.SetColor(System.Drawing.Color.White);
                    range.Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                    range.Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                    range.Style.WrapText = true;
                }

                // Cargar datos debajo de la fila 2
                ws.Cells[headerRow2 + 1, 1].LoadFromDataTable(dt, false);

                // Bordes y ajuste
                using (var range = ws.Cells[headerRow2 + 1, 1, dt.Rows.Count + headerRow2, dt.Columns.Count])
                {
                    range.Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                    range.Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                    range.Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                    range.Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                    range.Style.WrapText = true;
                }

                ws.Cells.AutoFitColumns();

                // ✅ Inmovilizar encabezado (después de la fila 6)
                ws.View.FreezePanes(headerRow2 + 1, 1);

                string fileName = "Reporte_Evaluaciones_" + DateTime.Now.ToString("yyyyMMdd_HHmm") + ".xlsx";
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment; filename=" + fileName);
                Response.BinaryWrite(pck.GetAsByteArray());
                Response.End();
            }
        }


        protected void btnExportarPDF_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = ObtenerReporte();

                if (dt.Rows.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "Swal.fire('Aviso','No hay datos para exportar.','warning');", true);
                    return;
                }

                // Agregar columna correlativa
                DataColumn colCorrelativo = new DataColumn("N°", typeof(int));
                dt.Columns.Add(colCorrelativo);
                colCorrelativo.SetOrdinal(0);

                int contador = 1;
                foreach (DataRow row in dt.Rows)
                {
                    row["N°"] = contador++;
                }

                // Diccionario de alias según condición
                Dictionary<string, string> columnasAlias;

                if (!string.IsNullOrWhiteSpace(ddlTipoEvaluacion.SelectedValue) &&
                    ddlTipoEvaluacion.SelectedItem.Text != "-- Todos --")
                {
                    columnasAlias = new Dictionary<string, string>()
                    {
                        {"N°", "N°"},
                        {"DNIEVALUADOR", "DNI E"},
                        {"NombresyApellidosEvaluador", "NOMBRES Y APELLIDOS E"},
                        {"CentroOperativo", "CENTRO OPERATIVO"},
                        {"TIPOEVALUACION", "TIPO EVALUACIÓN"},
                        {"NombresyApellidos", "NOMBRES Y APELLIDOS"},
                        {"DNIEVALUADO", "DNI"},
                        {"Evaluacion_Competencia", "EVALUACION"},
                        {"CASO", "CASO EVALUACION"},
                        {"Puntuacion", "PUNTUACIÓN"},
                        {"FechaEvaluacion", "FECHA EVALUACIÓN"}
                    };
                }
                else
                {
                    columnasAlias = new Dictionary<string, string>()
                    {
                        {"N°", "N°"},
                        {"NombresyApellidos", "APELLIDOS Y NOMBRES"},
                        {"DNIEVALUADO", "DNI"},
                        {"Puesto", "PUESTO"},
                        {"Area", "AREA"},
                        {"GERENCIA", "GERENCIA"},
                        {"NIVEL_OCUPACIONAL", "NIVEL OCUPACIONAL"},
                        {"TIEMPO_EMPRESA", "TIEMPO EN LA EMPRESA"},
                        {"Puntuacion_Obje", "PUNTAJE"},
                        {"Categoria_obj", "ESCALA"},
                        {"Puntuacion_compe", "PUNTAJE "},
                        {"Categoria_comp", "ESCALA "},
                        {"Puntuacion_final", "PUNTAJE  "},
                        {"Categoria_final", "ESCALA  "}
                    };
                }

                // Eliminar columnas que no están en el diccionario
                foreach (DataColumn col in dt.Columns.Cast<DataColumn>().ToList())
                {
                    if (!columnasAlias.ContainsKey(col.ColumnName))
                    {
                        dt.Columns.Remove(col);
                    }
                }

                // Renombrar columnas
                foreach (DataColumn col in dt.Columns)
                {
                    col.ColumnName = columnasAlias[col.ColumnName];
                }

                // Crear documento PDF
                Document pdfDoc = new Document(PageSize.A4.Rotate(), 20f, 20f, 60f, 40f);
                MemoryStream ms = new MemoryStream();
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, ms);
                writer.PageEvent = new PdfHeaderFooter();

                pdfDoc.Open();

                PdfPTable pdfTable = new PdfPTable(dt.Columns.Count);
                pdfTable.WidthPercentage = 100;

                // ===== Fila superior agrupada =====
                PdfPCell cellDatos = new PdfPCell(new Phrase("DATOS DEL EVALUADO", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 11, BaseColor.WHITE)));
                cellDatos.BackgroundColor = new BaseColor(204, 0, 0);
                cellDatos.HorizontalAlignment = Element.ALIGN_CENTER;
                cellDatos.Colspan = 8;
                pdfTable.AddCell(cellDatos);

                PdfPCell cellObj = new PdfPCell(new Phrase("RESULTADO DE EVALUACIÓN POR OBJETIVOS", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 11, BaseColor.WHITE)));
                cellObj.BackgroundColor = new BaseColor(204, 0, 0);
                cellObj.HorizontalAlignment = Element.ALIGN_CENTER;
                cellObj.Colspan = 2;
                pdfTable.AddCell(cellObj);

                PdfPCell cellComp = new PdfPCell(new Phrase("RESULTADO DE EVALUACIÓN POR COMPETENCIAS", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 11, BaseColor.WHITE)));
                cellComp.BackgroundColor = new BaseColor(204, 0, 0);
                cellComp.HorizontalAlignment = Element.ALIGN_CENTER;
                cellComp.Colspan = 2;
                pdfTable.AddCell(cellComp);

                PdfPCell cellFinal = new PdfPCell(new Phrase("RESULTADO FINAL", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 11, BaseColor.WHITE)));
                cellFinal.BackgroundColor = new BaseColor(204, 0, 0);
                cellFinal.HorizontalAlignment = Element.ALIGN_CENTER;
                cellFinal.Colspan = 2;
                pdfTable.AddCell(cellFinal);

                // ===== Encabezados normales =====
                foreach (DataColumn col in dt.Columns)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(col.ColumnName, FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE)));
                    cell.BackgroundColor = new BaseColor(204, 0, 0); // fila azul 0, 102, 204
                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                    pdfTable.AddCell(cell);
                }

                pdfTable.HeaderRows = 2;

                // Filas de datos
                foreach (DataRow row in dt.Rows)
                {
                    foreach (var item in row.ItemArray)
                    {
                        PdfPCell cell = new PdfPCell(new Phrase(item.ToString(), FontFactory.GetFont(FontFactory.HELVETICA, 9)));
                        cell.HorizontalAlignment = Element.ALIGN_CENTER;
                        pdfTable.AddCell(cell);
                    }
                }

                pdfDoc.Add(pdfTable);
                pdfDoc.Close();

                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment; filename=Reporte_Evaluaciones_" + DateTime.Now.ToString("yyyyMMdd_HHmm") + ".pdf");
                Response.BinaryWrite(ms.ToArray());
                //Response.End();
                Response.Flush();
                HttpContext.Current.ApplicationInstance.CompleteRequest();


            }
            catch (Exception ex)
            {
                // Mostrar error con SweetAlert
                string mensajeError = ex.Message.Replace("'", "\\'"); // Escapar comillas
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"Swal.fire('Error','Ocurrió un problema al generar el PDF: {mensajeError}','error');", true);

            }
        }


        // Clase para encabezado y pie de página
        public class PdfHeaderFooter : PdfPageEventHelper
        {
            public override void OnEndPage(PdfWriter writer, Document document)
            {
                PdfPTable header = new PdfPTable(2);
                header.TotalWidth = document.PageSize.Width - document.LeftMargin - document.RightMargin;
                float[] widths = { 15f, 85f };
                header.SetWidths(widths);

                // Logo
                string logoPath = HttpContext.Current.Server.MapPath("~/Recursos/img/logosima.JPG");
                PdfPCell logoCell;
                if (File.Exists(logoPath))
                {
                    iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(logoPath);
                    logo.ScaleAbsolute(50, 30);
                    logoCell = new PdfPCell(logo);
                }
                else
                {
                    logoCell = new PdfPCell(new Phrase(""));
                }
                logoCell.Border = Rectangle.NO_BORDER;
                logoCell.HorizontalAlignment = Element.ALIGN_LEFT;
                header.AddCell(logoCell);

                // Título
                PdfPCell titleCell = new PdfPCell(new Phrase("Reporte de Evaluaciones de Desempeño\nGenerado el: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm"),
                    FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12)));
                titleCell.Border = Rectangle.NO_BORDER;
                titleCell.HorizontalAlignment = Element.ALIGN_CENTER;
                header.AddCell(titleCell);

                header.WriteSelectedRows(0, -1, document.LeftMargin, document.PageSize.Height - 10, writer.DirectContent);

                // Pie de página
                ColumnText.ShowTextAligned(writer.DirectContent, Element.ALIGN_CENTER,
                    new Phrase("Página " + writer.PageNumber, FontFactory.GetFont(FontFactory.HELVETICA, 8)),
                    (document.Right - document.Left) / 2 + document.LeftMargin,
                    document.Bottom - 10, 0);
            }

        }

        protected void btnNuevoReporte_Click(object sender, EventArgs e)
        {
            //  abrir un modal o redirigir a otro formulario
        }
    }
}