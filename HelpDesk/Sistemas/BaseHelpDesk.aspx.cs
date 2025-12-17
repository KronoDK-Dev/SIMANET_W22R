using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb;
using SIMANET_W22R.HelpDesk.ITIL;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EasyControlWeb.InterConeccion;

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class BaseHelpDesk : HelpDeskBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarDatos();
            }
            catch (Exception ex)
            {

            }
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
            EasyTabItem oTab = null;
            int i = 0;
            foreach (DataRow dr in ListarServiciosOtorgados(this.IdActividad).GetDataTable().Rows )
            {


                oTab = new EasyTabItem();
                oTab.Id = "SH" + dr["ID_SERV_PROD"].ToString();
                oTab.Text = dr["NOMBRE"].ToString();
                oTab.TipoDisplay = TipoTab.UrlLocal;
                oTab.Value = "/HelpDesk/Sistemas/HelpDeskListarAtenciones.aspx";
                oTab.DataCollection = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);
                if (i == 0)
                {
                    oTab.Selected= true;
                }

                EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
                oParam.ParamName = AdministrarComponentesdeActividad.KEYIDACTIVIDAD;
                oParam.Paramvalue = this.IdActividad;
                oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);

                oParam = new EasyFiltroParamURLws();
                oParam.ParamName = AdministrarComponentesdeActividad.KEYIDSERVICIO;
                oParam.Paramvalue = dr["ID_SERV_PROD"].ToString();
                oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);

                i++;
                EasyTabControlV1.TabCollections.Add(oTab);
            }

        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public EasyDataInterConect ListarServiciosOtorgados(string pIdActividad)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "ServiciosOtorgadosAUnaActividad_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdActividad";
            oParam.Paramvalue = pIdActividad;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi;
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
            throw new NotImplementedException();
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