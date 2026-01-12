<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarInformeMetaPorArea.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.AdministrarInformeMetaPorArea" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

          <table id="tblServicios" style="width:100%;height:100%"  border="0" >
             <tr>
                 <td>
                     <uc1:Header runat="server" ID="Header" />
                </td>
             </tr>
             <tr>
                 <td style="width:100%; height:100%">
                        <cc3:EasyTabControl ID="EasyTabMetas" runat="server" fncTabOnClick="AdministrarInformeMetaPorArea.TabOnSelectedd" Ubicacion="Top"></cc3:EasyTabControl>               
                 </td>
             </tr>
        </table>


        
    </form>

    <script>
        AdministrarInformeMetaPorArea.TabOnSelected = function (oTabSelect) {
        }
    </script>
    

</body>
</html>
