using SIMANET_W22R.srvGestionCostos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionCostos.Ventas
{
    /// <summary>
    /// Descripción breve de Ventas
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Ventas : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_Ventas_diferidas_x_OT_detalle(string V_PERIODO, string V_CENTRO_OPERATIVO, string V_DIVISION, string UserName)
        {
            CostosSoapClient oP = new CostosSoapClient();
            dt = oP.Listar_Ventas_diferidas_x_OT_detalle(V_PERIODO, V_CENTRO_OPERATIVO, V_DIVISION, UserName);
            dt.TableName = "SP_Ventas_DifeLineaNegocioDet";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_Ventas_diferidas_x_Doc_detalle(string V_PERIODO, string V_CENTRO_OPERATIVO, string V_DIVISION, string UserName)
        {
            CostosSoapClient oP = new CostosSoapClient();
            dt = oP.Listar_Ventas_diferidas_x_Doc_detalle(V_PERIODO, V_CENTRO_OPERATIVO, V_DIVISION, UserName);
            dt.TableName = "SP_Ventas_Dife_LineaNeg_OT_Doc";
            return dt;
        }
    }
}
