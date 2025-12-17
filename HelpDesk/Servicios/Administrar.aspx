<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Administrar.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Servicios.Administrar" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>
<%@ Register TagPrefix="cc2" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc5" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>

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
        <table id="tblServicios" style="width: 100%;height: 100%" border="0">
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" />
                </td>
            </tr>
            <tr>
                <td style="width: 100%; height: 100%;" valign="top" align="left">
                    <table cellpadding="0" cellspacing="0" style="width: 100%;height: 100%" border="0">
                        <tr class="FondoTool">
                            <td style="width: 22%; height: 10px; border: 1px dotted #696666;">
                                <cc3:EasyToolBarButtons runat="server" ID="EasyToolBarAdm" Width="100%" fnToolBarButtonClick="Administrar.Toolbar.Servicios.onClick">
                                    <EasyButtons>
                                        <cc3:EasyButton Id="btnAgregar" Descripcion="" Icono="fa fa-venus-mars" RunAtServer="False" Texto="" Ubicacion="Izquierda"/>
                                        <cc3:EasyButton Id="btnModificar" Descripcion="" Icono="fa fa-pencil" RunAtServer="False" Texto="" Ubicacion="Izquierda"/>
                                        <cc3:EasyButton Id="btnAreas" Descripcion="" Icono="fa fa-files-o" RunAtServer="False" Texto="" Ubicacion="Centro"/>
                                        <cc3:EasyButton Id="btnActividades" Descripcion="" Icono="fa fa-puzzle-piece" RunAtServer="False" Ubicacion="Centro"/>
                                        <cc3:EasyButton Id="btnResp" Descripcion="" Icono="fa fa-male" RunAtServer="False" Ubicacion="Derecha"/>
                                        <cc3:EasyButton Id="btnEliminar" Descripcion="" Icono="fa fa-trash" RunAtServer="False" Texto="" Ubicacion="Derecha"/>
                                    </EasyButtons>
                                </cc3:EasyToolBarButtons>
                            </td>
                            <td style="padding: 10px; width: 80%; height: 100%; border: 1px dotted white;" align="left" valign="top">
                                <table>
                                    <tr>
                                        <td style="padding-left: 10px; width: 10%; color: white;font-weight: bold" nowrap="nowrap">Servicios</td>
                                        <td id="LstServicios" style="padding-left: 10px; width: 80%;"></td>
                                        <%--<td style="padding-left: 10px; width: 10%; color: white; font-weight: bold;" nowrap="nowrap">

                                        </td>--%>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                        <tr>
                            <td style="width: 20%; height: 100%; border: 1px dotted white;" align="left" valign="top">
                                <cc2:EasyAutocompletar runat="server" DisplayText="NOMBRE" EnableOnChange="False" ID="EasyArea" Placeholder="Seleccionar Area Usuaria" Etiqueta="Centro de Costo" NroCarIni="3" ValueField="CODIGO" >
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
                                <div class="content_wrap box" align="left" valign="top">
                                    <div id="Explore" class="zTreeDemoBackground left ConfigTree">
                                        <ul id="treeNav" class="ztree"></ul>
                                    </div>
                                </div>
                            </td>
                            <td class="ReportBody" style="width: 80%; height: 100%; border: 1px dotted white;" align="left" valign="top">
                                <div id="PanelOpcion"></div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
        <cc3:EasyPopupBase runat="server" ID="EasyPopupDetalleServicioProcedimiento" Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Crear Servicio" RunatServer="false" DisplayButtons="True" fncScriptAceptar="Administrar.Detalle.Aceptar"></cc3:EasyPopupBase>
        <cc3:EasyPopupBase runat="server" ID="EasyPopupActividadesProducto" Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Asignar Actividades" RunatServer="false" DisplayButtons="True" fncScriptAceptar="Administrar.Actividad.Producto.Aceptar"></cc3:EasyPopupBase>
        <cc3:EasyPopupBase runat="server" ID="EasyPopupAreasProducto" Modal="fullscreen" ModoContenedor="LoadPage" Titulo="AsignarAreas" RunatServer="false" DisplayButtons="True" fncScriptAceptar="Administrar.Area.Producto.Aceptar"></cc3:EasyPopupBase>
        <cc3:EasyPopupBase runat="server" ID="EasyPopupRespProducto" Modal="fullscreen" ModoContenedor="LoadPage" Titulo="AsignarAreas" RunatServer="false" DisplayButtons="True" fncScriptAceptar="Administrar.Responsable.Producto.Aceptar"></cc3:EasyPopupBase>
    </form>

    <script>
        SIMA.Utilitario.Constantes.ImgDataURL.IconSystem = new Array();
        SIMA.Utilitario.Constantes.ImgDataURL.IconSystem.AddName("IconBase", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAABpUExURQAAAMTExJqamsrKyqSkpf////r6+vHx8ezs7Lm5uePj49hxNP/oyP+/kPq6kd7e3vf399jY2P/et/+ye/KlddDQ0MjIyObm5sDAwN/f37i4uP/u0f/MpfzDn/v7+9vb29mcetPT0wAAAO+u5cgAAAAjdFJOU/////////////////////////////////////////////8AZimDlgAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAIRJREFUKFN9zusOwiAMBWBgh8GsyrzOednmef+HtEJixB82oSVfmpwa/pShdZZsgKY0Q+cdCe9R2j9ADa33+r43Qgx5wypYdkC7aoGORtabrZAJ/a5H0jtkfzgqEOEU8D7sA/EcaxguQw3jdSxwuz8yTPOUYRGRRT8arKEKTE8N08qTfAEDvxKTzBGBjwAAAABJRU5ErkJggg==");

        Administrar.Data = {};

        SIMA.Utilitario.Helper.TablaGeneralItem("50", 0, 'Oracle').Rows.forEach(function (Item, i) {
            SIMA.Utilitario.Constantes.ImgDataURL.IconSystem.AddName("Icon" + Item.CODIGO, Item.CMEDIA);
        });

        Administrar.Toolbar = {};

        Administrar.Data.Servicios = {};
        Administrar.EasyControl = {};
    </script>

    <script>

        Administrar.DetalleServicios = function(oModo, Id) {
            var Url = Page.Request.ApplicationPath + "/Helpdesk/Servicios/DetalleServicio_Proceso.aspx";
            var oCollectionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, oModo);
            oCollectionParams.Add(oParam);

            oParam = new SIMA.Param(Administrar.KEYIDSERVICIO, Id);
            oCollectionParams.Add(oParam);

            oParam = new SIMA.Param(Administrar.KEYIDPADRE, Administrar.EasyControl.Tree.ItemSelect.Data.ID_SERV_PROD);
            oCollectionParams.Add(oParam);

            EasyPopupDetalleServicioProcedimiento.Titulo = "Servicios";
            EasyPopupDetalleServicioProcedimiento.Load(Url, oCollectionParams, false);
        }

        Administrar.DetalleActividades = function(oModo, Id) {
            var Url = Page.Request.ApplicationPath + "/Helpdesk/Servicios/AdministrarActividadesXProducto.aspx";
            var oCollectionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, oModo);
            oCollectionParams.Add(oParam);

            oParam = new SIMA.Param(Administrar.KEYIDSERVICIO, Id);
            oCollectionParams.Add(oParam);

            EasyPopupActividadesProducto.Titulo = "Actividades";
            EasyPopupActividadesProducto.Load(Url, oCollectionParams, false);
        }

        Administrar.DetalleAreas = function (oModo, Id) {
            var Url = Page.Request.ApplicationPath + "/Helpdesk/Servicios/AdministrarAreaXProducto.aspx";
            var oCollectionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, oModo);
            oCollectionParams.Add(oParam);

            oParam = new SIMA.Param(Administrar.KEYIDSERVICIO, Id);
            oCollectionParams.Add(oParam);

            EasyPopupAreasProducto.Titulo = "Areas";
            EasyPopupAreasProducto.Load(Url, oCollectionParams, false);
        }

        Administrar.DetalleResponsable = function (oModo, Id) {
            var Url = Page.Request.ApplicationPath + "/Helpdesk/Servicios/DetalleResponsable.aspx";
            var oCollectionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, oModo);
            oCollectionParams.Add(oParam);

            oParam = new SIMA.Param(Administrar.KEYIDSERVICIO, Id);
            oCollectionParams.Add(oParam);

            EasyPopupRespProducto.Titulo = "Responsables";
            EasyPopupRespProducto.Load(Url, oCollectionParams, false);
        }

        Administrar.Toolbar.Servicios = {}
        Administrar.Toolbar.Servicios.onClick = function (btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregar":
                    if (Administrar.EasyControl.Tree.ItemSelect.Data.PRODUCTO == 0) {
                        Administrar.DetalleServicios(SIMA.Utilitario.Enumerados.ModoPagina.N, "0", Administrar.EasyControl.Tree.ItemSelect.Data.ID_SERV_PROD);
                    } else {
                        var msgConfig = { Titulo: "Error al insertar", Descripcion: 'No esta permitido crear un nivel adicional al PRODUCTO' };
                        (new SIMA.MessageBox(msgConfig)).Alert();
                    }
                    break;
                case "btnModificar":
                    var oNode = Administrar.EasyControl.Tree.ItemSelect.getParentNode();
                    Administrar.DetalleServicios(SIMA.Utilitario.Enumerados.ModoPagina.M, Administrar.EasyControl.Tree.ItemSelect.Data.ID_SERV_PROD);
                    break;
                case "btnActividades":
                    var oNode = Administrar.EasyControl.Tree.ItemSelect.getParentNode();
                    Administrar.DetalleActividades(SIMA.Utilitario.Enumerados.ModoPagina.N, Administrar.EasyControl.Tree.ItemSelect.Data.ID_SERV_PROD);
                    break;
                case "btnAreas":
                    var oNode = Administrar.EasyControl.Tree.ItemSelect.getParentNode();
                    Administrar.DetalleAreas(SIMA.Utilitario.Enumerados.ModoPagina.N, Administrar.EasyControl.Tree.ItemSelect.Data.ID_SERV_PROD);
                    break;
                case "btnResp":
                    var oNode = Administrar.EasyControl.Tree.ItemSelect.getParentNode();
                    Administrar.DetalleResponsable(SIMA.Utilitario.Enumerados.ModoPagina.N, Administrar.EasyControl.Tree.ItemSelect.Data.ID_SERV_PROD);
                    break;
            }
        }

    </script>

    <script>

        var arrData = new Array();
        var cmll = SIMA.Utilitario.Constantes.Caracter.Comilla;

        function LoadIni() {
            var BaseBE = { ID_SERV_PROD: 0, PRODUCTO: 0, Load: false };
            var OneNode = { id: BaseBE.ID_SERV_PROD, name: "Net Services", open: true, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["IconBase"], Data: BaseBE, nor: true, children: null, font: { 'font-weight': 'bold', 'color': 'blue', 'font-style': 'italic' } };

            arrData.Add(OneNode);
            Administrar.EasyControl.Tree(OneNode);

            //$.fn.zTree.init($("#treeNav"), setting, arrData);
            //treeObject = $.fn.zTree.getZTreeObj("treeNav");
        }

        Administrar.EasyControl = {};
        Administrar.EasyControl.Panel = {};

        Administrar.EasyControl.Panel.ElementosActividad = function (IdServProd) {
            var urlPag = Page.Request.ApplicationPath + "/HelpDesk/Servicios/DetalleComponentesServicio.aspx";

            var oCollectionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, "N");
            oCollectionParams.Add(oParam);
            oParam = new SIMA.Param(Administrar.KEYIDSERVICIO, IdServProd);
            oCollectionParams.Add(oParam);

            var oLoadConfig = {
                CtrlName: "PanelOpcion",
                UrlPage: urlPag,
                ColletionParams: oCollectionParams
            };

            SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
        }

        /**Version 1: Servicios -> Cambio por listado segun Area */
        //Administrar.Data.Servicios = function(IdServicioPadre) {
        //    var oEasyDataInterConect = new EasyDataInterConect();
        //    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        //    oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/Helpdesk/ITIL/GestiondeConfiguracion.asmx";
        //    oEasyDataInterConect.Metodo = "ListarServiosyProductos";

        //    var oParamCollections = new SIMA.ParamCollections();
        //    var oParam = new SIMA.Param("IdServicioPadre", IdServicioPadre);
        //    oParamCollections.Add(oParam);
        //    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
        //    oParamCollections.Add(oParam);
        //    oEasyDataInterConect.ParamsCollection = oParamCollections;

        //    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
        //    return oEasyDataResult.getDataTable();
        //}

        Administrar.Data.Servicios = function(IdServicioPadre) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/Helpdesk/ITIL/GestiondeConfiguracion.asmx";
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

        Administrar.EasyControl.Tree = function(oNodoPadre) {
            var NewCollection = new Array();
            Administrar.Data.Servicios(oNodoPadre.id).Rows.forEach(function(oDataRow, f) {
                var DataBE = oDataRow;
                var StrNombre = DataBE.NOMBRE.toString();

                var NodoBE = null;
                var ObjLogBE = Administrar.Trace.Log.Find('SERV', DataBE.ID_SERV_PROD.toString());
                var ExpandeCollapse = ((ObjLogBE.NodoBE == null) ? false : ((ObjLogBE.NodoBE.open == "true") ? true : false));

                if (DataBE.NROHIJOS.toString() != "0" || DataBE.PRODUCTO.toString() == "0") {
                    NodoBE = { id: DataBE.ID_SERV_PROD.toString(), pId: oNodoPadre.id, name: StrNombre, open: ExpandeCollapse, noR: true, Data: DataBE, children: null, isParent: true, font: { 'font-weight': 'bold' }, Load: ExpandeCollapse };
                } else {
                    NodoBE = { id: DataBE.ID_SERV_PROD.toString(), pId: oNodoPadre.id, isParent: false, name: StrNombre, Data: DataBE, children: null, Load: false };
                }

                NewCollection.Add(NodoBE);
                oNodoPadre.children = NewCollection;
                if ((DataBE.NROHIJOS.toString() != "0")) {
                    Administrar.EasyControl.Tree(NodoBE);
                }
            });
        }

        Administrar.EasyControl.Tree.ItemSelect = null;
        //Eventos de treeview 
        Administrar.EasyControl.Tree.zTreeOnNodeCreated = function (event, treeId, treeNode) {
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
        Administrar.EasyControl.Tree.onbeforeClick = function (treeId, treeNode, clickFlag) {
        }
        Administrar.EasyControl.Tree.onClick = function (event, treeId, treeNode, clickFlag) {
            Administrar.EasyControl.Tree.ItemSelect = treeNode;
        }
        Administrar.EasyControl.Tree.DblClick = function (event, treeId, treeNode, clickFlag) {
            var oDataBE = treeNode.Data;
            //console.log("Valores: " + oDataBE.ID_SERV_PROD);
            Administrar.EasyControl.Panel.ElementosActividad(oDataBE.ID_SERV_PROD);
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
                //beforeClick: Administrar.EasyControl.Tree.onbeforeClick,
                onClick: Administrar.EasyControl.Tree.onClick,
                onDblClick: Administrar.EasyControl.Tree.DblClick,
                /* onNodeCreated: Administrar.EasyControl.Tree.zTreeOnNodeCreated,
                onExpand: Administrar.EasyControl.Tree.Expand,*/
            }
        };

        
        //window.setTimeout(LoadIni(), 3000);

        //var treeObject = null;
        //$(document).ready(function () {
        //    $.fn.zTree.init($("#treeNav"), setting, arrData);
        //    treeObject = $.fn.zTree.getZTreeObj("treeNav");
        //});

        $(document).on('change', '#EasyArea_Text', function () {
            arrData = [];
            LoadIni();
            var treeObject = null;
            $.fn.zTree.init($("#treeNav"), setting, arrData);
            treeObject = $.fn.zTree.getZTreeObj("treeNav");
        });


    </script>


