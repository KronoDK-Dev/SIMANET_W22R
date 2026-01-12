<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarEstadoAtencionReque.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.AdministrarEstadoAtencionReque" %>

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
                <td  id="msgValRqr" colspan="3"></td>
           </tr>
           <tr>
               <td  class="Etiqueta" reference="EasyTxtEstado" >ESTADO:</td>
               <td style="width:70%"><cc1:EasyTextBox ID="EasyTxtEstado" ReadOnly="true" runat="server" Width="100%" required></cc1:EasyTextBox></td>
               <td>
                   <asp:Image ID="ImgEstado" runat="server" />
                   <cc1:EasyTextBox ID="hIdestado" ReadOnly="true" runat="server" Width="100%" ></cc1:EasyTextBox>
               </td>
           </tr>
           <tr>
               <td colspan="3" style="width:100%" class="Etiqueta" reference="EasyTxtObsEstado">
                   OBSERVACION:
               </td>
           </tr>
           <tr>
               <td colspan="3" >
                   <cc1:EasyTextBox ID="EasyTxtObsEstado" TextMode="MultiLine" runat="server" Width="100%" required></cc1:EasyTextBox>
               </td>
           </tr>

       </table>
    </form>
    <script>
        var EstadoSelectBE = null;
        AdministrarEstadoAtencionReque.PopupEstados = function () {
            var Config = {
                            Titulo: 'Cambio de Estado'
                             , IdTabla: 76
                             , IdSelected: AdministrarEstadoAtencionReque.Params[AdministrarEstadoAtencionReque.KEYQIDESTADO]
                             , ArrNotIn: [0]
                             , OrigenDB: "Oracle"
                             , width: "500px"
                             , TextField:"ABREV"
                            , fncOK: function (ItemBE) {
                                EstadoSelectBE = ItemBE;
                                //jNet.get('EasyTxtEstado').attr("value", ItemBE.ABREV);
                                EasyTxtEstado.SetValue(ItemBE.ABREV);
                                hIdestado.SetValue(ItemBE.IDITEM);
                             }
                         };
             SIMA.Utilitario.Helper.PopupTablaItems(Config);
        }

        AdministrarEstadoAtencionReque.Aceptar = function () {
            try {
                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("IdResponsable", AdministrarEstadoAtencionReque.Params[AdministrarEstadoAtencionReque.KEYIDRESPONSABLEATE]);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('Descripcion', EasyTxtObsEstado.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('IdEstado', hIdestado.GetValue(), TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                oParamCollections.Add(oParam);

                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
                oEasyDataInterConect.Metodo = 'RequerimientoResposableAtencionEstado_ins_Mod'; 
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var obj = oEasyDataResult.sendData();

                return true;
            }
            catch (SIMADataException) {
                var msgConfig = { Titulo: "Error al Eliminar Tarea", Descripcion: SIMADataException.Message };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }







            return true;
        }
    </script>
</body>
</html>
