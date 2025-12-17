using SIMANET_W22R.srvGestionContabilidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionContabilidad.Cobros
{
    /// <summary>
    /// Descripción breve de Cobros
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Cobros : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_registro_de_ventas(string D_AÑO, string D_MES, string V_CENTRO_OPERATIVO, string V_CONCEPTO, string V_LINEA_NEGOCIO, string V_ORIGEN, string V_SERIE, string V_TIPO_DOCUMENTO, string UserName)
        {
            ContabilidadSoapClient ts = new ContabilidadSoapClient();
            dt = ts.Listar_registro_de_ventas(D_AÑO, D_MES, V_CENTRO_OPERATIVO, V_CONCEPTO, V_LINEA_NEGOCIO, V_ORIGEN, V_SERIE, V_TIPO_DOCUMENTO, UserName);
            dt.TableName = "SP_Registro_de_Ventas";
            return dt;
        }
    }
}
