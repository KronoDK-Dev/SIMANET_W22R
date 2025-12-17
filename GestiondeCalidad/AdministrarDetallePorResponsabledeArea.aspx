<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarDetallePorResponsabledeArea.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.AdministrarDetallePorResponsabledeArea" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%">
              <tr>
                <td style="width:100%">
                    <cc3:EasyCardPerfil ID="EasyCardPerfil1" runat="server" BackColor="#F4F4F4"  BorderColor="#575757" BorderStyle="Dotted" BorderWidth="1px" >
                        <PathFoto></PathFoto>
                        <ApellidosyNombres></ApellidosyNombres>
                        <Area></Area>
                        <Email></Email>
                        <CssClassLine1>Etiqueta</CssClassLine1>
                        <CssClassLine2>Etiqueta</CssClassLine2>
                        <CssClassLine3></CssClassLine3>
                    </cc3:EasyCardPerfil>
                  </td>
            </tr>
            <tr>
                <td style="width:100%">
                        <cc1:EasyGridView ID="EasyGridViewAnotacion" runat="server" AutoGenerateColumns="False" TituloHeader="LISTA DE RESPUESTAS" Width="100%" ShowRowNumber="False" OnRowDataBound="EasyGridViewAnotacion_RowDataBound" ToolBarButtonClick="OnEasyGridButton_Click" BorderStyle="Groove" BorderWidth="1px">
                                        <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />

                                    <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="OnEasyGridDetalleProp_Click"></EasyExtended>

                                <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                                    <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                                    <Columns>
                                        <asp:BoundField DataField="FechaRpta" HeaderText="FECHA">
                                        <ItemStyle Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Observacion" HeaderText="ANOTACION">
                                        <ItemStyle HorizontalAlign="Left" Width="80%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FechaEnvio" HeaderText="FECHA ENVIO">
                                        <ItemStyle Width="10%" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="ESTADO">
                                    <ItemStyle HorizontalAlign="Left" Width="5%" />
                                </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="HeaderGrilla" Height="25px" />
                                    <RowStyle CssClass="ItemGrilla" Height="35px" />
                        </cc1:EasyGridView>
                </td>
            </tr>
        </table>
       
    </form>
</body>
</html>
