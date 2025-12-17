using SIMANET_W22R.srvGestionLogistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionLogistica.Materiales
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
        public DataTable ConsumoAnualMateriales(string N_CEO, string PERIODO, string TIPO, string CLASIFICACION, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ConsumoAnualMateriales(N_CEO, PERIODO, TIPO, CLASIFICACION, UserName);
            //dt.TableName = "PKG_ACTIVO_FIJO.SP_BIENES_TOMA_INVENTARIO;1";
            dt.TableName = "SP_ConsumoAnualMateriales";

            return dt;
        }

        [WebMethod]
        public DataTable DetalleGastoDirectoMaterialesPryOt(string Centro_Operativo, string Division, string Proyecto,
            string Fecha_Emision, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_DET_G_PRY_OT_VSM_PCI(Centro_Operativo, Division, Proyecto, Fecha_Emision, UserName);
            dt.TableName = "SP_DET_G_PRY_OT_VSM_PCI";

            return dt;
        }

        [WebMethod]
        public DataTable ControlMateriales(string N_OPC, string N_CEO, string D_FECHAINI, string D_FECHAFIN, string C_DESTINO_OPER, string V_COD_CLASE_MAT, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_controlmateriales(N_OPC, N_CEO, D_FECHAINI, D_FECHAFIN, C_DESTINO_OPER, V_COD_CLASE_MAT,
                UserName);
            dt.TableName = "SP_ControlMateriales";

            return dt;
        }

        [WebMethod]
        public DataTable MaterialesCentroOperativo(string Fecha_Emision_Inicio, string Fecha_Emision_Termino,
            string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Mat_CentroOperativo(Fecha_Emision_Inicio, Fecha_Emision_Termino, UserName);
            dt.TableName = "SP_MAT_CENTROOPERATIVO";

            return dt;
        }

        [WebMethod]
        public DataTable MaterialLlegadoCompra(string Codigo_Division, string Codigo_OT, string Fecha_LLegada_Inicio,
            string Fecha_Llegada_Termino, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_MatLLegadoCompras(Codigo_Division, Codigo_OT, Fecha_LLegada_Inicio, Fecha_Llegada_Termino,
                UserName);
            dt.TableName = "SP_MatLLegadoCompras";

            return dt;
        }

        [WebMethod]
        public DataTable CatalogoMaterialesFc(string D_FechaIEmision, string D_FechaFEmision, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_CatalogoMaterialesFC(D_FechaIEmision, D_FechaFEmision, UserName);
            dt.TableName = "SP_CatalogoMaterialesFC";

            return dt;
        }

        [WebMethod]
        public DataTable ConsumoValeMaterialCC(string N_CEO, string V_CODCC, string D_FECHAINI, string D_FECHAFIN,
            string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_VM_CC(N_CEO, V_CODCC, D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_VM_CC";
            return dt;
        }

        [WebMethod]
        public DataTable MovimientoMaterialesTipMov(string Centro_Operativo, string FECHA_INICIAL_MOVIMIENTO,
            string FECHA_FINAL_MOVIMIENTO, string CODIGO_MATERIAL, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_MoviMatIOCVSMVD(Centro_Operativo, FECHA_INICIAL_MOVIMIENTO, FECHA_FINAL_MOVIMIENTO,
                CODIGO_MATERIAL, UserName);
            dt.TableName = "SP_MoviMatIOCVSMVDE";

            return dt;
        }

        [WebMethod]
        public DataTable MovimientoMaterialesAuditoria(string Almacen, string año_Inventario, string Corte,
            string Fecha_Inicial, string Fecha_Final, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_MoviMaterialAud(Almacen, año_Inventario, Corte, Fecha_Inicial, Fecha_Final, UserName);
            dt.TableName = "SP_MoviMaterialAud";

            return dt;
        }

        [WebMethod]
        public DataTable CalculoCantidadEquivalente2013(string V_MATERIAL, string V_DIMLARGO, string V_DIMANCHO,
            string V_UNMEDIDA, string V_CANTREQ, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_EQUIVA2013(V_MATERIAL, V_DIMLARGO, V_DIMANCHO, V_UNMEDIDA, V_CANTREQ, UserName);
            dt.TableName = "SP_EQUIVA2013";

            return dt;
        }

        [WebMethod]
        public DataTable ConsumoValeMaterialCCEspecifico(string N_CEO, string V_CODCC, string D_FECHAINI, string D_FECHAFIN,
            string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_VM_CC_ESPECIFICO(N_CEO, V_CODCC, D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_VM_CC_ESPECIFICO";

            return dt;
        }

        [WebMethod]
        public DataTable SaldoHistoricoMaterialAlmacen(string CENTRO_OPERATIVO, string FECHA_DE_PROCESO,
            string MATERIAL, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_saldo_historico_mat(CENTRO_OPERATIVO, FECHA_DE_PROCESO, MATERIAL, UserName);
            dt.TableName = "SP_saldo_historico_mat";

            return dt;
        }

        [WebMethod]
        public DataTable ControlReservaMaterial(string V_CODIGO_MATERIAL, string D_FECHA_RESERVA_inicial,
            string D_FECHA_RESERVA_final, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ControlReservaMat(V_CODIGO_MATERIAL, D_FECHA_RESERVA_inicial, D_FECHA_RESERVA_final,
                UserName);
            dt.TableName = "SP_ControlReservaMat";

            return dt;
        }

        [WebMethod]
        public DataTable AtencionMaterialesCC(string V_Centro_Operativo, string D_Fecha_Inicio, string D_Fecha_Termino,
            string V_CC, string UserName)
        {
            V_CC = V_CC.Replace("-1", "");

            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_AtencionMaterialesCC(V_Centro_Operativo, D_Fecha_Inicio, D_Fecha_Termino, V_CC, UserName);
            dt.TableName = "SP_AtencionMaterialesCC";

            return dt;
        }

        [WebMethod]
        public DataTable ConsumoValesSalidaMaterial(string V_TIPO_VALE, string D_FECHAINI, string D_FECHAFIN,
            string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_CONSUMO_VM_VALJDE(V_TIPO_VALE, D_FECHAINI, D_FECHAFIN, UserName);
            dt.TableName = "SP_CONSUMO_VM_VALJDE";

            return dt;
        }

        [WebMethod]
        public DataTable SeguimientoRqDetalleOts(string Codigo_Division, string Codigo_OT,
            string FECHA_EMISION_OT_Inicio, string FECHA_EMISION_OT_Termino, string FECHA_ATENCION_INICIO,
            string FECHA_ATENCION_TERMINO, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_SeguiRequeDeta_OTS(Codigo_Division, Codigo_OT, FECHA_EMISION_OT_Inicio,
                FECHA_EMISION_OT_Termino, FECHA_ATENCION_INICIO, FECHA_ATENCION_TERMINO, UserName);
            dt.TableName = "SP_SeguiRequeDeta_OTS";

            return dt;
        }

        [WebMethod]
        public DataTable PreciosReposicion(string CLAS_MATERIAL, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_PRECIOSREPOSICION(CLAS_MATERIAL, UserName);
            dt.TableName = "SP_PRECIOSREPOSICION";

            return dt;
        }

        [WebMethod]
        public DataTable PuntoReposicion(string TIPO_STOCK, string CLASE_MATERIAL, string MAT_CRI, string UserName)
        {
            MAT_CRI = MAT_CRI.Replace("-1", "T");

            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Punto_Reposicion(TIPO_STOCK, CLASE_MATERIAL, MAT_CRI, UserName);
            dt.TableName = "SP_Punto_Reposicion";

            return dt;
        }

        [WebMethod]
        public DataTable PuntoReposicionPreciosPromedio(string TIPO_STOCK, string CLASE_MATERIAL, string MAT_CRI,
            string UserName)
        {
            MAT_CRI = MAT_CRI.Replace("-1", "T");

            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Punto_Repo_Precios_Prome(TIPO_STOCK, CLASE_MATERIAL, MAT_CRI, UserName);
            dt.TableName = "SP_Punto_Repo_Precios_Prome";

            return dt;
        }

        [WebMethod]
        public DataTable PedidosMaterialesMultiproposito(string NUMERO_PEDIDO, string EMISION_INICIAL_PEDIDO,
            string EMISION_FINAL_PEDIDO, string CODIGO_MATERIAL, string CODIGO_AUXILIAR, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_PedidoMateMultipropo(NUMERO_PEDIDO, EMISION_INICIAL_PEDIDO, EMISION_FINAL_PEDIDO,
                CODIGO_MATERIAL, CODIGO_AUXILIAR, UserName);
            dt.TableName = "SP_PedidoMateMultipropo";

            return dt;
        }

        [WebMethod]
        public DataTable ReservasPendientesOtsPro(string Codigo_OT, string Codigo_Material, string Estado_OT,
            string Estado_Seguimiento_OT, string UserName)
        {
            Estado_OT = Estado_OT.Replace("-1", "");

            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Reserva_OT_Produccion(Codigo_OT, Codigo_Material, Estado_OT, Estado_Seguimiento_OT,
                UserName);
            dt.TableName = "SP_Reserva_OT_Produccion";

            return dt;
        }

        [WebMethod]
        public DataTable MaterialesCargaMasiva(string CLASE_SUBCLASE, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_MAT_MASIVA(CLASE_SUBCLASE, UserName);
            dt.TableName = "SP_MAT_MASIVA";

            return dt;
        }

        [WebMethod]
        public DataTable ReservaMaterialesAreasUsuarias(string Area_Usuaria, string división, string Material,
            string OT, string UserName)
        {
            división = división.Replace("-1", "");

            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_ReserMateAreasUsua(Area_Usuaria, división, Material, OT, UserName);
            dt.TableName = "SP_ReserMateAreasUsua";

            return dt;
        }

        [WebMethod]
        public DataTable CodificacionCubso(string CLASE, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_CODIFICACION_CUBSO(CLASE, UserName);
            dt.TableName = "SP_Codificacion_Cubso";

            return dt;
        }

        [WebMethod]
        public DataTable PedidoMaterialCompraOts(string DIVISION, string NRO_PEDIDO, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_PedidoMaterialCompraOTS(DIVISION, NRO_PEDIDO, UserName);
            dt.TableName = "SP_PedidoMaterialCompraOTS";

            return dt;
        }

        [WebMethod]
        public DataTable MaterialesSinMovimiento(string Centro_Operativo, string Almacen, string Fecha_Inicial,
            string Fecha_Final, string Clase, string Stock, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_MatlesSinMov_PDR8701(Centro_Operativo, Almacen, Fecha_Inicial, Fecha_Final, Clase, Stock,
                UserName);
            dt.TableName = "SP_MatlesSinMov_PDR8701";

            return dt;
        }

        [WebMethod]
        public DataTable SaldoAlmacen(string Material_Inicial, string Material_Final, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_SaldoAlmacen(Material_Inicial, Material_Final, UserName);
            dt.TableName = "SP_SaldoAlmacen";

            return dt;
        }

        [WebMethod]
        public DataTable ValeSalida(string s_CEO, string s_NRO_VALE, string s_COD_ALMA, string s_AREA_USU, string UserName)
        {
            logisticaSoapClient oGL = new logisticaSoapClient();

            dt = oGL.Listar_Vale_Salida_Mat(s_CEO, s_NRO_VALE, s_COD_ALMA, s_AREA_USU, UserName);
            dt.TableName = "SP_VALE_SALIDA_MAT";
            return dt;

        }
    }
}
