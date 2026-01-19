<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportExploreV2.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.ReportExploreV2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>


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
        
        </style>

   
    <style>
  
    .ItemObj{
        background: #fefefe;
        color: #15428b;
        font: 12px tahoma,arial,sans-serif;
        margin-top:5px;
        margin-right:15px;
        margin-bottom:5px;
        border: 1px dotted #5394C8;
        height: 35px;        
        width:100%;
     }


    .ItemObj td {
        padding-left:5px;
        padding-right:5px;       
        height:35px;
    }

    .ItemObj tr:hover {
       background-color: #E1EFFA;
    }

    .ItemObjSelected{
        background: #2794DD;
        color: white;
        font: 12px tahoma,arial,sans-serif;
        margin-top:5px;
        margin-bottom:5px;
        border: 1px dotted #5394C8;
        height: 35px;
        width:100%;
     }

    .ItemObjSelected td {
        padding-left:5px;
        padding-right:5px;       
        height:35px;
    }
    /*.ItemObjSelected tr:hover {
       background-color: #E1EFFA;
    }*/
   /*Para el Boton anclar*/
   .imgEfect {
     border: 1px solid #ddd;
     border-radius: 4px;
     padding: 5px;
   }

   .imgEfect:hover {
     box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
   }


    .modal-dialog modal-lg {
         background-color: red;
       border: 1px dotted #5394C8;
    }

</style>

    <style>
        .export-button {
            position: absolute;
            z-index: 1;
          /*  background-color: #007bff; /* Color de fondo del botón */
            padding: 2px; /* Relleno del botón */
            color: white; /* Color del texto del botón */
            border: none; /* Sin borde */
            
            cursor: pointer; /* Cambia el cursor al pasar sobre el botón */
           /* border-radius: 5px; /* Bordes redondeados */
        }
        .export-button:hover {
            background-color: #0056b3; /* Color del botón al pasar el mouse */
        }

    </style> 
    <script type="text/javascript">
        function positionButton() {
          /*  var iframe = document.getElementById('RptInPrevio');
            var button = document.getElementById('ibtn');

            var rect = iframe.getBoundingClientRect();

            // Establece la posición del botón
            button.style.top = rect.top + '17.5' + 'px';
            button.style.left = rect.left+  (rect.width/2) +220 + 'px';*/
            //button.style.width = rect.width + 'px'; // Asegura que el botón tenga el mismo ancho que el iframe
        }

        window.onload = function () {
            positionButton();
        };

        window.onresize = function () {
            positionButton(); // Recalcula la posición si la ventana cambia de tamaño
        };
    </script>

