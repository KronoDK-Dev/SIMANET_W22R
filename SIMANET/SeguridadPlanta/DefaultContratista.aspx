<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefaultContratista.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.DefaultContratista" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <script>
        function onNroDocSeleccionado(value, ItemBE) {

           if (DefaultContratista.ValidaVigencia()) {
                if (ItemBE.ExisteEnProg == "SI") {
                    DefaultContratista.Data.TrabajadorProgDetalle(ItemBE.NroDNI).Rows.forEach(function (dr,r) {
                        DefaultContratista.MensajeInProg(dr);
                    });
                }
                else {
                    //cuando no esta programado
                    DefaultContratista.Data.RegistrarTrabajador();
                }
            }
            DefaultContratista.ListarTrabajadores()

        }


      

        function onDisplayTemplateTrabajador(ul, item) {
            var cmll = "\""; var iTemplate = null;
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '<div class= "flex-column">' + item.ApellidosNombres
                + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red"> </small>'
                + '    <small style="font-weight: bold">NRO RUC.:</small><small style="color:blue;text-transform: capitalize;">' + item.NroDNI + '</small></p>'
                + '    <span class="badge badge-info "> otrodato </span > '
                + '</div>'
                + '</a>';

            var oCustomTemplateBE = new acTrabajador.CustomTemplateBE(ul, item, iTemplate);

            return acTrabajador.SetCustomTemplate(oCustomTemplateBE);


        }

        function TabOnClick(oTab) {
            var idTab = oTab.attr('id').Replace("EasyTabBase_", "");
            switch (idTab) {
                case "TabDet_1":
                    Manager.Task.Excecute(function () {
                        try {
                         //alert(oTab.attr('Loading'))

                            DefaultContratista.ListarTrabajadores();
                        }
                        catch (ex) {
                            //  alert(ex);
                        }
                    }, 1500, true);
                    break;
            }
        }

        function OnEasyToolbarButton_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "dblCalendar":
                    //DefaultContratista.ListaTrabajadorEnFeriado();
                    var lstDNI = '';
                    var i = 0;
                    grvTrabajadores.querySelector('chkFeriado', function (ctrl) {
                        if (ctrl.children[0].checked) {
                            var TrabajadorBE = ctrl.attr('Data').toString().SerializedToObject();
                            lstDNI += ((i > 0) ? "@" : "") + TrabajadorBE.NroDni;
                            i++;
                        }
                    });


                    var wConfig = "width=600,height=400,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,status=no";
                    var URLPag = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/ListaTrabajadorEnFeriado.aspx" + SIMA.Utilitario.Constantes.Caracter.Interrogacion
                        + DefaultContratista.KEYQIDPROGRAMACION + SIMA.Utilitario.Constantes.Caracter.Igual + DefaultContratista.Params[DefaultContratista.KEYQIDPROGRAMACION]
                        + SIMA.Utilitario.Constantes.Caracter.Amperson + DefaultContratista.KEYQAÑO + SIMA.Utilitario.Constantes.Caracter.Igual + DefaultContratista.Params[DefaultContratista.KEYQAÑO]
                        + SIMA.Utilitario.Constantes.Caracter.Amperson + DefaultContratista.KEYQFECHAINI + SIMA.Utilitario.Constantes.Caracter.Igual + DefaultContratista.Params[DefaultContratista.KEYQFECHAINI].toString().substring(0, 10)
                        + SIMA.Utilitario.Constantes.Caracter.Amperson + DefaultContratista.KEYQFECHAFIN + SIMA.Utilitario.Constantes.Caracter.Igual + DefaultContratista.Params[DefaultContratista.KEYQFECHAFIN].toString().substring(0, 10)
                        + SIMA.Utilitario.Constantes.Caracter.Amperson + DefaultContratista.KEYQLSTDNI + SIMA.Utilitario.Constantes.Caracter.Igual + lstDNI;

                   

                    var popup = window.open(URLPag, 'PopupWindow','width=800,height=600,toolbar=no,menubar=no,resizable=no,scrollbars=no');
                    if (!popup) {
                        alert("Popup blocked! Please allow popups for this site.");
                    }

                    break;
            }

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <cc1:EasyTabControl ID="EasyTabBase" fncTabOnClick="TabOnClick" runat="server"></cc1:EasyTabControl>

        <table style="width:100%;visibility:visibility" id="tblTrabajador" >
            <tr>
                <td class="Etiqueta">
                    NRO DOCUMENTO:
                </td>
                <td style="width:20%">
                    <cc1:EasyAutocompletar ID="acTrabajador" runat="server"  NroCarIni="8"  DisplayText="NroDNI" ValueField="NroDNI"  fnOnSelected="onNroDocSeleccionado" fncTempaleCustom="onDisplayTemplateTrabajador" required>
                        <EasyStyle Ancho="Dos"></EasyStyle>
                            <DataInterconect MetodoConexion="WebServiceExterno">
                                 <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                 <Metodo>BuscarTrabajaor</Metodo>
                                 <UrlWebServicieParams>
                                     <cc2:EasyFiltroParamURLws  ParamName="FechaProgIni" Paramvalue="DefaultContratista.FechaProgInicio()" ObtenerValor="FunctionScript" />
                                     <cc2:EasyFiltroParamURLws  ParamName="FechaProgFin" Paramvalue="DefaultContratista.FechaProgFin()" ObtenerValor="FunctionScript" />
                                     <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                 </UrlWebServicieParams>
                             </DataInterconect>
                    </cc1:EasyAutocompletar>
                </td>
                <td>
                    <img id="ibtnAdd" runat="server"/>
                </td>
                <td style="width:50%">

                </td>
                <td style="width:10%">
                    <cc1:EasyToolBarButtons ID="tbCalendario" runat="server">
                        <EasyButtons>
                            <cc1:EasyButton ID="dblCalendar" Descripcion="" Icono="fa fa-calendar" RunAtServer="False" Texto="Feriados" Ubicacion="Derecha" />
                        </EasyButtons>
                    </cc1:EasyToolBarButtons>
                </td>
            </tr>
            <tr>
                <td id="ContentTrab" colspan="5" style="width:100%">

                </td>
            </tr>
        </table>

        <table style="width:100%;visibility:hidden" border="0" id="tblEquipos">
            <tr>
                <td style="width:10%" class="Etiqueta">
                    CODIGO:
                </td>
                <td style="width:10%">
                    <cc1:EasyTextBox ID="txtCodigo" runat="server"></cc1:EasyTextBox>
                </td>               
                <td class="Etiqueta">CANTIDAD</td>
                <td style="width:10%"><cc1:EasyTextBox ID="txtCant" runat="server"> </cc1:EasyTextBox></td>
                <td class="Etiqueta">TIPO</td>
                <td style="width:50%"> <cc1:EasyDropdownList ID="ddlTipo" runat="server"></cc1:EasyDropdownList></td>
                <td style="width:50%"></td>
            </tr>
            <tr>
                <td class="Etiqueta"  colspan="7">DESCRIPCION:</td>
            </tr>
            <tr>
                <td colspan="7"><cc1:EasyTextBox ID="txtDescripcion"  TextMode="MultiLine" Height="80px"  runat="server"></cc1:EasyTextBox></td>
            </tr>
        </table>
    </form>

    <script>
        DefaultContratista.Trabajador = function () {
            
        }

        DefaultContratista.Detalle = function () {
            alert();
        }

        DefaultContratista.ValidaVigencia = function () {

            var FechaAct = new Date();
            var MesAct = ((FechaAct.getMonth() <= 8) ? "0" + (FechaAct.getMonth() + 1) : (FechaAct.getMonth() + 1));
            var DiaAct = ((FechaAct.getDate().toString().length > 1) ? FechaAct.getDate() : "0" + FechaAct.getDate());
            var FechaHoy = DiaAct + '-' + MesAct + '-' + FechaAct.getFullYear();
            var hoyYYYYmmdd = FechaHoy.toString().ParseDateToYYYYmmDD( '-');
            var fechaTermino = DefaultContratista.Params[DefaultContratista.KEYQFECHAFIN].toString().substring(0, 10).ParseDateToYYYYmmDD('/');

            if (parseInt(fechaTermino) < parseInt(hoyYYYYmmdd)) {
                var msgConfig = { Titulo: 'Validación', Descripcion: 'Por vencimiento de la programacion no se autoriza el registro de nuevos trabajadores' };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();

                return false;
            }
            return true;
        }

        DefaultContratista.FechaProgInicio = function () {
            return DefaultContratista.Params[DefaultContratista.KEYQFECHAINI].toString().substring(0, 10).toString().ParseDateToYYYYmmDD('/');
        }
        DefaultContratista.FechaProgFin = function () {
            return DefaultContratista.Params[DefaultContratista.KEYQFECHAFIN].toString().substring(0, 10).toString().ParseDateToYYYYmmDD('/');
        }

        DefaultContratista.Data = {};
        DefaultContratista.Data.TrabajadorProgDetalle = function (NroDNI) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
            oEasyDataInterConect.Metodo = "TrabajadorInProgramacion";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("NroDNI", NroDNI);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Periodo", DefaultContratista.Params[DefaultContratista.KEYQAÑO], TipodeDato.Int);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            oParam = new SIMA.Param("IdProgramacion", DefaultContratista.Params[DefaultContratista.KEYQIDPROGRAMACION], TipodeDato.Int);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;


            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }



        DefaultContratista.MensajeInProg = function (TrabajadorProgBE) {

            var ConfigMsgb = {
                Titulo: 'SOLICITUD'
                , Descripcion: DefaultContratista.ItemplateSolicitud(TrabajadorProgBE)
                , Icono: 'fa fa-tag'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        DefaultContratista.Data.RegistrarTrabajador();

                        /*Manager.Task.Excecute(function () {
                            AdminstrarUsuariosFirmantes.EnviarEmailSolicitudAprobacion(tPlazo);
                        }, 1000);*/
                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }


        DefaultContratista.ItemplateSolicitud = function (oTrabajadorProgBE) {
            
            var FotoPersona = DefaultContratista.PathFotosPersonal + oTrabajadorProgBE.NroDocDni + ".jpg";

            var FotoClassName = "ms-n2 rounded-circle img-fluid";

            var MsgTemplate = '<table border=0 width="100%" id="tblSendAprob">'
                + '<tr>'
                + '     <td colspan=2 align="center"><img width="120px" class="' + FotoClassName + '" src="' + FotoPersona + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;" /></td>'
                + '</tr>'
                + '<tr>'
                + '     <td align="center" style="font-size: 14px;"><br>Trabajador se encuentra programado por el usuario:<span style="color:navy;font-size: 16px;">' + oTrabajadorProgBE.ApellidosyNombres + '</span></td>'
                + '</tr>'
                + '<tr>'
                + '     <td style="font-size: 14px;">de todas maneras, Desea incluir a: <span  style="color:red;font-size: 16px;">' + oTrabajadorProgBE.NombreTrabajador + '</span> con el Nro de Documento: <span style="color:red;font-size: 16px;">' + oTrabajadorProgBE.NroDNI + '</span> en su programación ahora?</td>'
                + '</tr>'
                + '</table>';
            return MsgTemplate;
        }


        DefaultContratista.Data.RegistrarTrabajador = function () {
            var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("Periodo", DefaultContratista.Params[DefaultContratista.KEYQAÑO], TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdProgramacion", DefaultContratista.Params[DefaultContratista.KEYQIDPROGRAMACION], TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("NroDNI", acTrabajador.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("FechaInicio", DefaultContratista.Params[DefaultContratista.KEYQFECHAINI]);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("FechaTermino", DefaultContratista.Params[DefaultContratista.KEYQFECHAFIN]);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("HoraInicio", DefaultContratista.Params[DefaultContratista.KEYQHORAINI]);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("HoraTermino", DefaultContratista.Params[DefaultContratista.KEYQHORAFIN]);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("SCTRSalud", "");
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("SCTRPension", "");
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
                oEasyDataInterConect.Metodo = 'ProgramacionTrabajador_ins';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData();

        }


        DefaultContratista.ListarTrabajadores = function () {

            EasyPopupTrabEqui.ProgressBar.Show('Cargando Trabajadores..');

            var urlPag = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/ListaTrabajadores.aspx";
            var oColletionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(DefaultContratista.KEYQAÑO, DefaultContratista.Params[DefaultContratista.KEYQAÑO]);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(DefaultContratista.KEYQIDPROGRAMACION,DefaultContratista.Params[DefaultContratista.KEYQIDPROGRAMACION]);
            oColletionParams.Add(oParam);

           
            var oLoadConfig = {
                CtrlName: "ContentTrab",
                UrlPage: urlPag,
                ColletionParams: oColletionParams,
                fnOnComplete: function () {
                    EasyPopupTrabEqui.ProgressBar.Hide();
                }
            };


            SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
        }


        //Trabajadores em feriados
        DefaultContratista.ListaTrabajadorEnFeriado = function () {

            var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/ListaTrabajadorEnFeriado.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(DefaultContratista.KEYQIDPROGRAMACION, DefaultContratista.Params[DefaultContratista.KEYQIDPROGRAMACION]);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(DefaultContratista.KEYQAÑO, DefaultContratista.Params[DefaultContratista.KEYQAÑO]);
            oColletionParams.Add(oParam);

            EasyPopupFeriado.Load(Url, oColletionParams, false);
        }
    </script>
</body>
</html>
