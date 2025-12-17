using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.srvGestionProyecto;
using System.Data;

namespace SIMANET_W22R.GestionProyecto.Ordenes
{
    /// <summary>
    /// Descripción breve de Ordenes
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Ordenes : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_det_gasto_pry_ot_ose_ava(string N_CEO, string V_CODDIV, string V_CODPRY, string V_ORDSRV, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_det_gasto_pry_ot_ose_ava(N_CEO,V_CODDIV,V_CODPRY,V_ORDSRV,UserName);
            dt.TableName = "SP_DET_GASTO_PRY_OT_OSE_AVA";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_detalle_gasto_pry_ot_ose(string N_CEO, string V_CODDIV, string V_CODPRY, string V_PERIODO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_detalle_gasto_pry_ot_ose( N_CEO,V_CODDIV,V_CODPRY,V_PERIODO,UserName);
            dt.TableName = "SP_Detalle_Gasto_Pry_OT_Ose";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_det_gasto_pry_ot_oco(string D_AÑO, string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            try {  
                ProyectoSoapClient oPy = new ProyectoSoapClient();
                //  validamos parámetros
                if (string.IsNullOrWhiteSpace(V_CENTRO_OPERATIVO) || V_CENTRO_OPERATIVO == "-1")
                {
                    throw new ArgumentException("El parámetro \"Centro Operativo/ Sucursal\" es obligatorio y no puede estar vacío. Coordine con el área respectiva para su asignación");
                }
                if (string.IsNullOrWhiteSpace(V_DIVISION) || V_DIVISION == "-1")
                {
                    throw new ArgumentException("El parámetro \"Linea de Negocio\" es obligatorio y no puede estar vacío. Coordine con el área respectiva para su asignación");
                }
                if (string.IsNullOrWhiteSpace(V_PROYECTO) || V_PROYECTO == "-1")
                {
                    throw new ArgumentException("El parámetro \"Proyecto\" es obligatorio y no puede estar vacío. Debe seleccionar el valor");
                }

                dt = oPy.Listar_det_gasto_pry_ot_oco(D_AÑO,V_CENTRO_OPERATIVO,V_DIVISION,V_PROYECTO,UserName);
                dt.TableName = "SP_DET_GASTO_PRY_OT_OCO";
                if (dt == null)
                { throw new ArgumentException("No se devolvieron resultados."); }

                return dt;
                }
            catch (Exception ex)
            {
                // 2. reenviamos el resultado mediante una tabla con los campos que tiene el procediemiento almacenado
                //  Siempre devuelve un DataTable válido con el mensaje de error
                DataTable errorTable = new DataTable("SP_DET_GASTO_PRY_OT_OCO");
                errorTable.Columns.Add("CENTRO_OPERATIVO", typeof(bool));
                errorTable.Columns.Add("DESCRIPCION_OT", typeof(string));
                errorTable.Rows.Add(false, ex.Message);
                return errorTable;
            }
        }

        [WebMethod]
        public DataTable Listar_resumen_ose(string D_AÑO, string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_resumen_ose( D_AÑO,V_CENTRO_OPERATIVO,V_DIVISION,V_PROYECTO,UserName);
            dt.TableName = "SP_resumen_ose";
            return dt;
        }

        [WebMethod]
        public DataTable Listar_detalle_ose_femision(string D_FECHAFIN, string D_FECHAINI, string N_CEO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_detalle_ose_femision(D_FECHAFIN,D_FECHAINI,N_CEO,UserName);
            dt.TableName = "SP_Detalle_Ose_Femision";
            return dt;
        }
        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }
    }
}
