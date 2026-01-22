<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="SIMANET_W22R.GestionComercial.Administracion.Clientes" %>

<%@ Register TagPrefix="cc1" Namespace="EasyControlWeb" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="uc1" TagName="Header" Src="~/Controles/Header.ascx" %>
<%@ Register TagPrefix="cc3" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc2" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>

<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/StyleEasy.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/Personalizado.css") %> ">

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%; height: 100%">
            <tr id="tblReport" border="0px">
                <td colspan="5">
                    <uc1:Header runat="server" ID="header" IdGestorFiltro="EasyGestorFiltro1" />
                </td>
            </tr>

            <tr>
                <td width="20px"></td>
                <td width="10%">
                    <asp:Label ID="lblbusqueda" runat="server" Text="Criterio Búsqueda: "></asp:Label>
                </td>
                <td width="45%">
                    <cc3:EasyTextBox ID="etbCriterio" runat="server" onkeydown="checkEnter(event)" Width="50%" Style="display: inline-block;"></cc3:EasyTextBox>
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="button-celeste" Icono="fa fa-search"
                        OnClick="btnBuscar_Click" />
                </td>
                <td></td>
                <td width="20px"></td>
            </tr>
            <tr>
                <td width="20px"></td>
                <td colspan="3">
                    <cc1:EasyGridView ID="GrillaClientes" runat="server" CssClass="STgridview"
                        AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Clientes"
                        ToolBarButtonClick="OnEasyGridButton_Click" Width="100%"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="EasyGridView1_PageIndexChanged"
                        OnEasyGridDetalle_Click="GrillaClientes_EasyGridDetalle_Click"
                        OnEasyGridButton_Click="GrillaClientes_EasyGridButton_Click"
                        OnSelectedIndexChanged="GrillaClientes_CambiaRegistro" OnRowDataBound="GrillaClientes_RowDataBound">

                        <EasyGridButtons>
                            <cc1:EasyGridButton Id="btnAgregar" Descripcion="Crea un nuevo Cliente" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Texto="Agregar" Ubicacion="Izquierda" />
                            <cc1:EasyGridButton Id="btnEmbarcaciones" Descripcion="Lista Embarcaciones del Cliente" Icono="fa fa-ship" MsgConfirm="" RunAtServer="True" Texto="Embarcaciones/Unidades/Proyectos" Ubicacion="Izquierda" />
                        </EasyGridButtons>
                        <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                        <DataInterconect MetodoConexion="WebServiceInterno">
                            <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                            <Metodo>ListarClientes</Metodo>
                            <UrlWebServicieParams>
                                <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="N_OPCION" Paramvalue="2" TipodeDato="String" />
                                <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_FILTRO" Paramvalue="etbCriterio" TipodeDato="String" />
                                <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="V_CEO" Paramvalue="" TipodeDato="String" />
                                <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="V_UND_OPER" Paramvalue="" TipodeDato="String" />
                                <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                            </UrlWebServicieParams>
                        </DataInterconect>

                        <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>

                        <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                        <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                        <Columns>
                            <asp:BoundField DataField="RUC_DOC_IDEN" HeaderText="RUC" />
                            <asp:BoundField DataField="DOC_IDENTIFICACION" HeaderText="DOC IDENTIFICACION" />
                            <asp:BoundField DataField="PAIS" HeaderText="PAIS" />
                            <asp:BoundField DataField="RAZON_SOCIAL" HeaderText="RAZON SOCIAL" />
                            <asp:BoundField DataField="TIPO_CLI" HeaderText="TIPO CLI" />
                            <asp:BoundField DataField="REPRESENTANTE_LEGAL" HeaderText="REPRESENTANTE LEGAL" />
                            <asp:BoundField DataField="TELEFONO" HeaderText="TELEFONO" />
                            <asp:BoundField DataField="cod_unisys" HeaderText="COD UNISYS" />
                            <asp:BoundField DataField="cod_comercialh" HeaderText="COD COMERCIALCH" />
                            <asp:BoundField DataField="FECHA_REG" HeaderText="FECHA REG" />
                            <asp:BoundField DataField="ACTIVO" HeaderText="ESTADO" />

                        </Columns>

                        <HeaderStyle CssClass="HeaderGrilla" />
                        <PagerStyle HorizontalAlign="Center" />
                        <RowStyle CssClass="ItemGrilla" Height="25px" />

                    </cc1:EasyGridView>
                </td>
                <td width="20px"></td>
            </tr>
        </table>
    </form>
    <script type="text/javascript">
        function checkEnter(event) {
            if (event.keyCode === 13) { // 13 es el código de la tecla Enter
                document.getElementById('<%= btnBuscar.ClientID %>').click();
                event.preventDefault(); // Evita que el Enter genere un salto de línea
            }
        }

    </script>
</body>
</html>
