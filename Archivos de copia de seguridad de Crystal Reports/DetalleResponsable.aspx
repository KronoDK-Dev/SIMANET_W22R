<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleResponsable.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Servicios.DetalleResponsable" %>
<%@ Register TagPrefix="cc2" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc5" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>

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
                <td>RESPONSABLE:</td>
            </tr>
            <tr>
                <td>
                    <cc2:EasyAutocompletar runat="server" DisplayText="APELLIDOSYNOMBRES" EnableOnChange="False" ID="EasyPersonal" Placeholder="Buscar Personal" Etiqueta="Personal" NroCarIni="3" ValueField="IDPERSONALO7">
                        <EasyStyle Ancho="Doce" />
                        <DataInterconect MetodoConexion="WebServiceExterno">
                            <UrlWebService>?</UrlWebService>
                            <Metodo>BuscarPeronal</Metodo>
                            <UrlWebServicieParams>
                                <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName"></cc5:EasyFiltroParamURLws>
                            </UrlWebServicieParams>
                        </DataInterconect>
                    </cc2:EasyAutocompletar>
                </td>
            </tr>
            <tr>
                <td>PRINCIPAL:</td>
            </tr>
            <tr>
                <td>
                    <cc2:EasyCheckBox runat="server" ID="chkPrincipal"></cc2:EasyCheckBox>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
