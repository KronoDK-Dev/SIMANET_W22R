using SIMANET_W22R.srvGestionContabilidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionContabilidad.Operaciones
{
    /// <summary>
    /// Descripción breve de Operaciones
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Operaciones : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable SubdiarioporCuentaRes(string D_AÑO, string D_MES, string V_CENTRO_OPERATIVO, string V_CUENTA, string V_SUBDIARIO, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_subdiario_por_cuenta_res(D_AÑO, D_MES, V_CENTRO_OPERATIVO, V_CUENTA, V_SUBDIARIO, UserName);
            dt.TableName = "SP_Subdiario_por_Cuenta_Res";

            return dt;
        }

        [WebMethod]
        public DataTable MayorAuxiCanceladasDet(string D_AÑO, string D_MES, string V_CUENTA, string V_DOCUMENTO, string V_RELACION_DESDE, string V_RELACION_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_mayor_auxi_canceladas_det(D_AÑO, D_MES, V_CUENTA, V_DOCUMENTO, V_RELACION_DESDE, V_RELACION_HASTA, UserName);
            dt.TableName = "SP_Mayor_Auxi_Canceladas_Det";

            return dt;
        }

        [WebMethod]
        public DataTable MovCuenta9192(string D_FECHA_DESDE, string D_FECHA_HASTA, string V_CENTRO_OPERATIVO, string V_CUENTA_DESDE,
            string V_CUENTA_HASTA, string V_SUBDIARIO_DESDE, string V_SUBDIARIO_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_mov_cuenta_91_92(D_FECHA_DESDE, D_FECHA_HASTA, V_CENTRO_OPERATIVO, V_CUENTA_DESDE, V_CUENTA_HASTA, V_SUBDIARIO_DESDE, V_SUBDIARIO_HASTA, UserName);
            dt.TableName = "SP_Mov_Cuenta_91_92";

            return dt;
        }

        [WebMethod]
        public DataTable PlanCuentasPCGE2019(string V_CTA_FIN, string V_CTA_INI, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_plan_cuentas_pcge_2019(V_CTA_FIN, V_CTA_INI, UserName);
            dt.TableName = "SP_Plan_Cuentas_PCGE_2019";

            return dt;
        }

        [WebMethod]
        public DataTable MovimientoCuenta96(string D_FECHA_DESDE, string D_FECHA_HASTA, string V_CENTRO_OPERATIVO, string V_CUENTA_DESDE,
            string V_CUENTA_HASTA, string V_SUBDIARIO_DESDE, string V_SUBDIARIO_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_movimiento_cuenta_96(D_FECHA_DESDE, D_FECHA_HASTA, V_CENTRO_OPERATIVO, V_CUENTA_DESDE, V_CUENTA_HASTA,
                V_SUBDIARIO_DESDE, V_SUBDIARIO_HASTA, UserName);
            dt.TableName = "SP_Movimiento_Cuenta_96";

            return dt;
        }

        [WebMethod]
        public DataTable AsientosporSubDiario(string D_DIAFIN, string D_DIAINI, string N_CEO, string V_ANIO, string V_ASIENTOFIN, string V_ASIENTOINI, string V_CENTROFIN,
            string V_CENTROINI, string V_CUENTAFIN, string V_CUENTAINI, string V_MES, string V_SUBDIARIO, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_asientos_por_subdiario(D_DIAFIN, D_DIAINI, N_CEO, V_ANIO, V_ASIENTOFIN, V_ASIENTOINI, V_CENTROFIN, V_CENTROINI,
                V_CUENTAFIN, V_CUENTAINI, V_MES, V_SUBDIARIO, UserName);
            dt.TableName = "SP_Asientos_por_SubDiario";

            return dt;
        }

        [WebMethod]
        public DataTable MayorAuxiDocResu(string D_AÑO, string D_MES, string V_CUENTA_DESDE, string V_CUENTA_HASTA, string V_RELACION_DESDE,
            string V_RELACION_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_mayor_auxi_doc_resu(D_AÑO, D_MES, V_CUENTA_DESDE, V_CUENTA_HASTA, V_RELACION_DESDE, V_RELACION_HASTA, UserName);
            dt.TableName = "SP_Mayor_Auxi_Doc_Resu";

            return dt;
        }

        [WebMethod]
        public DataTable MovimientoCuenta97(string D_FECHA_DESDE, string D_FECHA_HASTA, string V_CENTRO_OPERATIVO, string V_CUENTA_DESDE,
            string V_CUENTA_HASTA, string V_SUBDIARIO_DESDE, string V_SUBDIARIO_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_movimiento_cuenta_97(D_FECHA_DESDE, D_FECHA_HASTA, V_CENTRO_OPERATIVO, V_CUENTA_DESDE, V_CUENTA_HASTA,
                V_SUBDIARIO_DESDE, V_SUBDIARIO_HASTA, UserName);
            dt.TableName = "SP_Movimiento_Cuenta_97";

            return dt;
        }

        [WebMethod]
        public DataTable MayorAuxiPendDocRes(string D_AÑO, string D_MES, string V_CUENTA, string V_RELACION_DESDE, string V_RELACION_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_mayor_auxi_pend_doc_res(D_AÑO, D_MES, V_CUENTA, V_RELACION_DESDE, V_RELACION_HASTA, UserName);
            dt.TableName = "SP_Mayor_Auxi_Pend_Doc_Res";

            return dt;
        }

        [WebMethod]
        public DataTable MayorAuxiliarDetalle(string D_AÑO, string D_MES, string V_CUENTA_DESDE, string V_CUENTA_HASTA, string V_RELACION_DESDE,
            string V_RELACION_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_mayor_auxiliar_detalle(D_AÑO, D_MES, V_CUENTA_DESDE, V_CUENTA_HASTA, V_RELACION_DESDE, V_RELACION_HASTA, UserName);
            dt.TableName = "SP_Mayor_Auxiliar_Detalle";

            return dt;
        }

        [WebMethod]
        public DataTable MovimientoporCuenta(string D_FECHA_DESDE, string D_FECHA_HASTA, string V_CENTRO_OPERATIVO, string V_CUENTA_DESDE,
            string V_CUENTA_HASTA, string V_SUBDIARIO_DESDE, string V_SUBDIARIO_HASTA, string V_CC, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_movimiento_por_cuenta(D_FECHA_DESDE, D_FECHA_HASTA, V_CENTRO_OPERATIVO, V_CUENTA_DESDE, V_CUENTA_HASTA,
                V_SUBDIARIO_DESDE, V_SUBDIARIO_HASTA, V_CC, UserName);
            dt.TableName = "SP_Movimiento_por_Cuenta";

            return dt;
        }

        [WebMethod]
        public DataTable MovimientoporCuenta2(string D_FECHA_DESDE, string D_FECHA_HASTA, string V_CENTRO_OPERATIVO, string V_CUENTA_DESDE,
            string V_CUENTA_HASTA, string V_SUBDIARIO_DESDE, string V_SUBDIARIO_HASTA, string V_CC, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            // Llamar al método y obtener el XML como string
            string xmlData = oCtbl.Listar_movimiento_por_cuenta2(D_FECHA_DESDE, D_FECHA_HASTA, V_CENTRO_OPERATIVO, V_CUENTA_DESDE, V_CUENTA_HASTA,
                V_SUBDIARIO_DESDE, V_SUBDIARIO_HASTA, V_CC, UserName);

            // Crear un DataSet y cargar el XML
            DataSet ds = new DataSet();
            using (StringReader sr = new StringReader(xmlData))
            {
                ds.ReadXml(sr);
            }

            // Extraer el DataTable del DataSet
            DataTable dt = ds.Tables["SP_Movimiento_por_Cuenta"];

            return dt;
        }


        [WebMethod]
        public DataTable Listar_mayor_auxi_cuenta_resumen(string D_AÑO, string D_MES, string V_CUENTA_DESDE, string V_CUENTA_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_mayor_auxi_cuenta_resumen(D_AÑO, D_MES, V_CUENTA_DESDE, V_CUENTA_HASTA, UserName);
            dt.TableName = "SP_Mayor_Auxi_Cuenta_Resumen";

            return dt;
        }
        [WebMethod]
        public DataTable Listar_mayor_auxi_Rela_Resu(string D_AÑO, string D_MES, string V_CUENTA_DESDE, string V_CUENTA_HASTA, string V_RELACION_DESDE, string V_RELACION_HASTA, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_mayor_auxi_Rela_Resu(D_AÑO, D_MES, V_CUENTA_DESDE, V_CUENTA_HASTA, V_RELACION_DESDE, V_RELACION_HASTA, UserName);
            dt.TableName = "SP_Mayor_Auxi_Rela_Resu";

            return dt;
        }


        [WebMethod]
        public DataTable MayorAuxiliarPendDeta(string D_AÑO, string D_MES, string V_CUENTA, string V_DOCUMENTO, string V_RELACION, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_mayor_auxiliar_pend_deta(D_AÑO, D_MES, V_CUENTA, V_DOCUMENTO, V_RELACION, UserName);
            dt.TableName = "SP_Mayor_Auxiliar_Pend_Deta";

            return dt;
        }

        [WebMethod]
        public DataTable AsientosporSubDiario020(string D_DIAFIN, string D_DIAINI, string N_CEO, string V_ANIO, string V_ASIENTOFIN, string V_ASIENTOINI, string V_CENTROFIN,
            string V_CENTROINI, string V_CODDIV, string V_CUENTAFIN, string V_CUENTAINI, string V_MES, string V_NROOTS, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_asientos_por_subdiario_02(D_DIAFIN, D_DIAINI, N_CEO, V_ANIO, V_ASIENTOFIN, V_ASIENTOINI, V_CENTROFIN, V_CENTROINI, V_CODDIV,
                V_CUENTAFIN, V_CUENTAINI, V_MES, V_NROOTS, UserName);
            dt.TableName = "SP_Asientos_por_SubDiario_020";

            return dt;
        }

        [WebMethod]
        public DataTable AsientosSubDiarioResuCC(string D_DIAFIN, string D_DIAINI, string N_CEO, string V_ANIO, string V_ASIENTOFIN, string V_ASIENTOINI, string V_CENTROFIN,
            string V_CENTROINI, string V_CUENTAFIN, string V_CUENTAINI, string V_MES, string V_SUBDIARIO, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_asientos_subdiario_resu_c(D_DIAFIN, D_DIAINI, N_CEO, V_ANIO, V_ASIENTOFIN, V_ASIENTOINI, V_CENTROFIN, V_CENTROINI, V_CUENTAFIN, V_CUENTAINI, V_MES, V_SUBDIARIO, UserName);
            dt.TableName = "SP_Asientos_SubDiario_Resu_CC";

            return dt;
        }

        [WebMethod]
        public DataTable TabuladoporSubdiarios(string V_ANIO, string V_CUENTA, string V_MES, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_tabulado_por_subdiarios(V_ANIO, V_CUENTA, V_MES, UserName);
            dt.TableName = "SP_Tabulado_por_Subdiarios";

            return dt;
        }
    }
}
