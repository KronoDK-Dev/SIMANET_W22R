using SIMANET_W22R.srvGestionContabilidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionContabilidad.Estados
{
    /// <summary>
    /// Descripción breve de Estados
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Estados : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable AnalisisCuentasNat(string D_AÑO, string D_MES_DESDE, string D_MES_HASTA, string V_CENTRO_OPERATIVO, string V_CTA_MAYOR_DESDE,
            string V_CTA_MAYOR_HASTA, string V_C_COSTO_DESDE, string V_C_COSTO_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_analisis_cuentas_nat(D_AÑO, D_MES_DESDE, D_MES_HASTA, V_CENTRO_OPERATIVO, V_CTA_MAYOR_DESDE,
                V_CTA_MAYOR_HASTA, V_C_COSTO_DESDE, V_C_COSTO_HASTA, UserName);
            dt.TableName = "SP_Analisis_Cuentas_Nat";

            return dt;
        }

        [WebMethod]
        public DataTable EstadoDelProceso(string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_Estado_del_Proceso(UserName);
            dt.TableName = "SP_Estado_del_Proceso";

            return dt;
        }

        [WebMethod]
        public DataTable MaXAuxiliarPendCuentaRes(string V_Cuenta_Desde, string V_Cuenta_Hasta, string D_Año, string D_Mes, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_Mayor_Auxiliar_Pendientes_por_Cuenta_Resumen(V_Cuenta_Desde, V_Cuenta_Hasta, D_Año, D_Mes, UserName);
            dt.TableName = "SP_MaXAuxiliar_PendCuenta_Res";

            return dt;
        }

        [WebMethod]
        public DataTable ConciBancariaResumen(string D_AÑO, string D_MES, string V_COD_BCO, string V_CUENTA_CORRIENTE, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_conci_bancaria_resumen(D_AÑO, D_MES, V_COD_BCO, V_CUENTA_CORRIENTE, UserName);
            dt.TableName = "SP_Conci_Bancaria_Resumen";

            return dt;
        }

        [WebMethod]
        public DataTable MayorAuxiPendRelRes(string D_AÑO, string D_MES, string V_CUENTA, string V_RELACION_DESDE, string V_RELACION_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_mayor_auxi_pend_rel_res(D_AÑO, D_MES, V_CUENTA, V_RELACION_DESDE, V_RELACION_HASTA, UserName);
            dt.TableName = "SP_Mayor_Auxi_Pend_Rel_Res";

            return dt;
        }
    }
}
