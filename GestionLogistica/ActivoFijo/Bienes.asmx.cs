using SIMANET_W22R.srvGestionLogistica;
using SIMANET_W22R.srvLog_ActivoFijo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionLogistica.ActivoFijo
{
    /// <summary>
    /// Descripción breve de Bienes
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Bienes : System.Web.Services.WebService
    {
        DataTable dt;
        [System.Web.Services.WebMethod]
        public DataTable BienesInventario(string CODEMP, string NRO_PR, string CCO_INI, string CCO_FIN, string UserName)
        {
            ActivoFijoSoapClient oAF = new ActivoFijoSoapClient();
            dt = oAF.Lista_Bienes_toma_inventario(CODEMP, NRO_PR, CCO_INI, CCO_FIN, UserName);
            //dt.TableName = "PKG_ACTIVO_FIJO.SP_BIENES_TOMA_INVENTARIO;1";
            dt.TableName = "SP_BIENES_TOMA_INVENTARIO";

            return dt;
        }

        [WebMethod]
        public DataTable BienesAlmacenados(string V_CLASE_MATERIAL, string D_FECHA_ALMACENAMIENTO_inicial,
            string D_FECHA_ALMACENAMIENTO_fina, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_BienesAlmacenados(V_CLASE_MATERIAL, D_FECHA_ALMACENAMIENTO_inicial,
                D_FECHA_ALMACENAMIENTO_fina, UserName);
            dt.TableName = "SP_BienesAlmacenados";

            return dt;
        }
    }
}
