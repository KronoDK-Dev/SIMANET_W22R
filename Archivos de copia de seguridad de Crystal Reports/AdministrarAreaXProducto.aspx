<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarAreaXProducto.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Servicios.AdministrarAreaXProducto" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc1" %>
<%@ Register TagPrefix="cc5" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>

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
        <table>
            <tr>
                Area:
            </tr>
            <tr>
                <cc2:EasyAutocompletar runat="server" DisplayText="NOMBRE" EnableOnChange="False" ID="EasyAreaObj" Placeholder="Seleccionar Area Usuaria" Etiqueta="Centro de Costo" NroCarIni="3" ValueField="CODIGO" >
                    <EasyStyle Ancho="Doce" />
                    <DataInterconect MetodoConexion="WebServiceInterno">
                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                        <Metodo>ListaCentrosCostos</Metodo>
                        <UrlWebServicieParams>
                            <cc5:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="NOM_CEO" Paramvalue="1"></cc5:EasyFiltroParamURLws>
                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName"></cc5:EasyFiltroParamURLws>
                        </UrlWebServicieParams>
                    </DataInterconect>
                </cc2:EasyAutocompletar>
            </tr>
            <tr>
                SERVICIOS
            </tr>
            <tr>
                <td style="width: 20%; height: 100%; border: 1px dotted white;" align="left" valign="top">
                    <div class="content_wrap box" align="left" valign="top">
                        <div id="Explore" class="zTreeDemoBackground left ConfigTree">
                            <ul id="treeNavArea" class="ztree"></ul>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
