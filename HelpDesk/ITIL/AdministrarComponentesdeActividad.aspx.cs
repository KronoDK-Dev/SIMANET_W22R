using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using Newtonsoft.Json;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.ITIL
{
    public partial class AdministrarComponentesdeActividad : HelpDeskBase,IPaginaBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            this.LlenarJScript();
        }
        public DataTable ObtenerElementos(string IdTbl) {
            EasyDataInterConect oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathBaseWSCore") + "General/General.asmx";
            oEasyDataInterConect.Metodo = "ListarTodosOracle";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdtblModulo";
            oParam.Paramvalue = IdTbl;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            oEasyDataInterConect.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

            DataTable dt = (((DataTable)EasyWebServieHelper.InvokeWebService(oEasyDataInterConect)).Select("", "VAL1 asc")).CopyToDataTable();//Ordenando Resultado;
            return dt;
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void LlenarCombos()
        {
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            EasyTabItem oTab = null;
            foreach (DataRow dr in ObtenerElementos("52").Rows)
            {


                oTab = new EasyTabItem();
                oTab.Id = "Elem" + dr["CODIGO"].ToString();
                oTab.Text = dr["NOMBRE"].ToString();
                oTab.TipoDisplay = TipoTab.UrlLocal;
                string[] UrlParams = dr["BTNTOOL"].ToString().Split(new char[] { '?' });
                oTab.Value = UrlParams[0];
                oTab.DataCollection = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);
                if (dr["CODIGO"].ToString() == "3")
                {
                    oTab.Selected = true;
                    oTab.AccionRefresh = true;
                }
                if (dr["VAL1"].ToString() == "0")
                {
                    oTab.Enabled = false;
                }

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

                EasyTabControl1.TabCollections.Add(oTab);
            }
        }

        public void RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        public bool ValidarDatos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }

    }
}