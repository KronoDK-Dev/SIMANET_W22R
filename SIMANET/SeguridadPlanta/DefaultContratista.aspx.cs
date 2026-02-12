using CrystalDecisions.ReportAppServer.DataDefModel;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.HelpDesk.Atencion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class DefaultContratista : SeguridadPlantaBase,IPaginaBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                
                this.LlenarDatos();
                this.LlenarCombos();
                this.LlenarJScript();
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
            ddlTipo.Items.Add(new ListItem("Ingreso","1" ));
            ddlTipo.Items.Add(new ListItem("Salida","2"));
        }

        public void LlenarDatos()
        {
            string ImgDetalle = "data:image/png;base64,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";
            string cmll = "\"";


            foreach (DataRow dr in this.TablaGeneralItemSQL("703").GetDataTable().Rows) {

                EasyTabItem oTab =oTab = new EasyTabItem();
                oTab.Id = "TabDet_" + dr["CODIGO"].ToString();
                string htmlTab = "<table><tr><td><img src='" + dr["VAR5"].ToString() + "'/></td><td>"+ dr["VAR1"].ToString() + "</td><td onclick=" + cmll + "DefaultContratista.Detalle();" + cmll + "></td></tr></table>";
                oTab.Text = htmlTab;
                oTab.TipoDisplay = TipoTab.ContentCtrl;
                oTab.Value = dr["VAR3"].ToString();
                oTab.DataCollection = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);

                if (dr["CODIGO"].ToString().Equals("1"))
                {
                    oTab.Selected = true;
                    oTab.AccionRefresh = false;
                }
                EasyTabBase.TabCollections.Add(oTab);
            }

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
            this.ibtnAdd.Src =  EasyUtilitario.Constantes.ImgDataURL.NewItem;
            this.ibtnAdd.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "DefaultContratista.Trabajador(this)";
            this.ibtnAdd.Attributes["style"] = "cursor:pointer";


            acTrabajador.DataInterconect.UrlWebService = this.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
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