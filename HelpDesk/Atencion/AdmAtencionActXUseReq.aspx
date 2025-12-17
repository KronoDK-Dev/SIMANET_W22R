<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdmAtencionActXUseReq.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.AdmAtencionActXUseReq" %>

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




</head>
<body>
    <form id="form1" runat="server">
       <div class="content_wrap box"   align="left"  valign="top">
             <div  id="ExploreAct" class="zTreeDemoBackground left ConfigTree" >
                    <ul id="treeNav" class="ztree"></ul>
             </div>
       </div>
    </form>

          
            <script>
                //
                AdmAtencionActXUseReq.Data = {};
                AdmAtencionActXUseReq.Data.oDataTableActPrcRqr = null;
                AdmAtencionActXUseReq.Data.SysProcesActLst = function () {
                    var oEasyDataInterConect = new EasyDataInterConect();
                    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                    oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
                    oEasyDataInterConect.Metodo = "RequerimientoActividaAfectada_lst";

                    var oParamCollections = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param("IdPersonalAtencion", UsuarioBE.CodPersonal, TipodeDato.Int);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("IdRequerimiento", AdmAtencionActXUseReq.Params[AdmAtencionActXUseReq.KEYIDREQUERIMIENTO]);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("IdPersonalRequerimiento", AdmAtencionActXUseReq.Params[AdmAtencionActXUseReq.KEYIDPERSONALRQR], TipodeDato.Int);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                    oParamCollections.Add(oParam);
                    oEasyDataInterConect.ParamsCollection = oParamCollections;

                    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                    return oEasyDataResult.getDataTable();
                }

                AdmAtencionActXUseReq.Data.Actualiza = function (oNodoDataBE,Estado) {

                    var oEasyDataInterConect = new EasyDataInterConect();
                    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                    oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
                    oEasyDataInterConect.Metodo = "ActividadServicioPorRequerimiento";

                    var oParamCollections = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param("IdRequerimiento", AdmAtencionActXUseReq.Params[AdmAtencionActXUseReq.KEYIDREQUERIMIENTO]);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("IdActividad", oNodoDataBE.ID_SYS);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("IdPersonalAtiende", UsuarioBE.CodPersonal, TipodeDato.Int);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("Descripcion", 'Una descripcion');
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("IdEstado", Estado, TipodeDato.Int);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario , TipodeDato.Int);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                    oParamCollections.Add(oParam);
                    oEasyDataInterConect.ParamsCollection = oParamCollections;
                   

                    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                    var obj = oEasyDataResult.sendData();
                }
            </script>


       <script>


           var arrData = new Array();
           var cmll = SIMA.Utilitario.Constantes.Caracter.Comilla;
           SIMA.Utilitario.Constantes.ImgDataURL.IconSystem = new Array();
           SIMA.Utilitario.Constantes.ImgDataURL.IconSystem.AddName("IconBase", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAABpUExURQAAAMTExJqamsrKyqSkpf////r6+vHx8ezs7Lm5uePj49hxNP/oyP+/kPq6kd7e3vf399jY2P/et/+ye/KlddDQ0MjIyObm5sDAwN/f37i4uP/u0f/MpfzDn/v7+9vb29mcetPT0wAAAO+u5cgAAAAjdFJOU/////////////////////////////////////////////8AZimDlgAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAIRJREFUKFN9zusOwiAMBWBgh8GsyrzOednmef+HtEJixB82oSVfmpwa/pShdZZsgKY0Q+cdCe9R2j9ADa33+r43Qgx5wypYdkC7aoGORtabrZAJ/a5H0jtkfzgqEOEU8D7sA/EcaxguQw3jdSxwuz8yTPOUYRGRRT8arKEKTE8N08qTfAEDvxKTzBGBjwAAAABJRU5ErkJggg==");
           SIMA.Utilitario.Helper.TablaGeneralItem("50", 0, 'Oracle').Rows.forEach(function (Item, i) {
               SIMA.Utilitario.Constantes.ImgDataURL.IconSystem.AddName("Icon" + Item.CODIGO, Item.CMEDIA);
           });

           function LoadIni() {
               var BaseBE = { ID_SYS: 0, NIVEL: "-1", Load: false };
               var OneNode = { id: BaseBE.ID_SYS, name: "Actividades Relacionas al Requerimiento", open: true, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["IconBase"], Data: BaseBE, noR: true, children: null, font: { 'font-weight': 'bold', 'color': 'blue', 'font-style': 'italic' } };
               arrData.Add(OneNode);
               AdmAtencionActXUseReq.EasyControl.Tree(OneNode);
               
           }
           AdmAtencionActXUseReq.EasyControl = {};

           AdmAtencionActXUseReq.EasyControl.Tree = function (oNodoPadre) {
               var NewCollection = new Array();
               var DatRowSelect = null;
               DatRowSelect = AdmAtencionActXUseReq.Data.oDataTableActPrcRqr.Select("ID_PADRE", "=", oNodoPadre.id);
               DatRowSelect.forEach(function (oDataRow, r) {
                   var DataBE = oDataRow;
                   var StrNombre = DataBE.NOMBRE.toString();
                   var NodoBE = null;
                   var ObjLogBE = AdmAtencionActXUseReq.Trace.Log.Find('tskR', DataBE.ID_SYS.toString());
                   var ExpandeCollapse = ((ObjLogBE.NodoBE == null) ? false : ((ObjLogBE.NodoBE.open == "true") ? true : false));

                   if (DataBE.NROHIJOS.toString() != "0") {
                       NodoBE = { id: DataBE.ID_SYS.toString(), pId: oNodoPadre.id, name: StrNombre, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["Icon" + DataBE.NIVEL], open: ExpandeCollapse, noR: true, Data: DataBE, children: null, isParent: true, font: { 'font-weight': 'bold' }, Load: ExpandeCollapse };
                       NewCollection.Add(NodoBE);
                       oNodoPadre.children = NewCollection;
                       AdmAtencionActXUseReq.EasyControl.Tree(NodoBE);
                   }
                   else {
                       var Atendido = ((DataBE.ATENDIDO == "1") ? true : false);
                       var Habilitado = ((oDataRow["IDPERSONALATE"].toString() == UsuarioBE.CodPersonal) ? false: true);//Solo sera editado o mdoficado por el primrro que lo activa
                       NodoBE = { id: DataBE.ID_SYS.toString(), pId: oNodoPadre.id, isParent: false, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["Icon" + DataBE.NIVEL], name: StrNombre, chkDisabled: Habilitado, checked: Atendido, Data: DataBE, children: null, Load: false };
                       NewCollection.Add(NodoBE);
                       oNodoPadre.children = NewCollection;
                   }

                  /* 
                  NewCollection.Add(NodoBE);
                   oNodoPadre.children = NewCollection;
                   if ((DataBE.NROHIJOS.toString() != "0") && (DataBE.IDNIVEL.toString() != "5")) {
                       AdmAtencionActXUseReq.EasyControl.Tree(NodoBE);
                   }
                   else {
                       NodoBE=null;
                   }*/

               });
           }

           AdmAtencionActXUseReq.EasyControl.Tree.ItemSelect = null;
           //Eventos de treeview 
           AdmAtencionActXUseReq.EasyControl.Tree.zTreeOnNodeCreated = function (event, treeId, treeNode) {
               //			{ id:1, pId:0, name:"Custom Icon 01", open:true, iconOpen:"../../../css/zTreeStyle/img/diy/1_open.png", iconClose:"../../../css/zTreeStyle/img/diy/1_close.png"},
               //https://github.com/zTree/zTree_v3/blob/master/demo/en/core/expand.html   expaden dinamico
               var zTree = $.fn.zTree.getZTreeObj(treeId);
               //if (reloadFlag) {
               //    if (checkFlag) {
               //        zTree.checkNode(treeNode, true, true);
               //    }
               //    if (!treeNode.children) {
               //        zTree.reAsyncChildNodes(treeNode, "refresh");
               //    }
               //}
               //alert('4');
           }
           AdmAtencionActXUseReq.EasyControl.Tree.onbeforeClick = function (treeId, treeNode, clickFlag) {
           }
           AdmAtencionActXUseReq.EasyControl.Tree.onClick = function (event, treeId, treeNode, clickFlag) {
               AdmAtencionActXUseReq.EasyControl.Tree.ItemSelect = treeNode;
           }
           AdmAtencionActXUseReq.EasyControl.Tree.DblClick = function (event, treeId, treeNode, clickFlag) {
               var oDataBE = treeNode.Data;
               // AdmAtencionActXUseReq.Detalle.Show(SIMA.Utilitario.Enumerados.ModoPagina.M, oDataBE.ID_SERV_PROD);
           }
           AdmAtencionActXUseReq.EasyControl.Tree.Expand = function (event, treeId, treeNode) {
               var ObjLogBE = AdmAtencionActXUseReq.Trace.Log.Find('SYS', treeNode.id);
               if (ObjLogBE.NodoBE == null) {
                   var strBE = "{id:" + cmll + treeNode.id + cmll + ",open:" + cmll + "false" + cmll + ",Nivel:" + cmll + treeNode.level + cmll + ",Load:true}";
                   ObjLogBE.NodoBE = strBE.toString().SerializedToObject();
               }
               else {
                   ObjLogBE.NodoBE.open = true;
               }

               ObjLogBE.DBLog.Add(ObjLogBE.NodoBE);
               AdmAtencionActXUseReq.Trace.Log.Save('SYS', ObjLogBE);
               if (treeNode.Load == false) {
                   AdmAtencionActXUseReqServicios.EasyControl.Tree(treeNode);
                   treeNode.Load = true;
               }
           }



           function addDiyDom(treeId, treeNode) {
           }

           function getFont(treeId, node) {
               return node.font ? node.font : {};
           }



           AdmAtencionActXUseReq.onCheck = function (e, treeId, treeNode) {
               AdmAtencionActXUseReq.Data.Actualiza(treeNode.Data, ((treeNode.checked==true)?1:0));
           }

           var treeObjet = null;
           var setting = {
               edit: {
                   enable: true,
                   // editNameSelectAll: false, // Cuando la entrada del nombre de edición del nodo se muestre por primera vez, establezca si el contenido txt está todo seleccionado
                   showRemoveBtn: false,
                   showRenameBtn: false
               },
               check: {
                   enable: true,
                   chkDisabledInherit: true
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
                   //beforeClick: AdmAtencionActXUseReq.EasyControl.Tree.onbeforeClick,
                   onClick: AdmAtencionActXUseReq.EasyControl.Tree.onClick,
                   onDblClick: AdmAtencionActXUseReq.EasyControl.Tree.DblClick,
                   /* onNodeCreated: AdmAtencionActXUseReq.EasyControl.Tree.zTreeOnNodeCreated,
                   onExpand: AdmAtencionActXUseReq.EasyControl.Tree.Expand,*/
                   onCheck: AdmAtencionActXUseReq.onCheck
               }
           };


           var treeObject = null;
           $(document).ready(function () {
               //Cargar Datos 
               AdmAtencionActXUseReq.Data.oDataTableActPrcRqr = AdmAtencionActXUseReq.Data.SysProcesActLst();
               LoadIni();

              

               $.fn.zTree.init($("#treeNav"), setting, arrData);
               treeObject = $.fn.zTree.getZTreeObj("treeNav");
               //aler();
           });

       </script>

</body>
    
    
  
</html>
