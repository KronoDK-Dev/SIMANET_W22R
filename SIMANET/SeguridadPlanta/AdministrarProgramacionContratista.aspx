<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarProgramacionContratista.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.AdministrarProgramacionContratista" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%;">
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" />
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyGridView ID="EasyGRContrata"   AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Programación de Contratistas" ToolBarButtonClick="OnEasyGridButton_Click" Width="100%" AllowPaging="True" runat="server" fncExecBeforeServer="" OnRowDataBound="EasyGRContrata_RowDataBound" OnPageIndexChanged="EasyGRContrata_PageIndexChanged">
                            <EasyGridButtons>
                                <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RequiereSelecciondeReg="False" RunAtServer="False" SilenceWait="True" SolicitaConfirmar="False" Texto="Agregar" Ubicacion="Derecha" />
                                <cc1:EasyGridButton ID="btnEliminar" Descripcion="" Icono="fa fa-close" MsgConfirm="Desea eliminar ahora el registro seleccionado?" RequiereSelecciondeReg="True" RunAtServer="True" SilenceWait="False" SolicitaConfirmar="True" Texto="Eliminar" Ubicacion="Derecha" />
                                <cc1:EasyGridButton ID="btnTrabEquipo" Descripcion="" Icono="fa fa-user-plus" RequiereSelecciondeReg="True" RunAtServer="False" SilenceWait="False" Texto="Trabajadores / Equipos" Ubicacion="Centro" />
                            </EasyGridButtons>
                            <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                            <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect>
                            
                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" IdGestorFiltro="null" RowCellItemClick=" AdministrarProgramacionContratista.InformacionGeneral"></EasyExtended>

                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                            <Columns>
                             <asp:BoundField DataField="NroProg" HeaderText="N° PROGR." />
                             <asp:BoundField DataField="NroDocumentodeRef" HeaderText="NRO DOC. REF." SortExpression="NroDocumentodeRef" >
                             <ItemStyle HorizontalAlign="Left" Width="8%" />
                             </asp:BoundField>
                             <asp:BoundField DataField="NroProveedor" HeaderText="NRO R.U.C" SortExpression="NroProveedor" >
                             <ItemStyle HorizontalAlign="Left" />
                             </asp:BoundField>
                             <asp:BoundField DataField="RazonSocialProveedor" HeaderText="RAZON SOCIAL" SortExpression="RazonSocialProveedor" >
                             <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Wrap="False" />
                             </asp:BoundField>
                             <asp:BoundField DataField="NombreNave" HeaderText="NOMBRE NAVE" >
                             <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                             </asp:BoundField>
                             <asp:TemplateField HeaderText="FECHA">
                                 <ItemStyle Width="8%" HorizontalAlign="Center" />
                                </asp:TemplateField>
                             <asp:TemplateField HeaderText="HORA">
                                 <ItemStyle Width="8%" />
                                </asp:TemplateField>
                             <asp:BoundField HeaderText="NRO TRAB." DataField="NroTrab" >
                                <ItemStyle Width="4%" />
                                </asp:BoundField>
                         </Columns>
                           <HeaderStyle CssClass="HeaderGrilla" />
                           <PagerStyle HorizontalAlign="Center" />
                           <RowStyle CssClass="ItemGrilla" Height="25px" />
                        </cc1:EasyGridView>
                </td>
            </tr>

        </table>
        <cc2:EasyPopupBase ID="EasyPopInfoGen" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="PROGRAMACIÓN CONTRATISTA"   ValidarDatos="true"  RunatServer="true" DisplayButtons="true" fncScriptAceptar="DetalleProgramacion.Aceptar" OnClick="EasyPopInfoGen_Click" ></cc2:EasyPopupBase>
        <cc2:EasyPopupBase ID="EasyPopupPrv" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="PROVEEDOR"   ValidarDatos="true"  RunatServer="false" DisplayButtons="true" fncScriptAceptar="DetalleProveedor.Aceptar"></cc2:EasyPopupBase>
        <cc2:EasyPopupBase ID="EasyPopupTrabEqui" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="TRABAJADORES Y EQUIPOS"   ValidarDatos="true"  RunatServer="false" DisplayButtons="true" fncScriptAceptar=""  ></cc2:EasyPopupBase>

        <cc2:EasyPopupBase ID="EasyPopupFeriado" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="TRABAJADORES EN FERIADOS"   ValidarDatos="true"  RunatServer="false" DisplayButtons="true" fncScriptAceptar=""  ></cc2:EasyPopupBase>

    </form>
    <script>

        function OnEasyGridButton_Click(btnItem, DetalleBE) {

          
            switch (btnItem.Id) {
                case "btnAgregar":

                    var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleProgramacion.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQIDPROGRAMACION, "0");
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQAÑO, "0");
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                    oColletionParams.Add(oParam);

                    EasyPopInfoGen.Load(Url, oColletionParams, false);

                    break;

                case "btnTrabEquipo":

                    var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DefaultContratista.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQIDPROGRAMACION, DetalleBE.NroProgramacion);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQAÑO, DetalleBE.Periodo);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQFECHAINI, DetalleBE.FechaInicio);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQFECHAFIN, DetalleBE.FechaTermino);
                    oColletionParams.Add(oParam);
                    //falta envia la hora de inicio y la hora de fin de la programacion
                    oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQHORAINI, DetalleBE.HoraInicio);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQHORAFIN, DetalleBE.HoraTermino);
                    oColletionParams.Add(oParam);

                    EasyPopupTrabEqui.Load(Url, oColletionParams, false);
                    break;
            }
        }

        AdministrarProgramacionContratista.InformacionGeneral = function (oItemRowBE) {

            var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleProgramacion.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQIDPROGRAMACION, oItemRowBE.NroProgramacion);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQAÑO, oItemRowBE.Periodo);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
            oColletionParams.Add(oParam);


            EasyPopInfoGen.Load(Url, oColletionParams, false);
       
        }

        AdministrarProgramacionContratista.DetalleProveedor = function (oItemRowBE) {

            var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleProveedor.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQQUIENLLAMA, "AdministrarProgramacionContratista");
            oColletionParams.Add(oParam);

            EasyPopupPrv.Load(Url, oColletionParams, false);
        }


    </script>
</body>
</html>
