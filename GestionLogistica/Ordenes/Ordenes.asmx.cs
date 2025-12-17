using SIMANET_W22R.srvGestionLogistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Caching;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionLogistica.Ordenes
{
    /// <summary>
    /// Descripción breve de Ordenes
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Ordenes : System.Web.Services.WebService
    {
        DataTable dt = new DataTable();
        DataTable dt_e = new DataTable();
        [WebMethod]
        public DataTable OrdenesCompraEmitidasContraloria(string Centro_Operativo, string Procedencia, string Tipo, string Estado, string Fecha_Inicial, string Fecha_Final, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OcoEmiContral(Centro_Operativo, Procedencia, Tipo, Estado, Fecha_Inicial, Fecha_Final,
                UserName);
            dt.TableName = "SP_OcoEmiContral";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesCompraPorReposicion(string DESTINO_COMPRA, string FECHA_MOVIMIENTO_INICIO, string FECHA_MOVIMIENTO_TERMINO, string MATERIAL_FINAL,
            string MATERIAL_INICIAL, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ordcompraporrepo(DESTINO_COMPRA, FECHA_MOVIMIENTO_INICIO, FECHA_MOVIMIENTO_TERMINO, MATERIAL_FINAL, MATERIAL_INICIAL, UserName);
            dt.TableName = "SP_OrdCompraPorRepo";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesServicioLondon(string Fecha_Emision_Inicio, string Fecha_Emision_Termino,
            string Procedencia, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OrdServicioLond(Fecha_Emision_Inicio, Fecha_Emision_Termino, Procedencia, UserName);
            dt.TableName = "SP_OrdServicioLond";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesCompraPeriodoVFechaEntrega(string Centro_Operativo, string Procedencia, string Fecha_Inicio, string Fecha_Termino,
            string Clase_Material, string UserName)
        {
            try
            {
                logisticaSoapClient oLg = new logisticaSoapClient();
                dt = oLg.Listar_OrdenComP_VFechaEntre(Centro_Operativo, Procedencia, Fecha_Inicio, Fecha_Termino, Clase_Material, UserName);
                if (dt == null)
                    throw new Exception("No se devolvieron resultados.");

                dt.TableName = "SP_OrdenComP_VFechaEntre";

                return dt;
            }
            catch (Exception ex)
            {
                //  Siempre devuelve un DataTable válido con el mensaje de error
                DataTable errorTable = new DataTable("SP_OrdenComP_VFechaEntre");
                errorTable.Columns.Add("COD_MAT", typeof(bool));
                errorTable.Columns.Add("DESCRIPCION_MATERIAL", typeof(string));
                errorTable.Rows.Add(false, ex.Message);
                return errorTable;
            }
        }

        [WebMethod]
        public DataTable ModificacionFEntregaOcoOse(string Centro_Operativo, string Tipo_Orden, string Procedencia, string Numero_Orden, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ModiFEntreOcoOse(Centro_Operativo, Tipo_Orden, Procedencia, Numero_Orden, UserName);
            dt.TableName = "SP_ModiFEntreOcoOse";

            return dt;
        }

        [WebMethod]
        public DataTable OcoEmiLogistica(string Centro_Operativo, string Procedencia, string Tipo, string Estado, string Fecha_Emision_Inicial,
            string Fecha_Emision_Final, string Cotizador, string UserName)
        {


            DataTable dtError = new DataTable("SP_OcoEmiLogi");
            logisticaSoapClient oLg = new logisticaSoapClient();
            dtError.TableName = "SP_OcoEmiLogi";
            dtError.Columns.Add("COD_PRV", typeof(string));
            dtError.Columns.Add("RZS", typeof(string));
            //-- validaciones de datos
            Tipo = Tipo.Replace("-1", "");
            Estado = Estado.Replace("-1", "");

            try
            {

                dt = oLg.Listar_OcoEmiLogi(Centro_Operativo, Procedencia, Tipo, Estado, Fecha_Emision_Inicial, Fecha_Emision_Final, Cotizador, UserName);
                dt.TableName = "SP_OcoEmiLogi";
                return dt;
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["RZS"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oLg != null)
                {
                    try
                    {
                        if (oLg.State != System.ServiceModel.CommunicationState.Faulted)
                            oLg.Close();
                        else
                            oLg.Abort();
                    }
                    catch
                    { oLg.Abort(); }
                }
            }

        }

        [WebMethod]
        public DataTable AVANCE_OSE_VALJDE(string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_AVANCE_OSE_VALJDE(D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "AVANCE_OSE_VALJDE";

            return dt;
        }

        [WebMethod]
        public DataTable ALMAC_OCO_VALJDE(string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ALMAC_OCO_VALJDE(D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "ALMAC_OCO_VALJDE";

            return dt;
        }

        [WebMethod]
        public DataTable AtencionesServiciosCC(string N_CEO, string V_CODCCO, string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_AtencionesServiciosCC(N_CEO, V_CODCCO, D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_AtencionesServiciosCC";

            return dt;
        }

        [WebMethod]
        public DataTable REQUERIMIENTO_OCO_VALJDE(string Fecha_Emision, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_REQUERIMIENTO_OCO_VALJDE(Fecha_Emision, UserName);
            dt.TableName = "SP_REQUERIMIENTO_OCO_VALJDE";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesCompraOGC(string Centro_Operativo, string Procedencia, string año_de_Orden, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OCO_OGC(Centro_Operativo, Procedencia, año_de_Orden, UserName);
            dt.TableName = "SP_OCO_OGC";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesServicioOGC(string Centro_Operativo, string año_de_Orden, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OSE_OGC(Centro_Operativo, año_de_Orden, UserName);
            dt.TableName = "SP_OSE_OGC";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesServicioOtsxDiv(string V_Centro_Operativo, string V_división, string D_Fecha_Emision_OSE_Inicio,
            string D_Fecha_Emision_OSE_Termino, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_LOG_OSE_OTS_RN(V_Centro_Operativo, V_división, D_Fecha_Emision_OSE_Inicio, D_Fecha_Emision_OSE_Termino, UserName);
            dt.TableName = "SP_LOG_OSE_OTS_RN";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesServicioCC(string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OrdenesServicioCC(D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_OrdenesServicioCC";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesCompraCC(string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OrdenesCompraCC(D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_OrdenesCompraCC";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesComSerOtContraloria(string Centro_Operativo, string DIVISION, string ORDEN_DE_TRABAJO, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ORDENCOM_SER_OT_CONTRALORIA(Centro_Operativo, DIVISION, ORDEN_DE_TRABAJO, UserName);
            dt.TableName = "SP_ORDENCOM_SER_OT_CONTRALORIA";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesEntregaFacPrv(string FECHA_INICIAL, string FECHA_FINAL, string TIPO_DE_ORDEN, string PROCEDENCIA, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Ordenes_Entrega_FacPrv(FECHA_INICIAL, FECHA_FINAL, TIPO_DE_ORDEN, PROCEDENCIA, UserName);
            dt.TableName = "SP_Ordenes_Entrega_FacPrv";

            return dt;
        }

        [WebMethod]
        public DataTable EgresoDirectoOCO(string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Egresos_Directos_OCO(D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_Egresos_Directos_OCO";

            return dt;
        }

        [WebMethod]
        public DataTable OrdenesComSerOt(string Centro_Operativo, string DIVISION, string ORDEN_DE_TRABAJO, string UserName)
        {
            DataTable dtError = new DataTable("SP_ORDENES_COM_SER_OT");
            logisticaSoapClient oLg = new logisticaSoapClient();
            dtError.TableName = "SP_ORDENES_COM_SER_OT";
            dtError.Columns.Add("COD_PRV", typeof(string));
            dtError.Columns.Add("NOMBRE_RAZON_SOCIAL", typeof(string));
            try
            {

                dt = oLg.Listar_ORDENES_COM_SER_OT(Centro_Operativo, DIVISION, ORDEN_DE_TRABAJO, UserName);
                dt.TableName = "SP_ORDENES_COM_SER_OT";

                return dt;
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["NOMBRE_RAZON_SOCIAL"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oLg != null)
                {
                    try
                    {
                        if (oLg.State != System.ServiceModel.CommunicationState.Faulted)
                            oLg.Close();
                        else
                            oLg.Abort();
                    }
                    catch
                    { oLg.Abort(); }
                }
            }
        }

        [WebMethod]
        public DataTable DiferenciaCambiarioOrdSrv(string Centro_Operativo, string división, string Proyecto, string UserName)
        {
            DataTable dtError = new DataTable("SP_DIF_CMB_PRY_OSE");

            dtError.TableName = "SP_DIF_CMB_PRY_OSE";
            dtError.Columns.Add("Centro_Operativo", typeof(string));
            dtError.Columns.Add("div_pry", typeof(string));
            dtError.Columns.Add("cod_pry", typeof(string));
            dtError.Columns.Add("des_pry", typeof(string));
            dtError.Columns.Add("fec_ems", typeof(DateTime));
            dtError.Columns.Add("ORDEN", typeof(string));


            logisticaSoapClient oLg = new logisticaSoapClient();
            try
            {
                if (Centro_Operativo == "-1")
                { Centro_Operativo = "1"; }


                //************** MANEJO DE CACHE ****************
                string cacheKey = $"{Centro_Operativo}_{división}_{Proyecto}_{UserName}";             // Combinar los filtros para crear una clave única para la caché
                MemoryCache cache = MemoryCache.Default;  // Obtener la instancia del MemoryCache
                if (cache.Contains(cacheKey))              // Verificar si ya existe el resultado en caché
                {
                    //  object cachedObj = cache.Get(cacheKey);
                    //  DataTable dt2 = cachedObj as DataTable;

                    return cache.Get(cacheKey) as DataTable;  // Retornar el DataTable almacenado en caché
                }
                //***********************

                // -----validamos datos Obligatorios ----
                if (Centro_Operativo == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["div_pry"] = "A";
                    row["cod_pry"] = "Error";
                    row["des_pry"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (Proyecto == "-1" || Proyecto == "")
                {
                    DataRow row = dtError.NewRow();
                    row["div_pry"] = "B";
                    row["cod_pry"] = "Error";
                    row["des_pry"] = "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (división == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["div_pry"] = "C";
                    row["cod_pry"] = "Error";
                    row["des_pry"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }


                // Si no está en caché, llamar al servicio para obtener los datos
                string xmlData = oLg.Listar_DIF_CMB_PRY_OSE2(Centro_Operativo, división, Proyecto, UserName);  //Listar_DIF_CMB_PRY_OSE

                DataSet ds = new DataSet(); // Crear un DataSet y cargar el XML
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }
                DataTable dt = ds.Tables["SP_DIF_CMB_PRY_OSE"];             // Extraer el DataTable del DataSet



                // *********  VALIDACION DE DATOS ****************
                if (dt != null)   // si trajo data, Copiar la estructura del DataTable recibido (columnas y tipos)
                {
                    dt_e = dt.Clone();  // `Clone` copia la estructura sin los datos
                }
                else // SI NO TRAJO ESTRUCTURA, ENVIO DATOS VALIDOS PARA TRAER ESTRUCTURA
                {
                    /*
                dt = oLg.Listar_DIF_CMB_PRY_OSE("1", "RN", "CN-1195-SC", UserName);
                if (dt != null)                                                             // Copiar la estructura del DataTable recibido (columnas y tipos)
                {
                    dt_e = dt.Clone();  // `Clone` copia la estructura sin los datos
                }
                    */
                    DataRow row = dtError.NewRow();
                    row["des_pry"] = "No existen registros para los parámetros consultados: " + Proyecto + " " + división + " " + Centro_Operativo;
                    dtError.Rows.Add(row);
                    return dtError;

                }


                if (dt.Rows.Count == 0) // no hubo resultados por enviar parametros solo para traer estructura
                {

                    /*
                //************* MANEJO DE CACHE *****************
                // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                CacheItemPolicy policy = new CacheItemPolicy
                {
                    AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(5) // Expira en 5 minutos
                };
                // Almacenar el resultado en caché "SOLO" si los registros son mayores a 50
                if (dt_e != null)
                {
                    if (dt_e.Rows.Count == 0)
                    {
                        DataRow errorRow = dt_e.NewRow(); // Crear una nueva fila
                        errorRow["Centro_Operativo"] = "1";
                        errorRow["div_pry"] = "C";
                        errorRow["cod_pry"] = "VACIO";
                        errorRow["des_pry"] = "NO SE ENCONTRARON DATOS";  // Descripción del error
                        dt_e.Rows.Add(errorRow);  // Agregar la fila al DataTable
                    }
                  cache.Add(cacheKey, dt_e, policy); 
                }
                //***************************************
                return dt_e;
                    */
                    DataRow row = dtError.NewRow();

                    row["Centro_Operativo"] = Centro_Operativo;
                    row["div_pry"] = "C";
                    row["cod_pry"] = "Error";
                    row["des_pry"] = "No existen registros para los parámetros consultados: " + Proyecto + " " + división + " " + Centro_Operativo;
                    row["MNT_DOC_PAG"] = "0";
                    row["TC_EMS_DOC_PAG"] = "0";
                    row["TC_CAN_DOC_PAG"] = "0";
                    row["MONTO_REAL_PAGADO_SOLES"] = "0";
                    row["TOT_NET_ORD"] = "0";
                    row["ORDEN"] = Proyecto;

                    dtError.Rows.Add(row);
                    return dtError;


                }
                else
                {
                    //************* MANEJO DE CACHE *****************
                    // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                    CacheItemPolicy policy = new CacheItemPolicy
                    {
                        AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(5) // Expira en 5 minutos
                    };
                    // Almacenar el resultado en caché "SOLO" si los registros son mayores a 50
                    if (dt_e != null)
                    {
                        cache.Add(cacheKey, dt, policy);
                    }
                    //***************************************
                    return dt;
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
                if (oLg != null)
                {
                    try
                    {
                        if (oLg.State != System.ServiceModel.CommunicationState.Faulted)
                            oLg.Close();
                        else
                            oLg.Abort();
                    }
                    catch
                    { oLg.Abort(); }
                }
            }

        }


        [WebMethod]
        public DataTable DiferenciaCambiarioOrdSrv2(string Centro_Operativo, string división, string Proyecto, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_DIF_CMB_PRY_OSE(Centro_Operativo, división, Proyecto, UserName);
            dt.TableName = "SP_DIF_CMB_PRY_OSE";

            // *********  VALIDACION DE DATOS ****************
            if (dt != null)   // si trajo data, Copiar la estructura del DataTable recibido (columnas y tipos)
            {
                dt_e = dt.Clone();  // `Clone` copia la estructura sin los datos
            }
            else // SI NO TRAJO ESTRUCTURA, ENVIO DATOS VALIDOS PARA TRAER ESTRUCTURA
            {
                dt = oLg.Listar_DIF_CMB_PRY_OSE("1", "RN", "CN-1195-SC", UserName);
                if (dt != null)                                                             // Copiar la estructura del DataTable recibido (columnas y tipos)
                {
                    dt_e = dt.Clone();  // `Clone` copia la estructura sin los datos
                }
            }


            if (dt.Rows.Count == 0) // no hubo resultados por enviar parametros solo para traer estructura
            {
                //**********COLOCAMOS AQUI REGLAS DE VALIDACIÓN

                // Validar parámetros obligatorio (1)
                if (string.IsNullOrEmpty(Centro_Operativo) || Centro_Operativo == "-1")
                {
                    DataRow errorRow = dt_e.NewRow(); // Crear una nueva fila
                    errorRow["Centro_Operativo"] = "1";
                    errorRow["div_pry"] = "A";
                    errorRow["cod_pry"] = "Error";
                    errorRow["des_pry"] = "El parámetro 'Centro_Operativo' es obligatorio. Debe ingresar o seleccionar ese dato";  // Descripción del error
                    dt_e.Rows.Add(errorRow);  // Agregar la fila al DataTable

                }
                // Validar parámetros obligatorio (2)
                if (string.IsNullOrEmpty(división) || división == "-1")
                {
                    DataRow errorRow = dt_e.NewRow(); // Crear una nueva fila
                    errorRow["Centro_Operativo"] = "1";
                    errorRow["div_pry"] = "B";
                    errorRow["cod_pry"] = "Error";
                    errorRow["des_pry"] = "El parámetro 'División' es obligatorio. Debe ingresar o seleccionar ese dato";  // Descripción del error
                    dt_e.Rows.Add(errorRow);  // Agregar la fila al DataTable
                }
                // Validar parámetros obligatorio (3)
                if (string.IsNullOrEmpty(Proyecto) || Proyecto == "-1")
                {
                    DataRow errorRow = dt_e.NewRow(); // Crear una nueva fila
                    errorRow["Centro_Operativo"] = "1";
                    errorRow["div_pry"] = "C";
                    errorRow["cod_pry"] = "Error";
                    errorRow["des_pry"] = "El parámetro 'Proyecto' es obligatorio. Debe ingresar o seleccionar ese dato";  // Descripción del error
                    dt_e.Rows.Add(errorRow);  // Agregar la fila al DataTable

                }
                return dt_e;
            }
            else
            {
                return dt;
            }
        }

        [WebMethod]
        public DataTable DiferenciaCambiarioOrdSrvTotal(string Centro_Operativo, string división, string Proyecto, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_DIF_CMB_PRY_OSE_MNT_AVA(Centro_Operativo, división, Proyecto, UserName);
            dt.TableName = "SP_DIF_CMB_PRY_OSE_MNT_AVA";

            return dt;
        }

        [WebMethod]
        public DataTable DiferenciaCambiarioOrdenesCompra_v2(string Centro_Operativo, string división, string Proyecto, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_DIF_CMB_PRY_OCO(Centro_Operativo, división, Proyecto, UserName);
            dt.TableName = "SP_DIF_CMB_PRY_OCO";

            return dt;
        }

        //------ metodo con cadena xml -----------------
        [WebMethod]
        public DataTable DiferenciaCambiarioOrdenesCompra(string Centro_Operativo, string división, string Proyecto, string UserName)
        {

            DataTable dtError = new DataTable("SP_DIF_CMB_PRY_OCO");

            dtError.TableName = "SP_DIF_CMB_PRY_OCO";
            dtError.Columns.Add("Centro_Operativo", typeof(string));
            dtError.Columns.Add("div_pry", typeof(string));
            dtError.Columns.Add("cod_pry", typeof(string));
            dtError.Columns.Add("des_pry", typeof(string));
            dtError.Columns.Add("MNT_DOC_PAG", typeof(string));
            dtError.Columns.Add("TC_EMS_DOC_PAG", typeof(string));
            dtError.Columns.Add("TC_CAN_DOC_PAG", typeof(string));
            dtError.Columns.Add("MONTO_REAL_PAGADO_SOLES", typeof(string));
            dtError.Columns.Add("TOT_NET_ORD", typeof(string));
            dtError.Columns.Add("ORDEN", typeof(string));


            logisticaSoapClient oLg = new logisticaSoapClient();

            try
            {


                //****************************************


                // -----validamos datos Obligatorios ----
                if (Centro_Operativo == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["div_pry"] = "A";
                    row["cod_pry"] = "Error";
                    row["des_pry"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (Proyecto == "-1" || Proyecto == "")
                {
                    DataRow row = dtError.NewRow();
                    row["div_pry"] = "B";
                    row["cod_pry"] = "Error";
                    row["des_pry"] = "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (división == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["div_pry"] = "C";
                    row["cod_pry"] = "Error";
                    row["des_pry"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                string xmlData = oLg.Listar_DIF_CMB_PRY_OCO2(Centro_Operativo, división, Proyecto, UserName);  //Listar_DIF_CMB_PRY_OCO_V2

                DataSet ds = new DataSet(); // Crear un DataSet y cargar el XML
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }
                DataTable dt = ds.Tables["SP_DIF_CMB_PRY_OCO"];             // Extraer el DataTable del DataSet

                if (dt != null)   // si trajo data, Copiar la estructura del DataTable recibido (columnas y tipos)
                {
                    dt_e = dt.Clone();  // `Clone` copia la estructura sin los datos
                }
                else // SI NO TRAJO ESTRUCTURA, ENVIO DATOS VALIDOS "SOLO" PARA TRAER ESTRUCTURA
                {
                    /*
                          dt= oLg.Listar_DIF_CMB_PRY_OCO("1", "RN", "CN-1195-SC", UserName);
                            if (dt != null)                                                             // Copiar la estructura del DataTable recibido (columnas y tipos)
                            {
                                dt_e = dt.Clone();  // `Clone` copia la estructura sin los datos
                            }
                    */

                    DataRow row = dtError.NewRow();
                    row["des_pry"] = "No existen registros para los parámetros consultados: " + Proyecto + " " + división + " " + Centro_Operativo;
                    dtError.Rows.Add(row);
                    return dtError;

                }

                if (dt.Rows.Count == 0) // no hubo resultados por enviar parametros solo para traer estructura
                {

                    DataRow row = dtError.NewRow();

                    row["Centro_Operativo"] = Centro_Operativo;
                    row["div_pry"] = "C";
                    row["cod_pry"] = "Error";
                    row["des_pry"] = "No existen registros para los parámetros consultados: " + Proyecto + " " + división + " " + Centro_Operativo;
                    row["MNT_DOC_PAG"] = "0";
                    row["TC_EMS_DOC_PAG"] = "0";
                    row["TC_CAN_DOC_PAG"] = "0";
                    row["MONTO_REAL_PAGADO_SOLES"] = "0";
                    row["TOT_NET_ORD"] = "0";
                    row["ORDEN"] = Proyecto;

                    dtError.Rows.Add(row);
                    return dtError;




                }
                else
                {
                    return dt;
                }

            }
            catch (Exception ex)
            {
                //return dt_e;
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["Detalle  :"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;

            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oLg != null)
                {
                    try
                    {
                        if (oLg.State != System.ServiceModel.CommunicationState.Faulted)
                            oLg.Close();
                        else
                            oLg.Abort();
                    }
                    catch
                    { oLg.Abort(); }
                }
            }

        }

        [WebMethod]
        public DataTable OseAvance_FacPrv(string FECHA_EMISION_INICIAL, string FECHA_EMISION_FINAL, string NMRO_OSE, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OseAvance(FECHA_EMISION_INICIAL, FECHA_EMISION_FINAL, NMRO_OSE, UserName);
            dt.TableName = "SP_OseAvance";

            return dt;
        }

        [WebMethod]
        public DataTable DiferenciaCambiarioOrdenesCompraSinOtR69B(string Centro_Operativo, string división, string Proyecto, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_DIF_CMB_PRY_OCO_PCI(Centro_Operativo, división, Proyecto, UserName);
            dt.TableName = "SP_DIF_CMB_PRY_OCO_PCI";

            return dt;
        }

        [WebMethod]
        public DataTable DiferenciaCambiarioOrdenesCompraSinOt(string Centro_Operativo, string división, string Proyecto, string NroOrden, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_DIF_CMB_PRY_OCO_SIN_OT(Centro_Operativo, división, Proyecto, NroOrden, UserName);
            dt.TableName = "SP_DIF_CMB_PRY_OCO_SIN_OT";

            return dt;
        }

        [WebMethod]
        public DataTable DiferencialCambiarioEgresosDirectosSinOt(string Centro_Operativo, string división, string Proyecto, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_DIF_CMB_PRY_EGR_DIR_SIN_OT(Centro_Operativo, división, Proyecto, UserName);
            dt.TableName = "SP_DIF_CMB_PRY_EGR_DIR_SIN_OT";

            return dt;
        }

        [WebMethod]
        public DataTable DiferencialCambiarioEgresosDirectos(string Centro_Operativo, string división, string Proyecto, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_DIF_CMB_PRY_EGR_DIR(Centro_Operativo, división, Proyecto, UserName);
            dt.TableName = "SP_DIF_CMB_PRY_EGR_DIR";

            return dt;
        }
        //---------------------------------
        [WebMethod(Description = "ALMACENAMIENTO DE ORDENES DE COMPRA POR PERIODO")]
        public DataTable ALM_OCO_ATE_RSV(string D_INICIO_ALMACENAMIENTO, string D_FINAL_ALMACENAMIENTO, string V_DESTINO_COMPRA,
            string V_Filtro_PRY_AUS, string V_PRY_AUS, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ALM_OCO_ATE_RSV(D_INICIO_ALMACENAMIENTO, D_FINAL_ALMACENAMIENTO, V_DESTINO_COMPRA, V_Filtro_PRY_AUS, V_PRY_AUS, UserName);
            dt.TableName = "SP_ALM_OCO_ATE_RSV";

            return dt;
        }

        //------ metodo con cadena xml -----------------
        [WebMethod(Description = "ALMACENAMIENTO DE ORDENES DE COMPRA POR PERIODO vers.2")]
        public DataTable ALM_OCO_ATE_RSV2(string D_INICIO_ALMACENAMIENTO, string D_FINAL_ALMACENAMIENTO, string V_DESTINO_COMPRA,
           string V_Filtro_PRY_AUS, string V_PRY_AUS, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            string xmlData = oLg.Listar_ALM_OCO_ATE_RSV2(D_INICIO_ALMACENAMIENTO, D_FINAL_ALMACENAMIENTO, V_DESTINO_COMPRA, V_Filtro_PRY_AUS, V_PRY_AUS, UserName);


            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_ALM_OCO_ATE_RSV"];

            return dt;
        }

        //--------------------
        [WebMethod]
        public DataTable Listar_emb_det_v1(string V_ORCOMPRA, string V_EMBARQUE, string V_DIFERENCIA, string V_CODMAT, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            // dt = oLg.Listar_emb_det_v1(V_ORCOMPRA,V_EMBARQUE,V_DIFERENCIA,V_CODMAT,UserName);
            // dt.TableName = "SP_EMB_DET_V1";
            DataTable dtError = new DataTable("SP_EMB_DET_V1");
            DateTime fechaIni, fechaFin;
            dtError.TableName = "SP_EMB_DET_V1";
            dtError.Columns.Add("NRO_EMB", typeof(string));
            dtError.Columns.Add("OBS", typeof(string)); // el campo se toma de reporte crystal
            try
            {
                // -----validamos datos Obligatorios ----
                if (V_ORCOMPRA == " ")
                {
                    DataRow row = dtError.NewRow();
                    row["OBS"] = "Ingrese el Nro de Orden de Compra, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_EMBARQUE == "-1" || V_EMBARQUE == "")
                {
                    DataRow row = dtError.NewRow();
                    row["OBS"] = "Seleccione el tipo de Embarque para al OC, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_DIFERENCIA == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["OBS"] = "Seleccione Si hay diferencia entre cantidad comprada y solicitada, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                // ----------------------------------------------------
                dt = oLg.Listar_emb_det_v1(V_ORCOMPRA, V_EMBARQUE, V_DIFERENCIA, V_CODMAT, UserName);

                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_EMB_DET_V1";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_EMB_DET_V1";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["OBS"] = "No existen registros para los parámetros consultados: " + V_ORCOMPRA + " " + V_EMBARQUE + V_CODMAT + " " + V_DIFERENCIA;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["OBS"] = "No existen registros para los parámetros consultados: " + V_ORCOMPRA + " " + V_EMBARQUE + V_CODMAT + " " + V_DIFERENCIA;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["OBS"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oLg != null)
                {
                    try
                    {
                        if (oLg.State != System.ServiceModel.CommunicationState.Faulted)
                            oLg.Close();
                        else
                            oLg.Abort();
                    }
                    catch
                    { oLg.Abort(); }
                }
            }

        }

        [WebMethod]
        public DataTable Listar_OrdenCompraTPaqv1(string ORDEN_COMPRA, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OrdenCompraTPaqv1(ORDEN_COMPRA, UserName);
            dt.TableName = "SP_OrdenCompraTPaqv1";

            return dt;
        }
        [WebMethod]
        public DataTable Listar_Emb_det_mov_v1(string N_CEO, string V_ORCOMPRA, string V_EMBARQUE, string V_CODMAT, string UserName)
        {

            logisticaSoapClient oLg = new logisticaSoapClient();
            // Llamar al método y obtener el XML como string
            string xmlData = oLg.Listar_Emb_det_mov_v1(N_CEO, V_ORCOMPRA, V_EMBARQUE, V_CODMAT, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_EMB_DET_MOV_V1"];
            return dt;
            /*
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Emb_det_mov_v1(N_CEO,V_ORCOMPRA,V_EMBARQUE,V_CODMAT,UserName);
            dt.TableName = "SP_EMB_DET_MOV_V1";
            return dt;*/
        }
        [WebMethod]
        public DataTable Lista_OT_RELACIONADAS_OCO(string V_CEO, string V_Nro_Orden, string V_Procedencia, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Lista_OT_RELACIONADAS_OCO(V_CEO, V_Nro_Orden, V_Procedencia, UserName);
            dt.TableName = "SP_OT_RELACIONADAS_OCO";

            return dt;
        }
    }
}
