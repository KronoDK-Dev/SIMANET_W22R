using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.EasyUtilitario.Helper;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class AdminstrarUsuariosFirmantes : PaginaCalidadBase,IPaginaBase
    {

        string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
        UsuarioBE oUsuarioBE;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarJScript();
                    this.LlenarDatos();
                    this.LlenarGrilla();
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
            string backslash = "\\";
            this.txtPathFirma.Text = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "CalidadPathFirma").Replace(backslash, ".");
            this.txtIdInspeccion.Text = this.IdInspeccion;
        }
        



        public void LlenarGrilla()
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                 DataTable dt = oCalidad.ListarUsuariosFirmantes(this.IdInspeccion, "0", this.UsuarioLogin);
                
                EasyGridViewFirmantes.DataSource = dt;
                EasyGridViewFirmantes.DataBind();
            }
            catch (Exception ex)
            {
                string dd = "ss";
            }
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            this.txtPathFirma.Style.Add("display", "none");
            this.txtIdInspeccion.Style.Add("display", "none");
            oUsuarioBE = (new SeguridadSoapClient()).GetDatosUsuario(this.UsuarioId);
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

        protected void EasyGridViewFirmantes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string PathHTTP = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "CalidadHttpFirma");

                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;

                HtmlImage oImg = new HtmlImage();

                HtmlTable tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 3);
                string UrlFoto = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFotos");
                oImg.ID = dr["NroDocDni"].ToString();
                string FotoPersona= UrlFoto + dr["NroDocDni"].ToString() + ".jpg";
                oImg.Src = FotoPersona;
                oImg.Attributes.Add("class", "ms-n2 rounded-circle img-fluid");
                oImg.Attributes["onerror"] = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;";
                // oImg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.ondblclick.ToString(), "AdminstrarUsuariosFirmantes.SolicitaAprobacion(this);");
                oUsuarioBE = (new SeguridadSoapClient()).GetDatosUsuario(this.UsuarioId);
                if (dr["IdPersonaFirmante"].ToString() != oUsuarioBE.IdPersonal.ToString())
                {
                    oImg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.ondblclick.ToString(), "AdminstrarUsuariosFirmantes.Find(this);");
                }

                oImg.Style.Add("width", "60px");
                oImg.Style.Add("Height", "60px");
                tbl.Rows[0].Cells[0].Controls.Add(oImg);


                oImg = new HtmlImage();
                oImg.Attributes.Add("src",EasyUtilitario.Constantes.ImgDataURL.IconSendEmail);
                oImg.Attributes.Add("ClassN", "ms-n2 rounded-circle img-fluid");
                
                oImg.Style.Add("width", "25px");
                if (dr["IdPersonaFirmante"].ToString() != oUsuarioBE.IdPersonal.ToString())
                {
                    oImg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "AdminstrarUsuariosFirmantes.SolicitaAprobacion(this);");
                }


                if (dr["NroEnvios"].ToString()!= "0")
                {
                    HtmlGenericControl dvBadge = new HtmlGenericControl("div");
                    dvBadge.Style.Add("display", "inline-block");
                    dvBadge.Attributes.Add("width", "50px");
                    HtmlGenericControl Badge = new HtmlGenericControl("span");
                    Badge.Attributes.Add("class", "badge");
                    Badge.InnerText = dr["NroEnvios"].ToString();
                    dvBadge.Controls.Add(Badge);
                    dvBadge.Controls.Add(oImg);
                    tbl.Rows[0].Cells[2].Controls.Add(dvBadge);
                }
                else
                {
                    tbl.Rows[0].Cells[2].Controls.Add(oImg);
                }
                


                tbl.Rows[0].Cells[1].InnerText = dr["ApellidosyNombres"].ToString();
                tbl.Rows[0].Cells[0].Style.Add("width", "20%");
                tbl.Rows[0].Cells[1].Style.Add("width", "70%");
                tbl.Rows[0].Cells[2].Style.Add("width", "10%");
                tbl.Style.Add("width", "100%");

                e.Row.Cells[2].Controls.Add(tbl);

                oImg = new HtmlImage();
                oImg.Attributes["imgFirma"] = PathHTTP + dr["Firma"].ToString();


                if (dr["IdEstado"].ToString().Equals("3"))
                {
                    oImg.Src = PathHTTP + dr["Firma"].ToString();
                    oImg.Style.Add("width", "90px");
                    oImg.Style.Add("Height", "40px");
                    e.Row.Cells[3].Controls.Add(oImg);
                }
                else if (dr["IdEstado"].ToString().Equals("4"))
                {
                    oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconDesaprobado;
                    oImg.Style.Add("width", "40px");
                    oImg.Style.Add("Height", "40px");
                    e.Row.Cells[3].Controls.Add(oImg);
                }
                else
                {
                    oImg.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconEnEspera;
                    oImg.Style.Add("width", "40px");
                    oImg.Style.Add("Height", "40px");
                    e.Row.Cells[3].Controls.Add(oImg);
                }

            }
        }
    }
}