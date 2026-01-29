<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenerarEmbarcacion2.aspx.cs" Inherits="SIMANET_W22R.GestionComercial.Administracion.GenerarEmbarcacion2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>

<%@ Register TagPrefix="uc1" TagName="Header" Src="~/Controles/Header.ascx" %>

<!DOCTYPE html>

<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/StyleEasy.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/Personalizado.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/toastr.min.css") %> ">
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<script src="<%= ResolveUrl("~/Recursos/js/jquery-3.6.4.min.js") %>"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>


    <script>
        function llenarTxtBarcoId(value, ItemBE) {
            debugger;
            // Llamar a la función en el servidor usando AJAX
            PageMethods.ObtenerBarcoPorCliente(value, function (response) {
                jNet.get('txtBarcoId').text = response;
            }, function (error) {
                console.error("Error: " + error.get_message());
            });
        }
        function mostrarMensajeExito(x, V_EMBARCACION_ID) {
            Swal.fire({
                title: 'Exito',
                text: x,
                icon: 'success',
                showCancelButton: false,
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                allowOutsideClick: false
            }).then((result) => {
                if (result.isConfirmed) {



                    // document.getElementsByName('btnRedirigir')[0].click();
                }
            });

            return false;

        }

        function ConfirmarRegistroOActualizacion() {
            var mensaje;
            if (document.getElementById('txtModo').value == "N") {
                mensaje = "¿Esta seguro que desea registrar la embarcacion?";
            } else {
                mensaje = "¿Esta seguro que desea actualizar la informacion de la embarcacion?";
            }
            debugger;
            Swal.fire({
                title: '¿Está seguro?',
                text: mensaje,
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Sí',
                cancelButtonText: 'Cancelar',
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33'
            }).then((result) => {
                if (result.isConfirmed) {
                    /*
                    if (document.getElementById('txtModo').value == "M") {
                        debugger;
                        //Ejecuta el metodo ActualizarCliente del lado del servidor
                        document.getElementsByName('btnActualizar')[0].click();
                    } else {
                        //Ejecuta el metodo RegistrarCliente del lado del servidor
                        document.getElementsByName('btnRegistrar')[0].click();

                    }*/
                    document.getElementsByName('btnRegistrar')[0].click();
                }
            });
            return false;
        }

        function formatToTwoDecimals(input) {
            // Obtén el valor del campo
            let value = input.value.trim();

            // Intenta convertir el valor a un número
            let number = parseFloat(value);

            // Si es un número válido, formatea a dos decimales
            if (!isNaN(number)) {
                input.value = number.toFixed(2); // Formatea a 2 decimales
            } else {
                input.value = '0.00'; // Si no es válido, deja el campo vacío
                toastr.error('Por favor, ingrese un número válido.')
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%" border="0">
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" />

                </td>
            </tr>
            <tr>
                <td>
                    <asp:ScriptManager runat="server" />
                    <asp:UpdatePanel runat="server" ID="updPanel1">
                        <ContentTemplate>
                            <div class="container">
                                <br />
                                <h2 style="text-align: center;">
                                    <asp:Label class="" ID="lblTitulo" runat="server" Text="Label"></asp:Label></h2>
                                <h5 style="text-align: center;">
                                    <asp:Label Style="text-align: center;" ID="lblSubtitulo" runat="server" Text="Label"></asp:Label>
                                </h5>

                                <hr />

                                <br />
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="row">
                                            <div class="col-md-7">
                                                <asp:Label ID="lblClienteId" runat="server">Cliente</asp:Label>
                                                <cc2:EasyAutocompletar ID="acCliente" runat="server" Etiqueta="Cliente" DisplayText="NOMBRE" ValueField="CODIGO"
                                                    EnableOnChange="True"
                                                    Placeholder="Seleccionar Cliente" NroCarIni="3"
                                                    Requerido="True">
                                                    <EasyStyle Ancho="Nueve" />
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                        <Metodo>ListaBuscarCliente3</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyAutocompletar>


                                            </div>
                                            <div class="col-md-5">
                                                <asp:Label ID="lblBarcoId" runat="server">Id_Barco</asp:Label>
                                                <cc2:EasyTextBox ID="txtBarcoId" runat="server"></cc2:EasyTextBox>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <asp:Label ID="lblNombre" runat="server">Nombre</asp:Label>
                                                <cc2:EasyTextBox ID="txtNombre" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>

                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="lblNombreAnterior" runat="server">Nombre Anterior</asp:Label>
                                                <cc2:EasyTextBox ID="txtNombreAnterior" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                            </div>


                                        </div>
                                        <div class="row">
                                            <div class="col-md-5">
                                                <asp:Label ID="lblTipo" runat="server">Procedencia Cliente</asp:Label>
                                                <cc2:EasyDropdownList ID="ltTipo" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Ingresar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                        <Metodo>Lista_get_tabgeneral</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="N_TAB" Paramvalue="6" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="C_ESTA" Paramvalue="ACT" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                            <div class="col-md-7">
                                                <asp:Label ID="lblAstillero" runat="server">Astillero Const</asp:Label>
                                                <cc2:EasyTextBox ID="txtAstillero" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-5">
                                                <asp:Label ID="lblMatricula" runat="server">Matricula</asp:Label>
                                                <cc2:EasyTextBox ID="txtMatricula" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                            </div>
                                            <div class="col-md-7">
                                                <asp:Label ID="lblTipoEmb" runat="server">Tipo Embarc</asp:Label>
                                                <cc2:EasyDropdownList ID="ltTipoEmbarc" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Ingresar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                        <Metodo>Lista_get_tabgeneral</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="N_TAB" Paramvalue="8" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="C_ESTA" Paramvalue="ACT" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <asp:Label ID="lblToMatricula" runat="server">toMatricula</asp:Label>
                                                <cc2:EasyTextBox ID="txtToMatricula" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label ID="lblCentroOpera" runat="server">Centro operativo
                                                    <asp:Label ID="lbCod_Und" Style="color: red;" runat="server"> </asp:Label>
                                                </asp:Label>
                                                <cc2:EasyDropdownList ID="eDDLCentros" runat="server" CargaInmediata="True"
                                                    DataTextField="NOMBRE" DataValueField="NROCENTROOPERATIVO"
                                                    EnableOnChange="True" OnSelectedIndexChanged="fnRefrescaLN" OnTextChanged="fnRefrescaLN" AutoPostBack="True">
                                                    <EasyStyle Ancho="Uno"></EasyStyle>
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                        <Metodo>ListaCentrosOperativosPorPerfil</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdUsuario" Paramvalue="IdUsuario" TipodeDato="String" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>

                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label ID="lblUnidOpera" runat="server">Unidad operativa                                             
                                                </asp:Label>
                                                <asp:Label ID="lblId_Embarcacion" Style="color: red;" runat="server"> </asp:Label>
                                                <cc2:EasyDropdownList ID="eDDLUnidadO" runat="server" CargaInmediata="True"
                                                    DataTextField="NOMBRE" DataValueField="CODIGO" AutoPostBack="True">
                                                    <EasyStyle Ancho="Uno"></EasyStyle>
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                        <Metodo>ListaUnidad_OpexCEO</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="FormControl"
                                                                ParamName="sCodigo" Paramvalue="eDDLCentros" TipodeDato="String" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session"
                                                                ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <asp:Label ID="lblIdMaterial" runat="server">Id Material</asp:Label>
                                                <cc2:EasyDropdownList ID="ltIdMaterial" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Ingresar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                        <Metodo>Lista_get_tabgeneral</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="N_TAB" Paramvalue="200" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="C_ESTA" Paramvalue="ACT" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label ID="lblEstado" runat="server" Text="Estado"></asp:Label><br />
                                                <cc2:EasyDropdownList ID="ltEstado" runat="server" DisplayText="Estado" EnableOnChange="False" CargaInmediata="True" Etiqueta="Estado" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Ingresar estado">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                        <Metodo>Lista_get_tabgeneral</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="N_TAB" Paramvalue="39" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="C_ESTA" Paramvalue="ACT" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label ID="lblFechaRegistro" runat="server" Text="Fecha registro"></asp:Label><br />
                                                <cc2:EasyDatepicker ID="dpFechaRegistro" runat="server" FormatoFecha="dd/mm/yyyy" Hoy="" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False">
                                                </cc2:EasyDatepicker>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-md-8">
                                                <asp:Label ID="lblSistPesca" runat="server" Text="Sistema Pesca"></asp:Label><br />
                                                <cc2:EasyDropdownList ID="ltSistPesca" runat="server" DisplayText="Estado" EnableOnChange="False" CargaInmediata="True" Etiqueta="Estado" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Ingresar estado">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                        <Metodo>Lista_get_tabgeneral</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="N_TAB" Paramvalue="201" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="C_ESTA" Paramvalue="ACT" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                            <div class="col-md-4">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:Label ID="lblMotor" runat="server">Motor</asp:Label>
                                                <cc2:EasyTextBox ID="txtMotor" runat="server"></cc2:EasyTextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:Label ID="lblObservacion" runat="server">Observacion</asp:Label>
                                                <cc2:EasyTextBox ID="txtObservacion" runat="server"></cc2:EasyTextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 border" style="border: solid rgba(0, 0, 0, .1);">
                                        <div class="row">
                                            <p class="text-center font-weight-bold w-100 h6 m-0">Ficha Técnica de embarcación</p>
                                        </div>
                                        <div class="row">1. Eslora</div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <asp:Label ID="lblEslora" runat="server">Valor</asp:Label>
                                                <cc2:EasyTextBox ID="txtEslora" runat="server" onblur="formatToTwoDecimals(this)" Text="0.00"></cc2:EasyTextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="lblUm" runat="server">Um</asp:Label>
                                                <cc2:EasyDropdownList ID="ltUm1" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="UNIDAD_MEDIDA_CODIGO" DataTextField="UNIDAD_MEDIDA_DESCRIPCION" MensajeValida="Seleccionar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                        <Metodo>Listar_Tg_Unidad_Medida2</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="unidad" Paramvalue="LONGITUD" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                        </div>
                                        <div class="row">2. Manga</div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <asp:Label ID="lblManga" runat="server">Valor</asp:Label>
                                                <cc2:EasyTextBox ID="txtManga" runat="server" onblur="formatToTwoDecimals(this)" Text="0.00"></cc2:EasyTextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="lblUm2" runat="server">Um</asp:Label>
                                                <cc2:EasyDropdownList ID="ltUm2" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="UNIDAD_MEDIDA_CODIGO" DataTextField="UNIDAD_MEDIDA_DESCRIPCION" MensajeValida="Seleccionar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                        <Metodo>Listar_Tg_Unidad_Medida2</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="unidad" Paramvalue="LONGITUD" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                        </div>
                                        <div class="row">3. Puntal</div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <asp:Label ID="lblPuntal" runat="server">Valor</asp:Label>
                                                <cc2:EasyTextBox ID="txtPuntal" runat="server" onblur="formatToTwoDecimals(this)" Text="0.00"></cc2:EasyTextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="lblUm3" runat="server">Um</asp:Label>
                                                <cc2:EasyDropdownList ID="ltUm3" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="UNIDAD_MEDIDA_CODIGO" DataTextField="UNIDAD_MEDIDA_DESCRIPCION" MensajeValida="Seleccionar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                        <Metodo>Listar_Tg_Unidad_Medida2</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="unidad" Paramvalue="LONGITUD" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                        </div>
                                        <div class="row">4. Tonelaje Real Bruto</div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <asp:Label ID="lblTRB" runat="server">Valor</asp:Label>
                                                <cc2:EasyTextBox ID="txtTRB" runat="server" onblur="formatToTwoDecimals(this)" Text="0.00"></cc2:EasyTextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="lblUm4" runat="server">Um</asp:Label>
                                                <cc2:EasyDropdownList ID="ltUm4" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="UNIDAD_MEDIDA_CODIGO" DataTextField="UNIDAD_MEDIDA_DESCRIPCION" MensajeValida="Seleccionar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                        <Metodo>Listar_Tg_Unidad_Medida2</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="unidad" Paramvalue="PESO" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                        </div>
                                        <div class="row">5. Tonelaje Real Neto</div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <asp:Label ID="lblTRN" runat="server">Valor</asp:Label>
                                                <cc2:EasyTextBox ID="txtTRN" runat="server" onblur="formatToTwoDecimals(this)" Text="0.00"></cc2:EasyTextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="lblUm5" runat="server">Um</asp:Label>
                                                <cc2:EasyDropdownList ID="ltUm5" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="UNIDAD_MEDIDA_CODIGO" DataTextField="UNIDAD_MEDIDA_DESCRIPCION" MensajeValida="Seleccionar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                        <Metodo>Listar_Tg_Unidad_Medida2</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="unidad" Paramvalue="PESO" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                        </div>
                                        <div class="row">6. Bodega</div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <asp:Label ID="lblBodega" runat="server">Valor</asp:Label>
                                                <cc2:EasyTextBox ID="txtBodega" runat="server" onblur="formatToTwoDecimals(this)" Text="0.00"></cc2:EasyTextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="lblUm6" runat="server">Um</asp:Label>
                                                <cc2:EasyDropdownList ID="ltUm6" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="UNIDAD_MEDIDA_CODIGO" DataTextField="UNIDAD_MEDIDA_DESCRIPCION" MensajeValida="Seleccionar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                        <Metodo>Listar_Tg_Unidad_Medida2</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="unidad" Paramvalue="PESO" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                        </div>
                                        <div class="row">7. Area de construccion</div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <asp:Label ID="lblAreaConst" runat="server">Valor</asp:Label>
                                                <cc2:EasyTextBox ID="txtAreaConst" runat="server" onblur="formatToTwoDecimals(this)" Text="0.00"></cc2:EasyTextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="lblUm7" runat="server">Um</asp:Label>
                                                <cc2:EasyDropdownList ID="ltUm7" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Tipo" Requerido="True" DataValueField="UNIDAD_MEDIDA_CODIGO" DataTextField="UNIDAD_MEDIDA_DESCRIPCION" MensajeValida="Seleccionar tipo">
                                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                                        <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                        <Metodo>Listar_Tg_Unidad_Medida2</Metodo>
                                                        <UrlWebServicieParams>
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="unidad" Paramvalue="AREA" />
                                                            <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                        </UrlWebServicieParams>
                                                    </DataInterconect>
                                                </cc2:EasyDropdownList>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="row">
                                    <div style="display: flex; justify-content: right" class="col-md-12 mt-4">
                                        <asp:Button Style="margin-right: 30px;" ID="btnAceptar" runat="server" Text="Aceptar" CssClass="button-celeste"
                                            OnClientClick="return ConfirmarRegistroOActualizacion();" />

                                        <asp:Button class="btn btn-secondary" ID="btnCancelar" runat="server" Text="Cancelar" CssClass="button-celeste" OnClick="btnCancelar_Click" />

                                        <asp:Button ID="btnRegistrar" runat="server" CssClass="btn-servidor" Style="display: none;" OnClick="RegistrarEmbarcacion" />
                                        <asp:HiddenField ID="txtModo" runat="server" />
                                        <asp:HiddenField ID="txtEmbarcacionID" runat="server" />
                                    </div>
                                </div>
                                <br />
                                <br />

                            </div>
                            <!--Aca cieraa el contenedor -->
                        </ContentTemplate>
                    </asp:UpdatePanel>
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
</html>
