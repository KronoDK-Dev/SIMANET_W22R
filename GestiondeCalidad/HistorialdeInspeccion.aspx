<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistorialdeInspeccion.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.HistorialdeInspeccion" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register src="../Controles/Header.ascx" tagname="Header" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content=http://localhost/SIMANET_W22R/Login.aspx"text/html; charset=utf-8"/>
    <title></title>
       <!--Pagina de detalle de inspecciones-->
  


    <script>
        function onCompletado(WinUpLoad, oCollectionsFile) {
            oCollectionsFile.forEach(function (oFileBE) {
                alert(oFileBE.Nombre);
            });

            WinUpLoad.Close();
        }
        function onListViewGeneric(Accion, Source, oItem) {
            alert(Source.id + ' ' + oItem.Url);
            return true;
        }



    </script>
</head>
<body>
    <form id="formInspecciones" runat="server" aria-grabbed="undefined">
      
            <table style="width:100%; height:100%" border="0">
            <tr>
                <td>
                   </td>
            </tr>
            <tr>
                <td>

                    <cc1:EasyGridView ID="EasyGridViewInspeciones" runat="server" AutoGenerateColumns="False" TituloHeader="DETALLE" ToolBarButtonClick="OnEasyGridInspecionesButton_Click" OnRowDataBound="EasyGridViewInspeciones_RowDataBound" ShowRowNumber="False" Width="100%">
                        <EasyGridButtons>
                            <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RequiereSelecciondeReg="false" RunAtServer="False" SolicitaConfirmar="False" Texto="Agregar" Ubicacion="Derecha" />
                        </EasyGridButtons>
                         <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />

                        <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="OnEasyGridDetalle_Click"></EasyExtended>

                    <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                        <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                        <Columns>
                            <asp:TemplateField HeaderText="FECHA">
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DESCRIPCION">
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RECOMENDACIONES">
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CLAUSULA">
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="20%" />
                            </asp:TemplateField>                           
                            <asp:TemplateField HeaderText="ANEXO"></asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="HeaderGrilla" Height="25px" />
                        <RowStyle CssClass="ItemGrilla" />
                    </cc1:EasyGridView>
                
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>


    </form>
</body>
    
</html>