<script>

    Administrar.Detalle = {};
    Administrar.Detalle.Aceptar = function () {
        var IdObj = Administrar.Data.Servicios.InsertaActualiza();

        /*
        var zTree = $.fn.zTree.getZTreeObj("treeNav"),
            nodes = zTree.getSelectedNodes(),
            treeNode = nodes[0];

        var NewtreeNode = zTree.addNodes(treeNode, { id: _ObjetoBE.IdObjeto, pId: _ObjetoBE.IdPadre, isParent: ((_ObjetoBE.IdTipo == 1) ? true : false), name: _ObjetoBE.Nombre, Data: _ObjetoBE });
        AdministrarReporte.Navigator.Node.Select = NewtreeNode;
        */


        return true;
    }

    /**Version 1: Insercion y Actualizacion de servicio*/
    //Administrar.Data.Servicios.InsertaActualiza = function () {
    //    var oEasyDataInterConect = new EasyDataInterConect();
    //    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
    //    oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/Helpdesk/ITIL/GestiondeConfiguracion.asmx";
    //    oEasyDataInterConect.Metodo = "ServiciosModificaInserta";
    //    var oParamCollections = new SIMA.ParamCollections();
    //    var oParam = null;

    //    var DataBE = Administrar.EasyControl.Tree.ItemSelect.Data;

    //    switch (DetalleServicio_Proceso.ModoEdit) {
    //    case SIMA.Utilitario.Enumerados.ModoPagina.N: //Nuevo
    //        oParam = new SIMA.Param("IdServicioProducto", "0");
    //        oParamCollections.Add(oParam);
    //        oParam = new SIMA.Param("IdPadre", DataBE.ID_SERV_PROD);
    //        oParamCollections.Add(oParam);
    //        break;
    //    case SIMA.Utilitario.Enumerados.ModoPagina.M: //Modificar
    //        oParam = new SIMA.Param("IdServicioProducto", DataBE.ID_SERV_PROD);
    //        oParamCollections.Add(oParam);
    //        oParam = new SIMA.Param("IdPadre", DataBE.ID_PADRE);
    //        oParamCollections.Add(oParam);
    //        break;
    //    }
    //    oParam = new SIMA.Param("Nombre", EasyNombre.GetValue());
    //    oParamCollections.Add(oParam);
    //    oParam = new SIMA.Param("Descripcion", txtDescripcion.GetValue());
    //    oParamCollections.Add(oParam);
    //    oParam = new SIMA.Param("Interno", txtTipo.GetValue(), TipodeDato.Int);
    //    oParamCollections.Add(oParam);
    //    oParam = new SIMA.Param("Producto", chkServicio.GetValue() ? "1" : "0", TipodeDato.Int);
    //    oParamCollections.Add(oParam);
    //    oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
    //    oParamCollections.Add(oParam);
    //    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
    //    oParamCollections.Add(oParam);
    //    oEasyDataInterConect.ParamsCollection = oParamCollections;

    //    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
    //    var Result = oEasyDataResult.sendData().toString().SerializedToObject();

    //    if ((Result != null) || (Result != undefined)) {
    //        var treeNode = Administrar.EasyControl.Tree.ItemSelect;
    //        var zTree = $.fn.zTree.getZTreeObj("treeNav");
    //        switch (DetalleServicio_Proceso.ModoEdit) {
    //        case SIMA.Utilitario.Enumerados.ModoPagina.N: //Nuevo
    //            var DataBE = { ID_SERV_PROD: Result.IdOut, ID_PADRE: treeNode.ID_SERV_PROD, NOMBRE: EasyNombre.GetValue()};
    //            var TipoIcono = SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["Icon" + DataBE.TIPO];

    //            NodoBE = { id: DataBE.ID_SERV_PROD, pId: treeNode.ID_SERV_PROD, isParent: false, name: DataBE.NOMBRE, Data: DataBE, children: null, Load: false };
    //            var zTree = $.fn.zTree.getZTreeObj("treeNav");
    //            zTree.addNodes(treeNode, NodoBE);
    //            break;
    //        case SIMA.Utilitario.Enumerados.ModoPagina.M: //Modificar
    //            treeNode.name = EasyNombre.GetValue();
    //            zTree.updateNode(treeNode);
    //            break;
    //        }
    //    }

    //    return Result;
    //}

    Administrar.Data.Servicios.InsertaActualiza = function () {
        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/Helpdesk/ITIL/GestiondeConfiguracion.asmx";
        oEasyDataInterConect.Metodo = "ServiciosModificaInserta";
        var oParamCollections = new SIMA.ParamCollections();
        var oParam = null;

        var DataBE = Administrar.EasyControl.Tree.ItemSelect.Data;

        switch (DetalleServicio_Proceso.ModoEdit) {
            case SIMA.Utilitario.Enumerados.ModoPagina.N: //Nuevo
                oParam = new SIMA.Param("IdServicioProducto", "0");
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdPadre", DataBE.ID_SERV_PROD);
                oParamCollections.Add(oParam);
                break;
            case SIMA.Utilitario.Enumerados.ModoPagina.M: //Modificar
                oParam = new SIMA.Param("IdServicioProducto", DataBE.ID_SERV_PROD);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdPadre", DataBE.ID_PADRE);
                oParamCollections.Add(oParam);
                break;
        }
        oParam = new SIMA.Param("Nombre", EasyNombre.GetValue());
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("Descripcion", txtDescripcion.GetValue());
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("Interno", txtTipo.GetValue(), TipodeDato.Int);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("Producto", chkServicio.GetValue() ? "1" : "0", TipodeDato.Int);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
        oParamCollections.Add(oParam);
        oEasyDataInterConect.ParamsCollection = oParamCollections;

        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
        var Result = oEasyDataResult.sendData().toString().SerializedToObject();

        if ((Result != null) || (Result != undefined)) {

            if (SIMA.Utilitario.Enumerados.ModoPagina.N) {

                var oEasyDataInterConect2 = new EasyDataInterConect();
                oEasyDataInterConect2.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect2.UrlWebService = ConnectService.PathNetCore + "/Helpdesk/ITIL/GestiondeConfiguracion.asmx";
                oEasyDataInterConect2.Metodo = "ServicioArea";
                var oParamCollections2 = new SIMA.ParamCollections();
                var oParam2 = null;

                oParam2 = new SIMA.Param("IdServicioArea", "0");
                oParamCollections2.Add(oParam2);
                oParam2 = new SIMA.Param("IdServicioProducto", Result.IdOut.toString());
                oParamCollections2.Add(oParam2);
                oParam2 = new SIMA.Param("CodEmp", "001");
                oParamCollections2.Add(oParam2);
                oParam2 = new SIMA.Param("CodSuc", "001");
                oParamCollections2.Add(oParam2);
                oParam2 = new SIMA.Param("CodArea", EasyArea.GetValue().replace("400", ""));
                oParamCollections2.Add(oParam2);
                oParam2 = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections2.Add(oParam2);
                oParam2 = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections2.Add(oParam2);

                oEasyDataInterConect2.ParamsCollection = oParamCollections2;

                var oEasyDataResult2 = new EasyDataResult(oEasyDataInterConect2);
                var Result2 = oEasyDataResult2.sendData().toString().SerializedToObject();

                if (Result2 != "-1") {
                    var treeNode = Administrar.EasyControl.Tree.ItemSelect;
                    var zTree = $.fn.zTree.getZTreeObj("treeNav");
                    switch (DetalleServicio_Proceso.ModoEdit) {
                        case SIMA.Utilitario.Enumerados.ModoPagina.N: //Nuevo
                            var DataBE = { ID_SERV_PROD: Result.IdOut, ID_PADRE: treeNode.ID_SERV_PROD, NOMBRE: EasyNombre.GetValue() };
                            var TipoIcono = SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["Icon" + DataBE.TIPO];

                            NodoBE = { id: DataBE.ID_SERV_PROD, pId: treeNode.ID_SERV_PROD, isParent: false, name: DataBE.NOMBRE, Data: DataBE, children: null, Load: false };
                            var zTree = $.fn.zTree.getZTreeObj("treeNav");
                            zTree.addNodes(treeNode, NodoBE);
                            break;
                        case SIMA.Utilitario.Enumerados.ModoPagina.M: //Modificar
                            treeNode.name = EasyNombre.GetValue();
                            zTree.updateNode(treeNode);
                            break;
                    }
                    return;
                }
                else {
                    var msgConfig = { Titulo: "Error de enlace", Descripcion: 'El area: ' + EasyArea.GetValue() + ' no pudo ser asignada' };
                    (new SIMA.MessageBox(msgConfig)).Alert();
                }
            }
        }

        return Result;
    }

