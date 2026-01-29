<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleObjetivo.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.DetalleObjetivo" %>

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
                 <td id="msgValRqr"  colspan="2"> </td>                           
             </tr>
            <tr>
                <td class="Etiqueta" style="width:20%" >
                    CODIGO
                </td>
                <td style="width:80%">
                    <cc1:EasyTextBox ID="txtCodigo" runat="server" BackColor="#e6e6e6"  ReadOnly="true" ></cc1:EasyTextBox>
                </td>
            </tr>
            <tr>
                <td class="Etiqueta"  reference="txtNombre">
                    NOMBRE:
                </td>
                <td>
                    <cc1:EasyTextBox ID="txtNombre" TextMode="MultiLine" Height="100px" runat="server" required></cc1:EasyTextBox>
                </td>
            </tr>
            <tr>
                <td class="Etiqueta">
                    DESCRIPCION:
                </td>
                <td>
                    <cc1:EasyTextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Height="100px"></cc1:EasyTextBox>
                </td>
            </tr>

        </table>
    </form>
</body>
</html>
