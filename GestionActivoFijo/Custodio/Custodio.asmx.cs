using SIMANET_W22R.srvLog_ActivoFijo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

namespace SIMANET_W22R.GestionActivoFijo.Custodio
{
    /// <summary>
    /// Descripción breve de Custodio
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Custodio : System.Web.Services.WebService
    {
        DataTable dt;
        DataTable dtError = new DataTable();
        string sMensaje;

        [WebMethod]
        public DataTable Listar_inventario_activosxcustod(string COD_EMPE, string COD_ROL, string TIPOACTV, string UserName)
        {
            dtError.Columns.Add("Error", typeof(string));

            try
            {

                if (string.IsNullOrEmpty(COD_EMPE) || COD_EMPE == "-1")
                {
                    sMensaje = "Debe seleccionar Centro Operativo";
                    //  dtError.Columns.Add("Error", typeof(string));
                    dtError.Rows.Add(sMensaje.Trim());

                    throw new SoapException(sMensaje, SoapException.ClientFaultCode);
                    // return dtError;
                }

                if (string.IsNullOrEmpty(TIPOACTV) || TIPOACTV == "-1")
                {
                    sMensaje = "Debe seleccionar Tipo de Activo Operativo";
                    //  dtError.Columns.Add("Error", typeof(string));
                    dtError.Rows.Add(sMensaje.Trim());

                    throw new SoapException(sMensaje, SoapException.ClientFaultCode);
                    // return dtError;
                }

                if (string.IsNullOrEmpty(COD_ROL))
                {
                    sMensaje = "Debe Ingresar Número PR";
                    //  dtError.Columns.Add("Error", typeof(string));
                    dtError.Rows.Add(sMensaje.Trim());

                    throw new SoapException(sMensaje, SoapException.ClientFaultCode);
                    // return dtError;
                }

                //---------------------------------
                ActivoFijoSoapClient oC = new ActivoFijoSoapClient();
                dt = oC.Listar_inventario_activosxcustod(COD_EMPE, COD_ROL, TIPOACTV, UserName);
                dt.TableName = "SP_Inventario_ActivosxCustodio";
                return dt;
            }
            catch (Exception ex)
            {
                // Si hay error, devolver un DataTable con el mensaje de error

                //   dtError.Columns.Add("Error", typeof(string));
                dtError.Rows.Add("Error en el servicio: " + ex.Message);
                return dtError;
            }
        }
    }
}
