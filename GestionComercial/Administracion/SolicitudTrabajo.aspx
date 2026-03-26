<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SolicitudTrabajo.aspx.cs" Inherits="SIMANET_W22R.GestionComercial.Administracion.SolicitudTrabajo" %>

<%@ Register TagPrefix="uc1" TagName="header" Src="~/Controles/Header.ascx" %>
<%@ Register TagPrefix="cc1" Assembly="EasyControlWeb" Namespace="EasyControlWeb" %>
<%@ Register TagPrefix="cc2" Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" %>
<%@ Register TagPrefix="cc3" Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" %>
<%@ Register TagPrefix="cc6" Assembly="EasyControlWeb" Namespace="EasyControlWeb" %>

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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Solicitud de Trabajo</title>
    
    <style>
      .__hide { display: none !important; }
    </style>

    <script>
        function Espera() {
            SIMA.Utilitario.Helper.Wait('Solicitud de Trabajo', 1000, function () { });
        }
        //

        // 1) Neutralizar beforeunload bloqueado
        window.onbeforeunload = null;

        // 2) Ocultar overlay “Wait…” siempre
        (function () {
            function hideWaitOverlay() {
                var nodes = document.querySelectorAll('div,section,article');
                nodes.forEach(n => {
                    var t = (n.innerText || '').toLowerCase();
                    if (t.includes('wait') || t.includes('redireccionando')) n.classList.add('__hide');
                });
            }
            window.addEventListener('load', hideWaitOverlay);
            setTimeout(hideWaitOverlay, 6000);
        })();

        // 3) Stubs para toastr / Swal si los CDNs fueron bloqueados
        if (typeof window.toastr === 'undefined') {
            window.toastr = { options: {}, info: console.log, success: console.log, warning: console.warn, error: console.error };
        }
        if (typeof window.Swal === 'undefined') {
            window.Swal = { fire: function (opts) { console.log('[Swal blocked]', opts); return Promise.resolve({}); } };
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 100%; overflow: auto;">
            <table id="tblReport" style="width: 100%; border-collapse: collapse;" border="0px">
                <tr>
                    <td colspan="7">
                        <uc1:header runat="server" ID="header" />
                    </td>
                </tr>
                <!-- 07 columnas -->
                <tr>
                    <td width="20px"></td>
                    <td width="10%">
                        <asp:Label ID="lblCEO" runat="server" Text="Centro Operativo: " Width="150px"></asp:Label><br />

                        <cc3:EasyDropdownList ID="eDDLCentros" runat="server" CargaInmediata="True" Width="150px"
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
                    <td width="15%">
                        <asp:Label ID="lblUO" runat="server" Text="Unidad Operativa: " Width="200px"></asp:Label><br />
                        <cc3:EasyDropdownList ID="eDDLUnidadO" runat="server" CargaInmediata="True" Width="150px"
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


                    <td width="150px">
                        <div>
                            <asp:Label ID="lblLineaN" runat="server" Text="Linea Negocio: " Style="display: inline-block;"></asp:Label>
                            <br />
                            <cc3:EasyDropdownList ID="eDDLLineas" runat="server" CargaInmediata="True"
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
                    <td width="20%">
                        <div>
                            <asp:Label ID="lblSLineaN" runat="server" Text="SubLinea Negocio: " Style="display: inline-block;"></asp:Label>
                            <br />
                            <cc3:EasyDropdownList ID="eDDLSubLinea" runat="server" CargaInmediata="True"
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
                    <td width="40%">
                        <asp:Label ID="lblbusqueda" runat="server" Text="Criterio Búsqueda: "></asp:Label><br />
                        <cc3:EasyTextBox ID="etbCriterio" runat="server" onkeydown="checkEnter(event)" Width="35%" Style="display: inline-block;"></cc3:EasyTextBox>
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="button-celeste" Icono="fa fa-search" OnClick="btnBuscar_Click" OnClientClick="Espera();" />

                    </td>


                    <td width="20px"></td>
                </tr>

                <tr>
                    <td width="20px"></td>
                    <td colspan="5">
                        <cc6:EasyGridView ID="EGVsolicitudes" runat="server" CssClass="STgridview"
                            AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Solicitudes de Trabajo"
                            ToolBarButtonClick="OnEasyGridButton_Click" Width="100%"
                            AllowPaging="True" PageSize="10"
                            OnPageIndexChanging="EasyGridView1_PageIndexChanged"
                            OnEasyGridDetalle_Click="EGVsolicitudes_EasyGridDetalle_Click" OnEasyGridButton_Click="EGVsolicitudes_EasyGridButton_Click">
                            <EasyGridButtons>
                                <cc1:EasyGridButton Id="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Texto="Agregar" Ubicacion="Izquierda" />
                                <cc1:EasyGridButton Id="btnDetCostos" Descripcion="" Icono="fa fa-money" MsgConfirm="" RunAtServer="True" Texto="Det. Costos" Ubicacion="Centro" />
                                <cc1:EasyGridButton Id="btnDetMateriales" Descripcion="" Icono="fa fa-wrench" MsgConfirm="" RunAtServer="True" Texto="Det. Materiales" Ubicacion="Centro" />
                            </EasyGridButtons>

                            <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                            <DataInterconect MetodoConexion="WebServiceInterno">
                                <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                <Metodo>ListarSolicitudTrabajo2</Metodo>
                                <UrlWebServicieParams>
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="V_AMBIENTE" Paramvalue="" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_FILTRO" Paramvalue="etbCriterio" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_CEO" Paramvalue="eDDLCentros" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_UND_OPER" Paramvalue="eDDLUnidadO" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_LINEA" Paramvalue="eDDLSubLinea" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="V_FEC_STR_INI" Paramvalue="" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="V_FEC_STR_FIN" Paramvalue="" TipodeDato="String" />
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                </UrlWebServicieParams>
                            </DataInterconect>

                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>
                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                            <Columns>
                                <asp:BoundField DataField="NroSolicitud" HeaderText="N° SOLICITUD" />
                                <asp:BoundField DataField="Linea" HeaderText="LINEA" />
                                <asp:BoundField DataField="Cliente" HeaderText="CLIENTE" />
                                <asp:BoundField DataField="Embarcacion / Proyecto" HeaderText="EMBARCACION / PROYECTO" />
                                <asp:BoundField DataField="TipoSolicitud" HeaderText="TIPO SOLICITUD" />
                                <asp:BoundField DataField="Actividad" HeaderText="ACTIVIDAD" />
                                <asp:BoundField DataField="Estado" HeaderText="ESTADO" />
                                <asp:BoundField DataField="UsuarioReg" HeaderText="U. REGISTRO" />
                                <asp:BoundField DataField="FechaReg" HeaderText="F. REGISTRO" />
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
    </form>

    <script type="text/javascript">

        SolicitudTrabajo.onEasyFind_Selected = function (value, ItemBE) {

        }
    </script>
</body>
<script>
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
</script>
</html>
