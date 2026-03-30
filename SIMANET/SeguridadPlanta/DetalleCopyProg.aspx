<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleCopyProg.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.DetalleCopyProg" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>




<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
   
</head>
<body>
    <form id="form1" runat="server">
      <table border="0">
          <tr>
              <td class="Etiqueta">
                  NRO PROGRAMACION:
              </td>
              <td  colspan="4" id ="cellNroProg" runat="server" class="Etiqueta">

              </td>
          </tr>

          <tr style="height:45px">
              <td class="Etiqueta">
                  CONTRATISTA:
              </td>
              <td  colspan="4" id ="cellRSocial" class="Etiqueta" runat="server">

              </td>
          </tr>
          <tr>
              <td>

              </td>
              <td colspan="2" class="Etiqueta">
                  INICIO
              </td>
              <td colspan="2" class="Etiqueta">
                  TERMINO/TOLERANCIA
              </td>
          </tr>
          <tr>
              <td class="Etiqueta">FECHA</td>
              <td  reference="CFIni"></td>
              <td>
                  <cc1:EasyDatepicker ID="CFIni" runat="server" required></cc1:EasyDatepicker></td>
              <td reference="CFFin"></td>
              <td>
                  <cc1:EasyDatepicker ID="CFFin" runat="server" required></cc1:EasyDatepicker></td>
          </tr>
           <tr>
             <td class="Etiqueta">HORA:</td>
             <td reference="CTimeIni"></td>
             <td>
                 <cc1:EasyTimePicker ID="CTimeIni" runat="server" required />
             </td>
             <td reference="CTimeFin"></td>
             <td>
                 <cc1:EasyTimePicker ID="CTimeFin" runat="server" required />
             </td>
         </tr>
      </table>
    </form>
    <script>

       DetalleCopyProg.Aceptar = function () {
           EasyPopupCopiar.Arguments = "{FechaIni:'" + CFIni.GetValue() + "',FechaFin:'" + CFFin.GetValue() + "',HoraIni:'" + CTimeIni.GetValue() + "',HoraFin:'" + CTimeFin + "'}";
           return true;
        }
    </script>
</body>
</html>

