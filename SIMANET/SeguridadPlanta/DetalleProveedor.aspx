<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleProveedor.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.DetalleProveedor" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

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
                <td colspan="2" id="msgValRqrPrv"></td>
            </tr>
            <tr>
                <td  class="Etiqueta" reference="txtRuc">NRO RUC:</td>
                <td style="width:80%">
                    <cc1:EasyTextBox ID="txtRuc" runat="server" required></cc1:EasyTextBox></td>
            </tr>
            <tr>
                <td class="Etiqueta" reference="txtRSocial">RAZON SOCIAL:</td>
                <td style="width:80%">
                    <cc1:EasyTextBox ID="txtRSocial" runat="server" required></cc1:EasyTextBox></td>
            </tr>

        </table>
       
    </form>


    <script>
        DetalleProveedor.Aceptar = function () {

            var oParamCollections = new SIMA.ParamCollections();

            oParam = new SIMA.Param("IdTipo", "1", TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NroRuc", txtRuc.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("RazonSocial", txtRSocial.GetValue());
            oParamCollections.Add(oParam);


            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/SIMANET/SeguridadPlanta/Contratista.asmx';
            oEasyDataInterConect.Metodo = 'CrearProveedorCliente';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultId = oEasyDataResult.sendData();
            

            switch (DetalleProveedor.Params[DetalleProveedor.KEYQQUIENLLAMA]) {
                case "AdministrarProgramacionContratista":
                    acProveedor.SetValue(ResultId, txtRuc.GetValue());
                    acRSocial.SetValue(ResultId, txtRSocial.GetValue());
                    break;
            }

            return true;
        }
    </script>
    
</body>
</html>
