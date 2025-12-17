using SIMANET_W22R.srvGestionLogistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionLogistica.General
{
    /// <summary>
    /// Descripción breve de General
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class General : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable EquivalenciasGenericas(string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_TG_EQUIVALENICIASGENERICAS(UserName);
            dt.TableName = "SP_TG_EQUIVALENICIASGENERICAS";

            return dt;
        }

        [WebMethod]
        public DataTable EquivalenciasXMaterial(string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_TG_EQUIVALENICIASPORMATERIA(UserName);
            dt.TableName = "SP_TG_EQUIVALENICIASPORMATERIA";

            return dt;
        }

        [WebMethod]
        public DataTable UnidadesMedida(string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Tg_Unidad_Medida(UserName);
            dt.TableName = "SP_Tg_Unidad_Medida";

            return dt;
        }
        [WebMethod]
        public DataTable UnidadesMedida2(string unidad, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Tg_Unidad_Medida2(unidad, UserName);
            dt.TableName = "SP_Tg_Unidad_Medida2";

            return dt;
        }
    }
}
