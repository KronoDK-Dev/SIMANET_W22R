using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Base;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.GestionReportes;
using SIMANET_W22R.HelpDesk.BandejaEntrada;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Atencion
{
    public partial class AdministraGantt : HelpDeskBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!Page.IsPostBack)
                {
                    this.LlenarDatos();
                    this.LlenarGrilla();
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
        public void LlenarDatos()
        {
            foreach(DataRow drPlan in (new AdministrarPlandeTrabajo()).ObtenerPlanPorRequerimiento(this.IdRequerimiento).GetDataTable().Rows){
                if (drPlan["ID_PLAN"].ToString().Equals(this.IdPlandeTrabajo))
                {
                    EasyProgressbarBase oEasyProgressBar = new EasyProgressbarBase();
                    oEasyProgressBar.Progreso = Convert.ToInt32(drPlan["AVANCE"].ToString());
                    ContentProgress.Controls.Add(oEasyProgressBar);
                }
            }
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }


        public void LlenarCombos()
        {
            throw new NotImplementedException();
        }

       
        public void LlenarGrilla()
        {
            EasyGridSprint.ID = "grid_" + this.IdPlandeTrabajo.Replace("-","_");
            EasyGridSprint.DataInterconect = (new ListarSprint()).ListarSprints(this.IdRequerimiento, this.IdPersonal,this.IdPlandeTrabajo);
            EasyGridSprint.LoadData();
            
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

        protected void EasyGridSprint_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                    DataRowView drv = (DataRowView)e.Row.DataItem;
                    DataRow dr = drv.Row;
                    e.Row.Cells[1].Attributes["title"] = dr["ACCION"].ToString();

                    foreach (DataRow drtarea in ListadoTareaPorAccionActividad(dr["ID_ITEM"].ToString(),"0").GetDataTable().Rows)
                    {
                        e.Row.Cells[4].Controls.Add(CardTask(drtarea,dr));
                    }

                    EasyProgressbarBase oEasyProgressBar = new EasyProgressbarBase();
                    oEasyProgressBar.Progreso = Convert.ToInt32(dr["AVANCE"].ToString());
                    e.Row.Cells[5].Controls.Add(oEasyProgressBar);


                HtmlImage oimg = EasyUtilitario.Helper.HtmlControlsDesign.CrearImagen(EasyUtilitario.Constantes.ImgDataURL.IconDelete);
                    oimg.Style.Add("Width", "25px");
                    oimg.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "AdministraGantt.EliminarActividad('" + dr["ID_ITEM"].ToString() + "')";
                    e.Row.Cells[6].Controls.Add(oimg);
            }
        }

        public EasyDataInterConect ListadoTareaPorAccionActividad(string IdAccion,string IdTarea) {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "PlandeTrabajoTareas_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdItem";
            oParam.Paramvalue = IdAccion;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTarea";
            oParam.Paramvalue = IdTarea;
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


        HtmlGenericControl CardTask(DataRow drTask,DataRow drItemCrono) {
            string cmll = "\"";
            HtmlGenericControl CardRecipiente = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", "recipe-card caja");
            HtmlGenericControl Articulo = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("article");
            HtmlGenericControl h2 = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("h2");
            h2.InnerText = drTask["NOMBRETAREA"].ToString();
            Articulo.Controls.Add(h2);

            

            string sInfo = @"<ul>
                             <li><span class='icon icon-users' style='cursor:pointer;' onclick='AdministraGantt.SeleccionarActividadesProcesoRqr(" + cmll + drTask["ID_TAREA"].ToString()  + cmll + "," + cmll + drItemCrono["ID_ITEM"].ToString() + cmll + @")'></span><span>1</span></li>
                             <li><span class='icon icon-clock' style='cursor:pointer;' onclick='AdministraGantt.Task.LineaTiempo(" + cmll + drTask["ID_TAREA"].ToString() + cmll + @"," + cmll + drTask["NOMBRETAREA"].ToString().Replace("\r\n", "").Trim() + cmll + "," + cmll + drTask["ACCIONTOMADA"].ToString() + cmll + "," + cmll + drTask["AVANCE"].ToString() + cmll +")'></span><span>" + drTask["VALTIME"].ToString() +" " + drTask["ABREV_TIME"].ToString() + @"</span></li>
                             <li><span class='icon icon-level'></span><span>" + drTask["AVANCE"].ToString() +"% " + @"</span></li>
                             <li><span></span><img width='25px' src='" + EasyUtilitario.Constantes.ImgDataURL.IconDelete  + @"' style='cursor:pointer;' onclick = 'AdministraGantt.EliminarTarea(" + cmll + drTask["ID_TAREA"].ToString()  + cmll + @")'> <span></span></li>
                           </ul>
                           ";

            Articulo.Controls.Add(new LiteralControl(sInfo));
            


            string AccionTomada = " <p class='Parrafo'><span class='TituloAccion' style='cursor:pointer;' onclick='AdministraGantt.DetalledeTarea(" + cmll + drTask["ID_TAREA"].ToString()  + cmll + "," + cmll + drItemCrono["ID_ITEM"].ToString() + cmll +"," + cmll + drItemCrono["ID_ACTIVIDAD"].ToString() + cmll + " )'>Acción tomada:&nbsp;</span>" + drTask["ACCIONTOMADA"].ToString() + ".</p>";
            Articulo.Controls.Add(new LiteralControl(AccionTomada));
            CardRecipiente.Controls.Add(Articulo);
          
            return CardRecipiente;
        }

    }
}