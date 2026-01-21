<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarReporte.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.AdministrarReporte" %>

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
            
           background: url('');
            
        }
        .ConfigTree {
            border: 1px  dotted #696666; 
            overflow-x: hidden;
            overflow-y: auto;
         /*  background-image: url('http://10.10.90.4:7001/SIMANET_W22R/Recursos/img/NavTree.jpg');
          background-size: cover;
         background-repeat: no-repeat;
          background-position: center center;
          background-attachment: fixed;*/

        }
        

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


   .box {
  width: 100%;
 /* border: 2px dashed;*/
  height: 700px;
  overflow-y: scroll;
  scroll-behavior: smooth; /* <--- */
}

#boxChild {
  margin: 600px 0 300px;
  width: 40px;
  height: 40px;
  background: green;
}

</style>




   

</head>
<body>
    <form id="form1" runat="server">
        <table id="tblReport" style="width:100%;height:100%"  border="0px" >
                <tr>
                    <td>
                        <uc1:Header runat="server" ID="Header1" />
                        
                   </td>
                </tr>
                <tr>
                    <td style="width:100%; height:100%;" valign="top"  align="left"  >
                                <table cellpadding="0" cellspacing="0"  style="width:100%; height:100%"   border="2px">
                                    <tr class="FondoTool"  >
                                        <td style="width:20%;height:10px; border: 1px  dotted #696666;" >  
                                            <cc3:EasyToolBarButtons ID="EasyToolBarAdmRPT" runat="server" Width="100%" fnToolBarButtonClick="AdministrarReporte.Navigator.ToolBar.Onclick" OnonClick="EasyToolBarAdmRPT_onClick">
                                                <EasyButtons>
                                                    <cc3:EasyButton ID="btnAgregarObj" Descripcion="" Icono="fa fa-plus-square-o" RunAtServer="False" Texto="" Ubicacion="Derecha" />
                                                    <cc3:EasyButton ID="btnEliminaObj" Descripcion="" Icono="fa fa-close" RunAtServer="False" Texto="" Ubicacion="Derecha" />
                                                    <cc3:EasyButton ID="btnTest" Descripcion="" Icono="" RunAtServer="False" Texto="Test" Ubicacion="Izquierda" />
                                                    <cc3:EasyButton ID="btnCompartir" Descripcion="" Icono="fa fa-share-alt" RunAtServer="False" Texto="" Ubicacion="Centro" />
                                                </EasyButtons>
                                            </cc3:EasyToolBarButtons>
                                        </td>
                                          <td  style="padding:10px; width:80%;height:100%;border: 1px  dotted #696666; " align="left "  valign="top" >
                                              <table>
                                                    <tr>
                                                        <td style="padding-left: 10px; width: 20%;color:white;font-weight:bold"  nowrap>Usuarios Compartidos:.
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
                                            <div class="content_wrap"   align="left"  valign="top">
                                                <div id="Content" class="zTreeDemoBackground left ConfigTree">
                                                    <div id="treePropiedades"></div>      
                                                </div>
                                            </div>
                                        </td>
                                        <!-- <td   style="width:30%; height:100%; border: 1px  dotted #696666; "  align="left"  valign="top">
                                              <div id="ReportBody"></div>
                                         </td>-->
                                    </tr>
                                </table>
                    </td>
                </tr>
           </table>

       

          <cc3:EasyPopupBase ID="EasyPopupReporteCarpeta" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Asignar Reponsable de aprobación" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupReporteCarpeta.Aceptar"></cc3:EasyPopupBase>

          <cc3:EasyPopupBase ID="EasyPopupCarpeta" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Administrar Carpeta" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupCarpeta.Aceptar"></cc3:EasyPopupBase>

          <cc3:EasyPopupBase ID="EasyPopupTestReportParam"  runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Parámetros de reporte" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupReportParam_Aceptar">
          </cc3:EasyPopupBase>

         <cc3:EasyPopupBase ID="EasyPrevioRpt"  runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Vista previa" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPrevioRpt_Aceptar">
         </cc3:EasyPopupBase>

         <cc3:EasyPopupBase ID="EasyPopupCompartir"  runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Compartir" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupCompartir_Aceptar">
         </cc3:EasyPopupBase>




    </form>

   
