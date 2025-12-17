using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using EasyControlWeb;
using SIMANET_W22R.srvGestionPresupuesto;

namespace SIMANET_W22R.GestionPresupuesto.Ordenes
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
        string s_Ambiente = EasyUtilitario.Helper.Configuracion.Leer("Seguridad", "Ambiente");

        [WebMethod]
        public DataTable Listar_Cheques_por_OC_OS(string V_Centro_Operativo, string D_Año, string D_Mes,
            string V_Origen, string UserName)
        {
            PresupuestoSoapClient oPP = new PresupuestoSoapClient();
            dt = oPP.Listar_Cheques_por_OC_OS(V_Centro_Operativo, D_Año, D_Mes,
                V_Origen, UserName);
            dt.TableName = "SP_Cheques_por_OC_OS";
            return dt;
        }
    }
}
