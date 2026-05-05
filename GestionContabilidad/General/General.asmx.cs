using SIMANET_W22R.srvGestionContabilidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionContabilidad.General
{
    /// <summary>
    /// Descripción breve de General
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class General : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable CentrosdeCosto(string V_CENTRO_OPERATIVO, string V_GRUPO_CC_DESDE, string V_GRUPO_CC_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_centros_de_costo(V_CENTRO_OPERATIVO, V_GRUPO_CC_DESDE, V_GRUPO_CC_HASTA, UserName);
            dt.TableName = "SP_Centros_de_Costo";

            return dt;
        }

        [WebMethod]
        public DataTable TipodeCambio(string V_ANIO, string V_CODMND, string V_MESFIN, string V_MESINI, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            DataTable dtError = new DataTable("SP_Tipo_de_Cambio");
            DateTime fechaIni, fechaFin;
            // Configura estructura tabla de error // Los campos se toman de las etiquetas de reporte crystal
            dtError.TableName = "SP_Tipo_de_Cambio";
            dtError.Columns.Add("MONEDA", typeof(string));
            dtError.Columns.Add("FECHA", typeof(string));
            try
            {
                if (V_ANIO == "-1" || V_ANIO == "")
                {
                    DataRow row = dtError.NewRow();
                    row["MONEDA"] = "Ingrese el año, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODMND == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["MONEDA"] = "Seleccione la Moneda, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_MESINI == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["MONEDA"] = "Seleccione el Mes inicial, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_MESFIN == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["MONEDA"] = "Seleccione el Mes final, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                dt = oCtbl.Listar_tipo_de_cambio(V_ANIO, V_CODMND, V_MESFIN, V_MESINI, UserName);
            

            // ----------------------------------------------------
            

            if (dt != null)  // valida vacio
            {
                dt.TableName = "SP_Tipo_de_Cambio";
                if (dt.Rows.Count > 0)
                {
                    dt.TableName = "SP_Tipo_de_Cambio";
                    return dt;
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["MONEDA"] = "No existen registros para los parámetros consultados: " + V_ANIO + " Rango meses:" + V_MESINI + "-" + V_MESFIN + " " + V_CODMND;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            else
            {
                DataRow row = dtError.NewRow();
                row["MONEDA"] = "No existen registros para los parámetros consultados: " + V_ANIO + " Rango meses:" + V_MESINI + "-"+V_MESFIN + " " + V_CODMND;
                dtError.Rows.Add(row);
                return dtError;
            }
        }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                    row["MONEDA"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oCtbl != null)
                {
                    try
                    {
                        if (oCtbl.State != System.ServiceModel.CommunicationState.Faulted)
                            oCtbl.Close();
                        else
                            oCtbl.Abort();
                    }
                    catch
                    { oCtbl.Abort(); }
                }
            }
        }
    }
}
