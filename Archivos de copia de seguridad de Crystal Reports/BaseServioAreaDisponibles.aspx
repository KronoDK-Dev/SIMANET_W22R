<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BaseServioAreaDisponibles.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.ITIL.BaseServioAreaDisponibles" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc1" %>



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
                <td style="width:100%" >
                    <cc2:EasyTabControl ID="EasyTabAreas" runat="server"></cc2:EasyTabControl>
                </td>
            </tr>

        </table>
        
    </form>
</body>
</html>
