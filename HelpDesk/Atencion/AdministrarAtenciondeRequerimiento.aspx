<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarAtenciondeRequerimiento.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.AdministrarAtenciondeRequerimiento" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
 <table style="width:100%;"  border="0">
     <tr>
         <td>
             <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" /> </td>
     </tr>
     <tr>
         <td style="width:100%; height:100%">
             <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="GESTION DE TICKETS" Width="100%" AllowPaging="True"  ToolBarButtonClick="OnEasyGridButton_Click" OnRowDataBound="EasyGridView1_RowDataBound" OnEasyGridButton_Click="EasyGridView1_EasyGridButton_Click" fncExecBeforeServer="" OnPageIndexChanged="EasyGridView1_PageIndexChanged"  >
                 <EasyGridButtons>
                     <cc1:EasyGridButton ID="btnAgregarRqr" Descripcion="" Icono="fa fa-tags" MsgConfirm=""  RequiereSelecciondeReg="true" RunAtServer="True" Texto="Generar Requerimiento" Ubicacion="Derecha" />
                     <cc1:EasyGridButton ID="btnActividad" Descripcion="" Icono="fa fa-calendar" MsgConfirm=""  RequiereSelecciondeReg="true" RunAtServer="True" Texto="Plan de trabajo" Ubicacion="Centro" />
                     <cc1:EasyGridButton ID="btnRelacAct" Descripcion="" Icono="fa fa-tags" MsgConfirm=""  RequiereSelecciondeReg="true" RunAtServer="False" Texto="Vincular Actividades atendidas" Ubicacion="Centro" />
                 </EasyGridButtons>

                     <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                        <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect>
                     <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="OnEasyGridDetalle_Click" RowCellItemClick="" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                     <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
        
                     <AlternatingRowStyle CssClass="AlternateItemGrilla" />
        
                     <Columns>
                         <asp:BoundField DataField="NRO_TICKET" HeaderText="N° TICKET" >
                         <ItemStyle HorizontalAlign="Left" Width="2%" Wrap="False" />
                         </asp:BoundField>
                         <asp:TemplateField HeaderText="SOLICITANTE">
                             <ItemStyle Width="20%" />
                         </asp:TemplateField>
                         <asp:BoundField DataField="Fecha" HeaderText="FECHA" DataFormatString="{0:dd/MM/yyyy}" >
                         <ItemStyle HorizontalAlign="Left" Width="2%" />
                         </asp:BoundField>
                         <asp:BoundField DataField="PATHSERVICE" HeaderText="SERVICIO" >
                         <ItemStyle HorizontalAlign="Left" Width="20%" />
                         </asp:BoundField>
                         <asp:BoundField DataField="DESCRIPCION" HeaderText="DESCRIPCION " >
                         <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                         </asp:BoundField>
                         <asp:BoundField HeaderText="RESPONSABLE DE ATENCIÓN ESTADO" >
                         <HeaderStyle HorizontalAlign="Center" />
                         <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" Width="5%" />
                         </asp:BoundField>
                         <asp:TemplateField HeaderText="AVANCE">
                             <HeaderStyle HorizontalAlign="Center" />
                             <ItemStyle Width="20%" VerticalAlign="Middle" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="ESTADO"></asp:TemplateField>
                     </Columns>

                   <HeaderStyle CssClass="HeaderGrilla" />
                   <PagerStyle HorizontalAlign="Center" />
                   <RowStyle CssClass="ItemGrilla" Height="25px" />
        
             </cc1:EasyGridView>
         </td>
     </tr>
   
 </table>

     <cc3:EasyPopupBase ID="EasyPopupSprint" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Sprint" RunatServer="false" DisplayButtons="true" >
     </cc3:EasyPopupBase>

        
    <cc3:EasyPopupBase ID="EasyPopupActUserReq" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Actividades (Origen del Requerimiento)" RunatServer="false" DisplayButtons="true"  fncScriptAceptar="">
    </cc3:EasyPopupBase>
             
    <cc3:EasyPopupBase ID="EasyPopupEstAtencion" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Estado de Atención" ValidarDatos="true" CtrlDisplayMensaje="msgValRqr" RunatServer="false" DisplayButtons="true"  fncScriptAceptar="AdministrarEstadoAtencionReque.Aceptar">
    </cc3:EasyPopupBase>



    </form>
        <script>




            function OnEasyGridDetalle_Click() {

            }

            function OnEasyGridButton_Click(btnItem, DetalleBE) {

                switch (btnItem.Id) {
                    case "btnActividad":
                        /*
                        var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/AdministraGantt.aspx";

                        var oColletionParams = new SIMA.ParamCollections();
                        var oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDREQUERIMIENTO, DetalleBE.ID_REQU);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDPERSONAL, UsuarioBE.CodPersonal);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDRESPONSABLEATE, DetalleBE.ID_RESP_ATE);
                        oColletionParams.Add(oParam);

                        EasyPopupSprint.Load(Url, oColletionParams, false);
                        */

                        //AdministrarAtenciondeRequerimiento.SprintAll(DetalleBE);

                        break;
                    case "btnAsignar":

                        break;
                    case "btnRelacAct":
                        var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/AdmAtencionActXUseReq.aspx";
                        var oColletionParams = new SIMA.ParamCollections();
                        var oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDREQUERIMIENTO, DetalleBE.ID_REQU);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDPERSONALRQR, DetalleBE.CODPERSONALRQR);//Personal que realiza el requerimiento
                        oColletionParams.Add(oParam);

                        EasyPopupActUserReq.Load(Url, oColletionParams, false);//Llama a la ventana de mantenimiento detalle
                        break;
                }
            }


            

            AdministrarAtenciondeRequerimiento.AdministrarEstado = function () {
                
            }

            AdministrarAtenciondeRequerimiento.SprintAll = function (DetalleBE) {
                var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/AdministrarPlandeTrabajo.aspx";
                var oColletionParams = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDREQUERIMIENTO, DetalleBE.ID_REQU);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDPERSONAL, UsuarioBE.CodPersonal);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDRESPONSABLEATE, DetalleBE.ID_RESP_ATE);
                oColletionParams.Add(oParam);

                EasyPopupSprint.Load(Url, oColletionParams, false);
            }

            AdministrarAtenciondeRequerimiento.CambiarEstado = function () {
                //
                var oDataRow = EasyGridView1.GetDataRow();
                var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/AdministrarEstadoAtencionReque.aspx";
                var oColletionParams = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDREQUERIMIENTO, oDataRow["ID_REQU"]);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDPERSONAL, UsuarioBE.CodPersonal);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYIDRESPONSABLEATE, oDataRow["ID_RESP_ATE"]);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYQIDESTADO, oDataRow["IDESTADO"]);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(AdministrarAtenciondeRequerimiento.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
                oColletionParams.Add(oParam);

                EasyPopupEstAtencion.Load(Url, oColletionParams, false);
            }




        </script>

</body>

</html>
