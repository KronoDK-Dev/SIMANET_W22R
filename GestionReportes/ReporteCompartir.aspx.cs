using EasyControlWeb;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionReportes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionReportes
{
    public partial class ReporteCompartir : ReporteBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarGrilla();
                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }
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
            try
            {
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                DataTable dt = ogReports.ListarUsuariosxReporteCompartido(this.IdObjeto, UsuarioLogin);

                EasyGridViewCompartir.DataSource = dt;
                EasyGridViewCompartir.DataBind();
                
            }
            catch (Exception ex)
            {
                SIMAExceptionSeguridadAccesoForms oer = new SIMAExceptionSeguridadAccesoForms(ex.Message);
                this.ErrorDisplay(oer);
            }
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

        protected void EasyGridViewCompartir_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                HtmlImage oImg = new HtmlImage();
                string UrlFoto = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFotos");
                oImg.ID = dr["NroDocDni"].ToString();
                oImg.Src = UrlFoto + dr["NroDocDni"].ToString() + ".jpg";
                oImg.Attributes.Add("class", "ms-n2 rounded-circle img-fluid");
                oImg.Attributes["style"]="width:80px;height:50px";
                oImg.Attributes["onerror"] = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;";

                HtmlTable tblNodo = new HtmlTable();
                tblNodo = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, 2);
                tblNodo.Attributes["width"] = "100%";
                // tblNodo.Attributes["border"]="2";
                tblNodo.Rows[0].Cells[0].RowSpan = 2;
                tblNodo.Rows[1].Cells[0].Visible = false;
                tblNodo.Rows[0].Cells[0].Controls.Add(oImg);
                tblNodo.Rows[0].Cells[0].Attributes["width"] = "10%";
                tblNodo.Rows[0].Cells[0].Style.Add("padding-left", "10px");


                tblNodo.Rows[0].Cells[1].InnerText = dr["ApellidosyNombres"].ToString();
                tblNodo.Rows[1].Cells[1].InnerText = dr["Login"].ToString() + "@sima.com.pe";

                tblNodo.Rows[1].Cells[1].Attributes["style"]="font-style:italic;color:red;font-size:10px";

                tblNodo.Rows[0].Cells[1].Attributes["width"] = "90%";
                e.Row.Cells[0].Controls.Add(tblNodo);

                //crea los controles chk
                CheckBox chk = new CheckBox();
                chk.Checked = ((dr["Ver"].ToString().Equals("1"))?true:false);
                e.Row.Cells[1].Controls.Add(chk);

                chk = new CheckBox();
                chk.Checked = ((dr["Compartir"].ToString().Equals("1")) ? true : false);
                e.Row.Cells[2].Controls.Add(chk);
            }



        }
    }
}