</body>

    <script>
        //GESTIONREPORTE.RPTuspNTADVisorCarpetaRaizxUsuario 86,56
        function ddlTipo_onItemSelected(ListItem) {
            // alert(ListItem.text);
        }
        function EasyPrevioRpt_Aceptar() {
            return true;
        }


    </script>

    <script>
        AdministrarReporte.IconFolder = "data:image/gif;base64,R0lGODlhHgAaAHAAACH5BAEAAAcALAAAAAAeABoAggAAADo6OHp6ePr6+uXl5VtbWX19ewAAAANSeLrc/jBKF6q9QcwXhv8fUWgb04GgiK2Ywl4GKoOBO9+4Vx9n7n+73s8XHA6LRqItmUMyb86nLCqlLasoKnagxXarX2n4OWaWk8GXel1qu9+LBAA7";
        AdministrarReporte.IconReporte = "data:image/gif;base64,R0lGODlhHQAhAHAAACH5BAEAAA4ALAAAAAAdACEAgwAAAIqJhnl3dH99esrJyPr6+oSCgM/OzRhavf///0Gl7it80+bt+KzD5wAAAAAAAATA0MlJq73YBcG75wORVUJhnqgpGOIolWksHCy2fXioFnRLxjJWAdazwICnGetYpByRQ57w1HxBk6beZ+C87rJTVdf77CUR6LRafbp5BmdvAXE9ChCJvD6PokMFCip4e4R5fkh2g4V7h0ACC4KLhHQKlZaBUZGLDHqNMn53kg2dBQump5CZQ4qTpH9nkop0a2hfq7GuiHFenimJcr0oibTEdUljcr7HE0/JtgLIzs/R0h4B1M7QF83ZNjjfONcu4xkRADs=";
        AdministrarReporte.OpcionObjetSelected=null

        AdministrarReporte.SeleccionarOpcion = function (e,idOp) {
            var objContent = jNet.get("tblContentObj");
                objContent.forEach(function (ochild, i) {
                    jNet.get(ochild).attr("class", "ItemObj");
                });
                jNet.get(e).attr("class", "ItemObjSelected");
                AdministrarReporte.OpcionObjetSelected = idOp;
        }

        AdministrarReporte.OpcionTipoObjetoTemplate = function () {
            var MsgTemplate = '<table width="100%" border="0px" align="left">'
            MsgTemplate += '    <tr>'
            MsgTemplate += '        <td id="tblContentObj">'
            MsgTemplate += '            <table class="ItemObj" width="100%" onclick="javacript:AdministrarReporte.SeleccionarOpcion(this,1);"><tr><td style="width:10%"><img src="' + AdministrarReporte.IconFolder + '" ></td><td style="width:90%">Carpeta</td></tr></table>'
            MsgTemplate += '            <table class="ItemObj" width="100%" onclick="javacript:AdministrarReporte.SeleccionarOpcion(this,2);"><tr><td style="width:10%"><img src="' + AdministrarReporte.IconReporte + '" ></td><td style="width:90%">Reporte</td></tr></table>'
            MsgTemplate += '        </td>'
            MsgTemplate += '    </tr>'
            MsgTemplate += '</table>';
            return MsgTemplate;
        }

    </script>

	<SCRIPT type="text/javascript">
		<!--
        /*Definicion de eventos*/
        AdministrarReporte.Navigator = {};
        AdministrarReporte.Navigator.DetalleObjeto = {};
        AdministrarReporte.Navigator.DetalleObjeto.OnAceptar = function () {
            var arrData = EasyPopupDetalleObj_FrmDataReport.GetAllData();
        }


        AdministrarReporte.Navigator.ToolBar = {};
        AdministrarReporte.Navigator.ToolBar.Onclick = function (btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregarObj":
                    if (AdministrarReporte.Navigator.Node.Select == null) {
                        var msgConfig = { Titulo: "Error", Descripcion: "Seleccionar un item padre a cual se desea crear el Objeto" };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                    }
                    else {
                        AdministrarReporte.Navigator.ToolBar.AddReport();
                    }
                    break;
                case "btnTest":
                    
                    try {
                        if (AdministrarReporte.Navigator.Node.Select != null) {
                            var ObjetoBE = AdministrarReporte.Navigator.Node.Select.Data;
                            if (ObjetoBE.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) {
                                var oParamColletions = new EasyPopupTestReportParam.ParamCollection();
                                var oParam = new EasyPopupTestReportParam.Param(AdministrarReporte.KEYQIDOBJETO, ObjetoBE.IdObjeto);
                                oParamColletions.Add(oParam);
                                oParam = new EasyPopupTestReportParam.Param(AdministrarReporte.KEYQNOMBREOBJETO, ObjetoBE.Nombre);
                                oParamColletions.Add(oParam);
                                oParam = new EasyPopupTestReportParam.Param(AdministrarReporte.KEYQQUIENLLAMA, "AdministrarReporte");
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
                    break;
                case "btnCompartir":
                    var ObjetoBE = AdministrarReporte.Navigator.Node.Select.Data;
                    if (ObjetoBE.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) {
                        AdministrarReporte.ShowCompartir(ObjetoBE.IdObjeto, ObjetoBE.Nombre);
                    }
                    else {
                        var msgConfig = { Titulo: "Error", Descripcion: "No se esta permitido compartir este tipo de Objeto"};
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                    }
                    
                    break;
            }
        }

        AdministrarReporte.ShowCompartir = function (IdObj,Nom) {
                var oParamColletions = new EasyPopupTestReportParam.ParamCollection();
                var oParam = new EasyPopupTestReportParam.Param(AdministrarReporte.KEYQIDOBJETO, IdObj);
                oParamColletions.Add(oParam);
                oParam = new EasyPopupTestReportParam.Param(AdministrarReporte.KEYQNOMBREOBJETO, Nom);
                oParamColletions.Add(oParam);
                EasyPopupCompartir.Titulo = '<table><tr><td><img src="' + SIMA.Utilitario.Constantes.ImgDataURL.ImgCompartir2 + '"/></td><td>Administrar acceso</td></tr></table>';
                EasyPopupCompartir.Load(Page.Request.ApplicationPath + "/GestionReportes/ReporteCompartir.aspx?", oParamColletions, false);
        }


        AdministrarReporte.Navigator.ToolBar.AddReport = function () {
            try {
                var DataBE = AdministrarReporte.Navigator.Node.Select.Data;//Nodo Seleccionado

                if (DataBE.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta) {

                    var ConfigMsgb = {
                        Titulo: 'Tipo Objeto a crear'
                        , Descripcion: AdministrarReporte.OpcionTipoObjetoTemplate()
                        , Icono: 'fa fa-cogs'
                        , EventHandle: function (btn) {
                            if (btn == 'OK') {
                                switch (AdministrarReporte.OpcionObjetSelected.toString()) {
                                    case SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta:
                                        AdministrarReporte.Navigator.Node.Modo = SIMA.Utilitario.Enumerados.ModoPagina.N;
                                        var Url = Page.Request.ApplicationPath + "/GestionReportes/DetalleCarpeta.aspx";
                                        var oColletionParams = new SIMA.ParamCollections();
                                        var oParam = new SIMA.Param(AdministrarReporte.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                                        oColletionParams.Add(oParam);
                                        oParam = new SIMA.Param(AdministrarReporte.KEYQIDOBJETO, DataBE.IdObjeto);
                                        oColletionParams.Add(oParam);
                                        EasyPopupCarpeta.Titulo = "Detalle de Carpeta";
                                        EasyPopupCarpeta.Load(Url, oColletionParams, false);

                                        
                                        break;
                                    case SIMA.Utilitario.Enumerados.TipoObjeto.Reporte:
                                        AdministrarReporte.Navigator.Node.Modo = SIMA.Utilitario.Enumerados.ModoPagina.N;
                                        var Url = Page.Request.ApplicationPath + "/GestionReportes/DetalleObjeto_Reporte.aspx";
                                        var oColletionParams = new SIMA.ParamCollections();
                                        var oParam = new SIMA.Param(AdministrarReporte.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                                        oColletionParams.Add(oParam);
                                        oParam = new SIMA.Param(AdministrarReporte.KEYQIDOBJETO, DataBE.IdObjeto);
                                        oColletionParams.Add(oParam);
                                        EasyPopupReporteCarpeta.Titulo = "Detalle de Reporte (N)";
                                        EasyPopupReporteCarpeta.Load(Url, oColletionParams, false);
                                        break;

                                }
                            }
                        }
                    };
                    var oMsg = new SIMA.MessageBox(ConfigMsgb);
                    oMsg.confirm();
                   
                }
                else if (DataBE.IdTipo == "-1") {
                    var Url = Page.Request.ApplicationPath + "/GestionReportes/DetalleCarpeta.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministrarReporte.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                    oColletionParams.Add(oParam);
                    oParam = new SIMA.Param(AdministrarReporte.KEYQIDOBJETO, "0");
                    oColletionParams.Add(oParam);
                    EasyPopupCarpeta.Titulo = "Detalle de Carpeta";
                    EasyPopupCarpeta.Load(Url, oColletionParams, false);
                }
                else {
                       
                    var msgConfig = { Titulo: "Error", Descripcion: "Para crear un reporte o una carpeta deberá seleccionar El Item Raiz o la Carpeta destino"};
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                }
            }
            catch (erro) {
                alert(erro);
            }             
        }


       
        


        
        AdministrarReporte.Navigator.Node = {};
        AdministrarReporte.Navigator.Node.Modo = null;
        AdministrarReporte.Navigator.Node.Select= null;


        AdministrarReporte.Navigator.Node.SelectActivate = function () {
            treeObjet.selectNode(AdministrarReporte.Navigator.Node.Select);
            AdministrarReporte.Navigator.Node.onClick(null, null, AdministrarReporte.Navigator.Node.Select, true);
        }

        AdministrarReporte.LoadUser = function (IdObjeto) {
            var urlPag = Page.Request.ApplicationPath + "/GestionReportes/UsuarioCompartido.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarReporte.KEYQIDOBJETO, IdObjeto);
            oColletionParams.Add(oParam);
            //SIMA.Utilitario.Helper.LoadPageIn("LstUser", urlPag, oColletionParams);
            var oLoadConfig = {
                CtrlName: "LstUser",
                UrlPage: urlPag,
                ColletionParams: oColletionParams,
                //fnTemplate:function () {},
                //fnOnComplete: function () {}
            };
            SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
        }

        //Asociado al evento click del objeto tree
        IdPropertyLoad = 0;
        var IdPropertyLoad = "";
        AdministrarReporte.Navigator.Node.onClick = function (event, treeId, treeNode, clickFlag) {            
            AdministrarReporte.Navigator.Node.Select = treeNode;
            var DataBE = AdministrarReporte.Navigator.Node.Select.Data;

            switch (DataBE.IdTipo) {
                case SIMA.Utilitario.Enumerados.TipoObjeto.Reporte:
                    IdPropertyLoad = DataBE.IdObjeto;
                    jNet.get("treePropiedades").clear();
                    AdministrarReporte.LoadUser(DataBE.IdObjeto);
                    break;
                case SIMA.Utilitario.Enumerados.TipoObjeto.Secciondeparametros:
                    IdPropertyLoad = DataBE.IdObjeto;
                    jNet.get("treePropiedades").clear();
                    AdministrarReporte.LoadUser(treeNode.IdRpt);
                    break;
                case SIMA.Utilitario.Enumerados.TipoObjeto.parametros:
                    if (IdPropertyLoad != DataBE.IdObjeto) { 

                            AdministrarReporte.Navigator.Node.Select.iconOld = AdministrarReporte.Navigator.Node.Select.icon;
                            AdministrarReporte.Navigator.Node.Select.icon = "../Recursos/img/zTreeStyle/img/loading.gif";
                            treeObjet.updateNode(treeNode);

                            jNet.get("treePropiedades").clear();
                            AdministrarReporte.LoadUser(treeNode.IdRpt);
                            var urlPag = Page.Request.ApplicationPath + "/GestionReportes/AdministrarPropiedades.aspx";
                            var oColletionParams = new SIMA.ParamCollections();
                            var oParam = new SIMA.Param(AdministrarReporte.KEYQIDOBJETO, DataBE.IdObjeto);
                            oColletionParams.Add(oParam);

                            oParam = new SIMA.Param(AdministrarReporte.KEYQIDTIPOCONTROL, DataBE.IdTipoControl);
                            oColletionParams.Add(oParam);

                        //SIMA.Utilitario.Helper.LoadPageIn("treePropiedades", urlPag, oColletionParams);
                            var oLoadConfig = {
                                                CtrlName: "treePropiedades",
                                                UrlPage :urlPag,
                                                ColletionParams : oColletionParams,
                                                //fnTemplate:
                                                fnOnComplete: function () {
                                                    AdministrarReporte.Navigator.Node.Select.icon = AdministrarReporte.Navigator.Node.Select.iconOld;
                                                    treeObjet.updateNode(treeNode);
                                                }
                            };

                            SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);

                            IdPropertyLoad = DataBE.IdObjeto;
                    }
                    break;
            }
        }




        AdministrarReporte.ParamsSeccionTemplate = function (oObjetoBE, Modo) {
            // USADO EN : DetalleObjeto_Reporte.AddParam
            //              DetalleObjeto_Reporte.OnEasyGridButton_Click : btnAgregarSeccion
            var MsgTemplate = '<table width="100%" align="left">'
            MsgTemplate += '    <tr><td id="ContextAdmSecc"></td></tr>'
            MsgTemplate += '</table>';

            var urlPag = Page.Request.ApplicationPath + "/GestionReportes/DetalleObjetoSeccion.aspx";
            var oColletionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(AdministrarReporte.KEYMODOPAGINA, Modo);//Se puede eliminar
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarReporte.KEYQNOMBREOBJETO, oObjetoBE.Nombre);//Nombre del parametro
            oColletionParams.Add(oParam);
            oParam = new SIMA.Param(AdministrarReporte.KEYQDESCRIPCION, oObjetoBE.Descripcion);//Nombre del parametro
            oColletionParams.Add(oParam);


            oParam = new SIMA.Param(AdministrarReporte.KEYQNOMBREPARAM, oObjetoBE.Ref1);//Nombre del parametro
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarReporte.KEYQTIPOPARAM, oObjetoBE.Ref2);//Tipo de Dato del parametro
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarReporte.KEYQIDTIPOOBJETO, oObjetoBE.IdTipo);//Tipo de objeto parametro
            oColletionParams.Add(oParam);


            //SIMA.Utilitario.Helper.LoadPageIn("ContextAdmSecc", urlPag, oColletionParams);
            var oLoadConfig = {
                CtrlName: "ContextAdmSecc",
                UrlPage: urlPag,
                ColletionParams: oColletionParams
                //fnTemplate:function () {},
                //fnOnComplete: function () {}
            };

            SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);


            return MsgTemplate;
        }


        
        AdministrarReporte.Navigator.Node.DblClick = function (event, treeId, treeNode, clickFlag) {
            try {
                var oDataBE = treeNode.Data;
                AdministrarReporte.Navigator.Node.Modo = SIMA.Utilitario.Enumerados.ModoPagina.M;
                if (oDataBE.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta) {
                    var Url = Page.Request.ApplicationPath + "/GestionReportes/DetalleCarpeta.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministrarReporte.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
                    oColletionParams.Add(oParam);
                    oParam = new SIMA.Param(AdministrarReporte.KEYQIDOBJETO, oDataBE.IdObjeto);
                    oColletionParams.Add(oParam);
                    EasyPopupCarpeta.Titulo = "Detalle de Carpeta";
                    EasyPopupCarpeta.Load(Url, oColletionParams, false);
                }
                else if (oDataBE.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) {
                    var Url = Page.Request.ApplicationPath + "/GestionReportes/DetalleObjeto_Reporte.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministrarReporte.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
                    oColletionParams.Add(oParam);
                    oParam = new SIMA.Param(AdministrarReporte.KEYQIDOBJETO, oDataBE.IdObjeto);
                    oColletionParams.Add(oParam);
                    EasyPopupReporteCarpeta.Titulo = "Detalle Reporte (M)";
                    EasyPopupReporteCarpeta.Load(Url, oColletionParams, false);
                }
                else if ((oDataBE.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros) || (oDataBE.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Secciondeparametros)) {
                        var NodoSelectDataBE = AdministrarReporte.Navigator.Node.Select.Data;//Item Seleccionado del treeview
                        var strTitulo = ((oDataBE.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros) ? 'Modificar Parámetro' : 'Modificar Sección');
                        var ConfigMsgb = {
                            Titulo: strTitulo
                            , Width:"500px"
                            , Descripcion: AdministrarReporte.ParamsSeccionTemplate(oDataBE, SIMA.Utilitario.Enumerados.ModoPagina.M)
                            , Icono: 'fa fa-tag'
                            , EventHandle: function (btn) {
                                if (btn == 'OK') {
                                    oDataBE.Nombre = jNet.get('txtNombre').value;
                                    oDataBE.Descripcion = jNet.get('txtDescripcion').value;
                                    treeNode.name = oDataBE.Nombre;
                                    treeObjet.updateNode(treeNode);

                                    AdministrarReporte.ItemNodo.Guardar();
                                }
                            }
                        };
                        var oMsg = new SIMA.MessageBox(ConfigMsgb);
                        oMsg.confirm();

                }
                else {
                    var msgConfig = { Titulo: "Error", Descripcion: "No Implementado" };
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                }

            }
            catch (erro) {
                alert(erro);
            }
        }

        AdministrarReporte.ItemNodo = {};
        
        AdministrarReporte.ItemNodo.Guardar = function () {
                var oObjetoBE = new ObjetoBE();
                var DataReport = AdministrarReporte.Navigator.Node.Select.Data;
                oObjetoBE.IdObjeto = DataReport.IdObjeto;
                oObjetoBE.IdPadre = DataReport.IdPadre;
                oObjetoBE.Nombre = DataReport.Nombre;
                oObjetoBE.IdTipo = DataReport.IdTipo;
                oObjetoBE.IdTipoControl = DataReport.IdTipoControl;
                oObjetoBE.Descripcion = DataReport.Descripcion;
                oObjetoBE.Ref1 = DataReport.Ref1;
                oObjetoBE.Ref2 = DataReport.Ref2;
                oObjetoBE.Ref3 = DataReport.Ref3;//Orden del parámetro
                oObjetoBE.Ref4 = null;
                oObjetoBE.OrdenXNivel = DataReport.OrdenXNivel;
                oObjetoBE.IdUsuarioAnalista = DataReport.IdUsuarioAnalista;
                oObjetoBE.IdUsuarioSolicitante = DataReport.IdUsuarioSolicitante;
                oObjetoBE.IdEstado = "1";
                oObjetoBE.IdUsuario = UsuarioBE.IdUsuario;
                oObjetoBE.UserName = DataReport.UserName;
                AdministrarReporte.Commit(oObjetoBE);
         
        }




        var cmll = SIMA.Utilitario.Constantes.Caracter.Comilla;
        AdministrarReporte.Navigator.Node.Expand = function (event, treeId, treeNode) {
            var ObjLogBE = AdministrarReporte.Trace.Log.Find('Nav',treeNode.id);
            if (ObjLogBE.NodoBE == null) {
                var strBE = "{id:" + cmll + treeNode.id + cmll + ",open:" + cmll + "false" + cmll + ",Nivel:" + cmll + treeNode.level + cmll +"}";
                ObjLogBE.NodoBE = strBE.toString().SerializedToObject();
            }
            else {
                ObjLogBE.NodoBE.open = true;
            }
           
            ObjLogBE.DBLog.Add(ObjLogBE.NodoBE);
            AdministrarReporte.Trace.Log.Save('Nav',ObjLogBE);
            if (treeNode.Load == false) {
                AdministrarReporte.Navigator.LoadChilds(treeNode);
                treeNode.Load = true;
            }
        }
        AdministrarReporte.Navigator.Node.Collapse = function (event, treeId, treeNode) {
            var ObjLogBE = AdministrarReporte.Trace.Log.Find('Nav',treeNode.id);
            if (ObjLogBE.NodoBE == null) {
                var strBE = "{id:" + cmll + treeNode.id + cmll + ",open:" + cmll + "false" + ",Nivel:" + cmll + treeNode.level + cmll + "}";
                ObjLogBE.NodoBE = strBE.toString().SerializedToObject();
            }
            else {
                ObjLogBE.NodoBE.open = false;
            }
            ObjLogBE.DBLog.Add(ObjLogBE.NodoBE);
            AdministrarReporte.Trace.Log.Save('Nav',ObjLogBE);
        }

        /*------------------------------------------------------------CONFIGURACION --------------------------------------------------------------*/
        AdministrarReporte.Config = {};
        AdministrarReporte.Config.DataSource = function (IdObjeto,CallInvoke) {
            var urlPag = Page.Request.ApplicationPath + "/GestionReportes/DetalleReporte.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarReporte.KEYQIDOBJETO, IdObjeto);
            oColletionParams.Add(oParam);
            //SIMA.Utilitario.Helper.LoadPageIn("ReportBody", urlPag, oColletionParams);
            var oLoadConfig = {
                CtrlName: "ReportBody",
                UrlPage: urlPag,
                ColletionParams: oColletionParams,
                //fnTemplate:function () {},
                //fnOnComplete: function () {}
            };
            SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);

            if (CallInvoke == "Externo") {//Para el caso de la configuracion de paramtros del btn ACEPTAR del webforms DetalleConfiguraParametro
                Manager.Task.Excecute(function () {
                    DetalleReporte.MetodoSeleccionado.PaintParametros(EasyListarMetodos.GetText());
                }, 1000);
            }
        } 

        /*------------------------------------------------------------CONFIGURACION --------------------------------------------------------------*/
        var arrData = new Array();
        function InicioCarga() {
            var BaseBE = { IdObjeto: 0, IdTipo: "-1" };
            var OneNode = { id: BaseBE.IdObjeto, name: "Módulo  Gestión de Reportes", open: true, iconSkin: "pIcon01", Data: BaseBE, noR: true, children: null, font: { 'font-weight': 'bold', 'color': 'blue', 'font-style': 'italic' } };
            arrData[arrData.length] = new Array();
            arrData[arrData.length - 1] = OneNode;
            AdministrarReporte.Navigator.Tree(0, arrData);
        }

        /*Funcon que es usada por las 2 opciones como Crear Carpeta y Crear Reporte */

        AdministrarReporte.Commit = function (_ObjetoBE) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
            oEasyDataInterConect.Metodo = "InsertaModificaObjeto";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdObjeto", _ObjetoBE.IdObjeto, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdPadre", _ObjetoBE.IdPadre, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Nombre", _ObjetoBE.Nombre);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdTipo", _ObjetoBE.IdTipo, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdTipoControl", _ObjetoBE.IdTipoControl, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Descripcion", _ObjetoBE.Descripcion);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Ref1", _ObjetoBE.Ref1);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Ref2", _ObjetoBE.Ref2);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Ref3", _ObjetoBE.Ref3);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Ref4", _ObjetoBE.Ref4);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("OrdenXNivel", _ObjetoBE.OrdenXNivel, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdUsuarioAnalista", _ObjetoBE.IdUsuarioAnalista, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdUsuarioSolicitante", _ObjetoBE.IdUsuarioSolicitante, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdEstado", _ObjetoBE.IdEstado, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdUsuario", _ObjetoBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", _ObjetoBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;
            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var Result = oEasyDataResult.sendData();
            _ObjetoBE.IdObjeto = Result;
            //Solo para el cado de reporte y carpetas
            try {
                    var zTree = $.fn.zTree.getZTreeObj("treeNav"),
                        nodes = zTree.getSelectedNodes(),
                        treeNode = nodes[0];

                        if ((_ObjetoBE.IdTipo != SIMA.Utilitario.Enumerados.TipoObjeto.Secciondeparametros) && (_ObjetoBE.IdTipo != SIMA.Utilitario.Enumerados.TipoObjeto.parametros)) {
                            if (AdministrarReporte.Navigator.Node.Modo == SIMA.Utilitario.Enumerados.ModoPagina.N) {
                                var NewtreeNode = zTree.addNodes(treeNode, { id: _ObjetoBE.IdObjeto, pId: _ObjetoBE.IdPadre, isParent: ((_ObjetoBE.IdTipo == 1) ? true : false), name: _ObjetoBE.Nombre, Data: _ObjetoBE });
                                AdministrarReporte.Navigator.Node.Select = NewtreeNode;
                            }
                            else {
                                treeNode.name = _ObjetoBE.Nombre;
                                zTree.updateNode(treeNode,true);
                                AdministrarReporte.Navigator.Node.Select.Data = _ObjetoBE;

                        }
                    }
            }
            catch (erro) {
                alert(erro);
            }
            return Result;//Retorna el Id del registro Creaod
        }


      
       
        function addDiyDom(treeId, treeNode) {
            if ((treeNode.Data.IdTipo == "2") && (treeNode.Data.NroComp != 0)) {
               // var aObj = $("#" + treeNode.tId + IDMark_A);
               // var dvBadge1 = "<span id='diyBtn_" + treeNode.id + "' class='badge1 rounded-pill '> (+" + treeNode.Data.NroComp + ") </span>";
               // aObj.after(dvBadge1);
            }
        }

        function zTreeOnNodeCreated(event, treeId, treeNode) {
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
        }

        var log, className = "dark";
        function beforeClick(treeId, treeNode, clickFlag) {
            
            //className = (className === "dark" ? "" : "dark");
            /*alert("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.name);
            return (treeNode.click != false);*/
        }

        AdministrarReporte.Navigator.Node.beforeDrag = function (treeId, treeNodes) {
            for (var i = 0, l = treeNodes.length; i < l; i++) {
                if (treeNodes[i].drag === false) {
                    return false;
                }
            }
            return true;
        }

        AdministrarReporte.Navigator.Node.beforeDrop = function (treeId, treeNodes, targetNode, moveType) {
            var DataNodeMov = treeNodes[0].Data;
            var DataNodeTarget = targetNode.Data;

            var NodoPadre = treeNodes[0].getParentNode();

            switch (moveType) {
                case "inner":
                    if (((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros)) 
                        || ((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte))){
                        return false;
                    }
                    else if ((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros) && ((DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte)
                                                                                                            || (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta))) {
                        return false;
                    }
                    else if ((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta)) {
                        return true;
                    }
                    else if ((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta)) {
                        return true;
                    }

                    var NodoPadreBE = targetNode.Data;
                    var NodoBE = treeNodes[0].Data;
                    if (targetNode.Load == false) {
                        AdministrarReporte.Navigator.LoadChilds(targetNode);
                        
                        targetNode.Load = true;
                    }
                   
                    break;
                case "prev"://Cuando el Nodo Anterior es de nvel superior(Servira para Ordenar)
                    if (((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros))
                        || ((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte))) {
                        DataNodeMov.Ref4 = 1;
                        return true;
                    }
                    else if ((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta)) {
                        return true;
                    }
                    else if  (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta) {
                        return true;
                    }
                    else if (DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta) {
                        return true;
                    }
                    return false;
                    break;
                case "next"://Cuando el Nodo Anterior y Posterior son del mismo nivel(Servira para Ordenar)
                   
                    if ((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros)) {
                        DataNodeMov.Ref4 = parseInt(DataNodeTarget.Ref4) + 1;
                        //DataNodeTarget.Ref3 = parseInt(DataNodeMov.Ref3) + 1;
                        return true;
                    }
                    else if ((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.parametros) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Secciondeparametros)) {
                        return false;
                    }
                    else if ((DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) && (DataNodeTarget.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta)) {

                        return false;
                    }
                    else if (DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) {
                        return true;
                    }
                    else if (DataNodeMov.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta) {
                        return true;
                    }

                    return false;
                    break;
            }
            return targetNode ? targetNode.drop !== false : true;
            //return false;
        }
       
        AdministrarReporte.Navigator.LoadChilds = function (oNodePadre){
            var Inject = "";
            AdministrarReporte.Navigator.LoadNodos(oNodePadre.Data.IdObjeto).Rows.forEach(function (oDataRow, f) {
                var DataBE = Inject.Serialized(oDataRow, true);
                var StrNombre = DataBE.Nombre.toString();// + ' - ' + DataBE.IdObjeto.toString();
                
                if (DataBE.IdTipo.toString() == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta) {//TipoCarpeta
                    var ObjLogBE = AdministrarReporte.Trace.Log.Find('Nav',oDataRow["IdObjeto"].toString());
                    var ExpandeCollapse = ((ObjLogBE.NodoBE == null) ? false : ((ObjLogBE.NodoBE.open == true) ? true : false));
                    NodoBE = { id: DataBE.IdObjeto.toString(), pId: oNodePadre.Data.IdObjeto, name: StrNombre, open: ExpandeCollapse, noR: true, Data: DataBE, children: null, isParent: true, Load: false, font: { 'font-weight': 'bold' } };
                }
                else if (DataBE.IdTipo.toString() == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) {//Tipo Reporte
                    if (DataBE.NroComp != 0) {
                        NodoBE = { id: DataBE.IdObjeto.toString(), pId: oNodePadre.Data.IdObjeto, isParent: true, icon: Page.Request.ApplicationPath + "/Recursos/img/Shared.png", name: StrNombre, Data: DataBE, children: null ,Load:false};
                    }
                    else {
                        NodoBE = { id: DataBE.IdObjeto.toString(), pId: oNodePadre.Data.IdObjeto, isParent: true, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconCrystalRpt, name: StrNombre, Data: DataBE, children: null, Load: false};
                    }
                }
                else if (DataBE.IdTipo.toString() == SIMA.Utilitario.Enumerados.TipoObjeto.Secciondeparametros) {//Tipo Seccion
                    AdministrarReporte.LoadUser(oNodePadre.Data.IdObjeto);
                    NodoBE = { id: DataBE.IdObjeto.toString(), pId: oNodePadre.Data.IdObjeto, isParent: true, icon: DataBE.imgCtrl, name: StrNombre, Data: DataBE, children: null, Load: false, IdRpt: oNodePadre.Data.IdObjeto };
                }
                else if (DataBE.IdTipo.toString() == SIMA.Utilitario.Enumerados.TipoObjeto.parametros) {//Parametros
                    AdministrarReporte.LoadUser(oNodePadre.IdRpt);
                    NodoBE = { id: DataBE.IdObjeto.toString(), pId: oNodePadre.Data.IdObjeto, icon: DataBE.imgCtrl, name: StrNombre, Data: DataBE, IdRpt: oNodePadre.IdRpt};
                }

                treeObjet.addNodes(oNodePadre, NodoBE);
            });
        }

        AdministrarReporte.Navigator.LoadNodos = function (IdObjetoPadre) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/GestionReportes/AdministrarReportes.asmx";
            oEasyDataInterConect.Metodo = "ListarObjetos";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdPadre", IdObjetoPadre);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }

        AdministrarReporte.Navigator.Tree = function (IdObjetoPadre,arrElements) {
            var oDataTable = new SIMA.Data.DataTable('tbl');

            oDataTable = AdministrarReporte.Navigator.LoadNodos(IdObjetoPadre);
            var objNodoPadre = arrElements[arrElements.length - 1];
            var NewCollection = new Array();
            oDataTable.Rows.forEach(function (oDataRow, f) {
                var NodoChild = null;
                var Inject = "";
                var DataBE = Inject.Serialized(oDataRow, true);
                var StrNombre = DataBE.Nombre.toString();// + ' - ' + DataBE.IdObjeto.toString();

                var NodoBE = null;
                if (DataBE.IdTipo.toString() == SIMA.Utilitario.Enumerados.TipoObjeto.Carpeta) {//Tipo Carpeta
                    var ObjLogBE = AdministrarReporte.Trace.Log.Find('Nav',DataBE.IdObjeto.toString());
                    var ExpandeCollapse = ((ObjLogBE.NodoBE == null) ? false : ((ObjLogBE.NodoBE.open == "true") ? true : false));
                    NodoBE = { id: DataBE.IdObjeto.toString(), pId: IdObjetoPadre, name: StrNombre, open: ExpandeCollapse, noR: true, Data: DataBE, children: null, isParent: true, font: { 'font-weight': 'bold' }, Load: ExpandeCollapse };
                    NewCollection[NewCollection.length] = new Array();
                    NewCollection[NewCollection.length - 1] = NodoBE;

                    if ((DataBE.NroHijos.toString() != "0") && (ExpandeCollapse == true)) {
                        AdministrarReporte.Navigator.Tree(DataBE.IdObjeto.toString(), NewCollection);
                    }
                }
                else if (DataBE.IdTipo.toString() == SIMA.Utilitario.Enumerados.TipoObjeto.Reporte) {//Tipo Reporte

                    if (DataBE.NroComp != 0) {
                        NodoBE = { id: DataBE.IdObjeto.toString(), pId: IdObjetoPadre,  isParent: true, icon: Page.Request.ApplicationPath + "/Recursos/img/Shared.png", name: StrNombre, Data: DataBE, children: null,Load:false};
                    }
                    else {
                        NodoBE = { id: DataBE.IdObjeto.toString(), pId: IdObjetoPadre, isParent: true, icon: SIMA.Utilitario.Constantes.ImgDataURL.IconCrystalRpt, name: StrNombre, Data: DataBE, children: null, Load: false };
                    }

                     NewCollection[NewCollection.length] = new Array();
                     NewCollection[NewCollection.length - 1] = NodoBE;
                }

                objNodoPadre.children = NewCollection;
            });
        }


        AdministrarReporte.Navigator.Node.onDrop = function (treeId, treeNodes, NodeMove, moveType) {
            var NodoPadre = NodeMove[0].getParentNode();
            var NodoPadreBE = NodoPadre.Data;
                Manager.Task.Excecute(function () {
                        NodoPadre.children.forEach(function (NodeChild, i) {
                        var NodoBE = NodeChild.Data;
                        NodoBE.IdPadre = NodoPadreBE.IdObjeto;
                        NodoBE.IdEstado = 1;
                        NodoBE.UserName = UsuarioBE.UserName;
                        NodoBE.IdUsuario = UsuarioBE.IdUsuario;
                        NodoBE.OrdenXNivel = i;
                            AdministrarReporte.Navigator.Node.AdoptarHijo(NodoBE);
                        //AdministrarReporte.Commit(NodoBE);
                    });
                }, 500);

          }

        AdministrarReporte.Navigator.Node.AdoptarHijo = function (oXNode) {
            // PathUrlServicio = "http://localhost:1000/Core/GestionReportes/AdministrarReportes.asmx";
            PathUrlServicio = ConnectService.PathNetCore + "/GestionReportes/AdministrarReportes.asmx";
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = PathUrlServicio;
            oEasyDataInterConect.Metodo = "ReporteAdoptarHijo";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdObjeto", oXNode.IdObjeto, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdPadreNuevo", oXNode.IdPadre, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Orden", oXNode.OrdenXNivel, TipodeDato.Int);
            oParamCollections.Add(oParam);


            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;
            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var Result = oEasyDataResult.sendData();
        }


        function getFont(treeId, node) {
            return node.font ? node.font : {};
        }

        var treeObjet = null;
        var IDMark_A = "_a";
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
                beforeClick: beforeClick,
                onClick: AdministrarReporte.Navigator.Node.onClick,
                onDblClick: AdministrarReporte.Navigator.Node.DblClick,
                onNodeCreated: zTreeOnNodeCreated,
                onExpand: AdministrarReporte.Navigator.Node.Expand,
                onCollapse: AdministrarReporte.Navigator.Node.Collapse,
                beforeDrag: AdministrarReporte.Navigator.Node.beforeDrag,
                beforeDrop: AdministrarReporte.Navigator.Node.beforeDrop,
                onDrop: AdministrarReporte.Navigator.Node.onDrop
            }
        };

        
      

        window.setTimeout(InicioCarga(),3000);


      

        $(document).ready(function () {
            jNet.get('Explore').attr("height", screen.height);
            jNet.get('Content').attr("height", screen.height);

             treeObjet = $.fn.zTree.init($("#treeNav"), setting, arrData);
        });
		//-->

    </SCRIPT>

   

</html>
