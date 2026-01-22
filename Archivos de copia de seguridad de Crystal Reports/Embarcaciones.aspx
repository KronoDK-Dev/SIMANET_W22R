<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Embarcaciones.aspx.cs" Inherits="SIMANET_W22R.GestionComercial.Administracion.Embarcaciones" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<!-- ************ REFERENCIAS A ESTILOS *************+**** -->
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
        <table style="width: 100%" border="0">
            <tr id="tblReport" border="0px">
                <td colspan="5">
                    <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" />
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
                    <cc1:EasyGridView ID="GrillaEmbarcaciones" runat="server" CssClass="STgridview"
                        AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Embarcaciones" Width="100%"
                        ToolBarButtonClick="OnEasyGridButton_Click"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="EasyGridView1_PageIndexChanged"
                        OnEasyGridDetalle_Click="GrillaEmbarcaciones_EasyGridDetalle_Click"
                        OnEasyGridButton_Click="GrillaEmbarcaciones_EasyGridButton_Click">

                        <EasyGridButtons>
                            <cc1:EasyGridButton Id="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Texto="Agregar" Ubicacion="Izquierda" />
                        </EasyGridButtons>
                        <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                        <DataInterconect MetodoConexion="WebServiceInterno">
                            <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                            <Metodo>ObtenerEmbarcaciones</Metodo>
                            <UrlWebServicieParams>
                                <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_FILTRO" Paramvalue="etbCriterio" TipodeDato="String" />
                            </UrlWebServicieParams>
                        </DataInterconect>

                        <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>

                        <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                        <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                        <Columns>
                            <asp:BoundField DataField="V_EMBARCACION_ID" HeaderText="Embarcacion" />
                            <asp:BoundField DataField="NOM_UND" HeaderText="Nombre de embarcacion" />
                            <asp:BoundField DataField="NOMBREANTERIOR" HeaderText="Nombre anterior" />
                            <asp:BoundField DataField="NOM_APS" HeaderText="Razon social" />
                            <asp:BoundField DataField="EST_ATL" HeaderText="Estado" />
                            <asp:BoundField DataField="MATRICULA" HeaderText="Matricula" />
                            <asp:BoundField DataField="TIP_UND" HeaderText="Tipo" />
                            <asp:BoundField DataField="ESLORA" HeaderText="Eslora" />
                            <asp:BoundField DataField="ASTILLERO_CONSTRUCTOR" HeaderText="Astillero Constructor" />

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
</body>

<script>
    function checkEnter(event) {
        if (event.keyCode === 13) { // 13 es el código de la tecla Enter
            document.getElementById('<%= btnBuscar.ClientID %>').click();
            event.preventDefault(); // Evita que el Enter genere un salto de línea
        }
    }
</script>
</html>
