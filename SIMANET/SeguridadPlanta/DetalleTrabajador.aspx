<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleTrabajador.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.DetalleTrabajador" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Filtro" tagprefix="cc2" %>

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
                <td  reference="txtNroDoc">
                    NRO DOCUMENTO
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyTextBox ID="txtNroDoc" runat="server" required></cc1:EasyTextBox>
                </td>
            </tr>
            <tr>
                <td  reference="txtApPaterno">
                    APELLIDO PATERNO
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyTextBox ID="txtApPaterno" runat="server" required></cc1:EasyTextBox>
                </td>
            </tr>

            <tr>
                <td reference="txtApMaterno">
                    APELLIDO MATERNO
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyTextBox ID="txtApMaterno" runat="server" required></cc1:EasyTextBox>
                </td>
            </tr>
            <tr>
                <td reference="txtNombres">
                    NOMBRES:
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyTextBox ID="txtNombres" runat="server" required></cc1:EasyTextBox>
                </td>
            </tr>
            <tr>
                <td reference="ddlNacionalidad">
                    NACIONALIDAD:
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyDropdownList ID="ddlNacionalidad" runat="server" required DataTextField="Var1" DataValueField="Codigo" CargaInmediata="true" >
                        <EasyStyle Ancho="Dos"></EasyStyle>
                            <DataInterconect MetodoConexion="WebServiceExterno">
                                <ConfigPathSrvRemoto>PathBaseWSCore</ConfigPathSrvRemoto>
                                <UrlWebService>/General/General.asmx</UrlWebService>
                                <Metodo>ListarItemTablas</Metodo>
                                <UrlWebServicieParams>
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTablaGeneral" Paramvalue="458" TipodeDato="String"></cc2:EasyFiltroParamURLws>
                                    <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String"></cc2:EasyFiltroParamURLws>
                                </UrlWebServicieParams>
                            </DataInterconect>
                    </cc1:EasyDropdownList>
                </td>
            </tr>

        </table>   
    </form>
    <script>
        DetalleTrabajador.Data = {}
        DetalleTrabajador.Aceptar = function () {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("NroDNI", txtNroDoc.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("ApellidoPaterno", txtApPaterno.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("ApellidoMaterno", txtApMaterno.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Nombres", txtNombres.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdNacionalidad", ddlNacionalidad.GetValue() , TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
         

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
            oEasyDataInterConect.Metodo = 'ContratistaTrabajador_ins';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData();         

            switch (DetalleTrabajador.Params[DetalleTrabajador.KEYQQUIENLLAMA]) {
                case "ListaTrabajadores":
                        DefaultContratista.Data.RegistrarTrabajador(txtNroDoc.GetValue());
                        EasyTabBase.RefreshTabSelect();
                    break;
            }

            return true;
        }

      
    </script>
</body>
</html>
