using SIMANET_W22R.srvGestionContabilidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionContabilidad.Pagos
{
    /// <summary>
    /// Descripción breve de Pagos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Pagos : System.Web.Services.WebService
    {
        DataTable dt;

        [WebMethod]
        public DataTable VoucherporDocumento(string V_NUMERO, string V_PROVEEDOR, string V_SERIE, string V_TIPO, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_voucher_por_documento(V_NUMERO, V_PROVEEDOR, V_SERIE, V_TIPO, UserName);
            dt.TableName = "SP_Voucher_por_Documento";

            return dt;
        }

        [WebMethod]
        public DataTable REGISTRORETENCIONESSUNAT(string N_CEO, string V_ANIO, string V_NROMES, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_registro_retenciones_suna(N_CEO, V_ANIO, V_NROMES, UserName);
            dt.TableName = "SP_REGISTRO_RETENCIONES_SUNAT";

            return dt;
        }

        [WebMethod]
        public DataTable PagosporCuentaDetraccion(string N_CEO, string V_ANIO, string V_MESFIN, string V_MESINI, string UserName)
        {
            ContabilidadSoapClient oCtbl = new ContabilidadSoapClient();
            dt = oCtbl.Listar_pagos_por_cuenta_detraccion(N_CEO, V_ANIO, V_MESFIN, V_MESINI, UserName);
            dt.TableName = "SP_Pagos_por_Cuenta_Detraccion";

            return dt;
        }
    }
}
