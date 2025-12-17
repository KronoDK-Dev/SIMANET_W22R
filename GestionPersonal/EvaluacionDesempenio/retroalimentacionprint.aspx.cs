using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionPersonal.EvaluacionDesempenio
{
    public partial class retroalimentacionprint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string dni = Request.QueryString["dni"];
            if (string.IsNullOrEmpty(dni))
            {
                Response.Write("No se recibió un DNI válido.");
                return;
            }

            try
            {
                ReportDocument reporte = new ReportDocument();
                reporte.Load(Server.MapPath("../Reportes/rptRetroalimentacion.rpt"));
                // Conectar todas las tablas y subreportes
                // 18.11.2025 Extraemos parametros de conexion del archivo necesario

                // Obtiene la cadena completa desde web.config
                string connectionString = ConfigurationManager.ConnectionStrings["ConexionSQL"].ConnectionString;

                // Usa SqlConnectionStringBuilder para desglosar los componentes
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(connectionString);

                string servidor = builder.DataSource;       // Servidor1\instancia1
                string baseDatos = builder.InitialCatalog;  // mibase2025
                string usuario = builder.UserID;            // sa
                string clave = builder.Password;            // miclave

                AplicarCredenciales3(reporte, servidor, baseDatos, usuario, clave);

                foreach (ParameterFieldDefinition param in reporte.DataDefinition.ParameterFields)
                {
                    Response.Write("Parámetro encontrado: " + param.Name + "<br>");
                }

                string parametroNombre = "@Dni";

                reporte.SetParameterValue(parametroNombre, dni);

            
                foreach (ReportDocument sub in reporte.Subreports)
                {
                    reporte.SetParameterValue(parametroNombre, dni, sub.Name);
                }

                using (Stream pdfStream = reporte.ExportToStream(ExportFormatType.PortableDocFormat))
                {
                    byte[] pdfBytes = new byte[pdfStream.Length];
                    pdfStream.Read(pdfBytes, 0, pdfBytes.Length);

                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", $"inline;filename=Reporte_{dni}.pdf");
                    Response.BinaryWrite(pdfBytes);
                    Response.End();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error generando reporte: " + ex.Message);
            }
        }

        private void AplicarCredenciales(ReportDocument reporte, string servidor, string baseDatos, string usuario, string password)
        {
            TableLogOnInfo logOnInfo;

            foreach (CrystalDecisions.CrystalReports.Engine.Table table in reporte.Database.Tables)
            {
                logOnInfo = table.LogOnInfo;
                logOnInfo.ConnectionInfo.ServerName = servidor;
                logOnInfo.ConnectionInfo.DatabaseName = baseDatos;
                logOnInfo.ConnectionInfo.UserID = usuario;
                logOnInfo.ConnectionInfo.Password = password;
                table.ApplyLogOnInfo(logOnInfo);
            }

            foreach (ReportDocument sub in reporte.Subreports)
            {
                foreach (CrystalDecisions.CrystalReports.Engine.Table table in sub.Database.Tables)
                {
                    logOnInfo = table.LogOnInfo;
                    logOnInfo.ConnectionInfo.ServerName = servidor;
                    logOnInfo.ConnectionInfo.DatabaseName = baseDatos;
                    logOnInfo.ConnectionInfo.UserID = usuario;
                    logOnInfo.ConnectionInfo.Password = password;
                    table.ApplyLogOnInfo(logOnInfo);
                }
            }
        }

        private void AplicarCredenciales3(ReportDocument reporte, string servidor, string bd, string usuario, string clave)
        {
            const string esquemaForzado = "RRHHevaluacion";
            var connectionInfo = new ConnectionInfo
            {
                ServerName = servidor,
                DatabaseName = bd,
                UserID = usuario,
                Password = clave,
                IntegratedSecurity = false
            };

            // TABLAS PRINCIPALES
            foreach (CrystalDecisions.CrystalReports.Engine.Table table in reporte.Database.Tables)
            {
                try
                {
                    // 1) Aplicar credenciales iniciales
                    var logonInfo = table.LogOnInfo;
                    logonInfo.ConnectionInfo = connectionInfo;
                    table.ApplyLogOnInfo(logonInfo);

                    // 2) Obtener location original y sufijo (preservar ;1 si existe)
                    string originalLoc = table.Location ?? "";
                    string sufijo = "";
                    int idxSemi = originalLoc.IndexOf(';');
                    if (idxSemi >= 0)
                    {
                        sufijo = originalLoc.Substring(idxSemi); // incluye ';'
                        originalLoc = originalLoc.Substring(0, idxSemi);
                    }
                    // Asegura un único sufijo si no existía
                    if (string.IsNullOrEmpty(sufijo))
                        sufijo = ";1";

                    // 3) Determinar el nombre del objeto que el informe conoce
                    // usar table.Name suele ser más fiable que partir de Location
                    string nombreObjeto = table.Name ?? originalLoc;
                    // quitar posible sufijo en table.Name
                    if (nombreObjeto.IndexOf(';') >= 0)
                        nombreObjeto = nombreObjeto.Substring(0, nombreObjeto.IndexOf(';'));

                    // 4) Asegurarnos que tiene prefijo sp_
                    /*
                    if (!nombreObjeto.StartsWith("sp_", StringComparison.OrdinalIgnoreCase))
                        nombreObjeto = "sp_" + nombreObjeto;
                    */
                    // limpieza  add 18.11.2025 by vyr
                    if (nombreObjeto.IndexOf(';') >= 0)
                        nombreObjeto = nombreObjeto.Substring(0, nombreObjeto.IndexOf(';'));

                    // 5) Crear nueva location (BD.Esquema.sp_Nombre;sufijo)
                    string nuevaLocation = string.IsNullOrEmpty(bd)
                    ? $"{esquemaForzado}.{nombreObjeto}{sufijo}"
                    : $"{bd}.{esquemaForzado}.{nombreObjeto}{sufijo}";

                    // 6) Asignar y reaplicar LogOnInfo
                    table.Location = nuevaLocation;
                    // Reaplicar logon por si Crystal necesita volver a aplicar credenciales
                    logonInfo = table.LogOnInfo;
                    logonInfo.ConnectionInfo = connectionInfo;
                    table.ApplyLogOnInfo(logonInfo);

                    // 7) Debug: escribe valores para inspección (ver en Output/Debug)
                    System.Diagnostics.Debug.WriteLine($"TABLE: Name='{table.Name}' | originalLoc='{originalLoc + sufijo}' | setLocation='{table.Location}'");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error ajustando tabla principal: {ex.Message}");
                }
            }

            // SUBREPORTES
            foreach (ReportDocument sub in reporte.Subreports)
            {
                foreach (CrystalDecisions.CrystalReports.Engine.Table table in sub.Database.Tables)
                {
                    try
                    {
                        var logonInfo = table.LogOnInfo;
                        logonInfo.ConnectionInfo = connectionInfo;
                        table.ApplyLogOnInfo(logonInfo);

                        string originalLoc = table.Location ?? "";
                        string sufijo = "";
                        int idxSemi = originalLoc.IndexOf(';');
                        if (idxSemi >= 0)
                        {
                            sufijo = originalLoc.Substring(idxSemi);
                            originalLoc = originalLoc.Substring(0, idxSemi);
                        }
                        if (string.IsNullOrEmpty(sufijo))
                            sufijo = ";1";

                        string nombreObjeto = table.Name ?? originalLoc;
                        if (nombreObjeto.IndexOf(';') >= 0)
                            nombreObjeto = nombreObjeto.Substring(0, nombreObjeto.IndexOf(';'));
                        /* no forzamos el prefijo del sp  18.11.2025 by vyr 
                        if (!nombreObjeto.StartsWith("sp_", StringComparison.OrdinalIgnoreCase))
                            nombreObjeto = "sp_" + nombreObjeto;
                        */
                        string nuevaLocation = string.IsNullOrEmpty(bd)
                        ? $"{esquemaForzado}.{nombreObjeto}{sufijo}"
                        : $"{bd}.{esquemaForzado}.{nombreObjeto}{sufijo}";

                        table.Location = nuevaLocation;

                        logonInfo = table.LogOnInfo;
                        logonInfo.ConnectionInfo = connectionInfo;
                        table.ApplyLogOnInfo(logonInfo);

                        System.Diagnostics.Debug.WriteLine($"SUBTABLE: Name='{table.Name}' | originalLoc='{originalLoc + sufijo}' | setLocation='{table.Location}'");
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error ajustando subtabla: {ex.Message}");
                    }
                }
            }
        }

    }
}