<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarIndicadoresPorArea.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.ListarIndicadoresPorArea" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
      <style>
          .Titulo {
              font-weight: bold;
              text-transform: uppercase;
               color:red;
          }
      </style>
    
       <script>
           function onChangePeriodo(oLisItem) {
               var oDetMeta = jNet.get("DetInd_" + ListarIndicadoresPorArea.Params[ListarIndicadoresPorArea.KEYCODAREA]);
               oDetMeta.clear();

              // alert();
              /* alert(AdministrarMetasPorArea.Params[AdministrarMetasPorArea.KEYIDAREAINFO]);
               alert(AdministrarMetasPorArea.Params[AdministrarMetasPorArea.KEYIDINDICADOR]);


               alert(oLisItem.value);*/
           }


           function ListViewResponsable_ItemMouseMove(Target, Source, oItem) {
               ListItemActivo = { Origen: Source, Item: oItem, Target: Target };
           }
       </script>

</head> 
<body> 
    <form id="form1" runat="server">
        <table id="tblServicios" style="width:100%;height:100%"  border="0" >            
             <tr>
                 <td>
                     <table>
                          <tr>
                             <td class="Etiqueta">
                                 PERIODO:
                             </td>
                             <td style="width:10%">
                                   <cc3:EasyDropdownList ID="ddlPeriodo" runat="server" CargaInmediata="True"  DataTextField="NOMBRE" DataValueField="CODIGO" MensajeValida="No se ha seleccionado PERIODO" fnOnSelected="onChangePeriodo" >
                                      <EasyStyle Ancho="Dos"></EasyStyle>
                                      <DataInterconect  MetodoConexion="WebServiceExterno">
                                          <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                          <Metodo>ListarTodosOracle</Metodo>
                                          <UrlWebServicieParams>
                                              <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdtblModulo" Paramvalue="102" TipodeDato="Int" />
                                              <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                          </UrlWebServicieParams>
                                      </DataInterconect>
                                </cc3:EasyDropdownList>
                             </td>
                             <td class="Etiqueta" style="width:10%;padding-left: 10px;" >
                                 RESPONSABLES:
                             </td>
                              <td id="lstReponsable" runat="server"  style="width:80%; padding-left: 10px;">
                                  
                              </td>
                         </tr>
                     </table>
                 </td>
             </tr>
             <tr>
                 <td class="Etiqueta">INDICADORES ASOCIADOS..</td>
             </tr>
             <tr>
                 <td id="LsIndicadores"  runat="server">
    
                </td>
             </tr>
             <tr>
                 <td class="Etiqueta">EVALUACION DE METAS:</td>
             </tr>
             <tr>
                 <td style="width:100%; height:100%"  runat="server">
                             <cc1:EasyGridView ID="EasyDGIndicadores" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="GESTION DE INDICADORES"  ToolBarButtonClick="" Width="100%" AllowPaging="True"   fncExecBeforeServer="" OnRowDataBound="EasyDGIndicadores_RowDataBound" >

                                <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                    <DataInterconect MetodoConexion="WebServiceExterno">
                                        <UrlWebService></UrlWebService>
                                        <Metodo>Requerimientos_lst</Metodo>
                                        <UrlWebServicieParams>
                                            <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdUsuario" Paramvalue="IdUsuario" TipodeDato="Int" />
                                            <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="UserName" TipodeDato="String"/>
                                        </UrlWebServicieParams>
                                    </DataInterconect>

                                <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick ="GridetalleNull"  idgestorfiltro=""></EasyExtended>

                                <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                                <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                                <Columns>
                                    <asp:BoundField DataField="CODIGOOBJETIVO" HeaderText="CODIGO" >
                                    <ItemStyle HorizontalAlign="Left" Width="5%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NOMBREOBJETIVO" HeaderText="OBJETIVO / ACCIONES" >
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
             <tr>

                 <td id="DetIndicador" style="width:100%; height:100%"  runat="server">
                     
                 </td>

             </tr>
        </table>       

        <cc3:EasyPopupBase ID="EasyPopupDetalle" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="INDICADORES"  ValidarDatos="true" CtrlDisplayMensaje="msgValRqr"  RunatServer="false" DisplayButtons="true"></cc3:EasyPopupBase>

    </form>
        <script>
            var imgIndica = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAApCAMAAAB9Yuu9AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHvUExURQAAAODg4MPDw5mZmd3d3aKiooKCgoqKisDAwM3NzdbW1nR0dFBQUHt7e2xsbE5OTrGxsZubm29vb9jY2LCwsEtLS6Ghoe/v79ra2nZ2dklJSdTU1OHh4ZycnHh4eL29vaenp01NTcfHx/v7+/Hx8Y+Pjzc3N4mJiYuLi42Njerq6ldXV8jIyMbGxnp6eoSEhE9PT6+vr4SEg1ZWVqysrLe3t7q6upqamkpKSnd3d9DQ0GVlZYODg7i4uKOjo5eXl8/Pz8zMzMXFxYaGhry8vIyMjNfX1z09PZiYmKSkpGNjY5KSko6OjltbW9XV1dzc3FxcXL+/v4GBgZ2dnV5eXmFhYWBgYNHR0bu7u2pqapOTk4WFhWRkZKmpqVNTU7a2tsvLy7S0tMHBwb6+vtnZ2XV1dVlZWcrKylhYWFpaWl9fX9LS0jk5OXBwcFJSUlFRUaCgoGhoaExMTDo6OsnJyaurqzw8PIiIiGlpac7OzrKysp6enn5+fkhISD8/P3FxcW5ubtPT04eHhz4+Pq2trZCQkH19fTs7O0VFRcLCwqWlpbm5uUdHR7W1tfb29unp6UBAQERERP7+/vPz8zMzM1RUVFVVVWZmZtvb25SUlDY2Nmtra0FBQUNDQ6ioqICAgO3t7bOzs0JCQq6urgAAAIvbXT8AAACldFJOU///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////ACB7zgQAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALiSURBVEhLzZRrWxJBFIA3RNQkIRSLNTQsJMNripGaghEVhhcUUgmxSERJMsi7pGQWopRd7KZ2PT+0mZ1BVkEf+tb7Yc97DoflsDM7DGTGCRIYEGQJiR6DMFuUk4uFgTwuHkJ4kgqHMF98qkAiRXbEMKdlhdQwRfLiM2cVbAlpP0eKfJSlZdQw51XlFy6qK/KOvLtGdIkaJpetvJyn1SJjoCqb1PhU19TW1VPHXKloUMkbkaC/qiMlPk2VV/XXqGOaW7St17GkH6at3aBQGWmC6LhhIpK+PeumWXrrNk0QdyzlRNK3d94FsMqMXd00z++hwkAv/gsHMdvQnfvYfruD/IJZrOEibr83QDWJcbAY7ZIhtfO+3oXz8mE3Vz80zAjdDw+sD4lAC+tBV6nzEUkPto96x7g45KMbEMbGJwTdBs3+0qD2/T3g73ls42TSwQWMJ/BE4ZBM0Qy1u55SBY8kGHqGot9aSwoY6bhPOzpCE9Te0UkVOr3TM7Mojs1Nk0Iq/NktpSAangdYqEGX9PDa54OL0BxET3ipP7E8KfDaF/Voj7eGBx3PZbSSCgMmEdXlOvR0R2pWViaLaIWHgbyNDJS0cQKROgWRNAgGw+IXWJLDeFZfUkvB4NCuvXq9hizZ7oxSAeU6FYgtcGFjM/7mrU2FDpj9dvN4Yrk0W/YqYhvvvNw+r5d3vP9Q+ZE7CeIF3EeucIyLkLM6uF3Kmf9TdPszlq5tWVmMtSJjwKjEFfD1A3xpEvTaKmzw9RtXW5oxNa7ib0YmQqGQJYIsMUx7IA7zO7sqdk8NULjTg8b/vomWLGd3KTZl8fW5XHg3JdrXxT9+GuxepXvhF05LAnPOWbEday0rUWkXsWFo+7LeHQkGm0iCiA3Low0CmvCOXAY8aHWqw7+1Uf2Rzz0JelfRE/Gr1a2z9Cg5luQyZcR/1i6sN8Uz4Q8+qRmQsuGtTNgLoDcYDaMb0OncGYAX8Z9mB/gLhJoM+WWVTm0AAAAASUVORK5CYII=";

            function GridetalleNull() {
            }
            function OnClickObjetivo(Data) {
                //AdministrarObjetivosAcciones.Detalle.Objetivo('OBETIVO', "DetalleObjetivo.aspx", SIMA.Utilitario.Enumerados.ModoPagina.M, Data.IDTBL, Data.IDITEM);
               // alert('Detalle');
            }

            function onLoadTreeNode(oGridView, oRow, NodeBE) {
                var arrIds = NodeBE.Id.toString().split('-');
                var Idtbl = arrIds[0];
                var IdIem = arrIds[1];
                var TabladeAcciones = 82;
                var oDataRowBE = oGridView.GetDataRow(oRow.attr("Guid"));

                if (oDataRowBE.TIPO == '1') {
                    ListarIndicadoresPorArea.Data.ListarAcciones(2, Idtbl, IdIem).Rows.forEach(function (oDataRow, r) {
                        var IdFila = (r + 1);
                        ListarIndicadoresPorArea.ObjetivoAccion(oGridView, (oRow.rowIndex + IdFila), NodeBE, oDataRow);
                    });
                }
                else {
                    ListarIndicadoresPorArea.Data.ListarAcciones(3, Idtbl, IdIem).Rows.forEach(function (oDataRow, r) {
                        var IdFila = (r + 1);
                        ListarIndicadoresPorArea.ObjetivoAccionIndicador(oGridView, (oRow.rowIndex + IdFila), NodeBE, oDataRow);
                       
                    });
                }
            }

            ListarIndicadoresPorArea.ObjetivoAccion = function (_GridView, _RowPos, _NodeBE, _DataRow) {
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
                            oNodo.Id = _DataRow["IDTBLACCION"] + '-' + _DataRow["IDACCION"];
                            oNodo.IdPadre = _NodeBE.Id;
                            oNodo.IdNivel = _NodeBE.IdNivel + oNodo.Id + '.';
                            oNodo.Text = _DataRow["CODIGOOBJETIVO"] +'.' + _DataRow["CODIGOACCION"];
                            oNodo.TextoySubTexto = false;
                            oNodo.IsFather = true;
                            oNodo.LoadChild = false;
                            oNodo.Data = _DataRow;
                            var otblNode = SIMA.GridTree.Nodos.Crear(oNodo, _GridView, function (Data) {
                                //AdministrarObjetivosAcciones.Detalle.Acciones('ACCIONES', "DetalleAcciones.aspx", SIMA.Utilitario.Enumerados.ModoPagina.M, Data.IDTBL, Data.IDITEM, Data.IDTBLRELACION, Data.IDTBLITEMRELACION);
                            });
                            oCellNew.insert(otblNode);
                            oCellNew.css("border-left", "3px dotted gray");
                            break;
                        case 2:
                            oCellNew.css('padding-left', '30px')
                                .attr("align", "left");
                            oCellNew.innerHTML = _DataRow["NOMBREACCION"];
                            break;
                        case 3:
                            oCellNew.attr("align", "left");
                            //oCellNew.innerHTML = _DataRow["DESCRIPCION"];
                            break;
                    }
                });
            }

           
            ListarIndicadoresPorArea.ObjetivoAccionIndicador = function (_GridView, _RowPos, _NodeBE, _DataRow) {
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
                                oNodo.Id = _DataRow["IDTBLINDICADOR"] + '-' + _DataRow["IDINDICADOR"];
                                oNodo.IdPadre = _NodeBE.Id;
                                oNodo.IdNivel = _NodeBE.IdNivel + oNodo.Id + '.';
                                oNodo.Text = _NodeBE.Data.CODIGOOBJETIVO + '.' + _NodeBE.Data.CODIGOACCION +'.' + _DataRow["CODIGOINDICADOR"];
                                oNodo.TextoySubTexto = false;
                                oNodo.IsFather = false;
                                oNodo.LoadChild = false;
                                oNodo.Data = _DataRow;
                                var otblNode = SIMA.GridTree.Nodos.Crear(oNodo, _GridView, function (Data) {
                                    //AdministrarObjetivosAcciones.Detalle.Indicadores('INDICADORES', "DetalleIndicador.aspx", SIMA.Utilitario.Enumerados.ModoPagina.M, Data.IDTBL, Data.IDITEM, Data.IDTBLRELACION, Data.IDTBLITEMRELACION);
                                });
                                oCellNew.insert(otblNode);
                                break;
                            case 2://Columna de indicador
                                oCellNew.attr("colspan", "3")
                                    .attr("align", "left");

                                var tblIndicador = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(3, 3);
                                    tblIndicador.attr("id", "tbl_" + _DataRow.COD_AREA + "_" +  _DataRow.IDINDICADOR);
                                
                                    tblIndicador.attr("border", "0").css("cursor", "pointer");
                                    tblIndicador.attr("bloqueado", "0");
                                    tblIndicador.attr("class", "ItemIndicador");

                                var oImg = jNet.create('img');
                                oImg.attr("src", imgIndica);
                                jNet.get(tblIndicador.rows[0].cells[0]).insert(oImg);
                                tblIndicador.rows[0].cells[1].innerHTML = _DataRow["NOMBRE"];
                                jNet.get(tblIndicador.rows[0].cells[1]).attr('width', '100%').css("font-weight", "bold");


                                var oimgC = jNet.create('img');
                                oimgC.attr("src", SIMA.Utilitario.Constantes.ImgDataURL.IconConfig);
                                oimgC.attr("IDAREA", _DataRow.IDAREA);
                                oimgC.attr("INDICADOR", _DataRow.IDINDICADOR);
                                oimgC.css("cursor", "pointer");

                                
                                oimgC.addEvent("click", function () {
                                    var ImgConfig = jNet.get(this);
                                    ListarIndicadoresPorArea.ConfigIndicador(jNet.get(this.parentNode.parentNode.parentNode.parentNode), ImgConfig.attr("IDAREA"), ImgConfig.attr("INDICADOR"));
                                });
                                oimgC.addEvent("mouseover", function () {
                                                                        jNet.get(this.parentNode.parentNode.parentNode.parentNode).attr('bloqueado', '1');
                                                                    });
                                oimgC.addEvent("mouseout", function () {
                                                             jNet.get(this.parentNode.parentNode.parentNode.parentNode).attr('bloqueado', '0');
                                                });
                                               
                             
                                jNet.get(tblIndicador.rows[0].cells[2]).insert(oimgC);


                                var RowColCero = jNet.get(tblIndicador.rows[1].cells[0]);
                                RowColCero.innerHTML = _DataRow["DESCRIPCION"];
                                RowColCero.attr("colspan", "2");
                                jNet.get(tblIndicador.rows[2].cells[0]).attr("colspan", "2");


                                jNet.get(tblIndicador.rows[1].cells[1]).css("visibility", "hidden").css("display", "none");
                                jNet.get(tblIndicador.rows[2].cells[1]).css("visibility", "hidden").css("display", "none");

                                oCellNew.insert(tblIndicador);

                                oCellNew.addEvent("dblclick", function () {
                                    ListarIndicadoresPorArea.AdministraIndicador(_DataRow.COD_AREA, _DataRow.IDITEMINFOCOMPLE, _DataRow.IDINDICADOR);
                                });


                                var IdProgress = "Prog_" + _DataRow.COD_AREA + "_" + _DataRow.IDINDICADOR;
                                var HtmlProgress = "  <div id='" + IdProgress + "_ContentProgress' class='progress progress-striped active' style='margin-left:0;margin-bottom:0;display:none;width: 100%;height: 100%;'>"
                                    + "     <div  id='" + IdProgress + "_Progress' class='progress-bar' style='width: 100%;height: 100%; padding-left: 10px;'>Load..</div>"
                                                    + " </div>";
                    
                                    var tblprogress = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(1, 1);
                                        tblprogress.css("width", "300px");
                                        jNet.get(tblprogress.rows[0].cells[0]).innerHTML=HtmlProgress;

                                    jNet.get(tblIndicador.rows[2].cells[2]).attr("align", "right");
                                    jNet.get(tblIndicador.rows[2].cells[2]).insert(tblprogress);
                                
                                break;
                            default:
                                oCellNew.css("visibility", "hidden");
                                oCellNew.css("display", "none");
                                break;

                        }
                    });
            }




            ListarIndicadoresPorArea.Data = {};
            ListarIndicadoresPorArea.Data.ListarAcciones = function(IdTipo, pIdtbl,pIdItem){
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                oEasyDataInterConect.UrlWebService =  "/GestionGobernanza/Procesar.asmx";
                oEasyDataInterConect.Metodo = "AccionesEIndicadores";
                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("Tipo", IdTipo, TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("pCodArea", ListarIndicadoresPorArea.Params[ListarIndicadoresPorArea.KEYCODAREA]);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("pCodEmp", ListarIndicadoresPorArea.Params[ListarIndicadoresPorArea.KEYCODEMP]);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("pCodSuc", ListarIndicadoresPorArea.Params[ListarIndicadoresPorArea.KEYCODSUC]);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("Idtbl", pIdtbl, TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdItem", pIdItem, TipodeDato.Int);
                oParamCollections.Add(oParam);

                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                return oEasyDataResult.getDataTable();
            }
        </script>


        <script>

            ListarIndicadoresPorArea.AdministraIndicador = function (CodArea,IdAreaInfo,Indicador) {
                var tblNodo = jNet.get("tbl_" + CodArea + "_" + Indicador);
                if (tblNodo.attr("Bloqueado") == "1") { return; }

                    var ddlAño = jNet.get("ddl_" + CodArea); 
                    if (ddlAño.GetValue() == "-1") {
                        var msgConfig = { Titulo: "PERIODO", Descripcion: 'No se ha selecciondo un periodo, selecionar para continuar..' };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                        return;
                    }

                      var bContentProgress = jNet.get("Prog_" + CodArea + "_" + Indicador + "_ContentProgress");
                          bContentProgress.css('display', "block");

                    var urlPag = Page.Request.ApplicationPath + "/GestionGobernanza/Indicadores/AdministrarMetasPorArea.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(ListarIndicadoresPorArea.KEYIDAREAINFO, IdAreaInfo);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(ListarIndicadoresPorArea.KEYIDINDICADOR, Indicador);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(ListarIndicadoresPorArea.KEYCODAREA, CodArea);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(ListarIndicadoresPorArea.KEYQAÑO, ddlAño.GetValue());
                        oColletionParams.Add(oParam);

                    var oLoadConfig = {
                        CtrlName: "DetInd_" + CodArea,
                        UrlPage: urlPag,
                        ColletionParams: oColletionParams,
                        fnOnComplete: function () {
                             bContentProgress.css('display', "none");
                            
                        }
                    };
                    

                    SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
                

            }


            ListarIndicadoresPorArea.ConfigIndicador = function (e, IdAreaInfo, IdIndicador) {
                var oDataTable = ListarIndicadoresPorArea.ListarCriterioXIndicador(IdAreaInfo, IdIndicador);
                var tblCond = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(oDataTable.Rows.Count(), 2);
                tblCond.attr("id", "tblmsg_" + IdAreaInfo + "_" + IdIndicador).css("width","200px");

               
                oDataTable.Rows.forEach(function (item, f) {
                    var Cell0 = jNet.get(tblCond.rows[f].cells[0]);
                        Cell0.innerText = item.NOMBRECOLOR
                        Cell0.attr("class", "Etiqueta")
                            .css("background-color", item.COLOR)
                            .css("color", item.FONTCOLOR)
                            .css("padding-left", "20px");

                    var Cell1 = jNet.get(tblCond.rows[f].cells[1]);
                    Cell1.attr("nowrap", "nowrap");
                    Cell1.innerText = item.VALORCONDICION;
                    Cell1.css("color", "white").css("font-weight", "bold")
                         .css("padding-left", "20px");;

                });

              

                var ConfigMsgb = {
                    Titulo: "CONDICIONAL DE INDICADOR"
                    , Descripcion: tblCond.outerHTML
                    , width:"350px"
                    , Icono: 'fa fa-tag'
                    , EventHandle: function (btn) {
                        if (btn == 'OK') {
                            
                        }
                    }
                };
                var oMsg = new SIMA.MessageBox(ConfigMsgb);
                oMsg.confirm();

                //Establece el color de fondo de msgbox
                Manager.Task.Excecute(function () {
                    var objContent = jNet.get("tblmsg_" + IdAreaInfo + "_" + IdIndicador);
                    var oContentMsg = jNet.get(objContent.parentNode.parentNode.parentNode.parentNode);
                    oContentMsg.attr("align", "center");
                    oContentMsg.css("background-image", "url('../../Recursos/img/ToolBar.jpg')")
                        .css("background-repeat", "repeat-x")
                        .css("width", ConfigMsgb.width)
                        .css("cursor", "pointer")
                        .css("box-shadow", "rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px;");
                }, 100, true);


            }

            ListarIndicadoresPorArea.ListarCriterioXIndicador = function (oIdAreaInfo,oIdIndicador) {
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
                oEasyDataInterConect.Metodo = "ListarIndicadorCondicion";

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("IdArea", oIdAreaInfo , TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdIndicador", oIdIndicador, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                return oEasyDataResult.getDataTable();
            }
            
        /*

            AdministrarMetasPorArea.PopupEstados = function () {
                  var Config = {
                        Titulo: 'LISTA DE INDICADORES POR AREA'
                    , IdTabla: 87
                    , IdSelected: 1
                    , ArrNotIn: [0]
                    , OrigenDB: "Oracle"
                    , width: "500px"
                    , TextField: "ABREV"
                    , IdUerySelector:0//ListarTodos
                    , fncRowDataBound: function (ItemBE) {
                          var strBE = ''.toString().BaseSerialized(ItemBE);
                    return '<table><tr><td>' + ItemBE["NOMBRE"].toString() +'</td></tr></table>';
                      }
                    , fncOK: function (ItemBE) {
                        alert();
                 
                      }
                  };
                    // SIMA.Utilitario.Helper.PopupTablaItems(Config);
                    SIMA.Utilitario.Helper.PopupOptions(Config);
              }*/
        </script>
    
</body>
</html>
