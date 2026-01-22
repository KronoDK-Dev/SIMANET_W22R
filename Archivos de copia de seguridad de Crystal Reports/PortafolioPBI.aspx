<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PortafolioPBI.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.PortafolioPBI" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>
<%@ Register TagPrefix="uc1" TagName="Header" Src="~/Controles/Header.ascx" %>

<!DOCTYPE html>
    <link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/bootstrap.min.css") %> ">
    <link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/StyleEasy.css") %> ">
    <link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/Personalizado.css") %> ">
    <link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/toastr.min.css") %> ">
    <link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/font-awesome.min.css") %> ">

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Portafolio Power BI</title>
    <style>
        .report-frame {
            border: none;
            width: 100%;
            height: 80vh; /* 80% del alto visible */
            min-height: 500px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.2);
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%;" border="0">
            <!-- Cabecera -->
            <tr>
                <td class="auto-style1">
                    <uc1:Header runat="server" ID="Header" />
                </td>
            </tr>

            <!-- Título -->
            <tr>
                <td>
                    <center>
                        <h1 class="display-6">Portafolio de Proyectos - Dashboard Power BI</h1>
                        <p class="lead mb-0">Visualización interactiva de reportes</p>
                    </center>
                </td>
            </tr>

            <!-- Contenido -->
            <tr>
                <td style="padding:20px;">
                    <asp:Literal ID="ltlIframe" runat="server"></asp:Literal>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>