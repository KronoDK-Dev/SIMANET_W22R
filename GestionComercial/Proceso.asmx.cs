using SIMANET_W22R.srvCliente;
using SIMANET_W22R.srvGeneral;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using SixLabors.ImageSharp;
using System.Linq;
using System.Runtime.Caching;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionComercial;
using SIMANET_W22R.srvGestionLogistica;
using SIMANET_W22R.srvGestionProyecto;
using static EasyControlWeb.EasyUtilitario.Enumerados.Configuracion.SeccionKey;

namespace SIMANET_W22R.GestionComercial
{
    /// <summary>
    /// Descripción breve de Proceso
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Proceso : System.Web.Services.WebService
    {
        readonly string sAmbiente = ConfigurationManager.AppSettings["Ambiente"];
        DataTable dt = new DataTable();
        DataTable dtResultados;
        DataTable dtError = new DataTable();

        #region Clientes

        [WebMethod]
        public DataTable BuscarCliente(string RazonSocialCliente, string UserName)
        {
            return (new ClienteSoapClient()).BuscarCliente(RazonSocialCliente, UserName);
        }

        [WebMethod]
        public string Insert_Update_ContactoCliente(string X_C_CLIE_CODCARGO,
            string X_C_CLIE_NOMBRE, string X_C_CLIE_TELEF1, string X_C_CLIE_TELEF2, string X_C_CLIE_FECHANAC,
            string X_C_CLIE_EMAIL,
            string X_C_CLIE_TIPOENVIO, string X_V_CLIENTE_ID, string X_N_CLIE_IDCONTACTO, string opcion)
        {
            return (new ClienteSoapClient()).InsertarContactoCliente(X_C_CLIE_CODCARGO, X_C_CLIE_NOMBRE,
                X_C_CLIE_TELEF1, X_C_CLIE_TELEF2, X_C_CLIE_FECHANAC, X_C_CLIE_EMAIL, X_C_CLIE_TIPOENVIO, X_V_CLIENTE_ID,
                X_N_CLIE_IDCONTACTO, opcion);
            //    return (new ClienteSoapClient()).InsertarContactoCliente("ADM", "Roberto", "123", "321","","A", "TOD", "VCLAFG", "11", "1");
        }

        [WebMethod]
        public DataTable ListarContactosDeCliente(string X_V_CLIENTE_ID)
        {
            return (new ClienteSoapClient()).ListarContactosDeCliente(X_V_CLIENTE_ID);
            //    return (new ClienteSoapClient()).InsertarContactoCliente("ADM", "Roberto", "123", "321","","A", "TOD", "VCLAFG", "11", "1");
        }

        [WebMethod]
        public DataTable ListarClientes(string N_OPCION, string V_FILTRO, string V_CEO, string V_UND_OPER,
            string UserName)
        {
            try
            {
                // Combinar los filtros para crear una clave única para la caché
                string cacheKey = $"{N_OPCION}_{V_FILTRO}_{V_CEO}_{V_UND_OPER}_{UserName}";

                // Obtener la instancia del MemoryCache
                MemoryCache cache = MemoryCache.Default;

                // Verificar si ya existe el resultado en caché
                if (cache.Contains(cacheKey))
                {
                    // Retornar el DataTable almacenado en caché
                    return cache.Get(cacheKey) as DataTable;
                }

                // Si no está en caché, llamar al servicio para obtener los datos
                dtResultados =
                    (new ClienteSoapClient()).ListarClientes(N_OPCION, V_FILTRO, V_CEO, V_UND_OPER, UserName);

                // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                CacheItemPolicy policy = new CacheItemPolicy
                {
                    AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(30) // Expira en 30 minutos
                };

                // Almacenar el resultado en caché "SOLO" si los registros son mayores a 50
                if (dtResultados != null)
                {
                    if (dtResultados.Rows.Count > 49)
                    {
                        cache.Add(cacheKey, dtResultados, policy);
                    }
                }

                // Retornar los datos obtenidos
                return dtResultados;
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }

            //    return (new ClienteSoapClient()).InsertarContactoCliente("ADM", "Roberto", "123", "321","","A", "TOD", "VCLAFG", "11", "1");
        }

        [WebMethod]
        public DataTable BusquedaEmbarcacion(string V_NOMBRE, string UserName)
        {
            string cacheKey = $"{V_NOMBRE}"; // Combinar los filtros para crear una clave única para la caché
            MemoryCache cache = MemoryCache.Default; // Obtener la instancia del MemoryCache
            // Verificar si ya existe el resultado en caché
            if (cache.Contains(cacheKey))
            {
                return cache.Get(cacheKey) as DataTable; // Retornar el DataTable almacenado en caché
            }

            dtResultados =
                (new ClienteSoapClient()).BusquedaEmbarcacionyCliente(V_NOMBRE,
                    UserName); // Si no está en caché, llamar al servicio para obtener los datos

            // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
            CacheItemPolicy policy = new CacheItemPolicy
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(30) // Expira en 30 minutos
            };
            if (!string.IsNullOrEmpty(V_NOMBRE)) // Almacenar el resultado en caché, si es un valor correcto
            {
                cache.Add(cacheKey, dtResultados, policy); // Almacenar el resultado en caché
            }

            return dtResultados;
        }

