<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportExplore.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.ReportExplore" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>


    <link href="../Recursos/css/Cards/CardLstReport.css" rel="stylesheet" />

    
    <style>
        .ReportBody{
            width:70%; 
            border: 1px  dotted #696666; 
            background-repeat: no-repeat;
            background-position: 50% 50%;  
            background-image:  url('../Recursos/css/skin-vista/DOCS.png'); 
        }
    </style>

    

    <script type="text/javascript">
        var DataRpt = new Array();
        var SOURCE = [
            { title: "Administrador de Reportes", key: "0", folder: true, lazy: true, icon: "../Recursos/img/Root.jpg" }
        ];
    </script>

    <script>
        var tree = null;
        function EliminarNodo() {
            selNodes = tree.getActiveNode();
            selNodes.remove();
        }

        function AñadirNodo() {
            // var tree = $("#tree").fancytree("getTree"),
            var node = tree.getActiveNode();
            //  alert(node.key);
            var childNode = node.addChildren({
                title: "Programatically addded nodes",
                tooltip: "This folder and all child nodes were added programmatically.",
                folder: true
            });
        }




    </script>

   


    <script>
        function CardToolBarOnClick(Source, IdFile) {
            switch (Source) {
                case "btnShared":
                    ReportExplore.ModoCompartir = ReportExplore.Compartir.Modo.Archivo;
                    ReportExplore.NombreArchivo = IdFile;

                    var otbShared = jNet.get("tblCompartir");

                    jNet.get(otbShared.rows[2]).css("display", "none");
                    jNet.get(otbShared.rows[3]).css("display", "none");
                    jNet.get(otbShared.rows[4]).css("display", "none");

                    EasyPopupCompartir_acFindUsuario.Clear();
                    EasyPopupCompartir.Titulo = "<table border=0><tr><td><img src='imgFulera' onerror='this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgCompartir2;' /></td><td>Compartir Archivo</td></tr></table>";
                    EasyPopupCompartir.Show();
                    break;
                case "btnDelete":
                    var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
                    var oParam = new SIMA.Data.OleDB.Param("UserName", ReportExplore.getUserName());
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Data.OleDB.Param("NombreFile", IdFile);
                    oParamCollections.Add(oParam);

                    var OleDBCommand = new SIMA.Data.OleDB.Command();
                    OleDBCommand.CadenadeConexion = Page.Request.ApplicationPath + "/GestionReportes/Procesar.asmx/EliminarFilePdfPorUser";

                    var obj = OleDBCommand.ExecuteNonQuery(oParamCollections);

                    return ((obj == 1) ? true : false);

                    break;

            }
        }

        function CardOnClick(oItemCard) {
            var oRptPrevio = jNet.get('RptPrevio');
            oRptPrevio.src = oItemCard.attr("PathHTTP");
        }

        function ListViewReporte_OnItemClick(Source, Target, oItemData) {
            var oimg = ((Source.tagName == "IMG") ? Source : Source.children[1].children[0]);// esto se cambiara segun el itemTemplate de cada implementacion

            //Mostrar Detalle de Usuario Compartido
            var oObjetoReporteCompartidoBE = DetalleUsuarioACompartir(oItemData.UserComp);
            jNet.get("EasyPopupCompartir_txtDescripcion").value = oObjetoReporteCompartidoBE.Descripcion;
            jNet.get("EasyPopupCompartir_ChkDueño").checked = oObjetoReporteCompartidoBE.Owner;

            EasyPopupCompartir_acFindUsuario.SetValue(oItemData.UserComp, oItemData.ApellidosyNombres);


            var ConfigMsgb = {
                Titulo: 'COMPARTIR'
                , Descripcion: ReportExplore.EventTemplate.ListImgItemView(oimg, oItemData.ApellidosyNombres, "Desea dejar de compartir el Reporte con este usuario ahora?")
                , Icono: 'fa fa-question-circle'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        try {
                            //Eliminar suarios compartido
                            GuardarUsuarioCompartidoReporte(0);
                        }
                        catch (SIMADataException) {
                            var msgConfig = { Titulo: "Error al Eliminar Usuario compartido", Descripcion: SIMADataException.Message };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();
                        }


                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }



        function ListViewArchivo_OnItemClick(Source, Target, oItemData) {
            var oimg = ((Source.tagName == "IMG") ? Source : Source.children[1].children[0]);// esto se cambiara segun el itemTemplate de cada implementacion
            var ConfigMsgb = {
                Titulo: 'COMPARTIR'
                , Descripcion: ReportExplore.EventTemplate.ListImgItemView(oimg, oItemData.ApellidosyNombres, "Desea dejar de compartir el archivo con este usuario ahora?")
                , Icono: 'fa fa-question-circle'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        try {
                            var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
                            var oParam = new SIMA.Data.OleDB.Param("NombreArchivo", oItemData.NombreArchivo);
                            oParamCollections.Add(oParam);

                            oParam = new SIMA.Data.OleDB.Param("IdObjeto", oItemData.IdObjeto);
                            oParamCollections.Add(oParam);

                            oParam = new SIMA.Data.OleDB.Param("IdUsuarioComp", oItemData.UserComp);
                            oParamCollections.Add(oParam);

                            oParam = new SIMA.Data.OleDB.Param("NombreUsuarioComp", oItemData.UserNameComp);
                            oParamCollections.Add(oParam);

                            oParam = new SIMA.Data.OleDB.Param("IdUsuarioRegistro", ReportExplore.Params["IdUsuario"]);
                            oParamCollections.Add(oParam);

                            oParam = new SIMA.Data.OleDB.Param("UserName", AdministrarInspecion.Params["UserName"]);
                            oParamCollections.Add(oParam);

                            oParam = new SIMA.Data.OleDB.Param("IdEstado", 0);
                            oParamCollections.Add(oParam);

                            var OleDBCommand = new SIMA.Data.OleDB.Command();
                            OleDBCommand.CadenadeConexion = Page.Request.ApplicationPath + "/GestionReportes/Procesar.asmx/CompartirArchivo";

                            var obj = OleDBCommand.ExecuteNonQuery(oParamCollections);

                            if (obj == 1) {
                                EasyPopupCompartir.Close();
                                ReportExplore.ListarArchivoReports(ReportExplore.IdObjeto, ReportExplore.NombreReporte);
                            }
                        }
                        catch (SIMADataException) {
                            var msgConfig = { Titulo: "Error al Eliminar Inspector", Descripcion: SIMADataException.Message };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();
                        }


                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }

        //Evento para el popup 
        function onItemSeleccionado(value, ItemBE) {

            switch (ReportExplore.ModoCompartir) {
                case ReportExplore.Compartir.Modo.Reporte:
                    /*obtener los archivos generados en cada home*/
                    DetalleUsuarioACompartir(ItemBE.idUsuario);

                    break;
                case ReportExplore.Compartir.Modo.Archivo:
                    //Buscar datos del usuario compartido por archivo
                    UserNameComp = ItemBE.login;
                    // alert(value + ' Archivo');
                    break;

            }
        }


        function OnEasyToolbarButton_Click(btnItem) {
            try {
                switch (btnItem.Id) {
                    case "btnCompartir":
                        ReportExplore.ModoCompartir = ReportExplore.Compartir.Modo.Reporte;


                        //Cargar la Lista de Usuarios que comparten este reporte
                        var oListView = new SIMA.ListImgView();
                        oListView.Id = "lvwUserCompartido";
                        oListView.NroItemsView = 15;
                        oListView.onItemClick = ListViewReporte_OnItemClick;
                        oListView.fncTemplateMenuItem = ReportExplore.EventTemplate.onDisplayItemMenu;

                        /*Obtener los Usuarios compartidos */
                        var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
                        var oParam = new SIMA.Data.OleDB.Param("IdObjeto", ReportExplore.IdObjeto);
                        oParamCollections.Add(oParam);

                        oParam = new SIMA.Data.OleDB.Param("UserName", ReportExplore.getUserName());
                        oParamCollections.Add(oParam);


                        var OleDBCommand = new SIMA.Data.OleDB.Command();
                        OleDBCommand.CadenadeConexion = Page.Request.ApplicationPath + "/GestionReportes/Procesar.asmx/ListarUsuarioReporteCompartido";
                        var oDataTable = new SIMA.Data.DataTable('tbl');
                        oDataTable = OleDBCommand.ExecuteDataSet(oParamCollections);
                        oDataTable.Rows.forEach(function (oDataRow, i) {
                            var DataBE = {
                                UserComp: oDataRow["IdUsuario"]
                                , NroPersonal: oDataRow["NroPersonal"]
                                , NroDocDNI: oDataRow["NroDocDNI"]
                                , ApellidosyNombres: oDataRow["ApellidosyNombres"]
                            };
                            var oImgItem = new SIMA.ListItem(i, DataBE.ApellidosyNombres, DataBE.UserComp, 'http://10.10.90.13/fotopersonal/' + DataBE.NroDocDNI + '.jpg', DataBE);
                            oListView.ListItems.Add(oImgItem);

                        });
                        var HtmlWriter = jNet.get("tdLstUserReportCompartido");
                        oListView.Render(HtmlWriter);

                        //Llama a la ventana de comparir para buscar al usuario
                        jNet.get("EasyPopupCompartir_txtDescripcion").value = "";
                        jNet.get("EasyPopupCompartir_ChkDueño").checked = "";
                        var otbShared = jNet.get("tblCompartir");
                        jNet.get(otbShared.rows[2]).css("display", "block");
                        jNet.get(otbShared.rows[3]).css("display", "block");
                        jNet.get(otbShared.rows[4]).css("display", "block");

                        EasyPopupCompartir_acFindUsuario.Clear();
                        EasyPopupCompartir.Titulo = "<table border=0><tr><td><img src='imgFulera' onerror='this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgCompartir2;' /></td><td>Compartir Reporte</td></tr></table>";
                        EasyPopupCompartir.Show();

                        break;

                }
            }
            catch (error) {
                if (error instanceof SIMA.WebServiceDataException) {
                    var msgConfig = { Titulo: error.Name, Descripcion: error.Point + '<br>' + error.Message };
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                }
                else if (error instanceof SIMA.WebServiceException) {
                    var msgConfig = { Titulo: error.Name, Descripcion: error.Point + '<br>' + error.Message };
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                }
                else {
                    var msgConfig = { Titulo: "Al Llenar datos", error };
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();

                }
            }
        }

    </script>


  
    <style>
        /*para label implementacion del popup menu*/
        .dropbtn {
          /* background-color: #3498DB;
          color: white;
         padding: 16px;
          font-size: 16px;
          border: none;*/
          cursor: pointer;
        }

        .dropbtn:hover, .dropbtn:focus {
          /*background-color: #2980B9;*/
          color: blue;
           font-size: 16px;
           font-weight: bold; 
        }

        .dropdown1 {
          position: absolute;
          display: inline-block;
        }

        .dropdown-content {
          display: none;
          position: absolute;
          background-color: #f1f1f1;
          min-width: 160px;
          overflow: auto;
          box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
          z-index:100;
        }

        .dropdown-content a {
          color: black;
          padding: 12px 16px;
          width:320px;
          text-decoration: none;
          display: block;
        }

        .dropdown a:hover {background-color: #ddd;}

        .show {display: block;}
        .auto-style1 {
            width: 104px;
        }
    </style>




</head>
<body>
    <form id="form1" runat="server">
        
           <table id="tblReport" style="width:100%;height:100%"  border="0px" >
                <tr>
                    <td>
                        <uc1:Header runat="server" ID="Header" />
                   </td>
                </tr>
                <tr>
                    <td style="width:100%; height:100%;" valign="top"  align="left"  >
                                <table cellpadding="0" cellspacing="0"  style="width:100%; height:100%"   border="0px">
                                    <tr>
                                        <td  style="width:15%; height:100%; "  align="left"  valign="top" >
                                           
                                              <div class="cardRptTree">
                                                  
                                                  <div class="search-container">
                                                    <svg fill="none" viewBox="0 0 24 24" height="20" width="20" xmlns="http://www.w3.org/2000/svg">
                                                      <path stroke-linejoin="round" stroke-linecap="round" stroke-width="2" stroke="#171718" d="M17.5 17.5L22 22"></path>
                                                      <path stroke-linejoin="round" stroke-width="2" stroke="#171718" d="M20 11C20 6.02944 15.9706 2 11 2C6.02944 2 2 6.02944 2 11C2 15.9706 6.02944 20 11 20C15.9706 20 20 15.9706 20 11Z"></path>
                                                    </svg>
                                                    <input placeholder="Buscar reporte" type="search">
                                                 
                                                            <cc3:EasyToolBarButtons ID="EasyToolBarButtons1" runat="server">
                                                                <EasyButtons>
                                                                    <cc3:EasyButton ID="btnCompartir" Descripcion="" Icono="fa fa-share-alt-square fa-lg" RunAtServer="False"  Ubicacion="Derecha" />
                                                                </EasyButtons>
                                                          </cc3:EasyToolBarButtons>
                                                  </div>
                                                  <div id="LstRptTree" class="results">
                                                    <div id="LstGroupTree" class="results-list">
                                                        <div id="tree">

                                                        </div>
                                                    </div>
                                                  </div>
                                             
                                            </div>   
                                           
                                        </td>

                                        <td class="ReportBody" style="width:70%;height:100%;" align="left"  valign="top" >
                                              <iframe id="RptPrevio" src="" allowtransparency="true" style="background-color:transparent; solid #000000; bottom:0px; right:0px; width:100%; height:100%; border:none; margin:0; padding:0; overflow:hidden; z-index:999999;"  frameborder="0" > </iframe>
                                        </td>

                                        <td id="tdPanelLst" style="width:25%; height:100%; "  align="left"  valign="top">
                                            <!--<div class="cardRpt">
                                              <div id="LstFiles" class="results">
                                              </div>
                                            </div>                                           -->

                                        </td>

                                    </tr>
                                </table>
                    </td>
                </tr>
             
             </table>
                  <div class="content_wrap">
	                    <div class="zTreeDemoBackground left">
		                    <ul id="treeDemo" class="ztree"></ul>
	                    </div>
	
                        </div>
             
         
        
            <cc3:EasyPopupBase ID="EasyPopupReportParam"  runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Parámetros de reporte" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupReportParam_Aceptar">
            </cc3:EasyPopupBase>

    

            <cc3:EasyPopupBase ID="EasyPopupCompartir"  runat="server"  Modal="fullscreen" ModoContenedor="Contenedor"  RunatServer="false" DisplayButtons="true" fncScriptAceptar="ReportExplore.EasyPopup.Compartir_OnAceptar">
              <table border="0"  Width="100%" id="tblCompartir">
                     <tr>
                         <td colspan="2" Width="100%" >
                              <asp:Label ID="Label2" runat="server" Text="Buscar por Apellidos y Nombres" Width="100%"></asp:Label>
                         </td>
                     </tr>
                    <tr>
                        <td colspan="2"  Width="900px">
                             <cc3:EasyAutocompletar ID="acFindUsuario" runat="server" NroCarIni="4"  DisplayText ="ApellidosyNombres"  Width="100%" ValueField="idUsuario" fnOnSelected="onItemSeleccionado" fncTempaleCustom="ReportExplore.EventTemplate.onDisplayItemUsuario" >
                                <EasyStyle Ancho="Dos"></EasyStyle>
                                    <DataInterconect>
                                        <UrlWebService>/GestionReportes/Procesar.asmx</UrlWebService>
                                        <Metodo>BuscarUsuarios</Metodo>
                                    <UrlWebServicieParams>
                                        <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                            </cc3:EasyAutocompletar>
                        </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="DESCRIPCION" Width="20%"></asp:Label>
                    </td>
                    <td Width="900px">
                        <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Height="100px" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:CheckBox ID="ChkDueño" Text="Dueño" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" Width="900px" >
                        <table>
                            <td  Width="60%">
                                 <asp:Label ID="Label3" runat="server" Text="LISTA DE USUARIOS COMPARTIDOS" Width="100%"></asp:Label>
                            </td>
                            <td id="tdLstUserReportCompartido" Width="40%" style="padding-left:20PX;padding-top:20PX" >
                            </td>
                        </table>
                    </td>
                </tr>

            </table>
            </cc3:EasyPopupBase>



        

  <script>
      var NodoSelected = null;

      // Initialize Fancytree
      $("#tree").fancytree({
          checkbox: false,
          autoScroll: true,
          selectMode: 3,
          source: SOURCE,
          lazyLoad: function (event, ctx) {
              //Cargar  ctx.result = {url: "ajax-sub2.json", debugDelay: 1000};
              //Obtener el data table
              var Key = ctx.node.key;

              ctx.result = ReportExplore.ObtenerReportePorPerfil(Key);
              ctx.tree.rootNode.fixSelection3FromEndNodes();
          },
          loadChildren: function (event, ctx) {

              //ctx.tree.debug("loadChildren");
              ctx.node.fixSelection3FromEndNodes();
              // alert('Cargado');
          },
          activate: function (event, data) {
              this.currentMenuItemNode = data.node;
              //alert('Nodo Activo');
          },
          click: function (e, data) {
              /*Datos generales*/
              ReportExplore.Global.ItemOwner = data.node.Owner;

              ReportExplore.IdObjeto = data.node.key;
              ReportExplore.NombreReporte = data.node.title;
              //data.node.toggleExpanded();
             /* tree = $.ui.fancytree.getTree(this);
              var node = tree.getActiveNode();*/


              if (data.node.folder == false) {
                  //Lista Los archivos generados por el 
                  if (NodoSelected != data.node.key) {
                      NodoSelected = data.node.key;
                      ReportExplore.ListarArchivoReports(ReportExplore.IdObjeto, ReportExplore.NombreReporte);
                  }
              }
              //$("#tree").fancytree("getTree").getNodeByKey(data.node.key).setActive();

              //  alert(node.key);
              //tree.applyCommand("addChild", node);

              /*
              var childNode = node.addChildren({
                  title: "Programatically addded nodes",
                  tooltip: "This folder and all child nodes were added programmatically.",
                  folder: true
              });
              childNode.addChildren({
                  title: "Document using a custom icon",
                  icon: "customdoc1.gif"
              });*/

          },
          keydown: function (event, data) {
              var KC = $.ui.keyCode,
                  oe = event.originalEvent;
              // Swap LEFT/RIGHT keys
              switch (event.which) {
                  case KC.LEFT:
                      oe.keyCode = KC.RIGHT;
                      oe.which = KC.RIGHT;
                      break;
                  case KC.RIGHT:
                      oe.keyCode = KC.LEFT;
                      oe.which = KC.LEFT;
                      break;
              }
          },
          collapse: function (event, data) {
              alert('Colapso');
          },
          expand: function (event, data) {
              // alert('Expande');
          },
          createNode: function (event, data) {
              //  alert('Al crear');
          },
          dblclick: function (event, data) {

              if (data.node.folder == false) {
                  var node = data.node;
                  node.setSelected(true);
                  //Lista Los archivos generados por el 
                  //ReportExplore.ListarArchivoReports(data.node.key, data.node.title);
                  //Carga El popup de parametros para el reporte seleccionado
                  ReportExplore.ShowPopupParametros(data.node.key, data.node.title);
              }

          },
          select: function (event, data) {
              var node = data.node;

              /*  if (node.isSelected()) {
                    if (node.isUndefined()) {
                        // Load and select all child nodes
                        node.load().done(function () {
                            node.visit(function (childNode) {
                                childNode.setSelected(true);
                            });
                        });
                    } else {
                        // Select all child nodes
                        node.visit(function (childNode) {
                            childNode.setSelected(true);
                        });
                    }
                }*/
          },
          renderNode: function (event, data) {
              //alert('al pintar el nodo');
          }
      });

      /*demo de usos*/
      //$("#tree").fancytree("getTree").getNodeByKey("0").setActive();//Activar un nodo

      var iframe = jNet.get('RptPrevio');
      iframe.addEvent("load", function () {
          try {
              SIMA.Utilitario.Helper.Wait.Close(0);
          }
          catch (ex) {
              alert(ex);
          }
      });

  </script>


    <script>

        var ReportExplore = {};
        ReportExplore.Global = {};
        ReportExplore.Global.ItemOwner = null;

        ReportExplore.IdObjeto = null;
        ReportExplore.NombreArchivo = null;
        ReportExplore.NombreReporte = null;

        ReportExplore.ModoCompartir = null;

        ReportExplore.getIdUsuario = function () {
            return ReportExplore.Params["IdUsuario"];
        }
        ReportExplore.getUserName = function () {
            return ReportExplore.Params["UserName"];
        }


        /*  oParamCollections.Add(oParam);
          oParam = new SIMA.Data.OleDB.Param("UserName", AdministrarInspecion.Params["UserName"]);
          */

        ReportExplore.Compartir = new Object();
        ReportExplore.Compartir.Modo = {
            Reporte: "I",
            Archivo: "D"
        }
        /*----------------------Definicion de Tempates-------------------------------------*/
        ReportExplore.EventTemplate = {};

        ReportExplore.EventTemplate.ListImgItemView = function (oImg, ApellidosYNombres, msg) {
            var MsgTemplate = '<table width="100%"><tr><td align="center"><img width="220px" class="' + oImg.className + '" src="' + oImg.src + '"/></td></tr> <tr><td align="center">' + ApellidosYNombres + '<br>' + msg + ' </td></tr></table >';
            return MsgTemplate;
        }


        ReportExplore.EventTemplate.onDisplayItemMenu = function (oData) {
            var iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '<div class= "flex-column">' + oData.ApellidosyNombres
                + '   <p>'
                + '        <small style = "font-weight: bold" > Nro PR:</small> <small style="color:red">' + oData.NroDocDNI + '</small>'
                + '        <small style="font-weight: bold">AREA:</small><small style="color:blue;text-transform: capitalize;">' + oData.Area + '</small>'
                + '   </p> '
                + '       <span class="badge badge-info "> ' + oData.Login + '</span>'
                + '</div>'
                + '<div class="image-parent">'
                + '   <img class="rounded-circle" width="60px" src="http://10.10.90.13/fotopersonal/' + oData.NroDocDNI + '.jpg" onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                + '</div>'
                + '</a>';
            return iTemplate;
        }
        ReportExplore.EventTemplate.onDisplayItemUsuario = function (ul, item) {
            var cmll = "\"";
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '<div class= "flex-column">' + item.ApellidosyNombres
                + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red">' + item.NroPersonal + '</small>'
                + '    <small style="font-weight: bold">AREA:</small><small style="color:blue;text-transform: capitalize;">' + item.NombreArea + '</small></p>'
                + '    <span class="badge badge-info "> ' + item.login + '</span>'
                + '</div>'
                + '<div class="image-parent">'
                + '<img class=" rounded-circle" width="60px" src="http://10.10.90.13/fotopersonal/' + item.NroDocDNI + '.jpg"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                + '</div>'
                + '</a>';

            var oCustomTemplateBE = new EasyPopupCompartir_acFindUsuario.CustomTemplateBE(ul, item, iTemplate);

            return EasyPopupCompartir_acFindUsuario.SetCustomTemplate(oCustomTemplateBE);
        }
        /*----------------------End Tempates-------------------------------------*/


        ReportExplore.ListarArchivoReports = function (keyRpt, NombreRpt) {

            var otdPanelLst = jNet.get("tdPanelLst");
            otdPanelLst.clear();
            var oPanelView = new SIMA.PanelView('RigthPanelv');
            oPanelView.Render(otdPanelLst);

            /*obtener los archivos generados en cada home*/
            var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
            var oParam = new SIMA.Data.OleDB.Param("IdObjeto", keyRpt);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Data.OleDB.Param("UserName", ReportExplore.getUserName());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Data.OleDB.Param("NomReport", NombreRpt);
            oParamCollections.Add(oParam);

            var NomGrp = "";

            var OleDBCommand = new SIMA.Data.OleDB.Command();
            OleDBCommand.CadenadeConexion = Page.Request.ApplicationPath + "/GestionReportes/Procesar.asmx/ListarFilePdfPorUser";
            var oDataTable = new SIMA.Data.DataTable('tbl');
            oDataTable = OleDBCommand.ExecuteDataSet(oParamCollections);

            var CtrlGrp = null;
            oDataTable.Rows.forEach(function (oDataRow) {

                if (NomGrp != oDataRow["Grupo"]) {
                    NomGrp = oDataRow["Grupo"];
                    CtrlGrp = oPanelView.CrearGrupo(NomGrp, "Generado en:" + NomGrp);
                }
                /*Crea la Tarjeta para el archivo de reporte generado */
                var obe = new CardFileBE(oDataRow["Nombre"], oDataRow["IdGenerado"], oDataRow["PathFile"]);
                /*Asignacion de eventos a la tarjeta*/
                obe.IconSGV = SIMA.Utilitario.Constantes.ImgSGV.FilePdf;
                obe.ToolBarOnBtnClick = CardToolBarOnClick;
                obe.OnClick = CardOnClick;
                obe.Render(CtrlGrp);

                /*Eateblece el valor de fecha en la parte inferior izquierda */
                obe.SeccionLeftDown().innerText = oDataRow["FechaHora"];

                var oListView = new SIMA.ListImgView();
                oListView.Id = oDataRow["IdGenerado"];
                oListView.NroItemsView = 3;
                oListView.onItemClick = ListViewArchivo_OnItemClick;
                oListView.fncTemplateMenuItem = ReportExplore.EventTemplate.onDisplayItemMenu;

                /*Obtener los usuarios de los archivos compartidos*/
                /*----------------------------------------------------------------------------------------------------*/
                oParamCollections = new SIMA.Data.OleDB.ParamCollections();
                oParam = new SIMA.Data.OleDB.Param("NombreArchivo", oDataRow["IdGenerado"]);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Data.OleDB.Param("UserName", ReportExplore.getUserName());
                oParamCollections.Add(oParam);

                OleDBCommand = new SIMA.Data.OleDB.Command();
                OleDBCommand.CadenadeConexion = Page.Request.ApplicationPath + "/GestionReportes/Procesar.asmx/ListarUsuariorFileCompartidos";

                var oDataTableUsr = new SIMA.Data.DataTable('tbl');
                oDataTableUsr = OleDBCommand.ExecuteDataSet(oParamCollections);
                oDataTableUsr.Rows.forEach(function (oDataRowComp, i) {
                    var DataBE = {
                        IdUsuario: oDataRowComp["UserComp"]
                        , UserComp: oDataRowComp["UserComp"]
                        , NroPersonal: oDataRowComp["NroPersonal"]
                        , NroDocDNI: oDataRowComp["NroDocDNI"]
                        , ApellidosyNombres: oDataRowComp["ApellidosyNombres"]
                        , Area: oDataRowComp["NombreArea"]
                        , IdObjeto: keyRpt
                        , NombreArchivo: oListView.Id
                        , UserNameComp: oDataRowComp["UserNameComp"]
                    };
                    var oImgItem = new SIMA.ListItem(i, oDataRowComp["ApellidosyNombres"], oDataRowComp["IdUsuario"], 'http://10.10.90.13/fotopersonal/' + oDataRowComp["NroDocDNI"] + '.jpg', DataBE);
                    oListView.ListItems.Add(oImgItem);

                });

                /*----------------------------------------------------------------------------------------------------*/
                oListView.Render(obe.SeccionRightDown());//Se pinta el listview y su contenido en una seccion del card
            });
        }

        ReportExplore.ShowPopupParametros = function (keyRpt, NombreRpt) {
            var oParamColletions = new EasyPopupReportParam.ParamCollection();
            var oParam = new EasyPopupReportParam.Param('IdObjeto', keyRpt);
            oParamColletions.Add(oParam);
            oParam = new EasyPopupReportParam.Param('NomObjeto', NombreRpt);
            oParamColletions.Add(oParam);

            EasyPopupReportParam.Load(Page.Request.ApplicationPath + "/GestionReportes/ReportParams.aspx?", oParamColletions, false);
        }

        ReportExplore.ObtenerReportePorPerfil = function (idPadre) {
            var cmll = "\"";
            var Data = new Array();
            var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
            var oParam = new SIMA.Data.OleDB.Param("IdUsuario", ReportExplore.getIdUsuario());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Data.OleDB.Param("IdPadre", idPadre);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Data.OleDB.Param("UserName", ReportExplore.getUserName());
            oParamCollections.Add(oParam);


            var OleDBCommand = new SIMA.Data.OleDB.Command();
            OleDBCommand.CadenadeConexion = Page.Request.ApplicationPath + "/GestionReportes/Procesar.asmx/ListarReportePorUsuario";
            var oDataTable = new SIMA.Data.DataTable('tbl');
            oDataTable = OleDBCommand.ExecuteDataSet(oParamCollections);
            oDataTable.Rows.forEach(function (oDataRow) {
                var IsFolder = ((oDataRow["NroHijos"] > 0) ? true : false);
                var ExPande = false;
                var NodeItem = {
                    title: oDataRow["Nombre"]
                    , folder: IsFolder
                    , expanded: ExPande
                    , key: oDataRow["IdObjeto"]
                    , parent: idPadre
                    , lazy: IsFolder
                    , tooltip: oDataRow["Descripcion"]
                    , selected: true
                    , Owner: oDataRow["owner"]
                };
                Data[Data.length] = new Array();
                Data[Data.length - 1] = NodeItem;
            });

            return Data;
        }


        var UserNameComp = null;

        ReportExplore.EasyPopup = {};
        ReportExplore.EasyPopup.Compartir_OnAceptar = function () {
            switch (ReportExplore.ModoCompartir) {
                case ReportExplore.Compartir.Modo.Reporte:
                    GuardarUsuarioCompartidoReporte(1);
                    break;
                case ReportExplore.Compartir.Modo.Archivo:
                    var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
                    var oParam = new SIMA.Data.OleDB.Param("NombreArchivo", ReportExplore.NombreArchivo);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Data.OleDB.Param("IdObjeto", ReportExplore.IdObjeto);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Data.OleDB.Param("IdUsuarioComp", EasyPopupCompartir_acFindUsuario.GetValue());
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Data.OleDB.Param("NombreUsuarioComp", UserNameComp);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Data.OleDB.Param("IdUsuarioRegistro", ReportExplore.getIdUsuario());
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Data.OleDB.Param("UserName", ReportExplore.getUserName());
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Data.OleDB.Param("IdEstado", 1);
                    oParamCollections.Add(oParam);

                    var OleDBCommand = new SIMA.Data.OleDB.Command();
                    OleDBCommand.CadenadeConexion = Page.Request.ApplicationPath + "/GestionReportes/Procesar.asmx/CompartirArchivo";

                    var obj = OleDBCommand.ExecuteNonQuery(oParamCollections);

                    if (obj == 1) {
                        EasyPopupCompartir.Close();
                        ReportExplore.ListarArchivoReports(ReportExplore.IdObjeto, ReportExplore.NombreReporte);
                    }

                    break;

            }

        }

        function GuardarUsuarioCompartidoReporte(IdEstado) {
            var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
            var oParam = new SIMA.Data.OleDB.Param("IdObjeto", ReportExplore.IdObjeto);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Data.OleDB.Param("IdUsuarioComp", EasyPopupCompartir_acFindUsuario.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Data.OleDB.Param("Descripcion", jNet.get("EasyPopupCompartir_txtDescripcion").value);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Data.OleDB.Param("Owner", ((jNet.get("EasyPopupCompartir_ChkDueño").checked == true) ? 1 : 0));
            oParamCollections.Add(oParam);

            oParam = new SIMA.Data.OleDB.Param("IdUsuario", ReportExplore.getIdUsuario());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Data.OleDB.Param("UserName", ReportExplore.getUserName());
            oParamCollections.Add(oParam);


            oParam = new SIMA.Data.OleDB.Param("IdEstado", IdEstado);
            oParamCollections.Add(oParam);

            var OleDBCommand = new SIMA.Data.OleDB.Command();
            OleDBCommand.CadenadeConexion = Page.Request.ApplicationPath + "/GestionReportes/Procesar.asmx/CompartirObjeto";

            var obj = OleDBCommand.ExecuteNonQuery(oParamCollections);

            if (obj == 1) {
                EasyPopupCompartir.Close();
            }

        }

        function DetalleUsuarioACompartir(IdUsuarioComparir) {
            var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
            var oParam = new SIMA.Data.OleDB.Param("IdObjeto", ReportExplore.IdObjeto);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Data.OleDB.Param("IdUsuarioComp", IdUsuarioComparir);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Data.OleDB.Param("UserName", ReportExplore.getUserName());
            oParamCollections.Add(oParam);

            var OleDBCommand = new SIMA.Data.OleDB.Command();
            OleDBCommand.CadenadeConexion = Page.Request.ApplicationPath + "/GestionReportes/Procesar.asmx/DetalleUsuarioReporteCompartido";
            /*var oObjetoReporteCompartidoBE = OleDBCommand.ExecuteNonQuery(oParamCollections);
            jNet.get("EasyPopupCompartir_txtDescripcion").value = oObjetoReporteCompartidoBE.Descripcion;
            jNet.get("EasyPopupCompartir_ChkDueño").checked = oObjetoReporteCompartidoBE.Owner;
            */
            return OleDBCommand.ExecuteNonQuery(oParamCollections);
        }
    </script>


         
    </form>
  
      
</body>

    <link rel="stylesheet" href="https://www.jqueryscript.net/demo/Powerful-Multi-Functional-jQuery-Folder-Tree-Plugin-zTree/css/demo.cssZ" type="text/css">
	<link rel="stylesheet" href="https://www.jqueryscript.net/demo/Powerful-Multi-Functional-jQuery-Folder-Tree-Plugin-zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	
	
	<script type="text/javascript" src="https://www.jqueryscript.net/demo/Powerful-Multi-Functional-jQuery-Folder-Tree-Plugin-zTree/js/jquery.ztree.core-3.5.js"></script>
	<SCRIPT type="text/javascript">
		
    var setting = {};

    var zNodes = [
        {
            name: "pNode 01", open: true,
            children: [
                {
                    name: "pNode 11",
                    children: [
                        { name: "leaf node 111" },
                        { name: "leaf node 112" },
                        { name: "leaf node 113" },
                        { name: "leaf node 114" }
                    ]
                },
                {
                    name: "pNode 12",
                    children: [
                        { name: "leaf node 121" },
                        { name: "leaf node 122" },
                        { name: "leaf node 123" },
                        { name: "leaf node 124" }
                    ]
                },
                { name: "pNode 13 - no child", isParent: true }
            ]
        },
        {
            name: "pNode 02",
            children: [
                {
                    name: "pNode 21", open: true,
                    children: [
                        { name: "leaf node 211" },
                        { name: "leaf node 212" },
                        { name: "leaf node 213" },
                        { name: "leaf node 214" }
                    ]
                },
                {
                    name: "pNode 22",
                    children: [
                        { name: "leaf node 221" },
                        { name: "leaf node 222" },
                        { name: "leaf node 223" },
                        { name: "leaf node 224" }
                    ]
                },
                {
                    name: "pNode 23",
                    children: [
                        { name: "leaf node 231" },
                        { name: "leaf node 232" },
                        { name: "leaf node 233" },
                        { name: "leaf node 234" }
                    ]
                }
            ]
        },
        { name: "pNode 3 - no child", isParent: true }

    ];

    $(document).ready(function () {
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    });
		
    </SCRIPT>

</html>
