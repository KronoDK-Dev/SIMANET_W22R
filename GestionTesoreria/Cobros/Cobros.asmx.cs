using SIMANET_W22R.srvGestionTesoreria;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionTesoreria.Cobros
{
    /// <summary>
    /// Descripción breve de Cobros
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Cobros : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_ingresos_contabilizados(string D_FECHA_DESDE, string D_FECHA_HASTA, string V_CENTRO_OPERATIVO, string V_CONCEPTO, string V_DESDE, string V_EMPRESA_DESDE, string V_EMPRESA_HASTA, string V_HASTA, string V_MONEDA, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_ingresos_contabilizados(D_FECHA_DESDE, D_FECHA_HASTA, V_CENTRO_OPERATIVO, V_CONCEPTO, V_DESDE, V_EMPRESA_DESDE, V_EMPRESA_HASTA, V_HASTA, V_MONEDA, UserName);
            dt.TableName = "SP_Ingresos_Contabilizados";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_ventas_x_orden_trabajo(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_NUMERO_OT, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_ventas_x_orden_trabajo(V_CENTRO_OPERATIVO, V_DIVISION, V_NUMERO_OT, UserName);
            dt.TableName = "SP_Ventas_X_Orden_Trabajo";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_folios_pendientes_o7(string D_AÑO, string D_MES, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_folios_pendientes_o7(D_AÑO, D_MES, UserName);
            dt.TableName = "SP_Folios_Pendientes_O7";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_fact_cobrar_sector_privado(string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_fact_cobrar_sector_privado(UserName);
            dt.TableName = "SP_Fact_Cobrar_Sector_Privado";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_fact_cobrar_sector_marina(string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_fact_cobrar_sector_marina(UserName);
            dt.TableName = "SP_Fact_Cobrar_Sector_Marina";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Parte_de_Cobranzas(string V_Centro_Operativo, string D_Año, string D_Mes, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_Parte_de_Cobranzas(V_Centro_Operativo, D_Año, D_Mes, UserName);
            dt.TableName = "SP_Parte_de_Cobranzas";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Documentos_por_Cliente(string V_Centro_Operativo, string V_Cliente, string D_Año_Desde, string D_Año_Hasta, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_Documentos_por_Cliente(V_Centro_Operativo, V_Cliente, D_Año_Desde, D_Año_Hasta, UserName);
            dt.TableName = "SP_Documentos_por_Cliente";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Fact_Men_X_Linea_Neg(string V_Centro_Operativo, string D_Año, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_Fact_Men_X_Linea_Neg(V_Centro_Operativo, D_Año, UserName);
            dt.TableName = "SP_Fact_Men_X_Linea_Neg";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Orden_Trabajo_Datos_Gener(string V_Centro_Operativo, string V_Division, string V_Numero_OT, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_Orden_Trabajo_Datos_Gener(V_Centro_Operativo, V_Division, V_Numero_OT, UserName);
            dt.TableName = "SP_Orden_Trabajo_Datos_Gener";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Anexo_Diques(string V_Centro_Operativo, string V_Division, string V_Numero_OT, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_Anexo_Diques(V_Centro_Operativo, V_Division, V_Numero_OT, UserName);
            dt.TableName = "SP_Anexo_Diques";
            return dt;
        }
    }
}
