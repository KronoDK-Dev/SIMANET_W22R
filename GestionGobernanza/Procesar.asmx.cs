using AjaxControlToolkit.HtmlEditor.ToolbarButtons;
using DocumentFormat.OpenXml.Spreadsheet;
using EasyControlWeb;
using SIMANET_W22R.GestionGobernanza.Indicadores;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionGobernanza
{
    /// <summary>
    /// Descripción breve de Procesar
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Procesar : System.Web.Services.WebService
    {

        [WebMethod]
        public DataTable AccionesEIndicadores(int Tipo,  string pCodArea, string pCodEmp, string pCodSuc,int Idtbl, int IdItem)
        {
            DataTable result = new DataTable();
            DataTable dt=new DataTable();
            dt = (new ListarIndicadoresPorArea()).LstIndicadoresPorArea(Tipo, pCodArea, pCodEmp, pCodSuc);
            switch (Tipo) { 
                case 2://Acciones

                    string[] FieldGroup = { "IDTBLACCION", "IDACCION", "CODIGOACCION", "NOMBREACCION","IDTBLOBJETIVO","IDOBJETIVO", "CODIGOOBJETIVO","TIPO" };

                    DataTable dtAccion = EasyUtilitario.Helper.Data.GroupBy(dt, FieldGroup, null);

                    if (dtAccion != null) {
                        result = dtAccion.Select("IDTBLOBJETIVO=" + Idtbl.ToString() + " and IDOBJETIVO=" + IdItem.ToString()).CopyToDataTable();
                    }
                    break;
                case 3://INdicadores
                    string[] FieldGroupInd = {"COD_AREA","IDAREA","IDITEMINFOCOMPLE", "IDTBLINDICADOR", "IDINDICADOR","CODIGOINDICADOR", "NOMBRE", "DESCRIPCION", "IDTBLACCION", "IDACCION", "TIPO" };

                    DataTable dtIndica = EasyUtilitario.Helper.Data.GroupBy(dt, FieldGroupInd, null);

                    if (dtIndica != null)
                    {
                        result = dtIndica.Select("IDTBLACCION=" + Idtbl.ToString() + " and IDACCION=" + IdItem.ToString()).CopyToDataTable();
                    }

                    break;
            }
            foreach (DataRow row in result.Rows)
            {
                row["TIPO"] = Tipo.ToString();
            }
            result.AcceptChanges();

            result.TableName = "Table";
            return result;
        }
    }
}
