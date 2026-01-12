<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleSistema_Proceso.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.DetalleSistema_Proceso" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <table style="width:100%">
             <tr><td id="msgValRqr"> </td></tr>
           <tr>
               <td class="Etiqueta" style="width:100%">
                   TIPO:
               </td>
           </tr>
           <tr>
               <td  style="width:100%" reference="EasyDdLTipo">
                   <cc2:EasyDropdownList ID="EasyDdLTipo" runat="server" CargaInmediata="True" DataTextField="NOMBRE" DataValueField="CODIGO" Width="100%" required></cc2:EasyDropdownList>
               </td>
           </tr>
            <tr>
                 <td class="Etiqueta"  style="width:100%" reference="EasyNombre">
                     NOMBRE:
                 </td>
             </tr>
             <tr>
                 <td style="width:100%">
                     <cc2:EasyTextBox ID="EasyNombre" runat="server" Width="100%" required></cc2:EasyTextBox>
                 </td>
             </tr>
             <tr>
                  <td class="Etiqueta"  reference="EasyDescripcion">
                        DESCRIPCION:
                    </td>
                </tr>
                <tr>
                    <td  style="width:100%">
                        <cc2:EasyTextBox ID="EasyDescripcion" runat="server" Height="80px" TextMode="MultiLine" Width="100%" required></cc2:EasyTextBox>
                    </td>
                </tr>
       </table>
    </form>
</body>
</html>
