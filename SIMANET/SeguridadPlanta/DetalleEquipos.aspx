<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleEquipos.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.DetalleEquipos" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%;" border="0" id="tblEquipos">
              <tr>
                  <td style="width:10%" class="Etiqueta"  reference="txtCodigo">
                      CODIGO:
                  </td>
                  <td style="width:30%">
                      <cc1:EasyTextBox ID="txtCodigo" runat="server" required></cc1:EasyTextBox>
                  </td>               
                  <td class="Etiqueta" reference="txtCant">CANTIDAD</td>
                  <td style="width:10%"><cc1:EasyTextBox ID="txtCant" runat="server" required> </cc1:EasyTextBox></td>
                  <td class="Etiqueta" reference="ddlTipo">TIPO</td>
                  <td style="width:50%"> <cc1:EasyDropdownList ID="ddlTipo" runat="server" required></cc1:EasyDropdownList></td>
                  <td style="width:50%"></td>
              </tr>
              <tr>
                  <td class="Etiqueta"  colspan="7" reference="txtDescripcion">DESCRIPCION:</td>
              </tr>
              <tr>
                  <td colspan="7"><cc1:EasyTextBox ID="txtDescripcion"  TextMode="MultiLine" Height="80px"  runat="server" required></cc1:EasyTextBox></td>
              </tr>
          </table>
    </form>
    <script>
        DetalleEquipos.Aceptar = function () {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("NroProgramacion", DetalleEquipos.Params[DetalleEquipos.KEYQIDPROGRAMACION], TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Periodo", DetalleEquipos.Params[DetalleEquipos.KEYQAÑO], TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NroItem", ((DetalleEquipos.Params[DetalleEquipos.KEYQIDEQUIPO] == undefined) ? "0" : DetalleEquipos.Params[DetalleEquipos.KEYQIDEQUIPO]), TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Codigo", txtCodigo.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Descripcion", txtDescripcion.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Cantidad", txtCant.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdTipoInOut", ddlTipo.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Modo", DetalleEquipos.Params[DetalleEquipos.KEYMODOPAGINA]);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
            oEasyDataInterConect.Metodo = 'ContratistaEquipos_insMod';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData();

            EasyTabBase.RefreshTabSelect();

            return true;
        }
    </script>
</body>
</html>
