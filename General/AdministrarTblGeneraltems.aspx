<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarTblGeneraltems.aspx.cs" Inherits="SIMANET_W22R.General.AdministrarTblGeneraltems" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register src="../Controles/Header.ascx" tagname="Header" tagprefix="uc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Filtro" tagprefix="cc2" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>


    <style>
        .scrollContainer {
          overflow-y: auto;
          max-height: 500px;
          width:100%;
          position: relative;
          border: 1px solid gray;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
       <table style="width:100%">
           <tr>
               <td class="Etiqueta" style ="width:20%">
                   TABLA DE APOYO:
               </td>
               <td style="width:80%" class="Etiqueta">
                   <asp:Label ID="lblTabla" runat="server" Text="Label"></asp:Label>
               </td>
           </tr>
           <tr>
               <td class="Etiqueta" style ="width:20%">
                   DESCRIPCION:</td>
               <td style="width:80%">
                    <cc3:EasyAutocompletar ID="EasyAcBuscarTablaItems" runat="server" NroCarIni="4"  DisplayText="DESCRIPCION" ValueField="CODIGO" fnOnSelected="onItemSeleccionadoTablaItems" fncTempaleCustom="onDisplayTemplateTablaItems">
                       <EasyStyle Ancho="Dos"></EasyStyle>
                       <DataInterconect MetodoConexion="WebServiceInterno">
                            <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                            <Metodo>Buscar</Metodo>
                            <UrlWebServicieParams>
                                <cc2:EasyFiltroParamURLws  ParamName="IdTabla" Paramvalue="AdministrarTblGeneraltems.GetIdTabla()" ObtenerValor="FunctionScript"/>
                                <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                            </UrlWebServicieParams>
                        </DataInterconect>
                   </cc3:EasyAutocompletar>   
               </td>
           </tr>
           <tr>
               <td colspan="2" style ="width:100%">
                   <div id="container" class="scrollContainer">
                        <cc1:EasyGridView ID="EasyGridViewTblItems" runat="server" AutoGenerateColumns="False" TituloHeader="DETALLE" Width="100%" ToolBarButtonClick="OnEasyGridDetalle_Click" >
                          <EasyGridButtons>
                              <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RequiereSelecciondeReg="false" RunAtServer="False" SolicitaConfirmar="False" Texto="Agregar" Ubicacion="Derecha" />
                              <cc1:EasyGridButton ID="btnEliminar" Descripcion="" Icono="" MsgConfirm="Desea eliminar este registro ahora?" RequiereSelecciondeReg="True" RunAtServer="False" SolicitaConfirmar="True" Texto="Eliminar" Ubicacion="Derecha" />
                          </EasyGridButtons>
                           <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />

                          <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="AdministrarTblGeneraltems.Modificar"></EasyExtended>

                      <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                          <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                          <Columns>
                              <asp:BoundField DataField="DESCRIPCION" HeaderText="DESCRIPCION" >
                              <ItemStyle HorizontalAlign="Left" Width="90%" />
                              </asp:BoundField>
                          </Columns>
                          <HeaderStyle CssClass="HeaderGrilla" Height="25px" />
                          <RowStyle CssClass="ItemGrilla" Height="35px" />
                      </cc1:EasyGridView>
                    </div>
               </td>
           </tr>
       </table>
    </form>
</body>
    <script>

        function OnEasyGridDetalle_Click(btnItem, DetalleBE) {
            var otxtTipoOp = jNet.get('txtTipoOp');

            switch (btnItem.Id) {
                case "btnAgregar":

                    if (EasyAcBuscarTablaItems.GetText().length > 0) {
                        var NroFilIniClone = 3
                        var oRow = EasyGridViewTblItems.RowClone(NroFilIniClone, function (Celda, index) {
                            if (index == 0) {
                                if (jNet.get(Celda.parentNode).attr('TipoRow') != '4') {
                                    Celda.innerText = (EasyGridViewTblItems.GetNroFila() - (NroFilIniClone - 1));
                                }
                            }
                            else if (index == 1) {
                                Celda.innerText = EasyAcBuscarTablaItems.GetText();

                            }
                        });

                        oRow.attr('TipoRow', '2');
                        oData = oRow.GetData();
                        oData["CODIGO"] = 0;
                        oData["DESCRIPCION"] = EasyAcBuscarTablaItems.GetText();
                        oData["ESTADO"] = "1";

                        EasyAcBuscarTablaItems.Clear();
                    }
                    else {
                        var msgConfig = { Titulo: "TABLAS DE APOYO", Descripcion: "Error al intentar crear un ITEM de " };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                    }
                    break;
                    
                    break;
                case "btnEliminar":
                        var oRow = EasyGridViewTblItems.GetRowActive()
                        var oDataRow = oRow.GetData();
                        EasyGridViewTblItems.DeleteRowActive(true);
                    break;
            }
        }

        function onItemSeleccionadoTablaItems(value, ItemBE) {
             
        }

        function onDisplayTemplateTablaItems(ul, item) {
            var cmll = "\""; var iTemplate = null;
                iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '<div class= "flex-column">' + item.DESCRIPCION
                    + '    <p><small style="font-weight: bold">CODIGO:</small> <small style ="color:red">' + item.CODIGO + '</small>'
                    + '</div>'
                    + '</a>';

            var oCustomTemplateBE = new EasyAcBuscarTablaItems.CustomTemplateBE(ul, item, iTemplate);
            return EasyAcBuscarTablaItems.SetCustomTemplate(oCustomTemplateBE);
        }

        AdministrarTblGeneraltems.Detalle = {};
        AdministrarTblGeneraltems.GetIdTabla = function () {
            return AdministrarTblGeneraltems.Params[AdministrarTblGeneraltems.KEYQIDTABLAGENERAL];
        }



        AdministrarTblGeneraltems.ItemplateModificaItem = function (Descripcion) {
            var cmll = "\""; var iTemplate = null;
            iTemplate = '<table border="0" style ="width:300px">'
                + '         <tr><td style ="width:100%"><input id="txtItemdesc" value="' + Descripcion +  ' " style ="width:100%"/> </td></tr>';
                + '     </table>';
            return iTemplate;
        }

        AdministrarTblGeneraltems.Modificar = function () {
            var oRow = EasyGridViewTblItems.GetRowActive()
            //var oDataRow = EasyGridViewTblItems.GetDataRow();
            var oDataRow = oRow.GetData();

            var ConfigMsgb = {
                Titulo: 'MODIFICAR ITEM'
                , Descripcion: AdministrarTblGeneraltems.ItemplateModificaItem(oDataRow["DESCRIPCION"])
                , Icono: 'fa fa-link'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        var txtValDescrib = jNet.get('txtItemdesc');
                        oDataRow["DESCRIPCION"] = txtValDescrib.value;
                        oRow.cells[1].innerText = txtValDescrib.value;
                        //AdministrarTblGeneraltems.Commit(oDataRow);
                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }

        AdministrarTblGeneraltems.onAceptar = function () {
            var Exit = true;
            EasyGridViewTblItems.ItemsforEach(function (orow) {
                var oDataRow = orow.GetData();
                if (oDataRow["Modo"].toString().Equal("N") || oDataRow["Modo"].toString().Equal("E")) {
                    AdministrarTblGeneraltems.Commit(oDataRow);  
                }
            });
            return Exit;
        }

        AdministrarTblGeneraltems.Commit = function (_DataRow) {
            // try {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarTblGeneraltems.KEYQIDTABLAGENERAL, AdministrarTblGeneraltems.Params[AdministrarTblGeneraltems.KEYQIDTABLAGENERAL], TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param(AdministrarTblGeneraltems.KEYQIDITEMTABLAGENERAL, _DataRow["CODIGO"], TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param(AdministrarTblGeneraltems.KEYQDESCRIPCION, _DataRow["DESCRIPCION"]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param(AdministrarTblGeneraltems.KEYQIDESTADO, ((_DataRow["Modo"]=="E")?"0":_DataRow["ESTADO"]), TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('IdUsuario', AdministrarTblGeneraltems.Params['IdUsuario'], TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('UserName', AdministrarTblGeneraltems.Params['UserName']);
            oParamCollections.Add(oParam);

            

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = '/General/TablasGenerales.asmx';
            oEasyDataInterConect.Metodo = 'InsertaModificaTablaItems';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var obj = oEasyDataResult.sendData();

            if (obj != undefined) {
                _DataRow["CODIGO"] = obj;
                Exit = true;
            }
 /*  }
            catch (SIMADataException) {
                var msgConfig = { Titulo: "Error ", Descripcion: SIMADataException.Message };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }*/
            if (AdministrarTblGeneraltems.Params[AdministrarTblGeneraltems.KEYQQUIENLLAMA].toString().Equal("DetalleInspeccion")) {
                eval(DetalleInspeccion.ObjetoSelect);
            }

            return Exit;
        }

    </script>
    

</html>
