<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarProgVisita.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.AdministrarProgVisita" %>

<%@ Register TagPrefix="uc1" TagName="header" Src="~/Controles/Header.ascx" %>
<%@ Register TagPrefix="cc1" Assembly="EasyControlWeb" Namespace="EasyControlWeb" %>
<%@ Register TagPrefix="cc2" Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" %>
<%@ Register TagPrefix="cc3" Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" %>
<%@ Register TagPrefix="cc6" Assembly="EasyControlWeb" Namespace="EasyControlWeb" %>

<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/StyleEasy.css") %> " />
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/Personalizado.css") %> " />
<script src="<%= ResolveUrl("~/Recursos/Js/jquery-3.6.4.min.js") %> "></script>
<script src="<%= ResolveUrl("~/Recursos/Js/toastr.min.js") %> "></script>
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/toastr.min.css") %> " />
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/sweetalert2.min.css") %> "/>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>PROGRAMACION DE VISITA</title>





</head>
<body>
    
    <form id="form1" runat="server">

        <div style="height: 100%; overflow: auto;">
            <table id="tblReport" style="width: 100%; border-collapse: collapse;" border="0px">
                <tr>
                    <td colspan="7">
                        <uc1:header runat="server" ID="header" IdGestorFiltro="EasyGestorFiltro1" />
                    </td>
                </tr>
                <!-- 07 columnas -->
                <tr>
                    <td width="20px"></td>
                    <td width="10%">
                        <asp:Label ID="lblCEO" runat="server" Text="Centro Operativo: " Width="150px" Visible="false"   ></asp:Label><br />

                        <cc3:EasyDropdownList ID="eDDLCentros" runat="server" CargaInmediata="True" Width="50px" Visible="false" 
                            DataTextField="NOMBRE" DataValueField="NROCENTROOPERATIVO"
                            enableonchange="True" OnSelectedIndexChanged="fnRefrescaLN" OnTextChanged="fnRefrescaLN" AutoPostBack="True">
                            <EasyStyle Ancho="Uno"></EasyStyle>
                            <DataInterconect MetodoConexion="WebServiceInterno">
                                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                <Metodo>ListaCentrosOperativosPorPerfil</Metodo>
                                <UrlWebServicieParams>
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdUsuario" Paramvalue="IdUsuario" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                </UrlWebServicieParams>
                            </DataInterconect>
                        </cc3:EasyDropdownList>
                    </td>
                    <td width="10%">
                        <asp:Label ID="lblUO" runat="server" Text="Unidad Operativa: " Width="200px" Visible="false" ></asp:Label><br />
                        <cc3:EasyDropdownList ID="eDDLUnidadO" runat="server" CargaInmediata="True" Width="50px" Visible="false" 
                            DataTextField="NOMBRE" DataValueField="CODIGO"
                            enableonchange="True" OnSelectedIndexChanged="fnRefrescaSLN" OnTextChanged="fnRefrescaSLN" AutoPostBack="True">
                            <EasyStyle Ancho="Uno"></EasyStyle>
                            <DataInterconect MetodoConexion="WebServiceInterno">
                                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                <Metodo>ListaUnidad_OpexCEO</Metodo>
                                <UrlWebServicieParams>
                                    <cc2:EasyFiltroParamURLws ObtenerValor="FormControl"
                                        ParamName="sCodigo" Paramvalue="eDDLCentros" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Session"
                                        ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                </UrlWebServicieParams>
                            </DataInterconect>
                        </cc3:EasyDropdownList>

                    </td>


                    <td width="10px">
                        <div>
                            <asp:Label ID="lblLineaN" runat="server" Text="Linea Negocio: " Style="display: inline-block;" Visible="false" ></asp:Label>
                            <br />
                            <cc3:EasyDropdownList ID="eDDLLineas" runat="server" CargaInmediata="True" Visible="false" 
                                DataTextField="NOMBRE" DataValueField="CODIGO" OnSelectedIndexChanged="FnSublineas" AutoPostBack="true">
                                <EasyStyle Ancho="Uno"></EasyStyle>
                                <DataInterconect MetodoConexion="WebServiceInterno">
                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                    <Metodo>ListaLineasNegxCEOxUO</Metodo>
                                    <UrlWebServicieParams>
                                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_CEO" Paramvalue="eDDLCentros" TipodeDato="String" />
                                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_UNI_OPE" Paramvalue="eDDLUnidadO" TipodeDato="String" />
                                        <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="USERNAME" Paramvalue="UserName" TipodeDato="String" />
                                    </UrlWebServicieParams>
                                </DataInterconect>
                            </cc3:EasyDropdownList>
                        </div>
                    </td>
                    <td width="10%">
                        <div>
                            <asp:Label ID="lblSLineaN" runat="server" Text="SubLinea Negocio: " Style="display: inline-block;" Visible="false" ></asp:Label>
                            <br />
                            <cc3:EasyDropdownList ID="eDDLSubLinea" runat="server" CargaInmediata="True" Visible="false" 
                                DataTextField="NOMBRE" DataValueField="CODIGO">
                                <EasyStyle Ancho="Uno"></EasyStyle>
                                <DataInterconect MetodoConexion="WebServiceInterno">
                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                    <Metodo>ListaSubLineasNegxCEOxUOxL</Metodo>
                                    <UrlWebServicieParams>
                                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl"
                                            ParamName="V_CEO" Paramvalue="eDDLCentros" TipodeDato="String" />
                                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl"
                                            ParamName="V_UNI_OPE" Paramvalue="eDDLUnidadO" TipodeDato="String" />
                                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl"
                                            ParamName="V_LINEA" Paramvalue="eDDLLineas" TipodeDato="String" />
                                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl"
                                            ParamName="USERNAME" Paramvalue="UserName" TipodeDato="String" />
                                    </UrlWebServicieParams>
                                </DataInterconect>
                            </cc3:EasyDropdownList>
                        </div>
                    </td>
                    <td width="60%">
                        <asp:Label ID="lblbusqueda" runat="server"  Visible="false"   Text="Criterio Búsqueda: " ToolTip ="NroProgramación / Visitante / Observaciones / Fecha Ingreso"></asp:Label><br />
                        <cc3:EasyTextBox ID="etbCriterio" runat="server" Visible="false"  onkeydown="checkEnter(event)" Width="35%" Style="display: inline-block;"></cc3:EasyTextBox>
                        <asp:Button ID="btnBuscar" runat="server" Visible="false"  Text="Buscar" CssClass="button-celeste" Icono="fa fa-search" OnClick="btnBuscar_Click" OnClientClick="Espera();" />
                        
                        <cc3:EasyAutocompletar ID="EAC_Proveedor" runat="server" Width="35%" DisplayText="NombreArea" ValueField="IDAREA" 
                              MensajeValida="Este dato es obligatorio" EnableOnChange="True" Etiqueta="Area Usuaria destino de la visita">
                            <EasyStyle Ancho="Dos" TipoTalla="sm"></EasyStyle>
                             <DataInterconect MetodoConexion="WebServiceInterno">
                                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                <Metodo>ListaAreasxDescripcion</Metodo>
                                <UrlWebServicieParams>
                                      <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                     <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdCentro" Paramvalue="IdCentro" TipodeDato="String" />
            
                                </UrlWebServicieParams>
                             </DataInterconect>
                          </cc3:EasyAutocompletar>
                        
                        <!--
                            <cc3:EasyAutocompletar ID="EAC_Areas" runat="server" Width="35%" DisplayText="NombreArea" ValueField="IDAREA" 
                                  MensajeValida="Este dato es obligatorio" EnableOnChange="True" Etiqueta="Area Usuaria destino de la visita">
                                <EasyStyle Ancho="Dos" TipoTalla="sm"></EasyStyle>
                                 <DataInterconect MetodoConexion="WebServiceInterno">
                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                    <Metodo>ListaAreasxDescripcion</Metodo>
                                    <UrlWebServicieParams>
                                          <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                         <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdCentro" Paramvalue="IdCentro" TipodeDato="String" />
            
                                    </UrlWebServicieParams>
                                 </DataInterconect>
                              </cc3:EasyAutocompletar>
                         -->


                    </td>


                    <td width="20px">
                    

                    </td>
                </tr>

                <tr>
                    <td width="20px"></td>
                    <td colspan="5">
                        <cc6:EasyGridView ID="EGVResultados" runat="server" CssClass=""
                            AutoGenerateColumns="False" ShowFooter="True"
                            TituloHeader="Programacion de Visitas"
                            ToolBarButtonClick="OnEasyGridButton_Click" Width="100%"
                            AllowPaging="True"
                            OnPageIndexChanging="EasyGridView1_PageIndexChanged"
                            OnEasyGridDetalle_Click="EGVResultados_EasyGridDetalle_Click" OnEasyGridButton_Click="EGVResultados_EasyGridButton_Click" fncExecBeforeServer="">
                            <EasyGridButtons>
                                <cc1:EasyGridButton Id="btnAgregar"       Texto="Agregar"      Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Ubicacion="Derecha" />
                                <cc1:EasyGridButton Id="btnCopiarr"       Texto="Copiar"      Descripcion="" Icono="fa fa-copy" MsgConfirm="" RunAtServer="True" Ubicacion="Derecha" />
                                <cc1:EasyGridButton Id="btnEquipos"       Texto="List. Equipos" Descripcion="" Icono="fa fa-gear" MsgConfirm="" RunAtServer="True"  Ubicacion="Centro" />
                                <cc1:EasyGridButton Id="btnPersonas" Texto="List. Personas" Descripcion="" Icono="fa fa-user" MsgConfirm="" RunAtServer="True"  Ubicacion="Centro" />
                            </EasyGridButtons>

                            <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                            <DataInterconect MetodoConexion="WebServiceInterno">
                                <UrlWebService>/SIMANET/SeguridadPlanta/visitas.asmx</UrlWebService>
                                <Metodo>ListarTodos</Metodo>
                                <UrlWebServicieParams>
                                    <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="S_PROGRAMACION" Paramvalue="etbCriterio" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="S_PERIODO" Paramvalue="S_PERIODO" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="S_TIPOPROGRA" Paramvalue="S_TIPOPROGRA" TipodeDato="String" />
                                     <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdUser" Paramvalue="86" TipodeDato="String" />
                                </UrlWebServicieParams>
                            </DataInterconect>

                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>
                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                            <Columns>

                                <asp:BoundField DataField="NroProg" HeaderText="NRO PROG" />
                                <asp:BoundField DataField="RazonSocial" HeaderText="VISITANTE" />
                                <asp:BoundField DataField="NombreArea" HeaderText="DESTINO" />
                                <asp:BoundField DataField="Observaciones" HeaderText="ASUNTO" />
                                <asp:BoundField DataField="FechaInicioStr" HeaderText="INICIO" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="false"  ApplyFormatInEditMode="true" />
                                <asp:BoundField DataField="FechaTerminoStr" HeaderText="TERMINO" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField DataField="HoraInicio" HeaderText="HORA INGRESO" />
                                <asp:BoundField DataField="NroVisitas" HeaderText="NRO VISIT." />

                                <asp:TemplateField SortExpression="idEstado">
                                        <HeaderStyle Width="50px" />
                                        <HeaderTemplate>
                                            <asp:Label ID="Label3" runat="server">Est.<br />EMail</asp:Label>
                                        </HeaderTemplate>

                                        <ItemTemplate>
                                            <asp:Literal ID="litEmailIcon" runat="server"
                                                Text='<%# (Convert.ToInt32(Eval("idEstado")) == 1
                                                        ? "<i class=\"fa fa-envelope text-success\" title=\"Correo enviado\" aria-label=\"Correo enviado\"></i>"
                                                        : "<i class=\"fa fa-envelope-o text-warning\" title=\"Pendiente de envío\" aria-label=\"Pendiente de envío\"></i>") %>'>
                                            </asp:Literal>
                                        </ItemTemplate>

                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                            </Columns>

                            <HeaderStyle CssClass="HeaderGrilla" />
                            <PagerStyle HorizontalAlign="Center" />
                            <RowStyle CssClass="ItemGrilla" Height="25px" />

                        </cc6:EasyGridView>
                    </td>
                    <td width="20px"></td>
                </tr>
            </table>
        </div>
        <div>
        </div>
        <cc2:EasyGestorFiltro ID="EasyGestorFiltro1" runat="server" ClassHeader="HeaderGrilla" ClassItem="ItemGrilla" 
                                ClassItemAlternating="AlternateItemGrilla"  EasyFiltroCampos-Capacity="4"  DisplayButtonInterface="False" 
                                OnProcessCompleted="EasyGestorFiltro1_ProcessCompleted">

    <cc2:EasyFiltroCampo Descripcion="Tipo Personal" Nombre="IdProyecto" TipodeDato="String">
                <DataInterconect MetodoConexion="WebServiceInterno">
                    <UrlWebService>/GestiondeCalidad/Proceso.asmx</UrlWebService>
                     <Metodo>BuscarProyectoXNombre</Metodo>
                    <UrlWebServicieParams>
                        <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                    </UrlWebServicieParams>
                </DataInterconect>
                <EasyControlAsociado TemplateType="EasyITemplateAutoCompletar" NroCarIni="0" TextField="NombreProyecto" 
                       ValueField="IdProyecto" fncTempaleCustom="onDisplayTemplate" />
          </cc2:EasyFiltroCampo>

            <cc2:EasyFiltroCampo Descripcion="Visitante" Nombre="RazonSocial" TipodeDato="String">
            <DataInterconect MetodoConexion="WebServiceInterno">
                <UrlWebService>/GestiondeCalidad/Proceso.asmx</UrlWebService>
                <Metodo>BuscarProyectoXCliente</Metodo>
                <UrlWebServicieParams>
                    <cc2:EasyFiltroParamURLws ParamName="UserName" Paramvalue="UserName"  ObtenerValor="Session"  />
                </UrlWebServicieParams>
            </DataInterconect>
            <EasyControlAsociado NroCarIni="4" TemplateType="EasyITemplateAutoCompletar" 
                TextField  ="RazonSocialCliente"  ValueField="IdCliente" />
        </cc2:EasyFiltroCampo>

            <cc2:EasyFiltroCampo Descripcion="Asunto" Nombre="Observaciones">
                <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect><EasyControlAsociado TemplateType="EasyITemplateTextBox" />
            </cc2:EasyFiltroCampo>

            <cc2:EasyFiltroCampo Descripcion="Fecha Inicio" Nombre="FechaInicioStr" >
               <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect><EasyControlAsociado TemplateType="EasyITemplateDatepicker" />
            </cc2:EasyFiltroCampo>

            

        </cc2:EasyGestorFiltro>


    <script type="text/javascript">
        /*
            (function () {
                // Id del contenedor del modal del gestor de filtro
                var SEL = '#EasyGestorFiltro_Title_Gen';

                function isVisible(el) {
                    if (!el) return false;
                    var cs = getComputedStyle(el);
                    // visible si no está display:none y no está oculto por visibility
                    return cs.display !== 'none' && cs.visibility !== 'hidden';
                }

                function syncModalA11y() {
                    var dlg = document.querySelector(SEL);
                    if (!dlg) return;

                    if (isVisible(dlg)) {
                        // Si está visible, NO puede tener aria-hidden="true"
                        dlg.removeAttribute('aria-hidden');
                        dlg.setAttribute('aria-modal', 'true');
                        dlg.setAttribute('tabindex', '-1');

                        // Enfoca el primer control interactivo del modal (buena práctica)
                        var first = dlg.querySelector('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
                        if (first) try { first.focus(); } catch (e) { }
                    } else {
                        // Si está oculto, puede volver a aria-hidden
                        dlg.setAttribute('aria-hidden', 'true');
                        dlg.removeAttribute('aria-modal');
                        dlg.removeAttribute('tabindex');
                    }
                }

                // Observa cambios de estilo/clase para detectar apertura/cierre
                function attachObserver() {
                    var dlg = document.querySelector(SEL);
                    if (!dlg) return false;
                    var obs = new MutationObserver(syncModalA11y);
                    obs.observe(dlg, { attributes: true, attributeFilter: ['style', 'class', 'aria-hidden'] });
                    // Sincroniza una vez al inicio
                    syncModalA11y();
                    return true;
                }

                // Espera a que exista el nodo y conecta el observer
                if (!attachObserver()) {
                    var tries = 0, t = setInterval(function () {
                        tries++;
                        if (attachObserver() || tries > 50) clearInterval(t);
                    }, 200);
                }
            })();
            */
      
    </script>
        
    </form>

    </body>
    <script> 
        // Para el popup de SweetAlert
        toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": false,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };

        AdministrarProgVisita.onEasyFind_Selected = function (value, ItemBE) {
            var i = value;
        }

        AdministrarProgVisita.onDisplayTemplateUsuUNIX = function (ul, item) {
            alert(item.IDAREA);
            var cmll = "\"";
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '         <div class= "flex-column">' + item.NombreArea
                + '             <p><small style="font-weight: bold">User:</small> <small style ="color:red">' + item.IDAREA + '</small><br>'
                //    + '             <img class=" rounded-circle" width="60px" src="' + Descripcion_OT.PathFotosPersonal + item.NroDocIdentidad + '.jpg" alt="Usuario:=' + item.V_DESCRIPCION + '"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                + '         </div>'
                + '</a>';
            var oCustomTemplateBE = new EAC_Areas.CustomTemplateBE(ul, item, iTemplate);
            return EAC_Areas.SetCustomTemplate(oCustomTemplateBE);
        }
    </script>
</html>
