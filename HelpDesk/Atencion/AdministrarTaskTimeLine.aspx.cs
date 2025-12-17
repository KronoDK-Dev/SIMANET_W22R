using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using Microsoft.SqlServer.Server;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO.Packaging;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Atencion
{
    public partial class AdministrarTaskTimeLine : HelpDeskBase, IPaginaBase
    {
        string cmll = "\"";

        protected void Page_Load(object sender, EventArgs e)
        {
            PanelLT.Controls.Add(HeaderLineTime());
            PanelLT.Controls.Add(new LiteralControl("<a href='#' data-bs-toggle='modal' data-bs-target='.add-new' class='btn btn-primary' onclick='AdministrarTaskTimeLine.AgregarEvento()'><i class='fa fa-plus me-1'></i> Nuevo </a>"));
            PanelLT.Controls.Add(LineaTiempo());
            //VALOR DE PROGRESO DE AVANCE
            Page.Controls.Add(new LiteralControl("<style>@keyframes html-progress {to { --progress-value:" + this.Avance + "; }}</style>"));

        }
        Control HeaderLineTime() {
            string htmlHeader = @"<div class='title'>
                                      <h2>"+ this.NombreTarea + @"</h2>
                                      <div class='progress-bar-container'><div class='progress-barC html'><progressc id = 'html' min='0' max='100' value='" + this.Avance + @"'></progressc></div></div>
                                            <div class='alert fade alert-simple alert-info alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show' role='alert' data-brk-library='component__alert'>
                                                " + this.DescripcionTarea + @"
                                            </div>
                                  </div>";
            return new LiteralControl(htmlHeader);
        }
        HtmlGenericControl LineaTiempo() {
            HtmlGenericControl lt = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "timeline");
            HtmlGenericControl Container = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "container");
            HtmlGenericControl oRow = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "row");
            HtmlGenericControl oCol = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "col-lg-12");
            HtmlGenericControl TimeLineContainer = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "timeline-container");
            //Aqui incluir todos los elemento como eventos de la linea de tiempo
                TimeLineContainer.Controls.Add(PuntoFinal());
                TimeLineContainer.Controls.Add(LineaContinua());
                TimeLineContainer.Controls.Add(PuntoIncial());

            oCol.Controls.Add(TimeLineContainer);
                oRow.Controls.Add(oCol);
                Container.Controls.Add(oRow);
            lt.Controls.Add(Container);
            return lt;
        }

        Control PuntoFinal() {
            string htmlFinal = @"<div class=""timeline-end"">
                                    <p>AHORA</p>
                                  </div>";
            return new LiteralControl(htmlFinal);
        }
        Control PuntoIncial() {
            string htmlInicial = @" <div class='timeline-start'>
                                <p>INICIO</p>
                              </div>
                            ";
            return new LiteralControl(htmlInicial);
        }

        Control DatosInicioTarea(string FIniciTask) { 
            string  Lanzamiento= @" <div class='timeline-launch'>
                                       <div class='timeline-box'>
                                         <div class='timeline-text'>
                                           <h3>Fecha de Inicio de la tarea " + FIniciTask + @"</h3>
                                           <p>Erosales</p>
                                         </div>
                                       </div>
                                     </div>";
            return new LiteralControl(Lanzamiento);
        }

        HtmlGenericControl LineaContinua() { 
            HtmlGenericControl TimeLineContinue = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "timeline-continue");
            //Aqui la histia de eventos e la linea de tiempo
            int i = 0;
            foreach (DataRow dr in ObtenerHistoriadeTarea(this.IdTareaItemCronograma).GetDataTable().Rows)
            {
                if ((i % 2) == 0)
                {
                    TimeLineContinue.Controls.Add(EventRigth(dr));
                }
                else{

                    TimeLineContinue.Controls.Add(Eventleft(dr));
                }
                i++;
            }
            return TimeLineContinue;
        }
        string ToolBar(string className, DataRow drItem) {
            string sData = EasyUtilitario.Helper.Genericos.DataRowToStringJson(drItem).ToString().Replace(cmll, "'");
            return @"<div class='"+ className + @"'>
                         <div>
                           <a class='dateit' Data=" + cmll + sData + cmll+ @"  onclick='AdministrarTaskTimeLine.TimeLine.ToolBar("+ cmll + "Edit"  + cmll + @",this)' ><i class='fa fa-pencil pr-1' style='color:navy'></i> Edit </a>
                           <a class='locit' Data=" + cmll + sData + cmll+ @"  onclick='AdministrarTaskTimeLine.TimeLine.ToolBar("+ cmll + "Del"  + cmll + @",this)'><i class='fa fa-trash pr-1' style='color:red'></i> Del</a>
                           <a class='locit' Data=" + cmll + sData + cmll+ @"  onclick='AdministrarTaskTimeLine.TimeLine.ToolBar("+ cmll + "UpLoad"  + cmll + @",this)'><i class='fa fa-paperclip pr-1'></i>Adjuntar</a>
                           <a class='locit' Data=" + cmll + sData + cmll+ @"  onclick='AdministrarTaskTimeLine.TimeLine.ToolBar("+ cmll + "User"  + cmll + @",this)'><i class='fa fa-users pr-1'></i>Pers</a>
                         </div>
                     </div>
                     ";
        }

        Control EventRigth(DataRow drr) {
            string Hmlr = @"<div class='row timeline-right'>
                                  <div class='col-md-6'>
                                    <p class='timeline-date'>
                                      " + drr["FECHA"].ToString().Substring(0, 10) + @"
                                    </p>
                                  </div>
                                  <div class='col-md-6'>
                                    <div class='timeline-box'>
                                      <div class='timeline-icon'>
                                        <i class='" + drr["ICONOTIPO"].ToString() +@"'></i>
                                         " + FechaSuceso(drr["FECHA"].ToString().Substring(0, 10), "timeline-dateFlagR") + @"
                                      </div>
                                      <div class='timeline-textR'>
                                        <h3>"+ drr["TITULOACCION"].ToString() +@"</h3>
                                        <p>" + drr["DESCRIPCION"].ToString() + @"</p>
                                        <p>TIEMPO DEDICADO:" + drr["VALTIME"].ToString() + " (" + drr["NOMBRETIEMPO"].ToString() + @")</p>
                                      </div>
                                       " + ToolBar("footerRigth", drr) + @"
                                       " + HtmlParticipantes(drr["ID_HISTORY"].ToString()) + @"
                                    </div>
                                    
                                  </div>
                                </div>";
            return (new LiteralControl(Hmlr));
        }
        string MesAbreviado(int IdMes){
            string[] MAbrev = { "Ene", "Feb","Mar","Abr","May","Jun","Jul","Ago","Set","Oct","Nov","Dic" };
            return MAbrev[IdMes - 1];
        }

        string FechaSuceso(string Fecha,string ClassDate) {
            string Dia = Fecha.Split('/')[0];
            int Mes = Convert.ToInt32(Fecha.Split('/')[1]);
            return @"<div class='event-content'>
                                <div class='"+ ClassDate + @" bg-primary text-center rounded float-end'>
                                    <h3 class='text-white mb-0 fs-17'>"+ Dia + @"</h3>
                                    <p class='mb-0 text-white-50'>"+ MesAbreviado(Mes) + @"</p>
                                </div>
                              </div>";
        }

        string LstUser = @" <div class='card-attribute'>
                                <img src='https://i.postimg.cc/SQBzNQf1/image-avatar.png' alt='' avatar'' class='small-avatar'/>
                              </div>";

        string HtmlParticipantes(string IdHistory) {
            string LstUser = "";
            foreach (DataRow drp in ObtenerParticipantes(IdHistory).GetDataTable().Rows)
            {
                LstUser += " <img src='" + this.PathFotosPersonal + drp["NRODOCDNI"].ToString() + ".jpg' id='" + drp["ID_PARTICIPANTE"].ToString() + "' class='ms-n2 rounded-circle img-fluid' onerror='this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;' style='width:32px; height: 32px; object-fit: cover;'>";
            }
            return @"<div classname='d-flex mb-5'>
                                " + LstUser  + @"
                     </div>";

        }
    





        Control Eventleft(DataRow drr)
        {
            string HmlL = @"<div class='row timeline-left'>
              <div class='col-md-6 d-md-none d-block'>
                <p class='timeline-date'>
                  " + drr["FECHA"].ToString().Substring(0, 10) + @"
                </p>
              </div>
              <div class='col-md-6'>
                <div class='timeline-box'>
                  <div class='timeline-icon d-md-none d-block'>
                    <i class='" + drr["ICONOTIPO"].ToString() +@"'></i>
                  </div>
                  <div class='timeline-text'>
                    <h3>"+ drr["TITULOACCION"].ToString() +@"</h3>
                    <p>" + drr["DESCRIPCION"].ToString() + @"</p>
                    <p>TIEMPO DEDICADO:" + drr["VALTIME"].ToString() + " (" + drr["NOMBRETIEMPO"].ToString() + @")</p>
                     " + ToolBar("footerLeft", drr) + @"
                     " + HtmlParticipantes(drr["ID_HISTORY"].ToString()) + @"
                  </div>
                
                  <div class='timeline-icon d-md-block d-none'>
                    <i class='" + drr["ICONOTIPO"].ToString() +@"'></i>
                     " + FechaSuceso(drr["FECHA"].ToString().Substring(0, 10), "timeline-dateFlagL") + @"
                  </div>
                 
                </div>
                  
              </div>
              <div class='col-md-6 d-md-block d-none'>
                <p class='timeline-date'>
                  " + drr["FECHA"].ToString().Substring(0,10) + @"
                </p>
              </div>
            </div>";

            return (new LiteralControl(HmlL));
        }
        

        public EasyDataInterConect ObtenerHistoriadeTarea(string IdTareaItemCrono) {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "PlanCronogramaActividadTaskHistory_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            
            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTarea";
            oParam.Paramvalue = IdTareaItemCrono;
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

        public EasyDataInterConect ObtenerParticipantes(string IdHistory)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "PlanCronogramaActividadTaskHistory_Participantes";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdHistoria";
            oParam.Paramvalue = IdHistory;
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

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
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