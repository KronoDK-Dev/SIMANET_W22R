using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.GestionReportes;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class AdministrarSolicitudAprobacion : PaginaCalidadBase, IPaginaBase
    {
        EasyMessageBox oeasyMessageBox;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
                    this.LlenarJScript();

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
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            try
            {
                DataTable dt = (new ControlInspeccionesSoapClient()).ListarSolicitudAprobacion(this.UsuarioId, this.UsuarioLogin);
                DataView dv = dt.DefaultView;
                if (strFilter.Length > 0)
                {
                    dv.RowFilter = strFilter;
                }
                EasyGridView1.DataSource = dv;
                EasyGridView1.DataBind();
            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                this.LanzarException(NombreMetodo, ex);
            }
        }

        public void LlenarJScript()
        {
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble.ToString();
            btnPrevioRpt.Style.Add("display", "none");
            string FormReplicateConst = @"setTimeout(function(){
                                                    SIMA.Utilitario.Constantes.ImgDataURL.IconAprobado=" + cmll + EasyUtilitario.Constantes.ImgDataURL.IconAprobado + cmll + @";
                                                    SIMA.Utilitario.Constantes.ImgDataURL.IconDesaprobado=" + cmll + EasyUtilitario.Constantes.ImgDataURL.IconDesaprobado + cmll + @";
                                            }, 500);";

            



            Page.RegisterClientScriptBlock("IconAD", "<script>\n" + FormReplicateConst + "\n" + "</script>");
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

        protected void EasyGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                /*-----------------------------------------------------------------------------------------------------------------*/
                HtmlImage oImg = new HtmlImage();
                string UrlFoto = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFotos");
                oImg.ID = dr["NRODNI"].ToString();
                oImg.Src = UrlFoto + dr["NRODNI"].ToString() + ".jpg";
                oImg.Attributes.Add("class", "ms-n2 rounded-circle img-fluid");
                oImg.Attributes["width"] = "80px";
                oImg.Attributes["height"] = "50px";
                oImg.Attributes["onerror"] = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;";
               
               
                HtmlGenericControl dvBadge = new HtmlGenericControl("div");
                dvBadge.Style.Add("display", "inline-block");
                dvBadge.Attributes.Add("width", "50px");
                HtmlGenericControl Badge = new HtmlGenericControl("span");
                Badge.Attributes.Add("class", "badge");
                Badge.InnerText = dr["NroMsgRecibe"].ToString();
                dvBadge.Controls.Add(Badge);
                if (Convert.ToInt32(dr["NroMsgRecibe"].ToString()) > 0)
                {
                    dvBadge.Controls.Add(oImg);
                    e.Row.Cells[1].Controls.Add(dvBadge);
                }
                else{
                    e.Row.Cells[1].Controls.Add(oImg);
                }

                HtmlTable otblFileAdjunto = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
                otblFileAdjunto.Attributes["class"] = "ItemContact";
                otblFileAdjunto.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "AdministrarSolicitudAprobacion.VistaPreviaFI(this);";

                HtmlImage oimgFile = new HtmlImage();
                oimgFile.Attributes["Width"] = "30px";
                oimgFile.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconPdf;

                otblFileAdjunto.Rows[0].Cells[0].Controls.Add(oimgFile);
                otblFileAdjunto.Rows[0].Cells[0].Style.Add("padding-left", "5px");

                otblFileAdjunto.Rows[0].Cells[1].InnerText = "RI-" + dr["NombreProyecto"].ToString() +"-" + dr["NroReporte"].ToString();
                otblFileAdjunto.Rows[0].Cells[1].Style.Add("padding-right", "15px");
                e.Row.Cells[2].Controls.Add(otblFileAdjunto);

                oImg = new HtmlImage();
                oImg.Attributes["src"] = dr["imgEstado"].ToString();
                oImg.Attributes["width"] = "40px";
                oImg.Attributes["height"] = "40px";
                e.Row.Cells[8].Controls.Add(oImg);

                string imgAProb = "";
                    switch(dr["IdEstadoAProb"].ToString()){
                    case "2":
                        imgAProb = EasyUtilitario.Constantes.ImgDataURL.IconEnEspera;
                        break;
                    case "3":
                        imgAProb = EasyUtilitario.Constantes.ImgDataURL.IconAprobado;
                        break;
                    case "4":
                        imgAProb = EasyUtilitario.Constantes.ImgDataURL.IconDesaprobado;
                        break;
                }

                oImg = new HtmlImage();
                oImg.Attributes["src"] = imgAProb;
                oImg.Attributes["width"] = "40px";
                oImg.Attributes["height"] = "40px";
                oImg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "AdministrarSolicitudAprobacion.AprobarDesaprobar(this);");
                e.Row.Cells[9].Controls.Add(oImg);
            }

        }

        protected void btnPrevioRpt_Click(object sender, EventArgs e)
        {
            string strID = ((System.Web.UI.Page)HttpContext.Current.Handler).Request["__EVENTARGUMENT"];

            Dictionary<string,string> Param= EasyUtilitario.Helper.Data.SeriaizedDiccionario(strID);
            Dictionary<string, string> Data = this.EasyGridView1.getDataRow(Param["Guid"].ToString());

            DataSet ds = (new Proceso()).ReporteFichaTecnica(Data["IdInspeccion"].ToString(), this.IdReporteInspeccion, Convert.ToInt32(Data["IdUsuarioRegistro"].ToString()), this.UsuarioLogin);
            string NombreRptFI = "RI-" + Data["NombreProyecto"].ToString() + Data["NroReporte"].ToString() + ".pdf";

            int NroAproba = 0;
            foreach (DataRow drf in (new ControlInspeccionesSoapClient()).ListarUsuariosFirmantes(Data["IdInspeccion"].ToString(), "0", this.UsuarioLogin).Select("IdEstado=3"))
            {
                NroAproba++;
            }

            if (NroAproba == 3)//Verifica si esta autorizado para imprimir RI
            {
                (new GenerarPdf()).PrintPrevio(this.IdReporteInspeccion, NombreRptFI, this.UsuarioLogin, ds, EasyGridView1);
            }
            else
            {
                string FileSelloAgua = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "FileSelloAgua");
                (new GenerarPdf()).PrintPrevioWatermark(this.IdReporteInspeccion, NombreRptFI, FileSelloAgua, this.UsuarioLogin, ds, EasyGridView1);
            }
           
        }

        protected void EasyGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
        }

        protected void EasyGestorFiltro1_ProcessCompleted(string FiltroResultante, List<EasyFiltroItem> lstEasyFiltroItem)
        {
            this.LlenarGrilla(FiltroResultante);
        }

        protected void EasyGestorFiltro1_ItemCriterio(EasyGestorFiltro.ModoEditFiltro Modo, EasyFiltroItem oEasyFiltroItem)
        {
            if (Modo == EasyGestorFiltro.ModoEditFiltro.Add)
            {
                this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
            }
        }
    }
}