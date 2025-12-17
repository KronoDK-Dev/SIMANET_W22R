using SIMANET_W22R.srvGestionProduccion;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProduccion.Ordenes
{
    /// <summary>
    /// Descripción breve de Ordenes
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Ordenes : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable DetalleGastoPryOsesu(string N_CEO, string V_CODDIV, string V_CODPRY, string V_NROOTS, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_detalle_gasto_pry_ot_oses(N_CEO, V_CODDIV, V_CODPRY, V_NROOTS, UserName);
            dt.TableName = "SP_DETALLE_GASTO_PRY_OT_OSESU";
            return dt;
        }
        [WebMethod]
        public DataTable DetalleGastoPryOtOcosu(string V_CENTRO_OPERATIVO, string V_DIVISIÓN, string V_NROOTS, string V_PROYECTO, string V_ANIO, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_det_gasto_pry_ot_ocosu(V_CENTRO_OPERATIVO, V_DIVISIÓN, V_NROOTS, V_PROYECTO, V_ANIO, UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_OCOSU";
            return dt;
        }
        [WebMethod]
        public DataTable OtOcompra(string D_FECHA_INICIO, string D_FECHA_FIN, string V_DIVISION, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_ot_ocompra(D_FECHA_INICIO, D_FECHA_FIN, V_DIVISION, UserName);
            dt.TableName = "SP_Ot_OCompra";
            return dt;
        }
    }
}
