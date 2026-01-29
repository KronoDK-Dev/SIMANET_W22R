<%@ Page  Language="C#"  AutoEventWireup="true" CodeBehind="Retroalimentacion.aspx.cs" Inherits="SIMANET_W22R.GestionPersonal.EvaluacionDesempenio.FormRetroalimentacion" %>


<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc5" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc6" %>
    

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Evaluación de Desempeño</title>

    <!-- CSS propios de esta página -->
    <!-- CSS que falta -->
  <!--  <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/StyleEasy.css" />
    <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/Personalizado.css" />
     <link rel="stylesheet" href="/SIMANET_W22R/Recursos/css/bootstrap.min.css" />  -->
     <link id="cssPersonalizado" rel="stylesheet" />
    <script>
        window.addEventListener('DOMContentLoaded', function () {
            document.getElementById("cssPersonalizado").href = getBasePath() + "/Recursos/css/Personalizado.css";
        });
    </script>


    <link id="cssBootstrap" rel="stylesheet" />
    <script>  <!-- le adicionamos su referencia al control LINK -->
    window.addEventListener('DOMContentLoaded', function () {
        document.getElementById("cssBootstrap").href = getBasePath() + "/Recursos/css/bootstrap.min.css";
    });
    </script>  

    <!-- JS que falta -->
  <!--  <script src="/SIMANET_W22R/Recursos/js/jquery-3.6.4.min.js"> </script>
    <script src="/SIMANET_W22R/Recursos/js/bootstrap.bundle.min.js"></script>  -->

    <script id="scriptJquery364"></script>
    <script id="scriptBootstrapB"></script>

    <script>
        window.addEventListener('DOMContentLoaded', function () {
            document.getElementById("scriptJquery364").src = getBasePath() + "/Recursos/js/jquery-3.6.4.min.js";
        });
            window.addEventListener('DOMContentLoaded', function () {
                document.getElementById("scriptBootstrapB").src = getBasePath() + "/Recursos/js/bootstrap.bundle.min.js";
            });
    </script>

    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 15px;
        }

        .form-label {
            font-weight: 500;
        }

        .table thead {
            background-color: #dee2e6;
        }

        .section-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: #343a40;
        }

        .centrado-gridview {
            border-collapse: collapse;
            width: 100%;
        }

            .centrado-gridview td,
            .centrado-gridview th {
                border: 1px solid #ccc;
                padding: 8px;
            }

            .centrado-gridview th {
                background-color: #f2f2f2;
            }

        .centrado-dropdown {
            text-align: center;
            text-align-last: center;
        }

        .auto-style1 {
            padding: 1px 4px;
            height: 32px;
            text-align: center;
            color: #FFFFFF;
            background-color: #0D6EFD;
            border-left-color: #A0A0A0;
            border-left-width: 1px;
            border-right-width: 1px;
            border-top-color: #A0A0A0;
            border-top-width: 1px;
            border-bottom-width: 1px;
        }

        .auto-style2 {
            height: 32px;
            width: 205px;
            text-align: center;
            color: #FFFFFF;
            background-color: #0D6EFD;
        }

        .auto-style4 {
            width: 549px;
            font-size: large;
        }

        .auto-style5 {
            padding: 1px 4px;
            height: 32px;
            width: 205px;
            text-align: center;
            color: #FFFFFF;
            background-color: #0D6EFD;
            border-left-color: #A0A0A0;
            border-left-width: 1px;
            border-right-width: 1px;
            border-top-color: #A0A0A0;
            border-top-width: 1px;
            border-bottom-width: 1px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <!-- Header común (control user) -->
       <uc1:Header ID="Header1" runat="server" />


    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <%-- <div class="container py-5">--%>

            <div class="text-center mb-0">
                <p class="section-title mb-0">REPORTE DE RESULTADOS Y RETROALIMENTACION DE LA EVALUACIÓN DE DESEMPEÑO</p>
                <%--<p class="section-title mb-0">SECCIÓN: DATOS GENERALES</p>--%>
            </div>
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <i class="bi bi-person-badge-fill me-2"></i>DATOS DEL EVALUADOR
                </div>
                <div class="card-body">
                    <div class="row g-4 align-items-end">
                        <div class="col-md-6">
                            <label class="form-label">Nro. DNI:</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" placeholder="Nombre del Evaluador" MaxLength="8" TextMode="Number"></asp:TextBox>
                                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" CssClass="btn btn-outline-primary btn-sm rounded-pill px-3 shadow-sm" />
                                <asp:Button ID="btnNuevo" runat="server" Text="Limpiar" OnClick="btnNuevo_Click" CssClass="btn btn-outline-primary btn-sm rounded-pill px-3 shadow-sm" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Nombres y Apellidos:</label>
                            <asp:TextBox ID="txtNombresyApellidos" runat="server" CssClass="form-control" placeholder="Nombres y Apellidos" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Cargo</label>
                            <asp:TextBox ID="txtCargo" runat="server" CssClass="form-control" placeholder="Cargo" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Area:</label>
                            <asp:TextBox ID="txtArea" runat="server" CssClass="form-control" placeholder="Area" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Categoria</label>
                            <asp:TextBox ID="txtCategoria" runat="server" CssClass="form-control" placeholder="Categoria" ReadOnly="true"></asp:TextBox>
                        </div>

                    </div>
                </div>
            </div>

            <div class="card shadow-sm mb-4">
                <div class="card-header bg-secondary text-white">
                    <i class="bi bi-people-fill me-2"></i>Lista de Trabajadores Evaluados
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="gvRetroalimentacionEvaluados" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="centrado-gridview"
                            SelectedRowStyle-BackColor="#D9EDF7" SelectedRowStyle-ForeColor="Black"
                            HeaderStyle-HorizontalAlign="Center" OnSelectedIndexChanged="gvRetroalimentacionEvaluados_SelectedIndexChanged">
                            <Columns>
                                <asp:TemplateField HeaderText="N°">
                                    <HeaderStyle Width="10px" />
                                    <ItemStyle Width="10px" />
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="PR" HeaderText="PR" />
                                <asp:TemplateField HeaderText="DNI Evaluado">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDNI" runat="server" CommandName="Select" Text='<%# Eval("DNI_Evaluado") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="CO" HeaderText="CO" />
                                <asp:BoundField DataField="NombresyApellidos" HeaderText="Nombre del Evaluado" />
                                <asp:BoundField DataField="Cargo_Estructural" HeaderText="Cargo Estructural" />
                                 <asp:TemplateField HeaderText="Ver">
                                    <ItemTemplate>
                                        <a href='<%# "retroalimentacionprint.aspx?dni=" + Eval("DNI_Evaluado") %>' 
                                           class="text-danger" target="_blank">
                                            <i class="bi bi-file-earmark-pdf-fill"></i>Ver
                                        </a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <div class="text-center mb-0">
                <p class="section-title mb-0">SECCIÓN: RESULTADOS DE LA EVALUACIÓN DE DESEMPEÑO POR COMPETENCIAS</p>
            </div>
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="gvResultadoCompetencias" runat="server" AutoGenerateColumns="False" GridLines="None"
                            CssClass="centrado-gridview" ShowHeader="true" ShowHeaderWhenEmpty="true" HeaderStyle-HorizontalAlign="Center">
                            <Columns>
                                <asp:TemplateField HeaderText="N°">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Evaluacion_Competencia" HeaderText="Competencia" />
                               
                                <asp:TemplateField HeaderText="Calificación del Evaluador">
                                    <ItemTemplate>
                                        <%# Eval("ResultadoPuntuacion") %>
                                        <asp:Label ID="Label1" runat="server" Text="%" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Esperado" HeaderText="Esperado" />
                                <asp:BoundField DataField="Promedio" HeaderText="Promedio" />

                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>


            <div class="text-center mb-0">
                <p class="section-title mb-0">SECCIÓN: RESULTADOS DE LA EVALUACIÓN POR OBJETIVOS INDIVIDUALES DE DESEMPEÑO</p>
            </div>
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="gvResultadosObjetivos" runat="server" AutoGenerateColumns="False" GridLines="None"
                            CssClass="centrado-gridview" ShowHeader="true" ShowHeaderWhenEmpty="true" HeaderStyle-HorizontalAlign="Center">
                            <Columns>
                                <asp:TemplateField HeaderText="N°">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Objetivos">
                                    <ItemTemplate>
                                        <%# Eval("evaluacion_objetivos") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Calificación del Evaluador">
                                    <ItemTemplate>
                                        <%# Eval("Puntuacion") %>
                                        <asp:Label ID="Label1" runat="server" Text="%" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Ponderado" HeaderText="Ponderado" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <div>
                <table class="w-100" border="1">
                    <tr>
                        <td rowspan="2" class="auto-style4"><strong>RESULTADO EVALUACIÓN DE DESEMPEÑO</strong></td>
                        <td class="auto-style5">Resultado</td>

                    </tr>
                    <tr>
                        <td class="text-center" width="10%">
                            <asp:TextBox ID="txtresultado" runat="server" placeholder="Resultado" Text='' CssClass="form-control" />
                        </td>

                    </tr>
                </table>
            </div>
            <br />


            <div class="text-center mb-0">
                <p class="section-title mb-0">SECCIÓN: IDENTIFICACIÓN DE FORTALEZAS Y OPORTUNIDADES DE MEJORA</p>
            </div>

            <div class="text-center mb-0" style="width: 100%;">
                <tr>
                    <td style="width: 100%;">Fortalezas</td>
                </tr>
                <tr>
                    <td style="width: 100%;">
                        <asp:TextBox ID="txtFortalezas" runat="server"
                            placeholder="Fortalezas"
                            TextMode="MultiLine"
                            Rows="2"
                            CssClass="form-control"
                            Style="width: 100%; min-width: 1000px;" />
                    </td>
                </tr>
            </div>


            <div class="text-center mb-0" style="width: 100%;">
                <tr>
                    <td style="width: 100%;">Oportunidades de Mejora</td>
                </tr>
                <tr>
                    <td style="width: 100%;">
                        <asp:TextBox ID="txtOportunidadesMejora" runat="server"
                            placeholder="Oportunidades de Mejora"
                            TextMode="MultiLine"
                            Rows="2"
                            CssClass="form-control"
                            Style="width: 100%; min-width: 1000px;" />
                    </td>
                </tr>
            </div>


            <div class="text-center mb-0" style="width: 100%;">
                <tr>
                    <td style="width: 100%;">Observaciones</td>
                </tr>
                <tr>
                    <td style="width: 100%;">
                        <asp:TextBox ID="txtObservaciones" runat="server"
                            placeholder="Observaciones"
                            TextMode="MultiLine"
                            Rows="2"
                            CssClass="form-control"
                            Style="width: 100%; min-width: 1000px;" />
                    </td>
                </tr>
            </div>
             <br />
            <div class="text-center mb-0">
                <asp:Button ID="btngrabar" runat="server" CssClass="btn btn-outline-primary" Text="Grabar"
                    OnClick="btngrabar_Click" />
            </div>
          


            <%--</div>--%>
        </ContentTemplate>
    </asp:UpdatePanel>

  </form>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var chartData = <%= chartDataJson %>;

        if (chartData.length > 0) {
            var ctx = document.getElementById('chartCompetencias').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: chartData.map(x => x.Competencia),
                    datasets: [{
                        label: 'Resultado (%)',
                        data: chartData.map(x => x.Resultado),
                        backgroundColor: 'rgba(54, 162, 235, 0.6)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: false }
                    },
                    scales: {
                        y: { beginAtZero: true, max: 100 }
                    }
                }
            });
        }
    });
    </script>
</body>
</html>

