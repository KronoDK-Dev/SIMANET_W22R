<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetallePlanTrabajo.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.DetallePlanTrabajo" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
</head>
<body >
    <form id="form1" runat="server">
       
	       <table style="width:100%">
               <tr>
                   <td colspan="2" id="msgErr">

                   </td>
               </tr>
               <tr>
                   <td class="Etiqueta" reference="EasyTxtNombre">
                       NOMBRE:
                   </td>
                   <td class="Etiqueta" reference="EasyddlTipo">TIPO:</td>
               </tr>
               <tr>
                   <td>
                       <cc1:EasyTextBox ID="EasyTxtNombre" runat="server" required></cc1:EasyTextBox>
                   </td>
                   <td>
                       <cc1:EasyDropdownList ID="EasyddlTipo" DataTextField="NOMBRE"  DataValueField="IDITEM" runat="server" required></cc1:EasyDropdownList>
                   </td>
               </tr>
               <tr>
                   <td colspan="2" class="Etiqueta" reference="EasytxtDescrip">
                       DESCRIPCION:
                   </td>
               </tr>
               <tr>
                   <td colspan="2">
                       <cc1:EasyTextBox ID="EasytxtDescrip" runat="server" TextMode="MultiLine" Height="80px" required></cc1:EasyTextBox>
                   </td>
               </tr>
               <tr>
                   <td class="Etiqueta" colspan="2">
                       <table style="width:80%">
                           <tr>
                               <td style="width:5%">
                                   AVANCE:
                               </td>
                               <td style="width:45%" id="ContentProg" runat="server">

                               </td>
                               <td style="width:50%">

                               </td>
                           </tr>
                       </table>
                       
                   </td>
               </tr>
	       </table>
         <input id="IdRespAte" type="hidden"  runat="server"/>



    </form>
    <script>
        DetallePlanTrabajo.Aceptar = function () {
            var ResultBE = DetallePlanTrabajo.Guardar().toString().SerializedToObject();
            if (ResultBE.IdOut != "-1") {
                return true;
            }
        }

        DetallePlanTrabajo.Guardar = function () {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdPlan", DetallePlanTrabajo.Params[DetallePlanTrabajo.KEYIDPLANTRABAJO]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdRequerimiento", DetallePlanTrabajo.Params[DetallePlanTrabajo.KEYIDREQUERIMIENTO]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdServicioArea", DetallePlanTrabajo.Params[DetallePlanTrabajo.KEYIDSERVICIOAREA]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdResponsableAtiende", DetallePlanTrabajo.Params[DetallePlanTrabajo.KEYIDRESPONSABLEATE]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Nombre", EasyTxtNombre.GetValue());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Descripcion", EasytxtDescrip.GetValue());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdTipo", EasyddlTipo.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            oEasyDataInterConect.Metodo = 'PlandeTrabajo_ins';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var obj = oEasyDataResult.sendData();
            return obj;
        }
    </script>
</body>
  
</html>
