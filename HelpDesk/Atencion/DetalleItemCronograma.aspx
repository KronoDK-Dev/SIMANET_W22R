<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleItemCronograma.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.DetalleItemCronograma" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table border="0" style="width:100%">
               <tr>
                   <td colspan="6"  class="Etiqueta" id="MsgErrActiv">
                   </td>

              </tr>
             <tr>
                 <td class="Etiqueta" reference="eddlActividad">
                     ACTIVIDAD:
                 </td>
                 <td>
                     <cc1:EasyDropdownList ID="eddlActividad" runat="server" required></cc1:EasyDropdownList>
                 </td>
                 <td>

                 </td>
                  <td>

                 </td>
                 <td>

                 </td>
                 <td>

                 </td>

             </tr>

             <tr>
                 <td colspan="6"  class="Etiqueta" reference="EasyDescripcion">
                     DESCRIPCION:</td>

            </tr>

             <tr>
                 <td colspan="6">
                     <cc1:EasyTextBox ID="EasyDescripcion" runat="server" TextMode="MultiLine" required></cc1:EasyTextBox>
                 </td>

            </tr>

             <tr>
                 <td>
                     &nbsp;</td>
                  <td>
                      &nbsp;</td>
                 <td>

                     &nbsp;</td>
                 <td>

                     &nbsp;</td>
                  <td>

                      &nbsp;</td>
                  <td>

                    </td>

            </tr>
        </table>
    </form>
    
</body>
    <script>
        DetalleItemCronograma.Aceptar = function () {
           // if (SIMA.Utilitario.Helper.Form.Validar()) {
                DetalleItemCronograma.GuardarDatos();
                EasyTabPlan.RefreshTabSelect();
                return true;
            //}
        }

        DetalleItemCronograma.GuardarDatos = function () {

            var IdCronogramaActividad = ((DetalleItemCronograma.Params[DetalleItemCronograma.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.N.toString()) ? "0" : DetalleItemCronograma.Params[DetalleItemCronograma.KEYIDTASKITEMCRONOGRAMA]);
                var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdCronogramaActividad", IdCronogramaActividad);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdCronogramaActividadPadre", "0");
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("Descripcion", EasyDescripcion.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdActividad", eddlActividad.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdPlan", DetalleItemCronograma.Params[DetalleItemCronograma.KEYIDPLANTRABAJO]);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                oParamCollections.Add(oParam);

                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
                oEasyDataInterConect.Metodo = 'PlanCronogramaActividad_ins';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var obj = oEasyDataResult.sendData();

            }

        
    </script>
</html>
