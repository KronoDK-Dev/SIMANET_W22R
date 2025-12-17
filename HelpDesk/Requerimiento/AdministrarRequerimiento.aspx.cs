using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data;
using EasyControlWeb.Form.Controls;
using EasyControlWeb;
using SIMANET_W22R.GestiondeCalidad;
using EasyControlWeb.Filtro;
using SIMANET_W22R.srvGestionCalidad;
using DocumentFormat.OpenXml.Drawing.Charts;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.srvHelpDesk;
using System.Web.UI.HtmlControls;
using EasyControlWeb.Form.Base;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.InterConeccion.EasyDataInterConect;
using System.Security.Cryptography;
using DocumentFormat.OpenXml.Office2010.PowerPoint;

namespace SIMANET_W22R.HelpDesk.Requerimiento
{
    public partial class AdministrarRequerimiento : HelpDeskBase, IPaginaBase
    {
        EasyMessageBox oeasyMessageBox;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            try {

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

        }

        public void LlenarGrilla()
        {           
            this.EasyGridView1.DataInterconect = ListarRQR(this.UsuarioId, this.UsuarioLogin);
            EasyGridView1.LoadData();
        }
        EasyDataInterConect ListarRQR(int IdUsuario,string UserName) {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.ConfigPathSrvRemoto = "PathBaseWSCore";
            odi.MetodoConexion = MetododeConexion.WebServiceExterno;
            odi.UrlWebService = "HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "Requerimientos_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = IdUsuario.ToString();
            oParam.TipodeDato = TiposdeDatos.Int;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerientoPadre";
            oParam.Paramvalue = "0";
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = UserName;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);
            return odi;
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

        protected void EasyGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                if (dr["IDPRIORIDAD"].ToString() != "0")
                {
                    e.Row.Cells[1].Attributes["style"] = "border-left: 5px solid " + dr["COLORPRIORIDAD"].ToString() + "; border-radius: 5px;";
                }
                //Nodo
                if (Convert.ToInt32(dr["NROHIJOS"].ToString()) > 0)
                {
                    e.Row.Cells[1].Controls.Add(this.NodoTree("EasyGridView1", Convert.ToInt32(dr["NIVEL"].ToString()), dr["ID_REQU"].ToString(), dr["ID_REQU_PADRE"].ToString(), dr["NRO_TICKET"].ToString(), true));
                }

                EasyPathHistory oEasyPathHistory = new EasyPathHistory();
                string[] PathItem = drv["PATHSERVICE"].ToString().Split('|');
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

                HtmlTable otblSrvInfo = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, 1);
                    otblSrvInfo.Rows[0].Cells[0].Controls.Add(oEasyPathHistory);

                        EasyProgressbarBase oEasyProgressBar = new EasyProgressbarBase();
                        oEasyProgressBar.Progreso = Convert.ToInt32(dr["AVANCE"].ToString());
                    otblSrvInfo.Rows[1].Cells[0].Controls.Add(oEasyProgressBar);
                e.Row.Cells[3].Controls.Add(otblSrvInfo);

                //e.Row.Cells[3].Controls.Add(oEasyPathHistory);

                //Lista de Parobadores
                e.Row.Cells[5].Style.Add("padding-left","20px");
                e.Row.Cells[5].Style.Add("padding-top", "8px");

                e.Row.Cells[5].Controls.Add(ListarAprobador(drv["ID_REQU"].ToString()));

