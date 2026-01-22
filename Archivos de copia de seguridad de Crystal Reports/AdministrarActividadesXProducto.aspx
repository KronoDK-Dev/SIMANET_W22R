<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarActividadesXProducto.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Servicios.AdministrarActividadesXProducto" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style>
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
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <%--<table>
            <tr>
                BUSCAR ACTIVIDAD
            </tr>
            <tr>
                <cc2:EasyTextBox runat="server" ID="EasyActividad" Width="100%"/>
            </tr>
            <tr>
                ESTADO
            </tr>
            <tr>
                <cc2:EasyTextBox runat="server" ID="EasyEstado" Width="100%"/>
            </tr>
            <tr>
                ACTIVIDADES ASIGNADAS
            </tr>
            
        </table>--%>
        
        <table style="width:100%">
            <tr>
                <td>
                    <div class="content_wrap box"   align="left"  valign="top" style="width:100%">
                        <div  id="Explore" class="zTreeDemoBackground left ConfigTree" >
                            <ul id="treeNavAct" runat="server" class="ztree"></ul>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <cc2:EasyPathHistory ID="EasyPathActv" TipoPath="Tradicional" runat="server" fncPathOnClick="BtnPath"></cc2:EasyPathHistory></td>
            </tr>
        </table>
        
    </form>

    <script>

        var arrDataAct = new Array();
        var cmll = SIMA.Utilitario.Constantes.Caracter.Comilla;

        function LoadIniAct() {
            var BaseBEAct = { ID_SYS: 0, Load: false };
            var OneNodeAct = { id: BaseBEAct.ID_SYS, name: "Actividades Disponibles", open: true, iconSkin: "pIcon01", Data: BaseBEAct, noR: true, children: null, font: { 'font-weight': 'bold', 'color': 'blue', 'font-style': 'italic' } };

            arrDataAct.Add(OneNodeAct);
            AdministrarActividadesXProducto.EasyControl.Tree(OneNodeAct);
        }

        AdministrarActividadesXProducto.Data = {};
        AdministrarActividadesXProducto.EasyControl = {};

        AdministrarActividadesXProducto.Data.Actividades = function (IdSistemaPadre) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/ITIL/GestiondeConfiguracion.asmx";
            oEasyDataInterConect.Metodo = "ListarActvChck";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdSistemapadre", IdSistemaPadre);
            oParamCollections.Add(oParam);

            console.log("Id:" + AdministrarActividadesXProducto.Params[AdministrarActividadesXProducto.KEYIDSERVICIO]);

            oParam = new SIMA.Param("IdServProd", AdministrarActividadesXProducto.Params[AdministrarActividadesXProducto.KEYIDSERVICIO]);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            console.log("Url:" + oEasyDataInterConect.UrlWebService);
            console.log("Usuario" + UsuarioBE.UserName);
            //console.log(oEasyDataResult.getDataTable());

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
            
        }

        AdministrarActividadesXProducto.EasyControl.Tree = function (oNodoPadre) {
            console.log("Nodo Padre: " + oNodoPadre.id.toString());
            var NewCollection = new Array();
            AdministrarActividadesXProducto.Data.Actividades(oNodoPadre.id).Rows.forEach(function (oDataRow, f) {
                var DataBEAct = oDataRow;
                var StrNombreAct = DataBEAct.NOMBRE.toString();
                var NodoBEAct = null;
                var ObjLogBEAct = AdministrarActividadesXProducto.Trace.Log.Find('Sys', DataBEAct.ID_SYS.toString());
                var ExpandeCollapse = ((ObjLogBEAct.NodoBEAct == null) ? false : ((ObjLogBEAct.open == "true") ? true : false));
                var Check = ((DataBEAct.CHECKED.toString() == "1") ? true : false);

                if (DataBEAct.NROHIJOS.toString() != "0") {
                    NodoBEAct = {
                        id: DataBEAct.ID_SYS.toString(),
                        pId: oNodoPadre.id,
                        name: StrNombreAct,
                        open: ExpandeCollapse,
                        nOR: true,
                        Data: DataBEAct,
                        children: null,
                        isParent: true,
                        checked: Check,
                        font: { 'font-weight': 'bold' },
                        Load: ExpandeCollapse
                    };
                }
                else {
                    NodoBEAct = {
                        id: DataBEAct.ID_SYS.toString(),
                        pId: oNodoPadre.id,
                        isParent: false,
                        name: StrNombreAct,
                        Data: DataBEAct,
                        children: null,
                        checked: Check,
                        Load: false
                    };
                }

                NewCollection.Add(NodoBEAct);
                oNodoPadre.children = NewCollection;
                if ((DataBEAct.NROHIJOS.toString() != "0")) {
                    AdministrarActividadesXProducto.EasyControl.Tree(NodoBEAct);
                }
            });
        }

        AdministrarActividadesXProducto.EasyControl.Tree.ItemSelect = null;

        AdministrarActividadesXProducto.EasyControl.Tree.zTreeOnNodeCreated = function (event, treeId, treeNode) {
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
        AdministrarActividadesXProducto.EasyControl.Tree.onbeforeClick = function (treeId, treeNode, clickFlag) {

        }
        AdministrarActividadesXProducto.EasyControl.Tree.onClick = function (event, treeId, treeNode, clickFlag) {
        }

        function addDiyDom(treeId, treeNode) {
        }

        function getFont(treeId, node) {
            return node.font ? node.font : {};
        }

        var treeObjetAct = null;
        var settingAct = {
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
            check: {
                enable: true,
                chkboxType: { "Y": "ps", "N": "ps" }  // Corregido el signo igual (=) por dos puntos (:)
            },
            callback: {
                //beforeClick: ListarServicioXAreaRQR.EasyControl.Tree.onbeforeClick,
                //onClick: ListarServicioXAreaRQR.EasyControl.Tree.onClick,
                //onDblClick: ListarServicioXAreaRQR.EasyControl.Tree.DblClick,
                //onNodeCreated: ListarServicioXAreaRQR.EasyControl.Tree.zTreeOnNodeCreated,
                //onExpand: ListarServicioXAreaRQR.EasyControl.Tree.Expand,
                /*onCollapse: AdministrarServicios.EasyControl.Tree.Collapse*/
            }
        };

        window.setTimeout(LoadIniAct(), 3000);

        var treeObjectAct = null;
        $(document).ready(function () {
            $.fn.zTree.init($("#treeNavAct"), settingAct, arrDataAct);
            treeObjectAct = $.fn.zTree.getZTreeObj("treeNavAct");
        });

    </script>
</body>
</html>
