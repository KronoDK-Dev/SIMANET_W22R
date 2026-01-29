<%@ Page  Language="C#"  AutoEventWireup="true" CodeBehind="NCompetencias.aspx.cs" Inherits="SIMANET_W22R.GestionPersonal.EvaluacionDesempenio.NCompetencias" %>

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
 <!--   <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/StyleEasy.css" />
     <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/Personalizado.css" /> -->
 <!-- CSS que falta -->
  <!--   <link rel="stylesheet" href="/SIMANET_W22R/Recursos/css/bootstrap.min.css" />  -->
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
   <!-- <script src="/SIMANET_W22R/Recursos/js/jquery-3.6.4.min.js"> </script>
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

            <div class="text-center mb-0">
                <p class="section-title mb-0">COMPETENCIAS </p>
            </div>


            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <i class="bi bi-person-badge-fill me-2"></i>DATOS DEL EVALUADO
               
                </div>
                <div class="card-body">
                    <div class="row g-4 align-items-end">
                        <div class="col-md-6">
                            <label class="form-label">Nro. DNI:</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" placeholder="Nombre del Evaluado" MaxLength="8" TextMode="Number"></asp:TextBox>
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


        </ContentTemplate>
    </asp:UpdatePanel>


    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>

            <div class="text-center mb-2">
                <p class="section-title mb-0">COMPETENCIAS DEL TRABAJADOR</p>
            </div>

            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <i class="bi bi-flag-fill me-2"></i>Asignación de Competencias
                </div>
                <div class="card-body">

                    <!-- Botón agregar objetivo -->
                  <table class="table table-bordered">
                     <thead class="table-light">
                   <tr>
                       <th style="width: 75px;">DNI</th>
                       <th style="width: 50px;">ID</th>
                       <th style="width: 50px;">Competencia</th>
                       <th style="width: 350px;">Comportamiento</th>
                       <th style="width: 80px;">Acción</th>
                   </tr>
               </thead>
                      <tbody>
                   <tr>
                       <td>
                           <asp:TextBox ID="txtDNICOMP" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                       </td>
                       <td colspan="2" style="width:21%;">
                           <asp:DropDownList ID="ddlCompetencia" runat="server" 
                               CssClass="custom-select w-80">
                                <asp:ListItem Text="-- Seleccione --" Value="" />
                           </asp:DropDownList>
                       </td>
                       <td>
                           <asp:TextBox ID="txtComportamiento" runat="server" CssClass="form-control" placeholder="Escriba el Comportamiento" Width="100%"></asp:TextBox>
                       </td>
                       <td style="width: 10%;">
                           <asp:Button ID="btnAgregarComp" runat="server" Text="Agregar" CssClass="btn btn-success w-80" OnClick="btnAgregarComp_Click" />
                       </td>
                   </tr>
               </tbody>
                  </table>


                    <!-- Tabla de objetivos -->
                     <asp:GridView ID="gvCompetencias" runat="server" CssClass="table table-bordered table-sm"
                          AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" EmptyDataText="No hay Competencias agregados"
                          DataKeyNames="dni,id,IdCompetencia"
                          AllowPaging="True"
                          PageSize="7"
                          PagerSettings-Position="Bottom"
                          PagerStyle-CssClass="grid-pager text-center"
                          OnPageIndexChanging="gvCompetencias_PageIndexChanging"
                          OnRowEditing="gvCompetencias_RowEditing"
                          OnRowUpdating="gvCompetencias_RowUpdating"
                          OnRowCancelingEdit="gvCompetencias_RowCancelingEdit"
                          OnRowDeleting="gvCompetencias_RowDeleting">
                          <Columns>
                              <asp:BoundField DataField="dni" HeaderText="DNI" ReadOnly="True">
                                  <ItemStyle Width="100px" />
                                  <HeaderStyle Width="100px" />
                              </asp:BoundField>

                              <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True">
                                  <ItemStyle Width="20px" />
                                  <HeaderStyle Width="20px" />
                              </asp:BoundField>

                              <asp:BoundField DataField="IdCompetencia" HeaderText="IdComp" Visible="false">
                                  <ItemStyle Width="20px" />
                                  <HeaderStyle Width="20px" />
                              </asp:BoundField>

                              <asp:BoundField DataField="Competencia" HeaderText="Competencias" ReadOnly="True">
                                  <ItemStyle Width="150px" />
                                  <HeaderStyle Width="150px" />
                              </asp:BoundField>

                              <asp:TemplateField HeaderText="Comportamiento">
                                  <ItemTemplate>
                                      <%# Eval("Comportamiento") %>
                                  </ItemTemplate>
                                  <EditItemTemplate>
                                      <asp:TextBox ID="txtComportamiento" runat="server" 
                                          Text='<%# Bind("Comportamiento") %>'
                                          CssClass="form-control form-control-sm"
                                          TextMode="MultiLine"
                                          oninput="this.style.height='auto'; this.style.height=(this.scrollHeight)+'px';"
                                          Style="overflow:hidden; width:600px;">
                                      </asp:TextBox>
                                  </EditItemTemplate>
                                  <ItemStyle Width="480px" />
                                  <HeaderStyle Width="480px" />
                              </asp:TemplateField>


                              <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="85px">
                                  <ItemTemplate>
                                      <asp:LinkButton ID="btnEditar" runat="server" CssClass="btn btn-primary btn-sm"
                                          CommandName="Edit" ToolTip="Editar">
                                               <i class="bi bi-pencil-square"></i>
                                      </asp:LinkButton>
                                      <asp:LinkButton ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-sm"
                                          CommandName="Delete" ToolTip="Eliminar" OnClientClick="return confirmarEliminar(this);">
                                          <i class="bi bi-trash3"></i>
                                      </asp:LinkButton>
                                  </ItemTemplate>

                                  <EditItemTemplate>
                                      <asp:LinkButton ID="btnActualizar" runat="server" CssClass="btn btn-success btn-sm"
                                          CommandName="Update" ToolTip="Guardar">
                                              <i class="bi bi-check2-circle"></i>
                                      </asp:LinkButton>
                                      <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn btn-secondary btn-sm"
                                          CommandName="Cancel" ToolTip="Cancelar">
                                              <i class="bi bi-x-circle"></i>
                                      </asp:LinkButton>
                                  </EditItemTemplate>
                              </asp:TemplateField>
                              </Columns>
                  </asp:GridView>
                 

                    <!-- Botón Guardar -->
                    <%--<div class="text-end mt-3">
                    <asp:Button ID="btnGuardarObj" runat="server" Text="Guardar Objetivos"
                        CssClass="btn btn-primary px-4" OnClick="btnGuardarObj_Click" />
                </div>--%>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
 </form>
</body>
</html>