using SIMANET_W22R.srvGestionLogistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionLogistica.Proyectos
{
    /// <summary>
    /// Descripción breve de Proyectos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Proyectos : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable PRY_PAG_TOT(string Centro_Operativo, string división, string Proyecto, string Nro_Orden, string Procedencia, string Tipo_Orden, string UserName)
        {
            Procedencia = Procedencia.Replace("-1", "");
            Tipo_Orden = Tipo_Orden.Replace("-1", "");

            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_PRY_PAG_TOT(Centro_Operativo, división, Proyecto, Nro_Orden, Procedencia, Tipo_Orden, UserName);
            dt.TableName = "SP_PRY_PAG_TOT";

            return dt;
        }
    }
}
