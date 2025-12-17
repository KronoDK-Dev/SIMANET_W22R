using SIMANET_W22R.srvGestionTesoreria;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionTesoreria.Pagos
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
        TesoreriaSoapClient TES = new TesoreriaSoapClient();

        [WebMethod]
        public DataTable Listar_cheques_giradosxprove_res(string D_AÑO, string D_MES, string V_CENTRO_OPERATIVO, string V_RELACION_DESDE, string V_RELACION_HASTA, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_cheques_giradosxprove_res(D_AÑO, D_MES, V_CENTRO_OPERATIVO, V_RELACION_DESDE, V_RELACION_HASTA, UserName);
            dt.TableName = "SP_Cheques_GiradosxProve_Res";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_cheques_giradosxprove_det(string V_CENTRO_OPERATIVO, string D_FECHA_HASTA, string D_FECHA_DESDE, string V_RELACION_DESDE, string V_RELACION_HASTA, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_cheques_giradosxprove_det(D_FECHA_DESDE, D_FECHA_HASTA, V_CENTRO_OPERATIVO, V_RELACION_DESDE, V_RELACION_HASTA, UserName);
            dt.TableName = "SP_Cheques_GiradosxProve_Det";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_cheques_emitidos_resumen(string D_AÑO, string V_CENTRO_OPERATIVO, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            DataTable dtError = new DataTable("SP_Cheques_Emitidos_Resumen");

            //---
            try
            {


                dtError.TableName = "SP_Cheques_Emitidos_Resumen";
                dtError.Columns.Add("BANCO", typeof(string));

                // *********** valida data ************
                if (D_AÑO == null || string.IsNullOrEmpty(D_AÑO))
                {
                    DataRow row = dtError.NewRow();
                    row["BANCO"] = "Debe ingresar el parámetro AÑO";
                    dtError.Rows.Add(row);
                }


                if (V_CENTRO_OPERATIVO == null || string.IsNullOrEmpty(V_CENTRO_OPERATIVO))
                {
                    V_CENTRO_OPERATIVO = "1";
                }
                // SI HUBO ERROR EN LAS LINEAS ANTERIORES DEVOLVEMOS Y SALIMOS

                if (dtError.Rows.Count > 0)
                {
                    return dtError;
                }


                //----------------------


                dt = ts.Listar_cheques_emitidos_resumen(D_AÑO, V_CENTRO_OPERATIVO, UserName);
                dt.TableName = "SP_Cheques_Emitidos_Resumen";
                if (dt != null)  // valida vacio
                {
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Cheques_Emitidos_Resumen";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["BANCO"] = "No existen registros para los parámetros consultados: " + D_AÑO + " " + V_CENTRO_OPERATIVO;
                        dtError.Rows.Add(row);
                        return dtError;
                    }

                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["BANCO"] = "No existen registros para los parámetros consultados " + V_CENTRO_OPERATIVO + " " + D_AÑO;
                    dtError.Rows.Add(row);
                    return dtError;
                }

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["BANCO"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (TES != null)
                {
                    try
                    {
                        if (TES.State != System.ServiceModel.CommunicationState.Faulted)
                            TES.Close();
                        else
                            TES.Abort();
                    }
                    catch
                    { TES.Abort(); }
                }
            }
        }

        [WebMethod]
        public DataTable Listar_cheques_por_observacion(string V_CENTRO_OPERATIVO, string D_FECHA_DESDE, string D_FECHA_HASTA, string V_OBSERVACION, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_cheques_por_observacion(D_FECHA_DESDE, D_FECHA_HASTA, V_CENTRO_OPERATIVO, V_OBSERVACION, UserName);
            dt.TableName = "SP_Cheques_por_Observacion";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_cheque_giradoxnum(string V_CENTRO_OPERATIVO, string V_CHEQUE_NUMERO, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_cheque_giradoxnum(V_CENTRO_OPERATIVO, V_CHEQUE_NUMERO, UserName);
            dt.TableName = "SP_Cheque_GiradoxNum";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_lote_de_detrac_por_doc(string V_CENTRO_OPERATIVO, string V_NUMERO_DE_LOTE, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_lote_de_detrac_por_doc(V_CENTRO_OPERATIVO, V_NUMERO_DE_LOTE, UserName);
            dt.TableName = "SP_Lote_de_Detrac_por_Doc";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_fact_pagar_pendientes(string V_RECURSO, string V_RUC, string V_PROYECTO, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_fact_pagar_pendientes(V_RECURSO, V_RUC, V_PROYECTO, UserName);
            dt.TableName = "SP_Fact_Pagar_Pendientes";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_fact_por_pagar_doc(string D_AÑO, string D_MES, string V_RELACION_DESDE, string V_RELACION_HASTA, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_fact_por_pagar_doc(D_AÑO, D_MES, V_RELACION_DESDE, V_RELACION_HASTA, UserName);
            dt.TableName = "SP_Fact_por_Pagar_Doc";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_facturas_por_pagar_total(string UserName)
        {

            dt = TES.Listar_facturas_por_pagar_total(UserName);
            dt.TableName = "SP_Facturas_por_Pagar_Total";
            return dt;
        }

        [WebMethod(Description = "Pagos a proveedores")]
        public DataTable Listar_pago_proveedores(string V_SUCURSAL, string V_RUC_INI, string V_RUC_FIN, string v_fecha_ini, string v_fecha_fin,
                                               string v_operacion, string UserName)
        {
            DataTable dtError = new DataTable("SP_Pago_proveedores");
            TesoreriaSoapClient TES = new TesoreriaSoapClient();
            try
            {


                dtError.TableName = "SP_Pago_proveedores";

                DataColumn colRelacion = new DataColumn("RELACIÓN", typeof(string));
                colRelacion.DefaultValue = "SIN RELACIÓN"; // Valor por defecto
                dtError.Columns.Add(colRelacion);

                dtError.Columns.Add("DESCRIPCION", typeof(string));

                // *********** valida data ************
                if (v_operacion == null || string.IsNullOrEmpty(v_operacion))
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] = "Debe ingresar el parámetro OPERACION, ejemplo: Cheque";
                    dtError.Rows.Add(row);
                }
                if ((v_fecha_ini == null || string.IsNullOrEmpty(v_fecha_ini)) && (V_RUC_INI != V_RUC_FIN))
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] = "Debe Seleccionar el parámetro FECHA DE INICIO";
                    dtError.Rows.Add(row);
                }

                if ((v_fecha_fin == null || string.IsNullOrEmpty(v_fecha_fin)) && (V_RUC_INI != V_RUC_FIN))
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] = "Debe Seleccionar el parámetro FECHA DE FIN";
                    dtError.Rows.Add(row);
                }
                if (V_RUC_INI == null || string.IsNullOrEmpty(V_RUC_INI))
                {
                    V_RUC_INI = "0";
                }

                if (V_RUC_FIN == null || string.IsNullOrEmpty(V_RUC_FIN))
                {
                    V_RUC_FIN = "9999999999999";
                }
                if (V_SUCURSAL == null || string.IsNullOrEmpty(V_SUCURSAL))
                {
                    V_SUCURSAL = "1";
                }
                // SI HUBO ERROR EN LAS LINEAS ANTERIORES DEVOLVEMOS Y SALIMOS

                if (dtError.Rows.Count > 0)
                {
                    return dtError;
                }


                //----------------------
                dt = TES.Listar_pago_proveedores(V_SUCURSAL, V_RUC_INI, V_RUC_FIN, v_fecha_ini, v_fecha_fin, v_operacion, UserName);


                if (dt != null)  // valida vacio
                {
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Pago_proveedores";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["DESCRIPCION"] = "No existen registros para los parámetros consultados: " + V_SUCURSAL + " " + V_RUC_INI + " " + V_RUC_FIN + " " + v_fecha_ini + " " + v_fecha_fin + " " + v_operacion;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] = "No existen registros para los parámetros consultados " + V_SUCURSAL + " " + V_RUC_INI + " " + V_RUC_FIN + " " + v_fecha_ini + " " + v_fecha_fin + " " + v_operacion;
                    dtError.Rows.Add(row);
                    return dtError;
                }

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["DESCRIPCION"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (TES != null)
                {
                    try
                    {
                        if (TES.State != System.ServiceModel.CommunicationState.Faulted)
                            TES.Close();
                        else
                            TES.Abort();
                    }
                    catch
                    { TES.Abort(); }
                }
            }

        }

        [WebMethod(Description = "Pagos de Facturas")]
        public DataTable Listar_pago_Facturas(string V_SUCURSAL, string V_RUC_INI, string V_RUC_FIN, string v_fecha_ini, string v_fecha_fin,
                                         string v_operacion, string UserName)
        {


            DataTable dtError = new DataTable("SP_Pago_facturas");
            TesoreriaSoapClient TES = new TesoreriaSoapClient();
            try
            {


                dtError.TableName = "SP_Pago_facturas";

                DataColumn colRelacion = new DataColumn("RELACIÓN", typeof(string));
                colRelacion.DefaultValue = "SIN RELACIÓN"; // Valor por defecto
                dtError.Columns.Add(colRelacion);

                dtError.Columns.Add("DESCRIPCION", typeof(string));

                // *********** valida data ************
                if (v_operacion == null || string.IsNullOrEmpty(v_operacion))
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] = "Debe ingresar el parámetro OPERACION, ejemplo: Cheque";
                    dtError.Rows.Add(row);
                }
                if ((v_fecha_ini == null || string.IsNullOrEmpty(v_fecha_ini)) && (V_RUC_INI != V_RUC_FIN))
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] = "Debe Seleccionar el parámetro FECHA DE INICIO";
                    dtError.Rows.Add(row);
                }
                if ((v_fecha_fin == null || string.IsNullOrEmpty(v_fecha_fin)) && (V_RUC_INI != V_RUC_FIN))
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] = "Debe Seleccionar el parámetro FECHA DE FIN";
                    dtError.Rows.Add(row);
                }
                if (V_RUC_INI == null || string.IsNullOrEmpty(V_RUC_INI))
                {
                    V_RUC_INI = "0";
                }

                if (V_RUC_FIN == null || string.IsNullOrEmpty(V_RUC_FIN))
                {
                    V_RUC_FIN = "9999999999999";
                }
                if (V_SUCURSAL == null || string.IsNullOrEmpty(V_SUCURSAL))
                {
                    V_SUCURSAL = "1";
                }
                // SI HUBO ERROR EN LAS LINEAS ANTERIORES DEVOLVEMOS Y SALIMOS

                if (dtError.Rows.Count > 0)
                {
                    return dtError;
                }


                //----------------------

                dt = TES.Listar_pago_Facturas(V_SUCURSAL, V_RUC_INI, V_RUC_FIN, v_fecha_ini, v_fecha_fin, v_operacion, UserName);

                if (dt != null)  // valida vacio
                {

                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Pago_facturas";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["DESCRIPCION"] = "No existen registros para los parámetros consultados: " + V_SUCURSAL + " " + V_RUC_INI + " " + V_RUC_FIN + " " + v_fecha_ini + " " + v_fecha_fin + " " + v_operacion;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] = "No existen registros para los parámetros consultados " + V_SUCURSAL + " " + V_RUC_INI + " " + V_RUC_FIN + " " + v_fecha_ini + " " + v_fecha_fin + " " + v_operacion;
                    dtError.Rows.Add(row);
                    return dtError;
                }

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["DESCRIPCION"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (TES != null)
                {
                    try
                    {
                        if (TES.State != System.ServiceModel.CommunicationState.Faulted)
                            TES.Close();
                        else
                            TES.Abort();
                    }
                    catch
                    { TES.Abort(); }
                }
            }
        }
    }
}
