using EasyControlWeb;
using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionTesoreria;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

using System.Runtime.Caching;
using System.Web;
using System.Web.Services;
using System.Web.Services.Description;

namespace SIMANET_W22R.General
{
    /// <summary>
    /// Descripción breve de TablasGenerales
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class TablasGenerales : System.Web.Services.WebService
    {
        string s_Ambiente = EasyUtilitario.Helper.Configuracion.Leer("Seguridad", "Ambiente");
        //   string s_UserName = EasyUtilitario.Helper.Sessiones.Usuario.get().ToString() ;
        
        // 12.01.2026 v. ybañez
        DataTable dtResultados = new DataTable();
        DataTable dtError = new DataTable();


        // 12.01.2026 v. ybañez
        DataTable dtResultados = new DataTable();
        DataTable dtError = new DataTable();

        // ******* Método para obtener el usuario conectado *****************
        [WebMethod]  
        public string GetUserCode()
        {
            // Verificar si el usuario está autenticado
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                // Obtener el nombre de usuario del usuario autenticado
                string username = HttpContext.Current.User.Identity.Name;
                return username;
            }
            else
            {
                string username = HttpContext.Current.User.Identity.AuthenticationType.ToString();
                return username;
            }
        }


        [System.Web.Services.WebMethod]
        public DataTable ListarItems(string IdTabla, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                GeneralSoapClient oGeneral = new GeneralSoapClient();
                dt = oGeneral.ListarItemTablas(IdTabla, UserName);
                dt.TableName = "Table";
            }
            catch (Exception ex)
            {
                string e = ex.Message;
                throw ex;

            }
            return dt;
        }

        [System.Web.Services.WebMethod]
        public DataTable ListarTablasdeApoyo(string IdTablaModulo, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                GeneralSoapClient oGeneral = new GeneralSoapClient();
                dt = oGeneral.ListarTablasdeApoyo(IdTablaModulo, UserName);
                dt.TableName = "Table";
            }
            catch (Exception ex)
            {
                string e = ex.Message;
                throw ex;

            }
            return dt;
        }

        [System.Web.Services.WebMethod]
        public DataTable Buscar(string DESCRIPCION, string IdTabla, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                GeneralSoapClient oGeneral = new GeneralSoapClient();
                dt = oGeneral.ListarItemTablas(IdTabla, UserName);
                dt.TableName = "Table";
                if (dt.Rows.Count > 0)
                {
                    DataView dv = dt.DefaultView;
                    dv.RowFilter = "DESCRIPCION LIKE '*" + DESCRIPCION + "*'";
                    dt = EasyUtilitario.Helper.Data.ViewToDataTable(dv);
                }
            }
            catch (Exception ex)
            {
                string e = ex.Message;
                throw ex;

            }
            return dt;
        }

        [System.Web.Services.WebMethod]
        public int InsertaModificaTablaItems(int IdTabla, int IdItem, string Descripcion, int IdEstado, int IdUsuario, string UserName)
        {
            TablaItemBE oTablaItemBE = new TablaItemBE();
            oTablaItemBE.IdTabla = IdTabla;
            oTablaItemBE.Codigo = IdItem;
            oTablaItemBE.Nombre = Descripcion;
            oTablaItemBE.IdEstado = IdEstado;
            oTablaItemBE.IdUsuario = IdUsuario;
            oTablaItemBE.UserName = UserName;

            return (new GeneralSoapClient()).InsertaModificaItemsTabla(oTablaItemBE);
        }

        /*Lectura del v_ambiente desde el archivo de configuracion WEb.config*/

        [WebMethod(Description = "Lista de Centros de Costo")]
        public DataTable ListaCentrosCostos(string NOM_CC, string NOM_CEO, string UserName)
        {
            return (new GeneralSoapClient()).ListarCentrosCosto2(NOM_CEO, NOM_CC, UserName);
        }


        [WebMethod(Description = "Obtiene información de la seccion de configuracion")]
        public string GetWebConfig(string Seccion, string Key)
        {
            Dictionary<string, string> oConfigBaseBE = new Dictionary<string, string>();
            oConfigBaseBE.Add("KeyValue", EasyUtilitario.Helper.Configuracion.Leer(Seccion, Key).Replace("\\", "."));
            return EasyUtilitario.Helper.Data.SeriaizedDiccionario(oConfigBaseBE);
        }




        [WebMethod(Description = "Lista de Almacenes")]
        public DataTable ListaAlmacenes(string UserName)
        {
            return (new GeneralSoapClient()).listaalmacenes24(UserName);
        }

        [WebMethod(Description = "Lista de Bancos")]
        public DataTable ListaBancos(string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).listabancosxcodxdescr(V_DESCRIPCION, UserName);
        }

        [WebMethod(Description = "Lista las CARTOLA por AÑO,MES Y MONEDA")]
        public DataTable ListaCartolas(string V_ANIO, string V_MES, string V_MONEDA, string UserName)
        {
            return (new GeneralSoapClient()).listacartolasxanioxmesxmo(V_ANIO, V_MES, V_MONEDA, UserName);
        }

        [WebMethod(Description = "Lista centros de Costos por Centro operativo")]
        public DataTable ListaCC_xCEO(string N_COD_EMP, string UserName)
        {
            return (new GeneralSoapClient()).listacc_xceo(N_COD_EMP, UserName);
        }

        [WebMethod(Description = "Lista centros de Costos por Nombre")]
        public DataTable ListaCC_xNombre(string N_COD_EMP, string V_NOMBRE_CC, string UserName)
        {
            return (new GeneralSoapClient()).ListarCentrosCosto2(N_COD_EMP, V_NOMBRE_CC, UserName);
        }

        [WebMethod(Description = "Lista centros de Costos por Centro opertivo y Nombre")]
        public DataTable ListaCC_xCEO_Nombre(string UserName)
        {
            return (new GeneralSoapClient()).listacentro_costos02(UserName);
        }

        [WebMethod(Description = "Lista centros de Costos por Centro opertivo y Nombre")]
        public DataTable ListaCentro_Costos02(string UserName)
        {
            return (new GeneralSoapClient()).listacentro_costos02(UserName);
        }

        [WebMethod(Description = "Lista los centros operativo")]
        public DataTable ListaCentro_Opera01(string UserName)
        {
            return (new GeneralSoapClient()).listacentro_opera01(UserName);
        }

        [WebMethod(Description = "Lista de Clases de Material")]
        public DataTable ListaClaseMateriales(string V_NOMBRE, string UserName)
        {
            return (new GeneralSoapClient()).listaclasematxcodxdescrip(V_NOMBRE, UserName);
        }

        [WebMethod(Description = "Lista Clasificación de Rotación de Material")]
        public DataTable ListaClasif_RotacionMat29(string UserName)
        {
            return (new GeneralSoapClient()).listaclasif_rotacionmat29(UserName);
        }


        [WebMethod(Description = "Lista Cotizadores OC CALLAO por código o descripción")]
        public DataTable ListaCotizOCxCodxDescrip(string V_CODIGO, string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).listacotizocxcodxdescrip(V_CODIGO, V_DESCRIPCION, UserName);
        }

        [WebMethod(Description = "Lista cuenta corrientes por Codigo de Banco")]
        public DataTable ListaCtaCtexCodBanco(string V_NOMBRE, string V_CODIGO, string UserName)
        {
            return (new GeneralSoapClient()).listactactexcodbanco(V_NOMBRE, V_CODIGO, UserName);
        }

        [WebMethod(Description = "Lista Decisión: SI o NO")]
        public DataTable ListaDecisión34(string UserName)
        {
            return (new GeneralSoapClient()).listadecisión34(UserName);
        }

        #region faltantes

        [WebMethod(Description = "Lista Liquidaciones por Año")]
        public DataTable ListaLiquidacionesxAnio(string V_ANIO, string UserName)
        {
            return (new GeneralSoapClient()).listaliquidacionesxanio(V_ANIO, UserName);
        }

        [WebMethod(Description = "Lista Lotes de Detraccion por CODIGO")]
        public DataTable ListaLoteDetraccxCodigo(string V_CODIGO, string UserName)
        {
            return (new GeneralSoapClient()).listalotedetraccxcodigo(V_CODIGO, UserName);
        }

        [WebMethod(Description = "Lista meses del año")]
        public DataTable ListaMeses40(string UserName)
        {
            return (new GeneralSoapClient()).listameses40(UserName);
        }

        [WebMethod(Description = "Lista monedas")]
        public DataTable ListaMonedas41(string UserName)
        {
            return (new GeneralSoapClient()).listamonedas41(UserName);
        }

        [WebMethod(Description = "Lista Programa de Adquisición de Material  por Codigo o Descripción del proyecto")]
        public DataTable ListaPGAMxCodxDescrip(string V_CODIGO, string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).listapgamxcodxdescrip(V_CODIGO, V_DESCRIPCION, UserName);
        }

        [WebMethod(Description = "Lista Programa de Adquisición de Material  por Codigo o Descripción del proyecto")]
        public DataTable ListaProcedencia_Compra26(string UserName)
        {
            return (new GeneralSoapClient()).listaprocedencia_compra26(UserName);
        }

        [WebMethod(Description = "Lista Programa de Adquisición de Material  por Codigo o Descripción del proyecto")]
        public DataTable ListaProv_PdtePagoxRUCxDesc(string V_CODIGO, string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).listaprov_pdtepagoxrucxde(V_CODIGO, V_DESCRIPCION, UserName);
        }

        [WebMethod(Description = "Lista Programa de Adquisición de Material  por Codigo o Descripción del proyecto")]
        public DataTable ListaProyec_PdtePagoxDesc(string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).listaproyec_pdtepagoxdesc(V_DESCRIPCION, UserName);
        }


        [WebMethod(Description = "Lista Programa de Adquisición de Material  por Codigo o Descripción del proyecto")]
        public DataTable ListaProyectosxCodxDescrip(string V_CODIGO, string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).listaproyectosxcodxdescri(V_CODIGO, V_DESCRIPCION, UserName);
        }

        [WebMethod(Description = "Lista Proyecto por destino compra y área usuaria o Descripción del proyecto")]
        public DataTable ListaProyectosxDCxAUSxDescr(string V_CODIGO, string V_DESCRIPCION, string V_DESTINO_COMPRA, string UserName)
        {
            return (new GeneralSoapClient()).listaproyectosxdcxausxdes(V_CODIGO, V_DESCRIPCION, V_DESTINO_COMPRA, UserName);
        }

        [WebMethod(Description = "Lista Talleres / divisiones  por codigo y descripcion")]
        public DataTable ListaTalleresxCodxDescr(string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).listatalleresxcodxdescr(V_DESCRIPCION, UserName);
        }

        [WebMethod(Description = "Lista tipo de Egresos: chque o efectivo")]
        public DataTable ListaTipo_Egresos42(string UserName)
        {
            return (new GeneralSoapClient()).listatipo_egresos42(UserName);
        }

        [WebMethod(Description = "Lista Tipos de Orden compra")]
        public DataTable ListaTipo_OCompra31(string UserName)
        {
            return (new GeneralSoapClient()).listatipo_ocompra31(UserName);
        }

        [WebMethod(Description = "Lista Tipo de Proveedor: Materiales , Servicios , seguro médico, otros")]
        public DataTable ListaTipo_Proveedor36(string UserName)
        {
            return (new GeneralSoapClient()).listatipo_proveedor36(UserName);
        }

        [WebMethod(Description = "Lista Tipo de Recurso: Materiales o Servicios")]
        public DataTable ListaTipo_Recurso33(string UserName)
        {
            return (new GeneralSoapClient()).listatipo_recurso33(UserName);
        }

        [WebMethod(Description = "Lista tipo reporte Actividades por fechas:  Termino OT, Inicio Actividad, Fecha Termino Actividad")]
        public DataTable ListaTipo_ReportACTI39(string UserName)
        {
            return (new GeneralSoapClient()).listatipo_reportacti39(UserName);
        }


        #endregion

        [WebMethod(Description = "Lista tipo bien")]
        public DataTable ListaTipoBien(string UserName)
        {
            return (new GeneralSoapClient()).listadest_valesm32(UserName);
        }

        [WebMethod(Description = "Lista Estados de la Orden compra")]
        public DataTable ListaEstado_OCompra28(string UserName)
        {
            return (new GeneralSoapClient()).listaestado_ocompra28(UserName);
        }

        [WebMethod(Description = "Lista Estado OT: ANU, PRG, SUS, EJE , TER, ANU , APER")]
        public DataTable ListaEstado_OT38(string UserName)
        {
            return (new GeneralSoapClient()).listaestado_ot38(UserName);
        }

        [WebMethod(Description = "Lista Los tipo de adquisiciones  o finalidad de la compra")]
        public DataTable ListaFin_Compra27(string UserName)
        {
            return (new GeneralSoapClient()).listafin_compra27(UserName);
        }

        [WebMethod(Description = "Lista Linea de Negocio de Callo")]
        public DataTable ListaLineas(string UserName)
        {
            return (new GeneralSoapClient()).ListaLineas(UserName);
        }


        [WebMethod(Description = "Lista Linea de Negocio o Divisiones de sima PERU")]
        public DataTable ListaLineas_SIMAPERU30(string UserName)
        {
            return (new GeneralSoapClient()).listalineas_simaperu30(UserName);
        }


        [WebMethod(Description = "Lista tipo reporte OT: 1  Lista Valorizaciones no en OT | 2  Lista  OT |3  Lista  Todas las valorizaciones")]
        public DataTable ListaTipo_ReportOT37(string UserName)
        {
            return (new GeneralSoapClient()).listatipo_reportot37(UserName);
        }

        [WebMethod(Description = "Lista Tipo de Servicios: SR... por codigo y descripcion")]
        public DataTable ListaTipo_Servicios(string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).listatipo_servicios(V_DESCRIPCION, UserName);
        }

        [WebMethod(Description = "Lista de Tipos de Stock")]
        public DataTable ListaTipoStock(string UserName)
        {
            return (new GeneralSoapClient()).listatipo_stock25(UserName);
        }

        [WebMethod(Description = "Lista Colaboradores por codigo y descripcion")]
        public DataTable ListaTrabxCodxDescr(string V_CODIGO, string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).listatrabxcodxdescr(V_CODIGO, V_DESCRIPCION, UserName);
        }


        [WebMethod(Description = "Lista  usuarios unisys")]
        public DataTable ListaU(string v_descripcion, string UserName)
        {
            return (new GeneralSoapClient()).ListaUserUnisysxNom(v_descripcion, UserName);
        }

        [WebMethod(Description = "Lista de Cuentas")]
        public DataTable ListaContabCuentas(string V_NOMBRE, string V_PERIODO, string UserName)
        {
            DataTable dt = new DataTable();
            dt = (new GeneralSoapClient()).ListaContabCuentas(V_NOMBRE, V_PERIODO, UserName);
            dt.TableName = "Table";

            return dt;
        }

        [WebMethod(Description = "Lista de Cuentas")]
        public DataTable ListaContabCuentaMayor(string V_NOMBRE, string UserName)
        {
            return (new GeneralSoapClient()).ListaContabCuentaMayor(V_NOMBRE, UserName);
        }

        [WebMethod(Description = "Lista de Subdiarios")]
        public DataTable ListaSubDiarios(string V_NOMBRE, string UserName)
        {
            return (new GeneralSoapClient()).ListaSubDiario(V_NOMBRE, UserName);
        }

        [WebMethod(Description = "Lista de Cuentas sin Periodo")]
        public DataTable ListaContabCuentaSinPeriodo(string V_NOMBRE, string UserName)
        {
            return (new GeneralSoapClient()).ListaContabCuentaSinPeriodo(V_NOMBRE, UserName);
        }

        [WebMethod(Description = "Busqueda de Proveedores")]
        public DataTable ListaProveedores(string V_NOMBRE, string UserName)
        {
            return (new GeneralSoapClient()).ListaProveedores(V_NOMBRE, UserName);
        }

        [WebMethod(Description = "Tipo de Documentos")]
        public DataTable TipoDocumento(string UserName)
        {
            return (new GeneralSoapClient()).TipoDocumento(UserName);
        }

        [WebMethod(Description = "Tipos de Orden")]
        public DataTable TipoOrden(string UserName)
        {
            return (new GeneralSoapClient()).TipoOrden(UserName);
        }
        /*
        [WebMethod(Description = "Lista de Centros Operativos por Perfil")]
        public DataTable ListaCentrosOperativosPorPerfil(string IdUsuario, string UserName)
        {
            return (new GeneralSoapClient()).ListarCentroOperativoPorPerfil(IdUsuario, UserName);
        }
        */
        [WebMethod(Description = "Lista de Centros Operativos por Perfil")]
        public DataTable ListaCentrosOperativosPorPerfil(string IdUsuario, string UserName)
        {
            try
            {
                string cacheKey = $"{IdUsuario}_{UserName}"; // Combinar los filtros para crear una clave única para la caché
                MemoryCache cache = MemoryCache.Default;  // Obtener la instancia del MemoryCache
                                                          // Verificar si ya existe el resultado en caché
                if (cache.Contains(cacheKey))
                {
                    return cache.Get(cacheKey) as DataTable;                  // Retornar el DataTable almacenado en caché
                }

                dtResultados = (new GeneralSoapClient()).ListarCentroOperativoPorPerfil(IdUsuario, UserName);             // Si no está en caché, llamar al servicio para obtener los datos

                // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                CacheItemPolicy policy = new CacheItemPolicy
                {
                    AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(1) // Expira en 30 minutos
                };
                if (!string.IsNullOrEmpty(IdUsuario))  // Almacenar el resultado en caché, si es un valor correcto
                {
                    cache.Add(cacheKey, dtResultados, policy);
                }


                return dtResultados;              // Retornar los datos obtenidos

            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio SIMANET: " + ex.Message);
                return dtError;
            }
        }

        [WebMethod(Description = "Lista de Unidad Operativa por Centro Operativo")]
        public DataTable ListaUnidad_OpexCEO(string sCodigo, string UserName)
        {
            try
            {
                return (new GeneralSoapClient()).ListaUnidad_OpexCEO(sCodigo, UserName);
            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }
        }

        [WebMethod(Description = "Lista Linea de Negocio por centro operativo")]
        public DataTable ListaLineas_NegxCEO(string V_CODIGO, string UserName)
        {
            try
            {
                if (!string.IsNullOrEmpty(V_CODIGO))
                {
                    string cacheKey = $"{V_CODIGO}"; // Combinar los filtros para crear una clave única para la caché
                    MemoryCache cache = MemoryCache.Default;  // Obtener la instancia del MemoryCache
                                                              // Verificar si ya existe el resultado en caché
                    if (cache.Contains(cacheKey))
                    {
                        return cache.Get(cacheKey) as DataTable;                  // Retornar el DataTable almacenado en caché
                    }

                    dtResultados = (new GeneralSoapClient()).SP_ListaLineas_NegxCEO(V_CODIGO, UserName, UserName);             // Si no está en caché, llamar al servicio para obtener los datos

                    // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                    CacheItemPolicy policy = new CacheItemPolicy
                    {
                        AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(30) // Expira en 30 minutos
                    };
                    if (!string.IsNullOrEmpty(V_CODIGO))  // Almacenar el resultado en caché, si es un valor correcto
                    {
                        cache.Add(cacheKey, dtResultados, policy);
                    }
                }
                return dtResultados;              // Retornar los datos obtenidos

            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }
        }



        [WebMethod(Description = "Lista Linea de Negocio por centro operativo y unidad operativa")]
        public DataTable ListaLineasNegxCEOxUO(string V_CEO, string V_UNI_OPE, string UserName)
        {
            try
            {

                if (V_UNI_OPE == "-1")
                {
                    V_UNI_OPE = "";
                }
                dtResultados = (new GeneralSoapClient()).ListaLineasNegxCEOxUO(V_CEO, V_UNI_OPE, UserName);

                return dtResultados;
            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }
        }

        [WebMethod(Description = "Lista Sub Linea de Negocio por centro operativo , unidad operativa y Linea")]
        public DataTable ListaSubLineasNegxCEOxUOxL(string V_CEO, string V_UNI_OPE, string V_LINEA, string UserName)
        {
            try
            {

                if (V_UNI_OPE == "-1")
                {
                    V_UNI_OPE = "";
                }

                if (V_LINEA == "-1")
                {
                    V_LINEA = "";
                }
                dtResultados = (new GeneralSoapClient()).ListaSubLineasNegxCEOxUOxL(V_CEO, V_UNI_OPE, V_LINEA, UserName);

                return dtResultados;
            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }
        }



        [WebMethod(Description = "Lista SubLineas Callao")]
        public DataTable ListaSubLineasCallao(string UserName)
        {
            return (new GeneralSoapClient()).ListaSubLineasCallao(UserName);
        }



        /*
        [WebMethod(Description = "Lista de Centros Operativos por Perfil")]
        public DataTable ListaCentrosOperativosPorPerfil(string IdUsuario, string UserName)
        {
            return (new GeneralSoapClient()).ListarCentroOperativoPorPerfil(IdUsuario, UserName);
        }
        */
        [WebMethod(Description = "Lista de Centros Operativos por Perfil")]
        public DataTable ListaCentrosOperativosPorPerfil(string IdUsuario, string UserName)
        {
            try
            {
                string cacheKey = $"{IdUsuario}_{UserName}"; // Combinar los filtros para crear una clave única para la caché
                MemoryCache cache = MemoryCache.Default;  // Obtener la instancia del MemoryCache
                                                          // Verificar si ya existe el resultado en caché
                if (cache.Contains(cacheKey))
                {
                    return cache.Get(cacheKey) as DataTable;                  // Retornar el DataTable almacenado en caché
                }

                dtResultados = (new GeneralSoapClient()).ListarCentroOperativoPorPerfil(IdUsuario, UserName);             // Si no está en caché, llamar al servicio para obtener los datos

                // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                CacheItemPolicy policy = new CacheItemPolicy
                {
                    AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(1) // Expira en 30 minutos
                };
                if (!string.IsNullOrEmpty(IdUsuario))  // Almacenar el resultado en caché, si es un valor correcto
                {
                    cache.Add(cacheKey, dtResultados, policy);
                }


                return dtResultados;              // Retornar los datos obtenidos

            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio SIMANET: " + ex.Message);
                return dtError;
            }
        }

        [WebMethod(Description = "Lista de Unidad Operativa por Centro Operativo")]
        public DataTable ListaUnidad_OpexCEO(string sCodigo, string UserName)
        {
            try
            {
                return (new GeneralSoapClient()).ListaUnidad_OpexCEO(sCodigo, UserName);
            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }
        }

        [WebMethod(Description = "Lista Linea de Negocio por centro operativo")]
        public DataTable ListaLineas_NegxCEO(string V_CODIGO, string UserName)
        {
            try
            {
                if (!string.IsNullOrEmpty(V_CODIGO))
                {
                    string cacheKey = $"{V_CODIGO}"; // Combinar los filtros para crear una clave única para la caché
                    MemoryCache cache = MemoryCache.Default;  // Obtener la instancia del MemoryCache
                                                              // Verificar si ya existe el resultado en caché
                    if (cache.Contains(cacheKey))
                    {
                        return cache.Get(cacheKey) as DataTable;                  // Retornar el DataTable almacenado en caché
                    }

                    dtResultados = (new GeneralSoapClient()).SP_ListaLineas_NegxCEO(V_CODIGO, UserName, UserName);             // Si no está en caché, llamar al servicio para obtener los datos

                    // Configurar la política de expiración de la caché (30 minutos en este ejemplo)
                    CacheItemPolicy policy = new CacheItemPolicy
                    {
                        AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(30) // Expira en 30 minutos
                    };
                    if (!string.IsNullOrEmpty(V_CODIGO))  // Almacenar el resultado en caché, si es un valor correcto
                    {
                        cache.Add(cacheKey, dtResultados, policy);
                    }
                }
                return dtResultados;              // Retornar los datos obtenidos

            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }
        }

    

        [WebMethod(Description = "Lista Linea de Negocio por centro operativo y unidad operativa")]
        public DataTable ListaLineasNegxCEOxUO(string V_CEO, string V_UNI_OPE, string UserName)
        {
            try
            {

                if (V_UNI_OPE == "-1")
                {
                    V_UNI_OPE = "";
                }
                dtResultados = (new GeneralSoapClient()).ListaLineasNegxCEOxUO(V_CEO, V_UNI_OPE, UserName);

                return dtResultados;
            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }
        }

        [WebMethod(Description = "Lista Sub Linea de Negocio por centro operativo , unidad operativa y Linea")]
        public DataTable ListaSubLineasNegxCEOxUOxL(string V_CEO, string V_UNI_OPE, string V_LINEA, string UserName)
        {
            try
            {

                if (V_UNI_OPE == "-1")
                {
                    V_UNI_OPE = "";
                }

                if (V_LINEA == "-1")
                {
                    V_LINEA = "";
                }
                dtResultados = (new GeneralSoapClient()).ListaSubLineasNegxCEOxUOxL(V_CEO, V_UNI_OPE, V_LINEA, UserName);

                return dtResultados;
            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }
        }

      

        [WebMethod(Description = "Lista SubLineas Callao")]
        public DataTable ListaSubLineasCallao(string UserName)
        {
            return (new GeneralSoapClient()).ListaSubLineasCallao(UserName);
        }
        //**********************************************************************
        // metodos faltantes en integracion de la solucion 13.01.2026
        //*****************************************************************
        [WebMethod(Description = "listaTipoGasto")]
        public DataTable ListaTipo_GastosDOT(string UserName)
        {
            return (new GeneralSoapClient().ListaTipo_GastosDOT(UserName));
        }
        [WebMethod(Description = "Lista de Proyectos")]
        public DataTable ListaProyectosSinDep(string V_NOMBRE, string UserName)
        {
            return (new GeneralSoapClient().ListaProyectosSinDep(V_NOMBRE, UserName));
          //  return (new TesoreriaSoapClient().ListaProyectosSinDep(V_NOMBRE, UserName));

        }
        [WebMethod(Description = "Listar tipos de cliente")]
        public DataTable Lista_get_tabgeneral(string N_TAB, string C_ESTA, string UserName)
        {
            return (new GeneralSoapClient()).Lista_get_tabgeneral(N_TAB, C_ESTA, UserName);
        }
        [WebMethod(Description = "Listar CIIU")]
        public DataTable Lista_get_ciiu(string UserName)
        {
            return (new GeneralSoapClient()).Lista_get_ciiu(UserName);
        }
        [WebMethod(Description = "Lista paises, departamente, provincias o distritos")]
        public DataTable Lista_PAIS_DPT_PROV_DIST(string V_OPCION, string V_VAR, string UserName)
        {
            dtResultados= (new GeneralSoapClient()).Lista_PAIS_DPT_PROV_DIST(V_OPCION, V_VAR, UserName);
            return dtResultados;
        }
        [WebMethod(Description = "Listar impresoras")]
        public DataTable ListarImpresoras(string UserName)
        {
            return (new GeneralSoapClient().TipoImpresora(UserName));
        }
        [WebMethod(Description = "Lista de Tipos de Operaciones de Pago")]
        public DataTable ListaOperaciones_Lst(string V_DESCRIPCION, string UserName)
        {
            return (new GeneralSoapClient()).ListaOperaciones_Lst(V_DESCRIPCION, UserName);
        }

        [WebMethod(Description = "Lista estados Proyectos")]
        public DataTable ListaEstadosProyectos(string UserName)
        {
            DataTable dtError = new DataTable("SP_Lista_Registros_Gen");
            dtError.TableName = "SP_Lista_Registros_Gen";
            dtError.Columns.Add("CODIGO", typeof(string));
            dtError.Columns.Add("NOMBRE", typeof(string));

            try
            {
                dtResultados = (new GeneralSoapClient()).Listar_Reg_TabGeneral("206", "ACT", "NRO_CUO", UserName);
                return dtResultados;

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["NOMBRE"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
        }

        [WebMethod(Description = "Lista Categorías de Transferencia de Tecnología")]
        public DataTable ListaCategoriasTransferenciaDT(string UserName)
        {
            DataTable dtError = new DataTable("SP_Lista_Registros_Gen");
            dtError.TableName = "SP_Lista_Registros_Gen";
            dtError.Columns.Add("CODIGO", typeof(string));
            dtError.Columns.Add("NOMBRE", typeof(string));

            try
            {
                dtResultados = (new GeneralSoapClient()).Listar_Reg_TabGeneral("209", "ACT", "NRO_CUO", UserName);
                return dtResultados;

            }
            catch (Exception ex)
            {
                // Log del error y lanzar una excepción HTTP 500
                DataRow row = dtError.NewRow();
                row["NOMBRE"] = "Error en servicio: " + ex.Message;
                dtError.Rows.Add(row);
                return dtError;
            }
        }

    }
}
