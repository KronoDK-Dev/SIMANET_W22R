using DocumentFormat.OpenXml.Presentation;
using DocumentFormat.OpenXml.Wordprocessing;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Base;
using EasyControlWeb.InterConeccion;

using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.BandejaEntrada
{
    public partial class ListarSprint : HelpDeskBase,IPaginaBase, IPaginaMantenimento
    {
        //https://www.bootdey.com/snippets/view/bs4-user-card-task-list#html
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {

                if (!Page.IsPostBack)
                {
                    Response.AppendHeader("Cache-Control", "no-cache");
                    this.LlenarDatos();
                }
            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;

                this.LanzarException(NombreMetodo, ex);
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
            Page.Controls.Add(HTMSprint());
        }

        HtmlGenericControl HTMSprint() {
            HtmlGenericControl htmlContainerCard = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "container d-flex justify-content-center mt-7");
            HtmlGenericControl htmlCard = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "cardTask");

            DataRow[] drResponsable = (new AdministrarAtencion()).ListarResponsableAtencion(this.IdRequerimiento).Select("IDPERSONALO7=" + this.IdPersonal);

            htmlCard.Controls.Add(HtmlHeaderCard(drResponsable[0]));
            foreach (DataRow drSprint in (ListarSprints(this.IdRequerimiento,this.IdPersonal,"0").GetDataTable()).Rows)
            {
                htmlCard.Controls.Add(HtmlBodyCard(drSprint));
            }

            htmlContainerCard.Controls.Add(htmlCard);

            return htmlContainerCard;
        }
        HtmlGenericControl HtmlHeaderCard(DataRow drResponsable) {
            HtmlGenericControl Header = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "top-container");
            HtmlGenericControl FotoResponsable = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("img", "ms-n2 rounded-circle img-fluid profile-image");
           // HtmlGenericControl DatosResponsable = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("img", "img-fluid profile-image");

            FotoResponsable.Attributes.Add("width", "70");
            FotoResponsable.Attributes.Add("src", this.PathFotosPersonal + drResponsable["NRODOCDNI"].ToString() + ".jpg");

            Header.Controls.Add(FotoResponsable);
            
            //dATOS DEL RESPONSABLE DE ATENCION
            HtmlGenericControl htmlDiv = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "ml-3");
                HtmlGenericControl HTMLName = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("h5", "name");
                HTMLName.InnerText = drResponsable["APELLIDOSYNOMBRES"].ToString();
            htmlDiv.Controls.Add(HTMLName);
            
                HtmlGenericControl HTMLEMAIL = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("p", "mail");
                HTMLEMAIL.InnerText = drResponsable["EMAIL"].ToString();
            htmlDiv.Controls.Add(HTMLEMAIL);

            Header.Controls.Add(htmlDiv);
            //Crea la IMagen para eliminar
            //style='position:absolute;right:30px;top:5px' 
            string Cmll = "\"";
            Header.Controls.Add(new LiteralControl("<img width='25px' style='cursor: pointer;' DataBE = " + Cmll + EasyUtilitario.Helper.Genericos.DataRowToStringJson(drResponsable).Replace(Cmll,"'") + Cmll + "  onclick ='ListarSprint.Eliminar(this);'  src='" + EasyUtilitario.Constantes.ImgDataURL.IconDeItem.ToString() + "'  /img>"));

            //Registro el ProgressCircle
            Header.Controls.Add(new LiteralControl("<div class='progress-bar-container'><div class='progress-barC html'><progressc id = 'html' min='0' max='100' value='" + drResponsable["AVANCE"].ToString() + "'></progressc></div></div>"));
            //Registra el estilo para que refleje el avance 
            Page.Controls.Add(new LiteralControl("<style>@keyframes html-progress {to { --progress-value:"+ drResponsable["AVANCE"].ToString() + "; }}</style>"));

            return Header;
        }

        HtmlGenericControl HtmlBodyCard(DataRow drSprint) {
            bool ConSprint = false;
            HtmlGenericControl Body = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "middle-container recent-border   align-items-center mt-3 p-2");

         //   foreach (DataRow drSprint in ListarSprints().Rows){
                HtmlTable otblItem = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(3, 1);
                otblItem.Rows[0].Cells[0].InnerText = drSprint["ACTIVIDAD"].ToString();
                otblItem.Rows[1].Cells[0].InnerText = drSprint["DESCRIPCATIVIDAD"].ToString();
                //Datos de Programacion y avance

                        HtmlTable otblAvance = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 6);
                        otblAvance.Attributes["style"] = "Width:100%";
                        //inicio
                        otblAvance.Rows[0].Cells[0].InnerText = "INICIO:";
                        otblAvance.Rows[0].Cells[0].Attributes["class"] = "Font-Title";
                        otblAvance.Rows[0].Cells[1].InnerText = drSprint["F_INICIO"].ToString().Substring(0,10);
                        //Duracion
                        otblAvance.Rows[0].Cells[2].InnerText = "DURACION:";
                        otblAvance.Rows[0].Cells[2].Attributes["class"] = "Font-Title";
                        otblAvance.Rows[0].Cells[3].InnerText = drSprint["DURACION"].ToString() + " " + drSprint["TIPODURACION"].ToString(); 
                        //avance
                        otblAvance.Rows[0].Cells[4].InnerText = "AVANCE:";
                        otblAvance.Rows[0].Cells[4].Attributes["class"] = "Font-Title";
            // otblAvance.Rows[0].Cells[5].Controls.Add(HtmlProgressBar(drSprint["AVANCE"].ToString()));
            EasyProgressBar oEasyProgressBar = new EasyProgressBar();
              oEasyProgressBar.Progreso = Convert.ToInt32(drSprint["AVANCE"].ToString());
              oEasyProgressBar.ImgProgreso = "http://localhost/SIMANET_W22R/Recursos/img/NavTree.jpg";
              otblAvance.Rows[0].Cells[5].Controls.Add(oEasyProgressBar);
              otblAvance.Rows[0].Cells[5].Attributes["style"] = "Width:100%";

            /*EasyProgressbarBase oEasyProgressBar = new EasyProgressbarBase();
            oEasyProgressBar.Progreso = Convert.ToInt32(drSprint["AVANCE"].ToString());
            otblAvance.Rows[0].Cells[5].Controls.Add(oEasyProgressBar);*/


            otblItem.Rows[2].Cells[0].Controls.Add(otblAvance);


                Body.Controls.Add(otblItem);
                ConSprint = true;
          //  }
            if (ConSprint == false) {
                Body.Controls.Add(new LiteralControl("No existen Sprints definidos.."));
            }
            return Body;
        }
        public EasyDataInterConect ListarSprints(string IdReq,string IdPers,string IdPlanTrabajo)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "RequerimientoResponsableSprint_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            // oParam.Paramvalue = this.IdRequerimiento;
            oParam.Paramvalue = IdReq;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdPersonal";
            oParam.Paramvalue = IdPers;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdPlandeTrabajo";
            oParam.Paramvalue = IdPlanTrabajo;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            //  return ((DataTable)odi.GetDataTable());
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

        public void Agregar()
        {
            throw new NotImplementedException();
        }

        public void Modificar()
        {
            throw new NotImplementedException();
        }

        public void Eliminar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoPagina()
        {
            throw new NotImplementedException();
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoConsulta()
        {
            throw new NotImplementedException();
        }

        public bool ValidarCampos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarCamposRequeridos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarExpresionesRegulares()
        {
            throw new NotImplementedException();
        }
    }
}