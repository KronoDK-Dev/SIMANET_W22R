<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HelpDeskListarAtenciones.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.HelpDeskListarAtenciones" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .Margen {
            margin-left:30px;
            width:90%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
      <table class="Margen">
          <tr>
              <td>
             <cc1:EasyGridView ID="EasyGridrqr" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="REQUERIMIENTO SOLICITADOS" Width="100%" AllowPaging="True"  fncExecBeforeServer="" OnRowDataBound="EasyGridrqr_RowDataBound" ToolBarButtonClick="OnEasyGridButton_Click"  >

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
                     </Columns>

                   <HeaderStyle CssClass="HeaderGrilla" />
                   <PagerStyle HorizontalAlign="Center" />
                   <RowStyle CssClass="ItemGrilla" Height="25px" />
        
             </cc1:EasyGridView>
              </td>
          </tr>
      </table>
    </form>
</body>
</html>
