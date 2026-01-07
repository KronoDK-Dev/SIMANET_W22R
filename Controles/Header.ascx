<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="SIMANET_W22R.Controles.Header" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register TagPrefix="cc1" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>

<link id="cssBootstrapIcons" rel="stylesheet" />
<script>  <!-- le adicionamos su referencia al control LINK -->
    function getBasePath() {
        // Obtiene el origen (dominio + puerto)
        var origin = window.location.origin;
        // Obtiene el primer segmento del path (nombre del proyecto)
        var pathSegments = window.location.pathname.split('/');
        var projectName = pathSegments.length > 1 ? pathSegments[1] : '';
        // Devuelve la ruta base completa
        return origin + '/' + projectName;
    }

    window.addEventListener('DOMContentLoaded', function () {
        document.getElementById("cssBootstrapIcons").href = getBasePath() + "/Recursos/css/bootstrap-icons.css";
    });
</script>

<link id="cssToastr" rel="stylesheet" />
<script>  <!-- le adicionamos su referencia al control LINK -->
    window.addEventListener('DOMContentLoaded', function () {
        document.getElementById("cssToastr").href = getBasePath() + "/Recursos/css/toastr.min.css";
    });
</script>

<link id="cssSweetalert2" rel="stylesheet" />
<script>  <!-- le adicionamos su referencia al control LINK -->
    window.addEventListener('DOMContentLoaded', function () {
        document.getElementById("cssSweetalert2").href = getBasePath() + "/Recursos/css/sweetalert2.min.css";
    });
</script>

<link id="cssStyleEasy" rel="stylesheet" />
<script>  <!-- le adicionamos su referencia al control LINK -->
    window.addEventListener('DOMContentLoaded', function () {
        document.getElementById("cssStyleEasy").href = getBasePath() + "/Recursos/css/StyleEasy.css";
    });
</script>

<script id="scriptToastr"></script>
<script id="scriptSweetAlert"></script>

<script>
    window.addEventListener('DOMContentLoaded', function () {
        document.getElementById("scriptToastr").src = getBasePath() + "/Recursos/js/toastr.min.js";
    });
    window.addEventListener('DOMContentLoaded', function () {
        document.getElementById("scriptSweetAlert").src = getBasePath() + "/Recursos/js/sweetalert2.all.min.js";
    });
</script>

<table border="0px" style="width:100%">
    <tr>
        <td style="width:100%;" class="breadcrumb">
            <cc1:EasyNavigatorBarMenu ID="EasyNavigatorBarMenu1" runat="server" fc_OnMenuItem_Click="Perfil"
                                      OnHelpSnapShot="EasyNavigatorBarMenu1_HelpSnapShot" 
                                      ImagenLogoHeader="../Recursos/img/header.jpg" ParamMenuDescrip="MnuDescrib" ParamMenuText="MnuNombre">
            </cc1:EasyNavigatorBarMenu>	
        </td>
    </tr>
</table>
<asp:Button ID="btnIconMenu" runat="server" OnClick="btnIconMenu_Click" Text="IconMenu" />

