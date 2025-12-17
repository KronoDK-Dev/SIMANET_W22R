using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb;
using SIMANET_W22R.HelpDesk.ITIL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class BaseControlCambios :HelpDeskBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EasyTabItem oTab = null;
            foreach (DataRow dr in (new AdministrarComponentesdeActividad()).ObtenerElementos("63").Rows)
            {


                oTab = new EasyTabItem();
                oTab.Id = "SH" + dr["CODIGO"].ToString();
                oTab.Text = dr["NOMBRE"].ToString();
                oTab.TipoDisplay = TipoTab.UrlLocal;
                string[] UrlParams = dr["BTNTOOL"].ToString().Split(new char[] { '?' });
                oTab.Value = UrlParams[0];
                oTab.DataCollection = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);
                if (dr["CODIGO"].ToString() == this.IdTabDefault)
                {
                    oTab.Selected = true;
                    oTab.AccionRefresh = false;
                }
                /*if (dr["VAL1"].ToString() == "0")
                {
                    oTab.Enabled = false;
                }*/

                EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
                oParam.ParamName = AdministrarComponentesdeActividad.KEYIDACTIVIDAD;
                oParam.Paramvalue = this.IdActividad;
                oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);

                oParam = new EasyFiltroParamURLws();
                oParam.ParamName = AdministrarComponentesdeActividad.KEYIDTIPOELEMENTO;
                oParam.Paramvalue = dr["CODIGO"].ToString(); ;
                oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);


                oParam = new EasyFiltroParamURLws();
                oParam.ParamName = AdministrarComponentesdeActividad.KEYNOMBREELEMENTO;
                oParam.Paramvalue = oTab.Text;
                oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);

                if (UrlParams.Length > 1)
                {
                    string[] Params = UrlParams[1].ToString().Split(new char[] { '&' });
                    foreach (string _param in Params)
                    {
                        string[] pv = _param.Split(new char[] { '=' });

                        oParam = new EasyFiltroParamURLws();
                        oParam.ParamName = pv[0];
                        oParam.Paramvalue = pv[1];
                        oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                        oTab.UrlParams.Add(oParam);
                    }
                }

                EasyTabControlCambio.TabCollections.Add(oTab);
            }
        }
    }
}