<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Evaluacion.aspx.cs" Inherits="SIMANET_W22R.GestionPersonal.EvaluacionDesempenio.Evaluacion" %>

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
  <!--  <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/StyleEasy.css" />
    <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/Personalizado.css" /> -->
   <!-- CSS que falta -->
<!--     <link rel="stylesheet" href="/SIMANET_W22R/Recursos/css/bootstrap.min.css" />  -->
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
 <!--   <script src="/SIMANET_W22R/Recursos/js/jquery-3.6.4.min.js"></script>  -->
   <script id="scriptJquery364"></script>
   <script id="scriptBootstrapB"></script> <!-- NOTA:  es importante para los POPUP -->

   <script>
       window.addEventListener('DOMContentLoaded', function () {
           document.getElementById("scriptJquery364").src = getBasePath() + "/Recursos/js/jquery-3.6.4.min.js";
       });
       window.addEventListener('DOMContentLoaded', function () {
           document.getElementById("scriptBootstrapB").src = getBasePath() + "/Recursos/js/bootstrap.bundle.min.js";
       });
   </script>

    <style>
        body { background-color: #f8f9fa; }
        .card { border-radius: 15px; }
        .form-label { font-weight: 500; }
        .table thead { background-color: #dee2e6; }
        .section-title { font-size: 1.4rem; font-weight: 600; color: #343a40; }
        .centrado-gridview td, .centrado-gridview th {
            border: 1px solid #ccc;
            padding: 8px;
        }
        .centrado-gridview th { background-color: #f2f2f2; }
        .scroll-container {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #ccc;
        }
        .ddl-calificacion {
            width: 120px !important;
            height: 40px !important;
            font-size: 14px;
            padding: 5px;
        }
        .custom-select {
            width: 90px;
            padding: 4px 8px;
            font-size: 13px;
            border: 1px solid #0d6efd;
            border-radius: 8px;
            background-color: #f8f9fa;
            color: #212529;
            cursor: pointer;
            transition: 0.2s ease-in-out;
        }
        .custom-select:hover {
            border-color: #0a58ca;
            background-color: #e9f1ff;
        }

        .modal-dialog.modal-custom {
            max-width: 900px; /* ajusta según lo que necesites */
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Header común (control user) -->
        <uc1:Header ID="Header1" runat="server" />

        <!-- ScriptManager -->
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <!-- Contenido principal -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <!-- SECCIÓN DATOS GENERALES -->
                <div class="text-center mb-0">
                    <p class="section-title mb-0">EVALUACIÓN DE DESEMPEÑO</p>
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
                                    <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" placeholder="Ingrese DNI" MaxLength="8" TextMode="Number"></asp:TextBox>
                                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" CssClass="btn btn-outline-primary btn-sm rounded-pill px-3 shadow-sm" />
                                    <asp:Button ID="btnNuevo" runat="server" Text="Limpiar" OnClick="btnNuevo_Click" CssClass="btn btn-outline-primary btn-sm rounded-pill px-3 shadow-sm" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Nombres y Apellidos:</label>
                                <asp:TextBox ID="txtNombresyApellidos" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Cargo:</label>
                                <asp:TextBox ID="txtCargo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Área:</label>
                                <asp:TextBox ID="txtArea" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Categoría:</label>
                                <asp:TextBox ID="txtGrado" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- LISTA TRABAJADORES -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-secondary text-white">
                        <i class="bi bi-people-fill me-2"></i>Lista de Trabajadores a Evaluar
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <div class="scroll-container">
                                <asp:GridView ID="gvEvaluados" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="tabla-fija centrado-gridview"
                                    HeaderStyle-HorizontalAlign="Center" OnRowDataBound="gvEvaluados_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSeleccionar" runat="server" AutoPostBack="true" OnCheckedChanged="chkSeleccionar_CheckedChanged" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Nº">
                                            <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PR" HeaderText="PR" />
                                        <asp:BoundField DataField="DNI_Evaluado" HeaderText="DNI Evaluado" />
                                        <asp:BoundField DataField="CO" HeaderText="CO" />
                                        <asp:BoundField DataField="NombresyApellidos" HeaderText="Nombre del Evaluado" />
                                        <asp:BoundField DataField="Cargo_Estructural" HeaderText="Cargo Estructural" />
                                        <asp:BoundField DataField="MetaObjetivos" HeaderText="Objetivos" Visible="false" />
                                        <asp:TemplateField HeaderText="Ver">
                                            <ItemTemplate>
                                                <asp:Image ID="imgObjetivo" runat="server" Width="20px" Height="20px" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Competencias" HeaderText="Competencias" Visible="false" />
                                        <asp:TemplateField HeaderText="Ver">
                                            <ItemTemplate>
                                                <asp:Image ID="imgCompetencias" runat="server" Width="20px" Height="20px" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                              <asp:HyperLink ID="hlExcel" runat="server"
                                                CssClass="btn-outline-success"
                                                Target="_blank"
                                                NavigateUrl='<%# Eval("DNI_Evaluado", "./GenerarExcel.aspx?dni={0}") %>'>
                                                <i class="bi bi-file-excel-fill"></i>
                                            </asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                            <%-- download="Reporte_<%# Eval("DNI_Evaluado") %>.xlsx">    --%>    
                        </div>
                    </div>
                </div>

                <!-- BOTONES -->
                <div class="text-center mb-4">
                    <asp:Button ID="btnobjetivos" runat="server" Text=" Evaluar Objetivos (Metas)" CssClass="btn btn-success btn-lg me-3" OnClick="btnobjetivos_Click" />
                    <asp:Button ID="btncompetencias" runat="server" Text=" Evaluar Competencias" CssClass="btn btn-warning btn-lg" OnClick="btncompetencias_Click" />
                </div>

                <!-- MODAL 1: Objetivos -->
                <div id="PanelModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-custom modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-success text-white">
                                <h5 class="modal-title">Evaluación de Objetivos</h5>
                            </div>
                            <div class="modal-body">
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <label>Nro. DNI:</label>
                                        <asp:TextBox ID="txtmdni" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                    <div class="col-md-8">
                                        <label>Nombres y Apellidos:</label>
                                        <asp:TextBox ID="txtmnombresyapellidos" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <label>Cargo:</label>
                                        <asp:TextBox ID="txtmcargo" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                    <div class="col-md-4">
                                        <label>Área:</label>
                                        <asp:TextBox ID="txtmarea" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                    <div class="col-md-4">
                                        <label>Categoría:</label>
                                        <asp:TextBox ID="txtmcategoria" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <asp:GridView ID="gvEvaluadosdetail1" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="centrado-gridview"
                                            HeaderStyle-HorizontalAlign="Center" OnRowDataBound="gvEvaluadosdetail1_RowDataBound">
                                            <RowStyle Font-Size="12px" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Nro.">
                                                    <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Objetivo" HeaderText="Objetivos" />
                                                <asp:TemplateField HeaderText="Calificación (0-100)">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlCalificacion" runat="server" CssClass="custom-select">
                                                            <asp:ListItem Text="" Value="" />
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Puntuación (%)">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPuntuacion" runat="server" Text='<%# Eval("Puntuacion") %>' CssClass="text-center" />
                                                        <asp:Label ID="Label1" runat="server" Text="%" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer d-flex justify-content-between">
                                <div>
                                    <asp:Button ID="btnTerminar" runat="server" Visible="false"
                                        Text="Terminar Evaluación" 
                                         OnClientClick="return confirm('Si termina la evaluación no podrá tener acceso a este evaluado,\nya no estará disponible.\nSe recomienda terminar ambas evaluaciones.\n\n¿Desea continuar?');"
                                        OnClick="btnTerminar_Click" UseSubmitBehavior="false" CssClass="btn btn-secondary" />
                                </div>
                                <div>
                                    <asp:Button ID="btnmCerrar" runat="server" Text="Cerrar" CssClass="btn btn-primary" OnClientClick="cerrarModal(); return false;" />
                                    <asp:Button ID="btnmguardar" runat="server" Text="Guardar" OnClick="btnmguardar_Click" UseSubmitBehavior="false" CssClass="btn btn-success" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- MODAL 2: Competencias -->
                <div id="PanelModal2" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-custom modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-success text-white">
                                <h5 class="modal-title">Evaluación de Competencias</h5>
                            </div>
                            <div class="modal-body">
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <label>Nro. DNI:</label>
                                        <asp:TextBox ID="txtm2dni" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                    <div class="col-md-8">
                                        <label>Nombres y Apellidos:</label>
                                        <asp:TextBox ID="txtm2nombresyapellidos" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <label>Cargo:</label>
                                        <asp:TextBox ID="txtm2cargo" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                    <div class="col-md-4">
                                        <label>Área:</label>
                                        <asp:TextBox ID="txtm2area" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                    <div class="col-md-4">
                                        <label>Categoría:</label>
                                        <asp:TextBox ID="txtm2categoria" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <asp:UpdatePanel ID="updPanelModal2" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <div class="scroll-container">
                                                    <asp:GridView ID="gvCompetenciasdetail" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="tabla-fija centrado-gridview"
                                                        HeaderStyle-HorizontalAlign="Center" OnRowDataBound="gvCompetenciasdetail_RowDataBound">
                                                        <RowStyle Font-Size="12px" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Nro.">
                                                                <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Competencia" HeaderText="Competencia" />
                                                            <asp:BoundField DataField="Comportamiento" HeaderText="Comportamiento" />
                                                            <asp:TemplateField HeaderText="Calificación (0-100)">
                                                                <ItemTemplate>
                                                                    <asp:DropDownList ID="ddlCalificacion" runat="server" CssClass="custom-select">
                                                                        <asp:ListItem Text="" Value="" />
                                                                    </asp:DropDownList>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Puntuación (%)">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPuntuacion2" runat="server" Text='<%# Eval("Puntuacion") %>' CssClass="text-center" />
                                                                    <asp:Label ID="Label2" runat="server" Text="%" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer d-flex justify-content-between">
                                <div>
                                    <asp:Button ID="btnm2Terminar" runat="server"  Visible ="false" 
                                        Text="Terminar Evaluación" 
                                        OnClientClick="return confirm('Si termina la evaluación no podrá tener acceso a este evaluado,\nya no estará disponible.\nSe recomienda terminar ambas evaluaciones.\n\n¿Desea continuar?');"
                                        OnClick="btnm2Terminar_Click" UseSubmitBehavior="false" CssClass="btn btn-secondary" />
                                </div>
                                <div>
                                    <asp:Button ID="btnm2Cerrar" runat="server" Text="Cerrar" CssClass="btn btn-primary" OnClientClick="cerrarModal2(); return false;" />
                                    <asp:Button ID="btnm2guardar" runat="server" Text="Guardar" OnClick="btnm2guardar_Click" UseSubmitBehavior="false" CssClass="btn btn-success" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>

    </form>

    <!-- JS específico de esta página -->
    <script type="text/javascript">
        function cerrarModal() {
            $('#PanelModal').modal('hide');
            $('body').removeClass('modal-open');
            $('.modal-backdrop').remove();
        }
        function cerrarModal2() {
            $('#PanelModal2').modal('hide');
            $('body').removeClass('modal-open');
            $('.modal-backdrop').remove();
        }
    </script>
</body>
</html>
