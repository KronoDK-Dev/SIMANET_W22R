using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionCostos;

namespace SIMANET_W22R.GestionCostos.Pagos
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
        public DataTable Listar_analisis_gastos_ccnatudet(string D_AÑO_DE_PROCESO, string D_MES_DE_PROCESO, string V_CENTRO_OPERATIVO, string V_CUENTA_MAYOR, string UserName)
        {
            CostosSoapClient oP = new CostosSoapClient();
            dt = oP.Listar_analisis_gastos_ccnatudet(D_AÑO_DE_PROCESO, D_MES_DE_PROCESO, V_CENTRO_OPERATIVO, V_CUENTA_MAYOR, UserName);
            dt.TableName = "SP_Analisis_Gastos_CCNatuDet";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_analisis_gast_itemsasient(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_NUMERO_OT, string UserName)
        {
            CostosSoapClient oP = new CostosSoapClient();
            dt = oP.Listar_analisis_gast_itemsasient(V_CENTRO_OPERATIVO, V_DIVISION, V_NUMERO_OT, UserName);
            dt.TableName = "SP_Analisis_Gast_itemsAsientOT";
            return dt;
        }
    }
}
