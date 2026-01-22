<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarServicioXAreaRQR.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Requerimiento.ListarServicioXAreaRQR" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
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

 
         .ConfigTree {
             border: 1px  dotted #696666; 
             overflow-x: hidden;
             overflow-y: auto;
         }
 

 </style>
    <script>
        function BtnPath(oPathBE) {
            //alert(oPathBE);
            
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%">
            <tr>
                <td>
                    <div class="content_wrap box"   align="left"  valign="top" style="width:100%">
                        <div  id="Explore" class="zTreeDemoBackground left ConfigTree" >
                                <ul id="treeNavSrv" runat="server" class="ztree"></ul>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyPathHistory ID="EasyPathService" TipoPath="Tradicional" runat="server" fncPathOnClick="BtnPath"></cc1:EasyPathHistory></td>
            </tr>

        </table>
    </form>

     <script>
         var arrData = new Array();
         var cmll = SIMA.Utilitario.Constantes.Caracter.Comilla;

         function LoadIni() {
             var BaseBE = { ID_SERV_PROD: 0, IdTipo: "-1", Load: false };
             var OneNode = { id: BaseBE.ID_SERV_PROD, name: "Servicios Disponibles", open: true, iconSkin: "pIcon01", Data: BaseBE, noR: true, children: null, font: { 'font-weight': 'bold', 'color': 'blue', 'font-style': 'italic' } };
             arrData.Add(OneNode);
             ListarServicioXAreaRQR.EasyControl.Tree(OneNode);
         }
         ListarServicioXAreaRQR.Data = {};
         ListarServicioXAreaRQR.EasyControl = {};


         ListarServicioXAreaRQR.Data.Servicios = function (IdServicioPadre) {
             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
             oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/ITIL/GestiondeConfiguracion.asmx";
             oEasyDataInterConect.Metodo = "ListarServiosPorArea";

             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("IdServicioPadre", IdServicioPadre);
             oParamCollections.Add(oParam);

             oParam = new SIMA.Param("CodigoArea", ListarServicioXAreaRQR.Params[ListarServicioXAreaRQR.KEYIDAREA]);
             oParamCollections.Add(oParam);

             oParam = new SIMA.Param("IdTipoServicio", "1");
             oParamCollections.Add(oParam);

             oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
             oParamCollections.Add(oParam);
             oEasyDataInterConect.ParamsCollection = oParamCollections;

             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
             return oEasyDataResult.getDataTable();
         }


         ListarServicioXAreaRQR.EasyControl.Tree = function (oNodoPadre) {
             var NewCollection = new Array();
             ListarServicioXAreaRQR.Data.Servicios(oNodoPadre.id).Rows.forEach(function (oDataRow, f) {
                 var DataBE = "".Serialized(oDataRow, true);
                 var StrNombre = DataBE.NOMBRE.toString();
                 var NodoBE = null;
                 var ObjLogBE = ListarServicioXAreaRQR.Trace.Log.Find('Svr', DataBE.ID_SERV_PROD.toString());
                 var ExpandeCollapse = ((ObjLogBE.NodoBE == null) ? false : ((ObjLogBE.NodoBE.open == "true") ? true : false));
                 if (DataBE.NROHIJOS.toString() != "0") {
                     NodoBE = { id: DataBE.ID_SERV_PROD.toString(), pId: oNodoPadre.id, name: StrNombre, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconServicio, open: ExpandeCollapse, noR: true, Data: DataBE, children: null, isParent: true, font: { 'font-weight': 'bold' }, Load: ExpandeCollapse };
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
                 if ((DataBE.NROHIJOS.toString() != "0")) {
                     ListarServicioXAreaRQR.EasyControl.Tree(NodoBE);
                 }

             });


         }

         ListarServicioXAreaRQR.EasyControl.Tree.ItemSelect = null;
         //Eventos de treeview 
         ListarServicioXAreaRQR.EasyControl.Tree.zTreeOnNodeCreated = function (event, treeId, treeNode) {
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
         ListarServicioXAreaRQR.EasyControl.Tree.onbeforeClick = function (treeId, treeNode, clickFlag) {

         }
         ListarServicioXAreaRQR.EasyControl.Tree.onClick = function (event, treeId, treeNode, clickFlag) {
             ListarServicioXAreaRQR.EasyControl.Tree.ItemSelect = treeNode;
             var DataBE = ListarServicioXAreaRQR.EasyControl.Tree.ItemSelect.Data;
             var ArrayPath = DataBE.PATHSERVICE.toString().split('|');
             EasyPathService.Clear();
             var oItemPath = new EasyPathService.PathItem("1", "", "", EasyPathHistory1.TipoItem.Home);
             EasyPathService.Add(oItemPath);
             ArrayPath.reverse().forEach(function (ItemPathText, p) {
                 oItemPath = new EasyPathService.PathItem(ItemPathText, ItemPathText, "", EasyPathHistory1.TipoItem.Default);
                 EasyPathService.Add(oItemPath);
             });
             EasyPathService.Paint();
         }

         ListarServicioXAreaRQR.EasyControl.Tree.DblClick = function (event, treeId, treeNode, clickFlag) {
             var oDataBE = treeNode.Data;
             var urlPag = Page.Request.ApplicationPath + "/HelpDesk/ITIL/DetalleRqrServicio.aspx";
             var oColletionParams = new SIMA.ParamCollections();
             var oParam = new SIMA.Param(ListarServicioXAreaRQR.KEYIDSERVICIO, oDataBE.ID_SERV_PROD);
             oColletionParams.Add(oParam);

             oParam = new SIMA.Param(ListarServicioXAreaRQR.KEYNOMBRESERVICIO, oDataBE.NOMBRE);
             oColletionParams.Add(oParam);

             NetSuite.Manager.Broker.Persiana.Popup.Show({ Titulo: oDataBE.NOMBRE, Pagina: urlPag, Parametros: oColletionParams });//llama a la ventana de detalle del servicio

         }

         ListarServicioXAreaRQR.EasyControl.Tree.Expand = function (event, treeId, treeNode) {
             var ObjLogBE = ListarServicioXAreaRQR.Trace.Log.Find('Srv', treeNode.id);
             if (ObjLogBE.NodoBE == null) {
                 var strBE = "{id:" + cmll + treeNode.id + cmll + ",open:" + cmll + "false" + cmll + ",Nivel:" + cmll + treeNode.level + cmll + ",Load:true}";
                 ObjLogBE.NodoBE = strBE.toString().SerializedToObject();
             }
             else {
                 ObjLogBE.NodoBE.open = true;
             }

             ObjLogBE.DBLog.Add(ObjLogBE.NodoBE);
             ListarServicioXAreaRQR.Trace.Log.Save('Srv', ObjLogBE);
             if (treeNode.Load == false) {
                 ListarServicioXAreaRQR.EasyControl.Tree(treeNode);
                 treeNode.Load = true;
             }
         }



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
                 beforeClick: ListarServicioXAreaRQR.EasyControl.Tree.onbeforeClick,
                 onClick: ListarServicioXAreaRQR.EasyControl.Tree.onClick,
                 onDblClick: ListarServicioXAreaRQR.EasyControl.Tree.DblClick,
                 onNodeCreated: ListarServicioXAreaRQR.EasyControl.Tree.zTreeOnNodeCreated,
                 onExpand: ListarServicioXAreaRQR.EasyControl.Tree.Expand,
                 /*onCollapse: AdministrarServicios.EasyControl.Tree.Collapse*/
             }
         };



         window.setTimeout(LoadIni(), 3000);

         var treeObject = null;
         var NombreTree = "treeNavSrv_" + ListarServicioXAreaRQR.Params[ListarServicioXAreaRQR.KEYIDAREA];

         $.fn.zTree.init($("#" + NombreTree), setting, arrData);
         treeObject = $.fn.zTree.getZTreeObj(NombreTree);



         /*$(document).ready(function () {
             alert(arrData);
             $.fn.zTree.init($("#treeNavSrv"), setting, arrData);
             treeObject = $.fn.zTree.getZTreeObj("treeNavSrv");
         });*/

     </script>

</body>
</html>