        [WebMethod]
        public DataTable ListarContactos(string X_C_CLIE_CODCLI)
        {
            return (new ClienteSoapClient()).ListarContactosDeCliente(X_C_CLIE_CODCLI);
        }

        //---------------------------------
        [WebMethod]
        public DataTable ListarEmbarcaciones(string V_FILTRO)
        {
            try
            {
                // Obtener la instancia del MemoryCache
                MemoryCache cache = MemoryCache.Default;

                // Verificar si ya existe el resultado en caché
                if (cache.Contains(V_FILTRO))
                {
                    // Retornar el DataTable almacenado en caché
                    return cache.Get(V_FILTRO) as DataTable;
                }

                // Si no está en caché, llamar al servicio para obtener los datos
                DataTable resultado = ObtenerEmbarcaciones(V_FILTRO);

                // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                CacheItemPolicy policy = new CacheItemPolicy
                {
                    AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(30) // Expira en 30 minutos
                };

                // Almacenar el resultado en caché
                cache.Add(V_FILTRO, resultado, policy);

                // Retornar los datos obtenidos
                return resultado;
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                throw new HttpException(500, "Error interno del servidor", ex);
            }
        }

        [WebMethod]
        public DataTable ObtenerEmbarcaciones(string V_FILTRO)
        {
            try
            {
                // Llamar al método y obtener el XML como string
                String xmlData = (new ClienteSoapClient()).ListarEmbarcaciones(V_FILTRO);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                if (ds.Tables.Contains("PR_GET_EMBARCACIONES"))
                {
                    return ds.Tables["PR_GET_EMBARCACIONES"];
                }
                else
                {
                    DataTable dtVacio = new DataTable("PR_GET_EMBARCACIONES");

                    dtVacio.Columns.Add("ESLORA", typeof(decimal));
                    dtVacio.Columns.Add("V_EMBARCACION_ID", typeof(string));
                    dtVacio.Columns.Add("V_CLIENTE_ID", typeof(string));
                    dtVacio.Columns.Add("NOM_APS", typeof(string));
                    dtVacio.Columns.Add("TIP_UND", typeof(string));
                    dtVacio.Columns.Add("NOM_UND", typeof(string));
                    dtVacio.Columns.Add("NOMBREANTERIOR", typeof(string));
                    dtVacio.Columns.Add("EST_ATL", typeof(string));
                    dtVacio.Columns.Add("MATRICULA", typeof(string));
                    dtVacio.Columns.Add("TIPO", typeof(string));
                    dtVacio.Columns.Add("FEC_INGRESO", typeof(DateTime));
                    dtVacio.Columns.Add("ASTILLERO_CONSTRUCTOR", typeof(string));
                    return dtVacio;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                throw new HttpException(500, "Error interno del servidor", ex);
            }
        }

        [WebMethod]
        public string GEN_EMBARCACION_ID(string P_V_CLIENTE_ID)
        {
            return (new ClienteSoapClient()).GEN_EMBARCACION_ID(P_V_CLIENTE_ID);
        }

        [WebMethod]
        public DataTable ListaBuscarCliente3(string V_NOMBRE, string UserName)
        {
            // SP_BuscarCliente3
            DataTable dtError = new DataTable("SP_BuscarCliente3");
            dtError.TableName = "SP_BuscarCliente3";
            dtError.Columns.Add("CODIGO", typeof(string));
            dtError.Columns.Add("NOMBRE", typeof(string));


            // -----validamos datos Obligatorios ----
            if (V_NOMBRE == "" || V_NOMBRE == null)
            {
                DataRow row = dtError.NewRow();
                row["NOMBRE"] =
                    "Ingrese un valor para la busqueda, es un parámetro obligatorio para retornar información";
                dtError.Rows.Add(row);
                return dtError;
            }

            dtResultados = (new ClienteSoapClient().ListaBuscarCliente3(V_NOMBRE, UserName));
            if (dtResultados != null) // valida vacio
            {
                if (dtResultados.Rows.Count > 0)
                {
                    return dtResultados;
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["CODIGO"] = "0";
                    row["NOMBRE"] = "No existen registros para los parámetros consultados: " + V_NOMBRE;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }

            return dtResultados;
        }

        [WebMethod(Description = "Listar Unidad de medida filtrado por tipo de unidad")]
        public DataTable Listar_Tg_Unidad_Medida2(string unidad, string UserName)
        {
            return (new logisticaSoapClient()).Listar_Tg_Unidad_Medida2(unidad, UserName);
        }

        [WebMethod]
        public string InsertarDetalleEmbarcacion(string X_EMBARCACION_ID, string X_IDAREA, string X_VALOR,
            string X_FECHAREGISTRO, string X_UM)
        {
            return (new ClienteSoapClient()).InsertarDetalleEmbarcacion(X_EMBARCACION_ID, X_IDAREA, X_VALOR,
                X_FECHAREGISTRO, X_UM);
        }

        [WebMethod]
        public DataTable ListarDetalleDeEmbarcacionPorID(string X_EMBARCACION_ID)
        {
            return (new ClienteSoapClient()).ListarDetalleDeEmbarcacionPorID(X_EMBARCACION_ID);
        }

        [WebMethod(Description = "Lista de clientes 2")]
        public DataTable ListaBuscarCliente2(string V_NOMBRE, string UserName)
        {
            string cacheKey = $"{V_NOMBRE}"; // Combinar los filtros para crear una clave única para la caché
            MemoryCache cache = MemoryCache.Default; // Obtener la instancia del MemoryCache
            // Verificar si ya existe el resultado en caché
            if (cache.Contains(cacheKey))
            {
                return cache.Get(cacheKey) as DataTable; // Retornar el DataTable almacenado en caché
            }

            dtResultados =
                (new ClienteSoapClient().ListaBuscarCliente2(V_NOMBRE,
                    UserName)); // Si no está en caché, llamar al servicio para obtener los datos

            // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
            CacheItemPolicy policy = new CacheItemPolicy
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(30) // Expira en 30 minutos
            };
            if (!string.IsNullOrEmpty(V_NOMBRE)) // Almacenar el resultado en caché, si es un valor correcto
            {
                cache.Add(cacheKey, dtResultados, policy);
            }

            return dtResultados; // Retornar los datos obtenidos
        }

        [WebMethod(Description = "Lista Clientes por codigo o descripción")]
        public DataTable ListaClientesxCodxDescr(string V_CODIGO, string V_DESCRIPCION, string UserName)
        {
            return (new ClienteSoapClient()).listaclientesxcodxdescr(V_CODIGO, V_DESCRIPCION, UserName);
        }

        [WebMethod(Description = "Lista Unidades / embarcaciones  por cliente, codigo unidad y descripcion")]
        public DataTable ListaUnidxCliexCodxDescr(string V_CLIENTE, string V_CODIGO, string V_DESCRIPCION,
            string UserName)
        {
            return (new ClienteSoapClient()).listaunidxcliexcodxdescr(V_CLIENTE, V_CODIGO, V_DESCRIPCION, UserName);
        }

        #endregion

        #region Solicitud de Trabajo

        [WebMethod]
        public DataTable ListarSolicitudTrabajo(string V_AMBIENTE, string V_FILTRO, string V_CEO,
            string V_UND_OPER, string V_FEC_STR_INI, string V_FEC_STR_FIN, string UserName)
        {
            V_AMBIENTE = sAmbiente;
            return (new SolicitudSoapClient()).ListarSolicitudTrabajo(V_AMBIENTE, V_FILTRO, V_CEO, V_UND_OPER,
                V_FEC_STR_INI, V_FEC_STR_FIN, UserName);
        }

        [WebMethod]
        public DataTable ListarClasesTrabajo(string UserName)
        {
            string cacheKey = $"ListarClasesTrabajo"; // Combinar los filtros para crear una clave única para la caché
            MemoryCache cache = MemoryCache.Default; // Obtener la instancia del MemoryCache
            // Verificar si ya existe el resultado en caché
            if (cache.Contains(cacheKey))
            {
                return cache.Get(cacheKey) as DataTable; // Retornar el DataTable almacenado en caché
            }

            dtResultados =
                (new GeneralSoapClient())
                .ListaClase_Trabajo(UserName); // Si no está en caché, llamar al servicio para obtener los datos

            // Configurar la política de expiración de la caché (10 minutos en este ejemplo)
            CacheItemPolicy policy = new CacheItemPolicy
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(10) // Expira en 30 minutos
            };

            cache.Add(cacheKey, dtResultados, policy); // Almacenar el resultado en caché

            return dtResultados;
        }

