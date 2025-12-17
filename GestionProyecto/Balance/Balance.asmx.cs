using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionProyecto;
using System.Data;


namespace SIMANET_W22R.GestionProyecto.Balance
{
    /// <summary>
    /// Descripción breve de Balance
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Balance : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_comparventvscostoproyecotR(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PERIODO, string V_PROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_comparventvscostoproyecot( V_CENTRO_OPERATIVO,  V_DIVISION,  V_PERIODO,  V_PROYECTO,  UserName);
            dt.TableName = "SP_ComparVentvsCostoProyecotR";
            return dt;
        }
        
        [WebMethod]
        public DataTable Listar_comparventvscostoproyec_ot(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PERIODO, string V_PROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_comparventvscostoproyec_ot(V_CENTRO_OPERATIVO,V_DIVISION,V_PERIODO,V_PROYECTO,UserName);
            dt.TableName = "SP_ComparVentvsCostoProyec_ot";
            return dt;
        }
        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }
    }
}
