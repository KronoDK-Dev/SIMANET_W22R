using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionProduccion;

namespace SIMANET_W22R.GestionProduccion.General
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
        public DataTable TarifaMaq(string V_TALLER, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_tarifa_maq(V_TALLER, UserName);
            dt.TableName = "SP_tarifa_maq";
            return dt;
        }
    }
}
