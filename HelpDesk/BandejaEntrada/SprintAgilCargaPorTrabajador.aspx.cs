using DocumentFormat.OpenXml;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO.Packaging;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.BandejaEntrada
{
    public partial class SprintAgilCargaPorTrabajador : HelpDeskBase, IPaginaBase, IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!Page.IsPostBack)
                {
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
            DataTable dt = ListarRecursos();

            /* HtmlTable tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(dt.Rows.Count, 2);
             tbl.Style.Add("width", "100%");
             int i = 0;
             int Fila = 0;
             foreach (DataRow dr in dt.Rows) {
                 HtmlGenericControl CtrCard = CardCtrlSprint(dr);
                 int Col = i % 2;
                 tbl.Rows[Fila].Cells[Col].Controls.Add(CtrCard);
                 if (Col == 1)
                 {
                     Fila++;
                 }
                 i++;
             }

             Contenedor.Controls.Add(tbl); 
             */

            foreach (DataRow dr in dt.Rows)
            {
                Contenedor.Controls.Add(CardSprints(dr));
            }
        }

        Control CardSprints(DataRow drPer) {
            string check = ((drPer["ASIGNADO"].ToString() == "1") ? " checked=true" : "");
            string htmlCard = @" <div class='col-sm-6'>
                                       <div class='" + ((drPer["ASIGNADO"].ToString() == "1")? "cardSelect" : "card") + @"'>
                                           <div class='img'>
                                             <img src='"+ this.PathFotosPersonal + drPer["NRODOCDNI"].ToString()+ ".jpg" + @"'>
                                           </div>
                                           <div class='infos'>
                                                 <div class='name'>
                                                   <h2>" + drPer["APELLIDOSYNOMBRES"].ToString() + @"</h2>
                                                   <h4>" + drPer["PTREMAIL"].ToString() + @"</h4>
                                                 </div>
                                                 <p class='text'>
                                                  " + drPer["PUESTO"].ToString() + @"
                                                 </p>
                                                   <ul class='stats'>
                                                   <li>
                                                     <h3>" + drPer["SIN_INICIAR"].ToString() + @"</h3>
                                                     <h4>Sin Ini</h4>
                                                   </li>
                                                   <li>
                                                     <h3> " + drPer["EN_PROCESO"].ToString() + @"</h3>
                                                     <h4>Proceso</h4>
                                                   </li>
                                                   <li>
                                                     <h3>" + drPer["TOTAL"].ToString() + @"</h3>
                                                     <h4>Total</h4>
                                                   </li>
                                                 </ul>
                                                    <div class='d-flex justify-content-end'>
                                                        <div class='checkbox-wrapper-34'>
                                                            <input class='tgl tgl-ios' name='Recurso' ASIGNADO='" + drPer["ASIGNADO"].ToString()  + "'  id='" + drPer["PTRCODTRA"].ToString() + @"' idRespAten='" + drPer["ID_RESP_ATE"].ToString() + "'  type='checkbox'   " + check + @" />
                                                            <label class='tgl-btn' for='" + drPer["PTRCODTRA"].ToString() + @"'></label>
                                                        </div>
                                                    </div>
                                           </div>
                                       </div>
                                 </div>";
            return new LiteralControl(htmlCard);
        }
        HtmlGenericControl CardCtrlSprint(DataRow drPer) {
            HtmlGenericControl HTMLCard = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "two");
            string HtmlFoto = @"<div class='px-3'><div class='round'><img src='"+ this.PathFotosPersonal + drPer["NRODOCDNI"].ToString()+ ".jpg" + @"' width='60' class='ms-n2 rounded-circle img-fluid'/></div></div>";
            HTMLCard.Controls.Add(new LiteralControl(HtmlFoto));
            string Email = drPer["PTREMAIL"].ToString();
            if (Email.Length > 0)
            {
                int pos = Email.IndexOf('@');
                Email = Email.Substring(0, pos);
            }
            else {
                Email= drPer["APELLIDOSYNOMBRES"].ToString();
            }

                string htmlDatos = "<div class='px-3 pt-3'><h3 class='name'>" + Email + "</h3></div>";
            HTMLCard.Controls.Add(new LiteralControl(htmlDatos));


            htmlDatos = "<div class='d-flex justify-content-start px-3 align-items-center'><i class='fa fa-bookmark'></i><span class='quote2 pl-2'>Sin Iniciar: " + drPer["SIN_INICIAR"].ToString() + "</span></div>";
            HTMLCard.Controls.Add(new LiteralControl(htmlDatos));
            
            htmlDatos = "<div class='d-flex justify-content-start px-3 align-items-center'><i class='fa fa-calendar'></i><span class='quote2 pl-2'>En Proceso: " + drPer["EN_PROCESO"].ToString() + "</span></div>";
            HTMLCard.Controls.Add(new LiteralControl(htmlDatos));

            htmlDatos = "<div class='d-flex justify-content-between  px-3 align-items-center pb-3'><div class='d-flex justify-content-start align-items-center'><i class='fa fa-tags'></i><span class='quote2 pl-2'>Total:" + drPer["TOTAL"].ToString() + "</span></div>";
            HTMLCard.Controls.Add(new LiteralControl(htmlDatos));

            string total = drPer["TOTAL"].ToString();
            string check = ((drPer["ASIGNADO"].ToString()=="1") ? " checked=true" : "");

            htmlDatos = "<div class='d-flex justify-content-end'><input name='Recurso' ASIGNADO='" + drPer["ASIGNADO"].ToString()  + "'  id='" + drPer["PTRCODTRA"].ToString() + "' idRespAten='" + drPer["ID_RESP_ATE"].ToString() + "'  type='checkbox' "  + check + " /></div>";

            HTMLCard.Controls.Add(new LiteralControl(htmlDatos));

            return HTMLCard;
        }

        public DataTable ListarRecursos()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "RecurosDisponiblePorArea_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            oParam.Paramvalue = this.IdRequerimiento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "CodigoArea";
            oParam.Paramvalue = (new AdministrarAtencion()).ObtenerCodArea();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = this.UsuarioId.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            return ((DataTable)odi.GetDataTable());
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