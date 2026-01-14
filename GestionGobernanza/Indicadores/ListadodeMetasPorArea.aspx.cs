using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class ListadodeMetasPorArea : GobernanzaBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            { 
                this.LlenarCombos();
            }
            catch (Exception ex)
            {
                int i = 0;
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

            DataTable dtMeta = ListarMetas(this.IdAreaInfo, this.IdTipoPlazo);
           int  c = 0;
            HtmlTable tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, dtMeta.Rows.Count);
            tbl.ID = "tbl_Meta";
            tbl.Rows[0].Attributes.Add("class", "HeaderGrilla");
            foreach (DataRow drc in dtMeta.Rows)
            {
                EasyTextBox tbMeta = new EasyTextBox();
                tbMeta.ID = "txtM" + drc["IDDETALLEPLAZO"].ToString();
                tbMeta.SetValue(drc["META"].ToString());
                tbMeta.Attributes.Add("required", " ");

                tbl.Rows[0].Cells[c].InnerText = drc["NOMBREDETALLEPLAZO"].ToString();
                tbl.Rows[0].Cells[c].Style.Add("color", "white");
                tbl.Rows[0].Cells[c].Align = "center";
                tbl.Rows[0].Cells[c].Attributes.Add("reference", tbMeta.ID);

                tbl.Rows[0].Cells[c].Attributes["class"] = "Etiqueta";
                // tbl.Rows[0].Cells[c].Style.Add("background-color", drc["COLOR"].ToString());

                tbl.Rows[1].Cells[c].Controls.Add(tbMeta);
                tbl.Rows[1].Cells[c].Attributes.Add("Data", EasyUtilitario.Helper.Genericos.DataRowToStringJson(drc));

                c++;
            }
            Page.Form.Controls.Add(tbl);
        }


        public DataTable ListarMetas(string IdAreaInfoComplet, string IdTipoMeta)
        {

            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "AreaindicadorPlazo_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdAreaInfoComplet";
            oParam.Paramvalue = IdAreaInfoComplet.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTipoPlazo";
            oParam.Paramvalue = IdTipoMeta.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetDataTable();
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