using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using iTextSharp.text.pdf;
using iTextSharp.text;
using SIMANET_W22R.Controles;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.GestionReportes;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvSeguridad;
using System.Net;
using System.Drawing;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.Form.Templates;


namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class AdministrarInspecion : PaginaCalidadBase, IPaginaBase
    {
        EasyMessageBox oeasyMessageBox;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarDatos();
                    this.LlenarJScript();
                    //Graba en el Log la acción ejecutada
                    /*   LogAplicativo.GrabarLogAplicativoArchivo(new LogAplicativo(CNetAccessControl.GetUserName(), "Secretaria - Directorio", this.ToString(), "Se consultó las Actas de Sesión de Directorio.", Enumerados.NivelesErrorLog.I.ToString()));
                    */
                    //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());

                    ConfigurarFiltroPorDefault();
                    this.LlenarGrilla("");

                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }

        }

        void ConfigurarFiltroPorDefault() {
            List<EasyFiltroItem> lFItem = new List<EasyFiltroItem>();
            lFItem = EasyGestorFiltro1.getCollectionCriterios();

            if (lFItem == null)
            {
                lFItem = new List<EasyFiltroItem>();

                EasyFiltroItem oItem = new EasyFiltroItem();
                oItem.Campo = "IdUsuarioRegistro";
                oItem.CampoDescripcion = "Inspector";
                oItem.Criterio = "LIKE@*[VALOR]*@";
                oItem.CriterioDescripcion = "Contenga";
                oItem.Definitivo = true;
                oItem.Id = "1";
                oItem.IdPadre = "0";
                //oItem.NroHijos = 0;
                oItem.Operador = " ";
                // oItem.TemplateType = "EasyITemplateAutoCompletar";
                oItem.TextField = this.DatosUsuario.ApellidosyNombres;//  "ROSALES AZABACHE EDDY JOSE";
                oItem.ValueField = UsuarioId.ToString();
                oItem.TipodeDatos = EasyUtilitario.Enumerados.TiposdeDatos.String;

                lFItem.Add(oItem);
                EasyGestorFiltro1.setCollectionCriterios(lFItem);
            }
        }

        protected void EasyGestorFiltro1_ProcessCompleted(string FiltroResultante, List<EasyFiltroItem> lstEasyFiltroItem)
        {
            this.LlenarGrilla(FiltroResultante);
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        /*https://www.codeproject.com/tips/312545/a-method-to-move-rows-within-a-datatable*/
        public void LlenarGrilla(string strFilter)
        { 
            try
            {
                /*  EasyDataInterConect odi = new EasyDataInterConect();
                  odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceInterno;
                  odi.UrlWebService = "/GestiondeCalidad/Proceso.asmx";
                  odi.Metodo = "TreeListarInspeciones";

                      EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
                      oParam.ParamName = "IdInspeccion";
                      oParam.Paramvalue = "0";
                      oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                      oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
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

                  EasyGridView1.DataInterconect = odi;*/

                EasyGridView1.LoadData();

            }
            catch (Exception ex) {                
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name+"/"+ stack.GetFrame(0).GetMethod().Name;
               
                this.LanzarException(NombreMetodo,ex);
            }
        }

        public void LlenarCombos()
        {
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
        }
        public void CargarModoNuevo()
        {
        }
        public void CargarModoModificar()
        {
        }
        public int Agregar()
        {
            return 0;
        }
        public int Modificar()
        {
            return 0;
        }

        public void LlenarJScript()
        {
            txtTipoOp.Style["Display"] = "none";
            TxtUserName.Style["Display"] = "none";
            lstParaEmail.Style["Display"] = "none";
            txtNomFileAdjunto.Style["Display"] = "none";
            txtAsunto.Style["Display"] = "none";
            ibtnAnclar.Style["Display"] = "none";
            EasytxtTipoTrabajador.Style["Display"] = "none";
            ResponsableAreaBE oResponsableAreaBE = new ResponsableAreaBE();
            this.EntityInJavascriptFromServer(oResponsableAreaBE.GetType());

        }





        public void RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }
        public bool ValidarDatos()
        {
            throw new NotImplementedException();
        }

        protected void EasyGridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void EasyGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                //crea la tabla de Nodos
                /*-----------------------------------------------------------------------------------------------------------------*/
                HtmlTable tblNodo = new HtmlTable();
                int Nivel = Convert.ToInt32(dr["Nivel"]);
                tblNodo = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, (Nivel + 1));
                tblNodo.Attributes["width"] = "100%";
              //  tblNodo.Attributes["border"]="2";
                tblNodo.Rows[0].Cells[Nivel].InnerText = dr["NroReporte"].ToString();
                tblNodo.Rows[0].Cells[Nivel].Align = "left";

                tblNodo.Rows[0].Cells[Nivel].Style.Add("white-space","nowrap"); 
                tblNodo.Rows[0].Cells[Nivel].Attributes["width"] = "100%";

                HtmlImage oImg = new HtmlImage();
                if (Convert.ToInt32(dr["NroHijos"]) > 0)
                {
                    tblNodo.Rows[0].Cells[Nivel].Style.Add("font-weight", "bold");
                    tblNodo.Rows[0].Cells[Nivel].Style.Add("font-size", "14px");

                    oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeMinus;
                    tblNodo.Rows[0].Cells[Nivel - 1].Controls.Add(oImg);

                    for (int i = 0; i <= (Nivel - 2); i++)
                    {
                        oImg = new HtmlImage();
                        oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeSpace;
                        tblNodo.Rows[0].Cells[i].Controls.Add(oImg);
                    }
                }
                else
                {
                    for (int i = 0; i <= (Nivel - 1); i++)
                    {
                        oImg = new HtmlImage();
                        oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeSpace;
                        tblNodo.Rows[0].Cells[i].Controls.Add(oImg);
                    }
                }
                //establece atributos para su control
                e.Row.Attributes["IdNodo"] = dr["IdNodo"].ToString();
                e.Row.Cells[1].Controls.Add(tblNodo);


                int NroAproba = 0;
                foreach (DataRow drf in (new ControlInspeccionesSoapClient()).ListarUsuariosFirmantes(dr["IdInspeccion"].ToString(), "0", this.UsuarioLogin).Select("IdEstado=3"))
                {
                    NroAproba++;
                }
                ViewState[dr["IdInspeccion"].ToString()] = NroAproba;//Almacena en el viewstate 
                if (NroAproba > 0)
                {
                    HtmlGenericControl dvBadge1 = new HtmlGenericControl("span");
                    dvBadge1.InnerText = "+" + NroAproba.ToString();
                    dvBadge1.Attributes["class"] = "badge1 rounded-pill text-danger ";
                    HtmlGenericControl Badge1 = new HtmlGenericControl("img");
                    Badge1.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconAprobado;
                    Badge1.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "ShowVentanaFirmas('" + dr["IdInspeccion"].ToString() + "');";
                    Badge1.Attributes["width"] = "20px";
                    dvBadge1.Controls.Add(Badge1);
                    e.Row.Cells[1].Controls.Add(dvBadge1);
                   
                }
                /*-----------------------------------------------------------------------------------------------------------------*/
                //Indicador de bloqueo
                if (dr["Bloqueado"].ToString().Equals("1"))
                {
                    HtmlGenericControl dvBadgeLock = new HtmlGenericControl("span");
                    dvBadgeLock.Attributes["class"] = "DocLock rounded-pill text-danger ";
                    HtmlGenericControl BadgeLock = new HtmlGenericControl("img");
                    BadgeLock.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconDocLock;
                    BadgeLock.Attributes["width"] = "17px";
                    BadgeLock.Attributes["title"] = "Bloqueado..";
                    dvBadgeLock.Controls.Add(BadgeLock);
                    string Nr = e.Row.Cells[0].Text;
                    e.Row.Cells[0].Controls.Add(new LiteralControl(Nr));
                    e.Row.Cells[0].Controls.Add(dvBadgeLock);
                }
                /*-----------------------------------------------------------------------------------------------------------------*/



                HtmlTable tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(4, 1);
                tbl.Style["width"] = "100%";
                tbl.Attributes["border"] = "0";
                //tbl.Rows[0].Cells[0].Style["width"] = "20%";
                tbl.Rows[0].Cells[0].Style["width"] = "100%";
                tbl.Rows[0].Cells[0].InnerHtml = "PROYECTO:";
                tbl.Rows[0].Cells[0].Attributes["style"] = "font-size: 10px;font-family:Arial;Color:blue";
                tbl.Rows[1].Cells[0].InnerText = dr["NombreProyecto"].ToString();
                tbl.Rows[2].Cells[0].InnerHtml = "CLIENTE:";
                tbl.Rows[2].Cells[0].Attributes["style"] = "font-size: 10px;font-family:Arial;Color:blue";
                tbl.Rows[3].Cells[0].InnerText =  dr["ClienteRazonSocial"].ToString();

                e.Row.Cells[4].Controls.Add(tbl);
                e.Row.Cells[6].Controls.Add(ListarInspector(dr["IdInspeccion"].ToString()));
                e.Row.Cells[7].Controls.Add(ListarResponsablePorArea(dr["IdInspeccion"].ToString()));

                /*-----------------------------------------------------------------------------------------------------------------*/
                //Columna de estado
                System.Web.UI.WebControls.Image oImage = new System.Web.UI.WebControls.Image();
                oImage.ID = "imgEst";
                oImage.Attributes["src"] = dr["ImgEstado"].ToString();
                oImage.Attributes["Width"] = "45px";
                oImage.Attributes["title"] = dr["Estado"].ToString();
                oImage.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "AdministraEstado('" + dr["IdInspeccion"].ToString()  + "','" + dr["IdUsuarioInspector"].ToString() + "',this)";

                e.Row.Cells[10].Controls.Add(oImage);

            }
        }

        EasyListView ListarInspector(string IdInspeccion) {
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            DataTable dtInspect = oCalidad.Inspeccion_ListarInspectores(IdInspeccion, this.UsuarioLogin);

            EasyListView oListViewInspect = new EasyListView();
            oListViewInspect.TipoItem = TipoItemView.ImagenCircular;
            oListViewInspect.DataComplete.Add("IdUsuario", this.UsuarioId.ToString());
            oListViewInspect.DataComplete.Add("UserName", this.UsuarioLogin);
            oListViewInspect.DataComplete.Add("Principal", "0");
            //oListViewInspect.DataComplete.Add("IdInspector", );

            oListViewInspect.AlertTitulo = "INSPECTOR SECUNDARIO";
            oListViewInspect.AlertMensaje = "Desea eliminar este registro ahora";
            oListViewInspect.ID = "LsvInspectores";
            oListViewInspect.ClassName = "BaseItemSecond";
            oListViewInspect.Ancho = "100%";
            //oListViewInspect.FncItemOnCLick = "ListViewInspector_ItemClick";
            oListViewInspect.FncItemOnMouseMove = "ListViewInspector_ItemMouseMove";
            oListViewInspect.TextAlign = EasyUtilitario.Enumerados.Ubicacion.Izquierda;


            foreach (DataRow drInspect in dtInspect.Rows)
            {
                EasyListItem oEasyListItemInspect = new EasyListItem();
                oEasyListItemInspect = new EasyListItem();
                oEasyListItemInspect.Src = EasyUtilitario.Helper.Configuracion.PathFotos + drInspect["NroDNI"].ToString() + ".jpg";
                oEasyListItemInspect.Value = drInspect["IdInspector"].ToString();
                oEasyListItemInspect.Text = drInspect["NombresInspector"].ToString();
                Dictionary<string, string> dc = new Dictionary<string, string>();
                dc.Add("IdPersonal", drInspect["IdPersonal"].ToString());
                oEasyListItemInspect.DataComplete = dc;
                oListViewInspect.ListItems.Add(oEasyListItemInspect);
            }
            return oListViewInspect;
        }


      
        EasyListView ListarResponsablePorArea(string IdInspeccion)
        {
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            DataTable dtResponsable = oCalidad.ListarResponsablesPorArea(IdInspeccion, this.UsuarioLogin);
            EasyListView oListViewResponsable = new EasyListView();
            oListViewResponsable.TipoItem = TipoItemView.ImagenCircular;
            oListViewResponsable.DataComplete.Add("IdUsuario", this.UsuarioId.ToString());
            oListViewResponsable.DataComplete.Add("UserName", this.UsuarioLogin);
            oListViewResponsable.DataComplete.Add("IdInspeccion", IdInspeccion);



            oListViewResponsable.AlertTitulo = "ENCARGADO DE AREA";
            oListViewResponsable.AlertTitulo = "Desea eliminar este registro ahora";

            oListViewResponsable.AlertTitulo = "RESPONSABLE DE AREA";
            oListViewResponsable.AlertMensaje = "Desea eliminar este registro ahora";
            oListViewResponsable.ID = "LsvResponsable";
            oListViewResponsable.ClassName = "BaseItemSecond";
            oListViewResponsable.Ancho = "100%";
           // oListViewResponsable.FncItemOnCLick = "ListViewResponsables_ItemClick";
            oListViewResponsable.FncItemOnMouseMove = "ListViewInspector_ItemMouseMove";

            oListViewResponsable.TextAlign = EasyUtilitario.Enumerados.Ubicacion.Izquierda;

            foreach (DataRow drResponsable in dtResponsable.Rows)
            {
                EasyListItem oEasyListItemResponsable = new EasyListItem();
                oEasyListItemResponsable = new EasyListItem();
                oEasyListItemResponsable.Src = EasyUtilitario.Helper.Configuracion.PathFotos + drResponsable["NroDNI"].ToString() + ".jpg";
                oEasyListItemResponsable.Value = drResponsable["IdPersonal"].ToString();
                oEasyListItemResponsable.Text = drResponsable["NombreResponsable"].ToString();

                Dictionary<string, string> dcp = new Dictionary<string, string>();
                dcp.Add("IdPersonal", drResponsable["IdPersonal"].ToString());
                dcp.Add("IdTipoTrabajador", drResponsable["IdTipoTrabajador"].ToString());
                oEasyListItemResponsable.DataComplete = dcp;

                DataTable dtMsgResArea = oCalidad.ListarDetallePorReponsabledeArea(IdInspeccion, Convert.ToInt32(drResponsable["IdPersonal"].ToString()), this.UsuarioLogin);
                if (dtMsgResArea != null)
                {
                    DataRow []NroReg = dtMsgResArea.Select("IdEstado=2");//Enviado a revision
                    if ((NroReg != null)&& (NroReg.Length>0))
                    {
                        oEasyListItemResponsable.NroMsg = NroReg.Length;
                    }
                }

                oListViewResponsable.ListItems.Add(oEasyListItemResponsable);
            }
            return oListViewResponsable;
        }

        protected void EasyPopupBase1_onClick()
        {
            Dictionary<string, string> RowSelectd =  EasyGridView1.getDataItemSelected();
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                InspectorBE oInspectorBE = new InspectorBE();

                oInspectorBE.IdInspeccion = RowSelectd["IdInspeccion"];
                oInspectorBE.IdInspector = "0";
                oInspectorBE.IdPersonal = Convert.ToInt32(EasyAcBuscarPersonal.GetValue());

                oInspectorBE.Principal = Convert.ToInt32(txtTipoOp.Text);
                oInspectorBE.IdUsuario = this.UsuarioId;
                oInspectorBE.UserName = this.UsuarioLogin;
                oInspectorBE.IdEstado = 1;
                oCalidad.Inspeccion_ModificarInsertarInspector(oInspectorBE);


            //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
            this.LlenarGrilla("");
        }

        protected void EasyGridView1_EasyGridDetalle_Click(Dictionary<string , string> Recodset)
        {
            
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            oEasyNavigatorBE.Texto = "Detalle de Inspección";
            oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de inspección";
            oEasyNavigatorBE.Pagina = "/GestiondeCalidad/DetalleInspeccion.aspx";

            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaCalidadBase.KEYIDINSPECCION, Recodset["IdInspeccion"]));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(),  "M"));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaCalidadBase.KEYQEDITABLE, Recodset["Editable"]));


           /* List<EasyNavigatorBE> oEasyNavigatorBElst = new List<EasyNavigatorBE>();
            try
            {
                string s = "";
                oEasyNavigatorBElst = (List<EasyNavigatorBE>)Session[EasyUtilitario.Constantes.Sessiones.Historial];
                foreach (EasyNavigatorBE onbe in oEasyNavigatorBElst)
                {
                    s += onbe.LstCtrlValue;
                }
                SIMAExceptionSeguridadAccesoForms ex = new SIMAExceptionSeguridadAccesoForms(s);
                ErrorDisplay(ex);
            }
            catch (Exception ex)
            {
                this.LanzarException("Page_Load.LlenarDatos.CargarModoModificar", ex);
            }
            */


            this.IrA(oEasyNavigatorBE, EasyGridView1, EasyGestorFiltro1);
        }

        void verDetalledeInspeccion(EasyUtilitario.Enumerados.ModoPagina Modo,string IdInspeccionRelacionada,string EDITABLE) {
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            oEasyNavigatorBE.Texto = "Detalle de Inspección";
            oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de inspección";
            oEasyNavigatorBE.Pagina = "/GestiondeCalidad/DetalleInspeccion.aspx";
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), Modo.ToString()));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaCalidadBase.KEYIDINSPECCION, IdInspeccionRelacionada));
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(PaginaCalidadBase.KEYQEDITABLE, EDITABLE));
            

            this.IrA(oEasyNavigatorBE, EasyGridView1, EasyGestorFiltro1);
        }

        protected void EasyGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
            this.LlenarGrilla("");
        }

        protected void EasyPopupBase2_Click()
        {
            Dictionary<string, string> RowSelectd = EasyGridView1.getDataItemSelected();
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            //Elimina la lista de responsables previos
            DataTable dtResponsable = oCalidad.ListarResponsablesPorArea(RowSelectd["IdInspeccion"], this.UsuarioLogin);
            ResponsableAreaBE oResponsableAreaBE; ;
            foreach (DataRow drResponsable in dtResponsable.Rows)
            {
                oResponsableAreaBE = new ResponsableAreaBE();
                oResponsableAreaBE.IdInspeccion = RowSelectd["IdInspeccion"]; ;
                oResponsableAreaBE.IdPersonal = drResponsable["IdPersonal"].ToString();
                oResponsableAreaBE.IdTipoPersonal = Convert.ToInt32(drResponsable["IdTipoTrabajador"].ToString());
                oResponsableAreaBE.IdUsuario = this.UsuarioId;
                oResponsableAreaBE.UserName = this.UsuarioLogin;
                oResponsableAreaBE.IdEstado = 0;

                oCalidad.Inspeccion_ModficarInsertarResponsable(oResponsableAreaBE);
            }

            oResponsableAreaBE = new ResponsableAreaBE();
            oResponsableAreaBE.IdInspeccion = RowSelectd["IdInspeccion"];
            oResponsableAreaBE.IdPersonal = EasyAutocompletar2.GetValue();
            oResponsableAreaBE.IdTipoPersonal = Convert.ToInt32(EasytxtTipoTrabajador.GetValue());
            oResponsableAreaBE.IdUsuario = this.UsuarioId;
            oResponsableAreaBE.UserName = this.UsuarioLogin;
            oResponsableAreaBE.IdEstado = 1;

            string id= oCalidad.Inspeccion_ModficarInsertarResponsable(oResponsableAreaBE);




            //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
            this.LlenarGrilla("");

        }

        protected void EasyGridView1_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recordset)
        {

            switch (oEasyGridButton.Id)
            {
                case "btnAgregar":
                    //EasyUtilitario.Helper.Archivo.PDF.CrearTemplateWatermark("RI. NO AUTORIZADO", "C:\\AppWebs\\AppTest\\Archivos\\Calidad\\AllFiles\\Recursos\\DEMO.pdf");
                    verDetalledeInspeccion(EasyUtilitario.Enumerados.ModoPagina.N,"", "");
                    break;

                case "btnInfoRel":
                    verDetalledeInspeccion(EasyUtilitario.Enumerados.ModoPagina.N, Recordset["IdInspeccion"], "");
                    break;
                case "btnEliminar":
                    //Proceso de eliminacion
                    if (Recordset["IdEstado"] != "1")
                    {
                        //(new Proceso()).InspeccionCambiarEstado(Recordset["IdInspeccion"].ToString(), 0, this.UsuarioId, this.UsuarioLogin);
                        (new ControlInspeccionesSoapClient()).InspeccionCambiarEstado(Recordset["IdInspeccion"].ToString(), 0, this.UsuarioId, this.UsuarioLogin);
                    }
                    else {
                        oeasyMessageBox = new EasyMessageBox();
                        oeasyMessageBox.ID = "msgb";
                        oeasyMessageBox.Titulo = "Eliminar registro";
                        oeasyMessageBox.Contenido = "No es posible eliminar este registro, se encuentra en estado cerrado";
                        oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                        oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                        Page.Controls.Add(oeasyMessageBox);
                    }
                    //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
                    this.LlenarGrilla("");
                    break;
                case "btnImprimir":

                    DataSet ds = new DataSet();
                   

                    string NombreRptRI = "RI-" + Recordset["NombreProyecto"].ToString() +"-"+ Recordset["NroReporte"].ToString()+".pdf";

                    /* int NroAprob = (int) ViewState[Recordset["IdInspeccion"].ToString()];
                     if (NroAprob == 3)//Verifica si esta autorizado para imprimir RI
                     {*/
                    if (Recordset["Bloqueado"].ToString().ToString().Equals("1")) {
                        (new GenerarPdf()).PrintPrevio("Reporte de Inspección",NombreRptRI, "ConfigModCalidad", "HttpRIFinal",   EasyGridView1, EasyGestorFiltro1);
                    }
                    else
                    {
                        ds = DataReporteFichaTecnica(Recordset["IdInspeccion"].ToString());
                        (new GenerarPdf()).PrintPrevio(this.IdReporteInspeccion, NombreRptRI, this.UsuarioLogin, ds, EasyGridView1, EasyGestorFiltro1);
                    }
                    /*}
                    else
                    {
                        string FileSelloAgua = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "FileSelloAgua");
                        (new GenerarPdf()).PrintPrevioWatermark(this.IdReporteInspeccion, NombreRptRI, FileSelloAgua, this.UsuarioLogin, ds, EasyGridView1, EasyGestorFiltro1);
                    }*/
                    break;
            }
        }








        public DataSet DataReporteFichaTecnica(string IdInspeccion) {
            /*EasyDataInterConect oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.UrlWebService = "/GestiondeCalidad/Proceso.asmx";
            oEasyDataInterConect.Metodo = "ReporteFichaTecnica";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdInspeccion";
            oParam.Paramvalue = IdInspeccion;
            oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdOjeto";
            oParam.Paramvalue = this.IdReporteInspeccion.ToString();//EN caso cambien actualmente es el id =8
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

            DataSet ds = new DataSet();
            //Obtiene el DataTable como fuente de informacion del reporte
            ds = (DataSet)EasyUtilitario.Helper.Data.getResultInterConect(oEasyDataInterConect);*/
            DataSet ds=(new Proceso()).ReporteFichaTecnica(IdInspeccion, this.IdReporteInspeccion,this.UsuarioId ,this.UsuarioLogin);
            return ds;
        }

        public DataSet DataReporteNoConformes()
        {


            // DataSet ds = (new Proceso()).DataReporteNoConforme(2023,3, this.UsuarioLogin);
            DataSet ds = (new Proceso()).DataReportResumenNoConformePorProyecto_Mensual(2023, 12, this.UsuarioLogin);
            return ds;
        }


        protected void EasyPopupEmailSend_Click()
        {
            try
            {
                string lstCC = lstParaEmail.Text.Substring(0, lstParaEmail.Text.Length - 1);
                if(lstCC.Length== 0){
                    oeasyMessageBox = new EasyMessageBox();
                    oeasyMessageBox.ID = "msgbA";
                    oeasyMessageBox.Titulo = "Enviar Correo";
                    oeasyMessageBox.Contenido = "No se ha ingresado listado de destinos";
                    oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                    oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                    Page.Controls.Add(oeasyMessageBox);
                    return;
                }
                UsuarioBE oUsuarioBE = (UsuarioBE)Session["UserBE"];

                string[] ArrCc = lstCC.Split(',');
                string sPara = ArrCc[0].ToString();
                ArrCc = ArrCc.Where(val => val != sPara).ToArray();

                Dictionary<string, string> DataFila = EasyGridView1.getDataItemSelected();//Pbtiene informacion del registro seleccionado
                string NombreRI = "RI-" + DataFila["NombreProyecto"].ToString() + "-" + DataFila["NroReporte"].ToString() + ".pdf";
                string RutaFinalRI = "";
                string NombreArchivo = "";
                if (DataFila["Bloqueado"].ToString().Equals("1"))//sii esta bloqueado abre el archivo caso contrario copia de la carpeta de archivo generado por el usuario a la caprte sde fina de bloeados
                {
                    RutaFinalRI = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "LocalRIFinal") + oUsuarioBE.Login +"\\" + NombreRI;
                }
                else {

                    NombreArchivo = txtNomFileAdjunto.Text.Replace(EasyUtilitario.Constantes.Caracteres.SignoArroba.ToString(), "\\");
                    //Inicia la copia al area defnitiva de archivos bloqueados
                    string CarpetaFinal = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "LocalRIFinal") + oUsuarioBE.Login ;
                    RutaFinalRI = CarpetaFinal + "\\" + NombreRI;
                    //verifica si existe la parte del usuario en el ri final
                    if(!Directory.Exists(CarpetaFinal)){
                        DirectoryInfo di = Directory.CreateDirectory(CarpetaFinal);
                    }

                    if (File.Exists(RutaFinalRI)) {
                        File.Delete(RutaFinalRI);   
                    }
                    File.Move(NombreArchivo, RutaFinalRI);//Archivo copiado
                    //Elimina el arcvivo generado
                    File.Delete(NombreArchivo);
                    //Actualiza el registro del RI a Bloqueado
                    (new ControlInspeccionesSoapClient()).BloqueaRegistroInspeccion(DataFila["IdInspeccion"].ToString(), 1, oUsuarioBE.Login);
                }
                List<string> lstArchivos = new List<string>();
                lstArchivos.Add(RutaFinalRI);
                
                

                //Mail oMail = new Mail(oUsuarioBE.Email, lstPara, txtAsunto.Text,"Adjunto Ficha técnica[" + DataFila["NroReporte"].ToString() +"]"  , lstArchivos);
                Mail oMail = new Mail(oUsuarioBE.Email, sPara, ArrCc, txtAsunto.Text, "Adjunto Ficha técnica[" + DataFila["NroReporte"].ToString() + "]", lstArchivos);
                MailResult oMailResult = oMail.enviaMail();
                    oeasyMessageBox = new EasyMessageBox();
                    oeasyMessageBox.ID = "msgb3";
                    oeasyMessageBox.Titulo = "Enviar Correo";
                    oeasyMessageBox.Contenido = oMailResult.Message;
                    oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                    oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                    Page.Controls.Add(oeasyMessageBox);
            }
            catch (Exception ex)
            {
                oeasyMessageBox = new EasyMessageBox();
                oeasyMessageBox.ID = "msgb2";
                oeasyMessageBox.Titulo = "Enviar Correo";
                oeasyMessageBox.Contenido = ex.Message;
                oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                Page.Controls.Add(oeasyMessageBox);

            }
            // this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
            this.LlenarGrilla("");
        }

        protected void ibtnAnclar_Click(object sender, EventArgs e)
        {
            HttpRequest ContextRequest = ((System.Web.UI.Page)HttpContext.Current.Handler).Request;
            string EntityCliente = ContextRequest["__EVENTARGUMENT"];
            Dictionary<string,string>DataCliente= EasyUtilitario.Helper.Data.SeriaizedDiccionario(EntityCliente);
            string pathEncryt = DataCliente["UrlBase"].Replace("/", "[.]");
            (new GenerarPdf()).PrintPrevio(DataCliente["Titulo"], this.UsuarioLogin, pathEncryt);
        }

        protected void EasyGestorFiltro1_ItemCriterio(EasyGestorFiltro.ModoEditFiltro Modo, EasyFiltroItem oEasyFiltroItem)
        {  
            if (Modo == EasyGestorFiltro.ModoEditFiltro.Add)
            {
                //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
                this.LlenarGrilla("");
            }
        }





        /*
        void MergePdf(string targetFile ,string []files) {
            using (FileStream stream = new FileStream(targetFile, FileMode.OpenOrCreate))
            {
                Document pdfDoc = new Document(PageSize.LETTER);
                PdfSmartCopy pdf = new PdfSmartCopy(pdfDoc, stream);
                pdfDoc.Open();
                foreach (string file in files)
                {
                    PdfReader reader = new PdfReader(file);
                    pdf.AddDocument(reader);
                    pdf.FreeReader(reader);
                    reader.Close();
                }
                pdfDoc.Close();
                stream.Close();
            }
        }*/




    }
}