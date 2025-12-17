using SIMANET_W22R.srvGestionLogistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionLogistica.Stock
{
    /// <summary>
    /// Descripción breve de Stock
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Stock : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable TransStockVerFec(string FECHA_DE_TRANSFERENCIA_Inicio, string FECHA_DE_TRANSFERENCIA_Termino, string Material_Inicial,
            string Material_Final, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_TransStockVerFec(FECHA_DE_TRANSFERENCIA_Inicio, FECHA_DE_TRANSFERENCIA_Termino, Material_Inicial, Material_Final, UserName);
            dt.TableName = "SP_TransStockVerFec";

            return dt;
        }

        [WebMethod]
        public DataTable LiberaReservasTrf(string FECHA_DE_LIBERACION_INICIO, string FECHA_DE_LIBERACION_TERMINO, string MATERIAL_FINAL, string MATERIAL_INICIAL, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_liberareservastrf(FECHA_DE_LIBERACION_INICIO, FECHA_DE_LIBERACION_TERMINO, MATERIAL_FINAL, MATERIAL_INICIAL, UserName);
            dt.TableName = "SP_LiberaReservasTrf";

            return dt;
        }

        [WebMethod]
        public DataTable Valorizacion_Disp_Stock(string N_CEO, string V_CODDIV, string V_NROVAL, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Valorizacion_Disp_Stock(N_CEO, V_CODDIV, V_NROVAL, UserName);
            dt.TableName = "SP_Valorizacion_Disp_Stock";

            return dt;
        }

        [WebMethod]
        public DataTable Punto_Reposicion_Pedido(string TIPO_STOCK, string CLASE_MATERIAL, string CLASIFICACION, string MATERIAL_CRITICO, string UserName)
        {
            CLASIFICACION = CLASIFICACION.Replace("-1", "");
            MATERIAL_CRITICO = MATERIAL_CRITICO.Replace("-1", "");

            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Punto_Reposicion_Pedido(TIPO_STOCK, CLASE_MATERIAL, CLASIFICACION, MATERIAL_CRITICO, UserName);
            dt.TableName = "SP_Punto_Reposicion_Pedido";

            return dt;
        }

        [WebMethod]
        public DataTable TransStockVerCon(string Fecha_Inicial, string Fecha_Final, string USUARIO, string TERMINAL, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_TransStockVerCon(Fecha_Inicial, Fecha_Final, USUARIO, TERMINAL, UserName);
            dt.TableName = "SP_TransStockVerCon";

            return dt;
        }

        [WebMethod]
        public DataTable LiberaReservasCon(string FECHA_FINAL, string FECHA_INICIAL, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_liberareservascon(FECHA_FINAL, FECHA_INICIAL, UserName);
            dt.TableName = "SP_LiberaReservasCon";

            return dt;
        }
        [WebMethod]
        public DataTable Listar_InventarioFisicoResultado(string V_CEO, string N_ANIO, string V_CODALM, string V_CODCOR, string V_DIFE, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_InventarioFisicoResultado(V_CEO, N_ANIO, V_CODALM, V_CODCOR, V_DIFE, UserName);
            dt.TableName = "SP_InventarioFisicoResultado";

            return dt;
        }
        [WebMethod]
        public DataTable Listar_InventarioFisicoToma(string CEO_OPE, string V_ANO_INV, string V_COD_ALM, string V_COD_COR, string DIFE, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_InventarioFisicoToma(CEO_OPE, V_ANO_INV, V_COD_ALM, V_COD_COR, DIFE, UserName);
            dt.TableName = "SP_InventarioFisicoToma";

            return dt;
        }

        [WebMethod]
        public DataTable Listar_Paquetes_Materiales(string PAQUETE, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_Paquetes_Materiales(PAQUETE, UserName);
            dt.TableName = "SP_PAQUETES_MATERIALES";

            return dt;
        }

        [WebMethod(Description = "Detalle de las Transferidas de stock")]
        public DataTable Listar_TransStockVerCon(string Fecha_Inicial, string Fecha_Final, string USUARIO,
            string TERMINAL, string UserName)
        {
            logisticaSoapClient oLg = new logisticaSoapClient();
            dt = oLg.Listar_TransStockVerCon(Fecha_Inicial, Fecha_Final, USUARIO, TERMINAL, UserName);
            dt.TableName = "SP_TransStockVerCon";

            return dt;
        }
    }
}
