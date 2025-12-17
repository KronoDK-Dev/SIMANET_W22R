using DocumentFormat.OpenXml.Presentation;
using SIMANET_W22R.srvGestionComercial;
using SIMANET_W22R.srvGestionProduccion;
using SIMANET_W22R.srvGestionProyecto;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Caching;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using static EasyControlWeb.EasyUtilitario.Enumerados.MessageBox;


namespace SIMANET_W22R.GestionProyecto.FlujoCaja
{
    /// <summary>
    /// Descripción breve de FlujoCaja
    ///   /GestionProyecto/FlujoCaja/FlujoCaja.asmx
    ///   
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class FlujoCaja : System.Web.Services.WebService
    {
        string sAmbiente = ConfigurationManager.AppSettings["Ambiente"];

        DataTable dtResultados;
        DataTable dtError = new DataTable();


        [WebMethod]
        public DataTable Listar_Rendicion_Recibo_Caja_xProyecto(string v_CEO, string v_ANIO, string V_CODPROYECTO, string v_TIPO, string UserName)
        {
            return (new ProyectoSoapClient()).Listar_Rendicion_Recibo_Caja_xProyecto(v_CEO, v_ANIO, V_CODPROYECTO, v_TIPO, UserName); 
        }
        
        [WebMethod]
        public DataTable Listar_Rendicion_Recibo_Caja_xProyecto2(string v_CEO, string v_ANIO, string V_CODPROYECTO,  string UserName)
        {
            try
            {
                //**************************************************************************************************************************************
                // PRODEMOS USAR CACHE DE DATOS  DADO QUE LOS PARAMETROS DEL PROYECTO SON  POCOS Y SI REGULARIZA UNA RENDICION LE DAMOS PLAZO 20 MIN
                //**************************************************************************************************************************************

                
                string cacheKey = $"{v_CEO}_{v_ANIO}_{V_CODPROYECTO}_{UserName}";  // Combinar los filtros para crear una clave única para la caché: COLOCAMOS LOS PARAMETROS DEL METODO
                MemoryCache cache = MemoryCache.Default;                          // Obtener la instancia del MemoryCache
                if (cache.Contains(cacheKey))                                    // Verificar si ya existe el resultado en caché
                {
                    return cache.Get(cacheKey) as DataTable;  // Retornar el DataTable almacenado en caché
                }


                // Si no está en caché, llamar al servicio para obtener los datos   
                 //---------------------------------------------                
                // Llamar al método y obtener el XML como string
                String xmlData = (new ProyectoSoapClient()).Listar_Rendicion_Recibo_Caja_xProyecto2(v_CEO, v_ANIO, V_CODPROYECTO, "1", UserName);
                DataSet ds = new DataSet();  // Crear un DataSet y cargar el XML
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }
                dtResultados = ds.Tables["SP_RENDICION_RECIBO_CAJA_xPRY"];  // Extraer el DataTable del DataSet
               //-------------------------------------------

                //  CONTINUAMOS CON LA CONFIGURACION DE LA CACHE

                CacheItemPolicy policy = new CacheItemPolicy  // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                {
                    AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(20) // Expira en 20 minutos
                };
                
                return dtResultados;

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                throw new SoapException("Error al obtener datos: " + ex.Message, SoapException.ServerFaultCode);
       //         throw new HttpException(500, "Error interno del servidor", ex);

            }
        }


        [WebMethod]
        public DataTable Listar_OT_Costos_estimados_xProyecto(string v_CEO, string V_CODPROYECTO, string UserName)
        {
            return (new ProyectoSoapClient()).Listar_OT_Costos_estimados_xProyecto(v_CEO,  V_CODPROYECTO,  UserName);
        }

        [WebMethod]
        public DataTable Listar_OT_Costos_estimados_xProyecto2(string v_CEO, string V_CODPROYECTO, string UserName)
        {
            try
            {
                //**************************************************************************************************************************************
            
                //---------------------------------------------                
                // Llamar al método y obtener el XML como string
                String xmlData = (new ProyectoSoapClient()).Listar_OT_Costos_estimados_xProyecto2(v_CEO,  V_CODPROYECTO,  UserName);
                DataSet ds = new DataSet();  // Crear un DataSet y cargar el XML
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }
                dtResultados = ds.Tables["SP_COSTOS_OT_ESTIMADOS"];  // Extraer el DataTable del DataSet
                                                                            //-------------------------------------------

              
                return dtResultados;

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                //throw new SoapException("Error al obtener datos: " + ex.Message, SoapException.ServerFaultCode);
                //         throw new HttpException(500, "Error interno del servidor", ex);

                // Los nombre de columna debe ser los mismo del reporte diseñado
                dtError.TableName = "SP_COSTOS_OT_ESTIMADOS";
                dtError.Columns.Add("N_CSTPROY_OT", typeof(decimal));
                dtError.Rows.Add(0m);
                dtError.Columns.Add("V_CSTPROY_DESCRIPCION", typeof(string));
                dtError.Rows.Add(ex.Message);
                dtError.Columns.Add("V_CSTPROY_ACTIVIDAD", typeof(string));
                dtError.Rows.Add("ERROR");
                dtError.Columns.Add("V_CSTPROY_DESCRIPCION_A", typeof(string));
                dtError.Rows.Add("ERROR");
                dtError.Columns.Add("V_CSTPROY_RECURSO", typeof(string));
                dtError.Rows.Add("");
                dtError.Columns.Add("N_CSTPROY_MONTO_EJECUTADO", typeof(decimal));
                dtError.Rows.Add(0m);
                dtError.Columns.Add("N_CSTPROY_MONTO_PROYECTADO", typeof(decimal));
                dtError.Rows.Add(0m);
                dtError.Columns.Add("N_CSTPROY_MONTO_SIN_IGV", typeof(decimal));
                dtError.Rows.Add(0m);
                dtError.Columns.Add("COSTO_TOTAL_SIN_IGV", typeof(decimal));
                dtError.Rows.Add(0m);
                return dtError;

                

            }
        }

        [WebMethod]
        public DataTable Listar_Viaticos_Rendidos(string v_CEO, string V_CODPROYECTO, string UserName)
        {
            // ESTE REPORTE DEMORA, ENTONCES PARA EVITAR VOLVER A CARGAR EN CADA MOMENTO GUARDAREMOS LA DATA TEMPORTAL POR 10 MIN ---

            //**************************************************************************************************************************************
            // PRODEMOS USAR CACHE DE DATOS  DADO QUE LOS PARAMETROS DEL PROYECTO SON  POCOS Y SI REGULARIZA UNA RENDICION LE DAMOS PLAZO 20 MIN
            //**************************************************************************************************************************************


            string cacheKey = $"{v_CEO}_{V_CODPROYECTO}_{UserName}";  // Combinar los filtros para crear una clave única para la caché: COLOCAMOS LOS PARAMETROS DEL METODO
            MemoryCache cache = MemoryCache.Default;                          // Obtener la instancia del MemoryCache
            if (cache.Contains(cacheKey))                                    // Verificar si ya existe el resultado en caché
            {
                return cache.Get(cacheKey) as DataTable;  // Retornar el DataTable almacenado en caché
            }


            // Si no está en caché, llamar al servicio para obtener los datos   
            //---------------------------------------------                
            // Llamar al método y obtener el XML como string
            dtResultados = (new ProyectoSoapClient()).Listar_Viaticos_Rendidos(v_CEO, V_CODPROYECTO, UserName);
            dtResultados.TableName = "SP_VIATICOS_RENDIDOS";
            //-------------------------------------------

            //***********************************************
            //  CONTINUAMOS CON LA CONFIGURACION DE LA CACHE
            //***********************************************
            CacheItemPolicy policy = new CacheItemPolicy  // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(20) // Expira en 20 minutos
            };

       
            return dtResultados;
        }


        [WebMethod]
        public DataTable Listar_Cartas_Fianzas(string v_CEO, string V_CODPROYECTO, string UserName)
        {
            // ESTE REPORTE DEMORA, ENTONCES PARA EVITAR VOLVER A CARGAR EN CADA MOMENTO GUARDAREMOS LA DATA TEMPORTAL POR 10 MIN ---

            //**************************************************************************************************************************************
            // PRODEMOS USAR CACHE DE DATOS  DADO QUE LOS PARAMETROS DEL PROYECTO SON  POCOS Y SI REGULARIZA UNA RENDICION LE DAMOS PLAZO 20 MIN
            //**************************************************************************************************************************************


            string cacheKey = $"{v_CEO}_{V_CODPROYECTO}_{UserName}";  // Combinar los filtros para crear una clave única para la caché: COLOCAMOS LOS PARAMETROS DEL METODO
            MemoryCache cache = MemoryCache.Default;                          // Obtener la instancia del MemoryCache
            if (cache.Contains(cacheKey))                                    // Verificar si ya existe el resultado en caché
            {
                return cache.Get(cacheKey) as DataTable;  // Retornar el DataTable almacenado en caché
            }


            // Si no está en caché, llamar al servicio para obtener los datos   
            //---------------------------------------------                
            // Llamar al método y obtener el XML como string
            dtResultados = (new ProyectoSoapClient()).Listar_Cartas_Fianzas(v_CEO, V_CODPROYECTO, UserName);
            dtResultados.TableName = "SP_CARTAS_FIANZAS";
            //-------------------------------------------

            //***********************************************
            //  CONTINUAMOS CON LA CONFIGURACION DE LA CACHE
            //***********************************************
            CacheItemPolicy policy = new CacheItemPolicy  // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(20) // Expira en 20 minutos
            };


            return dtResultados;
        }

        [WebMethod]
        public DataTable Listar_Aportes_Sencico(string v_CEO, string V_CODPROYECTO, string UserName)
        {
            // ESTE REPORTE DEMORA, ENTONCES PARA EVITAR VOLVER A CARGAR EN CADA MOMENTO GUARDAREMOS LA DATA TEMPORTAL POR 10 MIN ---

            //**************************************************************************************************************************************
            // PRODEMOS USAR CACHE DE DATOS  DADO QUE LOS PARAMETROS DEL PROYECTO SON  POCOS Y SI REGULARIZA UNA RENDICION LE DAMOS PLAZO 20 MIN
            //**************************************************************************************************************************************


            string cacheKey = $"{v_CEO}_{V_CODPROYECTO}_{UserName}";  // Combinar los filtros para crear una clave única para la caché: COLOCAMOS LOS PARAMETROS DEL METODO
            MemoryCache cache = MemoryCache.Default;                          // Obtener la instancia del MemoryCache
            if (cache.Contains(cacheKey))                                    // Verificar si ya existe el resultado en caché
            {
                return cache.Get(cacheKey) as DataTable;  // Retornar el DataTable almacenado en caché
            }


            // Si no está en caché, llamar al servicio para obtener los datos   
            //---------------------------------------------                
            // Llamar al método y obtener el XML como string
            dtResultados = (new ProyectoSoapClient()).Listar_Aportes_Sencico(v_CEO, V_CODPROYECTO, UserName);
            dtResultados.TableName = "SP_APORTES_SENCICO";
            //-------------------------------------------

            //***********************************************
            //  CONTINUAMOS CON LA CONFIGURACION DE LA CACHE
            //***********************************************
            CacheItemPolicy policy = new CacheItemPolicy  // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(20) // Expira en 20 minutos
            };


            return dtResultados;
        }

        [WebMethod]
        public DataTable Listar_Ingresos_Proyecto(string v_CEO, string V_CODPROYECTO, string UserName)
        {
            // ESTE REPORTE DEMORA, ENTONCES PARA EVITAR VOLVER A CARGAR EN CADA MOMENTO GUARDAREMOS LA DATA TEMPORTAL POR 10 MIN ---

            //**************************************************************************************************************************************
            // PRODEMOS USAR CACHE DE DATOS  DADO QUE LOS PARAMETROS DEL PROYECTO SON  POCOS Y SI REGULARIZA UNA RENDICION LE DAMOS PLAZO 20 MIN
            //**************************************************************************************************************************************


            string cacheKey = $"{v_CEO}_{V_CODPROYECTO}_{UserName}";  // Combinar los filtros para crear una clave única para la caché: COLOCAMOS LOS PARAMETROS DEL METODO
            MemoryCache cache = MemoryCache.Default;                          // Obtener la instancia del MemoryCache
            if (cache.Contains(cacheKey))                                    // Verificar si ya existe el resultado en caché
            {
                return cache.Get(cacheKey) as DataTable;  // Retornar el DataTable almacenado en caché
            }


            // Si no está en caché, llamar al servicio para obtener los datos   
            //---------------------------------------------                
            // Llamar al método y obtener el XML como string
            dtResultados = (new ProyectoSoapClient()).Listar_Ingresos_Proyecto(v_CEO, V_CODPROYECTO, UserName);
            dtResultados.TableName = "SP_INGRESOS_PROYECTO";
            //-------------------------------------------

            //***********************************************
            //  CONTINUAMOS CON LA CONFIGURACION DE LA CACHE
            //***********************************************
            CacheItemPolicy policy = new CacheItemPolicy  // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(20) // Expira en 20 minutos
            };


            return dtResultados;
        }

        [WebMethod]
        public DataTable Listar_Planilla_Proyecto(string v_CEO, string V_CODPROYECTO, string V_PERIODO, string UserName)
        {
            // ESTE REPORTE DEMORA, ENTONCES PARA EVITAR VOLVER A CARGAR EN CADA MOMENTO GUARDAREMOS LA DATA TEMPORTAL POR 10 MIN ---
            dtError.TableName = "SP_PLANILLA_PROYECTO";
            dtError.Columns.Add("PR", typeof(string));
            dtError.Columns.Add("CARGO", typeof(string)); // el campo se toma de reporte crystal
            ProyectoSoapClient oPY = new ProyectoSoapClient();
            try
            {

                //**************************************************************************************************************************************
                // PRODEMOS USAR CACHE DE DATOS  DADO QUE LOS PARAMETROS DEL PROYECTO SON  POCOS Y SI REGULARIZA UNA RENDICION LE DAMOS PLAZO 20 MIN
                //**************************************************************************************************************************************
                if (V_PERIODO.Contains("/"))
                {

                    DataRow row = dtError.NewRow();
                    row["CARGO"] = "El parámetro V_PERIODO no debe contener el carácter '/'.";
                    dtError.Rows.Add(row);
                    return dtError;

                }

                string cacheKey = $"{v_CEO}_{V_CODPROYECTO}_{V_PERIODO}_{UserName}";  // Combinar los filtros para crear una clave única para la caché: COLOCAMOS LOS PARAMETROS DEL METODO
                MemoryCache cache = MemoryCache.Default;                          // Obtener la instancia del MemoryCache
                if (cache.Contains(cacheKey))                                    // Verificar si ya existe el resultado en caché
                {
                    return cache.Get(cacheKey) as DataTable;  // Retornar el DataTable almacenado en caché
                }


                // Si no está en caché, llamar al servicio para obtener los datos   
                //---------------------------------------------                
                // Llamar al método y obtener el XML como string
                dtResultados = oPY.Listar_Planilla_Proyecto(v_CEO, V_CODPROYECTO, V_PERIODO, UserName);
                dtResultados.TableName = "SP_PLANILLA_PROYECTO";
                //-------------------------------------------

                //***********************************************
                //  CONTINUAMOS CON LA CONFIGURACION DE LA CACHE
                //***********************************************
                CacheItemPolicy policy = new CacheItemPolicy  // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                {
                    AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(20) // Expira en 20 minutos
                };


                 return dtResultados;
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["CARGO"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPY != null)
                {
                    try
                    {
                        if (oPY.State != System.ServiceModel.CommunicationState.Faulted)
                            oPY.Close();
                        else
                            oPY.Abort();
                    }
                    catch
                    { oPY.Abort(); }
                }
            }
        }

    }
}
