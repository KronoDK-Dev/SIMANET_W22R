<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReprogramarTrabajador.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.ReprogramarTrabajador" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
  
</head>
<body>
    <form id="form1" runat="server">
      <table style="width:80%" align="center">
          <tr style="height:40px;border-style: dotted;border-width: 1px;border-color: #4783C2;border-radius: 5px;">
              <td class="Etiqueta" style="padding-left: 20px;">
                    TRABAJADOR: 
              </td>
              <td id="rpNombreTrab" runat="server" colspan="3" class="Etiqueta" style="padding-left: 20px;">

              </td>
          </tr>
          <tr>
              <td class="Etiqueta" rowspan="2">FECHA:</td>
              <td class="Etiqueta" style="padding-top:20px" reference="rpFIni">INICIO</td>
              <td class="Etiqueta" style="padding-top:20px" reference="rpFFin">TERMINO</td>
              <td></td>
          </tr>
          <tr>
              
              <td>
                  <cc1:EasyDatepicker ID="rpFIni" runat="server" required></cc1:EasyDatepicker></td>
              <td>
                  <cc1:EasyDatepicker ID="rpFFin" runat="server" required></cc1:EasyDatepicker></td>
              <td></td>
          </tr>
          <tr>
              <td class="Etiqueta" rowspan="2">HORA:</td>
              <td class="Etiqueta"  reference="rpHIni">INICIO</td>
              <td class="Etiqueta"  reference="rpHFin">TOLERANCIA</td>
              <td></td>
          </tr>

          <tr>
              <td>
                  <cc1:EasyTimePicker ID="rpHIni" runat="server" required />
              </td>
              <td>
                  <cc1:EasyTimePicker ID="rpHFin" runat="server" required />
              </td>
              <td></td>
          </tr>

      </table>
    </form>
    <script>

        ReprogramarTrabajador.Aceptar = function () {
            ReprogramarTrabajador.Data.ReprogramarTrabajador();
            return true;
        }

        ReprogramarTrabajador.Data = {};

        ReprogramarTrabajador.Data.ReprogramarTrabajador= function (NroDocumento) {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("Periodo", ReprogramarTrabajador.Params[DefaultContratista.KEYQAÑO], TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdProgramacion", ReprogramarTrabajador.Params[DefaultContratista.KEYQIDPROGRAMACION], TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NroDNI", ReprogramarTrabajador.Params[DefaultContratista.KEYQNRODOC]);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FIni", rpFIni.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FFin", rpFFin.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("HIni", rpHIni.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("HFin", rpHFin.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
            oEasyDataInterConect.Metodo = 'ReProgramarTrabajador_Act';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData();
        }

    </script>
</body>
</html>
