<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarObjetivosAcciones.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.AdministrarObjetivosAcciones" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
    <style>
           .ItemArea {
                 border: 1px dotted #5394C8;
                background: #fefefe;
                color: #15428b;
                cursor: pointer;
                font: 11px tahoma,arial,sans-serif;
                height: 30px;
                display:inline-block;
                margin-right:2px;
                }
               

            .ItemArea tr {
                height:30px;
            }

            .ItemArea td {
                margin-left: 2px;
                margin-right: 2px;
            }

            .ItemArea tr:hover {
                background-color: #E1EFFA;
            }

             .ItemAreaNoInfo {
                border: 1px dotted #5394C8;
               background: #fefefe;
               color: red;
               cursor: pointer;
               font: 11px tahoma,arial,sans-serif;
               height: 30px;
               display:inline-block;
               margin-right:2px;
               }
              .ItemAreaNoInfo tr {
                     height:30px;
                 }

                 .ItemAreaNoInfo td {
                     margin-left: 2px;
                     margin-right: 2px;
                 }

                 .ItemAreaNoInfo tr:hover {
                     background-color: #E1EFFA;
                 }





             .ItemIndicador{
                  border: 1px dotted #5394C8;
                  cursor: pointer;
                  font: 11px tahoma,arial,sans-serif;
                  margin-right:2px;
                  width:100%;
              }

              .ItemIndicador tr {
                  height:30px;
              }

              .ItemIndicador td {
                  margin-left: 2px;
                  margin-right: 2px;
              }

    </style>

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
                     <td style="width:100%; height:100%">
                         <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="GESTION DE INDICADORES"  ToolBarButtonClick="OnEasyGridButton_Click" Width="100%" AllowPaging="True"   fncExecBeforeServer="AdministrarObjetivosAcciones.EliminarItem" OnRowDataBound="EasyGridView1_RowDataBound" OnEasyGridButton_Click="EasyGridView1_EasyGridButton_Click" >
                             <EasyGridButtons>
                                 <cc1:EasyGridButton ID="btnAgregar" SilenceWait="true"  Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="false" Texto="Agregar" Ubicacion="Derecha"  />
                                 <cc1:EasyGridButton ID="btnEliminar" Descripcion="" Icono="fa fa-close" MsgConfirm="Desea Eliminar este registro ahora?"  RequiereSelecciondeReg="true" SolicitaConfirmar="true" RunAtServer="True" Texto="Eliminar" Ubicacion="Derecha" />
                             </EasyGridButtons>

                                 <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                     <DataInterconect MetodoConexion="WebServiceExterno">
                                         <UrlWebService></UrlWebService>
                                         <Metodo>Requerimientos_lst</Metodo>
                                         <UrlWebServicieParams>
                                             <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdUsuario" Paramvalue="IdUsuario" TipodeDato="Int" />
                                             <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="UserName" TipodeDato="String"/>
                                         </UrlWebServicieParams>
                                     </DataInterconect>

                                 <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="GridetalleNull"  idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                                 <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                                 <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                                 <Columns>
                                     <asp:BoundField DataField="CODIGO" HeaderText="CODIGO" >
                                     <ItemStyle HorizontalAlign="Left" Width="5%" />
                                     </asp:BoundField>
                                     <asp:BoundField DataField="NOMBRE" HeaderText="OBJETIVO / ACCIONES" >
                                     <ItemStyle HorizontalAlign="Left" Width="40%" />
                                     </asp:BoundField>
                                     <asp:BoundField HeaderText="DESCRIPCION" >
                                     <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                     </asp:BoundField>
                                     <asp:BoundField HeaderText="RESPONSABLES">
                                     <ItemStyle Width="30%" />
                                     </asp:BoundField>
                                 </Columns>

                               <HeaderStyle CssClass="HeaderGrilla" />
                               <PagerStyle HorizontalAlign="Center" />
                               <RowStyle CssClass="ItemGrilla" Height="25px" />

                         </cc1:EasyGridView>
                     </td>
                 </tr>
            </table>

        <cc3:EasyPopupBase ID="EasyPopupDetalleObjetivo" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="OBJETIVO"  ValidarDatos="true" CtrlDisplayMensaje="msgValRqr"  RunatServer="false" DisplayButtons="true"  fncScriptAceptar="AdministrarObjetivosAcciones.Detalle.Aceptar"></cc3:EasyPopupBase>


      <script>
          AdministrarObjetivosAcciones.EliminarItem = function (btnItem, ItemRowBE) {

              var oParamCollections = new SIMA.ParamCollections();
              var oParam = new SIMA.Param("IdTabla", ItemRowBE.IDTBL, TipodeDato.Int);
              oParamCollections.Add(oParam);

              oParam = new SIMA.Param("IdItem", ItemRowBE.IDITEM, TipodeDato.Int);
              oParamCollections.Add(oParam);

              oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
              oParamCollections.Add(oParam);

              var oEasyDataInterConect = new EasyDataInterConect();
              oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
              oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
              oEasyDataInterConect.Metodo = 'Indicador_del';
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
              var ResultBE = oEasyDataResult.sendData();

              return true;
          }

          function GridetalleNull() {
          }

          var imgIndica = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAApCAMAAAB9Yuu9AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHvUExURQAAAODg4MPDw5mZmd3d3aKiooKCgoqKisDAwM3NzdbW1nR0dFBQUHt7e2xsbE5OTrGxsZubm29vb9jY2LCwsEtLS6Ghoe/v79ra2nZ2dklJSdTU1OHh4ZycnHh4eL29vaenp01NTcfHx/v7+/Hx8Y+Pjzc3N4mJiYuLi42Njerq6ldXV8jIyMbGxnp6eoSEhE9PT6+vr4SEg1ZWVqysrLe3t7q6upqamkpKSnd3d9DQ0GVlZYODg7i4uKOjo5eXl8/Pz8zMzMXFxYaGhry8vIyMjNfX1z09PZiYmKSkpGNjY5KSko6OjltbW9XV1dzc3FxcXL+/v4GBgZ2dnV5eXmFhYWBgYNHR0bu7u2pqapOTk4WFhWRkZKmpqVNTU7a2tsvLy7S0tMHBwb6+vtnZ2XV1dVlZWcrKylhYWFpaWl9fX9LS0jk5OXBwcFJSUlFRUaCgoGhoaExMTDo6OsnJyaurqzw8PIiIiGlpac7OzrKysp6enn5+fkhISD8/P3FxcW5ubtPT04eHhz4+Pq2trZCQkH19fTs7O0VFRcLCwqWlpbm5uUdHR7W1tfb29unp6UBAQERERP7+/vPz8zMzM1RUVFVVVWZmZtvb25SUlDY2Nmtra0FBQUNDQ6ioqICAgO3t7bOzs0JCQq6urgAAAIvbXT8AAACldFJOU///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////ACB7zgQAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALiSURBVEhLzZRrWxJBFIA3RNQkIRSLNTQsJMNripGaghEVhhcUUgmxSERJMsi7pGQWopRd7KZ2PT+0mZ1BVkEf+tb7Yc97DoflsDM7DGTGCRIYEGQJiR6DMFuUk4uFgTwuHkJ4kgqHMF98qkAiRXbEMKdlhdQwRfLiM2cVbAlpP0eKfJSlZdQw51XlFy6qK/KOvLtGdIkaJpetvJyn1SJjoCqb1PhU19TW1VPHXKloUMkbkaC/qiMlPk2VV/XXqGOaW7St17GkH6at3aBQGWmC6LhhIpK+PeumWXrrNk0QdyzlRNK3d94FsMqMXd00z++hwkAv/gsHMdvQnfvYfruD/IJZrOEibr83QDWJcbAY7ZIhtfO+3oXz8mE3Vz80zAjdDw+sD4lAC+tBV6nzEUkPto96x7g45KMbEMbGJwTdBs3+0qD2/T3g73ls42TSwQWMJ/BE4ZBM0Qy1u55SBY8kGHqGot9aSwoY6bhPOzpCE9Te0UkVOr3TM7Mojs1Nk0Iq/NktpSAangdYqEGX9PDa54OL0BxET3ipP7E8KfDaF/Voj7eGBx3PZbSSCgMmEdXlOvR0R2pWViaLaIWHgbyNDJS0cQKROgWRNAgGw+IXWJLDeFZfUkvB4NCuvXq9hizZ7oxSAeU6FYgtcGFjM/7mrU2FDpj9dvN4Yrk0W/YqYhvvvNw+r5d3vP9Q+ZE7CeIF3EeucIyLkLM6uF3Kmf9TdPszlq5tWVmMtSJjwKjEFfD1A3xpEvTaKmzw9RtXW5oxNa7ib0YmQqGQJYIsMUx7IA7zO7sqdk8NULjTg8b/vomWLGd3KTZl8fW5XHg3JdrXxT9+GuxepXvhF05LAnPOWbEday0rUWkXsWFo+7LeHQkGm0iCiA3Low0CmvCOXAY8aHWqw7+1Uf2Rzz0JelfRE/Gr1a2z9Cg5luQyZcR/1i6sN8Uz4Q8+qRmQsuGtTNgLoDcYDaMb0OncGYAX8Z9mB/gLhJoM+WWVTm0AAAAASUVORK5CYII=";

          function OnEasyGridButton_Click(btnItem, DetalleBE) {

              switch (btnItem.Id) {
                  case "btnAgregar":
                      var Config = {
                          Titulo:'Crear'
                          , IdTabla: 88
                          , IdSelected: 0
                          , TextField: "NOMBRE"
                          , ArrNotIn: [3]
                          , OrigenDB: "Oracle"
                          , width: "500px"
                          , fncOK: function (ItemBE) {
                              var frmEdit = ItemBE.DESCRIPCION2;
                              switch (ItemBE.IDITEM) {
                                  case "1":
                                      AdministrarObjetivosAcciones.Detalle.Objetivo(ItemBE.NOMBRE, frmEdit, SIMA.Utilitario.Enumerados.ModoPagina.N, 80, AdministrarObjetivosAcciones.Params[AdministrarObjetivosAcciones.KEYOBJETIVOVERSION]);
                                      break;
                                  case "2":
                                      if ((DetalleBE != undefined) && (DetalleBE.VAL4 == 1)) {//Registro selecciondo debe de ser un objetivo
                                          AdministrarObjetivosAcciones.Detalle.Acciones(ItemBE.NOMBRE, frmEdit, SIMA.Utilitario.Enumerados.ModoPagina.N, ItemBE.VAL1, 0, 81, DetalleBE.IDITEM);
                                      }
                                      else {
                                          var msgConfig = { Titulo: "AGREGAR ACCION", Descripcion: 'No es posible agregar una ACCIÓN sin primero seleccionar un objetivo'};
                                          var oMsg = new SIMA.MessageBox(msgConfig);
                                          oMsg.Alert();
                                      }
                                      break;
                                  case "4":
                                      if ((DetalleBE != undefined)&& (DetalleBE.VAL4 == 2)) {//Registro seleccionado debe ser una accion
                                          AdministrarObjetivosAcciones.Detalle.Indicadores(ItemBE.NOMBRE, frmEdit, SIMA.Utilitario.Enumerados.ModoPagina.N, ItemBE.VAL1, 0, 82, DetalleBE.IDITEM);
                                      }
                                      else {
                                          var msgConfig = { Titulo: "AGREGAR INDICADOR", Descripcion: 'No es posible agregar un INDICADOR sin primero seleccionar una acción' };
                                          var oMsg = new SIMA.MessageBox(msgConfig);
                                          oMsg.Alert();
                                      }
                                      
                                      break;

                              }

                          }
                      };
                      SIMA.Utilitario.Helper.PopupTablaItems(Config);
                      break;
              }
          }

          function onLoadTreeNode(oGridView, oRow, NodeBE) {
              var TabladeAcciones = 82;
              var oDataRowBE = oGridView.GetDataRow(oRow.attr("Guid"));
              AdministrarObjetivosAcciones.Data.ListarAccionesxObjetivos(oDataRowBE.IDTBL, oDataRowBE.IDITEM).Rows.forEach(function (oDataRow, r) {
                  var IdFila = (r+1);
                  if (oDataRowBE.IDTBL != TabladeAcciones) {
                      AdministrarObjetivosAcciones.ObjetivoAccion(oGridView, (oRow.rowIndex + IdFila), NodeBE, oDataRow);
                  }
                  else { 

                      AdministrarObjetivosAcciones.ObjetivoAccionIndicador(oGridView, (oRow.rowIndex + IdFila), NodeBE, oDataRow);
                  }

              });
            
          }
          function OnClickObjetivo(Data) {
              AdministrarObjetivosAcciones.Detalle.Objetivo('OBETIVO',"DetalleObjetivo.aspx", SIMA.Utilitario.Enumerados.ModoPagina.M, Data.IDTBL, Data.IDITEM);
          }

          AdministrarObjetivosAcciones.ObjetivoAccion = function (_GridView, _RowPos, _NodeBE, _DataRow) {
             // var RowIni = _Row.rowIndex + 1;
              _GridView.InsertRow(_RowPos, function (oCellNew, c) {
                  switch (c) {
                      case 0:
                          oCellNew.css("background-color", "white");
                          var GUID = jNet.get(oCellNew.parentNode).attr("Guid");
                          var oNewDR = _GridView.GetDataRow(GUID);
                          _DataRow.Columns.forEach(function (oDataColumn, c) {
                              oNewDR[oDataColumn.Name] = _DataRow[oDataColumn.Name];

                          });
                          break;
                      case 1:
                              var oNodo = new SIMA.GridTree.Nodo();
                                oNodo.Nivel = parseInt(_NodeBE.Nivel) + 1;
                                oNodo.Id = _DataRow["IDITEM"];
                                oNodo.IdPadre = _NodeBE.Id;
                                oNodo.IdNivel = _NodeBE.IdNivel +  oNodo.Id + '.' ;
                                oNodo.Text = _DataRow["CODIGO"];
                                oNodo.TextoySubTexto = false;
                                oNodo.IsFather = true;
                                oNodo.LoadChild = false;
                                oNodo.Data = _DataRow;
                              var otblNode = SIMA.GridTree.Nodos.Crear(oNodo, _GridView, function (Data) {
                                                                                            AdministrarObjetivosAcciones.Detalle.Acciones('ACCIONES',"DetalleAcciones.aspx", SIMA.Utilitario.Enumerados.ModoPagina.M, Data.IDTBL, Data.IDITEM, Data.IDTBLRELACION,Data.IDTBLITEMRELACION);
                                                                                        });
                              oCellNew.insert(otblNode);
                              oCellNew.css("border-left", "3px dotted gray");
                          break;
                      case 2:
                              oCellNew.css('padding-left', '30px')
                                       .attr("align", "left");
                              oCellNew.innerHTML = _DataRow["NOMBRE"];
                          break;
                      case 3:
                              oCellNew.attr("align", "left");
                              oCellNew.innerHTML = _DataRow["DESCRIPCION"];
                          break;
                  }
              });
          }

          AdministrarObjetivosAcciones.ObjetivoAccionIndicador = function (_GridView, _RowPos, _NodeBE, _DataRow) {
              var TblTipoRecurso = 88;
              var IdTipoRecurso = 4;//Tipo de Indicadores
              if (
                  (_DataRow["VAL3"].toString().Equal(TblTipoRecurso))
                  &&
                  (_DataRow["VAL4"].toString().Equal(IdTipoRecurso))
              ) {
                  _GridView.InsertRow(_RowPos, function (oCellNew, c) {
                      switch (c) {
                          case 0:
                              oCellNew.css("background-color", "white");
                              var GUID = jNet.get(oCellNew.parentNode).attr("Guid");
                              var oNewDR = _GridView.GetDataRow(GUID);
                              _DataRow.Columns.forEach(function (oDataColumn, c) {
                                  oNewDR[oDataColumn.Name] = _DataRow[oDataColumn.Name];

                              });
                              break;
                          case 1:
                              oCellNew.css("border-left", "3px dotted gray");
                              oCellNew.css("background-color", "white");

                              var oNodo = new SIMA.GridTree.Nodo();
                              oNodo.Nivel = parseInt(_NodeBE.Nivel) + 1;
                              oNodo.Id = _DataRow["IDITEM"];
                              oNodo.IdPadre = _NodeBE.Id;
                              oNodo.IdNivel = _NodeBE.IdNivel +  oNodo.Id + '.' ;
                              oNodo.Text = _DataRow["CODIGO"];
                              oNodo.TextoySubTexto = false;
                              oNodo.IsFather = false;
                              oNodo.LoadChild = false;
                              oNodo.Data = _DataRow;
                              var otblNode = SIMA.GridTree.Nodos.Crear(oNodo, _GridView, function (Data) {
                                  AdministrarObjetivosAcciones.Detalle.Indicadores('INDICADORES', "DetalleIndicador.aspx", SIMA.Utilitario.Enumerados.ModoPagina.M, Data.IDTBL, Data.IDITEM, Data.IDTBLRELACION, Data.IDTBLITEMRELACION);
                                                    });
                              oCellNew.insert(otblNode);
                              break;
                          case 2:
                              oCellNew.attr("colspan", "2")
                                  .attr("align", "left");

                              var tblIndicador = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(2, 2);
                              tblIndicador.attr("class", "ItemIndicador");
                              var oImg = jNet.create('img');
                              oImg.attr("src", imgIndica);
                              jNet.get(tblIndicador.rows[0].cells[0]).insert(oImg);
                              tblIndicador.rows[0].cells[1].innerHTML = _DataRow["NOMBRE"];
                              jNet.get(tblIndicador.rows[0].cells[1]).attr('width', '100%;').css("font-weight","bold");

                              var RowColCero = jNet.get(tblIndicador.rows[1].cells[0]);
                              RowColCero.innerHTML = _DataRow["DESCRIPCION"];
                              RowColCero.attr("colspan", "2");

                              jNet.get(tblIndicador.rows[1].cells[1]).css("visibility", "hidden").css("display", "none");
                              oCellNew.insert(tblIndicador);
                               
                              break;
                          case 3:
                              //Lista de areas vinculadas al indicador
                              AdministrarObjetivosAcciones.PaintsResponsable(oCellNew,_DataRow.IDTBL, _DataRow.IDITEM);

                              break;

                          default:
                              oCellNew.css("visibility", "hidden");
                              oCellNew.css("display", "none");
                              break;

                      }
                  });



                  //jNet.get(_GridView.rows[_Row.rowIndex + 1].cells[2]).attr("colspan", "3");
              }
          }

          AdministrarObjetivosAcciones.PaintsResponsable = function (oCellNew,Idtbl,IdItem) {
              oCellNew.attr("align", "left");
              AdministrarObjetivosAcciones.Data.ListarAccionesResponsables(Idtbl, IdItem).Rows.forEach(function (oDataRowResponsable, r) {
                  var tblArea = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(1, 2);
                  var sclass = ((oDataRowResponsable["IDTBLITEMRELACION"].toString() == "0") ? "ItemAreaNoInfo" : "ItemArea");
                  tblArea.attr("class", sclass);
                  var oimg = jNet.create("img");
                  oimg.attr("src", SIMA.Utilitario.Constantes.ImgDataURL.Home);
                  jNet.get(tblArea.rows[0].cells[0]).insert(oimg);
                  tblArea.rows[0].cells[1].innerHTML = oDataRowResponsable["NOMBRE_AREA"].toString();
                  var CellArea = jNet.get(tblArea.rows[0].cells[1]);
                  CellArea.css("padding-right", "10px").css("text-decoration", "underline");
                  CellArea.attr("Data", ''.toString().BaseSerialized(oDataRowResponsable));
                  CellArea.addEvent("click", function () {
                      var Data = jNet.get(this).attr("Data").SerializedToObject();
                      AdministrarObjetivosAcciones.Detalle.Area('CONFIGURAR INDICADORES POR AREA', "DetalleAreaIndicador.aspx", SIMA.Utilitario.Enumerados.ModoPagina.M, Data.IDTBL, Data.IDITEM, Data.IDTBLINDICADOR, Data.IDINDICADOR);
                  });
                  oCellNew.insert(tblArea);
              });
          }




          AdministrarObjetivosAcciones.Data = {};

          AdministrarObjetivosAcciones.Data.ListarAccionesxObjetivos=function(IdTablaObjetivo, IdItemObjetivo)
          {

              var oEasyDataInterConect = new EasyDataInterConect();
              oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
              oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
              oEasyDataInterConect.Metodo = "ListarObjetivosoAcciones";

              var oParamCollections = new SIMA.ParamCollections();
              var oParam = new SIMA.Param("IdTblObjetivo", IdTablaObjetivo, TipodeDato.Int);
              oParamCollections.Add(oParam);

              oParam = new SIMA.Param("IdObjetivo", IdItemObjetivo, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
              return oEasyDataResult.getDataTable();
          }


          AdministrarObjetivosAcciones.Data.ListarAccionesResponsables = function (IdTablaObjetivo, IdItemObjetivo) {

              var oEasyDataInterConect = new EasyDataInterConect();
              oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
              oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
              oEasyDataInterConect.Metodo = "ListarAccioneResponsable";

              var oParamCollections = new SIMA.ParamCollections();
              var oParam = new SIMA.Param("IdTblObjetivo", IdTablaObjetivo, TipodeDato.Int);
              oParamCollections.Add(oParam);

              oParam = new SIMA.Param("IdObjetivo", IdItemObjetivo, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
              return oEasyDataResult.getDataTable();
          }





          AdministrarObjetivosAcciones.Detalle = {};

          AdministrarObjetivosAcciones.Detalle.Objetivo = function (Titulo,Pagina, Modo, IdTabla, IdItem) {
              AdministrarObjetivosAcciones.Detalle.FormBase.Show(Titulo, "/GestionGobernanza/Indicadores/" + Pagina, Modo, IdTabla, IdItem);
              
          }

          AdministrarObjetivosAcciones.Detalle.Acciones = function (Titulo,Pagina, Modo, IdTabla, IdItem, IdTablaRel, IdItemRel) {
              AdministrarObjetivosAcciones.Detalle.FormBase.Show(Titulo, "/GestionGobernanza/Indicadores/" + Pagina, Modo, IdTabla, IdItem, IdTablaRel, IdItemRel);
          }

          AdministrarObjetivosAcciones.Detalle.Indicadores = function (Titulo,Pagina, Modo, IdTabla, IdItem, IdTablaRel, IdItemRel) {
              var _Titulo = '<table><tr><td><img style ="width:45px;border-radius: 50%;background-color: white;" src="' + imgIndica + '"/></td><td>' + Titulo + '</td></tr></table>';
              AdministrarObjetivosAcciones.Detalle.FormBase.Show(_Titulo, "/GestionGobernanza/Indicadores/" + Pagina, Modo, IdTabla, IdItem, IdTablaRel, IdItemRel);
          }

          AdministrarObjetivosAcciones.Detalle.Area = function (Titulo, Pagina, Modo, IdTabla, IdItem, IdTablaRel, IdItemRel) {
              var _Titulo = '<table><tr><td><img style ="width:45px;border-radius: 50%;background-color: white;" src="' + SIMA.Utilitario.Constantes.ImgDataURL.Home + '"/></td><td>' + Titulo + '</td></tr></table>';
              AdministrarObjetivosAcciones.Detalle.FormBase.Show(_Titulo, "/GestionGobernanza/Indicadores/" + Pagina, Modo, IdTabla, IdItem, IdTablaRel, IdItemRel);
          }



          AdministrarObjetivosAcciones.Detalle.FormBase = {};
          AdministrarObjetivosAcciones.Detalle.FormBase.Show = function (Titulo, FormDetalle, Modo, IdTabla, IdItem, IdTablaRel, IdItemRel) {
              var Url = Page.Request.ApplicationPath + FormDetalle;
              var oColletionParams = new SIMA.ParamCollections();
              var oParam = new SIMA.Param(AdministrarObjetivosAcciones.KEYMODOPAGINA, Modo);
              oColletionParams.Add(oParam);

              oParam = new SIMA.Param(AdministrarObjetivosAcciones.KEYQIDTABLAGENERAL, IdTabla);
              oColletionParams.Add(oParam);

              oParam = new SIMA.Param(AdministrarObjetivosAcciones.KEYQIDITEMTABLAGENERAL, IdItem);
              oColletionParams.Add(oParam);

              if (IdTablaRel != undefined) {
                  oParam = new SIMA.Param(AdministrarObjetivosAcciones.KEYQIDTABLAGENERALREL, IdTablaRel);
                  oColletionParams.Add(oParam);
              }
              if (IdItemRel != undefined) {
                  oParam = new SIMA.Param(AdministrarObjetivosAcciones.KEYQIDITEMTABLAGENERALREL, IdItemRel);
                  oColletionParams.Add(oParam);
              }

              EasyPopupDetalleObjetivo.Titulo = Titulo;
              EasyPopupDetalleObjetivo.Load(Url, oColletionParams, false);
          }



          AdministrarObjetivosAcciones.Detalle.Aceptar = function () {
              switch (GlobalEntorno.PageName) {
                  case "DetalleObjetivo":
                      var oParamCollections = new SIMA.ParamCollections();
                      var oParam = new SIMA.Param("IdItem", ((DetalleObjetivo.Data==undefined)?"0": DetalleObjetivo.Data.IDITEM), TipodeDato.Int);
                          oParamCollections.Add(oParam);
                      // oParam = new SIMA.Param("Codigo", txtCodigo.GetValue());
                          oParam = new SIMA.Param("Codigo", '0');
                          oParamCollections.Add(oParam);

                          oParam = new SIMA.Param("Nombre", txtNombre.GetValue());
                          oParamCollections.Add(oParam);

                          oParam = new SIMA.Param("Descripcion", txtDescripcion.GetValue());
                          oParamCollections.Add(oParam);
                          oParam = new SIMA.Param("IdVersion", AdministrarObjetivosAcciones.Params[AdministrarObjetivosAcciones.KEYOBJETIVOVERSION], TipodeDato.Int);
                          oParamCollections.Add(oParam);
                          oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                          oParamCollections.Add(oParam);

                      var oEasyDataInterConect = new EasyDataInterConect();
                          oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                          oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
                          oEasyDataInterConect.Metodo = 'Objetivo_ins';
                          oEasyDataInterConect.ParamsCollection = oParamCollections;

                          var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                          var ResultBE = oEasyDataResult.sendData();

                          if (DetalleObjetivo.Params[DetalleObjetivo.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.M) {
                              //Actualiza la fila de la grilla
                              var oRow = EasyGridView1.GetRowActive();
                              var orowsNodo = oRow.cells[1].children[0].rows[0];
                              var xcellNodo = orowsNodo.cells[orowsNodo.cells.length - 1];
                              xcellNodo.innerHTML = txtCodigo.GetValue();

                              var xcell = jNet.get(oRow.cells[2]);
                              xcell.innerHTML = txtNombre.GetValue();
                              jNet.get(oRow.cells[3]).innerHTML = txtDescripcion.GetValue();;
                          }
                          else {
                              __doPostBack('btnPostBack', '');
                          }

                          return true;

                      break;
                  case "DetalleAcciones":

                      var oParamCollections = new SIMA.ParamCollections();
                      var oParam = new SIMA.Param("IdItem", ((DetalleAcciones.Data == undefined)?"0":DetalleAcciones.Data.IDITEM), TipodeDato.Int);
                      oParamCollections.Add(oParam);

                      //oParam = new SIMA.Param("Codigo", txtCodigo.GetValue());
                      oParam = new SIMA.Param("Codigo", '0');
                      oParamCollections.Add(oParam);

                      oParam = new SIMA.Param("Nombre", txtNombre.GetValue());
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("Descripcion", txtDescripcion.GetValue());
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("IdObjetivo", ((DetalleAcciones.Data == undefined) ? DetalleAcciones.Params[DetalleAcciones.KEYQIDITEMTABLAGENERALREL]:DetalleAcciones.Data.IDTBLITEMRELACION), TipodeDato.Int);
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                      oParamCollections.Add(oParam);

                      var oEasyDataInterConect = new EasyDataInterConect();
                      oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                      oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
                      oEasyDataInterConect.Metodo = 'Accion_ins';
                      oEasyDataInterConect.ParamsCollection = oParamCollections;

                      var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                      var ResultIdAccion = oEasyDataResult.sendData();

                      if (DetalleAcciones.Params[DetalleAcciones.KEYMODOPAGINA]== SIMA.Utilitario.Enumerados.ModoPagina.M) {
                          //Actualiza la fila de la grilla
                          var oRow = EasyGridView1.GetRowActive();

                          var orowsNodo = oRow.cells[1].children[0].rows[0];
                          var xcellNodo = orowsNodo.cells[orowsNodo.cells.length - 1];
                          xcellNodo.innerHTML = txtCodigo.GetValue();

                          var xcell = jNet.get(oRow.cells[2]);
                          xcell.innerHTML = txtNombre.GetValue();
                          jNet.get(oRow.cells[3]).innerHTML = txtDescripcion.GetValue();
                      }
                      else {
                          
                          __doPostBack('btnPostBack', '');
                      }

                      return true;

                      break;
                  case "DetalleIndicador":
                      var oParamCollections = new SIMA.ParamCollections();
                      var oParam = new SIMA.Param("IdItem", ((DetalleIndicador.Data == undefined)?"0": DetalleIndicador.Data.IDITEM), TipodeDato.Int);
                      oParamCollections.Add(oParam);
                      //oParam = new SIMA.Param("Codigo", txtCodigo.GetValue());
                      oParam = new SIMA.Param("Codigo", '0');
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("Nombre", txtNombre.GetValue());
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("Descripcion", txtDescripcion.GetValue());
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("IdAccion", ((DetalleIndicador.Data == undefined) ? DetalleIndicador.Params[DetalleIndicador.KEYQIDITEMTABLAGENERALREL] : DetalleIndicador.Data.IDTBLITEMRELACION), TipodeDato.Int);
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                      oParamCollections.Add(oParam);

                      var oEasyDataInterConect = new EasyDataInterConect();
                      oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                      oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
                      oEasyDataInterConect.Metodo = 'Indicador_ins';
                      oEasyDataInterConect.ParamsCollection = oParamCollections;

                      var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                      var ResultIdIndicador = oEasyDataResult.sendData();
                      //Obtener la Lista de responsables
                      EasyAcBuscarPersonal.GetCollection().forEach(function (oItem, i) {
                          AdministrarObjetivosAcciones.ResponsablesInsAct(oItem, ResultIdIndicador);
                      });

                      if (DetalleIndicador.Params[DetalleIndicador.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.M) {
                          //Actualiza las celdas
                          var oRow = EasyGridView1.GetRowActive();
                          var xcell = jNet.get(oRow.cells[3]);
                          xcell.remove();
                          //Carga las nuevas areas
                          AdministrarObjetivosAcciones.PaintsResponsable(xcell, 87, DetalleIndicador.Data.IDITEM);
                          //Actualiza la fila de la grilla
                          var oRow = EasyGridView1.GetRowActive();

                          var orowsNodo = oRow.cells[1].children[0].rows[0];
                          var xcellNodo = orowsNodo.cells[orowsNodo.cells.length - 1];
                          xcellNodo.innerHTML = txtCodigo.GetValue();


                          var xcell = jNet.get(oRow.cells[2]);
                          var tblInd = jNet.get(xcell.children[0]);
                          tblInd.rows[0].cells[1].innerHTML = txtNombre.GetValue();
                          tblInd.rows[1].cells[0].innerHTML = txtDescripcion.GetValue();
                      }
                      else {
                          __doPostBack('btnPostBack', '');
                      }
                      break;
                  case "DetalleAreaIndicador":
                  case "ListadodeMetasPorArea":
                      var oParamCollections = new SIMA.ParamCollections();
                      var objh = jNet.get('hIdAreaInfo');
                      var oParam = new SIMA.Param("IdAreaInfo", objh.attr("value"), TipodeDato.Int);
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("FuenteInforma", txtFuente.GetValue());
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("IdArea", DetalleAreaIndicador.Params[DetalleAreaIndicador.KEYQIDITEMTABLAGENERAL], TipodeDato.Int);
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("IdTipo", ddlUnidad.GetValue());
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("IdSentido", ddlSentido.GetValue());
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("IdPeridoMedicion", ddlMedicion.GetValue());
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("IdProceso", ddlProceso.GetValue());
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                      oParamCollections.Add(oParam);

                      var oEasyDataInterConect = new EasyDataInterConect();
                      oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                      oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
                      oEasyDataInterConect.Metodo = 'AreaInforComplementaria_ins';
                      oEasyDataInterConect.ParamsCollection = oParamCollections;

                      var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                      var ResultIdInfo = oEasyDataResult.sendData();
                      
                      if (ResultIdInfo != null) {
                          var ResultBE = ResultIdInfo.toString().SerializedToObject();
                          //Obtener las condiciones del, indicador
                          var cols = jNet.get("tbl_Condicion").rows[1].querySelectorAll("td").forEach(function (cell) {
                              var DataBE = jNet.get(cell).attr('Data').toString().SerializedToObject();
                              var ctrText = jNet.get(cell.children[0]);

                              DataBE.IDAREAINFOCOMP = ResultBE.IdOut;
                              DataBE.VALORCONDICION = ctrText.GetValue();
                              if (DataBE.VALORCONDICION.length > 0) {
                                  AreaIndicadorCondicion_Ins(DataBE);
                              }
                          }); 
                          //Datos d Metas
                          var cols = jNet.get("tbl_Meta").rows[1].querySelectorAll("td").forEach(function (cell) {
                              var DataBE = jNet.get(cell).attr('Data').toString().SerializedToObject();
                              var ctrText = jNet.get(cell.children[0]);

                              DataBE.IDAREAINFO = ResultBE.IdOut;
                              DataBE.META = ctrText.GetValue();
                              if (DataBE.META.length > 0) {
                                  AdministrarObjetivosAcciones.AreaIndicadorMetaInsAct(DataBE);
                              }
                          }); 
                      }
                      break;
              }
              return true;
          }

          AdministrarObjetivosAcciones.ResponsablesInsAct = function (ReponsableBE,IdIndiador) {
              var oParamCollections = new SIMA.ParamCollections();
              var oParam = new SIMA.Param("IdItem", ((ReponsableBE.IDITEM == undefined) ? 0 : ReponsableBE.IDITEM), TipodeDato.Int);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("CodigoArea", ReponsableBE.COD_AREA);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("Descripcion", "");
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("IdAccion", ((DetalleIndicador.Data == undefined) ? IdIndiador : DetalleIndicador.Data.IDITEM), TipodeDato.Int);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
              oParamCollections.Add(oParam);

              var oEasyDataInterConect = new EasyDataInterConect();
              oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
              oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
              oEasyDataInterConect.Metodo = 'Reesposable_ins';
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
              var ResultBE = oEasyDataResult.sendData();
          }

          AdministrarObjetivosAcciones.AreaIndicadorMetaInsAct = function (AreaIndicadorMetaBE) {

              var oParamCollections = new SIMA.ParamCollections();
              var oParam = new SIMA.Param("IdItemMetaArea", AreaIndicadorMetaBE.IDMETAAREA , TipodeDato.Int);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("Meta", AreaIndicadorMetaBE.META);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("IdAreaInfoComplet", AreaIndicadorMetaBE.IDAREAINFO, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("IdTipoDetMeta", AreaIndicadorMetaBE.IDDETALLEPLAZO);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
              oParamCollections.Add(oParam);

              var oEasyDataInterConect = new EasyDataInterConect();
              oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
              oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
              oEasyDataInterConect.Metodo = 'AreaindicadorPlazo_ins';
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
              var ResultBE = oEasyDataResult.sendData();
          }

          function AreaIndicadorCondicion_Ins(AreaIndicadorCondBE) {
              var oParamCollections = new SIMA.ParamCollections();

              var oParam = new SIMA.Param("IdItemConfig", AreaIndicadorCondBE.IDITEMCONDICION, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("Condicion", AreaIndicadorCondBE.VALORCONDICION );
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("IdAreaInfo", AreaIndicadorCondBE.IDAREAINFOCOMP, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("IdColor", AreaIndicadorCondBE.IDCOLOR);
              oParamCollections.Add(oParam);
              oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
              oParamCollections.Add(oParam);

              var oEasyDataInterConect = new EasyDataInterConect();
              oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
              oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
              oEasyDataInterConect.Metodo = 'AreaCondicionIndicador_ins';
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
              var ResultBE = oEasyDataResult.sendData();
          }

      </script>

          <asp:Button ID="btnPostBack" runat="server" Text="Button" OnClick="btnPostBack_Click" />
          <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/GestionGobernanza/Indicadores/AdministrarInformeMetaPorArea.aspx" Visible="False">HyperLink</asp:HyperLink>
          <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/GestionGobernanza/Indicadores/AdministrarResponsablePorArea.aspx" Visible="False">Responsable por Area</asp:HyperLink>
    </form>
  
</body>
</html>