</script>

<script>
    Administrar.Area = {};
    Administrar.Area.Producto = {};
    Administrar.Area.Producto.Aceptar = function () {
        var IdObj = Administrar.Area.Producto.AsignarArea();

        return true;
    }

    Administrar.Area.Producto.AsignarArea = function () {

        var treeObject = $.fn.zTree.getZTreeObj("treeNavArea");
        var checkedNodes = treeObject.getCheckedNodes(true);

        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/ITIL/GestiondeConfiguracion.asmx";
        oEasyDataInterConect.Metodo = "ServicioArea";

        checkedNodes.forEach(function (oNodoBE) {

            oEasyDataInterConect.ParamsCollection = null;
            var oParamCollection = new SIMA.ParamCollections();
            var oParam = null;

            if (oNodoBE.Data.ID_SERV_PROD.toString() != "0") {
                oParam = new SIMA.Param("IdServicioArea", "0");
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("IdServicioProducto", oNodoBE.Data.ID_SERV_PROD.toString());
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("CodEmp", "001");
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("CodSuc", "001");
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("CodArea", EasyAreaObj.GetValue().replace("400", ""));
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollection.Add(oParam);

                oEasyDataInterConect.ParamsCollection = oParamCollection;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var Result = oEasyDataResult.sendData().toString().SerializedToObject();

                if (Result != "-1") {
                    return;
                }
                else {
                    var msgConfig = { Titulo: "Error de enlace", Descripcion: 'El area: ' + EasyCodArea.GetValue() + ' no pudo ser asignada' };
                    (new SIMA.MessageBox(msgConfig)).Alert();
                }
            }
            else {
                return;
            }
        });
    }
