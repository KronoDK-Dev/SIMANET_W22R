using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionContabilidad;

namespace SIMANET_W22R.GestionContabilidad.Balance
{
    /// <summary>
    /// Descripción breve de Balance
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Balance : System.Web.Services.WebService
    {
        DataTable dt;
        ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();

        [WebMethod]
        public DataTable BalanceDeComprobacion(string D_MES, string D_PERIODO, string V_CENTRO_OPERATIVO, string V_CUENTA_DESDE, string V_CUENTA_HASTA, string UserName)
        {
            dt = oCtbl.Listar_balance_de_comprobacion(D_MES, D_PERIODO, V_CENTRO_OPERATIVO, V_CUENTA_DESDE, V_CUENTA_HASTA, UserName);
            dt.TableName = "SP_Balance_de_Comprobacion";

            return dt;
        }

        [WebMethod(Description = "2. Balance de Comprobación 3 Digitos")]
        public DataTable Listar_balance_de_comprobacion_3_Digitos(string D_PERIODO, string D_MES, string V_CENTRO_OPERATIVO, string V_CUENTA_DESDE, string V_CUENTA_HASTA, string UserName)
        {
            return oCtbl.Listar_balance_de_comprobacion_3_Digitos(D_PERIODO, D_MES, V_CENTRO_OPERATIVO, V_CUENTA_DESDE, V_CUENTA_HASTA, UserName);
        }

        [WebMethod(Description = "3. Balance a 8 Columnas ( Cta. 2 Digitos)")]
        public DataTable Listar_balance_10_Columnas_2_Digit(string N_CEO, string V_ANIO, string V_MES, string UserName)
        {
            return oCtbl.Listar_balance_10_Columnas_2_Digit(N_CEO, V_ANIO, V_MES, UserName);
        }

        [WebMethod(Description = "4. Balance de Comprobación SUNAT")]
        public DataTable Listar_balance_de_comprobacion_SUNAT(string N_CEO, string V_ANIO, string V_MES, string V_CUENTAINI, string V_CUENTAFIN, string UserName)
        {
            return oCtbl.Listar_balance_de_comprobacion_SUNAT(N_CEO, V_ANIO, V_MES, V_CUENTAINI, V_CUENTAFIN, UserName);
        }

        [WebMethod(Description = "1. Balance de Comprobación PDT")]
        public DataTable Listar_balance_de_comprobacion_p(string D_AÑO, string D_MES, string D_MES_AJUSTE, string UserName)
        {
            return oCtbl.Listar_balance_de_comprobacion_p(D_AÑO, D_MES, D_MES_AJUSTE, UserName);
        }

        [WebMethod(Description = "1. Balance Constructivo MEF Sima Peru S.A.")]
        public DataTable Listar_balance_constructivo_mef(string D_AÑO, string D_MES, string D_MES_AJUSTE, string V_CODCEO, string UserName)
        {
            return oCtbl.Listar_balance_constructivo_mef(D_AÑO, D_MES, D_MES_AJUSTE, V_CODCEO, UserName);
        }

        [WebMethod(Description = "1. Balance de Comprobación SUSALUD")]
        public DataTable Listar_bal_constructivo_susalud(string D_AÑO, string D_MES, string UserName)
        {
            return oCtbl.Listar_bal_constructivo_susalud(D_AÑO, D_MES, UserName);
        }
        [WebMethod(Description = "4. Detalle     - Mayor Auxiliar")]
        public DataTable Listar_MaXAuxi_Pend_Det_Conci(string V_Cuenta, string D_Año, string D_Mes, string V_Relacion_Desde, string V_Relacion_Hasta, string V_Documento, string V_Menos_Subdiario, string UserName)
        {
            return oCtbl.Listar_MaXAuxi_Pend_Det_Conci(V_Cuenta, D_Año, D_Mes, V_Relacion_Desde, V_Relacion_Hasta, V_Documento, V_Menos_Subdiario, UserName);
        }
    }
}
