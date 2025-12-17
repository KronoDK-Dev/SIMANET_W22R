using SIMANET_W22R.srvGestionProd_Mantenimiento;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProduccion.Mantenimiento
{
    /// <summary>
    /// Descripción breve de Mantenimiento
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Mantenimiento : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_consumo_mat_ots2(string S_CEO, string S_CODDIV, string S_OT, string S_FINICIO, string S_FTERMINO, string UserName)
        {
            try
            {

                //  validamos parámetros
                if (string.IsNullOrWhiteSpace(S_CEO) || S_CEO == "-1")
                {
                    throw new ArgumentException("El parámetro \"Centro Operativo/ Sucursal\" es obligatorio y no puede estar vacío. Coordine con el área respectiva para su asignación");
                }
                if (string.IsNullOrWhiteSpace(S_CODDIV) || S_CODDIV == "-1")
                {
                    throw new ArgumentException("El parámetro \"Linea de Negocio\" es obligatorio y no puede estar vacío. Coordine con el área respectiva para su asignación");
                }

                // Llamar al método y obtener el XML como string
                String xmlData = (new MantenimientoSoapClient()).Listar_consumo_mat_ots2(S_CEO, S_CODDIV, S_OT, S_FINICIO, S_FTERMINO, UserName);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                DataTable dt = ds.Tables["SP_CONSUMO_MAT_OTS"];
                if (dt == null)
                { throw new ArgumentException("No se devolvieron resultados."); }


                return dt;

            }
            catch (Exception ex)
            {
                // 2. reenviamos el resultado mediante una tabla con los campos que tiene el procediemiento almacenado
                //  Siempre devuelve un DataTable válido con el mensaje de error
                DataTable errorTable = new DataTable("SP_CONSUMO_MAT_OTS");
                errorTable.Columns.Add("actividad", typeof(bool));
                errorTable.Columns.Add("des_atv", typeof(string));
                errorTable.Rows.Add(false, ex.Message);
                return errorTable;

            }
        }
        [WebMethod]
        public DataTable Listar_recursos_ots2(string S_Anio, string UserName)
        {
            try
            {

                if (string.IsNullOrWhiteSpace(S_Anio) || S_Anio == "-1")
                {
                    throw new ArgumentException("El parámetro \"Año\" es obligatorio y no puede estar vacío");
                }

                if (string.IsNullOrWhiteSpace(S_Anio) || S_Anio.Length != 4 || !S_Anio.All(char.IsDigit))
                {
                    throw new ArgumentException("El parámetro \"Año\" debe tener exactamente 4 dígitos numéricos.");
                }
                // Llamar al método y obtener el XML como string
                String xmlData = (new MantenimientoSoapClient()).Listar_recursos_ots2(S_Anio, UserName);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                DataTable dt = ds.Tables["SP_RECOTSSE"];
                if (dt == null)
                { throw new ArgumentException("No se devolvieron resultados."); }

                return dt;

            }
            catch (Exception ex)
            {
                // 2. reenviamos el resultado mediante una tabla con los campos que tiene el procediemiento almacenado
                //  Siempre devuelve un DataTable válido con el mensaje de error
                DataTable errorTable = new DataTable("SP_RECOTSSE");
                errorTable.Columns.Add("cod_ceo", typeof(bool));
                errorTable.Columns.Add("tll", typeof(string));
                errorTable.Rows.Add(false, ex.Message);
                return errorTable;

            }
        }
        [WebMethod]
        public DataTable Listar_gasto_otx_fecha2(string S_CEO, string S_CODDIV, string S_OT, string S_FINICIO, string S_FTERMINO, string UserName)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(S_CEO) || S_CEO == "-1")
                {
                    throw new ArgumentException("El parámetro \"Centro Operativo/ Sucursal\" es obligatorio y no puede estar vacío. Coordine con el área respectiva para su asignación");

                }
                if (string.IsNullOrWhiteSpace(S_CODDIV) || S_CODDIV == "-1")
                {
                    throw new ArgumentException("El parámetro \"Linea de Negocio\" es obligatorio y no puede estar vacío. Coordine con el área respectiva para su asignación");

                }

                // Llamar al método y obtener el XML como string
                String xmlData = (new MantenimientoSoapClient()).Listar_gasto_otx_fecha2(S_CEO, S_CODDIV, S_OT, S_FINICIO, S_FTERMINO, UserName);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                DataTable dt = ds.Tables["SP_gasto_otx_fecha"];
                if (dt == null)
                { throw new ArgumentException("No se devolvieron resultados."); }
                return dt;

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                //  throw new HttpException(500, "Error interno del servidor", ex);
                // 2. reenviamos el resultado mediante una tabla con los campos que tiene el procediemiento almacenado
                //  Siempre devuelve un DataTable válido con el mensaje de error
                DataTable errorTable = new DataTable("SP_gasto_otx_fecha");
                errorTable.Columns.Add("div", typeof(bool));
                errorTable.Columns.Add("nombre_prd", typeof(string));
                errorTable.Rows.Add(false, ex.Message);
                return errorTable;

            }
        }
        [WebMethod]
        public DataTable Listar_ots_se2(string V_CEO, string V_CODDIV, string V_OT, string V_FINICIO, string V_FTERMINO, string V_BIEN, string UserName)
        {
            MantenimientoSoapClient oMtt = new MantenimientoSoapClient();
            DataTable dtError = new DataTable("SP_Lista_OTS_SE");

            dtError.TableName = "SP_Lista_OTS_SE";
            dtError.Columns.Add("cod_ubi", typeof(string));
            dtError.Columns.Add("des_ubi", typeof(string)); // el campo se toma de reporte crystal

            try
            {
                //  validamos parámetros
                if (string.IsNullOrWhiteSpace(V_CEO) || V_CEO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["des_ubi"] = "El parámetro \"Centro Operativo/ Sucursal\" es obligatorio y no puede estar vacío. Coordine con el área respectiva para su asignación";
                    dtError.Rows.Add(row);
                    return dtError;

                }
                if (string.IsNullOrWhiteSpace(V_CODDIV) || V_CODDIV == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["des_ubi"] = "El parámetro \"Linea de Negocio\" es obligatorio y no puede estar vacío. Coordine con el área respectiva para su asignación";
                    dtError.Rows.Add(row);
                    return dtError;
                }


                // Llamar al método y obtener el XML como string
                String xmlData = oMtt.Listar_ots_se2(V_CEO, V_CODDIV, V_OT, V_FINICIO, V_FTERMINO, V_BIEN, UserName);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                DataTable dt = ds.Tables["SP_Lista_OTS_SE"];
                if (dt == null)
                {
                    DataRow row = dtError.NewRow();
                    row["des_ubi"] = "No se encontraron resultados para los parámetros enviados. " + V_CODDIV + V_OT + " " + V_FINICIO + " " + V_FTERMINO + " " + V_BIEN;
                    dtError.Rows.Add(row);
                    return dtError;
                }

                return dt;

            }
            catch (Exception ex)
            {
                // 2. reenviamos el resultado mediante una tabla con los campos que tiene el procediemiento almacenado
                //  Siempre devuelve un DataTable válido con el mensaje de error
                DataRow row = dtError.NewRow();
                row["des_ubi"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;


            }

            finally
            {
                if (oMtt != null)
                {
                    try
                    {
                        if (oMtt.State != System.ServiceModel.CommunicationState.Faulted)
                            oMtt.Close();
                        else
                            oMtt.Abort();
                    }
                    catch
                    { oMtt.Abort(); }
                }
            }


        }
    }
}
