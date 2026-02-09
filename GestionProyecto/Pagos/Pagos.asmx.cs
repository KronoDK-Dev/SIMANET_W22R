using DocumentFormat.OpenXml.Presentation;
using SIMANET_W22R.srvGestionProyecto;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Caching;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProyecto.Pagos
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
        public DataTable Listar_resumen_ose_partida(string N_CEO, string V_CODDIV, string V_CODPRY, string V_PERIODO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_resumen_ose_partida(N_CEO,V_CODDIV,V_CODPRY,V_PERIODO,UserName);
            dt.TableName = "SP_Resumen_Ose_Partida";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_det_gto_mat_pry_ot_partid(string N_CEO, string V_CODDIV, string V_CODPRY, string V_PERIODO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_det_gto_mat_pry_ot_partid( N_CEO,V_CODDIV,V_CODPRY, V_PERIODO, UserName );
            dt.TableName = "SP_DET_GTO_MAT_PRY_OT_PARTIDA";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_det_gast_pry_ot_oco_ate_acu(string D_AÑO, string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            // ESTE REPORTE DEMORA, ENTONCES PARA EVITAR VOLVER A CARGAR EN CADA MOMENTO GUARDAREMOS LA DATA TEMPORTAL POR 10 MIN ---

            //**************************************************************************************************************************************
            // PRODEMOS USAR CACHE DE DATOS  DADO QUE LOS PARAMETROS DEL PROYECTO SON  POCOS Y SI REGULARIZA UNA RENDICION LE DAMOS PLAZO 20 MIN
            //**************************************************************************************************************************************


            string cacheKey = $"{D_AÑO}_{V_CENTRO_OPERATIVO}_{V_DIVISION}_{V_PROYECTO}_{UserName}";  // Combinar los filtros para crear una clave única para la caché: COLOCAMOS LOS PARAMETROS DEL METODO
            MemoryCache cache = MemoryCache.Default;                          // Obtener la instancia del MemoryCache
            if (cache.Contains(cacheKey))                                    // Verificar si ya existe el resultado en caché
            {
                return cache.Get(cacheKey) as DataTable;  // Retornar el DataTable almacenado en caché
            }


            // Si no está en caché, llamar al servicio para obtener los datos   
            //---------------------------------------------                
            // Llamar al método y obtener el XML como string
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_det_gast_pry_ot_oco_ate_acu(D_AÑO, V_CENTRO_OPERATIVO, V_DIVISION, V_PROYECTO, UserName);
            dt.TableName = "SP_DET_GAST_PRY_OT_OCO_ATE_ACU";
            //-------------------------------------------

            //***********************************************
            //  CONTINUAMOS CON LA CONFIGURACION DE LA CACHE
            //***********************************************
            CacheItemPolicy policy = new CacheItemPolicy  // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(20) // Expira en 20 minutos
            };
            return dt;
        }

        [WebMethod]
        public DataTable Listar_gastos_proyectos_ot_v3(string N_CEO, string V_CODDIV, string V_CODPRY, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            DataTable dtError = new DataTable("SP_Gastos_Proyectos_OT_v3");
            // Configura estructura tabla de error // Los campos se toman de las etiquetas de reporte crystal
            // Gastos_Proyectos_por_OT_v3.rep 
            dtError.TableName = "SP_Gastos_Proyectos_OT_v3";
            dtError.Columns.Add("GRUPO_CC", typeof(string));
            dtError.Columns.Add("CENTRO_COSTO", typeof(string));
            try
            {

                // -----validamos datos Obligatorios ----
                if (N_CEO == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["CENTRO_COSTO"] = "Seleccione el Centro Operativo, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODPRY == "-1" || V_CODPRY == "")
                {
                    DataRow row = dtError.NewRow();
                    row["CENTRO_COSTO"] = "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }
                if (V_CODDIV == "-1")
                {
                    DataRow row = dtError.NewRow();
                    row["CENTRO_COSTO"] = "Seleccione la Linea de Negocio, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }


                dt = oPy.Listar_gastos_proyectos_ot_v3(N_CEO, V_CODDIV, V_CODPRY, UserName);
               
                if (dt != null)  // valida vacio
                {
                    dt.TableName = "SP_Gastos_Proyectos_OT_v3";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "SP_Gastos_Proyectos_OT_v3";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["CENTRO_COSTO"] = "No existen registros para los parámetros consultados: " + V_CODPRY + " " + V_CODDIV  + " " + N_CEO;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["CENTRO_COSTO"] = "No existen registros para los parámetros consultados: " + V_CODPRY + " " + V_CODDIV  + " " + N_CEO;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["CENTRO_COSTO"] = "Error en servicio: " + ex.Message;
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
        public DataTable Listar_CartaFianzas(string v_ANIOCARTA, string V_CODPROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_CartaFianzas(v_ANIOCARTA, V_CODPROYECTO, UserName);
            dt.TableName = "SP_LISTA_CARTAFIANZAS";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_ViaticosProyectos(string v_ANIOCARTA, string V_CODPROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_ViaticosProyectos(v_ANIOCARTA, V_CODPROYECTO, UserName);
            dt.TableName = "SP_LISTA_VIATICOSPROYECTOS";
            return dt;
        }
        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }
    }
}
