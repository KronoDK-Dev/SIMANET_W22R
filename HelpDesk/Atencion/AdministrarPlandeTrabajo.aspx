<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarPlandeTrabajo.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.AdministrarPlandeTrabajo" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls.Cards" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>




<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <!--
  <script src="http://localhost:5000/Gojs/go.js"></script>
  <script src="http://localhost:5000/Gojs/Figures.js"></script>
  <script src="http://localhost:5000/Gojs/DrawCommandHandler.js"></script>

-->

</head>
<body style="background-color:white">
    <form id="form1" runat="server">
         <table style="width:100%">
               <tr>
                  <td style="width:100%" >
                    <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" />
                  </td>
              </tr>
             <tr>
                 <td style="width:100%"  align="center">
                     <table style="width:90%">
                         <tr>
                             <td style="width:80%" border="0">
                                    <table style="width:100%" border="0">
                                             <tr>
                                                 <td>
                                 
                                                         <table style="width:100%;" id="Principal" border="0" >
                                                                <tr>
                                                                    <td class="Etiqueta" valign="left" style="width:10%">NRO TICKET:</td>
                                                                    <td class="Etiqueta" valign="left" style="width:10%"> <cc1:EasyTextBox ID="EasytxtTicket" runat="server" ReadOnly="true" BackColor="#e6e6e6"></cc1:EasyTextBox></td>
                                                                    <td class="Etiqueta" valign="left"  style="width:5%">SERVICIO:</td>
                                                                    <td class="Etiqueta" valign="left" style="width:90%"><cc1:EasyPathHistory ID="EasyPathHistory1" runat="server" fncPathOnClick="AdministrarPlandeTrabajo.AgregarActividad"></cc1:EasyPathHistory></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="Etiqueta" valign="left" >
                                                                        DESCRIPCION:
                                                                    </td> 
                                                                    <td valign="left" colspan="3">
                                                                        <cc1:EasyTextBox ID="EasyTxtDescripcion" runat="server" BackColor="#e6e6e6"> TextMode="MultiLine" Height="80px" Width="100%"></cc1:EasyTextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="left" colspan="4">
                                                    
                                                                    </td>
                                                                </tr>
                                                        </table>
                                                     <input id="HServicioArea" runat="server" type="hidden" />

                                                 </td>
                                             </tr>
                                             <tr>
                                              <td>
                                                     <cc1:EasyToolBarButtons ID="EasyToolBarOts" runat="server">
                                                         <EasyButtons>
                                                             <cc1:EasyButton ID="btnAgregarPlan" Descripcion="" Icono="fa fa-calendar" RunAtServer="False" Texto="Nuevo Plan" Ubicacion="Derecha" />
                                                         </EasyButtons>
                                                     </cc1:EasyToolBarButtons>
                                              </td>
                                             </tr>
                                             <tr>
                                                 <td style="width:100%">
                                                   
                                                 </td>
                                             </tr>
                                         </table>
                             </td>
                             <td id="lstUserAten">
                                 
                             </td>
                         </tr>
                         <tr>
                             <td colspan="2" style="width:100%">
                                 <cc1:EasyTabControl ID="EasyTabPlan" runat="server" fncTabOnClick="AdministrarPlandeTrabajo.TabOnSelected" Ubicacion="Top"></cc1:EasyTabControl>
                             </td>
                         </tr>
                     </table>
                   
                            
                 </td>
             </tr>

         </table>

              
     <cc1:EasyPopupBase ID="EasyPopupItemCronograma" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Item de Actividad" RunatServer="false" DisplayButtons="true" ValidarDatos="true" CtrlDisplayMensaje="MsgErrActiv" fncScriptAceptar="DetalleItemCronograma.Aceptar">
     </cc1:EasyPopupBase>

     <cc1:EasyPopupBase ID="EasyPopupTarea" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Tareas de Actividad" RunatServer="false" DisplayButtons="true" ValidarDatos="true" CtrlDisplayMensaje="MsgErrTask" fncScriptAceptar="ListarTareas.Aceptar">
     </cc1:EasyPopupBase>

    <cc1:EasyPopupBase ID="EasyPopupTaskLineaTiempo" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Línea de tiempo" RunatServer="false" DisplayButtons="true"  fncScriptAceptar="">
    </cc1:EasyPopupBase>

    <cc1:EasyPopupBase ID="EasyPopupTaskLineaTiempoDet" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Programar/Desarrollar (Tarea)"  ValidarDatos="true" CtrlDisplayMensaje="msgErrorLT" RunatServer="false" DisplayButtons="true"  fncScriptAceptar="DetalleTaskTimeLine.Aceptar">
    </cc1:EasyPopupBase>

    <cc1:EasyPopupBase ID="EasyPopupDetallePlan" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Plan de Trabajo " RunatServer="false" DisplayButtons="true"  ValidarDatos="true" CtrlDisplayMensaje="msgErr"  fncScriptAceptar="DetallePlanTrabajo.Aceptar">
    </cc1:EasyPopupBase>

    <cc1:EasyPopupBase ID="EasyPopupBuscarPersona" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Buscar Persona" RunatServer="false" DisplayButtons="true"  fncScriptAceptar="BuscarPersonal.Aceptar">
    </cc1:EasyPopupBase>


    </form>
    <script>
        function OnEasyToolbarButton_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregarPlan":
                    var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/DetallePlanTrabajo.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministrarPlandeTrabajo.KEYIDREQUERIMIENTO, AdministrarPlandeTrabajo.Params[AdministrarPlandeTrabajo.KEYIDREQUERIMIENTO]);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarPlandeTrabajo.KEYIDSERVICIOAREA, jNet.get('HServicioArea').value);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarPlandeTrabajo.KEYIDRESPONSABLEATE, AdministrarPlandeTrabajo.Params[AdministrarPlandeTrabajo.KEYIDRESPONSABLEATE]);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarPlandeTrabajo.KEYIDPLANTRABAJO, "0");
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministraGantt.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                    oColletionParams.Add(oParam);


                    EasyPopupDetallePlan.Load(Url, oColletionParams, false);
                    break;
            }
        }

        AdministrarPlandeTrabajo.TabOnSelected = function (oTabSelect) {
            AdministrarPlandeTrabajo.ListarAnalistaAtencion();
        }

        AdministrarPlandeTrabajo.DetallePlan = function (IdPlan) {
            var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/DetallePlanTrabajo.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarPlandeTrabajo.KEYIDREQUERIMIENTO, AdministrarPlandeTrabajo.Params[AdministrarPlandeTrabajo.KEYIDREQUERIMIENTO]);
                oColletionParams.Add(oParam);
                oParam = new SIMA.Param(AdministraGantt.KEYIDPLANTRABAJO, IdPlan);
                oColletionParams.Add(oParam);
                oParam = new SIMA.Param(AdministrarPlandeTrabajo.KEYIDSERVICIOAREA, jNet.get('HServicioArea').value);
                oColletionParams.Add(oParam);
                oParam = new SIMA.Param(AdministrarPlandeTrabajo.KEYIDRESPONSABLEATE, AdministrarPlandeTrabajo.Params[AdministrarPlandeTrabajo.KEYIDRESPONSABLEATE] );
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(AdministraGantt.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
                oColletionParams.Add(oParam);

            EasyPopupDetallePlan.Load(Url, oColletionParams, false);
        }
    </script>
    <script>
        AdministrarPlandeTrabajo.ListarAnalistaAtencion=function(){
            var urlPag = Page.Request.ApplicationPath + "/HelpDesk/Atencion/ListarAnalistaAtencion.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarPlandeTrabajo.KEYIDREQUERIMIENTO, AdministrarPlandeTrabajo.Params[AdministrarPlandeTrabajo.KEYIDREQUERIMIENTO]);
            oColletionParams.Add(oParam);
            var oLoadConfig = {
                CtrlName: "lstUserAten",
                UrlPage: urlPag,
                ColletionParams: oColletionParams,
            };
            SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
        }        
        
        AdministrarPlandeTrabajo.AgregarActividad = function (oItempath) {
            switch (oItempath.Id) {
                case "EasyPathHistory1_Home":
                case "1":
                    var oPlanBE = EasyTabPlan.TabActivo.attr("Data").toString().SerializedToObject();

                    var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/DetalleItemCronograma.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministraGantt.KEYIDSERVICIOAREA, jNet.get('HServicioArea').attr('value'));
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministraGantt.KEYIDPLANTRABAJO, oPlanBE.ID_PLAN);
                    oColletionParams.Add(oParam);
                    
                    oParam = new SIMA.Param(AdministraGantt.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                    oColletionParams.Add(oParam);

                    EasyPopupItemCronograma.Load(Url, oColletionParams, false);//Llama a la ventana de mantenimiento detalle
                    
                    break;
            }
        }

        //Inicia la Carga de los usuarios responsables
        AdministrarPlandeTrabajo.ListarAnalistaAtencion();
    </script>
</body>
</html>