</script>

<script>

    Administrar.Actividad = {};
    Administrar.Actividad.Producto = {};
    Administrar.Actividad.Producto.Aceptar = function () {
        var IdObj = Administrar.Actividad.Producto.AsignarActividad();

        return true;
    }

    Administrar.Actividad.Producto.AsignarActividad = function () {

        var treeObject = $.fn.zTree.getZTreeObj("treeNavAct");
        var checkedNodes = treeObject.getCheckedNodes(true);

        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/ITIL/GestiondeConfiguracion.asmx";
        oEasyDataInterConect.Metodo = "ServicioAsignarActividad";

        checkedNodes.forEach(function (oNodoBE) {

            oEasyDataInterConect.ParamsCollection = null;
            var oParamCollection = new SIMA.ParamCollections();
            var oParam = null;

            if (oNodoBE.Data.ID_SYS.toString() != "0") {
                oParam = new SIMA.Param("IdServicioProducto", Administrar.EasyControl.Tree.ItemSelect.Data.ID_SERV_PROD)
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("IdActividad", oNodoBE.Data.ID_SYS)
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("IdEstado", 1, TipodeDato.Int);
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int)
                oParamCollection.Add(oParam);
                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollection.Add(oParam);

                oEasyDataInterConect.ParamsCollection = oParamCollection;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var Result = oEasyDataResult.sendData().toString().SerializedToObject();

                if (Result != "-1") {
                    return;
                }
                else {
                    var msgConfig = { Titulo: "Error de enlace", Descripcion: "La Actividad: " + oNodoBE.Data.NOMBRE + " no pudo ser asignada" };
                    (new SIMa.MessageBox(msgConfig)).Alert();
                }
            }
            else {
                return;
            }
        });
    }

