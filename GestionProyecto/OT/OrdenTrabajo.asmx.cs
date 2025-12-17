using SIMANET_W22R.srvGestionProyecto;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

namespace SIMANET_W22R.GestionProyecto.OT
{
    /// <summary>
    /// Descripción breve de OrdenTrabajo
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class OrdenTrabajo : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable Listar_detg_pry_ot_sinfact(string CENTRO_OPERATIVO, string DIVISION, string PROYECTO,string sAnio, string UserName)
        {
          try { 
            if (string.IsNullOrEmpty(CENTRO_OPERATIVO) || CENTRO_OPERATIVO=="-1")
            {
                    // Envía un error que el cliente puede capturar
                    throw new SoapException("El campo CENTRO_OPERATIVO es obligatorio.", SoapException.ClientFaultCode);

                }
                ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_detg_pry_ot_sinfact(CENTRO_OPERATIVO,DIVISION,PROYECTO, sAnio, UserName);
            dt.TableName = "SP_DETG_PRY_OT_SINFACT";
             return dt;
            
            }
            catch (SoapException ex)
            {
                // Reenvía tal cual el error Soap personalizado
                throw;
            }
            catch (Exception ex)
            {
                // Envía otros errores genéricos
                throw new SoapException("Error al procesar la solicitud: " + ex.Message, SoapException.ServerFaultCode);
            }

        }

        [WebMethod]
        public DataTable Listar_ots_por_proyecto(string V_CENTRO_OPERATIVO, string V_DIVISION, string V_PROYECTO, string UserName)
        {
            ProyectoSoapClient oPy = new ProyectoSoapClient();
            dt = oPy.Listar_ots_por_proyecto(V_CENTRO_OPERATIVO,V_DIVISION,V_PROYECTO,UserName);
            dt.TableName = "SP_OTS_por_Proyecto";
            return dt;
        }
    }
}
