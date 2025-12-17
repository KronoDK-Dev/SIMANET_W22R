using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionFinanciera;

namespace SIMANET_W22R.GestionFinanciera
{
    /// <summary>
    /// Descripción breve de EstadosFinancieros
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class EstadosFinancieros : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable GenRptAnexosFinanciero(int IdFormato, int Periodo, string RangoMes, int IdUsuario,
            string UserName)
        {
            ReportesSoapClient rp = new ReportesSoapClient();
            dt = rp.GenRptAnexosFinanciero(IdFormato, Periodo, "06,07", IdUsuario, UserName);
            dt.TableName = "NQ_SP_RepMeses";
            return dt;
        }
    }
}
