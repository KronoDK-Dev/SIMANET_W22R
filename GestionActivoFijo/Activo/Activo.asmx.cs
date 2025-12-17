using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvLog_ActivoFijo;

namespace SIMANET_W22R.GestionActivoFijo.Activo
{
    /// <summary>
    /// Descripción breve de Activo
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Activo : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_inventario_activosxccrsm(string CCOSTO1, string CCOSTO2, string COD_EMPE, string TIPOACTV, string UserName)
        {
            ActivoFijoSoapClient oC = new ActivoFijoSoapClient();
            dt = oC.Listar_inventario_activosxccrsm(CCOSTO1, CCOSTO2, COD_EMPE, TIPOACTV, UserName);
            dt.TableName = "SP_Inventario_ActivosxCCRSM";
            return dt;
        }
    }
}
