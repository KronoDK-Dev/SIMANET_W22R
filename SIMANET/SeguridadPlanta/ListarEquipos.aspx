<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarEquipos.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.ListarEquipos" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%">
            <tr>
                <td>
                    <cc1:EasyGridView ID="grvEquipos" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="LISTA DE EQUIPOS"   Width="100%"  fncExecBeforeServer="" ToolBarButtonClick="OnEasyGridButtonEquipo_Click" OnRowDataBound="grvEquipos_RowDataBound" >
                                 <EasyGridButtons>
                                     <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="False" Texto="Agregar" Ubicacion="Derecha" />
                                 </EasyGridButtons>
                               <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                <DataInterconect MetodoConexion="WebServiceExterno">
                                    <Metodo></Metodo>
                                    <UrlWebServicieParams>
                                        <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="UserName" TipodeDato="String"/>
                                    </UrlWebServicieParams>
                                </DataInterconect>

                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" idgestorfiltro="" RowItemClick="ListarEquipos.GridCellOnClick"></EasyExtended>

                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                            <Columns>
                                <asp:BoundField HeaderText="CODIGO" DataField="Codigo" >
                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="DESCRIPCION" DataField="Descripcion" >
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Cantidad" HeaderText="CANTIDAD">
                                <ItemStyle Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="IN/OUT" DataField="NombreTipoIngreso" >
                                <ItemStyle Width="5%" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemStyle Width="2%" />
                                </asp:TemplateField>
                            </Columns>

                          <HeaderStyle CssClass="HeaderGrilla" />
                          <PagerStyle HorizontalAlign="Center" />
                          <RowStyle CssClass="ItemGrilla" Height="25px" />

                    </cc1:EasyGridView>
                </td>
            </tr>
        </table>    
        <script>
            var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleEquipos.aspx";
            function OnEasyGridButtonEquipo_Click(btnItem, DetalleBE) {
                switch (btnItem.Id) {
                    case "btnAgregar":
                        var oColletionParams = new SIMA.ParamCollections();
                        var oParam = new SIMA.Param(ListarEquipos.KEYQIDPROGRAMACION, ListarEquipos.Params[ListarEquipos.KEYQIDPROGRAMACION]);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(ListarEquipos.KEYQAÑO, ListarEquipos.Params[ListarEquipos.KEYQAÑO]);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(ListarEquipos.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                        oColletionParams.Add(oParam);

                        EasyPopupEquipoDet.Load(Url, oColletionParams, false);
                        
                        break;
                }
            }

            ListarEquipos.GridCellOnClick = function (oCell, oDataBE) {
                switch (oCell.cellIndex) {
                    case 0:
                        ListarEquipos.Detalle(oDataBE.NroItem);
                        break;
                }
            }
            //
            ListarEquipos.Detalle = function (IdEquipo) {
                var oColletionParams = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(ListarEquipos.KEYQIDPROGRAMACION, ListarEquipos.Params[ListarEquipos.KEYQIDPROGRAMACION]);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(ListarEquipos.KEYQAÑO, ListarEquipos.Params[ListarEquipos.KEYQAÑO]);
                oColletionParams.Add(oParam);
                
                oParam = new SIMA.Param(ListarEquipos.KEYQIDEQUIPO, IdEquipo);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(ListarEquipos.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
                oColletionParams.Add(oParam);

                EasyPopupEquipoDet.Load(Url, oColletionParams, false);

            }

            ListarEquipos.Eliminar = function (e) {
                var ConfigMsgb = {
                    Titulo: 'EQUIPO'
                    , Descripcion: "Desea eliminar el registro seleccionado ahora?"
                    , Icono: 'fa fa-question-circle'
                    , EventHandle: function (btn) {
                        if (btn == 'OK') {

                            try {
                                var DataRowBE = grvEquipos.GetDataRow();
                                ListarEquipos.Data.Eliminar(DataRowBE.Periodo, DataRowBE.NroProgramacion,DataRowBE.NroItem);
                                grvEquipos.DeleteRowActive(false);
                            }
                            catch (SIMADataException) {
                                var msgConfig = { Titulo: "Error al Eliminar", Descripcion: SIMADataException.Message };
                                var oMsg = new SIMA.MessageBox(msgConfig);
                                oMsg.Alert();
                            }

                        }
                    }
                };
                var oMsg = new SIMA.MessageBox(ConfigMsgb);
                oMsg.confirm();
                
            }
            ListarEquipos.Data = {};

            ListarEquipos.Data.Eliminar = function (Periodo, IdProgramacion, IdItem) { 
               
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
                oEasyDataInterConect.Metodo = "ContratistaEquipos_Del";

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("Periodo", Periodo, TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdProgramacion", IdProgramacion, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                oParam = new SIMA.Param("NroItem", IdItem, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var ResultBE = oEasyDataResult.sendData();
            }
        </script>
    </form>
</body>
</html>
