<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleRespuestaResponsableArea.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.DetalleRespuestaResponsableArea" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
</head>
<body>
    <form id="form1" runat="server">
       <table >
           <tr>
               <td class="Etiqueta">
                   FECHA DE:</td>
               <td colspan="5" style="border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #808080;">
                   &nbsp;</td>
               
           </tr>
           <tr>
               <td class="Etiqueta">
                   RESPUESTA</td>
               <td>
                   <cc1:EasyTextBox ID="txtFechaRpt" runat="server" ReadOnly="True"></cc1:EasyTextBox>
               </td>
               <td class="Etiqueta">
                   ENVIO</td>
               <td>
                    <cc1:EasyTextBox ID="txtFechaEnvio" runat="server" ReadOnly="True"></cc1:EasyTextBox>
               </td>
               <td class="Etiqueta">
                   LECTURA
               </td>
               <td>
                    <cc1:EasyTextBox ID="txtFechaLectura" runat="server" ReadOnly="True"></cc1:EasyTextBox>
               </td>

           </tr>
           <tr>
               <td class="Etiqueta" colspan="6">
                   ANOTACION
               </td>
           </tr>
           <tr>
               <td colspan="6">
                    <cc1:EasyTextBox ID="txtAnotacion" TextMode="MultiLine" runat="server" Height="100px" Width="100%"></cc1:EasyTextBox>
               </td>
           </tr>
         
           <tr>
               <td colspan="6">
                    <table >
                        <tr>
                            <td class="Etiqueta" colspan="2">ESTADO:</td>

                        </tr>
                        <tr>
                            <td>
                                <asp:Image ID="ImgEstadoAct" runat="server" Height="35px" Width="35px" />
                            </td>
                            <td style="width: 95%; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #808080;">
                                <asp:Label ID="lblEstado" runat="server" Text="..."></asp:Label>
                            </td>
                        </tr>
                    </table>
               </td>
           </tr>
         
         </table>
    </form>
</body>
</html>