</head>
<body>
    <form id="form1" runat="server">

        <table id="tblReport" style="width: 100%; height: 100%" border="0px">
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" />
                </td>
            </tr>
            <tr>
                <td style="width: 100%; height: 100%;" valign="top" align="left">
                    <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%" border="0px">
                        <tr style="height: 100%;">
                            <!-- PANEL IZQUIERDO -->
                            <td id="leftPanel" style="width: 30%; max-width: 250px; height: 100%; border: 1px dotted #696666; position: relative;" valign="top">
                                <div style="position: relative; width: 100%; height: 100%; display: flex; flex-direction: column;">

                                    <!-- Barra de scroll superior -->
                                    <div class="scroll-top"
                                        style="flex: 0 0 12px; overflow-x: auto; overflow-y: hidden; z-index: 10;">
                                        <div style="width: 600px; height: 1px;"></div>
                                    </div>

                                    <!-- Contenido principal con scroll normal -->
                                    <div class="scroll-main"
                                        style="flex: 1; overflow: auto; white-space: nowrap;">
                                        <div class="content_wrap">
                                            <div class="zTreeDemoBackground left" style="height: 800px">
                                                <ul id="treeNav" class="ztree"></ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Barra de scroll inferior -->
                                    <div class="scroll-bottom"
                                        style="flex: 0 0 12px; overflow-x: auto; overflow-y: hidden; z-index: 10;">
                                        <div style="width: 600px; height: 1px;"></div>
                                    </div>

                                </div>
                            </td>
                         <!-- DIVISOR -->
                        <td id="divider" class="divider"><span>||</span></td>

                            <!-- PANEL DERECHO -->
                            <td class="ReportBody"
                                style="padding: 10px; width: 70%; height: 100%; border: 1px dotted #696666;"
                                valign="top">
                                <div id="iframe-container"
                                    style="position: relative; width: 100%; height: 100%;">

                                    <!-- Botones centrados sobre el iframe -->
                                    <div id="export-buttons-container"
                                        style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); display: flex; gap: 10px; z-index: 1000;">
                                        <asp:ImageButton ID="ibtn" runat="server" CssClass="export-button"
                                            ImageUrl="~/Recursos/img/BtnExcel1.jpg"
                                            OnClick="prExportarExcel"
                                            ToolTip="Exportar datos a Excel (Histórico)" />
                                        <asp:ImageButton ID="ibtn2" runat="server" CssClass="export-button"
                                            ImageUrl="~/Recursos/img/BtnExcel2.jpg"
                                            OnClick="prExportarExcelDT"
                                            ToolTip="Exportar datos a Excel (sólo proceso reciente)" />
                                    </div>

                                    <!-- IFRAME -->
                                    <iframe runat="server" id="RptInPrevio" src=""
                                        allowtransparency="true"
                                        style="background-color: transparent; width: 100%; height: 100%; border: none; margin: 0; padding: 0; overflow: hidden; z-index: 1;"
                                        frameborder="0"></iframe>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div style="position: relative;">
		
	</div>
    
     <cc3:EasyPopupBase ID="EasyPopupTestReportParam"  runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Parámetros de reporte" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupReportParam_Aceptar">
    </cc3:EasyPopupBase>


    <cc3:EasyPopupBase ID="EasyPrevioRpt"  runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Vista previa" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPrevioRpt_Aceptar">
   </cc3:EasyPopupBase>
    </form>

    <script>
        // --- Sincroniza los scrolls horizontales ---
        const topScroll = document.querySelector('.scroll-top');
        const bottomScroll = document.querySelector('.scroll-bottom');
        const mainScroll = document.querySelector('.scroll-main');

        [topScroll, bottomScroll].forEach(bar => {
            bar.addEventListener('scroll', () => {
                mainScroll.scrollLeft = bar.scrollLeft;
                [topScroll, bottomScroll].forEach(other => {
                    if (other !== bar) other.scrollLeft = bar.scrollLeft;
                });
            });
        });
        mainScroll.addEventListener('scroll', () => {
            topScroll.scrollLeft = mainScroll.scrollLeft;
            bottomScroll.scrollLeft = mainScroll.scrollLeft;
        });

        // --- Control de expansión del panel izquierdo ---
        const divider = document.getElementById("divider");
        const leftPanel = document.getElementById("leftPanel");

        let isResizing = false;
        let startX = 0;
        let startWidth = 0;

        // Permite arrastrar el divisor
        divider.addEventListener("mousedown", e => {
            isResizing = true;
            startX = e.clientX;
            startWidth = leftPanel.offsetWidth;
            document.body.style.cursor = "ew-resize";
        });

        document.addEventListener("mousemove", e => {
            if (!isResizing) return;
            const dx = e.clientX - startX;
            leftPanel.style.width = Math.min(Math.max(100, startWidth + dx), 600) + "px";
        });

        document.addEventListener("mouseup", () => {
            isResizing = false;
            document.body.style.cursor = "default";
        });

        // Click en el divisor para colapsar/expandir
        divider.addEventListener("dblclick", () => {
            if (leftPanel.style.width === "0px" || leftPanel.offsetWidth < 20) {
                leftPanel.style.width = "250px";
                divider.querySelector("span").textContent = "||";
            } else {
                leftPanel.style.width = "0px";
                divider.querySelector("span").textContent = "⟩";
            }
        });

        // posiciona los botones de exportacion de excel --
        document.addEventListener("DOMContentLoaded", function () {
            const iframe = document.getElementById("RptInPrevio");
            const buttonsContainer = document.getElementById("export-buttons-container");

            function positionButtons() {
                if (!iframe || !buttonsContainer) return;

                // Rectángulo del iframe relativo al viewport
                const rect = iframe.getBoundingClientRect();

                // Scroll actual para calcular posición absoluta en la página
                const scrollTop = window.scrollY || document.documentElement.scrollTop;
                const scrollLeft = window.scrollX || document.documentElement.scrollLeft;

                // Posicionar el contenedor sobre el centro del iframe
                buttonsContainer.style.position = "absolute";
                buttonsContainer.style.top = (rect.top + scrollTop + 10) + "px"; // 10px desde la parte superior del iframe
                buttonsContainer.style.left = (rect.left + scrollLeft + rect.width / 2) + "px"; // centro horizontal del iframe
                buttonsContainer.style.transform = "translateX(-50%)";
                buttonsContainer.style.zIndex = 1000;
            }

            // Recalcular al cargar la página, redimensionar o hacer scroll
            window.addEventListener("resize", positionButtons);
            window.addEventListener("scroll", positionButtons);

            // Recalcular cuando el iframe termina de cargar su contenido
            iframe.addEventListener("load", positionButtons);

            // Inicial
            positionButtons();
        });

    </script>

