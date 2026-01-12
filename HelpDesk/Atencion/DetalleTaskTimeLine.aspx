<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleTaskTimeLine.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.DetalleTaskTimeLine" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
   
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome-animation/0.2.1/font-awesome-animation.min.css" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css" crossorigin="anonymous">
   

</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%" border="0">
            <tr>
                <td colspan="6" id="msgErrorLT">
                </td>
            </tr>
            <tr>
                <td colspan="6" class="Etiqueta" >
                    ACCIONAR</td>
            </tr>
            
            <tr>
                <td style="width: 10%" class="Etiqueta" reference="EasyTxtAccionar" >
                   LABOR:
                </td>
                <td colspan="3">
                    <cc1:EasyTextBox ID="EasyTxtAccionar" runat="server" Width="100%"  required></cc1:EasyTextBox>
                </td>
                <td class="Etiqueta"  reference="EasyddlTipoAccion">
                    MEDIO:</td>
                <td>
                    <cc1:EasyDropdownList ID="EasyddlTipoAccion" runat="server" DataTextField="NOMBRE" DataValueField="IDITEM" required>
                    </cc1:EasyDropdownList>
                </td>
            </tr>
            
            <tr>
                <td class="Etiqueta">
                    CONCLUSIONES:&nbsp;</td>
                <td colspan="5" reference="EasyTxtDescripcionTask">
                    <cc1:EasyTextBox ID="EasyTxtDescripcionTask" runat="server" Height="80px" TextMode="MultiLine" Width="100%" required></cc1:EasyTextBox>
                </td>
            </tr>
            
            <tr>
                <td colspan="6" class="Etiqueta">
                    TIEMPO:</td>
            </tr>
            
            <tr>
                <td style="width: 10%" class="Etiqueta" reference="EasyTxtDescripcion">
                    DEDICADO</td>
                <td style="width: 10%">
                    <cc1:EasyTextBox ID="EasyTxtValTiempo" runat="server" Width="80px" required></cc1:EasyTextBox>
                </td>
                <td class="Etiqueta" reference="EasyddlTipoTime">
                    TIPO</td>
                <td>
                    <cc1:EasyDropdownList ID="EasyddlTipoTime" runat="server" DataTextField="NOMBRE" DataValueField="IDITEM" required>
                    </cc1:EasyDropdownList>
                </td>
                <td></td>
                <td></td>
            </tr>
            
        </table>
    </form>
</body>
    <script>
        DetalleTaskTimeLine.Aceptar = function () {

                DetalleTaskTimeLine.GuardarDatos();
                return true;
        }
       
        DetalleTaskTimeLine.GuardarDatos = function () {
            var IdHistory = ((DetalleTaskTimeLine.Params[DetalleTaskTimeLine.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.N.toString()) ? "0" : DetalleTaskTimeLine.Params[DetalleTaskTimeLine.KEYIDTASKITEMHISTORY]);
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdHistorial", IdHistory);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdTarea", DetalleTaskTimeLine.Params[DetalleTaskTimeLine.KEYIDTASKITEMCRONOGRAMA]);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("Nombre", EasyTxtAccionar.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("Descripcion", EasyTxtDescripcionTask.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdTipoAccion", EasyddlTipoAccion.GetValue(), TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdTipoTiempo", EasyddlTipoTime.GetValue(), TipodeDato.Int);
                oParamCollections.Add(oParam);  
                oParam = new SIMA.Param("valTipoTime", EasyTxtValTiempo.GetValue(), TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                oParamCollections.Add(oParam);

          

                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
                oEasyDataInterConect.Metodo = 'PlanCronogramaActividadTaskHistory_ins';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var obj = oEasyDataResult.sendData();
           
                EasyPopupTaskLineaTiempo.Reload();

            }
        


    </script>

    <style>
     
  
    </style>
   
</html>
