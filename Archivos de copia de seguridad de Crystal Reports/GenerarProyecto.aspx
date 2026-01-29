<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenerarProyecto.aspx.cs" Inherits="SIMANET_W22R.GestionComercial.Administracion.GenerarProyecto" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>

<%@ Register TagPrefix="uc1" TagName="Header" Src="~/Controles/Header.ascx" %>

<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/bootstrap.min.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/StyleEasy.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/Personalizado.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/toastr.min.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/font-awesome.min.css") %> ">

<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<script src="<%= ResolveUrl("~/Recursos/js/jquery-3.6.4.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Recursos/js/bootstrap.bundle.min.js") %>"></script>
<!-- (opcional, si FixSIMA necesita $.confirm) -->
<script src="<%= ResolveUrl("~/Recursos/js/jquery-confirm.min.js") %>"></script>
<!--  referencias ya existentes desde el Header 
    <script src="<%= ResolveUrl("~/Recursos/LibSIMA/FixSIMA.js") %>"></script>
     <script src="<%= ResolveUrl("~/Recursos/LibSIMA/AccesoDatosBase.js") %>"></script>
        -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        .texto-moneda {
            display: block;
            width: 100%;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            font-family: inherit; /* Igual que otros controles */
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da; /* Gris claro */
            border-radius: 0.25rem; /* Bordes redondeados */
            box-shadow: none;
            outline: none;
        }
    </style>
    <script>
        function Espera() {
            SIMA.Utilitario.Helper.Wait('Proyectos', 1000, function () { });
        }

        function GenerarCodigoProyecto(value, itemBE) {
            if (txtModo.value == "N") {
                //El codigo de proyecto solo se genera si se esta registrando un nuevo proyecto
                document.getElementById('btnGenProyectoID').click();
            }

        }
        function mostrarMensajeExito(x, id_proyecto) {
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
                mensaje = "¿Esta seguro que desea registrar el proyecto?";
            } else {
                mensaje = "¿Esta seguro que desea actualizar la informacion del proyecto?";
            }

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
                    document.getElementsByName('btnRegistrar')[0].click();
                }
            });
            return false;
        }
        function EasyPopupAdenda_Aceptar() {
            var mensaje;
            if (epuAdenda_txtFlag.value == "2") {
                mensaje = "¿Esta seguro de modificar la Adenda?";
            } else {
                mensaje = "¿Esta seguro de registrar la Adenda?";
            }

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
                    RegistrarOActualizarAdenda();
                }
            });

        }
        function RegistrarOActualizarAdenda() {
            //  location.reload();
            var x;
            var msg;
            if (OnValidate()) {

                switch (epuAdenda_txtFlag.value) {
                    case "1":
                        x = InsertarAdenda();
                        msg = 'Adenda registrada satisfactoriamente';
                        break;
                    case "2":
                        x = ActualizarAdenda()
                        msg = 'Adenda actualizada satisfactoriamente';
                        break;

                }

                if (x == '1') {
                    Swal.fire({
                        title: 'Exito',
                        text: msg,
                        icon: 'success',
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            //Ejecuta la funcion ActualizarGrillaAdendas del lado del servidor
                            document.getElementsByName('btnActualizarGrillaAdendas')[0].click();
                            epuAdenda.Close();
                        }
                    });

                } else {
                    Swal.fire({
                        title: "Error",
                        text: "Se presento un error al registrar la adenda",
                        icon: "error"
                    });

                }

            }
        }
        function OnValidate() {
            var msgText = "";
            var flag = 0;
            if (epuAdenda_txtPopMontoContractual.GetText().length == 0) {
                var flag = 1;
                toastr.error('El campo Monto es obligatorio ', 'Requerido');
                document.getElementById('epuAdenda_txtPopMontoContractual').focus();
                document.getElementById('epuAdenda_txtPopMontoContractual').style.borderColor = 'red';
            } else {
                document.getElementById('epuAdenda_txtPopMontoContractual').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            }

            if (epuAdenda_ltPopMoneda.value == "-1") {
                var flag = 1;
                toastr.error('El campo moneda es obligatorio', 'Requerido');
                document.getElementById('epuAdenda_ltPopMoneda').focus();
                document.getElementById('epuAdenda_ltPopMoneda').style.borderColor = 'red';
            } else {
                document.getElementById('epuAdenda_ltPopMoneda').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            }

            if (flag == 1) {
                return false;
            }
            return true;
        }
        function InsertarAdenda() {

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionComercial/Proceso.asmx";
            oEasyDataInterConect.Metodo = "Insert_Update_AdendaProyecto";

            var oParamCollections = new SIMA.ParamCollections();

            var oParam = new SIMA.Param("X_V_PROYADE_CODPRY", epuAdenda_txtPopcodProyecto.value);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_N_PROYADE_NROADENDA", "");
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_N_PROYADE_MONTO", epuAdenda_txtPopMontoContractual.GetText().trim());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_V_PROYADE_MONEDA", epuAdenda_ltPopMoneda.value);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("opcion", "1");
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);

            var Result = oEasyDataResult.sendData();
            return Result;
        }
        function ActualizarAdenda() {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionComercial/Proceso.asmx";
            oEasyDataInterConect.Metodo = "Insert_Update_AdendaProyecto";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("X_V_PROYADE_CODPRY", epuAdenda_txtPopcodProyecto.value);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_N_PROYADE_NROADENDA", epuAdenda_txtIDAdenda.value);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_N_PROYADE_MONTO", epuAdenda_txtPopMontoContractual.GetText().trim());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_V_PROYADE_MONEDA", epuAdenda_ltPopMoneda.value);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("opcion", "2");
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);

            var Result = oEasyDataResult.sendData();

            return Result;
        }
        // funcion para mostrar valores en una ventana emergente
        function onGridAdendaDetalle_click(AdendaBE) {
            epuAdenda.Show();
            epuAdenda_txtIDAdenda.value = AdendaBE.N_PROYADE_NROADENDA;
            epuAdenda_txtPopMontoContractual.value = AdendaBE.N_PROYADE_MONTO;
            epuAdenda_ltPopMoneda.value = AdendaBE.V_PROYADE_MONEDA;
            epuAdenda_txtFlag.value = "2";
            epuAdenda_txtPopcodProyecto.value = AdendaBE.V_PROYADE_CODPRY;
            //console.log("test4", GenerarCliente.Params[GenerarCliente.KEYMODOPAGINA]);
            // ShowContacto("M", GenerarCliente.Params["V_CLIENTE_ID"], ContactoBE)
        }
        function mostrarPopup() {

            if (typeof epuColaboradores !== "undefined") {
                epuColaboradores.Show(); // Muestra el popup
            } else {
                console.warn("Popup 'epuColaboradores' no está definido aún.");
            }
        }

        // Esta función puedes usarla desde algún botón o evento del cliente

        // para dar formato a la moneda


        /*
        function formatearMonedaPersonalizada(input) {
            let valor = input.value.replace(/[^\d]/g, '');
            if (valor === '') {
                input.value = '';
                return;
            }
  
            let numero = parseFloat(valor) / 100;
            let partes = numero.toFixed(2).split('.');
            let entero = partes[0];
            let decimal = partes[1];
  
            // Separar millones con apóstrofe, miles con coma
            let enteroFormateado = '';
            if (entero.length > 6) {
                let millones = entero.slice(0, entero.length - 6);
                let miles = entero.slice(entero.length - 6, entero.length - 3);
                let centenas = entero.slice(entero.length - 3);
                enteroFormateado = millones + '’' + miles + ',' + centenas;
            } else if (entero.length > 3) {
                let miles = entero.slice(0, entero.length - 3);
                let centenas = entero.slice(entero.length - 3);
                enteroFormateado = miles + ',' + centenas;
            } else {
                enteroFormateado = entero;
            }
  
            input.value = enteroFormateado + '.' + decimal;
        }
        */

        function formatearMonedaPersonalizada(input) {
            let valor = input.value.replace(/[^0-9.]/g, '');
            if (valor === '') {
                input.value = '';
                return;
            }

            let numero = parseFloat(valor);
            if (isNaN(numero)) {
                input.value = '';
                return;
            }

            // Convertir a string con dos decimales
            let partes = numero.toFixed(2).split('.');
            let entero = partes[0];
            let decimal = partes[1];

            // Formatear entero con apóstrofe para millones y coma para miles
            let enteroFormateado = '';
            if (entero.length > 6) {
                let millones = entero.slice(0, entero.length - 6);
                let miles = entero.slice(entero.length - 6, entero.length - 3);
                let centenas = entero.slice(entero.length - 3);
                enteroFormateado = millones + '’' + miles + ',' + centenas;
            } else if (entero.length > 3) {
                let miles = entero.slice(0, entero.length - 3);
                let centenas = entero.slice(entero.length - 3);
                enteroFormateado = miles + ',' + centenas;
            } else {
                enteroFormateado = entero;
            }

            input.value = enteroFormateado + '.' + decimal;
        }

        function aplicarFormatoMoneda() {
            document.querySelectorAll('.texto-moneda').forEach(function (input) {
                formatearMonedaPersonalizada(input);
                input.addEventListener('input', function () {
                    formatearMonedaPersonalizada(input);
                });
            });
        }




        // Compatible con UpdatePanel
        if (typeof Sys !== 'undefined') {
            Sys.Application.add_load(aplicarFormatoMoneda);
        } else {
            document.addEventListener('DOMContentLoaded', aplicarFormatoMoneda);
        }


    </script>
    <style>
        .btn-binocular::before {
            font-family: FontAwesome;
            content: "\f1e5"; /* Unicode del ícono de binoculares */
            margin-right: 6px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />

        <table style="width: 100%" border="0">
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" />
                </td>
            </tr>
            <tr>
                <!-- ***  INICIO CONETENEDOR  ****  -->
                <td>
                    <div class="container">
                        <br />
                        <h2 style="text-align: center;">
                            <asp:Label class="" ID="lblTitulo" runat="server" Text="">Proyecto</asp:Label></h2>
                        <!--    <h5 style="text-align:center;">  -->
                        <!-- CODIGO DEL PROYECTO -->

                        <div class="form-inline justify-content-center mb-3">
                            <asp:Label ID="lblSubtitulo" runat="server" CssClass="mr-2"></asp:Label>
                            <cc2:EasyTextBox ID="txtCodProyecto" runat="server" Visible="false"
                                CssClass="form-control form-control-sm text-primary font-weight-bold"
                                Style="width: 140px; font-size: 1.2rem" MaxLength="10" />
                        </div>

                        <div class="text-center">
                            <asp:Label ID="lblTotalProy" runat="server"></asp:Label>
                        </div>

                        <asp:Button ID="btnGenProyectoID" runat="server" Text="" CssClass="d-none" OnClick="GenProyectoId" />
                        <!--  </h5> -->

                        <hr />

                        <br />
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-3">
                                        <asp:Label ID="lblCEO" runat="server" Text="Centro Operativo: "></asp:Label><br />

                                        <cc2:EasyDropdownList ID="eDDLCentros" runat="server" CargaInmediata="True"
                                            DataTextField="NOMBRE" DataValueField="NROCENTROOPERATIVO"
                                            EnableOnChange="True" OnSelectedIndexChanged="fnRefrescaUO" AutoPostBack="True">
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
                                    <div class="col-md-3">
                                        <asp:Label ID="lblUO" runat="server" Text="Unidad Operativa: "></asp:Label><br />
                                        <cc2:EasyDropdownList ID="eDDLUnidadO" runat="server" CargaInmediata="True"
                                            DataTextField="NOMBRE" DataValueField="CODIGO"
                                            EnableOnChange="True" OnSelectedIndexChanged="fnRefrescaLN2" AutoPostBack="True">
                                            <EasyStyle Ancho="Uno"></EasyStyle>
                                            <DataInterconect MetodoConexion="WebServiceInterno">
                                                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                <Metodo>ListaUnidad_OpexCEO</Metodo>
                                                <UrlWebServicieParams>
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="sCodigo" Paramvalue="eDDLCentros" TipodeDato="String" />
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                </UrlWebServicieParams>
                                            </DataInterconect>
                                        </cc2:EasyDropdownList>

                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblLineaN" runat="server" Text="Linea Negocio: " Style="display: inline-block;"></asp:Label>
                                        <br />
                                        <cc2:EasyDropdownList ID="eDDLLineasN" runat="server" CargaInmediata="True" EnableOnChange="False"
                                            DataTextField="NOMBRE" DataValueField="CODIGO" AutoPostBack="True" OnSelectedIndexChanged="FnSublineas">
                                            <EasyStyle Ancho="Uno"></EasyStyle>
                                            <DataInterconect MetodoConexion="WebServiceInterno">
                                                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                <Metodo>ListaLineasNegxCEOxUO</Metodo>
                                                <UrlWebServicieParams>
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="FormControl"
                                                        ParamName="V_CEO" Paramvalue="eDDLCentros" TipodeDato="String" />
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="FormControl"
                                                        ParamName="V_UNDOPE" Paramvalue="eDDLUnidadO" TipodeDato="String" />
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="Session"
                                                        ParamName="USERNAME" Paramvalue="UserName" TipodeDato="String" />
                                                </UrlWebServicieParams>
                                            </DataInterconect>
                                        </cc2:EasyDropdownList>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblSublinea" runat="server">Sublinea</asp:Label>
                                        <cc2:EasyDropdownList ID="eDDLSubLineasN" runat="server" CargaInmediata="True"
                                            DataTextField="NOMBRE" DataValueField="CODIGO">
                                            <EasyStyle Ancho="Uno"></EasyStyle>
                                            <DataInterconect MetodoConexion="WebServiceInterno">
                                                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                <Metodo>ListaSubLineasNegxCEOxUOxL</Metodo>
                                                <UrlWebServicieParams>
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_CEO" Paramvalue="eDDLCentros" TipodeDato="String" />
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_UNDOPE" Paramvalue="eDDLUnidadO" TipodeDato="String" />
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_LINEA" Paramvalue="eDDLLineasN" TipodeDato="String" />
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="USERNAME" Paramvalue="UserName" TipodeDato="String" />
                                                </UrlWebServicieParams>
                                            </DataInterconect>
                                        </cc2:EasyDropdownList>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <asp:Label ID="lblClienteId" runat="server">Cliente</asp:Label>
                                        <cc2:EasyAutocompletar ID="acCliente" runat="server" Etiqueta="Cliente" DisplayText="NOMBRE" ValueField="CODIGO"
                                            EnableOnChange="True" fnOnSelected="GenerarCodigoProyecto"
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
                                    <div class="col-md-6 ">
                                        <asp:Label ID="lblCorreo" runat="server">Correo</asp:Label>
                                        <cc2:EasyTextBox ID="txtCorreo" runat="server"></cc2:EasyTextBox>
                                    </div>
                                    <div class="col-md-0 d-none">
                                        <asp:Label ID="lblBarcoId" runat="server">Id_Barco</asp:Label>
                                        <cc2:EasyTextBox ID="txtBarcoId" runat="server"></cc2:EasyTextBox>
                                    </div>


                                </div>

                                <div class="row">
                                    <div class="col-md-3">
                                        <asp:Label ID="lblFechaIni" runat="server">Fecha Inicio</asp:Label>
                                        <cc2:EasyDatepicker ID="dpcFechaIni" runat="server" FormatoFecha="dd/mm/yyyy" Hoy="" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False">
                                        </cc2:EasyDatepicker>

                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblFechaFin" runat="server">Fecha Fin</asp:Label>
                                        <cc2:EasyDatepicker ID="dpcFechaFin" runat="server" FormatoFecha="dd/mm/yyyy" Hoy="" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False">
                                        </cc2:EasyDatepicker>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblMonto" runat="server">Monto Contractual  (sin IGV)</asp:Label>
                                        <cc2:EasyTextBox ID="txtMontoContr" runat="server" TextMode="SingleLine" CssClass="texto-moneda"></cc2:EasyTextBox>

                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblMoneda" runat="server">Moneda</asp:Label>
                                        <cc2:EasyDropdownList ID="ltMoneda" runat="server" CargaInmediata="True"
                                            DataTextField="NOMBRE" DataValueField="CODIGO"
                                            EnableOnChange="True" AutoPostBack="True">
                                            <EasyStyle Ancho="Uno"></EasyStyle>
                                            <DataInterconect MetodoConexion="WebServiceInterno">
                                                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                <Metodo>ListaMonedas41</Metodo>
                                                <UrlWebServicieParams>
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                </UrlWebServicieParams>
                                            </DataInterconect>
                                        </cc2:EasyDropdownList>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <asp:Label ID="lblJefeProyecto" runat="server">Jefe proyecto (busque por PR o cod O7)</asp:Label>
                                        <!--   <cc2:EasyTextBox ID="txtJefePry" runat="server"  autocomplete="off" CssClass="form-control" data-validate="true"  Requerido="False" Etiqueta=""></cc2:EasyTextBox> -->
                                        <cc2:EasyAutocompletar ID="EAC_usuarios" runat="server" Width="35%" DisplayText="NOMBRES" ValueField="CODTRA"
                                            fnOnSelected="Personal_Pry.onEasyFind_Selected"
                                            fncTempaleCustom="Personal_Pry.onDisplayTemplateUsuUNIX"
                                            MensajeValida="Este dato es obligatorio" EnableOnChange="True" Etiqueta="Usuario Jefe Proyecto">
                                            <EasyStyle Ancho="Dos" TipoTalla="sm"></EasyStyle>
                                            <DataInterconect MetodoConexion="WebServiceInterno">
                                                <UrlWebService>/GestionProyecto/Proyecto.asmx</UrlWebService>
                                                <Metodo>ListaColaboradores</Metodo>
                                                <UrlWebServicieParams>
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                </UrlWebServicieParams>
                                            </DataInterconect>
                                        </cc2:EasyAutocompletar>

                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="Label2" runat="server">N° Convenio</asp:Label>
                                        <cc2:EasyTextBox ID="txtConvenio" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-6">
                                        <asp:Label ID="lblDescripcion" runat="server">Descripcion</asp:Label>
                                        <cc2:EasyTextBox ID="txtDescripcion" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblEstadoPry" runat="server">Estado</asp:Label>
                                        <!-- <cc2:EasyTextBox ID="txtEstadoPry" runat="server"  autocomplete="off" CssClass="form-control" data-validate="true"  Requerido="False" Etiqueta=""></cc2:EasyTextBox>                          -->
                                        <cc2:EasyDropdownList ID="ltEstadoPr" runat="server" CargaInmediata="True"
                                            DataTextField="NOMBRE" DataValueField="CODIGO"
                                            EnableOnChange="True" AutoPostBack="True">
                                            <EasyStyle Ancho="Uno"></EasyStyle>
                                            <DataInterconect MetodoConexion="WebServiceInterno">
                                                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                <Metodo>ListaEstadosProyectos</Metodo>
                                                <UrlWebServicieParams>
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                </UrlWebServicieParams>
                                            </DataInterconect>
                                        </cc2:EasyDropdownList>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblTipo" runat="server">Tipo</asp:Label>
                                        <cc2:EasyDropdownList ID="ltTipoPry" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Estado" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccione tipo">
                                            <DataInterconect MetodoConexion="WebServiceInterno">
                                                <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                <Metodo>listaTipoProyecto</Metodo>
                                                <UrlWebServicieParams>
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_CEO" Paramvalue="eDDLCentros" TipodeDato="String" />
                                                    <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                </UrlWebServicieParams>
                                            </DataInterconect>
                                        </cc2:EasyDropdownList>
                                    </div>
                                </div>

                                <br />
                                <!--  BLOQUE DETALLES DE LA EMBARCACION  -->
                                <div class="row">
                                    <div class="card">
                                        <div class="card-header">Detalles embarcación</div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <asp:Label ID="lblEslora" runat="server">Eslora Total (LOA – Length Overall)</asp:Label>
                                                    <cc2:EasyTextBox ID="txtEslora" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <asp:Label ID="lblEslora2" runat="server">Eslora entre Perpendiculares (LBP)</asp:Label>
                                                    <cc2:EasyTextBox ID="txtEslora2" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <asp:Label ID="lblManga" runat="server">Manga</asp:Label>
                                                    <cc2:EasyTextBox ID="txtManga" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <asp:Label ID="lblPuntal" runat="server">Puntal</asp:Label>
                                                    <cc2:EasyTextBox ID="txtPuntal" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <asp:Label ID="lblBogega" runat="server">Bodega</asp:Label>
                                                    <cc2:EasyTextBox ID="txtBodega" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <asp:Label ID="Label1" runat="server">Calado_de_diseño</asp:Label>
                                                    <cc2:EasyTextBox ID="txtCalado" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <asp:Label ID="lblNumeroCasco" runat="server">Numero_casco</asp:Label>
                                                    <cc2:EasyTextBox ID="txtNumeroCasco" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--  termina el detalle de la embarcion   -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <asp:Label ID="lblObservacion" runat="server">Observacion</asp:Label>
                                        <cc2:EasyTextBox ID="txtObservacion" MaxLength="199" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <asp:Label ID="Label27" runat="server">Alias del Convenio (opcional, agrupador de Proyectos)</asp:Label>
                                        <cc2:EasyTextBox ID="txtAlias" MaxLength="4" runat="server" autocomplete="off" CssClass="form-control col-md-4" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <!--  DATA ESPECIAL -->
                        <div class="row w-100">

                            <div id="accordionEmbarcacion" class="w-100">
                                <div class="card w-100">
                                    <div class="card-header" id="headingOne">

                                        <button class="btn btn-link text-dark font-weight-bold p-0 row"
                                            type="button"
                                            data-toggle="collapse"
                                            data-target="#collapseOne"
                                            aria-expanded="false"
                                            aria-controls="collapseOne"
                                            style="text-decoration: none; width: 100%; text-align: left; cursor: pointer">
                                            Reforma Industrial
                              <span class="float-right">&#9662;</span>
                                            <!-- flecha ▼ -->
                                        </button>

                                    </div>

                                    <div id="collapseOne"
                                        class="collapse w-100"
                                        aria-labelledby="headingOne"
                                        data-parent="#accordionEmbarcacion">
                                        <div class="card-body">
                                            <div class="row">

                                                <table style="width: 90%">
                                                    <!--  AGENTE EXTRANJERO -->
                                                    <tr>
                                                        <td colspan="12" class="text-center font-weight-bold">
                                                            <asp:Label ID="Label5" runat="server" Text="Agente Impulsor Extranjero (AIE) - Reforma Industrial" />
                                                            <br />
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td colspan="12">
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <!--  fila titulos 1 -->
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label8" runat="server" Text="Monto Destinado" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label9" runat="server" Text="Monto Ejecutado" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label6" runat="server" Text="Crecimiento Empresas productoras locales" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label10" runat="server" Text="Empresas importadoras conexas en mercado local" />
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <!-- contenido -->
                                                    <tr>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtmontoAIE" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox></td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtmontoEjeAIE" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox></td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtCntEPLC" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtCntEICML" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td colspan="5"></td>

                                                    </tr>

                                                    <tr>
                                                        <td colspan="12"></td>
                                                    </tr>
                                                    <!--  GRUPO: CONTRATOS CON EMPRESAS -->
                                                    <!--  fila titulos 2 -->
                                                    <tr>
                                                        <td colspan="6">
                                                            <asp:Label ID="Label30" runat="server" Text="Contratos firmados Empresa Local con Agente IE." />
                                                        </td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtContratoFAIE" runat="server" autocomplete="off" CssClass="form-control"
                                                                data-validate="true" Requerido="False" Etiqueta="" Enabled="false"></cc2:EasyTextBox>
                                                        </td>
                                                        <td colspan="5"></td>
                                                    </tr>
                                                    <!-- contenido 2 -->
                                                    <tr>
                                                        <td colspan="12"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"></td>
                                                        <td colspan="7" class="col-md-8">
                                                            <asp:Label ID="Label11" runat="server">Empresa</asp:Label>
                                                            <cc2:EasyAutocompletar ID="EasyAutocompletar1" runat="server"
                                                                Etiqueta="Empresa" DisplayText="NOMBRE" ValueField="CODIGO"
                                                                EnableOnChange="True" fnOnSelected="GenerarCodigoProyecto"
                                                                Placeholder="Seleccionar Empresa" NroCarIni="3"
                                                                Requerido="True">
                                                                <EasyStyle Ancho="Nueve" />
                                                                <DataInterconect MetodoConexion="WebServiceInterno">
                                                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                                    <Metodo>ListaProveedores</Metodo>
                                                                    <UrlWebServicieParams>
                                                                        <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                                    </UrlWebServicieParams>
                                                                </DataInterconect>
                                                            </cc2:EasyAutocompletar>
                                                        </td>
                                                        <td>
                                                            <br />
                                                            <asp:Button ID="BtnAgregarECF" runat="server" Text="+"
                                                                OnClick="btnGaleria_Click" ToolTip="Adicionar Empresa que firmó contrato con el Agente IE" class="button-celeste" />

                                                        </td>
                                                        <td colspan="2"></td>
                                                    </tr>

                                                    <!--   grilla empresas firmaron contrato     -->
                                                    <tr>
                                                        <td colspan="2"></td>
                                                        <td colspan="8">
                                                            <cc4:EasyGridView ID="EGVempresasFC" runat="server" CssClass="STgridview"
                                                                AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Transferencia de Tecnología"
                                                                AllowPaging="True" PageSize="7" Width="100%"
                                                                ToolBarButtonClick="OnEasyGridButton_Click"
                                                                OnPageIndexChanging="EasyGridOTsProyecto_PageIndexChanged"
                                                                OnEasyGridButton_Click="EasyGridOTsProyecto_EasyGridButton_Click">

                                                                <EasyGridButtons>
                                                                </EasyGridButtons>
                                                                <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                                                <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowCellItemClick=""
                                                                    IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>
                                                                <DataInterconect MetodoConexion="WebServiceInterno">
                                                                    <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                                    <Metodo>ListarOtSPorProyecto</Metodo>
                                                                    <UrlWebServicieParams>

                                                                        <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_COD_PRY" Paramvalue="txtCodProyecto" />

                                                                    </UrlWebServicieParams>
                                                                </DataInterconect>


                                                                <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                                                                <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                                                                <Columns>
                                                                    <asp:BoundField DataField="COD_OTS" HeaderText="RUC" />
                                                                    <asp:BoundField DataField="NRO_VAL_TBJ" HeaderText="Razon Social" />
                                                                </Columns>

                                                                <HeaderStyle CssClass="HeaderGrilla" />
                                                                <PagerStyle HorizontalAlign="Center" />
                                                                <RowStyle CssClass="ItemGrilla" Height="25px" />
                                                            </cc4:EasyGridView>
                                                        </td>
                                                        <td colspan="2"></td>
                                                    </tr>

                                                    <!--  GRUPO: PROXIMOS CONTRATOS CON EMPRESAS -->
                                                    <!--  fila titulos 3 -->
                                                    <tr>
                                                        <td colspan="6">
                                                            <asp:Label ID="Label12" runat="server" Text="Próximo Contratos firmados Empresa Local con Agente IE." />
                                                        </td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtProxContrato" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox></td>
                                                        <td colspan="5"></td>

                                                    </tr>
                                                    <!-- contenido 3 -->
                                                    <tr>
                                                        <td colspan="12"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"></td>
                                                        <td colspan="7" class="col-md-8">
                                                            <asp:Label ID="Label26" runat="server">Empresa</asp:Label>
                                                            <cc2:EasyAutocompletar ID="EACempresasP" runat="server"
                                                                Etiqueta="Empresa" DisplayText="NOMBRE" ValueField="CODIGO"
                                                                EnableOnChange="True" fnOnSelected="GenerarCodigoProyecto"
                                                                Placeholder="Seleccionar Empresa" NroCarIni="3"
                                                                Requerido="True">
                                                                <EasyStyle Ancho="Nueve" />
                                                                <DataInterconect MetodoConexion="WebServiceInterno">
                                                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                                    <Metodo>ListaProveedores</Metodo>
                                                                    <UrlWebServicieParams>
                                                                        <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                                                    </UrlWebServicieParams>
                                                                </DataInterconect>
                                                            </cc2:EasyAutocompletar>
                                                        </td>
                                                        <td>
                                                            <br />
                                                            <asp:Button ID="BtnAgregarPCE" runat="server" Text="+"
                                                                OnClick="btnGaleria_Click" ToolTip="Adicionar Empresa que firmó contrato con el Agente IE" class="button-celeste" />

                                                        </td>
                                                        <td colspan="2"></td>
                                                    </tr>
                                                    <!--   grilla empresas que posteriormente firmaran contrato     -->
                                                    <tr>
                                                        <td colspan="2"></td>
                                                        <td colspan="8">
                                                            <cc4:EasyGridView ID="EasyGridView1" runat="server" CssClass="STgridview"
                                                                AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Transferencia de Tecnología"
                                                                AllowPaging="True" PageSize="7" Width="100%"
                                                                ToolBarButtonClick="OnEasyGridButton_Click"
                                                                OnPageIndexChanging="EasyGridOTsProyecto_PageIndexChanged"
                                                                OnEasyGridButton_Click="EasyGridOTsProyecto_EasyGridButton_Click">

                                                                <EasyGridButtons>
                                                                </EasyGridButtons>
                                                                <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                                                <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowCellItemClick=""
                                                                    IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>
                                                                <DataInterconect MetodoConexion="WebServiceInterno">
                                                                    <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                                    <Metodo>ListarOtSPorProyecto</Metodo>
                                                                    <UrlWebServicieParams>

                                                                        <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_COD_PRY" Paramvalue="txtCodProyecto" />

                                                                    </UrlWebServicieParams>
                                                                </DataInterconect>


                                                                <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                                                                <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                                                                <Columns>
                                                                    <asp:BoundField DataField="COD_OTS" HeaderText="RUC" />
                                                                    <asp:BoundField DataField="NRO_VAL_TBJ" HeaderText="Razon Social" />
                                                                </Columns>

                                                                <HeaderStyle CssClass="HeaderGrilla" />
                                                                <PagerStyle HorizontalAlign="Center" />
                                                                <RowStyle CssClass="ItemGrilla" Height="25px" />
                                                            </cc4:EasyGridView>
                                                        </td>
                                                        <td colspan="2"></td>
                                                    </tr>


                                                    <!-- TRANSFERENCIA -->
                                                    <tr>
                                                        <td>
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="12" class="text-center font-weight">
                                                            <asp:Label ID="Label22" runat="server" Text="Transferencia de Tecnología del AIE " />
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <!--  fila titulos-->
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label23" runat="server" Text="Categoría" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label24" runat="server" Text="Monto Asignado" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label25" runat="server" Text="Monto Ejecutado" />
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>

                                                    </tr>
                                                    <!-- contenido -->
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>

                                                            <cc2:EasyDropdownList ID="EDDLcategoria" runat="server" DisplayText="Tipo" EnableOnChange="False" CargaInmediata="True" Etiqueta="Estado" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccione tipo">
                                                                <DataInterconect MetodoConexion="WebServiceInterno">
                                                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                                    <Metodo>ListaCategoriasTransferenciaDT</Metodo>
                                                                    <UrlWebServicieParams>
                                                                        <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                                    </UrlWebServicieParams>
                                                                </DataInterconect>
                                                            </cc2:EasyDropdownList>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtMontoAsig" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="MontoEjec" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Button ID="BtnAgregarTT" runat="server" Text="+"
                                                                OnClick="btnGaleria_Click" ToolTip="Adicionar Monto de Transferencia de Tecnología" class="button-celeste" />

                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>

                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <!--  GRILLA TRANSFERENCIA  -->
                                                        <td colspan="10" id="COL3_10grillaTT">
                                                            <cc4:EasyGridView ID="EGVtt" runat="server" CssClass="STgridview"
                                                                AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Transferencia de Tecnología"
                                                                AllowPaging="True" PageSize="7" Width="100%"
                                                                ToolBarButtonClick="OnEasyGridButton_Click"
                                                                OnPageIndexChanging="EasyGridOTsProyecto_PageIndexChanged"
                                                                OnEasyGridButton_Click="EasyGridOTsProyecto_EasyGridButton_Click">

                                                                <EasyGridButtons>
                                                                </EasyGridButtons>
                                                                <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                                                <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowCellItemClick=""
                                                                    IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>
                                                                <DataInterconect MetodoConexion="WebServiceInterno">
                                                                    <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                                    <Metodo>ListarOtSPorProyecto</Metodo>
                                                                    <UrlWebServicieParams>

                                                                        <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_COD_PRY" Paramvalue="txtCodProyecto" />

                                                                    </UrlWebServicieParams>
                                                                </DataInterconect>


                                                                <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                                                                <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                                                                <Columns>

                                                                    <asp:BoundField DataField="COD_OTS" HeaderText="TIPO" />
                                                                    <asp:BoundField DataField="NRO_VAL_TBJ" HeaderText="Monto Asignado" />
                                                                    <asp:BoundField DataField="FEC_REG" HeaderText="Monto Ejecutado" />
                                                                    <asp:BoundField DataField="DES_DET" HeaderText="Monto Pendiente" />
                                                                </Columns>

                                                                <HeaderStyle CssClass="HeaderGrilla" />
                                                                <PagerStyle HorizontalAlign="Center" />
                                                                <RowStyle CssClass="ItemGrilla" Height="25px" />
                                                            </cc4:EasyGridView>
                                                        </td>
                                                    </tr>

                                                    <!--  AGENTE NACIONAL -->
                                                    <tr>
                                                        <td colspan="12" id="COL12_TIT_AN">
                                                            <br />
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="12" class="text-center font-weight-bold" id="col12_tit_AIN">
                                                            <br />
                                                            <asp:Label ID="Label3" runat="server" Text="Agente Impulsor Nacional - Reforma Industrial" />
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="12">
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <!--  fila titulos-->
                                                    <tr>

                                                        <td>
                                                            <asp:Label ID="Label4" runat="server" Text="Monto Destinado" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label7" runat="server" Text="Monto Ejecutado" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label13" runat="server" Text="Monto Inversión Local" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label14" runat="server" Text="Empresas Contratadas" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label15" runat="server" Text="Empleos Generados" />
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <!-- contenido -->
                                                    <tr>

                                                        <td>
                                                            <cc2:EasyTextBox ID="txtmontoAIN" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtmontoEjeAIN" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox></td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtMontoIL" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtEmpresasCont" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtEmplesoGen" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>

                                                    <!-- *** Generacion de empleo **** -->
                                                    <tr>
                                                        <td colspan="12">
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="12" class="text-center font-weight">
                                                            <asp:Label ID="Label16" runat="server" Text="Generación de Empleo" />
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="12">
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <!--  fila titulos-->
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label18" runat="server" Text="Mano de obra directa contratada" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label19" runat="server" Text="MOb Servicios Especializados" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label20" runat="server" Text="MOb Bienes especializados" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label21" runat="server" Text="Servicios Indirectos" />
                                                        </td>
                                                        <td></td>
                                                        <td colspan="2">
                                                            <asp:Label ID="Label17" runat="server" Text="Total Empleos Directos e Indirectos" />
                                                        </td>
                                                    </tr>
                                                    <!-- contenido -->
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtMOBDC" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox></td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtMOBSE" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox></td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtMOBBE" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtSI" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox></td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtTotalEDI" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <!--  fila titulos-->
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label28" runat="server" Text="MOb Servicios Especializados por Agente Impulsor" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label29" runat="server" Text="MOb Bienes especializados por Agente Impulsor" />
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td colspan="2"></td>
                                                    </tr>
                                                    <!-- contenido -->
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtMOBseai" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox></td>
                                                        <td></td>
                                                        <td>
                                                            <cc2:EasyTextBox ID="txtMOBbeai" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta=""></cc2:EasyTextBox>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>

                                                </table>

                                            </div>
                                            <!-- cierre de .row dentro del card-body -->
                                        </div>
                                        <!-- cierre de .card-body -->
                                    </div>
                                    <!-- cierre de #collapseOne -->
                                </div>
                                <!-- cierre de .card  w-100 -->
                            </div>
                            <!-- cierre de #accordionEmbarcacion -->

                        </div>
                        <!-- cierre de row w-100"  -->

                        <br />
                        <!-- FILA DE BOTONES DE ACCION -->
                        <div class="row">
                            <div class="col-md-12 mt-4" style="display: flex; justify-content: flex-end; gap: 20px; flex-wrap: nowrap;">

                                <asp:Button ID="BtnGaleria" runat="server" Text="Galeria"
                                    OnClick="btnGaleria_Click" ToolTip="Galería de imagenes del proyecto" class="button-celeste" />


                                <asp:Button ID="BtnDocumentos" runat="server" Text="Documentos" Style="margin-right: 30px;"
                                    OnClick="btnDocumentos_Click" ToolTip="Documento del proyecto" class="button-celeste" />

                                <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="button-celeste" ToolTip="Insertar/Actualizar Registro"
                                    Style="margin-right: 30px;" OnClientClick="return ConfirmarRegistroOActualizacion();" />


                                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="button-celeste" OnClick="btnCancelar_Click" ToolTip="Cancelar acción" class="btn btn-secondary" />

                                <asp:Button ID="btnRegistrar" runat="server" CssClass="btn-servidor" Style="display: none;" OnClick="RegistrarProyecto" />

                                <asp:Button ID="btnPersonal" runat="server" Text="Personal"
                                    OnClick="btnPersonal_Click" ToolTip="Listado del Personal para el proyecto" class="button-celeste" />


                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                <asp:HiddenField ID="txtProyectoID" runat="server" />
                            </div>
                        </div>


                        <br />
                        <br />
                        <asp:HiddenField ID="txtModo" runat="server" />

                    </div>
                    <!--Aca cierra el contenedor -->

                </td>
            </tr>

            <!--  **************** OTS ******************* -->
            <tr>
                <td colspan="12">
                    <hr />
                    <hr />
                    <p style="margin: 20px 100px;" class="h5 text-center">
                        <asp:Label ID="lblTituloOT" runat="server" Text="Lista de Ordenes de Trabajo" CssClass="h5 text-center"></asp:Label>
                    </p>

                    <!--   acordeon de OT -->

                    <div class="accordion" id="accordionOT">
                        <div class="card">
                            <div class="card-header" id="headingOT">
                                <button class="btn btn-link text-dark font-weight-bold p-0 row"
                                    type="button"
                                    data-toggle="collapse" data-target="#collapseOT"
                                    aria-expanded="false" aria-controls="collapseOT"
                                    style="text-decoration: none; width: 100%; text-align: left; cursor: pointer;">
                                    OT´s
                                      <span class="float-right">&#9662;</span>
                                </button>
                            </div>

                            <div id="collapseOT" class="collapse" aria-labelledby="headingOT" data-parent="#accordionOT">
                                <div class="card-body">
                                    <!-- Aquí va tu contenido actual -->
                                    <div style="display: flex; justify-content: center; margin: 0px 100px;">
                                        <table style="width: 90%">
                                            <tr>
                                                <td>

                                                    <cc4:EasyGridView ID="EasyGridOtsProyecto" runat="server" CssClass="STgridview"
                                                        AutoGenerateColumns="False" ShowFooter="True" TituloHeader="OTs"
                                                        AllowPaging="True" PageSize="7" Width="100%"
                                                        ToolBarButtonClick="OnEasyGridButton_Click"
                                                        OnPageIndexChanging="EasyGridOTsProyecto_PageIndexChanged"
                                                        OnEasyGridButton_Click="EasyGridOTsProyecto_EasyGridButton_Click">

                                                        <EasyGridButtons>
                                                        </EasyGridButtons>
                                                        <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                                        <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowCellItemClick=""
                                                            IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>
                                                        <DataInterconect MetodoConexion="WebServiceInterno">
                                                            <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                                            <Metodo>ListarOtSPorProyecto</Metodo>
                                                            <UrlWebServicieParams>

                                                                <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_COD_PRY" Paramvalue="txtCodProyecto" />

                                                            </UrlWebServicieParams>
                                                        </DataInterconect>


                                                        <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                                                        <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                                                        <Columns>
                                                            <asp:BoundField DataField="DESCRIPCION" HeaderText="CEO" />
                                                            <asp:BoundField DataField="COD_OTS" HeaderText="Ots" />
                                                            <asp:BoundField DataField="NRO_VAL_TBJ" HeaderText="Nro_val" />
                                                            <asp:BoundField DataField="UNIDAD" HeaderText="Unidad" />
                                                            <asp:BoundField DataField="FEC_REG" HeaderText="Fecha registro" />
                                                            <asp:BoundField DataField="DES_DET" HeaderText="Descripción" />
                                                            <asp:BoundField DataField="COSTO_EJECUTADO" HeaderText="Costo Ejecutado" DataFormatString="{0:C}" HtmlEncode="false" />
                                                            <asp:BoundField DataField="COSTO_ESTIMADO" HeaderText="Costo Estimado" DataFormatString="{0:C}" HtmlEncode="false" />
                                                            <asp:BoundField DataField="ESTADO_OT" HeaderText="Estado OT" />
                                                            <asp:BoundField DataField="ESTADO_FINAC" HeaderText="Estado Finaciero" />

                                                        </Columns>

                                                        <HeaderStyle CssClass="HeaderGrilla" />
                                                        <PagerStyle HorizontalAlign="Center" />
                                                        <RowStyle CssClass="ItemGrilla" Height="25px" />
                                                    </cc4:EasyGridView>
                                                </td>

                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--  Fin acordeon OT    -->
                </td>


            </tr>
            <!--  **************** ADENDAS ******************* -->
            <tr>
                <td>
                    <p style="margin: 20px 100px;" class="h5 text-center">Lista de Adendas</p>
                    <div style="display: flex; justify-content: center; margin: 0px 100px;">
                        <table style="width: 90%">
                            <tr>
                                <td>
                                    <cc4:EasyGridView ID="EasyGridAdendas" runat="server" CssClass="STgridview"
                                        AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Adendas"
                                        ToolBarButtonClick="OnEasyGridButton_Click" Width="100%"
                                        OnEasyGridButton_Click="EasyGridAdendas_EasyGridButton_Click"
                                        AllowPaging="True" PageSize="7" OnPageIndexChanging="EasyGridAdendas_PageIndexChanged">

                                        <EasyGridButtons>
                                            <cc4:EasyGridButton Id="btnAgregarAdenda" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Texto="Agregar" Ubicacion="Izquierda" />
                                            <cc4:EasyGridButton Id="btnEliminarAdenda" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Texto="Eliminar" Ubicacion="Izquierda" />
                                        </EasyGridButtons>
                                        <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                        <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66"
                                            RowCellItemClick="onGridAdendaDetalle_click" IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>
                                        <DataInterconect MetodoConexion="WebServiceInterno">
                                            <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                            <Metodo>ListarAdendasPorProyecto</Metodo>
                                            <UrlWebServicieParams>

                                                <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_COD_PRY" Paramvalue="txtCodProyecto" />

                                            </UrlWebServicieParams>
                                        </DataInterconect>


                                        <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                                        <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                                        <Columns>
                                            <asp:BoundField DataField="N_PROYADE_MONTO" HeaderText="Monto" />
                                            <asp:BoundField DataField="V_PROYADE_MONEDA" HeaderText="Moneda" />
                                            <asp:BoundField DataField="D_PROYADE_FECHA" HeaderText="Fecha" />
                                        </Columns>

                                        <HeaderStyle CssClass="HeaderGrilla" />
                                        <PagerStyle HorizontalAlign="Center" />
                                        <RowStyle CssClass="ItemGrilla" Height="25px" />
                                    </cc4:EasyGridView>

                                </td>
                            </tr>
                        </table>
                    </div>

                </td>
            </tr>
        </table>

        <cc2:EasyPopupBase ID="epuAdenda" runat="server" Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Datos de la Adenda"
            RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupAdenda_Aceptar">
            <table style="width: 100%;">

                <asp:HiddenField ID="txtFlag" runat="server" />
                <asp:HiddenField ID="txtIDAdenda" runat="server" />
                <asp:HiddenField ID="txtPopcodProyecto" runat="server" />


                <tr>
                    <td width="20px"></td>
                    <td style="width: 26%;">
                        <asp:Label ID="lblPopMontoContractual" runat="server" Text="Monto Contractual"></asp:Label></td>
                    <td>
                        <cc2:EasyTextBox ID="txtPopMontoContractual" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Etiqueta="Nombres"></cc2:EasyTextBox>
                    </td>
                    <td width="20px"></td>
                </tr>
                <tr>

                    <td width="20px"></td>
                    <td style="width: 26%;">
                        <asp:Label ID="lblPopMoneda" runat="server" Text="Moneda"></asp:Label></td>
                    <td>
                        <cc2:EasyDropdownList ID="ltPopMoneda" runat="server" DisplayText="Cargo" CargaInmediata="True" Etiqueta="" Requerido="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccione cargo">
                            <DataInterconect MetodoConexion="WebServiceInterno">
                                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                <Metodo>ListaMonedas41</Metodo>
                                <UrlWebServicieParams>
                                    <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                </UrlWebServicieParams>
                            </DataInterconect>
                        </cc2:EasyDropdownList>
                    </td>
                    <td width="20px"></td>
                </tr>
            </table>

        </cc2:EasyPopupBase>
        <asp:Button ID="btnActualizarGrillaAdendas" runat="server" CssClass="btn-servidor" Style="display: none;" OnClick="ActualizarGrillaAdendas" />


        <!-- Popup con ModalExtender o simplemente un div visible con JS -->
        <asp:HiddenField ID="hfMostrarPopup" runat="server" />
        <cc2:EasyPopupBase ID="epuColaboradores" runat="server" Titulo="Colaboradores del Proyecto" Modal="fullscreen">
            <asp:Panel ID="pnlColaboradores" runat="server" CssClass="popupPanel">
                <h3>Gestión de Colaboradores</h3>

                <asp:Label runat="server" Text="PR:" Width="100px" />
                <asp:TextBox ID="txtPR" runat="server" Width="80px" MaxLength="9" />
                <asp:Label runat="server" Text="CodTrabajador:" />
                <asp:TextBox ID="txtCodTra" runat="server" Width="80px" MaxLength="9" />
                <button id="BtnBuscarCola" runat="server" class="button-celeste" title="Buscar Colaborador en O7" onserverclick="BtnBuscar_Colaborador">
                    <i class="fa fa-binoculars"></i>Buscar
                </button>
                <asp:Label runat="server" ID="lblTrabajador" />
                <br />
                <asp:Label runat="server" Text="Fecha Ingreso:" />
                <asp:TextBox ID="dtFechaIngreso" runat="server" Width="90px" />
                <ajaxtoolkit:calendarextender
                    id="CalendarExtender1"
                    runat="server"
                    targetcontrolid="dtFechaIngreso"
                    format="dd/MM/yyyy" />
                <asp:Label runat="server" Text="Fecha Cese:" />
                <asp:TextBox ID="dtFechaCese" runat="server" Width="90px" />
                <ajaxtoolkit:calendarextender
                    id="CalendarExtender2"
                    runat="server"
                    targetcontrolid="dtFechaCese"
                    format="dd/MM/yyyy" />



                <asp:Button ID="btnAgregarColaborador" runat="server" Text="Agregar / Actualizar" OnClick="btnAgregarColaborador_Click" class="button-celeste" />
                <br />
                <asp:Label ID="lblmensaje" runat="server"
                    Text="<i class='fa fa-info-circle'></i> "
                    CssClass="mensaje" />

                <div style="max-height: 300px; overflow-y: auto; border: 1px solid #ccc;">
                    <cc4:EasyGridView ID="EasyGridColaboradores" runat="server" CssClass="STgridview"
                        AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Colaboradores"
                        ToolBarButtonClick="OnEasyGridButton_Click" Width="100%"
                        AllowPaging="True" PageSize="7" OnPageIndexChanging="EasyGridColProyecto_PageIndexChanged"
                        OnEasyGridButton_Click="EasyGridColProyecto_EasyGridButton_Click"
                        OnEasyGridDetalle_Click="EGV_EasyGridDetalle_Click">
                        <EasyGridButtons>
                            <cc4:EasyGridButton Id="btnEliminarCol" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Texto="Eliminar" Ubicacion="Izquierda" />
                        </EasyGridButtons>
                        <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                        <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>
                        <DataInterconect MetodoConexion="WebServiceInterno">
                            <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                            <Metodo>Listar_ColaboradoresProyecto</Metodo>
                            <UrlWebServicieParams>
                                <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_SUCURSAL" Paramvalue="eDDLCentros" TipodeDato="String" />
                                <cc3:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_PROYECTO" Paramvalue="txtCodProyecto" />

                            </UrlWebServicieParams>
                        </DataInterconect>


                        <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                        <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                        <Columns>
                            <asp:BoundField DataField="V_COLPROY_PR" HeaderText="PR" />
                            <asp:BoundField DataField="V_COLPROY_CODTRA" HeaderText="COD_TRA" />
                            <asp:BoundField DataField="PERSONAL" HeaderText="Colaborador" />
                            <asp:BoundField DataField="DT_COLPROY_INGRESO" HeaderText="Fecha Ingreso" />
                            <asp:BoundField DataField="DT_COLPROY_CESE" HeaderText="Fecha Cese" />
                        </Columns>

                        <HeaderStyle CssClass="HeaderGrilla" />
                        <PagerStyle HorizontalAlign="Center" />
                        <RowStyle CssClass="ItemGrilla" Height="25px" />
                    </cc4:EasyGridView>

                </div>

                <asp:Button ID="btnCerrarPopup" runat="server" Text="Cerrar" class="button-celeste" OnClick="btnCerrarPopup_Click" OnClientClick="document.getElementById('pnlColaboradores').style.display='none'; return false;" />
                <br />
            </asp:Panel>
        </cc2:EasyPopupBase>

        <!-- ********************  SCRIPT PARA EL FUNCIONAMIENTO         *********************  -->
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


            // **************** BLOQUE DE PROCEDIMIENTO Y FUNCIONES JAVASCRIPT ****************************************** 

            // Se implementa la funcion JS para usarlo en: 
            //    <cc2: EasyFiltroParamURLws ObtenerValor="FunctionScript" ParamName="v_ambiente" Paramvalue="Personal_Pry.ObteberAmbiente" TipodeDato="String">
            //    </cc2: EasyFiltroParamURLws >
            var Personal_Pry = Personal_Pry || {};
            Personal_Pry.ObtenerAmbiente = function () {
                return IMA.Utilitario.Helper.Configuracion.Leer("Seguridad", "Ambiente");
            }

            Personal_Pry.onEasyFind_Selected = function (value, ItemBE) {

            }
            Personal_Pry.onDisplayTemplateUsuUNIX = function (ul, item) {
                // según los campos que retorna la Función colocamos la data a retornar 
                var cmll = "\"";
                iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '         <div class="flex-column">' + item.NOMBRES
                    + '             <p><small style="font-weight: bold">CODTRA:</small> <small style="color:red">' + item.CODTRA + '</small><br>'
                    //    + '             <img class=" rounded-circle" width="60px" src="' + Personal_Pry.PathFotosPersonal + item.NroDocIdentidad + '.jpg" alt="Usuario:=' + item.V_DESCRIPCION + '" onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                    + '         </div>'
                    + '</a>';
                var oCustomTemplateBE = new EAC_usuarios.CustomTemplateBE(ul, item, iTemplate);
                return EAC_usuarios.SetCustomTemplate(oCustomTemplateBE);
            }

        </script>

    </form>
</body>
</html>
