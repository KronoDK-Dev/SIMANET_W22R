<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleRqrServicio.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.ITIL.DetalleRqrServicio" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

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
                        REQUERIMIENTO
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyTextBox ID="EasyTxtRqr" runat="server" TextMode="MultiLine" placeholder="Escribe un mensaje aquí..." style="border-width:1px;  border-style: dotted;border-color: gray;" Width="100%"></cc1:EasyTextBox>

                </td>
            </tr>
            <tr>
                <td>Aprobadores</td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyListAutocompletar ID="EasyListAprobadores" runat="server" > </cc1:EasyListAutocompletar>
                </td>
            </tr>
            <tr>
                <td>
                    Adjunto
                </td>
            </tr>

        </table>
    </form>
</body>
</html>
