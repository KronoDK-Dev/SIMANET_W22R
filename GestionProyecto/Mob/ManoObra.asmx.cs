using SIMANET_W22R.srvGestionProduccion;
using SIMANET_W22R.srvGestionProyecto;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProyecto.Mob
{
    /// <summary>
    /// Descripción breve de ManoObra
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class ManoObra : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_det_gasto_pry_ot_mob(string D_FECHA_DE_TRABAJO_DESDE, string D_FECHA_DE_TRABAJO_HASTA, string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
         
            
            
            
            DataTable dtError = new DataTable("SP_DET_GASTO_PRY_OT_MOB");
            DateTime fechaIni, fechaFin;
            dtError.TableName = "SP_DET_GASTO_PRY_OT_MOB";
            dtError.Columns.Add("COD_ATV", typeof(string));
            dtError.Columns.Add("DES_ATV", typeof(string)); // el campo se toma de reporte crystal
            try
            {
                // -----validamos datos Obligatorios ----
                if (V_CENTRO_OPERATIVO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["DES_ATV"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_PROYECTO == "-1" || V_PROYECTO == "")
                {
                    DataRow row = dtError.NewRow();
                    row["DES_ATV"] = "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_DIVISION == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["DES_ATV"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (string.IsNullOrWhiteSpace(D_FECHA_DE_TRABAJO_DESDE))
                {
                    DataRow row = dtError.NewRow();
                    row["DES_ATV"] = "La fecha inicial es obligatoria.";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (!DateTime.TryParseExact(D_FECHA_DE_TRABAJO_DESDE, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaIni))
                {
                    DataRow row = dtError.NewRow();
                    row["DES_ATV"] = "La fecha inicial no tiene un formato válido. Formato correcto: dd/MM/yyyy";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (string.IsNullOrWhiteSpace(D_FECHA_DE_TRABAJO_HASTA))
                {
                    DataRow row = dtError.NewRow();
                    row["DES_ATV"] = "La fecha final es obligatoria.";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (!DateTime.TryParseExact(D_FECHA_DE_TRABAJO_HASTA, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaFin))
                {
                    DataRow row = dtError.NewRow();
                    row["DES_ATV"] = "La fecha final no tiene un formato válido. Formato correcto: dd/MM/yyyy";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                // ----------------------------------------------------

                dt = oPy.Listar_det_gasto_pry_ot_mob(D_FECHA_DE_TRABAJO_DESDE, D_FECHA_DE_TRABAJO_HASTA, V_CENTRO_OPERATIVO, V_DIVISION, V_PROYECTO, UserName);

                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_DET_GASTO_PRY_OT_MOB";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_DET_GASTO_PRY_OT_MOB";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["DES_ATV"] = "No existen registros para los parámetros consultados: " + V_PROYECTO + " " + V_DIVISION +  " " + D_FECHA_DE_TRABAJO_DESDE + " " + D_FECHA_DE_TRABAJO_HASTA;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["DES_ATV"] = "No existen registros para los parámetros consultados: " + V_PROYECTO + " " + V_DIVISION +  " " + D_FECHA_DE_TRABAJO_DESDE + " " + D_FECHA_DE_TRABAJO_HASTA;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["DES_ATV"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPy != null)
                {
                    try
                    {
                        if (oPy.State != System.ServiceModel.CommunicationState.Faulted)
                            oPy.Close();
                        else
                            oPy.Abort();
                    }
                    catch
                    { oPy.Abort(); }
                }
            }
        }

        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }
    }
}
