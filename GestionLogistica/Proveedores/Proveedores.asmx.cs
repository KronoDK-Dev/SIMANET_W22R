using SIMANET_W22R.srvGestionLogistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionLogistica.Proveedores
{
    /// <summary>
    /// Descripción breve de Proveedores
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Proveedores : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable PDT0601_4TA(string D_FECHAPRO, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_PDT601_4TA(D_FECHAPRO, UserName);
            dt.TableName = "SP_PDT601_4TA";

            return dt;
        }

        [WebMethod]
        public DataTable PDT601_PS4(string D_FECHAPRO, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_PDT601_PS4(D_FECHAPRO, UserName);
            dt.TableName = "SP_PDT601_PS4";

            return dt;
        }

        [WebMethod]
        public DataTable Reg_Retencion_4TA(string D_FECHAPRO, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Reg_Retencion_4TA(D_FECHAPRO, UserName);
            dt.TableName = "SP_Reg_Retencion_4TA";

            return dt;
        }

        [WebMethod]
        public DataTable Salidas_Dev_Prov(string N_CEO, string V_PROCESO, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Salidas_Dev_Prov(N_CEO, V_PROCESO, UserName);
            dt.TableName = "SP_Salidas_Dev_Prov";

            return dt;
        }

        [WebMethod]
        public DataTable ProgramaAdquiEnvioCot(string PROGRAMA_ADQUISICION, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ProgramaAdquiEnvioCot(PROGRAMA_ADQUISICION, UserName);
            dt.TableName = "SP_ProgramaAdquiEnvioCot";

            return dt;
        }

        [WebMethod]
        public DataTable RegistroProveedores(string Fecha_Registro, string Estado, string Tipo, string RUC, string Procedencia, string UserName)
        {
            Estado = Estado.Replace("-1", "");
            Tipo = Tipo.Replace("-1", "");
            RUC = RUC.Replace("-1", "");
            Procedencia = Procedencia.Replace("-1", "");

            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_RegistroProveedores(Fecha_Registro, Estado, Tipo, RUC, Procedencia, UserName);
            dt.TableName = "SP_RegistroProveedores";

            return dt;
        }
    }
}
