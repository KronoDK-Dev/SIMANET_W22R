using SIMANET_W22R.srvGestionProyecto;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProyecto.Materiales
{
    /// <summary>
    /// Descripción breve de Materiales
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Materiales : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_det_gasto_pry_ot_uti(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_det_gasto_pry_ot_uti(V_CENTRO_OPERATIVO,V_DIVISION,V_PROYECTO,UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_UTI";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_det_gasto_pry_ot_vsm(string V_CENTRO_OPERATIVO, string V_DIVISIÓN, string V_PROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            //  9.-Proyecto Vales Salida de Materiales
            // dt.TableName = "SP_DET_GASTO_PRY_OT_VSM";
            
            DataTable dtError = new DataTable("SP_DET_GASTO_PRY_OT_VSM");
            
            dtError.TableName = "SP_DET_GASTO_PRY_OT_VSM";
            dtError.Columns.Add("OT", typeof(int));
            dtError.Columns.Add("DES_DET", typeof(string)); // el campo se toma de reporte crystal
            try
            {
                // -----validamos datos Obligatorios ----
                if (V_CENTRO_OPERATIVO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["OT"] = 0;
                    row["DES_DET"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_PROYECTO == "-1" || V_PROYECTO == "")
                {
                    DataRow row = dtError.NewRow();
                    row["OT"] = 0;
                    row["DES_DET"] = "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_DIVISIÓN == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["OT"] = 0;
                    row["DES_DET"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                // ----------------------------------------------------
                
                dt = oPy.Listar_det_gasto_pry_ot_vsm(V_CENTRO_OPERATIVO, V_DIVISIÓN, V_PROYECTO, UserName);
                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_DET_GASTO_PRY_OT_VSM";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_DET_GASTO_PRY_OT_VSM";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["OT"] = 0;
                        row["DES_DET"] = "No existen registros para los parámetros consultados: " + V_CENTRO_OPERATIVO + " " + V_DIVISIÓN + V_PROYECTO + " " + V_DIVISIÓN;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["OT"] = 0;
                    row["DES_DET"] = "No existen registros para los parámetros consultados: " + V_CENTRO_OPERATIVO + " " + V_DIVISIÓN + V_PROYECTO + " " + V_PROYECTO;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["OT"] = 0;
                row["DES_DET"] = "Error en servicio: " + ex.Message;
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
        
    }
}
