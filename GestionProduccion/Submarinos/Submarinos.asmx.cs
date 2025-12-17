using EasyControlWeb;
using SIMANET_W22R.srvGestionProduccion;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProduccion.Submarinos
{
    /// <summary>
    /// Descripción breve de Submarinos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Submarinos : System.Web.Services.WebService
    {
        DataTable dt;
        string s_Ambiente = EasyUtilitario.Helper.Configuracion.Leer("Seguridad", "Ambiente");

        [WebMethod(Description = "12. Registro de Ventas Serie 021. Registro de Ventas Serie 021")]
        public DataTable Listar_Registro_Ventas_Serie_021(string V_Centro_Operativo, string D_Año, string D_Mes,
            string V_Tipo_Documento, string V_Origen, string V_Serie, string V_Concepto, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_Registro_Ventas_Serie_021(V_Centro_Operativo, D_Año, D_Mes,
                V_Tipo_Documento, V_Origen, V_Serie, V_Concepto, UserName);
            dt.TableName = "SP_Registro_Ventas_Serie_021";
            return dt;
        }

        [WebMethod(Description = "13. Parte de Cobranzas Serie 021. Parte de Cobranzas Serie 021")]
        public DataTable Listar_Parte_Cobranzas_Serie_021(string V_Centro_Operativo, string D_Año_de_Proceso,
            string D_Mes, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_Parte_Cobranzas_Serie_021(V_Centro_Operativo, D_Año_de_Proceso, D_Mes,
                UserName);
            dt.TableName = "SP_Parte_Cobranzas_Serie_021";
            return dt;
        }

        [WebMethod(Description = "3.-Proyecto Ordenes de Servicios Avance. AVANCE POR ORDENES DE SERVICIO DE OT'S POR PROYECTOS SUBMARINOS")]
        public DataTable Listar_DET_GASTO_PRY_OT_OSE_AVASU(string N_CEO, string V_CODDIV, string V_CODPRY,
            string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_DET_GASTO_PRY_OT_OSE_AVASU(N_CEO, V_CODDIV, V_CODPRY, V_NROOTS,
                UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_OSE_AVASU";
            return dt;
        }

        [WebMethod(Description = "5.-Proyecto Utilización MOB Ruc. UTILIZACION DE MOB DE OT'S POR PROYECTOS SUBMARINOS")]
        public DataTable Listar_DET_GASTO_PRY_OT_MOB_RUCSU(string N_CEO, string V_CODDIV, string V_CODPRY,
            string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_DET_GASTO_PRY_OT_MOB_RUCSU(N_CEO, V_CODDIV, V_CODPRY, D_FECHAINI,
                D_FECHAFIN, UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_MOB_RUCSU";
            return dt;
        }

        [WebMethod(Description = "11. Egresos Directos PRCS. Egresos Directos - PROY.RECUPERACION CAPACIDAD SUBMARINA")]
        public DataTable Listar_Egresos_Directos_PRCS(string V_Centro_Operativo, string D_Año, string D_Mes_Desde,
            string D_Mes_Hasta, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_Egresos_Directos_PRCS(V_Centro_Operativo, D_Año, D_Mes_Desde,
                D_Mes_Hasta, UserName);
            dt.TableName = "SP_Egresos_Directos_PRCS";
            return dt;
        }

        [WebMethod(Description = "15. Mayor Auxliar de Canceladas FxP - Mayor Auxliar de Canceladas FxP")]
        public DataTable Listar_Mayor_Auxiliar_Cancelada(string v_anio, string v_mes, string v_cta, string v_ruc1, string v_ruc2, string v_docu, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_Mayor_Auxiliar_Cancelada(v_anio, v_mes, v_cta, v_ruc1, v_ruc2, v_docu, UserName);
            dt.TableName = "SP_Mayor_Auxiliar_Cancelada";
            return dt;
        }
    }
}
