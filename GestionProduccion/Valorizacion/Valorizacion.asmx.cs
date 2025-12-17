using SIMANET_W22R.srvGestionProduccion;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProduccion.Valorizacion
{
    /// <summary>
    /// Descripción breve de Valorizacion
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Valorizacion : System.Web.Services.WebService
    {
        DataTable dt;
        [WebMethod]
        public DataTable EstActividad01(string N_CEO, string V_CODDIV, string V_NROVAL, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_est_actividad_01(N_CEO, V_CODDIV, V_NROVAL, UserName);
            dt.TableName = "SP_Est_Actividad_01";

            return dt;
        }
        [WebMethod]
        public DataTable ListaOtsSe01(string V_ANIO, string V_OPCION, string UserName)
        {
            try
            {
                ProduccionSoapClient oPD = new ProduccionSoapClient();

                if (string.IsNullOrWhiteSpace(V_ANIO) || V_ANIO == "-1")
                {
                    throw new ArgumentException("El parámetro \"Año\" es obligatorio y no puede estar vacío");
                }
                if (string.IsNullOrWhiteSpace(V_OPCION) || V_OPCION == "-1")
                {
                    throw new ArgumentException("El parámetro \"Opción\" es obligatorio y no puede estar vacío");
                }
                if (string.IsNullOrWhiteSpace(V_ANIO) || V_ANIO.Length != 2 || !int.TryParse(V_ANIO, out _))
                {
                    throw new ArgumentException("El parámetro \"Año\" es obligatorio y debe tener exactamente 2 dígitos numéricos.");
                }

                dt = oPD.Listar_lista_ots_se_01(V_ANIO, V_OPCION, UserName);
                dt.TableName = "SP_lista_ots_se_01";
                if (dt == null)
                { throw new ArgumentException("No se devolvieron resultados."); }

                return dt;
            }
            catch (Exception ex)
            {
                // 2. reenviamos el resultado mediante una tabla con los campos que tiene el procediemiento almacenado
                //  Siempre devuelve un DataTable válido con el mensaje de error
                DataTable errorTable = new DataTable("SP_lista_ots_se_01");
                errorTable.Columns.Add("COD_CC", typeof(bool));
                errorTable.Columns.Add("DES_CC", typeof(string));
                errorTable.Rows.Add(false, ex.Message);
                return errorTable;
            }
        }

        [WebMethod]
        public DataTable Valorizacionr01(string D_FECHAFIN, string D_FECHAINI, string V_CO, string V_DIVISION, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_valorizacionr01(D_FECHAFIN, D_FECHAINI, V_CO, V_DIVISION, UserName);
            dt.TableName = "SP_valorizacionR01";

            return dt;
        }

        [WebMethod]
        public DataTable Valorizacionrproy(string V_CO, string V_DIVISION, string V_OT, string V_PROYECTO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();

            //dt.TableName = "SP_valorizacionRProy";
            DataTable dtError = new DataTable("SP_valorizacionRProy");

            dtError.TableName = "SP_valorizacionRProy";
            dtError.Columns.Add("COD_CLI", typeof(string));
            dtError.Columns.Add("NOM_UND", typeof(string)); // el campo se toma de reporte crystal
            try
            {
                // -----validamos datos Obligatorios ----
                if (V_CO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["NOM_UND"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_PROYECTO == "-1" || V_PROYECTO == "")
                {
                    DataRow row = dtError.NewRow();
                    row["NOM_UND"] = "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_DIVISION == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["NOM_UND"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }


                // ----------------------------------------------------

                dt = oPD.Listar_valorizacionrproy(V_CO, V_DIVISION, V_OT, V_PROYECTO, UserName);
                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_valorizacionRProy";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_valorizacionRProy";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["NOM_UND"] = "No existen registros para los parámetros consultados: " + V_CO + " " + V_PROYECTO + V_OT + " " + V_DIVISION;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["NOM_UND"] = "No existen registros para los parámetros consultados: " + V_CO + " " + V_PROYECTO + V_OT + " " + V_DIVISION;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["NOM_UND"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    { oPD.Abort(); }
                }
            }
            //   return dt;
        }

        [WebMethod]
        public DataTable Valorizacionrproy02(string D_FECHAFIN, string D_FECHAINI, string V_CO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_valorizacionrproy_02(D_FECHAFIN, D_FECHAINI, V_CO, V_DIVISION, V_PROYECTO, UserName);
            dt.TableName = "SP_valorizacionRProy_02";
            Session["DataTable"] = dt;
            return dt;
        }

        [WebMethod]
        public DataTable Valorizacionrunidad(string N_CEO, string V_CODCLI, string V_CODDIV, string V_CODUND, string V_PERIODO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_valorizacionrunidad(N_CEO, V_CODCLI, V_CODDIV, V_CODUND, V_PERIODO, UserName);
            dt.TableName = "SP_ValorizacionRUnidad";
            Session["DataTable"] = dt;
            return dt;
        }

        [WebMethod(EnableSession = true)]
        public DataTable ValorizacionR(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string V_CODDIV, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();

            DataTable dtError = new DataTable("SP_ValorizacionR");

            dtError.TableName = "SP_ValorizacionR";
            dtError.Columns.Add("COD_DIV", typeof(string));
            dtError.Columns.Add("DESCRIP_PRODUC", typeof(string));
            try
            {

                dt = oPD.Listar_valorizacionr(D_FECHAFIN, D_FECHAINI, N_CEO, V_CODDIV, UserName);
                dt.TableName = "SP_ValorizacionR";

                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_ValorizacionR";
                    return dt;
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIP_PRODUC"] = "No existen registros para los parámetros consultados " + V_CODDIV + " " + D_FECHAINI + " " + D_FECHAFIN;
                    dtError.Rows.Add(row);
                    return dtError;
                }

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["DESCRIP_PRODUC"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPD != null)
                {
                    try
                    {
                        if (oPD.State != System.ServiceModel.CommunicationState.Faulted)
                            oPD.Close();
                        else
                            oPD.Abort();
                    }
                    catch
                    { oPD.Abort(); }
                }
            }

        }

        [WebMethod]
        public DataTable ValorizacionRxAN(string N_CEO, string V_CODDIV, string V_PAAMM, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_valorizacionrxan(N_CEO, V_CODDIV, V_PAAMM, UserName);
            dt.TableName = "SP_ValorizacionRxAN";

            return dt;
        }
        [WebMethod]
        public DataTable Valorizacionrproy01(string V_CO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_valorizacionrproy01(V_CO, V_DIVISION, V_PROYECTO, UserName);
            dt.TableName = "SP_valorizacionRProy01";

            return dt;
        }
        [WebMethod]
        public DataTable Listar_est_actividad(string N_CEO, string V_CODDIV, string V_NROVAL, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_est_actividad(N_CEO, V_CODDIV, V_NROVAL, UserName);
            dt.TableName = "SP_Est_Actividad";

            return dt;
        }

        [WebMethod]
        public DataTable Lista_Valorizacion_OT_Callao2(string sCodigoDivision, string sFechaIni, string sFechaFin, string UserName)
        {
            try
            {
                // Llamar al método y obtener el XML como string
                String xmlData = (new ProduccionSoapClient()).Lista_Valorizacion_OT_Callao2("1", sCodigoDivision, sFechaIni, sFechaFin, UserName);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                DataTable dt = ds.Tables["SP_lista_100_2575"];

                return dt;

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                throw new HttpException(500, "Error interno del servidor", ex);
            }
        }
    }
}
