<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarReposanbleAprobacion.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.ListarReposanbleAprobacion" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register src="../Controles/Header.ascx" tagname="Header" tagprefix="uc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Filtro" tagprefix="cc3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    

    <script>
        //Evento para El control Autocmpletar    
        function onItemSeleccionado(value, ItemBE) {
                //alert(value);
        }
    </script>


</head>
<body>
    <form id="form1" runat="server">
       <table style="width:100%; height:100%" border="0">
                <tr>
                    <td>

                        <asp:Label ID="Label1" runat="server" Text="Buscar Persona Responsable"></asp:Label>

                    </td>
                </tr>
            <tr>
                <td>
                          <cc2:EasyAutocompletar ID="EasyAutocompletAct" runat="server" NroCarIni="2"  DisplayText="ApellidosyNombres" ValueField="IdPersonal" fnOnSelected="onItemSeleccionado" Placeholder="Ingrese Apellidos y nombres.">
                            <EasyStyle Ancho="Dos"></EasyStyle>
                            <DataInterconect>
                                <UrlWebService>/RecursosHumanos/Personal.asmx</UrlWebService>
                                <Metodo>BuscarPersona</Metodo>
                                <UrlWebServicieParams>
                                    <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="TxtUserName" ObtenerValor="FormControl" />
                                </UrlWebServicieParams>
                            </DataInterconect>
                        </cc2:EasyAutocompletar>
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
