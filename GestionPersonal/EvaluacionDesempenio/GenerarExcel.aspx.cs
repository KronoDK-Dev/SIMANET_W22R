using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing; // para Color
using System.Web;
using OfficeOpenXml;  // Install-Package EPPlus -Version 4.5.3.3
using OfficeOpenXml.Style;
using System.Web.UI;

namespace SIMANET_W22R.GestionPersonal.EvaluacionDesempenio
{
    public partial class GenerarExcel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         try { 
                string dni = Request.QueryString["dni"];
                if (string.IsNullOrEmpty(dni))
                {
                    Response.StatusCode = 400;
                    Response.Write("Falta parámetro dni");
                    Response.End();
                    return;
                }

                // Generar Excel
                using (var pkg = new ExcelPackage())
                {
                    DataSet ds = ObtenerDatos(dni);
                

                

                    for (int t = 0; t < ds.Tables.Count; t++)
                    {
                        DataTable dt = ds.Tables[t];

                        // ==== TÍTULO DE SECCIÓN ====
                        //string titulo = !string.IsNullOrEmpty(dt.TableName) ? dt.TableName : "Consulta " + (t + 1);
                        //ws.Cells[filaActual, 1].Value = titulo;
                        //ws.Cells[filaActual, 1].Style.Font.Bold = true;
                        //ws.Cells[filaActual, 1].Style.Font.Size = 12;
                        //ws.Cells[filaActual, 1, filaActual, dt.Columns.Count].Merge = true;
                        //ws.Cells[filaActual, 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        //filaActual++;
                        /*
                        string sheetName = !string.IsNullOrEmpty(dt.TableName) && dt.TableName != "Table"
                                           ? dt.TableName
                                           : "Reporte " + (t + 1);
                        */
                        string sheetName = !string.IsNullOrEmpty(dt.TableName) && dt.TableName != "Table"
                                            ? $"{t + 1} Competencias "
                                            : $"{t + 1} Objetivos ";

                        /*** 16.10.25 validacion para el nombrel del archivo */
                        // Reemplazar caracteres inválidos
                        foreach (char c in System.IO.Path.GetInvalidFileNameChars())
                        {
                            sheetName = sheetName.Replace(c.ToString(), "_");
                        }
                        // Excel también prohíbe : / \ * ? [ ]
                        string[] invalids = { ":", "/", "\\", "?", "*", "[", "]" };
                        foreach (var inv in invalids)
                        {
                            sheetName = sheetName.Replace(inv, "_");
                        }

                        // Limitar a 31 caracteres
                        if (sheetName.Length > 31)
                            sheetName = sheetName.Substring(0, 31);


                        var ws = pkg.Workbook.Worksheets.Add(sheetName);
                        // 16.10.2025  seleccinamos hoja activa
                        pkg.Workbook.View.ActiveTab = 0;
                        ws.Select();

                        int filaActual = 1;

                        // ==== CARGAR TABLA ====
                        ws.Cells[filaActual, 1].LoadFromDataTable(dt, true);

                        // Encabezados
                        using (var header = ws.Cells[filaActual, 1, filaActual, dt.Columns.Count])
                        {
                            header.Style.Font.Bold = true;
                            header.Style.Fill.PatternType = ExcelFillStyle.Solid;
                            header.Style.Fill.BackgroundColor.SetColor(Color.Green);
                            header.Style.Font.Color.SetColor(Color.White);
                            header.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        }

                        // Datos
                        using (var data = ws.Cells[filaActual + 1, 1, filaActual + dt.Rows.Count, dt.Columns.Count])
                        {
                            data.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                            data.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                            data.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                            data.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        }

                        // Pasar a la fila siguiente después de los datos (+2 para dejar espacio)
                        filaActual += dt.Rows.Count + 2;
                    }

                

                    // Ajustar ancho de columnas
                    //ws.Cells[ws.Dimension.Address].AutoFitColumns();

                    // ==== EXPORTAR ====
                    byte[] fileBytes = pkg.GetAsByteArray();
                    string fileName = $"Reporte_{dni}_{DateTime.Now:yyyyMMddHHmm}.xlsx";

                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
                    Response.Cache.SetCacheability(HttpCacheability.NoCache); // 16.10.2025
                    Response.BinaryWrite(fileBytes);
                    Response.Flush();
                    Response.End(); // 16.10.2025 cerramos envio de datos
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                }
               }
               catch (Exception ex)
                    {
                    string mensaje = ex.Message.Replace("'", "\\'");
                                 ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
                     }
        }

        private DataSet ObtenerDatos(string dni)
        {
            var ds = new DataSet();
            try { 
                
                string cs = System.Configuration.ConfigurationManager
                               .ConnectionStrings["ConexionSQL"].ConnectionString;

                using (var cn = new SqlConnection(cs))
                using (var cmd = new SqlCommand("RRHHevaluacion.sp_ObtenerEvaluadosCalibracionxls", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@DNI", dni);
                    using (var da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds); // ahora llena todas las consultas (varias tablas)
                    }
                }
                return ds;
            }
            catch (Exception ex)
            {
                string mensaje = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                 $"Swal.fire({{ icon: 'error', title: 'Oops...', text: '{mensaje}' }});", true);
                return new DataSet();
            }
        }

    }
}
