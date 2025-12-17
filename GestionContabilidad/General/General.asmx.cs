using SIMANET_W22R.srvGestionContabilidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionContabilidad.General
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
        public DataTable CentrosdeCosto(string V_CENTRO_OPERATIVO, string V_GRUPO_CC_DESDE, string V_GRUPO_CC_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_centros_de_costo(V_CENTRO_OPERATIVO, V_GRUPO_CC_DESDE, V_GRUPO_CC_HASTA, UserName);
            dt.TableName = "SP_Centros_de_Costo";

            return dt;
        }

        [WebMethod]
        public DataTable TipodeCambio(string V_ANIO, string V_CODMND, string V_MESFIN, string V_MESINI, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_tipo_de_cambio(V_ANIO, V_CODMND, V_MESFIN, V_MESINI, UserName);
            dt.TableName = "SP_Tipo_de_Cambio";

            return dt;
        }
    }
}
