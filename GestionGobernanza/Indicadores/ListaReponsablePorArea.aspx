<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaReponsablePorArea.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.ListaReponsablePorArea" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body> 
    <form id="form1" runat="server">
        <table style="width:100%">
            <tr>
                <td>
                    <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="GESTION DE INDICADORES"  ToolBarButtonClick="OnEasyGridButton_Click" Width="100%" fncExecBeforeServer="" OnRowDataBound="EasyGridView1_RowDataBound" >

                            <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                <DataInterconect MetodoConexion="WebServiceExterno">
                                    <UrlWebService></UrlWebService>
                                    <Metodo>RespnsablePorArea_Lst</Metodo>
                                    <UrlWebServicieParams>
                                        <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="CodEmp" Paramvalue="001"  />
                                        <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="CodCeo" Paramvalue="001"  />
                                        <cc2:EasyFiltroParamURLws ObtenerValor="FunctionScript" ParamName="CodArea" Paramvalue="ObtenerCodArea()"/>
                                        <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="UserName" TipodeDato="String"/>
                                    </UrlWebServicieParams>
                                </DataInterconect>

                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="ListaReponsablePorArea.OnNull " RowCellItemClick="ListaReponsablePorArea.OnNull "  idgestorfiltro=""></EasyExtended>

                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                            <Columns>
                                <asp:BoundField HeaderText="FOTO" >
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="NRO DNI" >
                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="APELLIDOS Y NOMBRES" >
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80%" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemStyle Width="3%" />
                                </asp:TemplateField>
                            </Columns>

                          <HeaderStyle CssClass="HeaderGrilla" />
                          <PagerStyle HorizontalAlign="Center" />
                          <RowStyle CssClass="ItemGrilla" Height="25px" />

                    </cc1:EasyGridView>
                </td>
            </tr>
        </table>   
    </form>

    <script>
        ListaReponsablePorArea.OnNull = function () {
        } 
        ListaReponsablePorArea.Eliminar = function (e) {

            var ConfigMsgb = {
                Titulo: 'RESPONSABLE DE AREA'
                , Descripcion: "Desea eliminar el registro de responsable de esta area ahora?"
                , Icono: 'fa fa-question-circle'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {

                        try {
                            var DataRowBE = EasyGridView1.GetDataRow();
                            AdministrarResponsablePorArea.EliminarResponsable(DataRowBE.IDTBL, DataRowBE.IDITEM);
                            AdministrarResponsablePorArea.ListarResponsables();
                        }
                        catch (SIMADataException) {
                            var msgConfig = { Titulo: "Error al Eliminar Responsable", Descripcion: SIMADataException.Message };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();
                        }

                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }
    </script>
</body>
</html>
