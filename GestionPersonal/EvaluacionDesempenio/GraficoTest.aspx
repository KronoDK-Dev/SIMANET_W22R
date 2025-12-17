<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GraficoTest.aspx.cs" Inherits="SIMANET_W22R.GestionPersonal.EvaluacionDesempenio.GraficoTest" %>

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


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>


    <body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm1" runat="server" />

        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvDatos" runat="server" AutoGenerateColumns="false"
                    OnSelectedIndexChanged="gvDatos_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Puntaje" HeaderText="Puntaje" />
                        <asp:CommandField ShowSelectButton="true" />
                    </Columns>
                </asp:GridView>

                <br />
                <canvas id="graficoCompetencias" width="600" height="300"></canvas>
            </ContentTemplate>
        </asp:UpdatePanel>

        <!-- SCRIPT FUERA del UpdatePanel -->
        <script type="text/javascript">
            function drawCompetenciasChart(chartData) {
                console.log("drawCompetenciasChart, datos:", chartData);
                if (!chartData || chartData.length === 0) {
                    console.warn("No hay datos para pintar.");
                    return;
                }
                if (typeof Chart === 'undefined') {
                    console.error("Chart.js no cargado.");
                    return;
                }

                var canvas = document.getElementById('graficoCompetencias');
                if (!canvas) {
                    console.error("Canvas NO encontrado.");
                    return;
                }

                var ctx = canvas.getContext('2d');
                if (window.myCompetenciasChart) {
                    window.myCompetenciasChart.destroy();
                }

                window.myCompetenciasChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: chartData.map(c => c.Competencia),
                        datasets: [{
                            label: 'Resultado',
                            data: chartData.map(c => c.Resultado),
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: { y: { beginAtZero: true } }
                    }
                });
            }
        </script>
    </form>
</body>


</html>
