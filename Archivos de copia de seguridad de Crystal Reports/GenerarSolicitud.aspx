<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenerarSolicitud.aspx.cs" Inherits="SIMANET_W22R.GestionComercial.Administracion.GenerarSolicitud" %>

<%@ Register TagPrefix="cc1" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc2" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc5" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="uc1" TagName="header" Src="~/Controles/Header.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <!--   <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>

        function confirmGuardar() {
            Swal.fire({
                title: '¿Está seguro?',
                text: "¿Desea guardar la solicitud?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Sí, guardar',
                cancelButtonText: 'Cancelar',
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33'
            }).then((result) => {
                if (result.isConfirmed) {

                    // llama al evento de boton de validar datos, que esta en el boton btnAgregar
                    document.getElementById('btnAgregar').click();
                    // Ejecutar Espera() antes del postback
                    Espera();

                }
            });

            return false;
        }

        function onEasy_Find(value, itemBE) {
            if (itemBE) {
                var clienteNombre = itemBE.CLIENTE;    // Nombre del cliente
                var clienteCodigo = itemBE.COD_CLIENTE; // Código del cliente

                setClienteAutocomplete(clienteCodigo, clienteNombre);
            }
        }

        function setClienteAutocomplete(clienteCodigo, clienteNombre) {

            acCliente.SetValue(clienteCodigo, clienteNombre);
            acCliente_Text.ReadOnly = true; // Aplica una clase CSS que desactive el control
            acCliente_Text.setAttribute("readonly", true); // Añade el atributo readonly al control

        }


        function onDisplayTemplateEmbarcacion(ul, item) {
            var iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '<div class="flex-column">'
                + '    <p><small style="font-weight: bold">NOMBRE:</small> <small style="color:black; text-transform: capitalize;">' + item.NOMBRE + '</small><br>'
                + '    <small style="font-weight: bold">Cod. Embarcacion:</small> <small style="color:red;">' + item.CODIGO + '</small><br>'
                + '    <small style="font-weight: bold">Cliente:</small> <small style="color:red;">' + item.CLIENTE + '</small><br>'
                + '</div>'
                + '</a>';

            var oCustomTemplateBE = new acEmbarcacion.CustomTemplateBE(ul, item, iTemplate);

            return acEmbarcacion.SetCustomTemplate(oCustomTemplateBE);
        }

    </script>
    <style>
        /* Estilos de error */
        .error {
            border: 2px solid red;
            box-shadow: 0 0 5px red;
        }
        /* Estilo para los asteriscos de los campos requeridos */
        .required-label:after {
            content: " *";
            color: red;
        }
    </style>

    <script>
        function Espera() {
            SIMA.Utilitario.Helper.Wait('Solicitud de Trabajo', 1000, function () { });
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%" border="0">
            <tr>
                <td>
                    <uc1:header runat="server" id="Header" idgestorfiltro="EasyGestorFiltro1" />
                </td>
            </tr>
            <tr>
                <td>
                    <div class="container">
                        <br />
                        <h2 style="text-align: center;"><strong>SOLICITUD DE TRABAJO</strong></h2>
                        <h5 style="text-align: center;">Generar Solicitud de Trabajo</h5>
                        <!--       <label id="nroSOL" style="align-content:center;text-align:center;font-weight:600 " runat="server"></label> -->
                        <asp:Label ID="lblnroSOL" runat="server" Style="align-content: center; text-align: center; font-weight: 600"></asp:Label>
                        &nbsp;<asp:Label ID="lblestado" runat="server"></asp:Label>
                        <hr />

                        <br />
                        <!-- Unidad Operativa 07.12.2024 -->
                        <div class="row">
                            <div class="col-md-6">
                                <cc1:EasyDropdownList ID="eDDLCentros" runat="server" CargaInmediata="True" Visible="false"
                                    DataTextField="NOMBRE" DataValueField="NROCENTROOPERATIVO"
                                    EnableOnChange="True" AutoPostBack="True">
                                    <EasyStyle Ancho="Uno"></EasyStyle>
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                        <Metodo>ListaCentrosOperativosPorPerfil</Metodo>
                                        <UrlWebServicieParams>
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdUsuario" Paramvalue="IdUsuario" TipodeDato="String" />
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                                </cc1:EasyDropdownList>

                                <label for="UnidadOpera" id="lblUnidadOpera" runat="server">Unidad Operativa</label>
                                <cc1:EasyDropdownList ID="ltUnidadOpe" runat="server" AutoPostBack="True"
                                    DisplayText="Unidad Operativa" Etiqueta="Unidad Operativa"
                                    EnableOnChange="True" Requerido="True" MensajeValida="Ingresar Unidad Operativa"
                                    OnSelectedIndexChanged="fnLineaNegocio" OnTextChanged="fnLineaNegocio" CargaInmediata="True"
                                    DataValueField="CODIGO" DataTextField="NOMBRE">
                                    <EasyStyle Ancho="Seis" />
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                        <Metodo>ListaUnidad_OpexCEO</Metodo>
                                        <UrlWebServicieParams>
                                            <cc5:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="sCodigo" Paramvalue="eDDLCentros" />
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                                </cc1:EasyDropdownList>
                            </div>
                        </div>
                        <!-- Línea de Negocio -->
                        <div class="row">
                            <div class="col-md-6">
                                <label for="lineaNegocio1">Línea de Negocio</label>
                                <cc1:EasyDropdownList ID="ltLineas" runat="server" AutoPostBack="True" DisplayText="Linea de Negocio"
                                    EnableOnChange="True" OnSelectedIndexChanged="fnSubLineaNegocio" OnTextChanged="fnSubLineaNegocio" CargaInmediata="True"
                                    Etiqueta="Linea de Negocio" Requerido="True"
                                    DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccione la Linea Negocio">
                                    <EasyStyle Ancho="Seis" />
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                        <Metodo>ListaLineasNegxCEOxUO</Metodo>
                                        <UrlWebServicieParams>
                                            <cc5:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_CEO" Paramvalue="eDDLCentros" TipodeDato="String" />
                                            <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_UNI_OPE" Paramvalue="ltUnidadOpe" TipodeDato="String" />
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />




                                        </UrlWebServicieParams>
                                    </DataInterconect>
                                </cc1:EasyDropdownList>
                            </div>

                            <div id="ctrlSublinea" runat="server" class="col-md-6">
                                <label for="lineaNegocio2">SubLinea de Negocio</label>
                                <cc1:EasyDropdownList ID="ltSubLinea" runat="server" DisplayText="SubLinea" EnableOnChange="False" CargaInmediata="True"
                                    Etiqueta="Linea de Negocio" Requerido="True"
                                    DataValueField="CODIGO" DataTextField="NOMBRE"
                                    MensajeValida="Seleccionar la Sublinea">
                                    <EasyStyle Ancho="Seis" />
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                        <Metodo>ListarSublineasxLinea</Metodo>
                                        <UrlWebServicieParams>
                                            <cc5:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="ceo" Paramvalue="ltUnidadOpe" />
                                            <cc5:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="s_linea" Paramvalue="ltLineas" />
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                                </cc1:EasyDropdownList>
                            </div>
                        </div>

                        <!-- Embarcación/Proyecto y Cliente -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label for="embarcacion">Embarcación / Proyecto</label>
                                <cc1:EasyAutocompletar ID="acEmbarcacion" runat="server" DisplayText="NOMBRE" ValueField="CODIGO"
                                    Etiqueta="Embarcacion / Proyecto" EnableOnChange="True"
                                    Placeholder="Seleccionar Embarcacion o Proyecto" NroCarIni="3"
                                    Requerido="True" fncTempaleCustom="onDisplayTemplateEmbarcacion"
                                    fnOnSelected="onEasy_Find">
                                    <EasyStyle Ancho="Nueve" />
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                        <Metodo>BusquedaEmbarcacion</Metodo>
                                        <UrlWebServicieParams>
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                                </cc1:EasyAutocompletar>
                            </div>
                            <div class="col-md-6">
                                <label for="cliente">Cliente</label>
                                <cc1:EasyAutocompletar ID="acCliente" runat="server" Etiqueta="Cliente" DisplayText="NOMBRE" ValueField="CODIGO"
                                    EnableOnChange="True"
                                    Placeholder="Seleccionar Cliente" NroCarIni="3"
                                    Requerido="True">
                                    <EasyStyle Ancho="Nueve" />
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                        <Metodo>ListaBuscarCliente2</Metodo>
                                        <UrlWebServicieParams>
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                                </cc1:EasyAutocompletar>
                            </div>
                        </div>

                        <!-- Información de Solicitud -->
                        <h3 class="mt-4">INFORMACIÓN DE SOLICITUD</h3>
                        <div class="row">
                            <div class="col-md-3">
                                <label for="tipoSolicitud">Tipo de Solicitud</label>
                                <cc1:EasyDropdownList ID="ltTipoSolicitud" runat="server" DisplayText="Tipo de Solicitud" CargaInmediata="True" Etiqueta="Tipo de Solicitud" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccionar Tipo de Solicitud">
                                    <EasyStyle Ancho="Seis" />
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                        <Metodo>ListarTiposSolicitud</Metodo>
                                        <UrlWebServicieParams>
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                                </cc1:EasyDropdownList>
                            </div>
                            <div class="col-md-3">
                                <label for="tipoTrabajo">Tipo de Trabajo</label>
                                <cc1:EasyDropdownList ID="ltTipoTrabajo" runat="server" DisplayText="Tipo de Trabajo" CargaInmediata="True" Etiqueta="Tipo de Trabajo" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccionar Tipo de Trabajo">
                                    <EasyStyle Ancho="Tres" />
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                        <Metodo>ListarTiposTrabajo</Metodo>
                                        <UrlWebServicieParams>
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                                </cc1:EasyDropdownList>
                            </div>
                            <div class="col-md-6" id="ctrlASolicitante" runat="server">
                                <label for="solicitante">A. Solicitante</label>
                                <cc1:EasyDropdownList ID="ltAreaSolicitante" runat="server" DisplayText="Área Solictante" CargaInmediata="True" Etiqueta="A. Solicitante" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccionar Área">
                                    <EasyStyle Ancho="Seis" />
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                        <Metodo>ListarAreasxLinea</Metodo>
                                        <UrlWebServicieParams>
                                            <cc5:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="sLinea" Paramvalue="ltLineas" TipodeDato="String" />
                                            <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                                </cc1:EasyDropdownList>
                            </div>
                        </div>

                        <!-- Fecha, Presupuesto, Revisión -->
                        <div class="row mt-3">
                            <div class="col-md-4">
                                <label for="referencia">Referencia / Plano</label>
                                <cc1:EasyTextBox runat="server" ID="txtReferencia" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Referencia / Plano" MensajeValida="" Necesario="True" Rows="5" TextMode="SingleLine" MaxLength="50">
                                  <EasyStyle Ancho="Seis"></EasyStyle>
                                </cc1:EasyTextBox>
                            </div>
                            <div class="col-md-2">
                                <label for="fechaReferencia">Fecha Referencia</label>
                                <cc1:EasyDatepicker runat="server" ID="dtFecReferencia" Etiqueta="Fecha Referencia">
                                <EasyStyle Ancho="Dos"></EasyStyle>
                                </cc1:EasyDatepicker>
                            </div>
                            <div class="col-md-3">
                                <label for="presupuesto">Presupuesto</label>
                                <cc1:EasyTextBox runat="server" ID="txtPresupuesto" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Presupuesto" MensajeValida="" Requerido="True" Rows="5" TextMode="SingleLine" MaxLength="9">
                                    <EasyStyle Ancho="Dos"></EasyStyle>
                                </cc1:EasyTextBox>
                            </div>
                            <div class="col-md-3">
                                <label for="revision">Revisión</label>
                                <cc1:EasyTextBox runat="server" ID="txtRevision" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Revision" MensajeValida="" Requerido="True" Rows="5" TextMode="SingleLine" MaxLength="1"></cc1:EasyTextBox>
                            </div>
                        </div>

                        <!-- Actividad -->
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label for="observaciones">Actividad (Descripción)</label>
                                <cc1:EasyTextBox ID="txtActividad" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Actividad / Partida" MensajeValida="" Requerido="True" Rows="5" TextMode="SingleLine" MaxLength="50">
                                    <EasyStyle Ancho="Diez" TipoTalla="sm"></EasyStyle>
                                </cc1:EasyTextBox>
                            </div>
                        </div>

                        <!-- Observaciones -->
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label for="observaciones">Observacion</label>
                                <cc1:EasyTextBox ID="txtObservaciones" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Observaciones" MensajeValida="Observaciones" Requerido="True" Rows="5" TextMode="MultiLine" MaxLength="2000">
                                <EasyStyle Ancho="Doce" TipoTalla="sm"></EasyStyle>
                                </cc1:EasyTextBox>
                            </div>
                        </div>

                        <div id="secAlojamiento" runat="server">
                            <h3 class="mt-4">ESPECIFICACION DE ALOJAMIENTO</h3>
                            <div class="row mt-3">
                                <div class="col-md-4">
                                    <label for="observaciones">Clase Trabajo</label>
                                    <cc1:EasyDropdownList ID="ltClaseTrabajo" runat="server" DisplayText="Clase" EnableOnChange="False" CargaInmediata="True" Etiqueta="Clase" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccionar Clase">
                                        <EasyStyle Ancho="Dos" />
                                        <DataInterconect MetodoConexion="WebServiceInterno">
                                            <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                            <Metodo>ListarClasesTrabajo</Metodo>
                                            <UrlWebServicieParams>
                                                <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                            </UrlWebServicieParams>
                                        </DataInterconect>
                                    </cc1:EasyDropdownList>
                                </div>
                                <div class="col-md-4">
                                    <label for="observaciones">Dique</label>
                                    <cc1:EasyDropdownList ID="ltDiques" runat="server" DisplayText="Tipo de Trabajo" CargaInmediata="True" Etiqueta="Dique" Requerido="True"
                                        DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccionar Dique">
                                        <EasyStyle Ancho="Seis" />
                                        <DataInterconect MetodoConexion="WebServiceInterno">
                                            <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                            <Metodo>ListarDiquesCEO</Metodo>
                                            <UrlWebServicieParams>
                                                <cc5:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="ceo" Paramvalue="eDDLCentros" />
                                                <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                            </UrlWebServicieParams>
                                        </DataInterconect>
                                    </cc1:EasyDropdownList>
                                </div>
                                <div class="col-md-4">
                                    <label for="observaciones">Tarifas</label>
                                    <cc1:EasyDropdownList ID="ltTarifas" runat="server" DisplayText="Tarifas de Dique" CargaInmediata="True" Etiqueta="Tarifa" Requerido="True"
                                        DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccionar Tarifa">
                                        <EasyStyle Ancho="Seis" />
                                        <DataInterconect MetodoConexion="WebServiceInterno">
                                            <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                            <Metodo>ListarTarifas</Metodo>
                                            <UrlWebServicieParams>
                                                <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                            </UrlWebServicieParams>
                                        </DataInterconect>
                                    </cc1:EasyDropdownList>
                                </div>
                            </div>
                        </div>

                        <div id="secInfoOperativa" runat="server">
                            <h3 class="mt-4">INFORMACION OPERATIVA</h3>
                            <div class="row mt-3">
                                <div class="col-md-3">
                                    <label for="observaciones">Fecha / Hora Recepción</label>
                                    <!--
                                    <cc1:EasyDatepicker runat="server" ID="dtFecRecepcion" Etiqueta="Fecha / Hora Recepción">
                                        <EasyStyle Ancho="Dos"></EasyStyle>
                                    </cc1:EasyDatepicker>
                                        -->
                                    <input type="datetime-local" id="dtFecRecepcion1" runat="server" class="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label for="observaciones">Nro Sol. MGP</label>
                                    <cc1:EasyTextBox runat="server" ID="txtNroSolMgp" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Nro Sol. MGP" MensajeValida="" Requerido="True" Rows="5" TextMode="SingleLine" MaxLength="30">
                                        <EasyStyle Ancho="Seis"></EasyStyle>
                                    </cc1:EasyTextBox>
                                </div>
                                <div class="col-md-3">
                                    <label for="observaciones">Fecha Sol. MGP</label>
                                    <cc1:EasyDatepicker runat="server" ID="dtFecSolMgp" Etiqueta="Fecha Sol. MGP">
                                        <EasyStyle Ancho="Dos"></EasyStyle>
                                    </cc1:EasyDatepicker>
                                </div>
                                <div class="col-md-3">
                                    <label for="observaciones">Nro IBP</label>
                                    <cc1:EasyTextBox runat="server" ID="txtIbp" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Nro IBP" MensajeValida="" Requerido="True" Rows="5" TextMode="SingleLine" MaxLength="200">
                                        <EasyStyle Ancho="Seis"></EasyStyle>
                                    </cc1:EasyTextBox>
                                </div>
                            </div>
                        </div>

                        <div id="secMantenimiento" runat="server">
                            <h3 class="mt-4">MANTENIMIENTO</h3>
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <label for="observaciones">Equipo / Bien / Unidad</label>
                                    <cc1:EasyTextBox runat="server" ID="txtEquipo" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Equipo / Bien / Unidad" MensajeValida="" Requerido="True" Rows="5" TextMode="SingleLine" MaxLength="3">
                                        <EasyStyle Ancho="Seis"></EasyStyle>
                                    </cc1:EasyTextBox>
                                </div>
                                <div class="col-md-6">
                                    <label for="observaciones">Ubicacion Equipo</label>
                                    <cc1:EasyTextBox runat="server" ID="txtUbicacion" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Ubicacion Equipo" MensajeValida="" Requerido="True" Rows="5" TextMode="SingleLine" MaxLength="50">
                                        <EasyStyle Ancho="Seis"></EasyStyle>
                                    </cc1:EasyTextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-md-12 text-end">
                                <asp:Button ID="btnAgregar1" class="btn btn-primary" runat="server" OnClientClick="return confirmGuardar();" Text="Guardar" />
                                <asp:Button ID="btnAgregar" class="btn btn-primary" runat="server" OnClick="btn_Agregar_Post" Text="Guardar" Style="visibility: hidden; display: none;" />
                                <button id="btnRegresar" class="btn btn-secondary" onclick="history.back(); return false;">Cancelar</button>
                            </div>
                        </div>
                        <br />
                        <br />

                    </div>

                </td>
            </tr>
        </table>
    </form>
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
<script type="text/javascript">
    function changeBorderColor(element, eventType) {
        if (eventType === 'focus') {
            element.style.borderColor = 'red'; // Cambia a rojo cuando se recibe el foco
        } else if (eventType === 'blur') {
            element.style.borderColor = ''; // Restaura el borde cuando se pierde el foco
        }
    }
</script>
<script>
    $("[data-required='true']").on("blur", function () {
        validateRequiredField($(this));
    });

    // Función para validar los campos requeridos
    function validateRequiredField($field) {
        const fieldName = $field.attr("name");
        if ($field.val().trim() === "" || $field.val() == "-1") {
            $field.addClass("error");  // Agregar la clase de error si está vacío
            const mensaje = `Debe completar el campo: "${fieldName}"`;
            toastr.warning("", mensaje)
        } else {
            $field.removeClass("error");  // Quitar la clase de error si no está vacío
        }
    }

    //const requeridos = $('[data-required='true']').serializeArray();
    /*    const requeridos_sin_valor = requeridos.filter((item) => item.value.trim() == "")*/

    //if (requeridos_sin_valor.length > 0) {

    //    const mensaje = `Debe completar el campo: "${requeridos_sin_valor[0].name}"`;


    //    /*$(`[name="${requeridos_sin_valor[0].name}"]`).focus();*/
    //    $(`[name="${requeridos_sin_valor[0].name}"]`)
    //        //.css("border", "2px solid red")
    //        //.css("box-shadow", "0 0 5px red") // Efecto al borde
    //        .focus();
    //    return;
    //}

</script>
</html>
