using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionCostos;

namespace SIMANET_W22R.GestionCostos.Costos
{
    /// <summary>
    /// Descripción breve de Costos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Costos : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_costo_prod_linea_neg_resu(string D_AÑO, string D_MES, string V_CENTRO_OPERATIVO, string V_LINEA_NEGOCIO, string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_costo_prod_linea_neg_resu(D_AÑO, D_MES, V_CENTRO_OPERATIVO, V_LINEA_NEGOCIO, UserName);
            dt.TableName = "SP_COSTO_PROD_LINEA_NEG_RESU";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_costo_prod_linea_neg_det(string V_CENTRO_OPERATIVO, string V_LINEA_NEGOCIO, string D_AÑO, string D_MES, string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_costo_prod_linea_neg_det(D_AÑO, D_MES, V_CENTRO_OPERATIVO, V_LINEA_NEGOCIO, UserName);
            dt.TableName = "SP_Costo_Prod_Linea_Neg_Det";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_ManoObra_ImprodNatuG_Det(string V_Centro_Operativo, string D_Año_de_Proceso,
            string D_Mes, string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_ManoObra_ImprodNatuG_Det(V_Centro_Operativo, D_Año_de_Proceso,
            D_Mes, UserName);
            dt.TableName = "SP_ManoObra_ImprodNatuG_Det";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_Costo_Prod_Linea_Neg_Det(string D_Año, string D_Mes, string V_Centro_Operativo,
            string V_Linea_Negocio, string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_Costo_Prod_Linea_Neg_Det1(D_Año, D_Mes, V_Centro_Operativo,
            V_Linea_Negocio, UserName);
            dt.TableName = "SP_Costo_Prod_Linea_Neg_Det";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_Costo_VentasLineaNegocioRes(string V_Centro_Operativo, string D_Año, string D_Mes,
            string V_Linea_Negocio, string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_Costo_VentasLineaNegocioRes(V_Centro_Operativo, D_Año, D_Mes,
            V_Linea_Negocio, UserName);
            dt.TableName = "SP_Costo_VentasLineaNegocioRes";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_CostPro_por_Linea_Neg_R(string Centro_Operativo, string Periodo, string Linea_Negocio,
            string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_CostPro_por_Linea_Neg_R(Centro_Operativo, Periodo, Linea_Negocio,
            UserName);
            dt.TableName = "SP_CostPro_por_Linea_Neg_R";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_CostPro_por_Linea_Neg_D(string Centro_Operativo, string Periodo, string Linea_Negocio,
            string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_CostPro_por_Linea_Neg_D(Centro_Operativo, Periodo, Linea_Negocio,
            UserName);
            dt.TableName = "SP_CostPro_por_Linea_Neg_D";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_Hors_HombreNormalUtili_Divi(string V_Centro_Operativo, string D_Año, string D_Mes,
            string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_Hors_HombreNormalUtili_Divi(V_Centro_Operativo, D_Año, D_Mes, UserName);
            dt.TableName = "SP_Hors_HombreNormalUtili_Divi";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Distri_Costo_Grup_Resu(string V_Centro_Operativo, string D_Año, string D_Mes,
           string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_Distri_Costo_Grup_Resu(V_Centro_Operativo, D_Año, D_Mes, UserName);
            dt.TableName = "SP_Distri_Costo_Grup_Resu";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Distri_Costo_Grup_CC_Det(string V_Centro_Operativo, string D_Año, string D_Mes, string V_Grupo_CC_Desde, string V_Grupo_CC_Hasta,
          string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_Distri_Costo_Grup_CC_Det(V_Centro_Operativo, D_Año, D_Mes, V_Grupo_CC_Desde, V_Grupo_CC_Hasta, UserName);
            dt.TableName = "SP_Distri_Costo_Grup_CC_Det";
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Mano_Obra_Directa_Div_Det(string V_Centro_Operativo, string D_Año, string D_Mes, string V_Division_Inicial, string V_Division_Final,
        string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();
            dt = oC.Listar_Mano_Obra_Directa_Div_Det(V_Centro_Operativo, D_Año, D_Mes, V_Division_Inicial, V_Division_Final, UserName);
            dt.TableName = "SP_Mano_Obra_Directa_Div_Det";
            return dt;
        }


        [WebMethod]
        public DataTable Listar_CostosDirectos_OT_CC(string V_Centro_Operativo, string v_Anio, string v_Mes, string V_Linea_Neg, string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();

            if (V_Linea_Neg == "-1")
            {
                V_Linea_Neg = "";
            }

            DataTable dt = new DataTable("SP_CostosDirectos_OT_CC");
            // Llamar al método y obtener el XML como string
            string xmlData = oC.Listar_CostosDirectos_OT_CC(V_Centro_Operativo, v_Anio, v_Mes, V_Linea_Neg, UserName);


            // Crear un DataSet y cargar el XML
            DataSet ds2 = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds2.ReadXml(sr);
            }

            if (ds2 != null) // existen datos
            {
                if (ds2.Tables.Count > 0)
                {
                    // Extraer el DataTable del DataSet
                    DataTable dt1 = ds2.Tables["SP_CostosDirectos_OT_CC"];

                    if (dt1 is null) // si no tiene datos, cargamos mensaje
                    {
                        dt1.Columns.Add("descripcion", typeof(string));
                        dt1.Rows.Add("Sin datos");
                    }
                    dt = dt1;
                }
                else // si no existen tablas
                {
                    DataTable dt2 = new DataTable("Error");
                    dt2.Columns.Add("descripcion", typeof(string));
                    dt2.Rows.Add("Sin datos");
                    dt = dt2;

                }

            }

            // retornamos el data table
            return dt;
        }
        [WebMethod]
        public DataTable Listar_Materiales_en_Proyectos(string V_Centro_Operativo, string v_materiales, string UserName)
        {
            CostosSoapClient oC = new CostosSoapClient();


            DataTable dt = new DataTable("SP_MATERIAL_EN_PROYECTO");
            // Llamar al método y obtener el XML como string
            string xmlData = oC.Listar_Materiales_en_Proyectos(V_Centro_Operativo, v_materiales, UserName);


            // Crear un DataSet y cargar el XML
            DataSet ds2 = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds2.ReadXml(sr);
            }

            if (ds2 != null) // existen datos
            {
                if (ds2.Tables.Count > 0)
                {
                    // Extraer el DataTable del DataSet
                    DataTable dt1 = ds2.Tables["SP_MATERIAL_EN_PROYECTO"];

                    if (dt1 is null) // si no tiene datos, cargamos mensaje
                    {
                        dt1.Columns.Add("descripcion", typeof(string));
                        dt1.Rows.Add("Sin datos");
                    }
                    dt = dt1;
                }
                else // si no existen tablas
                {
                    DataTable dt2 = new DataTable("Error");
                    dt2.Columns.Add("descripcion", typeof(string));
                    dt2.Rows.Add("Sin datos");
                    dt = dt2;

                }

            }

            // retornamos el data table
            return dt;
        }
    }
}
