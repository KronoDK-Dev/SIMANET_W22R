<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenerarCliente.aspx.cs" Inherits="SIMANET_W22R.GestionComercial.Administracion.GenerarCliente" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/StyleEasy.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/Personalizado.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/toastr.min.css") %> ">
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<%= ResolveUrl("~/Recursos/js/jquery-3.6.4.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Recursos/js/toastr.min.js") %>"></script>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript">
        //Se ejecuta cada vez que el usuario teclee Enter en el campo RUC/DOC
        function executeOnEnter(event) {
            if (event.key === "Enter" && jNet.get('txtRucDoc').value.length >= 11) {
                event.preventDefault(); // Evita que el formulario se envíe automáticamente
                document.getElementById('btnBuscarRuc').click(); //Ejecuta la funcion buscarRuc del lado del servidor
            }
        }

        function rellenarCampoPais(cod_ubc) {
            ltPais.value = "702701";//PERU
            __doPostBack('btnSeleccionarCombosUbicacion', cod_ubc + "Pa");//Ejecuta la funcion SeleccionarCombosUbicacion del lado del servidor
        }

        function rellenarCampoDepartamento(cod_ubc) {
            ltDepartamento.value = cod_ubc.substring(0, 2);
            __doPostBack('btnSeleccionarCombosUbicacion', cod_ubc + 'De');//Ejecuta la funcion SeleccionarCombosUbicacion del lado del servidor
        }
        function rellenarCampoProvincia(cod_ubc) {
            ltProvincia.value = cod_ubc.substring(0, 4);
            __doPostBack('btnSeleccionarCombosUbicacion', cod_ubc + 'Pr');//Ejecuta la funcion SeleccionarCombosUbicacion del lado del servidor
        }

    </script>
    <script>

        function ShowContacto(Modo, Id, ContactoBE) {
            var Url = Page.Request.ApplicationPath + "/GestionComercial/Administracion/ContactoCliente.aspx"
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(GenerarCliente.KEYMODOPAGINA, Modo);
            oColletionParams.Add(oParam);
            oParam = new SIMA.Param("V_ClIENTE_ID", Id);
            oColletionParams.Add(oParam);

            if (Modo == "M") {
                oParam = new SIMA.Param("Nombre", ContactoBE.C_CLIE_NOMBRE.trim());
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param("Cargo", ContactoBE.C_CLIE_CODCARGO.trim());
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param("Email", ContactoBE.C_CLIE_EMAIL.trim());
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param("Telefono", ContactoBE.C_CLIE_TELEF1.trim());
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param("Movil", ContactoBE.C_CLIE_TELEF2.trim());
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param("Envio", ContactoBE.C_CLIE_TIPOENVIO.trim());
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param("FechaNac", ContactoBE.C_CLIE_FECHANAC.substring(0, 10).trim());
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param("IdContacto", ContactoBE.N_CLIE_IDCONTACTO.trim());
                oColletionParams.Add(oParam);
            }
            epuContactosClientes.Load(Url, oColletionParams, false);
        }
    </script>

    <script>
        //Esta funcion se ejecuta al dar clic al boton de id btnEliminarContacto
        //Retorna false para evitar el postback;
        function eliminar_contacto() {
            Swal.fire({
                title: '¿Está seguro?',
                text: '¿Esta seguro de eliminar contacto',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Sí',
                cancelButtonText: 'Cancelar',
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33'
            }).then((result) => {
                if (result.isConfirmed) {
                    //Ejecuta la funcion EliminarContacto del lado del servidor
                    document.getElementById('epuContactos_btnEliminarContacto1').click();
                }
            });
            return false;
        }
        //Esta funcion se ejecuta luego de haber eliminado el contacto del cliente
        //Si el contacto se elimino con exito, entonces exito es 1 , de lo contrario es 0
        //El valor de mensaje depende de si el contacto se elimino satisfactoriamente o no
        function mensajeEiminarContacto(mensaje, icono) {

            Swal.fire({
                title: 'Mensaje',
                text: mensaje,
                icon: icono,
                showCancelButton: false,
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#3085d6',
                allowOutsideClick: false
            }).then((result) => {
                if (result.isConfirmed) {
                    //Ejecuta la funcion ActualizarGrillaContactos del lado del servidor
                    document.getElementsByName('btnActualizarGrillaContactos')[0].click();
                    epuContactos.Close();
                }
            });

            return false;
        }

        function Espera() {
            SIMA.Utilitario.Helper.Wait('Actividades', 1000, function () { });
        }
        //Retorna false para evitar el postback
        function ConfirmarRegistroOActualizacion() {
            var mensaje;
            if (GenerarCliente.Params["Modo"] == "N") {
                mensaje = "¿Esta seguro que desea registrar el cliente?";
            } else {
                mensaje = "¿Esta seguro que desea actualizar la informacion del cliente?";
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

                    if (GenerarCliente.Params["Modo"] == "M") {

                        //Ejecuta el metodo ActualizarCliente del lado del servidor
                        document.getElementsByName('btnActualizar')[0].click();
                    } else {
                        //Ejecuta el metodo RegistrarCliente del lado del servidor
                        document.getElementsByName('btnRegistrar')[0].click();

                    }
                }
            });
            return false;
        }

        function mostrarMensajeExito(x, IDCliente) {
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
                    /*
                 const url = new URL(window.location.href);
                 var newUrl = url.origin + url.pathname + "?V_CLIENTE_ID="+IDCliente+"&Modo=M";
                 window.location.replace(newUrl);*/
                    document.getElementsByName('btnRedirigir')[0].click();
                }
            });

            return false;

        }

    </script>
    <script>             
        function OnEasyGridButton_Click(btnItem, DetalleBE) {
            // var otxtTipoOp = jNet.get('txtTipoOp');

            switch (btnItem.Id) {
                case "btnNuevoContacto":
                    //epuContactos_txtFlag.SetValue("N")
                    epuContactos_txtFlag.value = "N"
                    epuContactos_txtApellidosNombres.SetValue("");
                    epuContactos_ltCargo.value = -1;
                    epuContactos_txtCorreo.SetValue("@");
                    epuContactos_txtFijo.SetValue("");
                    epuContactos_txtMovil.SetValue("");
                    epuContactos_ltEnvios.selectedIndex = 7;
                    epuContactos_dpFechaNac.SetValue("");
                    document.getElementById('epuContactos_btnEliminarContacto').style.display = 'none';
                    // epuContactos_txtIDContacto.SetValue("");                          
                    epuContactos_txtIDContacto.value = ""
                    //jNet.get('txtApellidosNombres').focus();
                    document.getElementById('epuContactos_txtApellidosNombres').style.borderColor = 'rgba(0, 0, 0, 0.15)';
                    document.getElementById('epuContactos_ltCargo').style.borderColor = 'rgba(0, 0, 0, 0.15)';
                    document.getElementById('epuContactos_txtCorreo').style.borderColor = 'rgba(0, 0, 0, 0.15)';
                    document.getElementById('epuContactos_ltEnvios').style.borderColor = 'rgba(0, 0, 0, 0.15)';
                    document.getElementById('epuContactos_txtFijo').style.borderColor = 'rgba(0, 0, 0, 0.15)';
                    epuContactos.Show();
                    document.getElementById('epuContactos_txtApellidosNombres').focus();

                    break;

            }
        }
        function OnValidate() {
            var msgText = "";
            var flag = 0;
            if (epuContactos_txtApellidosNombres.GetText().length == 0) {
                var flag = 1;
                toastr.error('El campo apellidos y nombres es obligatorio ', 'Requerido');
                /*
                Swal.fire({
                    text: "El campo apellidos y nombres es obligatorio",
                    icon: 'warning'
                });*/
                // foco en el control, pero para ello activar en el control la propiedad el evento focus:  onfocus="this.style.borderColor = '';"
                document.getElementById('epuContactos_txtApellidosNombres').focus();
                document.getElementById('epuContactos_txtApellidosNombres').style.borderColor = 'red';
            } else {
                document.getElementById('epuContactos_txtApellidosNombres').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            }

            if (epuContactos_ltCargo.value == "-1") {
                var flag = 1;
                toastr.error('El campo cargo es obligatorio ', 'Requerido');
                document.getElementById('epuContactos_ltCargo').focus();
                document.getElementById('epuContactos_ltCargo').style.borderColor = 'red';
            } else {
                document.getElementById('epuContactos_ltCargo').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            }

            if (epuContactos_txtFijo.GetText().length == 0) {
                var flag = 1;
                toastr.error('El campo fijo es obligatorio ', 'Requerido');
                document.getElementById('epuContactos_txtFijo').focus();
                document.getElementById('epuContactos_txtFijo').style.borderColor = 'red';
            } else {
                document.getElementById('epuContactos_txtFijo').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            }

            if (epuContactos_txtCorreo.GetText().length == 0) {
                var flag = 1;
                toastr.error('El campo correo es obligatorio ', 'Requerido');
                document.getElementById('epuContactos_txtCorreo').focus();
                document.getElementById('epuContactos_txtCorreo').style.borderColor = 'red';
            } else {
                document.getElementById('epuContactos_txtCorreo').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            }

            if (epuContactos_ltEnvios.value == "-1") {
                var flag = 1;
                toastr.error('El campo envios es obligatorio ', 'Requerido');
                document.getElementById('epuContactos_ltEnvios').focus();
                document.getElementById('epuContactos_ltEnvios').style.borderColor = 'red';
            } else {
                document.getElementById('epuContactos_ltEnvios').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            }

            if (flag == 1) {
                return false;
            }
            return true;
        }
        function onGridContactosDetalle_click(ContactoBE) {
            epuContactos.Show();
            epuContactos_txtApellidosNombres.SetValue(ContactoBE.C_CLIE_NOMBRE);
            epuContactos_ltCargo.value = ContactoBE.C_CLIE_CODCARGO;
            epuContactos_txtCorreo.SetValue(ContactoBE.C_CLIE_EMAIL);
            epuContactos_txtFijo.SetValue(ContactoBE.C_CLIE_TELEF1);
            epuContactos_txtMovil.SetValue(ContactoBE.C_CLIE_TELEF2);
            epuContactos_ltEnvios.value = ContactoBE.C_CLIE_TIPOENVIO.trim()
            epuContactos_dpFechaNac.SetValue(ContactoBE.C_CLIE_FECHANAC.substring(0, 10));
            document.getElementById('epuContactos_txtApellidosNombres').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            document.getElementById('epuContactos_ltCargo').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            document.getElementById('epuContactos_txtCorreo').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            document.getElementById('epuContactos_ltEnvios').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            document.getElementById('epuContactos_txtFijo').style.borderColor = 'rgba(0, 0, 0, 0.15)';
            document.getElementById('epuContactos_btnEliminarContacto').style.display = 'inline-block';
            //epuContactos_txtFlag.SetValue("M");
            epuContactos_txtFlag.value = "M";
            // epuContactos_txtIDContacto.SetValue(ContactoBE.N_CLIE_IDCONTACTO);
            epuContactos_txtIDContacto.value = ContactoBE.N_CLIE_IDCONTACTO;
            //console.log("test4", GenerarCliente.Params[GenerarCliente.KEYMODOPAGINA]);
            // ShowContacto("M", GenerarCliente.Params["V_CLIENTE_ID"], ContactoBE)
        }
        function EasyPopupContacto_Aceptar() {
            var mensaje;
            if (epuContactos_txtFlag.value == "M") {
                mensaje = "¿Esta seguro de modificar el contacto?";
            } else {
                mensaje = "¿Esta seguro de registrar el contacto?";
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
                    RegistrarOActualizarContacto();
                }
            });

        }

        function RegistrarOActualizarContacto() {

            //  location.reload();
            var x;
            var msg;
            if (OnValidate()) {

                switch (epuContactos_txtFlag.value) {
                    case "N":
                        x = InsertarContacto();
                        msg = 'Contacto registrado satisfactoriamente';
                        break;
                    case "M":
                        x = ActualizarContacto()
                        msg = 'Contacto actualizado satisfactoriamente';
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
                            //Ejecuta la funcion ActualizarGrillaContactos del lado del servidor
                            document.getElementsByName('btnActualizarGrillaContactos')[0].click();
                            epuContactos.Close();
                        }
                    });
                    /*
                    var ConfigMsgb = {
                        Titulo: 'Mensaje'
                        , Descripcion: msg
                        , Icono: 'fa fa-question-circle'
                        , EventHandle: function (btn) {
                            console.log(btn);
                            if (btn == 'OK' || btn == 'cancel') {
                                document.getElementsByName('btnActualizarGrillaContactos')[0].click();
                                epuContactos.Close();
                                //location.reload();
                            }
                        }
                    };
                    var oMsg = new SIMA.MessageBox(ConfigMsgb);
                    oMsg.confirm();*/

                } else {
                    //Si x es 2 quiere decir que el contacto no se registro porque ya existe otro contacto con el mismo nombre
                    if (x == '2') {
                        Swal.fire({
                            title: "Error",
                            text: "Ya existe un contacto con el mismo nombre",
                            icon: "error"
                        });

                        return false;
                    } else if (x != null) {
                        Swal.fire({
                            title: "Error",
                            text: "Se presento un error al registrar el contacto",
                            icon: "error"
                        });

                        return false;
                    }

                }

            }
        }

        function InsertarContacto() {

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionComercial/Proceso.asmx";
            oEasyDataInterConect.Metodo = "Insert_Update_ContactoCliente";

            var oParamCollections = new SIMA.ParamCollections();

            var oParam = new SIMA.Param("X_C_CLIE_CODCARGO", epuContactos_ltCargo.value);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_C_CLIE_NOMBRE", epuContactos_txtApellidosNombres.GetText().trim());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_C_CLIE_TELEF1", epuContactos_txtFijo.GetText().trim());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_C_CLIE_TELEF2", epuContactos_txtMovil.GetText().trim());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_C_CLIE_FECHANAC", epuContactos_dpFechaNac.GetText().trim());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_C_CLIE_EMAIL", epuContactos_txtCorreo.GetText().trim());//
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_C_CLIE_TIPOENVIO", epuContactos_ltEnvios.value);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_V_CLIENTE_ID", GenerarCliente.Params["V_CLIENTE_ID"]);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_N_CLIE_IDCONTACTO", "");
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("opcion", "1");
            oParamCollections.Add(oParam);

            /*   oParam = new SIMA.Param("IdUsuario", DetalleProyecto.Params["IdUsuario"], TipodeDato.Int);
               oParamCollections.Add(oParam);
 
               oParam = new SIMA.Param("UserName", DetalleProyecto.Params["UserName"]);
               oParamCollections.Add(oParam);  */

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);

            var Result = oEasyDataResult.sendData();
            return Result;
        }

        function ActualizarContacto() {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionComercial/Proceso.asmx";
            oEasyDataInterConect.Metodo = "Insert_Update_ContactoCliente";

            var oParamCollections = new SIMA.ParamCollections();

            var oParam = new SIMA.Param("X_C_CLIE_CODCARGO", epuContactos_ltCargo.value);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_C_CLIE_NOMBRE", epuContactos_txtApellidosNombres.GetText());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_C_CLIE_TELEF1", epuContactos_txtFijo.GetText());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_C_CLIE_TELEF2", epuContactos_txtMovil.GetText());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("X_C_CLIE_FECHANAC", epuContactos_dpFechaNac.GetText());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_C_CLIE_EMAIL", epuContactos_txtCorreo.GetText().trim());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_C_CLIE_TIPOENVIO", epuContactos_ltEnvios.value);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_V_CLIENTE_ID", GenerarCliente.Params["V_CLIENTE_ID"]);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("X_N_CLIE_IDCONTACTO", epuContactos_txtIDContacto.value);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("opcion", "2");
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);

            var Result = oEasyDataResult.sendData();

            return Result;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true" />
        <table style="width: 100%">
            <tr id="tblReport" border="0px">
                <td colspan="5">
                    <uc1:header runat="server" id="header1" />
                </td>
            </tr>
        </table>

        <asp:HiddenField ID="hdnReload" runat="server" />
        <asp:Button ID="btnRedirigir" runat="server" CssClass="btn-servidor" Style="display: none;" OnClick="Redirigir" />
        <asp:Button ID="btnActualizarGrillaContactos" runat="server" CssClass="btn-servidor" Style="display: none;" OnClick="ActualizarGrillaContactos" />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnSeleccionarCombosUbicacion" runat="server" Text="" CssClass="d-none" OnClick="SeleccionarCombosUbicacion" />
                <table style="width: 100%">

                    <tr>

                        <td colspan="5">
                            <h1 style="text-align: center;">FICHA DE  CLIENTE</h1>
                        </td>

                    </tr>
                    <tr>
                        <td colspan="5" style="text-align: center;">
                            <asp:Label Style="text-align: center;" ID="lblSubtitulo" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                        <td width="100px"></td>

                        <td>
                            <cc2:easytextbox visible="false" id="txt_v_cliente_id" runat="server" autocomplete="off" cssclass="form-control" data-validate="true" requerido="False" etiqueta="Cod cli"></cc2:easytextbox>

                            <asp:Label ID="lblTipo" runat="server" Text="Tipo"></asp:Label><br />
                            <cc2:easydropdownlist id="ltTipo" runat="server" displaytext="Tipo" enableonchange="False" cargainmediata="True" etiqueta="Tipo" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Ingresar tipo">
                                <datainterconect metodoconexion="WebServiceInterno">
                                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                    <metodo>Lista_get_tabgeneral</metodo>
                                    <urlwebservicieparams>
                                        <cc3:EasyFiltroParamUrlWs obtenervalor="Fijo" paramname="N_TAB" paramvalue="6" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="C_ESTA" paramvalue="ACT" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" />
                                    </urlwebservicieparams>
                                </datainterconect>
                            </cc2:easydropdownlist>
                        </td>
                        <td width="20px"></td>
                        <td width="44%">
                            <asp:Label ID="lblCiiu" runat="server" Text="CIIU"></asp:Label><br />
                            <cc2:easydropdownlist id="ltCiiu" runat="server" displaytext="CIIU" enableonchange="False" cargainmediata="True" etiqueta="CIIU" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Ingresar CIIU">
                                <datainterconect metodoconexion="WebServiceInterno">
                                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                    <metodo>Lista_get_ciiu</metodo>
                                    <urlwebservicieparams>
                                        <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" />
                                    </urlwebservicieparams>
                                </datainterconect>
                            </cc2:easydropdownlist>
                        </td>


                        <td width="100px"></td>
                    </tr>
                    <tr>
                        <td width="100px"></td>
                        <td>
                            <asp:Label ID="lblPais" runat="server" Text="Pais"></asp:Label><br />
                            <cc2:easydropdownlist id="ltPais" runat="server" displaytext="Pais" autopostback="True" enableonchange="True" onselectedindexchanged="fnRefrescaDptPVC" cargainmediata="True" etiqueta="Pais"
                                requerido="True" datavaluefield="COD_UBC" datatextfield="NOM_PVC" mensajevalida="Seleccione pais">
                                <datainterconect metodoconexion="WebServiceInterno">
                                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                    <metodo>Lista_PAIS_DPT_PROV_DIST</metodo>
                                    <urlwebservicieparams>
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="V_OPCION" paramvalue="1" tipodedato="String" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="V_VAR" paramvalue="" tipodedato="String" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" tipodedato="String" />
                                    </urlwebservicieparams>
                                </datainterconect>
                            </cc2:easydropdownlist>
                        </td>
                        <td width="20px"></td>
                        <td>
                            <asp:Label ID="lblRucDoc" runat="server" Text="RUC/DOC"></asp:Label><br />
                            <cc2:easytextbox id="txtRucDoc" runat="server" maxlength="11" autocomplete="off" cssclass="form-control" data-validate="true" requerido="False" etiqueta="RUC/DOC" onkeydown="executeOnEnter(event)"></cc2:easytextbox>
                            <asp:Button ID="btnBuscarRuc" runat="server" Text="Buscar Ruc" CssClass="d-none" OnClick="buscarRuc" />
                        </td>

                        <td width="100px"></td>
                    </tr>
                    <tr>
                        <td width="100px"></td>
                        <td>
                            <asp:Label ID="lblDoc" runat="server" Text="Doc Identificacion"></asp:Label><br />
                            <cc2:easytextbox id="txtDoc" runat="server" maxlength="20" autocomplete="off" cssclass="form-control" data-validate="true" requerido="False" etiqueta="Roc Identificacion"></cc2:easytextbox>
                        </td>
                        <td width="20px"></td>
                        <td>
                            <asp:Label ID="lblRazSocial" runat="server" Text="Razon Social"></asp:Label><br />
                            <cc2:easytextbox id="txtRazSoc" runat="server" maxlength="100" autocomplete="off" cssclass="form-control" data-validate="true"
                                requerido="False" etiqueta="Razon Social">
                            </cc2:easytextbox>
                        </td>

                        <td width="100px"></td>
                    </tr>
                    <tr>
                        <td width="100px"></td>
                        <td>
                            <asp:Label ID="lblProcedencia" runat="server" Text="Procedencia"></asp:Label><br />
                            <cc2:easydropdownlist id="ltProcedencia" runat="server" displaytext="Procedencia" enableonchange="False" cargainmediata="True" etiqueta="Procedencia" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Ingresar procedencia">
                                <datainterconect metodoconexion="WebServiceInterno">
                                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                    <metodo>Lista_get_tabgeneral</metodo>
                                    <urlwebservicieparams>
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="N_TAB" paramvalue="7" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="C_ESTA" paramvalue="ACT" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" />
                                    </urlwebservicieparams>
                                </datainterconect>
                            </cc2:easydropdownlist>
                        </td>
                        <td width="20px"></td>
                        <td>
                            <asp:Label ID="lblEntidad" runat="server" Text="Entidad"></asp:Label><br />
                            <cc2:easydropdownlist id="ltEntidad" runat="server" displaytext="Entidad" enableonchange="False" cargainmediata="True" etiqueta="Entidad" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Ingresar entidad">
                                <datainterconect metodoconexion="WebServiceInterno">
                                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                    <metodo>Lista_get_tabgeneral</metodo>
                                    <urlwebservicieparams>
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="N_TAB" paramvalue="116" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="C_ESTA" paramvalue="ACT" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" />
                                    </urlwebservicieparams>
                                </datainterconect>
                            </cc2:easydropdownlist>
                        </td>
                        <td width="100px"></td>
                    </tr>
                    <tr>
                        <td width="100px"></td>
                        <td>
                            <asp:Label ID="lblDepartamento" runat="server" Text="Departamento"></asp:Label><br />
                            <cc2:easydropdownlist id="ltDepartamento" runat="server" displaytext="Departamento" autopostback="True" enableonchange="True" onselectedindexchanged="fnRefrescaPvc" cargainmediata="True" etiqueta="Departamento" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Ingresar departamento">
                                <datainterconect metodoconexion="WebServiceInterno">
                                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                    <metodo>Lista_PAIS_DPT_PROV_DIST</metodo>
                                    <urlwebservicieparams>
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="V_OPCION" paramvalue="2" tipodedato="String" />
                                        <cc3:easyfiltroparamurlws obtenervalor="FormControl" paramname="V_VAR" paramvalue="ltPais" tipodedato="String" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" tipodedato="String" />
                                    </urlwebservicieparams>
                                </datainterconect>
                            </cc2:easydropdownlist>
                        </td>
                        <td width="20px"></td>
                        <td>
                            <asp:Label ID="lblProvincia" runat="server" Text="Provincia"></asp:Label><br />
                            <cc2:easydropdownlist id="ltProvincia" runat="server" displaytext="Provincia" cargainmediata="True" autopostback="True" enableonchange="True" onselectedindexchanged="fnRefrescaDtto" etiqueta="Provincia" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Seleccione provincia">
                                <datainterconect metodoconexion="WebServiceInterno">
                                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                    <metodo>Lista_PAIS_DPT_PROV_DIST</metodo>
                                    <urlwebservicieparams>
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="V_OPCION" paramvalue="3" tipodedato="String" />
                                        <cc3:easyfiltroparamurlws obtenervalor="FormControl" paramname="V_VAR" paramvalue="ltDepartamento" tipodedato="String" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" tipodedato="String" />
                                    </urlwebservicieparams>
                                </datainterconect>
                            </cc2:easydropdownlist>
                        </td>
                        <td width="100px"></td>
                    </tr>
                    <tr>
                        <td width="100px"></td>
                        <td>
                            <asp:Label ID="lblDistrito" runat="server" Text="Distrito"></asp:Label><br />
                            <cc2:easydropdownlist id="ltDistrito" runat="server" displaytext="Distrito" cargainmediata="True" etiqueta="Distrito" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Seleccione distrito">
                                <datainterconect metodoconexion="WebServiceInterno">
                                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                    <metodo>Lista_PAIS_DPT_PROV_DIST</metodo>
                                    <urlwebservicieparams>
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="V_OPCION" paramvalue="4" tipodedato="String" />
                                        <cc3:easyfiltroparamurlws obtenervalor="FormControl" paramname="V_VAR" paramvalue="ltProvincia" tipodedato="String" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" tipodedato="String" />
                                    </urlwebservicieparams>
                                </datainterconect>
                            </cc2:easydropdownlist>
                        </td>
                        <td width="20px"></td>
                        <td>
                            <asp:Label ID="lblDireccion" runat="server" Text="Direccion"></asp:Label><br />
                            <cc2:easytextbox id="txtDireccion" runat="server" autocomplete="off" maxlength="100" cssclass="form-control" data-validate="true" requerido="False" etiqueta="Direccion"></cc2:easytextbox>
                        </td>

                        <td width="100px"></td>
                    </tr>
                    <tr>
                        <td width="100px"></td>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Red Social"></asp:Label><br />
                            <cc2:easytextbox id="txtRedSocial" runat="server" maxlength="20" autocomplete="off" cssclass="form-control" data-validate="true" requerido="False" etiqueta="Red social"></cc2:easytextbox>
                        </td>

                        <td width="20px"></td>
                        <td>
                            <asp:Label ID="lblWebsite" runat="server" Text="Website"></asp:Label><br />
                            <cc2:easytextbox id="txtWebsite" runat="server" maxlength="20"></cc2:easytextbox>
                        </td>
                        <td width="100px"></td>
                    </tr>
                    <tr>
                        <td width="100px"></td>
                        <td>
                            <asp:Label ID="lblEstado" runat="server" Text="Estado"></asp:Label><br />
                            <cc2:easydropdownlist id="ltEstado" runat="server" displaytext="Estado" enableonchange="False" cargainmediata="True" etiqueta="Estado" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Ingresar estado">
                                <datainterconect metodoconexion="WebServiceInterno">
                                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                    <metodo>Lista_get_tabgeneral</metodo>
                                    <urlwebservicieparams>
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="N_TAB" paramvalue="39" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="C_ESTA" paramvalue="ACT" />
                                        <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" />
                                    </urlwebservicieparams>
                                </datainterconect>
                            </cc2:easydropdownlist>
                        </td>
                        <td width="20px"></td>
                        <td>
                            <asp:Label ID="lblFechaRegistro" runat="server" Text="Fecha registro"></asp:Label><br />
                            <cc2:easydatepicker id="dpFechaRegistro" runat="server" formatofecha="dd/mm/yyyy" hoy="" autocomplete="off" cssclass="form-control" data-validate="true" requerido="False">
                            </cc2:easydatepicker>
                        </td>
                        <td width="100px"></td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>




        <div style="display: flex; justify-content: right; margin: 35px 100px;">
            <asp:Button Style="margin-right: 30px;" ID="btnAceptar" runat="server" Text="Aceptar" CssClass="button-celeste"
                OnClientClick="return ConfirmarRegistroOActualizacion();" />

            <!--  <asp:Button class="btn btn-secondary" ID="btnCancelar" runat="server" Text="Cancelar"  CssClass="" 
            OnClick="btnCancelar_Click" /> -->
            <button id="btnRegresar" class="btn btn-secondary" onclick="history.back(); return false;">Cancelar</button>
        </div>

        <div style="display: flex; justify-content: center; margin: 35px 100px;">
            <table style="width: 90%">
                <tr>
                    <td>
                        <cc4:easygridview id="EasyGridContacto" runat="server" cssclass="STgridview"
                            autogeneratecolumns="False" showfooter="True" tituloheader="Contactos"
                            toolbarbuttonclick="OnEasyGridButton_Click" width="100%"
                            allowpaging="True" pagesize="7" onpageindexchanging="EasyGridContacto_PageIndexChanged"
                            oneasygridbutton_click="EasyGridContacto_EasyGridButton_Click">

                            <easygridbuttons>
                                <cc4:easygridbutton id="btnNuevoContacto" descripcion="" icono="fa fa-plus-square-o" msgconfirm="" runatserver="False" texto="Nuevo Contacto" ubicacion="Izquierda" />
                            </easygridbuttons>
                            <easystylebtn classname="btn btn-primary" fontsize="1em" textcolor="white" />
                            <easyextended itemcolormousemove="#CDE6F7" itemcolorseleccionado="#ffcc66" rowcellitemclick="onGridContactosDetalle_click" idgestorfiltro="EasyGestorFiltro1"></easyextended>
                            <datainterconect metodoconexion="WebServiceInterno">
                                <urlwebservice>/GestionComercial/Proceso.asmx</urlwebservice>
                                <metodo>ListarContactosDeCliente</metodo>
                                <urlwebservicieparams>

                                    <cc3:easyfiltroparamurlws obtenervalor="FormControl" paramname="X_V_CLIENTE_ID" paramvalue="txt_v_cliente_id" />

                                </urlwebservicieparams>
                            </datainterconect>


                            <easyrowgroup groupeddepth="0" colinirowmerge="0"></easyrowgroup>

                            <alternatingrowstyle cssclass="AlternateItemGrilla" />

                            <columns>
                                <asp:BoundField DataField="C_CLIE_NOMBRE" HeaderText="NOMBRES" />
                                <asp:BoundField Visible="false" DataField="C_CLIE_CODCARGO" HeaderText="" />
                                <asp:BoundField DataField="DES_CARGO" HeaderText="CARGO" />
                                <asp:BoundField DataField="C_CLIE_TELEF1" HeaderText="TELEFONO" />
                                <asp:BoundField DataField="C_CLIE_TELEF2" HeaderText="CELULAR" />
                                <asp:BoundField DataField="C_CLIE_FECHANAC" HeaderText="FEC NAC" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField DataField="C_CLIE_EMAIL" HeaderText="CORREO" />
                                <asp:BoundField Visible="false" DataField="C_CLIE_TIPOENVIO" HeaderText="" />
                                <asp:BoundField DataField="DES_TIPOENVIO" HeaderText="ENVIOS" />
                                <asp:BoundField Visible="false" DataField="N_CLIE_IDCONTACTO" HeaderText="IDCONTACTO" />
                            </columns>

                            <headerstyle cssclass="HeaderGrilla" />
                            <pagerstyle horizontalalign="Center" />
                            <rowstyle cssclass="ItemGrilla" height="25px" />
                        </cc4:easygridview>
                    </td>
                </tr>
            </table>
        </div>

        <cc2:easypopupbase id="epuContactos" runat="server" modal="fullscreen" modocontenedor="LoadPage" titulo="Datos de Contacto" runatserver="false" displaybuttons="true" fncscriptaceptar="EasyPopupContacto_Aceptar">
            <table style="width: 100%;">

                <asp:HiddenField ID="txtFlag" runat="server" />
                <asp:HiddenField ID="txtIDContacto" runat="server" />
                <tr>
                    <td width="20px"></td>
                    <td style="width: 26%;"></td>
                    <td>

                        <asp:Button ID="btnEliminarContacto" Style="margin-left: 82%; margin-bottom: 5px;" runat="server" Text="Eliminar" CssClass="button-celeste" OnClientClick="return eliminar_contacto();" />
                        <asp:Button ID="btnEliminarContacto1" Style="visibility: hidden; display: none;" runat="server" Text="Eliminar" CssClass="button-celeste" OnClick="EliminarContacto" />
                    </td>
                    <td width="20px"></td>
                </tr>
                <tr>
                    <td width="20px"></td>
                    <td style="width: 26%;">
                        <asp:Label ID="lblApellidosNombres" runat="server" Text="Apellidos y Nombres"></asp:Label></td>
                    <td>
                        <cc2:easytextbox maxlength="50" id="txtApellidosNombres" runat="server" autocomplete="off" cssclass="form-control" data-validate="true" requerido="False" etiqueta="Nombres"></cc2:easytextbox>
                    </td>
                    <td width="20px"></td>
                </tr>
                <tr>
                    <td width="20px"></td>
                    <td style="width: 26%;">
                        <asp:Label ID="lblCargo" runat="server" Text="Cargo"></asp:Label></td>
                    <td>
                        <cc2:easydropdownlist id="ltCargo" runat="server" displaytext="Cargo" cargainmediata="True" etiqueta="Distrito" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Seleccione cargo">
                            <datainterconect metodoconexion="WebServiceInterno">
                                <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                <metodo>Lista_get_tabgeneral</metodo>
                                <urlwebservicieparams>
                                    <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="N_TAB" paramvalue="203" />
                                    <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="C_ESTA" paramvalue="ACT" />
                                    <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" />
                                </urlwebservicieparams>
                            </datainterconect>
                        </cc2:easydropdownlist>
                    </td>
                    <td width="20px"></td>
                </tr>
                <tr>
                    <td width="20px"></td>
                    <td style="width: 26%;">
                        <asp:Label ID="lblCorreo" runat="server" Text="Correo"></asp:Label></td>
                    <td>
                        <cc2:easytextbox id="txtCorreo" runat="server" autocomplete="off" maxlength="30" cssclass="form-control" data-validate="true" requerido="False" etiqueta="Correo"></cc2:easytextbox>
                    </td>
                    <td width="20px"></td>
                </tr>
                <tr>
                    <td width="20px"></td>
                    <td style="width: 26%;" colspan="2">TELEFONOS
                    </td>
                    <td width="20px"></td>
                </tr>
                <tr>
                    <td width="20px"></td>
                    <td style="width: 26%;">&nbsp&nbsp Fijo </td>
                    <td>
                        <cc2:easytextbox id="txtFijo" runat="server" autocomplete="off" maxlength="12" cssclass="form-control" data-validate="true" requerido="False" etiqueta="Fijo"></cc2:easytextbox>
                    </td>
                    <td width="20px"></td>
                </tr>
                <tr>
                    <td width="20px"></td>
                    <td style="width: 26%;">&nbsp&nbsp Movil </td>
                    <td>
                        <cc2:easytextbox id="txtMovil" runat="server" autocomplete="off" maxlength="12" cssclass="form-control" data-validate="true" requerido="False" etiqueta="Movil"></cc2:easytextbox>
                    </td>
                    <td width="20px"></td>
                </tr>
                <tr>
                    <td width="20px"></td>
                    <td style="width: 27%;">
                        <asp:Label ID="lblEnvio" runat="server" Text="Envio"></asp:Label></td>
                    <td>
                        <cc2:easydropdownlist id="ltEnvios" runat="server" displaytext="Envio" cargainmediata="True" etiqueta="Envio" requerido="True" datavaluefield="CODIGO" datatextfield="NOMBRE" mensajevalida="Seleccione envio">
                            <datainterconect metodoconexion="WebServiceInterno">
                                <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                                <metodo>Lista_get_tabgeneral</metodo>
                                <urlwebservicieparams>
                                    <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="N_TAB" paramvalue="204" />
                                    <cc3:easyfiltroparamurlws obtenervalor="Fijo" paramname="C_ESTA" paramvalue="ACT" />
                                    <cc3:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" />
                                </urlwebservicieparams>
                            </datainterconect>
                        </cc2:easydropdownlist>
                    </td>
                    <td width="20px"></td>
                </tr>
                <tr>
                    <td width="20px"></td>
                    <td style="width: 26%;">
                        <asp:Label ID="lblFechaNac" runat="server" Text="Fecha nacimiento"></asp:Label></td>
                    <td>
                        <cc2:easydatepicker id="dpFechaNac" runat="server" autocomplete="off" cssclass="form-control" data-validate="true" requerido="False" etiqueta="Fecha Nac"></cc2:easydatepicker>
                    </td>
                    <td width="20px"></td>
                </tr>
            </table>
        </cc2:easypopupbase>


        <cc2:easypopupbase id="epuContactosClientes" runat="server" runatserver="true" modal="fullscreen" modocontenedor="LoadPage" displaybuttons="true" fncscriptaceptar="ContactoClientebtnAceptar" onclick="EasyPopupContactosClientes_Click" titulo="Contacto">
        </cc2:easypopupbase>


        <cc2:easypopupbase id="epuMensaje" runat="server" displaybuttons="true"
            runatserver="true" titulo="Nivel de Conformidad">

            <table id="pp">
                <tr>
                    <td width="20px"></td>
                    <td width="35%">
                        <asp:TextBox ID="lbl_Cliente_ID" runat="server"></asp:TextBox></td>
                    <td width="20px"></td>

                </tr>
            </table>
        </cc2:easypopupbase>

        <asp:Button ID="btnRegistrar" runat="server" CssClass="btn-servidor" Style="display: none;" OnClick="RegistrarCliente" />
        <asp:Button ID="btnActualizar" runat="server" CssClass="btn-servidor" Style="display: none;" OnClick="ActualizarCliente" />

    </form>
    <script type="text/javascript">


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
<script type="text/javascript">
    function changeBorderColor(element, eventType) {
        if (eventType === 'focus') {
            element.style.borderColor = 'red'; // Cambia a rojo cuando se recibe el foco
        } else if (eventType === 'blur') {
            element.style.borderColor = ''; // Restaura el borde cuando se pierde el foco
        }
    }
</script>
</html>

