using SIMANET_W22R.srvGestionProduccion;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProduccion.Materiales
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
        public DataTable ListaMateriales(string V_CODDIV, string V_NROVAL, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_lista_materiales(V_CODDIV, V_NROVAL, UserName);
            dt.TableName = "SP_Lista_Materiales";
            return dt;
        }
        [WebMethod]
        public DataTable ListaMaterialesTest(string V_CODDIV, string V_NROVAL, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_materiales_test(V_CODDIV, V_NROVAL, UserName);
            dt.TableName = "SP_Lista_Materiales_test";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Saldo_Valorizado_Material(string N_CEO, string V_ANIO, string V_MES, string UserName)
        {
            ProduccionSoapClient oPD = new ProduccionSoapClient();
            dt = oPD.Listar_Saldo_Valorizado_Material(N_CEO, V_ANIO, V_MES, UserName);
            dt.TableName = "SP_Saldo_Valorizado_Material";
            return dt;
        }
    }
}