<script>
    var arrDataArea = new Array();
    //var cmll,

    function LoadIniArea() {
        var BaseBEArea = { ID_SERV_PROD: 0, Load: false };
        var OneNodeArea = {
            id: BaseBEArea.ID_SERV_PROD,
            name: "Servicios y Productos",
            open: true,
            icon: SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["IconBase"],
            Data: BaseBEArea,
            nor: true,
            children: null,
            font: {
                'font-weight': 'bold',
                'color': 'blue', 'font-style': 'italic'
            }
        };

        arrDataArea.Add(OneNodeArea);
        AdministrarAreaXProducto.EasyControl.Tree(OneNodeArea);
    }

    AdministrarAreaXProducto.Data = {};
    //AdministrarAreaXProducto.Data.Servicios = {};
    AdministrarAreaXProducto.EasyControl = {};

    //**Version 1: Listado General*/
    //AdministrarAreaXProducto.Data.Servicios = function (IdServicioPadre) {
    //    var oEasyDataInterConect = new EasyDataInterConect();
    //    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
    //    oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/ITIL/GestiondeConfiguracion.asmx";
    //    oEasyDataInterConect.Metodo = "ListarServiosyProductos";

    //    var oParamCollections = new SIMA.ParamCollections();
    //    var oParam = new SIMA.Param("IdServicioPadre", IdServicioPadre);
    //    oParamCollections.Add(oParam)
    //    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
    //    oParamCollections.Add(oParam);

    //    oEasyDataInterConect.ParamsCollection = oParamCollections;

    //    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
    //    return oEasyDataResult.getDataTable();
    //}

    AdministrarAreaXProducto.Data.Servicios = function (IdServicioPadre) {
        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/ITIL/GestiondeConfiguracion.asmx";
        oEasyDataInterConect.Metodo = "ListarServiosPorArea";

        var oParamCollections = new SIMA.ParamCollections();
        var oParam = new SIMA.Param("IdServicioPadre", IdServicioPadre);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("CodigoArea", EasyArea.GetValue().replace("400", ""));
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
        oParamCollections.Add(oParam);
        oEasyDataInterConect.ParamsCollection = oParamCollections;

        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
        return oEasyDataResult.getDataTable();
    }

    AdministrarAreaXProducto.EasyControl.Tree = function (oNodoPadre) {
        var NewCollection = new Array();
        AdministrarAreaXProducto.Data.Servicios(oNodoPadre.id).Rows.forEach(function (oDataRow, f) {
            var DataBEArea = oDataRow;
            var StrNombreArea = DataBEArea.NOMBRE.toString();

            var NodoBEArea = null;
            var ObjLogBEArea = AdministrarAreaXProducto.Trace.Log.Find('SERV', DataBEArea.ID_SERV_PROD.toString());
            var ExpandeCollapse = ((ObjLogBEArea.NodoBEArea == null) ? false :
                ((ObjLogBEArea.NodoBEArea.open == "true") ? true : false));

            if (DataBEArea.NROHIJOS.toString() != "0" || DataBEArea.PRODUCTO.toString() == "0") {
                NodoBEArea = {
                    id: DataBEArea.ID_SERV_PROD.toString(),
                    pId: oNodoPadre.id,
                    name: StrNombreArea,
                    open: ExpandeCollapse,
                    nOR: true,
                    Data: DataBEArea,
                    children: null,
                    isParent: true,
                    font: { 'font-weight': 'bold' },
                    Load: ExpandeCollapse
                };
            }
            else {
                NodoBEArea = {
                    id: DataBEArea.ID_SERV_PROD.toString(),
                    pId: oNodoPadre.id,
                    isParent: false,
                    name: StrNombreArea,
                    Data: DataBEArea,
                    children: null,
                    Load: false
                };
            }

            NewCollection.Add(NodoBEArea);
            oNodoPadre.children = NewCollection;
            if ((DataBEArea.NROHIJOS.toString() != "0")) {
                AdministrarAreaXProducto.EasyControl.Tree(NodoBEArea);
            }
        });
    }

    AdministrarAreaXProducto.EasyControl.Tree.ItemSelect = null;
    AdministrarAreaXProducto.EasyControl.Tree.zTreeOnNodeCreated = function (event, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj(treeId);
    }
    AdministrarAreaXProducto.EasyControl.Tree.onbeforeClick = function (treeId, treeNode, clickFlag) {

    }
    AdministrarAreaXProducto.EasyControl.Tree.onClick = function (event, treeId, treeNode, clickFlag) {
        AdministrarAreaXProducto.EasyControl.Tree.ItemSelect = treeNode;
    }

    function addDiyDom(treeId, treeNode) {
    }

    function getfont(treeId, treeNode) {
        return node.font ? node.font : {};
    }

    var treeObject = null;
    var settingArea = {
        edit: {
            enable: true,
            showRemoveBtn: false,
            showRenameBtn: false
        },
        view: {
            fontCss: getFont,
            namesIsHTML: true,
            dblClickExpand: false,
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
            onClick: AdministrarAreaXProducto.EasyControl.Tree.onClick
        }
    };

    window.setTimeout(LoadIniArea(), 3000);

    var treeObjectArea = null;
    $(document).ready(function () {
        $.fn.zTree.init($("#treeNavArea"), settingArea, arrDataArea);
        treeObjectArea = $.fn.zTree.getZTreeObj("treeNavArea");
    })

</script>
<script>
    //AdministrarAreaXProducto.Data.Aceptar = function () {
    //    var treeObject = $.fn.zTree.getZTreeObj("treeNav2");
    //    var checkedNodes = treeObject.getCheckedNodes(true);

    //    console.log(checkedNodes);

    //    checkedNodes.forEach(function (oNodoBE) {
    //        console.log("Nodo Seleccionado: ", {
    //            id: oNodoBE.Data.ID_SERV_PROD,
    //            name: oNodoBE.Data.NOMBRE
    //        });

    //        if (oNodoBE.Data.ID_SERV_PROD.toString() != "0") {
    //            console.log("Registrado : " + oNodoBE.Data.ID_SERV_PROD.toString());
    //        }
    //    });
    //}
</script>
</body>
</html>
