using SIMANET_W22R.srvGestionLogistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionLogistica.Almacen
{
    /// <summary>
    /// Descripción breve de Almacen
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Almacen : System.Web.Services.WebService
    {
        DataTable dt;
        [WebMethod]
        public DataTable Listar_IngresosAlmacen(string V_CEO, string D_FECHAINI, string D_FECHAFIN, string V_CODALM, string V_CODMAT, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            // Llamar al método y obtener el XML como string
            string xmlData = oLg.Listar_IngresosAlmacen(V_CEO, D_FECHAINI, D_FECHAFIN, V_CODALM, V_CODMAT, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_IngresosAlmacen"];
            return dt;
            /*
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_IngresosAlmacen(V_CEO, D_FECHAINI, D_FECHAFIN, V_CODALM, V_CODMAT, UserName);
            dt.TableName = "SP_IngresosAlmacen";
            return dt;*/
        }
        [WebMethod]
        public DataTable Listar_Ctrolmaterial_consol(string N_CEO, string N_CODMAT, string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Ctrolmaterial_consol(N_CEO, N_CODMAT, D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_CTRLMATERIAL_CONSOL";

            return dt;
        }
        [WebMethod]
        public DataTable Listar_ControlMatTotalxDia(string V_Centro_Operativo, string D_Fecha_Movimiento_Inicial, string D_Fecha_Movimiento_Final, string V_Codigo_Clase_Material, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ControlMatTotalxDia(V_Centro_Operativo, D_Fecha_Movimiento_Inicial, D_Fecha_Movimiento_Final, V_Codigo_Clase_Material, UserName);
            dt.TableName = "SP_ControlMatTotalxDia";

            return dt;
        }
        [WebMethod]
        public DataTable Listar_OC_Locales_Montos_AlmFac(string V_CEO, string V_OC, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OC_Locales_Montos_AlmFac(V_CEO, V_OC, UserName);
            dt.TableName = "SP_OC_Locales_Montos_AlmFac";

            return dt;
        }
        [WebMethod]
        public DataTable Listar_SALDO_HIST_ALMACEN_DETALLE(string Centro_Operativo, string Fecha_de_Proceso, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            // Llamar al método y obtener el XML como string
            string xmlData = oLg.Listar_SALDO_HIST_ALMACEN_DETALLE(Centro_Operativo, Fecha_de_Proceso, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_SALDO_HIST_ALMACEN_DETALLE"];
            return dt;
        }
        [WebMethod]
        public DataTable Listar_KARDEX_UF_EXONERADO(string V_MES, string V_ANIO, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            // Llamar al método y obtener el XML como string
            string xmlData = oLg.Listar_KARDEX_UF_EXONERADO(V_MES, V_ANIO, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_KARDEX_UF_EXONERADO"];
            return dt;
        }
        [WebMethod]
        public DataTable Listar_KARDEX_UF_GRAVADO(string D_Periodo_Saldo, string D_Mes_Periodo, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            // Llamar al método y obtener el XML como string
            string xmlData = oLg.Listar_KARDEX_UF_GRAVADO(D_Periodo_Saldo, D_Mes_Periodo, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_KARDEX_UF_GRAVADO"];
            return dt;
        }
        [WebMethod]
        public DataTable Listar_CTRL_MAT_ALM_OCO(string Fec_inic, string Fec_Final, string Codigo_OT, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_CTRL_MAT_ALM_OCO(Fec_inic, Fec_Final, Codigo_OT, UserName);
            dt.TableName = "SP_CTRL_MAT_ALM_OCO";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_SALDO_HIST_ALMACEN_RESUMEN(string Centro_Operativo, string Fecha_de_Proceso, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            // Llamar al método y obtener el XML como string
            string xmlData = oLg.Listar_SALDO_HIST_ALMACEN_RESUMEN(Centro_Operativo, Fecha_de_Proceso, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_SALDO_HIST_ALMACEN_RESUMEN"];
            return dt;
        }
        [WebMethod]
        public DataTable Listar_CTRLMATERIAL_SINFORMAT(string N_CEO, string N_CODMAT, string D_FECHAINI, string D_FECHAFIN, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_CTRLMATERIAL_SINFORMAT(N_CEO, N_CODMAT, D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_CTRLMATERIAL_SINFORMAT";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_SALDO_ALMACEN_DETALLE(string Centro_Operativo, string Codigo_Clase_Material, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_SALDO_ALMACEN_DETALLE(Centro_Operativo, Codigo_Clase_Material, UserName);
            dt.TableName = "SP_SALDO_ALMACEN_DETALLE";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_SALDO_ALMACEN_RESUMEN(string Centro_Operativo, string Codigo_Clase, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_SALDO_ALMACEN_RESUMEN(Centro_Operativo, Codigo_Clase, UserName);
            dt.TableName = "SP_SALDO_ALMACEN_RESUMEN";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_OcoImpGuias_v1(string ORDEN_COMPRA, string NUMERO_GUIA, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_OcoImpGuias_v1(ORDEN_COMPRA, NUMERO_GUIA, UserName);
            dt.TableName = "SP_OcoImpGuias_v1";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_SALIDAS_DEV_PROV_EMB_V1(string Fecha_Guia, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_SALIDAS_DEV_PROV_EMB_V1(Fecha_Guia, UserName);
            dt.TableName = "SP_SALIDAS_DEV_PROV_EMB_V1";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Vales_Dev_Pqt(string v_CEO, string V_PERIODO, string V_Estado_VDE, string V_Numero_VDE, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            // Llamar al método y obtener el XML como string
            string xmlData = oLg.Listar_Vales_Dev_Pqt(v_CEO, V_PERIODO, V_Estado_VDE, V_Numero_VDE, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds2 = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds2.ReadXml(sr);
            }

            if (ds2 != null)
            {
                if (ds2.Tables.Count > 0)
                {
                    // Extraer el DataTable del DataSet
                    DataTable dt = ds2.Tables["SP_Vales_Dev_Pqt"];

                    if (dt is null)
                    {
                        dt.Columns.Add("descripcion", typeof(string));
                        dt.Rows.Add("Sin datos");
                    }

                }
                else
                {
                    DataTable dt = new DataTable("Error");
                    dt.Columns.Add("descripcion", typeof(string));
                    dt.Rows.Add("Sin datos");

                }

            }


            return dt;
        }

        [WebMethod]
        public DataTable Listar_SaldosAlmacenBalance_Dif(string V_AÑO, string V_MES, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_SaldosAlmacenBalance_Dif(V_AÑO, V_MES, UserName);
            dt.TableName = "SP_SaldosAlmacenBalance_Dif";
            return dt;
        }
    }
}
