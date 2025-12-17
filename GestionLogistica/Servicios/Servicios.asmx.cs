using SIMANET_W22R.srvGestionLogistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionLogistica.Servicios
{
    /// <summary>
    /// Descripción breve de Servicios
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Servicios : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Catalogo_Servicios_SR(string CLASE, string UserName)
        {

            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Catalogo_Servicios_SR(CLASE, UserName);
            dt.TableName = "SP_Catalogo_Servicios_SR";

            return dt;
        }

        [WebMethod]
        public DataTable Listar_DET_G_PRY_OT_SER_PCI(string Centro_Operativo, string Division, string Proyecto, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_DET_G_PRY_OT_SER_PCI(Centro_Operativo, Division, Proyecto, UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_SER_PCI";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_DET_G_PRY_OT_SER_PCI2(string Centro_Operativo, string Division, string Proyecto, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            string xmlData = oLg.Listar_DET_G_PRY_OT_SER_PCI2(Centro_Operativo, Division, Proyecto, UserName);
            DataSet ds = new DataSet();  // Crear un DataSet y cargar el XML
            using (StringReader sr = new StringReader(xmlData))
            { ds.ReadXml(sr); }
            DataTable dt = ds.Tables["SP_DET_GASTO_PRY_OT_SER_PCI"];              // Extraer el DataTable del DataSet

            return dt;


        }

        [WebMethod]
        public DataTable Listar_OS_DETALLE_OTS(string s_fecha_ini, string s_fecha_fin, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OS_DETALLE_OTS(s_fecha_ini, s_fecha_fin, UserName);
            dt.TableName = "SP_OS_DETALLE_OTS";
            return dt;
        }
    }
}
