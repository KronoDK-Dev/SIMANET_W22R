<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleComponentesServicio.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Servicios.DetalleComponentesServicio" %>
<%@ Register TagPrefix="cc1" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <cc1:EasyTabControl ID="EasyTabControlServicio" runat="server" fncTabOnClick="TabClick"></cc1:EasyTabControl>
    </form>
</body>
</html>
