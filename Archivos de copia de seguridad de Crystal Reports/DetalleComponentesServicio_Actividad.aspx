<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleComponentesServicio_Actividad.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Servicios.DetalleComponentesServicio_Actividad" %>
<%@ Register TagPrefix="cc2" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc1" Namespace="EasyControlWeb" Assembly="EasyControlWeb" %>

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
                <Metodo>ListarActvXServicio</Metodo>
                <UrlWebServicieParams>
                </UrlWebServicieParams>
            </DataInterconect>

            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
        
            <AlternatingRowStyle CssClass="AlternateItemGrilla" />

            <Columns>
                <asp:BoundField DataField="ID_ACTIVIDAD" HeaderText="ID" />
                <asp:BoundField DataField="NOMBRE" HeaderText="NOMBRE" />
            </Columns>

            <HeaderStyle CssClass="HeaderGrilla" />
            <PagerStyle HorizontalAlign="Center" />
            <RowStyle CssClass="ItemGrilla" Height="25px" />

        </cc1:EasyGridView>
    </form>
</body>
</html>