</body>

     <script>
  
     function ddlTipo_onItemSelected(ListItem) {
         // alert(ListItem.text);
     }
     function EasyPrevioRpt_Aceptar() {
         return true;
     }
         function refreshPage() {
             // Realiza un refresco de la página después del postback
             window.location.reload();
         }

     </script>

 <script>
     ReportExploreV2.IconFolder = "data:image/gif;base64,R0lGODlhHgAaAHAAACH5BAEAAAcALAAAAAAeABoAggAAADo6OHp6ePr6+uXl5VtbWX19ewAAAANSeLrc/jBKF6q9QcwXhv8fUWgb04GgiK2Ywl4GKoOBO9+4Vx9n7n+73s8XHA6LRqItmUMyb86nLCqlLasoKnagxXarX2n4OWaWk8GXel1qu9+LBAA7";
     ReportExploreV2.IconReporte = "data:image/gif;base64,R0lGODlhHQAhAHAAACH5BAEAAA4ALAAAAAAdACEAgwAAAIqJhnl3dH99esrJyPr6+oSCgM/OzRhavf///0Gl7it80+bt+KzD5wAAAAAAAATA0MlJq73YBcG75wORVUJhnqgpGOIolWksHCy2fXioFnRLxjJWAdazwICnGetYpByRQ57w1HxBk6beZ+C87rJTVdf77CUR6LRafbp5BmdvAXE9ChCJvD6PokMFCip4e4R5fkh2g4V7h0ACC4KLhHQKlZaBUZGLDHqNMn53kg2dBQump5CZQ4qTpH9nkop0a2hfq7GuiHFenimJcr0oibTEdUljcr7HE0/JtgLIzs/R0h4B1M7QF83ZNjjfONcu4xkRADs=";
     ReportExploreV2.OpcionObjetSelected=null


     ReportExploreV2.VistaPrevia = function(PathRpt){
         var oRptInPrevio = jNet.get("RptInPrevio");
         oRptInPrevio.attr("src", PathRpt);

             var DataBE = ReportExploreV2.Navigator.Node.Select.Data;
             /*
             if (DataBE.IdTipo != '9999') {
                 Manager.Task.Excecute(function () {
                     var rect = jNet.get('RptInPrevio').getBoundingClientRect();
    
                     // Posiciona el contenedor en relación al iframe
                     jNet.get("export-buttons-container")
                         .css("display", "flex")
                        // .css("position", "absolute")
                         .css("top", (rect.top + 16.5) + 'px');
                        // .css("left", (rect.left + (rect.width / 2) + 150) + 'px');
                 }, 900, true);
             }
             */
         };


         ReportExploreV2.btnExportaXLS = function () {
             var rect = jNet.get('RptInPrevio').getBoundingClientRect();
             jNet.get("ibtn").css("display", "block")
                 .css("top", rect.top + '16.5' + 'px')
                 .css("left", rect.left + (rect.width / 2) + 220 + 'px');

             // Obtener el tamaño y posición actual de ibtn
             var ibtnRect = jNet.get('ibtn').getBoundingClientRect();

             // Mostrar y posicionar ibtn2 al costado derecho (10px de separación)
             jNet.get("ibtn2").css("display", "block")
                 .css("position", "absolute")
                 .css("top", ibtnRect.top + 'px')
                 .css("left", ibtnRect.right + 10 + 'px')

                 ;
         }


         /*   19.02.2025 se le quita el true
    ReportExploreV2.VistaPrevia = function(PathRpt){
        var oRptInPrevio = jNet.get("RptInPrevio");
        oRptInPrevio.attr("src", PathRpt);

        var DataBE = ReportExploreV2.Navigator.Node.Select.Data;
        if (DataBE.IdTipo != '9999') {
            Manager.Task.Excecute(function () {
                var rect = jNet.get('RptInPrevio').getBoundingClientRect();
                jNet.get("ibtn").css("display", "inline")
                    .css("position", "absolute")
                    .css("top", rect.top + '16.5' + 'px')
                    .css("left", rect.left + (rect.width / 2) + 220 + 'px');
            }, 900);
        }

     ReportExploreV2.SeleccionarOpcion = function (e,idOp) {
         var objContent = jNet.get("tblContentObj");
             objContent.forEach(function (ochild, i) {
                 jNet.get(ochild).attr("class", "ItemObj");
             });
             jNet.get(e).attr("class", "ItemObjSelected");
             ReportExploreV2.OpcionObjetSelected = idOp;
     }

     ReportExploreV2.OpcionTipoObjetoTemplate = function () {
         var MsgTemplate = '<table width="100%" border="0px" align="left">'
         MsgTemplate += '    <tr>'
         MsgTemplate += '        <td id="tblContentObj">'
         MsgTemplate += '            <table class="ItemObj" width="100%" onclick="javacript:ReportExploreV2.SeleccionarOpcion(this,1);"><tr><td style="width:10%"><img src="' + ReportExploreV2.IconFolder + '" ></td><td style="width:90%">Carpeta</td></tr></table>'
         MsgTemplate += '            <table class="ItemObj" width="100%" onclick="javacript:ReportExploreV2.SeleccionarOpcion(this,2);"><tr><td style="width:10%"><img src="' + ReportExploreV2.IconReporte + '" ></td><td style="width:90%">Reporte</td></tr></table>'
         MsgTemplate += '        </td>'
         MsgTemplate += '    </tr>'
         MsgTemplate += '</table>';
         return MsgTemplate;
     }

 </script>

	<SCRIPT type="text/javascript">
		<!--
     /*Definicion de eventos*/
     ReportExploreV2.Navigator = {};
     ReportExploreV2.Navigator.Node = {};
     ReportExploreV2.Navigator.Node.Modo = null;
     ReportExploreV2.Navigator.Node.Select= null;


     ReportExploreV2.Navigator.Node.SelectActivate = function () {
         treeObjet.selectNode(ReportExploreV2.Navigator.Node.Select);
         ReportExploreV2.Navigator.Node.onClick(null, null, ReportExploreV2.Navigator.Node.Select, true);
     }
     //Asociado al evento click del objeto tree
     ReportExploreV2.Navigator.Node.onClick = function (event, treeId, treeNode, clickFlag) {            
             ReportExploreV2.Navigator.Node.Select = treeNode;
         var DataBE = ReportExploreV2.Navigator.Node.Select.Data;
         switch (DataBE.IdTipo) {
             case "9999":
                 ReportExploreV2.VistaPrevia(DataBE.PathFile);
                 break;
         }
        }

        ReportExploreV2.ListFilePdf = function (oDataRptBE) {
            var rptChild = new Array()
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
            oEasyDataInterConect.Metodo = "ListarFilePdfPorUser";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdObjeto", oDataRptBE.IdObjeto);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", ReportExploreV2.Params["UserName"]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Data.OleDB.Param("NomReport", oDataRptBE.Nombre);
            oParamCollections.Add(oParam);


            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var Inject = "";
            var oDataTable = oEasyDataResult.getDataTable();
            if (oDataTable != null) {
                oDataTable.Rows.forEach(function (oDataRow, f) {
                    var DataBE = Inject.Serialized(oDataRow, true);

                    NodoBE = { id: oDataRptBE.IdObjeto.toString() + "-" + f, pId: oDataRptBE.IdObjeto.toString(), name: oDataRow["FechaHora"].toString(), icon: SIMA.Utilitario.Constantes.ImgDataURL.IconPDF,  Data: DataBE };
                    rptChild.Add(NodoBE);
                });
            }
            return rptChild;
        }

     ReportExploreV2.Navigator.Node.DblClick = function (event, treeId, treeNode, clickFlag) {

         try {
             if (ReportExploreV2.Navigator.Node.Select != null) {
                 var ObjetoBE = ReportExploreV2.Navigator.Node.Select.Data;
                 if (ObjetoBE.IdTipo == "2") {
                     var oParamColletions = new EasyPopupTestReportParam.ParamCollection();
                     var oParam = new EasyPopupTestReportParam.Param(ReportExploreV2.KEYQIDOBJETO, ObjetoBE.IdObjeto);
                     oParamColletions.Add(oParam);
                     oParam = new EasyPopupTestReportParam.Param(ReportExploreV2.KEYQNOMBREOBJETO, ObjetoBE.Nombre);
                     oParamColletions.Add(oParam);
                     oParam = new EasyPopupTestReportParam.Param(ReportExploreV2.KEYQQUIENLLAMA, "ReportExploreV2");
                     oParamColletions.Add(oParam);

                     EasyPopupTestReportParam.Load(Page.Request.ApplicationPath + "/GestionReportes/ReportParams.aspx?", oParamColletions, false);
                 }
                 else {
                     var msgConfig = { Titulo: "Error", Descripcion: "El objeto seleccionado no es de tipo Reporte." };
                     var oMsg = new SIMA.MessageBox(msgConfig);
                     oMsg.Alert();
                 }
             }
             else {
                 var msgConfig = { Titulo: "Error", Descripcion: "No se ha seleccionado item de reporte a testear" };
                 var oMsg = new SIMA.MessageBox(msgConfig);
                 oMsg.Alert();
             }
         }
         catch (oException) {
             var msgConfig = { Titulo: "Error", Descripcion: oException };
             var oMsg = new SIMA.MessageBox(msgConfig);
             oMsg.Alert();
         }




     }

     var LogNav = 'NavUSer';
     var cmll = SIMA.Utilitario.Constantes.Caracter.Comilla;
     ReportExploreV2.Navigator.Node.Expand = function (event, treeId, treeNode) {
         var ObjLogBE = ReportExploreV2.Trace.Log.Find(LogNav,treeNode.id);
         if (ObjLogBE.NodoBE == null) {
             var strBE = "{id:" + cmll + treeNode.id + cmll + ",open:" + cmll + "false" + cmll + ",Nivel:" + cmll + treeNode.level + cmll + "}";
             ObjLogBE.NodoBE = strBE.toString().SerializedToObject();
         }
         else {
             ObjLogBE.NodoBE.open = true;
         }
        
         ObjLogBE.DBLog.Add(ObjLogBE.NodoBE);
         ReportExploreV2.Trace.Log.Save(LogNav, ObjLogBE);
         if (treeNode.Load == false) {
             ReportExploreV2.Navigator.LoadChilds(treeNode);
             treeNode.Load = true;
         }

     }
     ReportExploreV2.Navigator.Node.Collapse = function (event, treeId, treeNode) {
         var ObjLogBE = ReportExploreV2.Trace.Log.Find(LogNav, treeNode.id);
         if (ObjLogBE.NodoBE == null) {
             var strBE = "{id:" + cmll + treeNode.id + cmll + ",open:" + cmll + "false" + cmll + "}";
             ObjLogBE.NodoBE = strBE.toString().SerializedToObject();
         }
         else {
             ObjLogBE.NodoBE.open = false;
         }
        

         ObjLogBE.DBLog.Add(ObjLogBE.NodoBE);
         ReportExploreV2.Trace.Log.Save(LogNav, ObjLogBE);
     }
     
   
     /*------------------------------------------------------------CONFIGURACION --------------------------------------------------------------*/
     ReportExploreV2.Config = {};
     /*------------------------------------------------------------CONFIGURACION --------------------------------------------------------------*/
     var arrData = new Array();
     function InicioCarga() {
         var BaseBE = { IdObjeto: 0, IdTipo: "-1" };
         var OneNode = { id: BaseBE.IdObjeto, name: "Explorador de Reportes..", open: true, iconSkin: "pIcon01", Data: BaseBE, noR: true, children: null, font: { 'font-weight': 'bold', 'color': 'blue', 'font-style': 'italic' } };
         arrData[arrData.length] = new Array();
         arrData[arrData.length - 1] = OneNode;
         ReportExploreV2.Navigator.Tree(0, arrData);
     }


    function getFont(treeId, node) {
        return node.font ? node.font : {};
    }

     var IDMark_A = "_a";

     var setting = {
                        edit:    {
                                     enable: false,
                                     editNameSelectAll: false, // Cuando la entrada del nombre de edición del nodo se muestre por primera vez, establezca si el contenido txt está todo seleccionado
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
                        callback:{
                                    beforeClick: beforeClick,
                                    onClick: ReportExploreV2.Navigator.Node.onClick,
                                    onDblClick: ReportExploreV2.Navigator.Node.DblClick,
                                    onNodeCreated: zTreeOnNodeCreated,
                                    onExpand: ReportExploreV2.Navigator.Node.Expand,
                                    onCollapse: ReportExploreV2.Navigator.Node.Collapse,
                                 }
                     };

     function addDiyDom(treeId, treeNode) {}

     function zTreeOnNodeCreated(event, treeId, treeNode) {
         var zTree = $.fn.zTree.getZTreeObj(treeId);
         /*if (reloadFlag) {
             if (checkFlag) {
                 zTree.checkNode(treeNode, true, true);
             }
             if (!treeNode.children) {
                 zTree.reAsyncChildNodes(treeNode, "refresh");
             }
         }*/
     }

     var log, className = "dark";
     function beforeClick(treeId, treeNode, clickFlag) {         
         //className = (className === "dark" ? "" : "dark");
         /*alert("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.name);
         return (treeNode.click != false);*/
     }


     ReportExploreV2.Navigator.LoadChilds = function (oNodePadre) {
            var Inject = "";

            ReportExploreV2.Navigator.LoadNodos(oNodePadre.Data.IdObjeto).Rows.forEach(function (oDataRow, f) {
                var DataBE = Inject.Serialized(oDataRow, true);
                var StrNombre = DataBE.Nombre.toString();// + ' - ' + DataBE.IdObjeto.toString();

                if (DataBE.IdTipo.toString() == "1") {
                    var ObjLogBE = ReportExploreV2.Trace.Log.Find(LogNav, DataBE.IdObjeto.toString());
                    var ExpandeCollapse = ((ObjLogBE.NodoBE == null) ? false : ((ObjLogBE.NodoBE.open == true) ? true : false));
                    NodoBE = { id: DataBE.IdObjeto.toString(), pId: oNodePadre.Data.IdObjeto, name: StrNombre, open: ExpandeCollapse, noR: true, Data: DataBE, children: null, isParent: true, Load: false, font: { 'font-weight': 'bold' } };
                }
                else {
                   
                    if (DataBE.IdTipo.toString().Equal("2")) {
                        var ChildFilesPdf = ReportExploreV2.ListFilePdf(oDataRow);
                        if ((ChildFilesPdf != null) && (ChildFilesPdf.length > 0)) {
                            var strImg = Page.Request.ApplicationPath + "/Recursos/img/rptOpen.png";
                            NodoBE = { id: DataBE.IdObjeto.toString(), pId: oNodePadre.Data.IdObjeto, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconCrystalRpt, name: StrNombre, Data: DataBE, children: ChildFilesPdf };
                        }
                        else {
                            NodoBE = { id: DataBE.IdObjeto.toString(), pId: oNodePadre.Data.IdObjeto, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconCrystalRpt, name: StrNombre, Data: DataBE, children: null };
                        }
                    }
                    
                }
                treeObjet.addNodes(oNodePadre, NodoBE);
            });
        }


     ReportExploreV2.Navigator.LoadNodos = function (IdObjetoPadre) {
          var oEasyDataInterConect = new EasyDataInterConect();
              oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
              oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "GestionReportes/AdministrarReportes.asmx";
              oEasyDataInterConect.Metodo = "ListarReportesCompartidosPorUsuario";

              var oParamCollections = new SIMA.ParamCollections();
              var oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("IdObjetoPadre", IdObjetoPadre, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
         return oEasyDataResult.getDataTable();
     }

        ReportExploreV2.Navigator.Tree = function (IdObjetoPadre, arrElements) {
            var oDataTable = new SIMA.Data.DataTable('tbl');
            oDataTable = ReportExploreV2.Navigator.LoadNodos(IdObjetoPadre);
            var objNodoPadre = arrElements[arrElements.length - 1];
            var NewCollection = new Array();
            oDataTable.Rows.forEach(function (oDataRow, f) {
                var NodoChild = null;
                var Inject = "";
                var DataBE = Inject.Serialized(oDataRow, true);
                var StrNombre = DataBE.Nombre.toString();// + ' - ' + DataBE.IdObjeto.toString();

                var NodoBE = null;
                if (DataBE.IdTipo.toString() == "1") {
                    var ObjLogBE = ReportExploreV2.Trace.Log.Find(LogNav, DataBE.IdObjeto.toString());
                    var ExpandeCollapse = ((ObjLogBE.NodoBE == null) ? false : ((ObjLogBE.NodoBE.open == "true") ? true : false));
                    NodoBE = { id: DataBE.IdObjeto.toString(), pId: IdObjetoPadre, name: StrNombre, open: ExpandeCollapse, noR: true, Data: DataBE, children: null, isParent: true, font: { 'font-weight': 'bold' }, Load: ExpandeCollapse };
                    NewCollection[NewCollection.length] = new Array();
                    NewCollection[NewCollection.length - 1] = NodoBE;

                    if ((DataBE.NroHijos.toString() != "0") && (ExpandeCollapse == true)) {
                        ReportExploreV2.Navigator.Tree(DataBE.IdObjeto.toString(), NewCollection);
                    }
                }
                else {
                   // NodoBE = { id: DataBE.IdObjeto.toString(), pId: IdObjetoPadre, icon: Page.Request.ApplicationPath + "/Recursos/img/Shared.png", name: StrNombre, Data: DataBE };


                    if (DataBE.IdTipo.toString().Equal("2")) {
                        var ChildFilesPdf = ReportExploreV2.ListFilePdf(oDataRow);
                        if ((ChildFilesPdf != null) && (ChildFilesPdf.length > 0)) {
                            var strImg = Page.Request.ApplicationPath + "/Recursos/img/rptOpen.png";
                            NodoBE = { id: DataBE.IdObjeto.toString(), pId: IdObjetoPadre, icon: strImg, name: StrNombre, Data: DataBE, children: ChildFilesPdf };
                        }
                        else {
                            NodoBE = { id: DataBE.IdObjeto.toString(), pId: IdObjetoPadre, name: StrNombre, Data: DataBE, children: null };
                        }
                    }

                    NewCollection[NewCollection.length] = new Array();
                    NewCollection[NewCollection.length - 1] = NodoBE;
                }

                objNodoPadre.children = NewCollection;
            });
        }


     var treeObjet = null;

     InicioCarga();


     $(document).ready(function () {
         treeObjet = $.fn.zTree.init($("#treeNav"), setting, arrData);
     });
		//-->

    </SCRIPT>

<script>
    // --- Sincroniza los scrolls horizontales ---
    const topScroll = document.querySelector('.scroll-top');
    const bottomScroll = document.querySelector('.scroll-bottom');
    const mainScroll = document.querySelector('.scroll-main');

    [topScroll, bottomScroll].forEach(bar => {
        bar.addEventListener('scroll', () => {
            mainScroll.scrollLeft = bar.scrollLeft;
            [topScroll, bottomScroll].forEach(other => {
                if (other !== bar) other.scrollLeft = bar.scrollLeft;
            });
        });
    });
    mainScroll.addEventListener('scroll', () => {
        topScroll.scrollLeft = mainScroll.scrollLeft;
        bottomScroll.scrollLeft = mainScroll.scrollLeft;
    });

    // --- Control de expansión del panel izquierdo ---
    const divider = document.getElementById("divider");
    const leftPanel = document.getElementById("leftPanel");

    let isResizing = false;
    let startX = 0;
    let startWidth = 0;

    // Permite arrastrar el divisor
    divider.addEventListener("mousedown", e => {
        isResizing = true;
        startX = e.clientX;
        startWidth = leftPanel.offsetWidth;
        document.body.style.cursor = "ew-resize";
    });

    document.addEventListener("mousemove", e => {
        if (!isResizing) return;
        const dx = e.clientX - startX;
        leftPanel.style.width = Math.min(Math.max(100, startWidth + dx), 600) + "px";
    });

    document.addEventListener("mouseup", () => {
        isResizing = false;
        document.body.style.cursor = "default";
    });

    // Click en el divisor para colapsar/expandir
    divider.addEventListener("dblclick", () => {
        if (leftPanel.style.width === "0px" || leftPanel.offsetWidth < 20) {
            leftPanel.style.width = "250px";
            divider.querySelector("span").textContent = "||";
        } else {
            leftPanel.style.width = "0px";
            divider.querySelector("span").textContent = "⟩";
        }
    });

    // posiciona los botones de exportacion de excel -- SE COMENTA POR QUE AHOR ASE USA LA funcion ReportExploreV2.btnExportaXLS
    /*
    document.addEventListener("DOMContentLoaded", function ()
    {
        const iframe = document.getElementById("RptInPrevio");
        const buttonsContainer = document.getElementById("export-buttons-container");

        function positionButtons() {
            if (!iframe || !buttonsContainer) return;

            // Rectángulo del iframe relativo al viewport
            const rect = iframe.getBoundingClientRect();

            // Scroll actual para calcular posición absoluta en la página
            const scrollTop = window.scrollY || document.documentElement.scrollTop;
            const scrollLeft = window.scrollX || document.documentElement.scrollLeft;

            // Posicionar el contenedor sobre el centro del iframe
            buttonsContainer.style.position = "absolute";
            buttonsContainer.style.top = (rect.top + scrollTop + 10) + "px"; // 10px desde la parte superior del iframe
            buttonsContainer.style.left = (rect.left + scrollLeft + rect.width / 2) + "px"; // centro horizontal del iframe
            buttonsContainer.style.transform = "translateX(-50%)";
            buttonsContainer.style.zIndex = 1000;
        }

        // Recalcular al cargar la página, redimensionar o hacer scroll
        window.addEventListener("resize", positionButtons);
        window.addEventListener("scroll", positionButtons);

        // Recalcular cuando el iframe termina de cargar su contenido
        iframe.addEventListener("load", positionButtons);

        // Inicial
        positionButtons();
    });
    */
   
    
</script>

</html>
