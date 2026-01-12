using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data;
using EasyControlWeb.Form.Controls;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.HelpDesk.Requerimiento;
using System.Web.UI.HtmlControls;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Base;

namespace SIMANET_W22R.HelpDesk.BandejaEntrada
{
    public partial class AdministrarAtencion :  HelpDeskBase, IPaginaBase
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
            throw new NotImplementedException();
        }

        public string ObtenerCodArea() {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/GestionPersonal/Personal.asmx";
            odi.Metodo = "DetallePersonaO7xCodigo";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdPersonal";
            oParam.Paramvalue = this.DatosUsuario.CodPersonal;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            EasyBaseEntityBE oPersonal = odi.GetEntity();
            return oPersonal.GetValue("CodigoArea");
        }

        EasyDataInterConect ObtenerDatos(string IdRqrPadre) {
            EasyDataInterConect odic = new EasyDataInterConect();
            odic.ConfigPathSrvRemoto = "PathBaseWSCore";
            odic.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odic.UrlWebService = "/HelpDesk/AdministrarHD.asmx";
            odic.Metodo = "BandejadeEntrada";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "CodigoArea";
            oParam.Paramvalue = ObtenerCodArea();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = this.UsuarioId.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRqrPadre";
            oParam.Paramvalue = IdRqrPadre;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);
            return odic;
        } 

        public void LlenarGrilla()
        {
            EasyGridView1.DataInterconect = ObtenerDatos("0");
            EasyGridView1.LoadData();
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

        //string IdRqrPadre = "";
       

        void PaintRow(GridViewRow oGvr,DataRow odrItem) {

            //Quien Solicita
            oGvr.Cells[2].Controls.Add(HTMLSolicitante(odrItem));
            //Path del servicio
            oGvr.Cells[4].Controls.Add(ControlPath(odrItem["PATHSERVICE"].ToString()));

            //Lista de Responsables
            oGvr.Cells[6].Style.Add("padding-left", "20px");
            oGvr.Cells[6].Style.Add("padding-top", "8px");
            oGvr.Cells[6].Controls.Add(HtmlResponsable(odrItem["ID_REQU"].ToString()));

            EasyProgressbarBase oEasyProgressBar = new EasyProgressbarBase();
            oEasyProgressBar.Progreso = Convert.ToInt32(odrItem["PORCAVANCE"].ToString());
            oGvr.Cells[7].Controls.Add(oEasyProgressBar);

            HtmlImage OIMG = EasyUtilitario.Helper.HtmlControlsDesign.CrearImagen(odrItem["ICONOEST"].ToString());
            oGvr.Cells[8].Controls.Add(OIMG);

        }

        public EasyPathHistory ControlPath(string strPath) {
            EasyPathHistory oEasyPathHistory = new EasyPathHistory();
            string[] PathItem = strPath.Split('|');
            List<string> list = PathItem.ToList();
            list.Reverse();
            foreach (string str in list)
            {
                EasyPathItem oEasyPathItem = new EasyPathItem();
                oEasyPathItem.Id = str.Replace(" ", "");
                //  oEasyPathItem.ClassName = "fa fa-venus-mars";
                oEasyPathItem.Descripcion = "";
                oEasyPathItem.Titulo = str;

                oEasyPathHistory.PathCollections.Add(oEasyPathItem);
            }
            oEasyPathHistory.PathHome = true;
            oEasyPathHistory.TipoPath = PathStyle.Tradicional;
            return oEasyPathHistory;
        }


        protected void EasyGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                try
                {
                    DataRowView drv = (DataRowView)e.Row.DataItem;
                    DataRow dr = drv.Row;

                    int SubNiv = 1;
                    if (Convert.ToInt32(dr["NROHIJOS"].ToString()) > 0)
                    {
                        //Crear la tabla de visivibidad de control de niveles
                        e.Row.Cells[1].Controls.Add(this.NodoTree("EasyGridView1", Convert.ToInt32(dr["NIVEL"].ToString()), dr["ID_REQU"].ToString(), dr["ID_REQU_PADRE"].ToString(), dr["NRO_TICKET"].ToString(), true));
                        e.Row.Attributes["IdNivel"] = dr["ID_REQU"].ToString()+".";
                    }
                
                    PaintRow(e.Row,dr);

                    //Prioridades
                    if (dr["IDPRIORIDAD"].ToString() != "0")
                    {
                        e.Row.Cells[2].Attributes["style"] = "margin-top:10PX; padding-left: 10px;border-left: 5px solid " + dr["COLORPRIORIDAD"].ToString() + "; border-radius: 5px;";
                    }
                    if (dr["IDPRIORIDAD_ATE"].ToString() != "0")
                    {
                        e.Row.Cells[0].Attributes["style"] = "border-left: 5px solid " + dr["COLORPRIORIDADATE"].ToString() + "; border-radius: 5px;";
                    }

                }
                catch (Exception ex) { 
                }
            }
        }
       public HtmlTable HTMLSolicitante(DataRow drSol) {
            try
            {
                HtmlTable htmlTable = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, 3);
                htmlTable.Rows[0].Cells[0].Attributes["rowspan"] = "2";
                htmlTable.Rows[1].Cells[0].Attributes["style"] = "display:none";
                string Foto = this.PathFotosPersonal + drSol["NRODOCDNI"].ToString() + ".jpg";
                HtmlImage oImg = EasyUtilitario.Helper.HtmlControlsDesign.CrearImagen(Foto, "ms-n2 rounded-circle img-fluid");
                oImg.Attributes["Width"] = "45px";
                oImg.Attributes["Height"] = "45px";
                htmlTable.Rows[0].Cells[0].Controls.Add(oImg);
                htmlTable.Rows[0].Cells[1].InnerText = drSol["APELLIDOSYNOMBRES"].ToString();
                htmlTable.Rows[0].Cells[1].Align = "left";
                htmlTable.Rows[1].Cells[1].InnerText = drSol["AREASOLICITANTE"].ToString();
                htmlTable.Rows[1].Cells[1].Align = "left";

                htmlTable.Rows[0].Cells[2].Attributes["rowspan"] = "2";
                htmlTable.Rows[1].Cells[2].Attributes["style"] = "display:none";


                if (drSol["NRO_MSG_APR"].ToString() != "0") {
                    HtmlGenericControl dvNotify = new HtmlGenericControl("div");
                    dvNotify.ID = "ntf_" + drSol["ID_REQU"].ToString();
                    dvNotify.Attributes["class"] = "notify-badge";
                    dvNotify.InnerText = drSol["NRO_MSG_APR"].ToString(); 
                    HtmlGenericControl Badge1 = new HtmlGenericControl("img");
                    Badge1.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.CardEMail;
                    Badge1.Attributes["width"] = "40px";
                    htmlTable.Rows[0].Cells[2].Controls.Add(dvNotify);
                    htmlTable.Rows[0].Cells[2].Controls.Add(Badge1);
                }


                return htmlTable;
            }
            catch (Exception ex){
            return null;
            }

        }


       public EasyListView HtmlResponsable(string IdRequerimiento)
        {

            EasyListView oListViewResponsable = new EasyListView();
            oListViewResponsable.TipoItem = TipoItemView.ImagenCircular;
            oListViewResponsable.DataComplete.Add("IdUsuario", this.UsuarioId.ToString());
            oListViewResponsable.DataComplete.Add("UserName", this.UsuarioLogin);
            //oListViewAprobadres.DataComplete.Add("Principal", "0");

            oListViewResponsable.AlertTitulo = "APROBADOR";
            oListViewResponsable.AlertMensaje = "Desea eliminar este registro ahora?";
            oListViewResponsable.ID = "LsvAprobador";
            oListViewResponsable.ClassName = "BaseItemSecond";
            oListViewResponsable.Ancho = "100%";
            oListViewResponsable.FncItemOnCLick = "ListViewResponsable_ItemClick";
            //oListViewResponsable.FncItemOnMouseMove = "ListViewInspector_ItemMouseMove";
            oListViewResponsable.TextAlign = EasyUtilitario.Enumerados.Ubicacion.Izquierda;


            foreach (DataRow dr in ListarResponsableAtencion(IdRequerimiento).Rows)
            {
                EasyListItem oEasyListItemResponsable = new EasyListItem();
                oEasyListItemResponsable = new EasyListItem();
                oEasyListItemResponsable.Src = EasyUtilitario.Helper.Configuracion.PathFotos + dr["NRODOCDNI"].ToString() + ".jpg";
                oEasyListItemResponsable.Value = dr["ID_RESPONSABLE"].ToString();
                oEasyListItemResponsable.Text = dr["APELLIDOSYNOMBRES"].ToString();
                Dictionary<string, string> dc = new Dictionary<string, string>();
                dc.Add("IdPersonal", dr["IDPERSONALO7"].ToString());
                dc.Add("IdRequerimiento", IdRequerimiento);
                oEasyListItemResponsable.DataComplete = dc;
                oListViewResponsable.ListItems.Add(oEasyListItemResponsable);

            }
            return oListViewResponsable;
        }


        public DataTable ListarResponsable(string IdRequerimiento) {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "RequerimientoResponsable_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            oParam.Paramvalue = IdRequerimiento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            
            return ((DataTable)odi.GetDataTable());
        }
        public DataTable ListarResponsableAtencion(string IdRequ)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "RequerimientoResponsableAtencion_Lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            oParam.Paramvalue = IdRequ;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            return ((DataTable)odi.GetDataTable());
        }

        protected void EasyGridView1_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            oEasyNavigatorBE.Texto = "Detalle de Requerimiento";
            oEasyNavigatorBE.Descripcion = "Registro de requerimiento";
            oEasyNavigatorBE.Pagina = "/HelpDesk/Requerimiento/DetalleRequerimiento.aspx";


            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarRequerimiento.KEYIDREQUERIMIENTO, Recodset["ID_REQU"]));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarRequerimiento.KEYIDREQUERIMIENTOPADRE, "0"));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.C.ToString()));
            this.IrA(oEasyNavigatorBE, EasyGridView1);
        }

        protected void EasyGridView1_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
            switch (oEasyGridButton.Id)
            {

                case "btnAgregarRqr":
                    EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                    oEasyNavigatorBE.Texto = "Detalle de Requerimiento";
                    oEasyNavigatorBE.Descripcion = "Registro de requerimiento";
                    oEasyNavigatorBE.Pagina = "/HelpDesk/Requerimiento/DetalleRequerimiento.aspx";

                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarRequerimiento.KEYIDREQUERIMIENTO, "0"));
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarRequerimiento.KEYIDREQUERIMIENTOPADRE, Recodset["ID_REQU"]));
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.N.ToString()));
                    this.IrA(oEasyNavigatorBE, EasyGridView1);
                    break;
                case "btnSolAprob":
                    this.LlenarGrilla();
                    break;
            }

        }

        protected void EasyGridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
           /* if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (IdRqrPadre.Length > 0) {
                    

                    GridViewRow dgr =new GridViewRow(e.Row.DataItemIndex-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal);
                    dgr.Attributes.Add("TipoRow", "2");

                    GridView dg = (GridView)sender;
                    Table t = (Table)dg.Controls[0];
                    t.Rows.Add(dgr);
                    IdRqrPadre = "";
                }
            }*/
        }

        protected void EasyGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            LlenarGrilla();
        }
    }
}