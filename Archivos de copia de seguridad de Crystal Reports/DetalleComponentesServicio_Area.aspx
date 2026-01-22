<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleComponentesServicio_Area.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Servicios.DetalleComponentesServicio_Area" %>
<%@ Register TagPrefix="cc2" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc3" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc1" Namespace="EasyControlWeb" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc2" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns ="False">
            <EasyStyleBtn />
            <DataInterconect MetodoConexion="WebServiceExterno">
                <UrlWebService></UrlWebService>
                <Metodo>ListarAreasXServicio</Metodo>
                <UrlWebServicieParams>
                </UrlWebServicieParams>
            </DataInterconect>

            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                
            <AlternatingRowStyle CssClass="AlternateItemGrilla" />

            <Columns>
                <asp:BoundField DataField="ID_SERV_AREA" HeaderText="ID" />
                <asp:BoundField DataField="NOM_AUS" HeaderText="AREA" />
            </Columns>

            <HeaderStyle CssClass="HeaderGrilla" />
            <PagerStyle HorizontalAlign="Center" />
            <RowStyle CssClass="ItemGrilla" Height="25px" />

        </cc1:EasyGridView>
        
    </form>
</body>
</html>
