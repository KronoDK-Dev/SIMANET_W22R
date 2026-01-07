<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarAprobaciondeRequerimiento.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Requerimiento.AdministrarAprobaciondeRequerimiento" %>

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
                     <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="GESTION DE TICKETS" ToolBarButtonClick="OnEasyGridButton_Click" Width="100%" AllowPaging="True" OnRowDataBound="EasyGridView1_RowDataBound" OnEasyGridDetalle_Click="EasyGridView1_EasyGridDetalle_Click" fncExecBeforeServer="" OnPageIndexChanged="EasyGridView1_PageIndexChanged" OnEasyGridButton_Click="EasyGridView1_EasyGridButton_Click">
                         <EasyGridButtons>
                             <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Texto="Agregar" Ubicacion="Derecha" />
                             <cc1:EasyGridButton ID="btnEliminar" Descripcion="" Icono="fa fa-close" MsgConfirm="Desea Eliminar este registro ahora?" RequiereSelecciondeReg="true" SolicitaConfirmar="true" RunAtServer="True" Texto="Eliminar" Ubicacion="Derecha" />
                         </EasyGridButtons>

                             <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                 <DataInterconect MetodoConexion="WebServiceExterno">
                                     <UrlWebService></UrlWebService>
                                     <Metodo>Requerimientos_lst</Metodo>
                                     <UrlWebServicieParams>
                                         <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdUsuario" Paramvalue="IdUsuario" TipodeDato="Int" />
                                         <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="UserName" TipodeDato="String"/>
                                     </UrlWebServicieParams>
                                 </DataInterconect>

                             <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                             <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                
                             <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                
                             <Columns>
                                 <asp:BoundField DataField="NRO_TICKET" HeaderText="N° TICKET" >
                                 <ItemStyle HorizontalAlign="Left" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="FECHA_AD" HeaderText="FECHA" DataFormatString="{0:dd/MM/yyyy}" >
                                 <ItemStyle HorizontalAlign="Left" Width="4%" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="PATHSERVICE" HeaderText="SERVICIO" >
                                 <ItemStyle HorizontalAlign="Left" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="DESCRIPCION" HeaderText="DESCRIPCION " >
                                 <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                 </asp:BoundField>
                                 <asp:BoundField HeaderText="APROBADORES" >
                                 <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                 </asp:BoundField>
                                 <asp:TemplateField HeaderText="ESTADO"></asp:TemplateField>
                             </Columns>

                           <HeaderStyle CssClass="HeaderGrilla" />
                           <PagerStyle HorizontalAlign="Center" />
                           <RowStyle CssClass="ItemGrilla" Height="25px" />
                
                     </cc1:EasyGridView>
                 </td>
            </tr>    
        </table>
    </form>
     <script>
             function OnEasyGridButton_Click(btnItem, DetalleBE) {

                 switch (btnItem.Id) {
                     case "btnAgregar":
                         AdministrarRequerimiento.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.N, "0");
                         break;
                 }
             }
         </script>
</body>
</html>
