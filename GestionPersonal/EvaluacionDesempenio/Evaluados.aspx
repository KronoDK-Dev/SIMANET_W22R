<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Evaluados.aspx.cs" Inherits="SIMANET_W22R.GestionPersonal.EvaluacionDesempenio.Evaluados" %>

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

    <!-- CSS propios -->
    <!--
    <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/StyleEasy.css" />
    <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/Personalizado.css" />
    -->
    
    <!-- Bootstrap CSS -->    <!--    estilo para downdroplist bootstrap 4: form-control  para bootsrap 5: form-select -->
   <!-- <link rel="stylesheet" href="/SIMANET_W22R/Recursos/css/bootstrap.min.css" /> -->

    <!--  la funcion getBasePath()  esta en el:Header.ascx -->

    <link id="cssPersonalizado" rel="stylesheet" />
    <script>
        window.addEventListener('DOMContentLoaded', function () {
            console.log(getBasePath());
            document.getElementById("cssPersonalizado").href = getBasePath() + "/Recursos/css/Personalizado.css";
        });
    </script>


    <link id="cssBootstrap" rel="stylesheet" />
    <!-- le adicionamos su referencia al control LINK -->
    <script>  
        window.addEventListener('DOMContentLoaded', function () {
            document.getElementById("cssBootstrap").href = getBasePath() + "/Recursos/css/bootstrap.min.css";
        });
    </script>    

    <!-- Bootstrap JS -->
   <!-- <script src="/SIMANET_W22R/Recursos/js/bootstrap.bundle.min.js" defer></script> -->
  
    
    <script id="scriptBootstrapB"></script>
    <script>
        window.addEventListener('DOMContentLoaded', function () {
            document.getElementById("scriptBootstrapB").src = getBasePath() + "/Recursos/js/bootstrap.bundle.min.js";
        });
    </script>



    <!-- DataTables CSS -->
  <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet" />

    <!-- DataTables -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js" defer></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js" defer></script>

    <!-- Inicialización DataTables -->
    <script defer>
        document.addEventListener("DOMContentLoaded", function () {
            function inicializarDataTable() {
                $("#tablaEvaluados").DataTable({
                    destroy: true,
                    language: {
                        url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
                    },
                    pageLength: 5,
                    lengthMenu: [5, 10, 25, 50],
                    responsive: true,
                    columnDefs: [
                        { className: "text-center", targets: 0 }
                    ]
                });
            }

            inicializarDataTable();

            if (typeof Sys !== "undefined" && Sys.WebForms) {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                    inicializarDataTable();
                });
            }
        });
    </script>

    <style>
        body { background-color: #f8f9fa; }
        .card { border-radius: 15px; }
        .table thead { background-color: #343a40; color: #fff; }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Header común (menú personalizado) -->
        <uc1:Header ID="Header1" runat="server" />

        <!-- ScriptManager -->
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="container mt-4">
                    
                    <!-- Filtro por Año -->
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <label for="ddlAnio" class="form-label">Filtrar por Año:</label>
                            <asp:DropDownList ID="ddlAnio" runat="server" CssClass="form-control"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlAnio_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3">
                              <br/>
                              <asp:Button ID="btnInformes" runat="server" Text="Informe"  CssClass="button-celeste" ToolTip ="Ir a la página de Informes de EDD" 
                                  Icono ="fa fa-search"    OnClick="btnInformes_Click" />  
                        </div>
                    </div>

                    <div class="card-header bg-primary text-white">
                        <i class="bi bi-person-badge-fill me-2"></i>EVALUADOS
                    </div>

                    <div class="table-responsive shadow-sm rounded">
                        <table id="tablaEvaluados" class="table table-striped table-hover table-bordered align-middle">
                            <thead class="table-dark text-white">
                                <tr>
                                    <th>#</th>
                                    <th>DNI</th>
                                    <th>Nombre</th>
                                  <%--    <th>Apellido</th>  --%>
                                    <th>PR</th>
                                    <th>Cargo Estructural</th>
                                    <th>Área</th>
                                    <th>Categoría</th>
                                    <th>C.O</th>
                                    <th>EVAL. OBJ</th>
                                    <th>EVAL. COMP</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptEvaluados" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Container.ItemIndex + 1 %></td>
                                            <td><%# Eval("Dni_Evaluado") %></td>
                                            <td><%# Eval("Nombres_Evaluado") %></td>
                                          <%--    <td><%# Eval("Apellido_Evaluado") %></td> --%>
                                            <td><%# Eval("PR") %></td>
                                            <td><%# Eval("Cargo_Estructural") %></td>
                                            <td><%# Eval("Area") %></td>
                                            <td><%# Eval("Categoria") %></td>
                                            <td><%# Eval("CentroOperativo") %></td>
                                             <td><%# Eval("Evaluacion_Objetivos") %></td>
                                             <td><%# Eval("Evaluacion_Competencias") %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
