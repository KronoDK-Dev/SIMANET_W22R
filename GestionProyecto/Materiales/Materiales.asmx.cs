using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionProyecto;
using System.Data;

namespace SIMANET_W22R.GestionProyecto.Materiales
{
    /// <summary>
    /// Descripción breve de Materiales
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Materiales : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_det_gasto_pry_ot_uti(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_det_gasto_pry_ot_uti(V_CENTRO_OPERATIVO,V_DIVISION,V_PROYECTO,UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_UTI";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_det_gasto_pry_ot_vsm(string V_CENTRO_OPERATIVO, string V_DIVISIÓN, string V_PROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_det_gasto_pry_ot_vsm( V_CENTRO_OPERATIVO,V_DIVISIÓN,V_PROYECTO,UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_VSM";
            return dt;
        }
        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }
    }
}
