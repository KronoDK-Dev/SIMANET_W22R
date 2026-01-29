<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarServicios.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.ITIL.AdministrarServicios" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>



<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

      


        <script src="http://localhost:5000/Gojs/go.js"></script>
        <script src="http://localhost:5000/Gojs/Figures.js"></script>
        <script src="http://localhost:5000/Gojs/DrawCommandHandler.js"></script>


     <style type="text/css">
		.ztree li > a
		{
            border-left: 1px solid white;
		}

		.ztree li > a.curSelectedNode {
            border-radius: 3px;
		}
     .ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
     .ztree li ul.level0 {padding:0; background:none;}

		.ztree li span.button.pIcon01_ico_open{margin-right:2px; background: url(../Recursos/img/zTreeStyle/img/diy/1_close.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.pIcon01_ico_close{margin-right:2px; background: url(../Recursos/img/zTreeStyle/img/diy/1_open.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.pIcon02_ico_open, .ztree li span.button.pIcon02_ico_close{margin-right:2px; background: url(../../../css/zTreeStyle/img/diy/2.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.icon01_ico_docu{margin-right:2px; background: url(../../../css/zTreeStyle/img/diy/3.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.icon02_ico_docu{margin-right:2px; background: url(../../../css/zTreeStyle/img/diy/4.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.icon03_ico_docu{margin-right:2px; background: url(../../../css/zTreeStyle/img/diy/5.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.icon04_ico_docu{margin-right:2px; background: url(../../../css/zTreeStyle/img/diy/6.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.icon05_ico_docu{margin-right:2px; background: url(../../../css/zTreeStyle/img/diy/7.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.icon06_ico_docu{margin-right:2px; background: url(../../../css/zTreeStyle/img/diy/8.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
	
     
     
     .badge1{
             position: absolute;
             margin-left: -1.1%;
             margin-top: -.6%;
             align-content:center;
             font-weight:bold;
             color:grey;              
             width:25px;
             height:25px;
            -moz-border-radius: 25px; 
            -webkit-border-radius: 25px; 
            border-radius: 25px;
         }

     .FondoTool {
         
        background: url('http://localhost/SIMANET_W22R/Recursos/img/NavTree.jpg');
         
     }
     .ConfigTree {
         border: 1px  dotted #696666; 
         overflow-x: hidden;
         overflow-y: auto;
     }
     

     </style>

    <script>
        function TabClick(oTab) {
            var idTab = oTab.attr('id').Replace("EasyTabControl1_","");
            switch (idTab) {
                    case "TbProcedure":
                    Manager.Task.Excecute(function () {
                            try {
                                init();
                                 Diagrama.Drawing.Tools.Paint();
                                 Diagrama.Drawing.Paint();
                            }
                            catch (ex) {
                              //  alert(ex);
                            }
                    }, 1500, true);
                    break;
                }

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
          <table id="tblServicios" style="width:100%;height:100%"  border="0px" >
                 <tr>
                     <td>
                         <uc1:Header runat="server" ID="Header" />
                    </td>
                 </tr>
                 <tr>
                     <td style="width:100%; height:100%;" valign="top"  align="left"  >
                                 <table cellpadding="0" cellspacing="0"  style="width:100%; height:100%"   border="2px">
                                     <tr class="FondoTool"  >
                                         <td style="width:20%;height:10px; border: 1px  dotted #696666;" >  
                                             <cc3:EasyToolBarButtons ID="EasyToolBarAdm" runat="server" Width="100%" fnToolBarButtonClick="AdministrarServicios.Toolbar.onClick" OnonClick="EasyToolBarAdm_onClick" >
                                                 <EasyButtons>
                                                     <cc3:EasyButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" RunAtServer="False" Texto="" Ubicacion="Derecha" />
                                                     <cc3:EasyButton ID="btnprocedure" Descripcion="" Icono="fa fa-code" RunAtServer="False" Texto="" Ubicacion="Derecha" />

                                                     <cc3:EasyButton ID="btnActividad" Descripcion="" Icono="fa fa-plus-square-o" RunAtServer="True" Texto="" Ubicacion="Izquierda" />
                                                     <cc3:EasyButton ID="btnElimina" Descripcion="" Icono="fa fa-close" RunAtServer="False" Texto="" Ubicacion="Derecha" />
                                                 </EasyButtons>
                                             </cc3:EasyToolBarButtons>
                                         </td>
                                           <td  style="padding:10px; width:80%;height:100%;border: 1px  dotted #696666; " align="left "  valign="top" >
                                               <table>
                                                     <tr>
                                                         <td style="padding-left: 10px; width: 20%;color:white;font-weight:bold"  nowrap>Administrar recursos:.
                                                         </td>
                                                         <td id="LstUser"  style="padding-left: 10px; width: 80%;" >
                                                         </td>

                                                     </tr>
                                                </table>
                                          </td>
                                         <!--<td   style="width:30%; height:100%; border: 1px  dotted #696666; "  align="left"  valign="top">
                                         </td>-->
                                     </tr>
                         
                                     <tr>
                                         <td  style="width:20%; height:100%;  border: 1px  dotted #696666; "  align="left"  valign="top" >
                                             <div class="content_wrap box"   align="left"  valign="top">
                                                 <div  id="Explore" class="zTreeDemoBackground left ConfigTree" >
                                                        <ul id="treeNav" class="ztree"></ul>
                                                 </div>
                                             </div>
                              
                                         </td>
                                         <td class="ReportBody"     style="width:80%;height:100%;border: 1px  dotted #696666; " align="left "  valign="top" >
                                                <div id="PanelOpcion"></div>
                                         </td>
                                         <!-- <td   style="width:30%; height:100%; border: 1px  dotted #696666; "  align="left"  valign="top">
                                               <div id="ReportBody"></div>
                                          </td>-->
                                     </tr>
                                 </table>
                     </td>
                 </tr>
            </table>

     <cc3:EasyPopupBase ID="EasyPopupDetalleServicio" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Crear Servicio/Producto" RunatServer="false" DisplayButtons="true" fncScriptAceptar="AdministrarServicios.Detalle.Aceptar"></cc3:EasyPopupBase>
     <cc3:EasyPopupBase ID="EasyPopupProcedimiento" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Procedimiento" RunatServer="false" DisplayButtons="true"></cc3:EasyPopupBase>

   
    </form>    

             <script>

                 AdministrarServicios.Toolbar = {};
                 AdministrarServicios.Toolbar.onClick = function (btnItem, DetalleBE) {
       
                     switch (btnItem.Id) {
                         case "btnAgregar":
                             AdministrarServicios.Detalle.Show(SIMA.Utilitario.Enumerados.ModoPagina.N,0);
                             break;
                         case "btnprocedure":
                             //AdministrarServicios.Actividad.Procedimiento(SIMA.Utilitario.Enumerados.ModoPagina.N, "2024-1");

                             var urlPag = Page.Request.ApplicationPath + "/HelpDesk/ITIL/AdministrarComponentesdeActividad.aspx";
                             var oColletionParams = new SIMA.ParamCollections();
                             var oParam = new SIMA.Param(AdministrarServicios.KEYMODOPAGINA, "N");
                             oColletionParams.Add(oParam);
                             oParam = new SIMA.Param(AdministrarServicios.KEYIDACTIVIDAD, Page.Request.Params[AdministrarServicios.KEYIDACTIVIDAD]);
                             oColletionParams.Add(oParam);

                             var oLoadConfig = {
                                 CtrlName: "PanelOpcion",
                                 UrlPage: urlPag,
                                 ColletionParams: oColletionParams,
                                 //fnTemplate:function () {},
                                 //fnOnComplete: function () {}
                             };

                             SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);

                             break;
                        /*case "btnActividad":
                             AdministrarServicios.Actividad.Show(SIMA.Utilitario.Enumerados.ModoPagina.N, 0);
                             break;*/
                     }
                 }
             </script>
             <script>

                 AdministrarServicios.Actividad = {};

                 AdministrarServicios.Actividad.Procedimiento = function (oModo,IdActividad) {

                     var Url = Page.Request.ApplicationPath + "/HelpDesk/ITIL/AdministrarActividadProcedimiento.aspx";
                     var oColletionParams = new SIMA.ParamCollections();
                     var oParam = new SIMA.Param(AdministrarServicios.KEYMODOPAGINA, oModo);
                     oColletionParams.Add(oParam);
                     oParam = new SIMA.Param(AdministrarServicios.KEYIDACTIVIDAD, IdActividad);
                     oColletionParams.Add(oParam);
                     EasyPopupProcedimiento.Titulo = "Adminsitrar procedimiento(" + oModo + ")";
                     EasyPopupProcedimiento.Load(Url, oColletionParams, false);
                 }


            


                 AdministrarServicios.Detalle = {}
                 AdministrarServicios.Detalle.Show = function (oModo,IdServicio) {
                     var Url = Page.Request.ApplicationPath + "/HelpDesk/ITIL/DetalleServicio.aspx";
                     var oColletionParams = new SIMA.ParamCollections();
                     var oParam = new SIMA.Param(AdministrarServicios.KEYMODOPAGINA, oModo);
                     oColletionParams.Add(oParam);
                     oParam = new SIMA.Param(AdministrarServicios.KEYIDSERVICIO, IdServicio);
                     oColletionParams.Add(oParam);
                     EasyPopupDetalleServicio.Titulo = "Detalle de Servicio ó Producto (" + oModo + ")";
                     EasyPopupDetalleServicio.Load(Url, oColletionParams, false);
                 }



                 AdministrarServicios.Detalle.Aceptar = function () {
                     var IdNodoPadre = "0";
                     var DataServicio = EasyFormDetalleSrv.GetAllData();

                     var oEasyDataInterConect = new EasyDataInterConect();
                     oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                     oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/ITIL/GestiondeConfiguracion.asmx";
                     oEasyDataInterConect.Metodo = "ServiciosModificaInserta";
                     var oParamCollections = new SIMA.ParamCollections();
                     var oParam = null;

                     var DataBE = AdministrarServicios.EasyControl.Tree.ItemSelect.Data;

                     switch (DetalleServicio.ModoEdit) {
                         case SIMA.Utilitario.Enumerados.ModoPagina.N:
                             oParam = new SIMA.Param("IdServicioProducto", "0");
                             oParamCollections.Add(oParam);
                             oParam = new SIMA.Param("IdPadre", DataBE.ID_SERV_PROD);
                             oParamCollections.Add(oParam);
                             IdNodoPadre = DataBE.ID_SERV_PROD;
                             break;
                         case SIMA.Utilitario.Enumerados.ModoPagina.M:
                 
                             oParam = new SIMA.Param("IdServicioProducto", DataBE.ID_SERV_PROD);
                             oParamCollections.Add(oParam);
                             oParam = new SIMA.Param("IdPadre", DataBE.ID_PADRE);
                             oParamCollections.Add(oParam);
                             break;
                     }
                     oParam = new SIMA.Param("Nombre", EasyFormDetalleSrv_aucServicio.GetText());
                     oParamCollections.Add(oParam);
                     oParam = new SIMA.Param("Descripcion", EasyFormDetalleSrv_txtDescrip.GetValue());
                     oParamCollections.Add(oParam);
                     oParam = new SIMA.Param("Interno", ((EasyFormDetalleSrv_chkInterno.GetValue()==true)?1:0), TipodeDato.Int);
                     oParamCollections.Add(oParam);
                     oParam = new SIMA.Param("Producto", ((EasyFormDetalleSrv_chkSrvProd.GetValue()==true)?0:1), TipodeDato.Int);
                     oParamCollections.Add(oParam);
                     oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
                     oParamCollections.Add(oParam);
                     oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                     oParamCollections.Add(oParam);
                     oEasyDataInterConect.ParamsCollection = oParamCollections;

                     var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                     var Result = oEasyDataResult.sendData();

                     if (DetalleServicio.ModoEdit == SIMA.Utilitario.Enumerados.ModoPagina.N) {
                         var NodeNewBE = Result.toString().SerializedToObject();
                         var zTree = $.fn.zTree.getZTreeObj("treeNav");
                             nodes = zTree.getSelectedNodes();
                             treeNode = nodes[0];
                         var oServicioBE = new ServicioBE();
             
                         var NodoBE = null;
                         var Icono = ((EasyFormDetalleSrv_chkSrvProd.GetValue() == true) ? SIMA.Utilitario.Constantes.ImgDataURL.IconServicio : SIMA.Utilitario.Constantes.ImgDataURL.IconProducto);
                             NodoBE = { id: NodeNewBE.IdOut, pId: IdNodoPadre, isParent: false, icon: Icono, name: EasyFormDetalleSrv_aucServicio.GetText(), Data: oServicioBE, children: null, Load: false };

                         zTree.addNodes(treeNode, NodoBE);
                     }
                     return true;
        
                 }
             </script>

             <script>
                 var arrData = new Array();
                 var cmll = SIMA.Utilitario.Constantes.Caracter.Comilla;

                 function LoadIni() {
                     var BaseBE = { ID_SERV_PROD: 0, IdTipo: "-1",Load:false };
                     var OneNode = { id: BaseBE.ID_SERV_PROD, name: "Configuración de servicios", open: true, iconSkin: "pIcon01", Data: BaseBE, noR: true, children: null, font: { 'font-weight': 'bold', 'color': 'blue', 'font-style': 'italic' } };
                     arrData.Add(OneNode);
                     AdministrarServicios.EasyControl.Tree(OneNode);
                 }
                 AdministrarServicios.Data = {};
                 AdministrarServicios.EasyControl = {};

    
                 AdministrarServicios.Data.Servicios = function (IdServicioPadre) {
                     var oEasyDataInterConect = new EasyDataInterConect();
                     oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                     oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/ITIL/GestiondeConfiguracion.asmx";
                     oEasyDataInterConect.Metodo = "ListarServiosyProductos";

                     var oParamCollections = new SIMA.ParamCollections();
                     var oParam = new SIMA.Param("IdServicioPadre", IdServicioPadre);
                     oParamCollections.Add(oParam);
                     oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                     oParamCollections.Add(oParam);
                     oEasyDataInterConect.ParamsCollection = oParamCollections;

                     var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                     return oEasyDataResult.getDataTable();
                 }

  
                 AdministrarServicios.EasyControl.Tree = function (oNodoPadre) {
                     var NewCollection = new Array();
                     AdministrarServicios.Data.Servicios(oNodoPadre.id).Rows.forEach(function (oDataRow, f) {
                         var DataBE = "".Serialized(oDataRow, true);
                         var StrNombre = DataBE.NOMBRE.toString();

                         var NodoBE = null;
                         var ObjLogBE = AdministrarServicios.Trace.Log.Find('Svr', DataBE.ID_SERV_PROD.toString());
                         var ExpandeCollapse = ((ObjLogBE.NodoBE == null) ? false : ((ObjLogBE.NodoBE.open == "true") ? true : false));
                         if (DataBE.NROHIJOS.toString() != "0"){
                             NodoBE = { id: DataBE.ID_SERV_PROD.toString(), pId: oNodoPadre.id, name: StrNombre, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconServicio , open: ExpandeCollapse, noR: true, Data: DataBE, children: null, isParent: true, font: { 'font-weight': 'bold' }, Load: ExpandeCollapse };
                         }
                         else {
                             if (DataBE.PRODUCTO == "0") {
                                 NodoBE = { id: DataBE.ID_SERV_PROD.toString(), pId: oNodoPadre.id, isParent: false, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconServicio, name: StrNombre, Data: DataBE, children: null, Load: false };
                             }
                             else {
                                 NodoBE = { id: DataBE.ID_SERV_PROD.toString(), pId: oNodoPadre.id, isParent: false, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconProducto, name: StrNombre, Data: DataBE, children: null, Load: false };
                             }
                         }

                         NewCollection.Add(NodoBE);
                         oNodoPadre.children = NewCollection;
                         //if ((DataBE.NROHIJOS.toString() != "0") && (ExpandeCollapse == true)) {
                         if ((DataBE.NROHIJOS.toString() != "0") ) {
                             AdministrarServicios.EasyControl.Tree(NodoBE);
                         }
             
                     });

            
                 }

                 AdministrarServicios.EasyControl.Tree.ItemSelect = null;
                 //Eventos de treeview 
                 AdministrarServicios.EasyControl.Tree.zTreeOnNodeCreated=function(event, treeId, treeNode) {
                     //			{ id:1, pId:0, name:"Custom Icon 01", open:true, iconOpen:"../../../css/zTreeStyle/img/diy/1_open.png", iconClose:"../../../css/zTreeStyle/img/diy/1_close.png"},
                     //https://github.com/zTree/zTree_v3/blob/master/demo/en/core/expand.html   expaden dinamico
                     var zTree = $.fn.zTree.getZTreeObj(treeId);
                     /*if (reloadFlag) {
                         if (checkFlag) {
                             zTree.checkNode(treeNode, true, true);
                         }
                         if (!treeNode.children) {
                             zTree.reAsyncChildNodes(treeNode, "refresh");
                         }
                     }*/
                     //alert('4');
                 }
                 AdministrarServicios.EasyControl.Tree.onbeforeClick = function (treeId, treeNode, clickFlag) {
                 }
                 AdministrarServicios.EasyControl.Tree.onClick = function (event, treeId, treeNode, clickFlag) {
                     //AdministrarReporte.Navigator.Node.Select = treeNode;
                     //var DataBE = AdministrarReporte.Navigator.Node.Select.Data;
                     AdministrarServicios.EasyControl.Tree.ItemSelect = treeNode;
                 }
                  AdministrarServicios.EasyControl.Tree.DblClick = function (event, treeId, treeNode, clickFlag) {
                      var oDataBE = treeNode.Data;
                      AdministrarServicios.Detalle.Show(SIMA.Utilitario.Enumerados.ModoPagina.M, oDataBE.ID_SERV_PROD);
       
                 }
                 AdministrarServicios.EasyControl.Tree.Expand = function (event, treeId, treeNode) {           
                     var ObjLogBE = AdministrarServicios.Trace.Log.Find('Srv', treeNode.id);
                     if (ObjLogBE.NodoBE == null) {
                         var strBE = "{id:" + cmll + treeNode.id + cmll + ",open:" + cmll + "false" + cmll + ",Nivel:" + cmll + treeNode.level + cmll + ",Load:true}";
                         ObjLogBE.NodoBE = strBE.toString().SerializedToObject();
                     }
                     else {
                         ObjLogBE.NodoBE.open = true;
                     }

                     ObjLogBE.DBLog.Add(ObjLogBE.NodoBE);
                     AdministrarServicios.Trace.Log.Save('Srv', ObjLogBE);
                     if (treeNode.Load == false) {
                         AdministrarServicios.EasyControl.Tree(treeNode);
                         treeNode.Load = true;
                     }
                 }
              /*   AdministrarServicios.EasyControl.Tree.Collapse = function (event, treeId, treeNode) {
                     var ObjLogBE = AdministrarServicios.Trace.Log.Find('Srv', treeNode.id);
                     if (ObjLogBE.NodoBE == null) {
                         var strBE = "{id:" + cmll + treeNode.id + cmll + ",open:" + cmll + "false" + ",Nivel:" + cmll + treeNode.level + cmll + "}";
                         ObjLogBE.NodoBE = strBE.toString().SerializedToObject();
                     }
                     else {
                         ObjLogBE.NodoBE.open = false;
                     }
                     ObjLogBE.DBLog.Add(ObjLogBE.NodoBE);
                     AdministrarServicios.Trace.Log.Save('Srv', ObjLogBE);
                 }

                 */


                 function addDiyDom(treeId, treeNode) {
                 }

                 function getFont(treeId, node) {
                     return node.font ? node.font : {};
                 }

                 var treeObjet = null;
                 var setting = {
                     edit: {
                         enable: true,
                         // editNameSelectAll: false, // Cuando la entrada del nombre de edición del nodo se muestre por primera vez, establezca si el contenido txt está todo seleccionado
                         showRemoveBtn: false,
                         showRenameBtn: false
                     },
                     view: {
                         fontCss: getFont,
                         nameIsHTML: true,
                         dblClickExpand: false,
                         txtSelectedEnable: true,
                         showIcon: true,
                         showLine: true,
                         showTitle: true,
                         addDiyDom: addDiyDom
                     },
                     data: {
                         simpleData: {
                             enable: true
                         }
                     },
                     callback: {
                         beforeClick: AdministrarServicios.EasyControl.Tree.onbeforeClick,
                         onClick: AdministrarServicios.EasyControl.Tree.onClick,
                         onDblClick: AdministrarServicios.EasyControl.Tree.DblClick,
                         onNodeCreated: AdministrarServicios.EasyControl.Tree.zTreeOnNodeCreated,
                         onExpand: AdministrarServicios.EasyControl.Tree.Expand,
                         /*onCollapse: AdministrarServicios.EasyControl.Tree.Collapse*/
                     }
                 };
     

    
                 window.setTimeout(LoadIni(), 3000);

                 var treeObject = null;
                 $(document).ready(function () {
                     //jNet.get('Explore').attr("height", screen.height);
                     //jNet.get('Content').attr("height", screen.height);

                     $.fn.zTree.init($("#treeNav"), setting, arrData);
                     treeObject = $.fn.zTree.getZTreeObj("treeNav");
                 });

             </script>
     <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">-->
</body>
</html>