                e.Row.Cells[6].Controls.Add(new LiteralControl("<img src='" + drv["CMEDIA"].ToString() + "' />"));
                

            }
        }

        EasyListView ListarAprobador(string IdRequerimiento) {

            EasyListView oListViewAprobadres = new EasyListView();
            oListViewAprobadres.TipoItem = TipoItemView.ImagenCircular;
            oListViewAprobadres.DataComplete.Add("IdUsuario", this.UsuarioId.ToString());
            oListViewAprobadres.DataComplete.Add("UserName", this.UsuarioLogin);
            //oListViewAprobadres.DataComplete.Add("Principal", "0");

            oListViewAprobadres.AlertTitulo = "APROBADOR";
            oListViewAprobadres.AlertMensaje = "Desea eliminar este registro ahora?";
            oListViewAprobadres.ID = "LsvAprobador";
            oListViewAprobadres.ClassName = "BaseItemSecond";
            oListViewAprobadres.Ancho = "100%";
            oListViewAprobadres.FncItemOnCLick = "ListViewAprobadores_ItemClick";
            //oListViewAprobadres.FncItemOnMouseMove = "ListViewAprobadores_ItemMouseMove";
            oListViewAprobadres.TextAlign = EasyUtilitario.Enumerados.Ubicacion.Izquierda;


            foreach (DataRow dr in (new DetalleRequerimiento()).ListarAprobadores(IdRequerimiento).Rows)
            {
                EasyListItem oEasyListItemAprobador = new EasyListItem();
                oEasyListItemAprobador = new EasyListItem();
                oEasyListItemAprobador.Src = EasyUtilitario.Helper.Configuracion.PathFotos + dr["NRODOCDNI"].ToString() + ".jpg";
                oEasyListItemAprobador.Value = dr["Id_Responsable"].ToString();
                oEasyListItemAprobador.Text = dr["APELLIDOSYNOMBRES"].ToString();
                Dictionary<string, string> dc = new Dictionary<string, string>();
                dc.Add("IdPersonal", dr["IdPersonalO7"].ToString());
                dc.Add("ID_RESPONSABLE", dr["Id_Responsable"].ToString());
                dc.Add("NRODOCDNI", dr["NRODOCDNI"].ToString());
                dc.Add("APELLIDOSYNOMBRES", dr["APELLIDOSYNOMBRES"].ToString());
                dc.Add("NRO_MSG_APR", dr["NRO_MSG_APR"].ToString());
                dc.Add("TOKENAPROB", dr["TOKENAPROB"].ToString());
                dc.Add("APROBADO", dr["APROBADO"].ToString());
                dc.Add("EMAIL", dr["PTRMAILCOR"].ToString());
                


                oEasyListItemAprobador.DataComplete = dc;
                oListViewAprobadres.ListItems.Add(oEasyListItemAprobador);

            }
            return oListViewAprobadres;
        }

        protected void EasyGridView1_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {

            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            oEasyNavigatorBE.Texto = "Detalle de Requerimiento";
            oEasyNavigatorBE.Descripcion = "Registro de requerimiento";
            oEasyNavigatorBE.Pagina = "/HelpDesk/Requerimiento/DetalleRequerimiento.aspx";

            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(AdministrarRequerimiento.KEYIDREQUERIMIENTO, Recodset["ID_REQU"]));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.M.ToString()));
            this.IrA(oEasyNavigatorBE, EasyGridView1);
        }

        protected void EasyGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            this.LlenarGrilla();
        }

        protected void EasyGridView1_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
            switch (oEasyGridButton.Id)
            {

                case "btnAgregar":
                    EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                    oEasyNavigatorBE.Texto = "Detalle de Inspección";
                    oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de inspección";
                    oEasyNavigatorBE.Pagina = "/HelpDesk/Requerimiento/DetalleRequerimiento.aspx";
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.N.ToString()));
//                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaCalidadBase.KEYIDINSPECCION, IdInspeccionRelacionada));
                    //oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaCalidadBase.KEYQEDITABLE, EDITABLE));


                    this.IrA(oEasyNavigatorBE, EasyGridView1);
                    break;
                case "btnEliminar":
                    if (Recodset["IDESTADO"].ToString() == "1")
                    {
                        AdministrarHDSoapClient oHelpDesk = new AdministrarHDSoapClient();
                        RequerimientoBE oRequerimientoBE = new RequerimientoBE();
                        oRequerimientoBE.IdRequerimiento = Recodset["ID_REQU"];
                        oRequerimientoBE.IdEstado = 0;
                        oRequerimientoBE.IdUsuario = this.UsuarioId;
                        oRequerimientoBE.UserName = this.UsuarioLogin;
                        string IdRqr = oHelpDesk.Requerimiento_Estado(oRequerimientoBE);
                    }
                    else {
                        oeasyMessageBox = new EasyMessageBox();
                        oeasyMessageBox.ID = "msgb";
                        oeasyMessageBox.Titulo = "Eliminar registro";
                        oeasyMessageBox.Contenido = "No es posible eliminar este registro, se encuentra en estado de atención";
                        oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                        oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                        Page.Controls.Add(oeasyMessageBox);
                    }
                    this.LlenarGrilla();
                    break;
            }

        }

    }
}