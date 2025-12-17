using EasyControlWeb;
using EasyControlWeb.Filtro;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.General;
using SIMANET_W22R.GestionReportes;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static iTextSharp.text.pdf.AcroFields;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class ListaReporteIndicadores : PaginaCalidadBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarJScript();
                    this.LlenarDatos();
             
                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }
        }
        public int Agregar()
        {
            throw new NotImplementedException();
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
            this.numAño.Text = DateTime.Now.Year.ToString();
            this.ddlMeses.LoadData();
            this.ddlMeses.SetValue(DateTime.Now.Month.ToString());
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
            HtmlTable tblTool;
            HtmlTable tblBtn;
            DataTable dtOP = (new TablasGenerales()).ListarItems("689", this.UsuarioLogin);

            tblTool = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, dtOP.Rows.Count);
            int c = 0;
            foreach (DataRow dr in dtOP.Rows){
                tblBtn = new HtmlTable();
                tblBtn = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 1);
                tblBtn.Border = 2;

                tblBtn.ID = "btn_" + dr["Codigo"].ToString();
                tblBtn.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "btn_OnClick(this)");
                tblBtn.Attributes.Add("class", "ItemOP");
                tblBtn.Attributes.Add("Data", dr["var1"].ToString());

                tblBtn.Rows[0].Cells[0].InnerText = dr["Descripcion"].ToString();


                tblTool.Rows[0].Cells[c].Controls.Add(tblBtn);
                c++;
            }
            BtnOpcion.Controls.Add(tblTool);

            //Imagen de fijado
            this.ImageFijarReport.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconoFijar;
            this.ImageFijarReport.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "ReportIndicadores.AnclarReport();";
            this.ImageFijarReport.Attributes["class"] = "imgEfect";
            this.ImageFijarReport.Attributes["onmouseover"] = "this.src='" + EasyUtilitario.Constantes.ImgDataURL.IconoDesFijar + "'";
            this.ImageFijarReport.Attributes["onmouseout"] = "this.src='" + EasyUtilitario.Constantes.ImgDataURL.IconoFijar + "'";
        }

        public int Modificar()
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