using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.HelpDesk.Atencion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web; 
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class AdministrarInformeMetaPorArea : GobernanzaBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                CargarAreasPorUsuario();
            }
            catch (Exception ex)
            {
            }
        }

        public EasyDataInterConect ObtenerListadodeAreasPorUsuario(int  IdUsuario)
        {

            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "AreaindicadorXUsuario_Lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = IdUsuario.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            return odi;
        }

        void CargarAreasPorUsuario()
        {
            string cmll = "\"";
            int i = 0;
            EasyTabItem oTab = null;
            foreach (DataRow dr in ObtenerListadodeAreasPorUsuario(this.UsuarioId).GetDataTable().Rows)
            {

                oTab = new EasyTabItem();
                oTab.Id = "SH" + dr["IDITEM"].ToString();
                string htmlTab = "<table><tr><td><img src='" + EasyUtilitario.Constantes.ImgDataURL.Home + "'/></td><td>" + dr["NOMBRE_AREA"].ToString() + "</td><td onclick=" + cmll + "AdministrarInformeMetaPorArea.Indicadores('" + dr["COD_AREA"].ToString() + "');" + cmll + "></td></tr></table>";
                oTab.Text = htmlTab;
                oTab.TipoDisplay = TipoTab.UrlLocal;
                oTab.Value = "/GestionGobernanza/Indicadores/ListarIndicadoresPorArea.aspx"; 
                oTab.DataCollection = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);
                if (i == 0)
                {
                    oTab.Selected = true;
                    oTab.AccionRefresh = false;
                }

                EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
                oParam.ParamName = AdministrarPlandeTrabajo.KEYCODAREA;
                oParam.Paramvalue = dr["COD_AREA"].ToString();
                oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
                oTab.UrlParams.Add(oParam);


                EasyTabMetas.TabCollections.Add(oTab);

                i++;
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