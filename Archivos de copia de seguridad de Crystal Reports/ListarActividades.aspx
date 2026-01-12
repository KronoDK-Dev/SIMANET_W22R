<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarActividades.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.ListarActividades" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register src="../Controles/Header.ascx" tagname="Header" tagprefix="uc1" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Filtro" tagprefix="cc3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script>
        //Evento para El control Autocmpletar    
        function onItemSeleccionado(value, ItemBE) {
             //alert(value);
        }
    </script>
</head>
<body>
    <form id="formActividades" runat="server" aria-grabbed="undefined">
      
            <table style="width:100%; height:100%" border="0">
                <tr>
                    <td>

                        <asp:Label ID="Label1" runat="server" Text="Buscar Actividad"></asp:Label>

                    </td>
                </tr>
            <tr>
                <td>
                        <cc2:EasyAutocompletar ID="EasyAutocompletAct" runat="server" NroCarIni="2"  DisplayText="NombreActividad" ValueField="CODIGO" fnOnSelected="onItemSeleccionado" Placeholder="Ingrese el Nombre de la Actividad.">
                            <EasyStyle Ancho="Dos"></EasyStyle>
                            <DataInterconect>
                                <UrlWebService>/GestiondeCalidad/Proceso.asmx</UrlWebService>
                                <Metodo>BuscarActividad</Metodo>
                                <UrlWebServicieParams>
                                    <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="TxtUserName" ObtenerValor="FormControl" />
                                </UrlWebServicieParams>
                            </DataInterconect>
                        </cc2:EasyAutocompletar>
                 

                   </td>
            </tr>
            <tr>
                <td>

                    <cc1:EasyGridView ID="EasyGridViewActividades" runat="server" AutoGenerateColumns="False" TituloHeader="DETALLE" ToolBarButtonClick="OnEasyGridActividades_Click" OnRowDataBound="EasyGridViewActividades_RowDataBound" Width="100%" ShowFooter="false">
                        <EasyGridButtons>
                            <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RequiereSelecciondeReg="false" RunAtServer="False" SolicitaConfirmar="False" Texto="Agregar" Ubicacion="Derecha" />
                            <cc1:EasyGridButton ID="btnEliminar" Descripcion="" Icono="" MsgConfirm="Desea eliminar este registro ahora?" RequiereSelecciondeReg="True" RunAtServer="False" SolicitaConfirmar="True" Texto="Eliminar" Ubicacion="Derecha" />
                        </EasyGridButtons>
                         <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />

                        <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="OnEasyGridDetalle_Click"></EasyExtended>

                    <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                        <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                        <Columns>
                            <asp:BoundField DataField="DESCRIPCION" HeaderText="ACTIVIDAD">
                            <ItemStyle HorizontalAlign="Left" Width="80%" />
                            </asp:BoundField>
                        </Columns>
                        <HeaderStyle CssClass="HeaderGrilla" Height="25px" />
                        <RowStyle CssClass="ItemGrilla" Height="35px" />
                    </cc1:EasyGridView>
                
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="TxtUserName" runat="server" ></asp:TextBox>
                </td>
            </tr>
        </table>


    </form>
</body>
</html>
