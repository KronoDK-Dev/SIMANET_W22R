using SIMANET_W22R.srvGestionTesoreria;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionTesoreria.Balance
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
        public DataTable Listar_libro_banco(string D_AÑO, string D_MES, string V_BANCO, string V_CENTRO_OPERATIVO, string V_CUENTA_CORRIENTE, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_libro_banco(D_AÑO, D_MES, V_BANCO, V_CENTRO_OPERATIVO, V_CUENTA_CORRIENTE, UserName);
            dt.TableName = "SP_Libro_Banco";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_conciliacion_banc_cartola(string V_CENTRO_OPERATIVO, string D_AÑO, string D_MES, string V_CARTOLA, string V_MONEDA, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_conciliacion_banc_cartola(D_AÑO, D_MES, V_CARTOLA, V_CENTRO_OPERATIVO, V_MONEDA, UserName);
            dt.TableName = "SP_Conciliacion_Banc_Cartola";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_conci_banc_r_cartola_conc(string D_AÑO, string D_MES, string V_CARTOLA, string V_CENTRO_OPERATIVO, string V_MONEDA, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_conci_banc_r_cartola_conc(D_AÑO, D_MES, V_CARTOLA, V_CENTRO_OPERATIVO, V_MONEDA, UserName);
            dt.TableName = "SP_ConcI_Banc_R_Cartola_Conci";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_conci_bancaria_res_cartol(string V_CENTRO_OPERATIVO, string D_AÑO, string D_MES, string V_CARTOLA, string V_MONEDA, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_conci_bancaria_res_cartol(D_AÑO, D_MES, V_CARTOLA, V_CENTRO_OPERATIVO, V_MONEDA, UserName);
            dt.TableName = "SP_Conci_Bancaria_Res_Cartola";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_detalle_ffj_gf(string D_AÑO, string V_LIQUIDACION, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_detalle_ffj_gf(D_AÑO, V_LIQUIDACION, UserName);
            dt.TableName = "SP_Detalle_FFJ_GF";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_res_ffj_x_centro_costos(string D_AÑO, string V_LIQUIDACION, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_res_ffj_x_centro_costos(D_AÑO, V_LIQUIDACION, UserName);
            dt.TableName = "SP_Res_FFJ_X_Centro_Costos";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_cheques_egresos_directos(string D_AÑO, string D_MES_DESDE, string D_MES_HASTA, string V_CENTRO_OPERATIVO, string V_MONEDA, string V_TIPO_DE_OPERACION, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_cheques_egresos_directos(D_AÑO, D_MES_DESDE, D_MES_HASTA, V_CENTRO_OPERATIVO, V_MONEDA, V_TIPO_DE_OPERACION, UserName);
            dt.TableName = "SP_Cheques_Egresos_Directos";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Estado_Cuenta_Doc_Elect(string V_Centro_Operativo, string V_Documento, string V_Nro_de_Serie, string V_Nro_Correlativo, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_Estado_Cuenta_Doc_Elect(V_Centro_Operativo, V_Documento, V_Nro_de_Serie, V_Nro_Correlativo, UserName);
            dt.TableName = "SP_Estado_Cuenta_Doc_Elect";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Estado_de_Cuenta_por_Doc(string V_Centro_Operativo, string V_Documento, string V_Nro_de_Serie, string V_Nro_Correlativo, string UserName)
        {
            TesoreriaSoapClient ts = new TesoreriaSoapClient();
            dt = ts.Listar_Estado_de_Cuenta_por_Doc(V_Centro_Operativo, V_Documento, V_Nro_de_Serie, V_Nro_Correlativo, UserName);
            dt.TableName = "SP_Estado_de_Cuenta_por_Doc";
            return dt;
        }
    }
}
