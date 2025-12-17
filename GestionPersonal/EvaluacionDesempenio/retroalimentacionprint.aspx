<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="retroalimentacionprint.aspx.cs" Inherits="SIMANET_W22R.GestionPersonal.EvaluacionDesempenio.retroalimentacionprint" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc5" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc6"   %>

<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/StyleEasy.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/Personalizado.css") %> ">
<script src="<%= ResolveUrl("~/Recursos/Js/jquery-3.6.4.min.js") %> "></script>
<script src="<%= ResolveUrl("~/Recursos/Js/toastr.min.js") %> "></script>
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/toastr.min.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/sweetalert2.min.css") %> ">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet" /> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%@ Import Namespace="System.IO" %>

<!DOCTYPE html>

<html>
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
     <form id="form1" runat="server" class="container mt-4">
        <div class="card shadow-lg">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Reporte Retroalimentacion</h5>
            </div>
            <div class="card-body">
                <asp:Label ID="lblInfo" runat="server" CssClass="text-muted"></asp:Label>
                <hr />
                <iframe id="framePDF" runat="server" style="width: 100%; height: 600px; border: none;"></iframe>
            </div>
        </div>
    </form>
</body>
</html>
