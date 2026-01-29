<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Administrar.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.Administrar" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>


<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   
     <script src="http://spedarosalesa:5000/Gojs/go.js"></script>
     <script src="http://spedarosalesa:5000/Gojs/Figures.js"></script>  
     <script src="http://spedarosalesa:5000/Gojs/DrawCommandHandler.js"></script>


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



    <script>

        function TabClick(oTab) {
            var idTab = oTab.attr('id').Replace("EasyTabControl1_","");
            switch (idTab) {
                    case "Elem3":
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
          <table id="tblServicios" style="width:100%;height:100%"  border="0" >
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" />
               </td>
            </tr>
            <tr>
                <td style="width:100%; height:100%;" valign="top"  align="left"  >
                            <table cellpadding="0" cellspacing="0"  style="width:100%; height:100%"   border="0">
                                <tr class="FondoTool"  >
                                    <td style="width:22%;height:10px; border: 1px  dotted #696666;" >  
                                        <cc3:EasyToolBarButtons ID="EasyToolBarAdm" runat="server" Width="100%" fnToolBarButtonClick="Administrar.Toolbar.Sistemas.onClick "  >
                                            <EasyButtons>
                                                <cc3:EasyButton ID="btnAgregar" Descripcion="" Icono="fa fa-venus-mars" RunAtServer="False" Texto="" Ubicacion="Derecha" />
                                                <cc3:EasyButton ID="btnModificar" Descripcion="" Icono="fa fa-pencil" RunAtServer="False" Texto="" Ubicacion="Derecha" />

                                                <cc3:EasyButton ID="btnElimina" Descripcion="" Icono="fa fa-close" RunAtServer="False" Texto="" Ubicacion="Derecha" />
                                            </EasyButtons>
                                        </cc3:EasyToolBarButtons>
                                    </td>
                                      <td  style="padding:10px; width:80%;height:100%;border: 1px  dotted white; " align="left "  valign="top" >
                                          <table>
                                                <tr>
                                                    <td style="padding-left: 10px; width: 10%;color:white;font-weight:bold"  nowrap="nowrap">StakeHolder(Aprobadores):.
                                                    </td>
                                                    <td id="LstUser"  style="padding-left: 10px; width: 80%;" >
                                                    </td>
                                                    <td style="padding-left: 10px; width: 10%;color:white;font-weight:bold"  nowrap="nowrap">
                                                         <cc3:EasyToolBarButtons ID="EasyToolBarButtonsRight" runat="server" Width="100%" fnToolBarButtonClick="Administrar.Toolbar.HelpElem.onClick"  >
                                                             <EasyButtons>
                                                                 <cc3:EasyButton ID="btnADD" Descripcion="" Icono="fa fa-question-circle" RunAtServer="False" Texto="" Ubicacion="Derecha" />
                                                             </EasyButtons>
                                                         </cc3:EasyToolBarButtons>
                                                    </td>

                                                </tr>
                                           </table>
                                     </td>
                                </tr>
                    
                                <tr>
                                    <td  style="width:20%; height:100%;  border: 1px  dotted white; "  align="left"  valign="top" >
                                        <div class="content_wrap box"   align="left"  valign="top">
                                            <div  id="Explore" class="zTreeDemoBackground left ConfigTree" >
                                                   <ul id="treeNav" class="ztree"></ul>
                                            </div>
                                        </div>
                         
                                    </td>
                                    <td class="ReportBody"     style="width:80%;height:100%;border: 1px  dotted white;" align="left "  valign="top" >
                                           <div id="PanelOpcion"></div>
                                    </td>
                                </tr>
                            </table>
                </td>
            </tr>
       </table>


        <cc3:EasyPopupBase ID="EasyPopupDetalleSistemaProcedimiento" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Crear Sistema/Procedimiento - Actividad" RunatServer="false" DisplayButtons="true" ValidarDatos="true" fncScriptAceptar="Administrar.Detalle.Aceptar"></cc3:EasyPopupBase>
        <cc3:EasyPopupBase ID="EasyPopupDetalleElementos" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Elementos - Actividad" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupDetalleElementos.Aceptar"></cc3:EasyPopupBase>
        <cc3:EasyPopupBase ID="EasyPopupHelp" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Ayuda" RunatServer="false" DisplayButtons="true" ></cc3:EasyPopupBase>

        <cc3:EasyPopupBase ID="EasyPopupParamInOut" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Elementos - Actividad" RunatServer="false" DisplayButtons="true" fncScriptAceptar="DetallePoint_In.Aceptar"></cc3:EasyPopupBase>

        <cc3:EasyPopupBase ID="EasyPopupProcedimientoNota" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Notas" RunatServer="false" DisplayButtons="false" ></cc3:EasyPopupBase>
        <cc3:EasyPopupBase ID="EasyPopupProcedimientoDetalleNota" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Notas" RunatServer="false" DisplayButtons="true" fncScriptAceptar="DetalledeNota.Aceptar" ></cc3:EasyPopupBase>

    </form>

         <script>
             SIMA.Utilitario.Constantes.ImgDataURL.IconSystem = new Array();
             SIMA.Utilitario.Constantes.ImgDataURL.IconSystem.AddName("IconBase","data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAABpUExURQAAAMTExJqamsrKyqSkpf////r6+vHx8ezs7Lm5uePj49hxNP/oyP+/kPq6kd7e3vf399jY2P/et/+ye/KlddDQ0MjIyObm5sDAwN/f37i4uP/u0f/MpfzDn/v7+9vb29mcetPT0wAAAO+u5cgAAAAjdFJOU/////////////////////////////////////////////8AZimDlgAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAIRJREFUKFN9zusOwiAMBWBgh8GsyrzOednmef+HtEJixB82oSVfmpwa/pShdZZsgKY0Q+cdCe9R2j9ADa33+r43Qgx5wypYdkC7aoGORtabrZAJ/a5H0jtkfzgqEOEU8D7sA/EcaxguQw3jdSxwuz8yTPOUYRGRRT8arKEKTE8N08qTfAEDvxKTzBGBjwAAAABJRU5ErkJggg==");
             
             

             Administrar.Data = {};
             SIMA.Utilitario.Helper.TablaGeneralItem("50",0,'Oracle').Rows.forEach(function (Item, i) {
                 SIMA.Utilitario.Constantes.ImgDataURL.IconSystem.AddName("Icon" + Item.CODIGO, Item.CMEDIA);
             });

             Administrar.Toolbar = {};
             Administrar.Aprobadores = {}


             Administrar.Aprobadores.ItemplateSolicitud = function (ItemData) {
                 var ImgFirma = Administrar.PathImagenFirmas + ItemData.PORTARETRATO + ".png";

                 var FotoPersona = Administrar.PathFotosPersonal + ItemData.NRODOCDNI + ".jpg";

                 var FotoClassName = "ms-n2 rounded-circle img-fluid";

                 var MsgTemplate = '<table border=0 width="100%" id="tblSendAprob">'
                     + '<tr>'
                     + '     <td colspan=2 align="center"><img width="150px" class="' + FotoClassName + '" src="' + FotoPersona + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;" /></td>'
                     + '</tr>'
                     + '<tr>'
                     + '     <td colspan=2 align="center"><br>Desea enviar una solicitud de aprobación a:' + ItemData.APELLIDOSYNOMBRES + ' a su bandeja de correo ahora? </td>'
                     + '</tr>'
                     + '<tr>'
                     + '     <td rowspan="3" align="center" style="width:40%"><img width = "80px" height="50px" src = "' + ImgFirma + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSFNormal;"></td>'
                     + '</tr>'
                     
                     + '</table>';

                 return MsgTemplate;
             }


             /*

             Administrar.Aprobadores.ItemplateFirmaAprobacion = function (ItemData) {
                 var MsgTemplate = '<table width="100%" align="left">'
                 MsgTemplate += '    <tr><td id="contentDet"></td></tr>'
                 MsgTemplate += '</table>';
                 var urlPag = Page.Request.ApplicationPath + "/HelpDesk/Sistemas/AdministrarAprobacion.aspx";
                 var oColletionParams = new SIMA.ParamCollections();

                 var oParam = new SIMA.Param(AdministrarElementos.KEYMODOPAGINA, 'N');
                 oColletionParams.Add(oParam);

                 oParam = new SIMA.Param(Administrar.KEYIDTAKEHOLDER, ItemData.ID_STAKEHOLDER);
                 oColletionParams.Add(oParam);

                 SIMA.Utilitario.Helper.LoadPageIn("contentDet", urlPag, oColletionParams);
                 return MsgTemplate;
             }

             Administrar.Aprobadores.onClick = function (Modo,SourceCtrl,ItemBE) {
                     var ConfigMsgb = {
                         Titulo: 'Aprobar Actividad:'
                         , Descripcion: Administrar.Aprobadores.ItemplateFirmaAprobacion(ItemBE.DataComplete)
                         , Icono: 'fa fa-tags'
                         , EventHandle: function (btn) {
                             if (btn == 'OK') {
                                 alert("graba");
                             }
                         }
                     }
                     var oMsg = new SIMA.MessageBox(ConfigMsgb);
                     oMsg.confirm();
             }
             */

             Administrar.Toolbar.HelpElem= {}
             Administrar.Toolbar.HelpElem.onClick = function () {
                 var oTabItemBE = EasyTabControl1.TabActivo.attr("Data").toString().SerializedToObject();

                 var Url = oTabItemBE.DESCRIPCION;
                 var oColletionParams = new SIMA.ParamCollections();
                 var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, 'Ayuda');
                 oColletionParams.Add(oParam);
                
                 EasyPopupHelp.Titulo = "Ayuda Conceptual";
                 EasyPopupHelp.Load(Url, oColletionParams, false);
                
             }

             Administrar.Aprobadores.onClick = function (Modo, SourceCtrl, ItemBE) {
                 var ConfigMsgb = {
                     Titulo: 'SOLICITUD DE APROBACIÓN'
                     , Descripcion: Administrar.Aprobadores.ItemplateSolicitud(ItemBE.DataComplete)
                     , Icono: 'fa fa-tag'
                     , EventHandle: function (btn) {
                         if (btn == 'OK') {
                             /*Manager.Task.Excecute(function () {
                                 AdminstrarUsuariosFirmantes.EnviarEmailSolicitudAprobacion(tPlazo);
                             }, 1000);*/
                         }
                     }
                 };
                 var oMsg = new SIMA.MessageBox(ConfigMsgb);
                 oMsg.confirm();
             }

             //

             Administrar.DetalleSistemas = function(oModo,Id,Tipo) {
                 var Url = Page.Request.ApplicationPath + "/HelpDesk/Sistemas/DetalleSistema_Proceso.aspx";
                 var oColletionParams = new SIMA.ParamCollections();
                 //var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, 'N');
                 var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, oModo);
                 oColletionParams.Add(oParam);
                 //oParam = new SIMA.Param(Administrar.KEYIDSYS_PRC, "0");
                 oParam = new SIMA.Param(Administrar.KEYIDSYS_PRC, Id);
                 oColletionParams.Add(oParam);

                 oParam = new SIMA.Param(Administrar.KEYIDPADRE, Administrar.EasyControl.Tree.ItemSelect.Data.ID_SYS);
                 oColletionParams.Add(oParam);

                 var arrRemoverTipo = new Array();
                 //switch (Administrar.EasyControl.Tree.ItemSelect.Data.TIPO) {
                 switch (Tipo) {
                     case "0":
                         arrRemoverTipo.Add("2");
                         arrRemoverTipo.Add("3");
                         arrRemoverTipo.Add("4");
                         arrRemoverTipo.Add("5");
                         break;
                     case "1":
                         arrRemoverTipo.Add("1");
                         arrRemoverTipo.Add("4");
                         arrRemoverTipo.Add("5");
                         break;
                     case "2":
                         arrRemoverTipo.Add("1");
                         arrRemoverTipo.Add("4");
                         arrRemoverTipo.Add("5");
                         break;
                     case "3":
                         arrRemoverTipo.Add("1");
                         arrRemoverTipo.Add("2");
                         arrRemoverTipo.Add("3");
                         break;
                     case "4":
                         arrRemoverTipo.Add("1");
                         arrRemoverTipo.Add("2");
                         arrRemoverTipo.Add("3");
                         arrRemoverTipo.Add("4");
                         break;
                     case "5":
                         arrRemoverTipo.Add("1");
                         arrRemoverTipo.Add("2");
                         arrRemoverTipo.Add("3");
                         arrRemoverTipo.Add("4");
                         arrRemoverTipo.Add("5");
                         break;

                 }
                 oParam = new SIMA.Param("rmOP", arrRemoverTipo.toString().Replace(",", ";"));
                 oColletionParams.Add(oParam);

                 EasyPopupDetalleSistemaProcedimiento.Titulo = "Sistemas, Procesos, Actividades";
                 EasyPopupDetalleSistemaProcedimiento.Load(Url, oColletionParams, false);


             }

            
             Administrar.Toolbar.Sistemas = {}
             Administrar.Toolbar.Sistemas.onClick = function (btnItem, DetalleBE) {
                 switch (btnItem.Id) {
                     case "btnAgregar":
                         if (Administrar.EasyControl.Tree.ItemSelect.Data.TIPO != 5) {
                             Administrar.DetalleSistemas(SIMA.Utilitario.Enumerados.ModoPagina.N, "0", Administrar.EasyControl.Tree.ItemSelect.Data.TIPO);
                         }
                         else {
                              var msgConfig = { Titulo: "Error al insertar un item", Descripcion: 'No esta permitido crea un item bajo del nivel de actividad'};
                                (new SIMA.MessageBox(msgConfig)).Alert();
                         }
                         break;
                     case "btnModificar":
                         var oNode = Administrar.EasyControl.Tree.ItemSelect.getParentNode();
                         Administrar.DetalleSistemas(SIMA.Utilitario.Enumerados.ModoPagina.M, Administrar.EasyControl.Tree.ItemSelect.Data.ID_SYS, oNode.Data.TIPO);
                         break;
                     case "btnElimina":
                             var ConfigMsgb = {
                                 Titulo: 'Eliminar:'
                                 , Descripcion: "Desea Ud Eliminar este registro ahora?"
                                 , Icono: 'fa fa-tags'
                                 , EventHandle: function (btn) {
                                     if (btn == 'OK') {
                                         Administrar.Data.Sistemas.Eliminar();
                                     }
                                 }
                             }
                             var oMsg = new SIMA.MessageBox(ConfigMsgb);
                             oMsg.confirm();
                          break;
                 }
             }

             
         </script>

         <script>
            

             var arrData = new Array();
             var cmll = SIMA.Utilitario.Constantes.Caracter.Comilla;

             function LoadIni() {
                 var BaseBE = { ID_SYS: 0, TIPO: "0", Load: false };
                 var OneNode = { id: BaseBE.ID_SYS, name: "SysProAct", open: true, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["IconBase"], Data: BaseBE, noR: true, children: null, font: { 'font-weight': 'bold', 'color': 'blue', 'font-style': 'italic' } };
                 arrData.Add(OneNode);
                 Administrar.EasyControl.Tree(OneNode);
             }
          //  Administrar.Data = {};
             Administrar.EasyControl = {};
             Administrar.EasyControl.Panel = {};

             Administrar.EasyControl.Panel.ListaAprobadores = function (IdActividad) {
                 var urlPag = Page.Request.ApplicationPath + "/HelpDesk/Sistemas/ListadeAprobadores.aspx";
                 var oColletionParams = new SIMA.ParamCollections();
                 var oParam = new SIMA.Param(Administrar.KEYIDACTIVIDAD, IdActividad);
                 oColletionParams.Add(oParam);
                 var oLoadConfig = {
                     CtrlName: "LstUser",
                     UrlPage: urlPag,
                     ColletionParams: oColletionParams,
                 };
                 SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
             }

             Administrar.EasyControl.Panel.ElementosActividad = function (IdActividad) {

                 var urlPag = Page.Request.ApplicationPath + "/HelpDesk/ITIL/AdministrarComponentesdeActividad.aspx";
                 //var urlPag = Page.Request.ApplicationPath + "/Test/TestTabs.aspx";
                 var oColletionParams = new SIMA.ParamCollections();
                 var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, "N");
                 oColletionParams.Add(oParam);
                 oParam = new SIMA.Param(Administrar.KEYIDACTIVIDAD, IdActividad);
                 oColletionParams.Add(oParam);

                 var oLoadConfig = {
                     CtrlName: "PanelOpcion",
                     UrlPage: urlPag,
                     ColletionParams: oColletionParams,
                     //fnTemplate:function () {},
                     //fnOnComplete: function () {}
                 };

                 SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
             }


            
             Administrar.Data.Sistemas = function (IdSistemaPadre) {
                 var oEasyDataInterConect = new EasyDataInterConect();
                 oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                 oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
                 oEasyDataInterConect.Metodo = "ListarSistemasyProcesos";

                 var oParamCollections = new SIMA.ParamCollections();
                 var oParam = new SIMA.Param("IdSistemapadre", IdSistemaPadre);
                 oParamCollections.Add(oParam);
                 oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                 oParamCollections.Add(oParam);
                 oEasyDataInterConect.ParamsCollection = oParamCollections;

                 var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                 return oEasyDataResult.getDataTable();
             }

             Administrar.EasyControl.Tree = function (oNodoPadre) {
                 var NewCollection = new Array();
                    Administrar.Data.Sistemas(oNodoPadre.id).Rows.forEach(function (oDataRow, f) {
                        var DataBE = oDataRow;// "".Serialized(oDataRow, true);
                        var StrNombre = DataBE.NOMBRE.toString();//+ ' (' + DataBE.ID_SYS.toString() +')';
                     var NodoBE = null;
                     var ObjLogBE = Administrar.Trace.Log.Find('SYS', DataBE.ID_SYS.toString());
                     var ExpandeCollapse = ((ObjLogBE.NodoBE == null) ? false : ((ObjLogBE.NodoBE.open == "true") ? true : false));
                     if (DataBE.NROHIJOS.toString() != "0") {

                         NodoBE = { id: DataBE.ID_SYS.toString(), pId: oNodoPadre.id, name: StrNombre, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["Icon" + DataBE.TIPO], open: ExpandeCollapse, noR: true, Data: DataBE, children: null, isParent: true, font: { 'font-weight': 'bold' }, Load: ExpandeCollapse };
                     }
                     else {
                         NodoBE = { id: DataBE.ID_SYS.toString(), pId: oNodoPadre.id, isParent: false, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["Icon" + DataBE.TIPO], name: StrNombre, Data: DataBE, children: null, Load: false };
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
                 switch (oDataBE.TIPO) {
                     case "4":
                         break;
                     case "5"://Tipo Actividad
                         Administrar.EasyControl.Panel.ElementosActividad(oDataBE.ID_SYS); 
                         Administrar.EasyControl.Panel.ListaAprobadores(oDataBE.ID_SYS);
                         break;
                 }
                 // Administrar.Detalle.Show(SIMA.Utilitario.Enumerados.ModoPagina.M, oDataBE.ID_SERV_PROD);


             }
             Administrar.EasyControl.Tree.Expand = function (event, treeId, treeNode) {
                 var ObjLogBE = Administrar.Trace.Log.Find('SYS', treeNode.id);
                 if (ObjLogBE.NodoBE == null) {
                     var strBE = "{id:" + cmll + treeNode.id + cmll + ",open:" + cmll + "false" + cmll + ",Nivel:" + cmll + treeNode.level + cmll + ",Load:true}";
                     ObjLogBE.NodoBE = strBE.toString().SerializedToObject();
                 }
                 else {
                     ObjLogBE.NodoBE.open = true;
                 }

                 ObjLogBE.DBLog.Add(ObjLogBE.NodoBE);
                 Administrar.Trace.Log.Save('SYS', ObjLogBE);
                 if (treeNode.Load == false) {
                     AdministrarServicios.EasyControl.Tree(treeNode);
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
                   //beforeClick: Administrar.EasyControl.Tree.onbeforeClick,
                      onClick: Administrar.EasyControl.Tree.onClick,
                      onDblClick: Administrar.EasyControl.Tree.DblClick,
                     /* onNodeCreated: Administrar.EasyControl.Tree.zTreeOnNodeCreated,
                     onExpand: Administrar.EasyControl.Tree.Expand,*/
                 }
             };
             


             window.setTimeout(LoadIni(), 3000);

             var treeObject = null;
             $(document).ready(function () {
                 $.fn.zTree.init($("#treeNav"), setting, arrData);
                 treeObject = $.fn.zTree.getZTreeObj("treeNav");
             });

         </script>

        <script>
            Administrar.Detalle = {};
            Administrar.Detalle.Aceptar = function () {
                //if (SIMA.Utilitario.Helper.Form.Validar()) {
                    var IdObj = Administrar.Data.Sistemas.InsertaActualiza();
                    return true;
                //}
                /*
                var zTree = $.fn.zTree.getZTreeObj("treeNav"),
                    nodes = zTree.getSelectedNodes(),
                    treeNode = nodes[0];

                var NewtreeNode = zTree.addNodes(treeNode, { id: _ObjetoBE.IdObjeto, pId: _ObjetoBE.IdPadre, isParent: ((_ObjetoBE.IdTipo == 1) ? true : false), name: _ObjetoBE.Nombre, Data: _ObjetoBE });
                AdministrarReporte.Navigator.Node.Select = NewtreeNode;
                */
            }
            Administrar.Data.Sistemas.InsertaActualiza = function () {
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/Sistemas/GestionSistemas.asmx";
                oEasyDataInterConect.Metodo = "SistemaProcedmientoInsAct";
                var oParamCollections = new SIMA.ParamCollections();
                var oParam = null;

                var DataBE = Administrar.EasyControl.Tree.ItemSelect.Data;

                switch (DetalleSistema_Proceso.ModoEdit) {
                    case SIMA.Utilitario.Enumerados.ModoPagina.N:
                        oParam = new SIMA.Param("IdSys", "0");
                        oParamCollections.Add(oParam);
                        oParam = new SIMA.Param("IdPadre", DataBE.ID_SYS);
                        oParamCollections.Add(oParam);
                        IdNodoPadre = DataBE.ID_SYS;
                        break;
                    case SIMA.Utilitario.Enumerados.ModoPagina.M:
                        oParam = new SIMA.Param("IdSys", DataBE.ID_SYS);
                        oParamCollections.Add(oParam);
                        oParam = new SIMA.Param("IdPadre", DataBE.ID_PADRE);
                        oParamCollections.Add(oParam);
                        break;
                }
                oParam = new SIMA.Param("Nombre", EasyNombre.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("Descripcion", EasyDescripcion.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdNivel", EasyDdLTipo.GetValue() , TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var Result = oEasyDataResult.sendData().toString().SerializedToObject();
                if ((Result != null) || (Result != undefined)) {  
                    var treeNode = Administrar.EasyControl.Tree.ItemSelect;
                    var zTree = $.fn.zTree.getZTreeObj("treeNav");
                    switch (DetalleSistema_Proceso.ModoEdit) {
                        case SIMA.Utilitario.Enumerados.ModoPagina.N:
                            var DataBE = { ID_SYS: Result.IdOut, ID_PADRE: treeNode.ID_SYS, NOMBRE: EasyNombre.GetValue(), TIPO: EasyDdLTipo.GetValue() };
                            var TipoIcono = SIMA.Utilitario.Constantes.ImgDataURL.IconSystem["Icon" + DataBE.TIPO];

                                NodoBE = { id: DataBE.ID_SYS, pId: treeNode.ID_SYS, isParent: true, icon: TipoIcono, name: DataBE.NOMBRE, Data: DataBE, children: null, Load: false };
                                var zTree = $.fn.zTree.getZTreeObj("treeNav");
                                zTree.addNodes(treeNode, NodoBE);
                            break;
                        case SIMA.Utilitario.Enumerados.ModoPagina.M:
                                treeNode.name = EasyNombre.GetValue();
                                zTree.updateNode(treeNode);
                            break;
                    }
                  
                }

                return Result;
            }

            Administrar.Data.Sistemas.Eliminar = function () {
                var DataBE = Administrar.EasyControl.Tree.ItemSelect.Data;

                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/Sistemas/GestionSistemas.asmx";
                oEasyDataInterConect.Metodo = "SistemaProcedmientoDel";
                var oParamCollections = new SIMA.ParamCollections();
                var oParam = null;
                oParam = new SIMA.Param("IdSys", DataBE.ID_SYS);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);

                oEasyDataInterConect.ParamsCollection = oParamCollections;
                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var Result = oEasyDataResult.sendData();
              
            }

        </script>
   

</body>
    
       
    

</html>
