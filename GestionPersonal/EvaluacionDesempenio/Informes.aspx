<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Informes.aspx.cs" Inherits="SIMANET_W22R.GestionPersonal.EvaluacionDesempenio.Informes" %>
<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Informes</title>
    <!--  la funcion getBasePath()  esta en el:Header.ascx -->

    <!-- Bootstrap CSS -->
    
    <!-- Bootstrap Icons -->
  
   <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" /> -->

        <!-- Scripts -->
    <link id="cssPersonalizado" rel="stylesheet" />
    <script>  <!-- le adicionamos su referencia al control LINK -->
        window.addEventListener('DOMContentLoaded', function () {
            document.getElementById("cssPersonalizado").href = getBasePath() + "/Recursos/css/Personalizado.css";
        });
    </script>

<link id="cssBootstrap" rel="stylesheet" />
<script>  <!-- le adicionamos su referencia al control LINK  * Bootstrap v4.0.0 -->
    window.addEventListener('DOMContentLoaded', function () {
        document.getElementById("cssBootstrap").href = getBasePath() + "/Recursos/css/bootstrap.min.css";
    });
</script>    

    
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
        .report-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .search-box input {
            border-radius: 20px;
            padding-left: 35px;
        }

        .search-box i {
            position: absolute;
            margin-left: 10px;
            margin-top: 10px;
            color: #aaa;
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .table thead {
            background-color: #007bff;
            color: #fff;
        }

        .table td, .table th {
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <uc1:Header ID="Header1" runat="server" />

        <div class="container mt-4">
            <!-- Título y botón -->
            <div class="report-header">
                <h3 class="fw-bold"><i class="bi bi-clipboard-data"></i> Informes</h3>
                <asp:Button ID="btnNuevoReporte" runat="server" CssClass="btn btn-primary" Text="Generar nuevo informe" OnClick="btnNuevoReporte_Click" />
            </div>

            <!-- Filtros   eslito bootstrap 4: form-control  para bootsrap 5: form-select -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-3">
                            <label class="form-label">Evaluador</label>
                            <asp:DropDownList ID="ddlEvaluador" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-- Todos --" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Tipo Evaluación</label>
                            <asp:DropDownList ID="ddlTipoEvaluacion" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-- Todos --" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Centro Operativo</label>
                            <asp:DropDownList ID="ddlCentroOperativo" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-- Todos --" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-6 d-flex align-items-end">
                            <div class="me-2 flex-fill">
                                <label class="form-label">Desde</label>
                                <asp:TextBox ID="txtDesde" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="flex-fill">
                                <label class="form-label">Hasta</label>
                                <asp:TextBox ID="txtHasta" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-md-12 text-end">
                            <asp:Button ID="btnFiltrar" runat="server" CssClass="btn btn-success" Text="Buscar" OnClick="btnFiltrar_Click" />
                            <asp:Button ID="btnLimpiar" runat="server" CssClass="btn btn-outline-secondary" Text="Limpiar" OnClick="btnLimpiar_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Barra de búsqueda y botones -->
            <div class="d-flex justify-content-between mb-2">
                <div class="search-box position-relative" style="width: 300px;">
                    <i class="bi bi-search"></i>
                    <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Buscar..." 
                        AutoPostBack="true"   OnTextChanged="txtBuscar_TextChanged" ></asp:TextBox>
                </div>
                <div>
                    <asp:Button ID="btnExportarExcel" runat="server" CssClass="btn btn-outline-success me-2" Text="Excel" OnClick="btnExportarExcel_Click" />
                    <asp:Button ID="btnExportarPDF" runat="server" CssClass="btn btn-outline-danger" Text="PDF" OnClick="btnExportarPDF_Click" />
                </div>
            </div>

            <!-- Tabla -->
            <div class="card">
                <div class="card-body">
                    <div style="overflow-x: auto; white-space: nowrap;">
                        <asp:GridView ID="gvReportes" runat="server"
                            CssClass="table table-striped table-hover text-center"
                            AutoGenerateColumns="True" AllowPaging="true" PageSize="10"
                            OnPageIndexChanging="gvReportes_PageIndexChanging"
                            EmptyDataText="No se encontraron registros." 
                            Style="min-width: 1200px;"
                            OnRowCreated="gvReportes_RowCreated"
                            >
                         
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>