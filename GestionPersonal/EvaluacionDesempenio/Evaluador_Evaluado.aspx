<%@ Page  Language="C#"  AutoEventWireup="true" CodeBehind="Evaluador_Evaluado.aspx.cs" Inherits="SIMANET_W22R.GestionPersonal.EvaluacionDesempenio.Evaluador_Evaluado" %>

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
   <!-- <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/StyleEasy.css" />
    <link rel="stylesheet" type="text/css" href="/SIMANET_W22R/Recursos/css/Personalizado.css" />  -->
    <!-- CSS que falta -->          <!--    estilo para downdroplist bootstrap 4: form-control  para bootsrap 5: form-select -->
    <!-- <link rel="stylesheet" href="/SIMANET_W22R/Recursos/css/bootstrap.min.css" />  -->

    <!--  la funcion getBasePath()  esta en el:Header.ascx -->

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
    <!-- <script src="/SIMANET_W22R/Recursos/js/jquery-3.6.4.min.js"></script>
    <script src="/SIMANET_W22R/Recursos/js/bootstrap.bundle.min.js"></script> -->
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

        /*.tabla-fija th {
            position: sticky;
            top: 0;
            background-color: #f8f8f8;
            z-index: 10;
        }

        .tabla-fija {
            width: 100%;
            border-collapse: collapse;
        }

            .tabla-fija th, .tabla-fija td {
                padding: 8px;
                text-align: center;
                border: 1px solid #ddd;
            }
*/
        .scroll-container {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #ccc;
        }

        .txtmayuscula {
            text-transform: uppercase;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <uc1:Header ID="Header1" runat="server" />

        <asp:ScriptManager ID="ScriptManager1" runat="server" />
     <asp:UpdatePanel ID="UpdatePanel2" runat="server">
      <ContentTemplate>

    

          <!-- Datos del Evaluador -->
          <div class="card shadow-sm mb-4">
              <div class="card-header bg-primary text-white">
                  <i class="bi bi-person-badge-fill me-2"></i>DATOS DEL EVALUADOR
             
              </div>
              <div class="card-body">
                  <div class="row g-4 align-items-end">
                      <div class="col-md-6">                            
                          <div class="mb-2">
                              <label class="form-label">Nro. DNI:</label>
                              <asp:Button ID="btnagregarevaluador" ToolTip ="Agregar Evaluadores" runat="server" Text="Agregar +" CssClass="btn btn-success btn-sm float-end" OnClientClick="abrirModalE(); return false;"/>
                          </div>
                          <div class="input-group">
                              <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" placeholder="Ingrese DNI" MaxLength="8" TextMode="Number"></asp:TextBox>
                              <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" CssClass="btn btn-outline-primary btn-sm rounded-pill px-3 shadow-sm" />
                              <asp:Button ID="btnNuevo" runat="server" Text="Limpiar" OnClick="btnNuevo_Click" CssClass="btn btn-outline-primary btn-sm rounded-pill px-3 shadow-sm" />
                          </div>
                      </div>
                      <div class="col-md-6">
                          <label class="form-label">Nombres y Apellidos:</label>
                          <asp:TextBox ID="txtNombresyApellidos" runat="server" CssClass="form-control" placeholder="Nombre completo" ReadOnly="true"></asp:TextBox>
                      </div>
                      <div class="col-md-4">
                          <label class="form-label">Cargo:</label>
                          <asp:TextBox ID="txtCargo" runat="server" CssClass="form-control" placeholder="Ej. Jefe de Área" ReadOnly="true"></asp:TextBox>
                      </div>
                      <div class="col-md-4">
                          <label class="form-label">Área:</label>
                          <asp:TextBox ID="txtArea" runat="server" CssClass="form-control" placeholder="Ej. Finanzas" ReadOnly="true"></asp:TextBox>
                      </div>
                      <div class="col-md-4">
                          <label class="form-label">Categoria:</label>
                          <asp:TextBox ID="txtGrado" runat="server" CssClass="form-control" placeholder="Ej. Licenciado" ReadOnly="true"></asp:TextBox>
                      </div>
                  </div>
                  <hr>
                  <hr>
                  <div class="row g-4 align-items-end">
                       <div class="col-md-4">
                           <label class="form-label">Evaluación:</label>
                           <asp:DropDownList ID="ddlEvaluacion" runat="server" CssClass="form-control"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlEvaluacion_SelectedIndexChanged">
                            </asp:DropDownList>
                       </div>
                     <div class="col-md-4">
                        <label class="form-label">Estado General Actual:</label>
                        <asp:DropDownList ID="ddlEstadoGG" runat="server" CssClass="form-control">
                         </asp:DropDownList>
                    </div>
                       <div class="col-md-4">
                        <label class="form-label"></label><br/>
                        <asp:Button ID="BtnModificarEstado" runat="server" Text="Modificar" CssClass="btn btn-success btn-sm" 
                            ToolTip ="Modificar Estado Evaluación" 
                            OnClick="BtnModificarEstado_Click"
                             OnClientClick="return confirm('¿Está seguro de modificar todos los registros?');" />
                                
                    </div>
                  </div>


              </div>
          </div>

          <div>
              <asp:Button ID="btnAgregarTrabajador" runat="server" Text="Agregar +" CssClass="btn btn-success btn-sm" ToolTip ="Agregar Evaluados"
                  OnClientClick="abrirModal(); return false;" />
          </div>


          <!-- Lista de Evaluados -->
          <div class="card shadow-sm mb-4">
              <div class="card-header bg-secondary text-white">
                  <i class="bi bi-people-fill me-2"></i>Lista de Trabajadores a Evaluar
             
              </div>
              <div class="card-body">
                  <div class="table-responsive">
                      <div class="scroll-container">
                            <asp:GridView ID="gvEvaluados" runat="server" AutoGenerateColumns="False" GridLines="None"
                                CssClass="tabla-fija centrado-gridview" DataKeyNames="DNI_Evaluado,EstadoEvaluado"
                                OnRowDataBound="gvEvaluados_RowDataBound" OnRowCommand="gvEvaluados_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="E.C">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSeleccionar" runat="server"
                                                AutoPostBack="true"
                                                OnCheckedChanged="chkSeleccionar_CheckedChanged" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Nª">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="PR" HeaderText="PR" />
                                    <asp:BoundField DataField="DNI_Evaluado" HeaderText="DNI">
                                        <ItemStyle Width="50" />
                                        <HeaderStyle Width="50px" />
                                    </asp:BoundField>

                                    <asp:BoundField DataField="CO" HeaderText="CO">
                                         <ItemStyle Width="120" />
                                        <HeaderStyle Width="120px" />
                                    </asp:BoundField>

                                    <asp:BoundField DataField="Nombres" HeaderText="Evaluado">
                                         <ItemStyle Width="300" />
                                        <HeaderStyle Width="300px" />
                                    </asp:BoundField>
                                    <%--<asp:BoundField DataField="Apellidos" HeaderText="Apellidos" />--%>
                                    <asp:BoundField DataField="Cargo_Estructural" HeaderText="Cargo Estructural">
                                         <ItemStyle Width="300" />
                                        <HeaderStyle Width="300px" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="AcciónE">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEditar" runat="server" CssClass="btn btn-primary btn-sm"
                                                CommandName="Editar" CommandArgument='<%# Eval("DNI_Evaluado") %>'>
                                                <i class="bi bi-pencil-square"></i> 
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnEliminar" runat="server" CssClass="btn btn-danger btn-sm"
                                                CommandName="Eliminar" CommandArgument='<%# Eval("DNI_Evaluado") %>'
                                                OnClientClick="return confirmarEliminar(this);">                                            
                                                <i class="bi bi-trash"></i> 
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>


                                </Columns>
                            </asp:GridView>
                      </div>
                  </div>
              </div>
          </div>

           <!--  ********** modal agregar trabajador:  modalAgregar **************** -->
          <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
              <ContentTemplate>
                  <div class="modal fade" id="modalAgregar" tabindex="-1" aria-labelledby="modalAgregarLabel" aria-hidden="true">
                      <div class="modal-dialog modal-lg modal-dialog-centered">
                          <div class="modal-content">
                              <div class="modal-header bg-primary text-white">
                                  <h5 class="modal-title" id="modalAgregarLabel"><i class="bi bi-person-plus-fill me-2"></i>Agregar Trabajador a Evaluar</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                              </div>

                              <div class="modal-body">
                                  <div class="row g-3">
                                      <div class="col-md-4">
                                          <label class="form-label">DNI:</label>
                                          <asp:TextBox ID="txtNuevoDNI" runat="server" CssClass="form-control" MaxLength="8" TextMode="Number"></asp:TextBox>
                                      </div>
                                  </div>
                                  <div class="row g-3">
                                      <div class="col-md-8">
                                          <label class="form-label">Nombres y Apellidos:</label>
                                          <asp:TextBox ID="txtNuevoNombres" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                  </div>
                                 <%--
                                  <div class="row g-3">
                                      <div class="col-md-8">
                                          <label class="form-label">Apellidos:</label>
                                          <asp:TextBox ID="txtNuevoApellidos" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                  </div>
                               --%>
                                  <div class="row g-3">
                                      <div class="col-md-2">
                                          <label class="form-label">PR:</label>
                                          <asp:TextBox ID="txtnuevopr" runat="server" CssClass="form-control limpiar-modal" MaxLength="8" ></asp:TextBox>
                                      </div>
                                  </div>
                                  <div class="row g-3">
                                      <div class="col-md-6">
                                          <label class="form-label">Cargo:</label>
                                          <asp:TextBox ID="txtNuevoCargo" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                      <div class="col-md-6">
                                          <label class="form-label">Área:</label>
                                          <asp:TextBox ID="txtNuevoArea" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                  </div>
                                  <div class="row g-3">
                                      <div class="col-md-6">
                                          <label class="form-label">Categoria:</label>
                                          <asp:TextBox ID="txtNuevoCategoria" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                      <div class="col-md-6">
                                          <label class="form-label">Centro Operativo:</label>
                                          <asp:TextBox ID="txtNuevoCentroOperativo" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                  </div>


                                  <div class="modal-footer d-flex justify-content-between align-items-center">
                                      <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger small"></asp:Label>
                                      <div>
                                          <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
                                          <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClientClick="cerrarModal('modalAgregar'); return false;"  /> <!--  OnClick="btnCancelar_Click" -->
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
              </ContentTemplate>
          </asp:UpdatePanel>


          <!--  ********** modal agregar evaluador:  modalAgregarEvaluador **************** -->
           <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
              <ContentTemplate>
                  <div class="modal fade" id="modalAgregarEvaluador" tabindex="-1" aria-labelledby="modalAgregarLabelE" aria-hidden="true">
                      <div class="modal-dialog modal-lg modal-dialog-centered">
                          <div class="modal-content">
                              <div class="modal-header bg-primary text-white">
                                  <h5 class="modal-title" id="modalAgregarLabelE"><i class="bi bi-person-plus-fill me-2"></i>Agregar Evaluador</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                              </div>

                              <div class="modal-body">
                                  <div class="col-md-6">
                                      <label class="form-label">DNI:</label>
                                      <div class="input-group">
                                          <asp:TextBox ID="txtDNIE" runat="server" CssClass="form-control" MaxLength="8" TextMode="Number"></asp:TextBox>
                                          <asp:Button ID="btnBuscarEvaluador" runat="server" CssClass="btn btn-outline-secondary" 
                                                  OnClick="btnBuscarEvaluador_Click" Text="🔍" />
                                      </div>
                                  </div>
                                  <div class="row g-3">
                                      <div class="col-md-8">
                                          <label class="form-label">Nombres y Apellidos:</label>
                                          <asp:TextBox ID="txtNuevoNombresE" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                  </div>
                                  <div class="row g-3">
                                      <div class="col-md-8">
                                          <label class="form-label" id="lblApellidos" runat="server"  Visible ="false" >Apellidos:</label>
                                          <asp:TextBox ID="txtNuevoApellidosE" runat="server" CssClass="form-control txtmayuscula limpiar-modal" Visible ="false" ></asp:TextBox>
                                      </div>
                                  </div>
                                  <div class="row g-3">
                                      <div class="col-md-2">
                                          <label class="form-label">PR:</label>
                                          <asp:TextBox ID="txtnuevoprE" runat="server" CssClass="form-control limpiar-modal" MaxLength="8"></asp:TextBox>
                                      </div>
                                      <div class="col-md-4">
                                        <label class="form-label">Usuario Netsuite:</label>
                                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control limpiar-modal"> </asp:TextBox>
                                    </div>
                                  </div>
                                  <div class="row g-3">
                                      <div class="col-md-6">
                                          <label class="form-label">Cargo:</label>
                                          <asp:TextBox ID="txtNuevoCargoE" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                      <div class="col-md-6">
                                          <label class="form-label">Área:</label>
                                          <asp:TextBox ID="txtNuevoAreaE" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                  </div>
                                  <div class="row g-3">
                                      <div class="col-md-6">
                                          <label class="form-label">Categoria:</label>
                                          <asp:TextBox ID="txtNuevoCategoriaE" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                      <div class="col-md-6">
                                          <label class="form-label">Centro Operativo:</label>
                                          <asp:TextBox ID="txtNuevoCentroOperativoE" runat="server" CssClass="form-control txtmayuscula limpiar-modal"></asp:TextBox>
                                      </div>
                                  </div>


                                  <div class="modal-footer d-flex justify-content-between align-items-center">
                                      <%--  asp:Button ID="btnCancelarEvaluador" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelarEvaluador_Click"/>   --%>
                                      <div>
                                          <asp:Button ID="btnGuardarEvaluador" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardarEvaluador_Click" />
                                          <asp:Button ID="btnCancelarEvaluador" runat="server" Text="Cancelar" CssClass="btn btn-secondary"  OnClientClick="cerrarModal('modalAgregarEvaluador'); return false;"/>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
              </ContentTemplate>
                <Triggers>
                  <asp:AsyncPostBackTrigger ControlID="btnBuscarEvaluador" EventName="Click" />
              </Triggers>
          </asp:UpdatePanel>


             <!--  ********** modal editar trabajador:  modalEditar **************** -->

          <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
              <ContentTemplate>
                  <div class="modal fade" id="modalEditar" tabindex="-1" aria-hidden="true">
                      <div class="modal-dialog modal-lg">
                          <div class="modal-content">
                              <div class="modal-header bg-primary text-white">
                                  <h5 class="modal-title">Editar Trabajador</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                              </div>
                              <div class="modal-body">
                                  <div class="row g-3">
                                      <div class="col-md-4">
                                          <label class="form-label">DNI Evaluado:</label>
                                          <asp:TextBox ID="txtEditDNI" runat="server" CssClass="form-control" ReadOnly="true" TextMode="Number"></asp:TextBox>
                                      </div>
                                      <div class="col-md-6">
                                          <label class="form-label">Nombres y Apellidos:</label>
                                          <asp:TextBox ID="txtEditNombres" runat="server" CssClass="form-control txtmayuscula"></asp:TextBox>
                                      </div>


                                      <div class="col-md-4">
                                          <label class="form-label">CO</label>
                                          <asp:TextBox ID="txtEditCO" runat="server" CssClass="form-control txtmayuscula" ></asp:TextBox>
                                      </div>
                                      <div class="col-md-4">
                                          <label class="form-label">Categoría:</label>
                                          <asp:TextBox ID="txtEditCategoria" runat="server" CssClass="form-control txtmayuscula"></asp:TextBox>
                                      </div>
                                      <%--
                                      <div class="col-md-4">
                                          <label class="form-label">Nombres:</label>
                                          <asp:TextBox ID="txtEditNombres" runat="server" CssClass="form-control txtmayuscula"></asp:TextBox>
                                      </div>
                                       
                                      <div class="col-md-4">
                                          <label class="form-label">Apellidos:</label>
                                          <asp:TextBox ID="txtEditApellidos" runat="server" CssClass="form-control txtmayuscula"></asp:TextBox>
                                      </div>
                                        --%>
                                       <div class="col-md-4">
                                          <label class="form-label">PR:</label>
                                          <asp:TextBox ID="txtEditPR" runat="server" CssClass="form-control txtmayuscula" MaxLength="8"></asp:TextBox>
                                      </div>
                                     
                  
                                     <div class="col-md-6">
                                          <asp:CheckBox ID="chkObjetivos" runat="server" Text="Estado Objetivos" />
                                      </div>

                                       <div class="col-md-6">                                           
                                          <asp:CheckBox ID="chkCompetencias" runat="server" Text="Estado Competencia" />   
                                      </div>

                                      <div class="col-md-6">
                                          <label class="form-label">Cambiar Evaluador:</label><br/>
                                          <asp:DropDownList ID="ddlEditEvaluador" runat="server" CssClass="form-control"></asp:DropDownList>
                                      </div>
                                      <div class="col-md-6">
                                          <label class="form-label">Área:</label>
                                          <asp:TextBox ID="txtEditArea" runat="server" CssClass="form-control txtmayuscula"></asp:TextBox>
                                      </div>
                                      <div class="col-md-6">
                                          <label class="form-label">Cargo:</label>
                                          <asp:TextBox ID="txtEditCargo" runat="server" CssClass="form-control txtmayuscula"></asp:TextBox>
                                      </div>
                                  </div>
                              </div>
                              <div class="modal-footer">
                                  <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-success" OnClick="btnActualizar_Click" />
                                <%--   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button> --%> 
                                  <button type="button" class="btn btn-secondary" onclick="cerrarModal('modalEditar'); return false;">Cerrar</button>

                              </div>
                          </div>
                      </div>
                  </div>

              </ContentTemplate>
          </asp:UpdatePanel>
      </ContentTemplate>
  </asp:UpdatePanel>

      

    </form>
      <!-- FUNCIONES JS PARA MODALES -->
  <script type="text/javascript">
      function abrirModal() {
          var myModal = new bootstrap.Modal(document.getElementById('modalAgregar'), {
              keyboard: false
          });
          myModal.show();
      }

      $('#modalAgregar').on('show.bs.modal', function () {
          $(this).find('.limpiar-modal').val('');
      });

      function abrirModalE() {
          var myModalE = new bootstrap.Modal(document.getElementById('modalAgregarEvaluador'), {
              keyboard: false
          });
          myModalE.show();
      }

      $('#modalAgregarEvaluador').on('show.bs.modal', function () {
          $(this).find('.limpiar-modal').val('');
      });
      // nuevas funciones
      function abrirModal2(id) {
          var modalEl = document.getElementById(id);
          if (modalEl) {
              var modal = new bootstrap.Modal(modalEl);
              modal.show();
          }
      }
      /*
      function cerrarModal(id) {
          var modalEl = document.getElementById(id);
          if (modalEl) {
              var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
              if (modal) modal.hide();
          }
          // Limpieza adicional para evitar fondo gris
          document.body.classList.remove('modal-open');
          var backdrops = document.querySelectorAll('.modal-backdrop');
          backdrops.forEach(function (bd) { bd.remove(); });
      }
      */
      function cerrarModal(id) {
          var modalEl = document.getElementById(id);
          if (modalEl) {
              var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
              if (modal) modal.hide();
          }
          document.body.classList.remove('modal-open');
          var backdrops = document.querySelectorAll('.modal-backdrop');
          backdrops.forEach(function (bd) { bd.remove(); });
      }

      function confirmarEliminar(btn) {
          return confirm('¿Seguro que deseas eliminar este evaluado?');
      }

  </script>
</body>
</html>