        [WebMethod]
        public DataTable ListarSolicitudTrabajo2(string V_AMBIENTE, string V_FILTRO, string V_CEO, string V_UND_OPER,
            string V_LINEA, string V_FEC_STR_INI, string V_FEC_STR_FIN, string UserName)
        {
            DataTable dtError = new DataTable("PR_GET_SOLICITUD");


            dtError.TableName = "PR_GET_SOLICITUD";
            dtError.Columns.Add("NroSolicitud", typeof(string));
            dtError.Columns.Add("Linea", typeof(string));
            dtError.Columns.Add("Cliente", typeof(string));
            dtError.Columns.Add("Embarcacion / Proyecto", typeof(string));
            dtError.Columns.Add("TipoSolicitud", typeof(string));
            dtError.Columns.Add("Actividad", typeof(string));
            dtError.Columns.Add("Estado", typeof(string));
            dtError.Columns.Add("UsuarioReg", typeof(string));
            dtError.Columns.Add("FechaReg", typeof(string));


            try
            {
                V_AMBIENTE = sAmbiente;
                if (V_UND_OPER == "-1")
                {
                    V_UND_OPER = V_LINEA;
                }

                if (V_LINEA != "-1" && V_FILTRO == "")
                {
                    V_FILTRO = V_LINEA;
                }

                if (V_CEO == "1" && V_UND_OPER != "") // DEBE ENVIAR VACIO PARA CALLAO
                {
                    V_UND_OPER = "";
                }

                if (V_CEO == "1" && V_UND_OPER == "" && V_FILTRO != "")
                {
                    V_UND_OPER = V_LINEA;
                }

                // Combinar los filtros para crear una clave única para la caché
                string cacheKey =
                    $"{V_AMBIENTE}_{V_FILTRO}_{V_CEO}_{V_UND_OPER}_{V_FEC_STR_INI}_{V_FEC_STR_FIN}_{UserName}";

                // Obtener la instancia del MemoryCache
                MemoryCache cache = MemoryCache.Default;

                // Verificar si ya existe el resultado en caché
                if (cache.Contains(cacheKey))
                {
                    // Retornar el DataTable almacenado en caché
                    return cache.Get(cacheKey) as DataTable;
                }

                // Si no está en caché, llamar al servicio para obtener los datos
                dtResultados = ListarSolicitudTrabajo_dt(V_AMBIENTE, V_FILTRO, V_CEO, V_UND_OPER, V_FEC_STR_INI,
                    V_FEC_STR_FIN, UserName);


                // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                CacheItemPolicy policy = new CacheItemPolicy
                {
                    AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(5) // Resultados almacenados Expira en 30 minutos
                };


                // Almacenar el resultado en caché "SOLO" si los registros son mayores a 50
                if (dtResultados != null)
                {
                    if (dtResultados.Rows.Count >= 49)
                    {
                        cache.Add(cacheKey, dtResultados, policy);
                    }

                    return dtResultados; // Retornar los datos obtenidos
                }

                else
                {
                    DataRow row = dtError.NewRow();
                    row["Linea"] = V_LINEA;
                    row["Embarcacion / Proyecto"] = "No existen registros para los parámetros consultados: " +
                                                    V_FILTRO + " " + V_CEO + " " + V_UND_OPER + " " + V_FEC_STR_INI;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["Actividad"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
        }

        public DataTable ListarSolicitudTrabajo_dt(string V_AMBIENTE, string V_FILTRO, string V_CEO, string V_UND_OPER,
            string V_FEC_STR_INI,
            string V_FEC_STR_FIN, string UserName)
        {
            try
            {
                V_AMBIENTE = sAmbiente;
                // Llamar al método y obtener el XML como string
                String xmlData = (new SolicitudSoapClient()).ListarSolicitudTrabajo2(V_AMBIENTE, V_FILTRO, V_CEO,
                    V_UND_OPER, V_FEC_STR_INI, V_FEC_STR_FIN, UserName);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                // Extraer el DataTable del DataSet
                DataTable dt = ds.Tables["PR_GET_SOLICITUD"];

                return dt;
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                throw new HttpException(500, "Error interno del servidor", ex);
            }
        }

        #endregion

        #region Proyecto

        [WebMethod(Description = "Lista Proyectos por CEO, codigo unidad operativa, Linea Negocio y descripcion")]
        public DataTable ListarProyectos(string V_CEO, string V_UND_OPER, string V_LINEA, string V_FILTRO,
            string V_FECHAINI, string V_FECHAFIN)
        {
            DataTable dtVacio = new DataTable("PR_GET_PROYECTOS");

            dtVacio.Columns.Add("COD_CEO", typeof(string));
            dtVacio.Columns.Add("V_PRY_UNDOPER", typeof(string));
            dtVacio.Columns.Add("COD_DIV", typeof(string));
            dtVacio.Columns.Add("V_PRY_SUBLINEA", typeof(string));
            dtVacio.Columns.Add("COD_PRY", typeof(string));
            dtVacio.Columns.Add("DES_PRY", typeof(string));
            dtVacio.Columns.Add("EST_PRY", typeof(string));
            dtVacio.Columns.Add("FEC_REG", typeof(string));
            dtVacio.Columns.Add("USR_REG", typeof(string));
            dtVacio.Columns.Add("FECINI_PRY", typeof(string));
            dtVacio.Columns.Add("FECFIN_PRY", typeof(string));
            dtVacio.Columns.Add("V_CLIENTE_ID", typeof(string));
            dtVacio.Columns.Add("V_PRY_COD_JEFEPROY", typeof(string));
            dtVacio.Columns.Add("N_PRY_MONTO_SINIMP", typeof(string));
            dtVacio.Columns.Add("V_PRY_CODMONEDA", typeof(string));

            try
            {
                // Llamar al método y obtener el XML como string
                string xmlData = (new ProyectoSoapClient()).ListarProyectos(V_CEO, V_UND_OPER, V_LINEA, V_FILTRO, V_FECHAINI, V_FECHAFIN);


                // Crear un DataSet y cargar el XML
                DataSet ds = new DataSet();
                using (StringReader sr = new StringReader(xmlData))
                {
                    ds.ReadXml(sr);
                }

                if (ds.Tables.Contains("PR_GET_PROYECTOS"))
                {
                    // Extraer el DataTable del DataSet
                    DataTable dt = ds.Tables["PR_GET_PROYECTOS"];

                    return dt;
                }
                else
                {
                    return dtVacio;
                }
            }
            catch (Exception ex)
            {
                // Devuelvo fila vacía con mensaje de error
                DataRow row = dtVacio.NewRow();
                //   row["DES_PRY"] = "0";
                row["DES_PRY"] = "Error en servicio: " + ex.Message;
                dtVacio.Rows.Add(row);
                return dtVacio;
            }
        }


        [WebMethod]
        public string GEN_PROYECTO_ID(string p_ceo, string p_unidOpe, string P_linea, string p_sublinea,
            string P_V_CLIENTE_ID)
        {
            return (new ProyectoSoapClient()).GEN_PROYECTO_ID(p_ceo, p_unidOpe, P_linea, p_sublinea, P_V_CLIENTE_ID);
        }

        [WebMethod(Description = "Lista tipo proyecto")]
        public DataTable listaTipoProyecto(string V_CEO, string UserName)
        {
            return (new GeneralSoapClient()).listaTipoProyecto(V_CEO, UserName);
        }

        [WebMethod(Description = "Lista Colaboradores del proyecto")]
        public DataTable Listar_ColaboradoresProyecto(string V_SUCURSAL, string V_PROYECTO)
        {
            return (new ProyectoSoapClient()).Listar_ColaboradoresProyecto(V_SUCURSAL, V_PROYECTO);
        }

        [WebMethod(Description = "LISTAR OTS ASOCIADAS A PROYECTO")]
        public DataTable ListarOtSPorProyecto(string V_COD_PRY)
        {
            //  dtResultados=(new ProyectoSoapClient()).ListarOtSPorProyecto(V_COD_PRY);
            ProyectoSoapClient oPRY = new ProyectoSoapClient();
            DataTable dtError = new DataTable("PR_GET_OTS_PROYECTO");

            dtError.TableName = "PR_GET_OTS_PROYECTO";
            dtError.Columns.Add("DESCRIPCION", typeof(string));
            dtError.Columns.Add("COD_OTS", typeof(Number));
            dtError.Columns.Add("NRO_VAL_TBJ", typeof(Number));
            dtError.Columns.Add("UNIDAD", typeof(string));
            dtError.Columns.Add("FEC_REG", typeof(DateTime));
            dtError.Columns.Add("DES_DET", typeof(string));
            try
            {
                // -----validamos datos Obligatorios ----

                if (V_COD_PRY == "-1" || V_COD_PRY == "")
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] =
                        "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                // ----------------------------------------------------
                dt = oPRY.ListarOtSPorProyecto(V_COD_PRY);

                if (dt != null) // valida vacio
                {
                    dt.TableName = "PR_GET_OTS_PROYECTO";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "PR_GET_OTS_PROYECTO";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["DESCRIPCION"] = "No existen registros para los parámetros consultados: " + V_COD_PRY;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["DESCRIPCION"] = "No existen registros para los parámetros consultados: " + V_COD_PRY;
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
                if (oPRY != null)
                {
                    try
                    {
                        if (oPRY.State != System.ServiceModel.CommunicationState.Faulted)
                            oPRY.Close();
                        else
                            oPRY.Abort();
                    }
                    catch
                    {
                        oPRY.Abort();
                    }
                }
            }
        }

        [WebMethod(Description = "LISTAR ADENDAS ASOCIADAS A PROYECTO")]
        public DataTable ListarAdendasPorProyecto(string V_COD_PRY)
        {
            //  dtResultados = (new ProyectoSoapClient()).ListarAdendasPorProyecto(V_COD_PRY);
            ProyectoSoapClient oPRY = new ProyectoSoapClient();
            DataTable dtError = new DataTable("PR_GET_ADENDAS_POR_PROYECTO");

            dtError.TableName = "PR_GET_ADENDAS_POR_PROYECTO";
            dtError.Columns.Add("N_PROYADE_MONTO", typeof(Number));
            dtError.Columns.Add("V_PROYADE_MONEDA", typeof(string));
            dtError.Columns.Add("D_PROYADE_FECHA", typeof(DateTime));
            try
            {
                // -----validamos datos Obligatorios ----

                if (V_COD_PRY == "-1" || V_COD_PRY == "")
                {
                    DataRow row = dtError.NewRow();
                    row["V_PROYADE_MONEDA"] =
                        "Seleccione un Proyecto, es un parámetro obligatorio para retornar información";
                    dtError.Rows.Add(row);
                    return dtError;
                }

                // ----------------------------------------------------
                dt = oPRY.ListarAdendasPorProyecto(V_COD_PRY);

                if (dt != null) // valida vacio
                {
                    dt.TableName = "PR_GET_ADENDAS_POR_PROYECTO";
                    if (dt.Rows.Count > 0)
                    {
                        dt.TableName = "PR_GET_ADENDAS_POR_PROYECTO";
                        return dt;
                    }
                    else
                    {
                        DataRow row = dtError.NewRow();
                        row["V_PROYADE_MONEDA"] = "No existen registros para los parámetros consultados: " + V_COD_PRY;
                        dtError.Rows.Add(row);
                        return dtError;
                    }
                }
                else
                {
                    DataRow row = dtError.NewRow();
                    row["V_PROYADE_MONEDA"] = "No existen registros para los parámetros consultados: " + V_COD_PRY;
                    dtError.Rows.Add(row);
                    return dtError;
                }
            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["V_PROYADE_MONEDA"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
            // evita que el servicio se bloquee por caida provocada por ese metodo
            finally
            {
                if (oPRY != null)
                {
                    try
                    {
                        if (oPRY.State != System.ServiceModel.CommunicationState.Faulted)
                            oPRY.Close();
                        else
                            oPRY.Abort();
                    }
                    catch
                    {
                        oPRY.Abort();
                    }
                }
            }
        }

        [WebMethod]
        public string Insert_Update_AdendaProyecto(string X_V_PROYADE_CODPRY,
            string X_N_PROYADE_NROADENDA, string X_N_PROYADE_MONTO, string X_V_PROYADE_MONEDA, string opcion)
        {
            return (new ProyectoSoapClient()).InsertarAdendaProyecto(X_V_PROYADE_CODPRY, X_N_PROYADE_NROADENDA,
                X_N_PROYADE_MONTO, X_V_PROYADE_MONEDA, DateTime.Now.ToString("dd/MM/yyyy"), opcion);
        }

        #endregion
    }
}