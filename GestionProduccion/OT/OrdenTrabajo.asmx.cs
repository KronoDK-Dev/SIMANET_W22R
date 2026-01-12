using Aspose.Cells.Revisions;
using EasyControlWeb;
using Microsoft.Win32;
//using NPOI.SS.Formula.Functions;
using SIMANET_W22R.srvGestionLogistica;
using SIMANET_W22R.srvGestionProduccion;
using SIMANET_W22R.srvGestionProyecto;
using SIMANET_W22R.srvLog_ActivoFijo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
//using System.Net.PeerToPeer;
using System.Security.Cryptography;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.UI.WebControls.WebParts;
using static SIMANET_W22R.ClasesExtendidas.Utilitario;

namespace SIMANET_W22R.GestionProduccion.OT
{
    /// <summary>
    /// Descripción breve de OrdenTrabajo
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class OrdenTrabajo : System.Web.Services.WebService
    {
        DataTable dt = new DataTable();
        
        string s_Ambiente = EasyUtilitario.Helper.Configuracion.Leer("Seguridad", "Ambiente");

        [WebMethod]
        public DataTable DetalleGastoPryOtSinFac(string CENTRO_OPERATIVO, string DIVISION, string PROYECTO, string sAnio, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();

            if (string.IsNullOrEmpty(CENTRO_OPERATIVO))
            {
                throw new SoapException("El campo CENTRO_OPERATIVO es obligatorio.",
                    SoapException.ClientFaultCode);
            }

            dt = oPD.Listar_detg_pry_ot_sinfact(CENTRO_OPERATIVO, DIVISION, PROYECTO, sAnio, UserName);
            dt.TableName = "SP_DetG_PRY_OT_SINFACT";
            return dt;
        }
        [WebMethod]
        public DataTable DetalleGastoPryOtFac(string N_CEO, string V_CODDIV, string V_CODPRY, string V_PERIODO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_detalle_gasto_pry_ot_fac(N_CEO, V_CODDIV, V_CODPRY, V_PERIODO, UserName);
            dt.TableName = "SP_Detalle_Gasto_Pry_OT_Fac";
            return dt;
        }
        [WebMethod]
        public DataTable ListaOtsDq(string N_CEO, string V_CODDIV, string D_FECHAINI,string D_FECHAFIN, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_lista_ots_dq(D_FECHAFIN, D_FECHAINI, N_CEO, V_CODDIV, UserName);
            dt.TableName = "SP_Lista_Ots_Dq";
                return dt;
        }
        [WebMethod]
        public DataTable CabeceraOt(string N_CEO, string V_CODDIV, string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            
            
            DataTable dtError = new DataTable("SP_Cabecera_Ot");
            
            dtError.TableName = "SP_Cabecera_Ot";
            dtError.Columns.Add("COD_PRY", typeof(string));
            dtError.Columns.Add("NOM_PRY", typeof(string));
            try
            {

                dt = oPD.Listar_cabecera_ot(N_CEO, V_CODDIV, V_NROOTS, UserName);
                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_Cabecera_Ot";
                    return dt;
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["NOM_PRY"] = "No existen registros para los parámetros consultados " + V_CODDIV + V_NROOTS;
                    dtError.Rows.Add(row);
                    return dtError;
                }
                
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["NOM_PRY"] = "Error en servicio: " + ex.Message;
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
        public DataTable ActividadOt(string N_CEO, string V_CODDIV, string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            DataTable dtError = new DataTable("SP_Actividad_OT");
            
            dtError.TableName = "SP_Actividad_OT";
            dtError.Columns.Add("COD_DIV", typeof(string));
            dtError.Columns.Add("DES_EST_OT", typeof(string));
            try
            {
                // -----validamos datos Obligatorios ----
                if (N_CEO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["DES_EST_OT"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_NROOTS == "-1" || V_NROOTS == "")
                {
                    DataRow row = dtError.NewRow();
                    row["DES_EST_OT"] = "Ingresa un número de OT o un listado separado por / , es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODDIV == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["DES_EST_OT"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }


                    dt = oPD.Listar_actividad_ot(N_CEO, V_CODDIV, V_NROOTS, UserName);
                


                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_Actividad_OT";
                    return dt;
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["DES_EST_OT"] = "No existen registros para los parámetros consultados " + V_CODDIV + V_NROOTS;
               
                    dtError.Rows.Add(row);
                    return dtError;
                }

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["DES_EST_OT"] = "Error en servicio: " + ex.Message;
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
        public DataTable EstadoOt(string N_CEO, string V_CODDIV, string D_FECHAINI,string D_FECHAFIN ,  string V_CODSTD, string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            if (V_CODSTD == "-1")
            {
                V_CODSTD = "";
            }
            dt = oPD.Listar_lista_estado_ot(D_FECHAFIN, D_FECHAINI, N_CEO, V_CODDIV, V_CODSTD, V_NROOTS, UserName);
            dt.TableName = "SP_Lista_Estado_Ot";
                return dt;
        }
        [WebMethod]
        public DataTable DetalleGastoPryOtFacsu(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_det_gasto_pry_ot_facsu(V_CENTRO_OPERATIVO, V_DIVISION, V_PROYECTO, UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_FACSU";
                return dt;
        }
        [WebMethod]
        public DataTable ActividadesJg(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string N_OPCION, string V_CODDIV, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_actividades_jg(D_FECHAFIN, D_FECHAINI, N_CEO, N_OPCION, V_CODDIV, UserName);
            dt.TableName = "SP_Actividades_Jg";
                return dt;
        }
        [WebMethod]
        public DataTable ActividadesJg2(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string N_OPCION, string V_CODDIV, string V_CODTLLR, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_actividades_jg2(D_FECHAFIN, D_FECHAINI, N_CEO, N_OPCION, V_CODDIV, V_CODTLLR, UserName);
            dt.TableName = "SP_Actividades_Jg2";
                return dt;
        }
        [WebMethod]
        public DataTable GastoOtsx(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string V_CODDIV, string V_CODPROY, string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_gasto_otsx(D_FECHAFIN, D_FECHAINI, N_CEO, V_CODDIV, V_CODPROY, V_NROOTS, UserName);
            dt.TableName = "SP_Gasto_OtsX";
                return dt;
        }
        [WebMethod]
        public DataTable ActividadOtProy(string N_CEO, string V_CODDIV, string V_CODPRY, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            DataTable dtError = new DataTable("SP_Actividad_OT_PROY");

            dtError.TableName = "SP_Actividad_OT_PROY";
            dtError.Columns.Add("COD_DIV", typeof(string));
            dtError.Columns.Add("DES_EST_OT", typeof(string)); // el campo se toma de reporte crystal
            try
            {
                // -----validamos datos Obligatorios ----
                if (N_CEO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODPRY == "-1" || V_CODPRY == "")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODDIV == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                // ----------------------------------------------------
                string xmlData = oPD.Listar_actividad_ot_proy(N_CEO, V_CODDIV, V_CODPRY, UserName);
                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                dt = ds.Tables["SP_Actividad_OT_PROY"];


                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_Actividad_OT_PROY";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Actividad_OT_PROY";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["DES_EST_OT"] = "No existen registros para los parámetros consultados: " + V_CODPRY + " " + V_CODDIV + N_CEO ;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["DES_EST_OT"] = "No existen registros para los parámetros consultados: " + V_CODPRY + " " + V_CODDIV + N_CEO;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["DES_EST_OT"] = "Error en servicio: " + ex.Message;
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
        public DataTable ActaConfSolmn(string V_CODUND, string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            // dt = oPD.Listar_acta_conf_solmn(V_CODUND, V_NROOTS, UserName);
            //  dt.TableName = "SP_Acta_Conf_SolMn";
            DataTable dtError = new DataTable("SP_Acta_Conf_SolMn");
            
            dtError.TableName = "SP_Acta_Conf_SolMn";
            dtError.Columns.Add("OTS", typeof(string));
            dtError.Columns.Add("UNIDAD", typeof(string)); // el campo se toma de reporte crystal
            try
            {
                // -----validamos datos Obligatorios ----
              
                if (V_CODUND == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["UNIDAD"] = "Seleccione la Unidad, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
              /*  if (V_NROOTS == "")
                {
                    DataRow row = dtError.NewRow();
                    row["UNIDAD"] = "Ingrese el Nro de Orden de Trabajo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }*/

                // ----------------------------------------------------

                dt = oPD.Listar_acta_conf_solmn(V_CODUND, V_NROOTS, UserName);
                    if (dt != null)  // valida vacio
                    {
                        dt.TableName = "SP_Acta_Conf_SolMn";
                        if (dt.Rows.Count > 0)
                        {
                            dt.TableName = "SP_Acta_Conf_SolMn";
                            return dt;
                        }
                        else
                        {
                            DataRow row = dtError.NewRow();
                            row["UNIDAD"] = "No existen registros para los parámetros consultados: " + V_CODUND + " " + V_NROOTS ;
                            dtError.Rows.Add(row);
                            return dtError;
                        }
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["UNIDAD"] = "No existen registros para los parámetros consultados: " + V_CODUND + " "  + V_NROOTS ;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["UNIDAD"] = "Error en servicio: " + ex.Message;
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
        public DataTable ActaConfInfGen(string V_CODUND, string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_acta_conf_inf_gen(V_CODUND, V_NROOTS, UserName);
            dt.TableName = "SP_Acta_Conf_Inf_Gen";
                return dt;
        }
        [WebMethod]
        public DataTable DetalleOtsRecursos(string N_CEO, string V_CATVCRV, string V_CODDIV, string V_NROOTS, string V_TIPRCS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_detalle_ots_recursos(N_CEO, V_CATVCRV, V_CODDIV, V_NROOTS, V_TIPRCS, UserName);
            dt.TableName = "SP_Detalle_Ots_Recursos";
                return dt;
        }
        [WebMethod]
        public DataTable DetalleGastoPryOTsinFactsu(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_det_gasto_pry_ot_sin_factsu(V_CENTRO_OPERATIVO, V_DIVISION, V_PROYECTO, UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_SIN_FACTSU";
            return dt;
        }
        
        [WebMethod]
        public DataTable DetalleOtsRecursosPry(string N_CEO, string V_CODATV, string V_CODDIV, string V_CODPROY, string V_NROOTS, string V_TIPRCS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            DataTable dtError = new DataTable("SP_Detalle_Ots_Recursos_Pryct");
        
            dtError.TableName = "SP_Detalle_Ots_Recursos_Pryct";
            dtError.Columns.Add("COD_PRY", typeof(string));
            dtError.Columns.Add("Detalle  :", typeof(string)); // el campo se toma de reporte crystal

            try
            {
                // -----validamos datos Obligatorios ----
                if (N_CEO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información" ;
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODPROY == "-1" || V_CODPROY == "")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODDIV == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                // ----  corrigo datos por defecto --- nota: no enviar nulos
                if (V_NROOTS == "")
                { V_NROOTS = "0"; }
                if (V_TIPRCS == "MATE")
                { V_TIPRCS = ""; }
                if (V_CODATV == "T")
                { V_CODATV = ""; }

                // ----------------------------------------------------

                // dt = oPD.Listar_detalle_ots_recursos_pryc(N_CEO, V_CODATV, V_CODDIV, V_CODPROY, V_NROOTS, V_TIPRCS, UserName);
                string xmlData = oPD.Listar_detalle_ots_recursos_pryc2(N_CEO, V_CODATV, V_CODDIV, V_CODPROY, V_NROOTS, V_TIPRCS, UserName);
                
                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                 dt = ds.Tables["SP_Detalle_Ots_Recursos_Pryct"];


                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_Detalle_Ots_Recursos_Pryct";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Detalle_Ots_Recursos_Pryct";
                        return dt;
                    }

                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["Detalle  :"] = "No existen registros para los parámetros consultados: " + V_CODPROY + " " +  V_CODDIV + V_NROOTS + " " + V_CODATV;
                        dtError.Rows.Add(row);
                        return dtError;
                    }

                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "No existen registros para los parámetros consultados: " + V_CODPROY + " " + V_CODDIV + V_NROOTS + " " + V_CODATV;
                    dtError.Rows.Add(row);
                    return dtError;
                }

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["Detalle  :"] = "Error en servicio: " + ex.Message;
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
        public DataTable DetalleOtsRecursosPry_fec(string N_CEO, string V_CODATV, string V_CODDIV, string V_CODPROY, string V_NROOTS, string V_TIPRCS, string D_FECHAINI_EMI, string D_FECHAFIN_EMI,string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            DataTable dtError = new DataTable("SP_Detalle_Ot_Recursos_Pry_fec");//28_detalle_ots_recursos_proyectos.rpt 

            dtError.TableName = "SP_Detalle_Ot_Recursos_Pry_fec";
            dtError.Columns.Add("COD_PRY", typeof(string));
            dtError.Columns.Add("Detalle  :", typeof(string)); // el campo se toma de reporte crystal

            try
            {
                // -----validamos datos Obligatorios ----
                if (N_CEO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODPROY == "-1" || V_CODPROY == "")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODDIV == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                if (V_TIPRCS == "-1")
                {
                    V_TIPRCS = "";
                }
                if (V_NROOTS == "000000")
                {
                    V_NROOTS = "0";
                }






                if (!string.IsNullOrWhiteSpace(D_FECHAINI_EMI))
                { 
                    // 1) Intentar parsear en formatos admitidos para FECHAS
                    // Ajusta los formatos a lo que realmente recibe tu sistema
                    var formatos = new[] { "dd/MM/yyyy", "d/M/yyyy", "yyyy-MM-dd", "dd-MM-yyyy" };

                    // Cultura peruana; si tu servidor está en otra cultura, especifica explícitamente
                    var cultura = new CultureInfo("es-PE");


                    DateTime fechaIni;
                        bool ok = DateTime.TryParseExact(
                            D_FECHAINI_EMI.Trim(),
                            formatos,
                            cultura,
                            DateTimeStyles.None,
                            out fechaIni
                        );

                    if (!ok)
                    {
                        DataRow row = dtError.NewRow();
                        row["Detalle  :"] = $"La fecha inicial '{D_FECHAINI_EMI}' no tiene un formato válido. Use dd/MM/yyyy (p.ej. 01/12/2025).";
                        dtError.Rows.Add(row);
                        return dtError;
                    }

                }

                // ----  corrigo datos por defecto --- nota: no enviar nulos
                if (V_NROOTS == "")
                { V_NROOTS = "0"; }
                if (V_TIPRCS == "MATE")
                { V_TIPRCS = ""; }
                if (V_CODATV == "T")
                { V_CODATV = ""; }

                // ----------------------------------------------------

                // dt = oPD.Listar_detalle_ots_recursos_pryc(N_CEO, V_CODATV, V_CODDIV, V_CODPROY, V_NROOTS, V_TIPRCS, UserName);
                string xmlData = oPD.Listar_Detalle_Ot_Recursos_Pry_fec(N_CEO, V_CODATV, V_CODDIV, V_CODPROY, V_NROOTS, V_TIPRCS, D_FECHAINI_EMI, D_FECHAFIN_EMI, UserName);

                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                dt = ds.Tables["SP_Detalle_Ot_Recursos_Pry_fec"];


                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_Detalle_Ot_Recursos_Pry_fec";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Detalle_Ot_Recursos_Pry_fec";
                        return dt;
                    }

                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["Detalle  :"] = "No existen registros! para los parámetros consultados: " + V_CODPROY + " " + V_CODDIV + " OT=" + V_NROOTS + " ACT=" + V_CODATV + " D_FECHAINI_EMI=" + D_FECHAINI_EMI + " " + D_FECHAFIN_EMI;
                        dtError.Rows.Add(row);
                        return dtError;
                    }

                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["Detalle  :"] = "No existen registros para los parámetros consultados: " + V_CODPROY + " " + V_CODDIV + " OT=" + V_NROOTS + " ACT=" + V_CODATV + " D_FECHAINI_EMI=" + D_FECHAINI_EMI + " " + D_FECHAFIN_EMI;
                    dtError.Rows.Add(row);
                    return dtError;
                }

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["Detalle  :"] = "Error en servicio: " + ex.Message;
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
        public DataTable Listar_acta_conf(string V_CODUND, string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_acta_conf(V_CODUND, V_NROOTS, UserName);
            dt.TableName = "SP_Acta_Conf";
            return dt;
        }
       
        [WebMethod]
        public DataTable Listar_indicadores(string V_CO, string V_DIVISION, string D_FECHAINI, string D_FECHAFIN,  string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_indicadores(V_CO,V_DIVISION,D_FECHAINI,D_FECHAFIN,UserName);
            dt.TableName = "SP_actividades_jg_man";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_Lista_costo_ot(string V_CEO, string V_DIV, string V_PERIODO, string V_GD, string V_OT_TER,
          string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            string xmlData = oPD.Listar_Lista_costo_ot(V_CEO, V_DIV, V_PERIODO, V_GD, V_OT_TER, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_Lista_costo_ot"];

            return dt;

            //ProduccionSoapClient oPD = new ProduccionSoapClient();
           // dt = oPD.Listar_Lista_costo_ot(V_CEO,V_DIV,V_PERIODO,V_GD,V_OT_TER,UserName);
            //dt.TableName = "SP_Lista_costo_ot";
           // return dt;
        }



        [WebMethod]
        public DataTable Lista_costo_ot_user(string V_CEO, string V_DIV, string V_PERIODO, string V_GD, string V_OT_TER,
          string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            string xmlData = oPD.Lista_costo_ot_user(V_CEO, V_DIV, V_PERIODO, V_GD, V_OT_TER, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            { ds.ReadXml(sr); }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_Lista_costo_ot_user"];
            return dt;
        }

        [WebMethod]
        public DataTable Listar_Lista_OT_Fac(string N_CEO, string V_CODDIV, string V_ESTADO, string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            string xmlData = oPD.Listar_OT_Fac(N_CEO,V_CODDIV,V_ESTADO,D_FECHAINI,D_FECHAFIN,UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_Lista_OT_Fac"];

            return dt;
        }
        /*
        [WebMethod]
        public DataTable DetalleOtsRecursos(string N_CEO, string V_CODATV, string V_CODDIV, string V_CODPROY, string V_NROOTS, string V_TIPRCS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_detalle_ots_recursos_pryc(N_CEO, V_CODATV, V_CODDIV, V_CODPROY, V_NROOTS, V_TIPRCS, UserName);
            dt.TableName = "SP_Detalle_Ots_Recursos_Pryct";
                return dt;
        }
        */

        [WebMethod(Description = "4.- Proyecto Utilización MAT-SER")]
        public DataTable Listar_DETALLE_GASTO_PRY_OT_UTISU(string N_CEO, string V_CODDIV, string V_CODPRY,
            string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_DETALLE_GASTO_PRY_OT_UTISU(N_CEO, V_CODDIV, V_CODPRY, V_NROOTS, UserName);
            dt.TableName = "SP_DETALLE_GASTO_PRY_OT_UTISU";
            return dt;
        }

        [WebMethod(Description = "8.-Proyecto Programa de Adquisiciones")]
        public DataTable Listar_DET_GASTO_PRY_OT_PGMSU(string V_Centro_Operativo, string V_División, string V_Proyecto,
            string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_DET_GASTO_PRY_OT_PGMSU(V_Centro_Operativo, V_División, V_Proyecto, UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_PGMSU";
            return dt;
        }

        [WebMethod(Description = "9.-Proyecto Vales Salida de Materiales (submarinos)")]
        public DataTable Listar_DET_GASTO_PRY_OT_VSMSU(string V_Centro_Operativo, string V_División, string V_Proyecto,
            string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_DET_GASTO_PRY_OT_VSMSU(V_Centro_Operativo, V_División, V_Proyecto, UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_VSMSU";
            return dt;
        }

        //------ metodo con cadena xml -----------------
        [WebMethod(Description = "REPORTE DE OTS")]
        public DataTable Impresion_OTs(string V_OT, string V_COD_DIV, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            string xmlData = oPD.Impresion_OTs(V_OT, V_COD_DIV, UserName);


            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_Impresion_OT"];

            return dt;
        }


        //------ metodo con cadena xml -----------------
        [WebMethod(Description = "REPORTE DE OTS")]
        public DataTable Impresion_OTs_v2(string V_OT, string V_COD_DIV,string V_IMPRESORA,string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            string xmlData = oPD.Impresion_OTs(V_OT, V_COD_DIV, UserName);


            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_Impresion_OT"];

            return dt;
        }
    }
}