<style>

    body {
        background-image: url('/Recursos/img/default0.png');
        background-repeat: No-repeat;
        background-size: 30px;
    }

    .breadcrumb, .navbar, .menu-header {
        background-color: transparent !important; /* Fondo transparente */
    }



    strong {
        font-weight: 600;
    }

    .notify {
        width: 360px;
        padding: 15px;
        background-color: white;
        border-radius: 16px;
        position: fixed;
        bottom: 15px;
        left: 15px;
        transform: translateY(200%);
        -webkit-animation: noti 5s 1 forwards alternate ease-in;
        animation: noti 5s 1 forwards alternate ease-in;
    }

    .notification-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 15px;
    }

    .notification-title {
        font-size: 16px;
        font-weight: 500;
        text-transform: capitalize;
    }

    .notification-close {
        cursor: pointer;
        width: 30px;
        height: 30px;
        border-radius: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #F0F2F5;
        font-size: 14px;
    }

    .notification-container {
        display: flex;
        align-items: flex-start;
    }

    .notification-media {
        position: relative;
    }

    .notification-user-avatar {
        width: 60px;
        height: 60px;
        border-radius: 60px;
        -o-object-fit: cover;
        object-fit: cover;
    }

    .notification-reaction {
        width: 30px;
        height: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 60px;
        color: white;
        background-image: linear-gradient(45deg, #0070E1, #14ABFE);
        font-size: 14px;
        position: absolute;
        top: 50px;
        left: 20px;
        margin-left: 20px;
    }

    .notification-content {
        width: calc(100% - 60px);
        padding-left: 20px;
        line-height: 1.2;
    }

    .notification-text {
        margin-bottom: 5px;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        padding-right: 50px;
    }

    .notification-timer {
        color: #1876F2;
        font-weight: 600;
        font-size: 14px;
    }

    .notification-status {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        width: 15px;
        height: 15px;
        background-color: red;
        border-radius: 50%;
    }

    @-webkit-keyframes noti {
        50% {
            transform: translateY(0);
        }

        100% {
            transform: translateY(0);
        }
    }

    @keyframes noti {
        50% {
            transform: translateY(0);
        }

        100% {
            transform: translateY(0);
        }
    }

    @keyframes reset {
        100% {
            opacity: 1;
        }

        60% {
            opacity: 0;
        }

        0% {
            opacity: 0;
        }
    }

    .HiddeNotify {
        display: none;
        animation-name: reset;
        animation-duration: 3s;
        animation-timing-function: ease-out;
        animation-iteration-count: 1;
        animation-delay: 0, 6s;
    }

    .ItemDisponible {
        background: #fefefe;
        color: #15428b;
        font: 12px tahoma,arial,sans-serif;
        margin-top: 5px;
        margin-right: 15px;
        margin-bottom: 5px;
        border: 1px dotted #5394C8;
        height: 35px;
        width: 100%;
    }

        .ItemDisponible td {
            padding-left: 5px;
            padding-right: 5px;
            height: 35px;
        }

        .ItemDisponible tr:hover {
            background-color: #E1EFFA;
        }

    .ItemSelected {
        background: #2794DD;
        color: white;
        font: 12px tahoma,arial,sans-serif;
        margin-top: 5px;
        margin-bottom: 5px;
        border: 1px dotted #5394C8;
        height: 35px;
        width: 100%;
    }

        .ItemSelected td {
            padding-left: 5px;
            padding-right: 5px;
            height: 35px;
        }

    .icon-container {
        width: 50px;
        height: 50px;
        position: relative;
    }

    .status-circle {
        width: 15px;
        height: 15px;
        border-radius: 50%;
        background-color: red;
        border: 2px solid white;
        bottom: 0;
        right: 0;
        position: absolute;
    }

</style>

<script>
    var MasterConfig = {};

    var DataSelectedBE = null;
    function OpcionClick(e) {
        var strData = jNet.get(e).attr("Data");
        DataSelectedBE = strData.toString().SerializedToObject();

        var objContent = jNet.get(e.parentNode);
        objContent.forEach(function (ochild, i) {
            var oDataBE = ochild.attr("Data").toString().SerializedToObject();
            nclass = ((oDataBE.IdItemConfig == DataSelectedBE.IdItemConfig) ? "ItemSelected" : "ItemDisponible");
            ochild.attr("class", nclass);
        });
    }

    function ConfigTemplate() {
        var cmll = "'";
        var MsgTemplate = 'Opciones de Configuración?<br><br><div>'
        var strPath = window.location.href;
        var PagActual = strPath.split('?')[0].split('/');
        var NombrePagActual = PagActual[PagActual.length - 1];//Obtiene el nombre de la pagina actual

        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        oEasyDataInterConect.UrlWebService = ConnectService.GeneralSoapClient;
        oEasyDataInterConect.Metodo = "ListarOpcionesConfiguracion";

        var oParamCollections = new SIMA.ParamCollections();
        var oParam = new SIMA.Param("PageName", NombrePagActual);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("UserName", GlobalEntorno.UserName);
        oParamCollections.Add(oParam);

        oEasyDataInterConect.ParamsCollection = oParamCollections;

        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
        var oDataTable = oEasyDataResult.getDataTable();
        if (oDataTable != null) {
            oDataTable.Rows.forEach(function (oDataRow, i) {
                var strData = "";
                oDataRow.Columns.forEach(function (oDataColumn, c) {
                    strData += ((c == 0) ? "" : ",") + oDataColumn.Name + ":" + cmll + oDataRow[oDataColumn.Name] + cmll;
                });
                strData = "{" + strData + "}";
                MsgTemplate += '<table class="ItemDisponible" Data="' + strData + '" width="100%" onclick="javascript:OpcionClick(this);"><tr> <td align="Left" >' + oDataRow["DESCRIPCION"].toString() + '</td><td align="right">' + "Alt + [" + oDataRow["IdItemConfig"].toString() + "]" + '</td></tr></table>';

            });
            MsgTemplate += '</div>';
        }

        return MsgTemplate;
    }

    var PathPageSelected = "";

    function LoadConfigMaster() {

        var ConfigMsg = {
            Titulo: 'CONFIGURACION'
            , Descripcion: ConfigTemplate()
            , Icono: 'fa fa-cog'
            , EventHandle: function (btn) {
                if (btn == 'OK') {
                    if (DataSelectedBE.TipoCall.toString().Equal("1")) {
                        eval(DataSelectedBE.PaginaFncConfig);
                    }
                    else {
                        var urlPag = Page.Request.ApplicationPath + DataSelectedBE.PaginaFncConfig;
                        var oColletionParams = new SIMA.ParamCollections();
                        var oParam = new SIMA.Param(AdministrarInspecion.KEYQQUIENLLAMA, GlobalEntorno.PageName);
                        oColletionParams.Add(oParam);
                        Header_EasyPopupMasrteConfig.Load(urlPag, oColletionParams, false);
                    }
                }
            }
        };
        var oMsgConfig = new SIMA.MessageBox(ConfigMsg);
        oMsgConfig.confirm();
    }

</script>

<cc1:EasyPopupBase ID="EasyPopupMasrteConfig" runat="server" Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Configuraciones" RunatServer="false" DisplayButtons="true" fncScriptAceptar="MasterConfig.OnAceptar">
</cc1:EasyPopupBase>

<cc1:EasyPopupBase ID="EasyPopupLiveChat" runat="server" Modal="Medio" ModoContenedor="LoadPage" Titulo="ChatApp" RunatServer="false" DisplayButtons="true" fncScriptAceptar="LiveChat_OnAceptar" fncScriptOnClose="LiveChat_OnClose">
</cc1:EasyPopupBase>

<cc1:EasyPopupBase ID="EasyPopupDetalleRQR" runat="server" Modal="fullscreen" ModoContenedor="LoadPage" Titulo="ChatApp" RunatServer="false" DisplayButtons="true" fncScriptAceptar="NetSuite.Manager.Broker.Persiana.Popup.Aceptar" fncScriptOnClose="LiveChat_OnClose">
</cc1:EasyPopupBase>

<style>
    /*   28.10.2025 se crea ancho responsive para que los controles No se apilen horizontalmente y le quiten la visualizacion rapida al usuario  */
    .navbar-nav {
        display: flex !important; /* asegura flexbox */
        flex-direction: row !important;
        flex-wrap: nowrap !important; /* evita que se apilen */
        overflow-x: auto; /* scroll si no caben */
        white-space: nowrap; /* evita saltos de línea */
    }

        .navbar-nav .nav-item {
            flex-shrink: 0; /* evita que los íconos se achiquen */
        }

    .navbar img {
        max-width: 100%;
        height: auto; /* mantiene proporción */
        display: block;
    }

</style>
