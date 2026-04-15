using SIMANET_W22R.srvGestionCostos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionCostos.Pagos
{
    /// <summary>
    /// Descripción breve de Pagos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Pagos : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_analisis_gastos_ccnatudet(string D_AÑO_DE_PROCESO, string D_MES_DE_PROCESO, string V_CENTRO_OPERATIVO, string V_CUENTA_MAYOR, string UserName)
        {
            CostosSoapClient oP = new CostosSoapClient();
            dt = oP.Listar_analisis_gastos_ccnatudet(D_AÑO_DE_PROCESO, D_MES_DE_PROCESO, V_CENTRO_OPERATIVO, V_CUENTA_MAYOR, UserName);
            dt.TableName = "SP_Analisis_Gastos_CCNatuDet";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_analisis_gast_itemsasient(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_NUMERO_OT, string UserName)
        {
            CostosSoapClient oCs = new CostosSoapClient();
            DataTable dtError = new DataTable("SP_Analisis_Gast_itemsAsientOT");
            
            // Configura estructura tabla de error // Los campos se toman de las etiquetas de reporte crystal
            dtError.TableName = "SP_Analisis_Gast_itemsAsientOT";
            dtError.Columns.Add("CENTRO_COSTO", typeof(string));
            dtError.Columns.Add("CENTRO_OPERATIVO", typeof(string));
            try
            {
                // -----validamos datos Obligatorios ----
                if (V_CENTRO_OPERATIVO == "-1" || V_CENTRO_OPERATIVO == "")
                {
                    DataRow row = dtError.NewRow();
                    row["CENTRO_OPERATIVO"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_NUMERO_OT == "0" || V_NUMERO_OT == "")
                {
                    DataRow row = dtError.NewRow();
                    row["CENTRO_OPERATIVO"] = "Ingrese el Número de la OT, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_DIVISION == "-1" || V_DIVISION == "")
                {
                    DataRow row = dtError.NewRow();
                    row["CENTRO_OPERATIVO"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
               
                // ----------------------------------------------------


                dt = oCs.Listar_analisis_gast_itemsasient(V_CENTRO_OPERATIVO, V_DIVISION, V_NUMERO_OT, UserName);
                dt.TableName = "SP_Analisis_Gast_itemsAsientOT";
                if (dt != null)  // valida vacio
                {

                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Analisis_Gast_itemsAsientOT";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["CENTRO_OPERATIVO"] = "No existen registros para los parámetros consultados: " + V_CENTRO_OPERATIVO + " " + V_DIVISION +  " " + V_NUMERO_OT;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["CENTRO_OPERATIVO"] = "No existen registros para los parámetros consultados: " + V_CENTRO_OPERATIVO + " " + V_DIVISION +   " " + V_NUMERO_OT;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["CENTRO_OPERATIVO"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oCs != null)
                {
                    try
                    {
                        if (oCs.State != System.ServiceModel.CommunicationState.Faulted)
                            oCs.Close();
                        else
                            oCs.Abort();
                    }
                    catch
                    { oCs.Abort(); }
                }
            }

        }



    }
}
