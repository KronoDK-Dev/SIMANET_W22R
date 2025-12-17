using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionProyecto;
using System.Data;

namespace SIMANET_W22R.GestionProyecto.Facturacion
{
    /// <summary>
    /// Descripción breve de Facturacion
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Facturacion : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_detalle_gasto_pry_ot_fac(string N_CEO, string V_CODDIV, string V_CODPRY, string V_PERIODO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_detalle_gasto_pry_ot_fac(N_CEO,V_CODDIV,V_CODPRY,V_PERIODO,UserName);
            dt.TableName = "SP_Detalle_Gasto_Pry_OT_Fac";
            return dt;
        }

        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }
    }
}
