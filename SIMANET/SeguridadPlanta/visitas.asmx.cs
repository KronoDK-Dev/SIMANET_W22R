using SIMANET_W22R.srvGestionSeguridadPlanta;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    /// <summary>
    /// Descripción breve de visitas
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class visitas : System.Web.Services.WebService
    {
        DataTable dtResultados;
        DataTable dtError = new DataTable();
        DataTable dt = new DataTable();

        [WebMethod(Description = "Lista la Programacion de visitas")]
        public DataTable ListarTodos(string S_PROGRAMACION, string S_PERIODO, string S_TIPOPROGRA, string IdUser)
        {
            //  dtResultados = (new ProyectoSoapClient()).ListarAdendasPorProyecto(V_COD_PRY);
            VisitasSoapClient oVisitas = new VisitasSoapClient();
            DataTable dtError = new DataTable("uspNTADConsultarProgramacionVisita_CVST");

            dtError.TableName = "uspNTADConsultarProgramacionVisita_CVST";
            dtError.Columns.Add("NroProg", typeof(Int64));
            dtError.Columns.Add("RazonSocial", typeof(string));
            dtError.Columns.Add("NombreArea", typeof(string));
            dtError.Columns.Add("Observaciones", typeof(string));
            dtError.Columns.Add("FechaInicio", typeof(DateTime));
            dtError.Columns.Add("FechaTermino", typeof(DateTime));
            dtError.Columns.Add("HoraInicio", typeof(string));
            dtError.Columns.Add("NroVisitas", typeof(Int16));
            dtError.Columns.Add("idEstado", typeof(Int16));

            try
            {
                // -----validamos datos Obligatorios ----

                if (S_PROGRAMACION == "-1" || S_PROGRAMACION == "")
                {
                    S_PROGRAMACION = "0";
                }
                if (S_PERIODO == "-1" || S_PERIODO == "")
                {
                    S_PERIODO = "0";
                }
                if (S_TIPOPROGRA == "-1" || S_TIPOPROGRA == "")
                {
                    S_TIPOPROGRA = "1";
                }


                // --------recibe un  string--------------------------------------------
                string xmlData = oVisitas.ListarTodos(S_PROGRAMACION, S_PERIODO, S_TIPOPROGRA, IdUser);
                // Crear un Datatable y cargar el XML


                var ds = new DataSet();
                using (var sr = new StringReader(xmlData))
                using (var xr = System.Xml.XmlReader.Create(sr))
                {
                    // Auto funciona bien con XSD + DiffGram; DiffGram también es válido.
                    ds.ReadXml(xr, XmlReadMode.Auto);
                    // ds.ReadXml(xr, XmlReadMode.DiffGram); // alternativa
                }

                // Saca la tabla; si el nombre no existe, usa la primera
                var dt = ds.Tables["uspNTADConsultarProgramacionVisita_CVST"]
                         ?? (ds.Tables.Count > 0 ? ds.Tables[0] : null);




                if (dt != null) // valida vacio
                {
                    dt.TableName = "uspNTADConsultarProgramacionVisita_CVST";
                    //----- solo cuando quieres mostrar campos fecha como string, sin hora

                    // Asegura columnas string que la UI espera
                    EnsureStrCols(dt);

                    bool hasFI = dt.Columns.Contains("FechaInicio");
                    bool hasFT = dt.Columns.Contains("FechaTermino");

                    foreach (DataRow row in dt.Rows)
                    {
                        row["FechaInicioStr"] = hasFI ? FormatearFecha(row["FechaInicio"]) : string.Empty;
                        row["FechaTerminoStr"] = hasFT ? FormatearFecha(row["FechaTermino"]) : string.Empty;
                    }


                    //---------------------------------------------------------
                    
                    if (dt.Rows.Count > 0)
                    {
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["Observaciones"] = "No existen registros para los parámetros consultados: nro programación/periodo/tipo-programación " + S_PROGRAMACION + "-"+ S_PERIODO+ "-"+ S_TIPOPROGRA;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["Observaciones"] = "No existen registros para los parámetros consultados: nro programación/periodo/tipo-programación " + S_PROGRAMACION + "-" + S_PERIODO + "-" + S_TIPOPROGRA;
                    row["idEstado"] = 0;
                    dtError.Rows.Add(row);
                    EnsureStrCols(dtError);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["Observaciones"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oVisitas != null)
                {
                    try
                    {
                        if (oVisitas.State != System.ServiceModel.CommunicationState.Faulted)
                            oVisitas.Close();
                        else
                            oVisitas.Abort();
                    }
                    catch
                    {
                        oVisitas.Abort();
                    }
                }
            }
        }
        private static void EnsureStrCols(DataTable t)
        {
            if (!t.Columns.Contains("FechaInicioStr")) t.Columns.Add("FechaInicioStr", typeof(string));
            if (!t.Columns.Contains("FechaTerminoStr")) t.Columns.Add("FechaTerminoStr", typeof(string));
        }



        private static string FormatearFecha(object val)
        {
            if (val == null || val == DBNull.Value) return string.Empty;

            if (val is DateTime dt) return dt.ToString("dd/MM/yyyy");

            var s = val.ToString();
            if (DateTimeOffset.TryParse(s, out var dto)) return dto.DateTime.ToString("dd/MM/yyyy");
            if (DateTime.TryParse(s, out var d)) return d.ToString("dd/MM/yyyy");

            return s; // fallback
        }




    }
}