</script>

<script>

    Administrar.Responsable = {};
    Administrar.Responsable.Producto = {};
    Administrar.Responsable.Producto.Aceptar = function (){
        var IdObj = Administrar.Responsable.Producto.AsignarResponsable();

        return true;
    }

    Administrar.Responsable.Producto.AsignarResponsable = function () {
        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/Helpdesk/ITIL/GestiondeConfiguracion.asmx";
        oEasyDataInterConect.Metodo = "ServicioResponsable";
        var oParamCollections = new SIMA.ParamCollections();
        var oParam = null;

        var DataBE = Administrar.EasyControl.Tree.ItemSelect.Data;

        oParam = new SIMA.Param("IdResponsable", "0");
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("IdServArea", DataBE.ID_SERV_PROD);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("IdPersonal", EasyPersonal.GetValue(), TipodeDato.Int);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("Principal", chkPrincipal.GetValue() ? "1" : "0", TipodeDato.Int);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
        oParamCollections.Add(oParam);
        oEasyDataInterConect.ParamsCollection = oParamCollections;

        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
        var Result = oEasyDataResult.sendData().toString().SerializedToObject();

        if (Result != "-1") {
            return;
        }
        else {
            var msgConfig = { Titulo: "Error de enlace", Descripcion: "Responsable no asignado" };
            (new SIMa.MessageBox(msgConfig)).Alert();
        }
    }

</script>

</body>
</html>
