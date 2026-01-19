<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleIndicador.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.DetalleIndicador" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>



      <script>

          function onDisplayTemplatePersonal(ul, item) {

              var cmll = "\"";
              var IcoEmail = SIMA.Utilitario.Constantes.ImgDataURL.IconoParam;
              var ItemUser = '<table style="width:100%">'
                  + ' <tr>'
                  + '     <td rowspan="3" align="center" style="width:5%"><img class=" rounded-circle" width = "25px" src = "' + SIMA.Utilitario.Constantes.ImgDataURL.Home + '"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                  + '     <td class="Etiqueta" style="width:85%">' + item.NOMBRE_AREA + '</td>'
                  + '     <td rowspan="3" align="center" style="width:10%"><img class=" rounded-circle" width = "25px" src = "' + IcoEmail + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                  + ' </tr>'
                  + ' <tr>'
                  + '     <td>' + item.COD_AREA + '</td>'
                  + '</tr>'
                  + '</table>';

              iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                  + ItemUser
                  + '</a>';

              var oCustomTemplateBE = new EasyAcBuscarPersonal.CustomTemplateBE(ul, item, iTemplate);
              return EasyAcBuscarPersonal.SetCustomTemplate(oCustomTemplateBE);
          }




          //Evento para El control Autocmpletar    
          function onItemSeleccionado(value, ItemBE) {
     
          }

          function TemplateItem(oItemBE) {
              var Foto = SIMA.Utilitario.Constantes.ImgDataURL.Home;
              var tblItem = '<table border="0"> <tr> <td  style="width:auto;height:30px;"><img  style="width:20px;" src="' + Foto + '"/></td> <td   style="width:90%" >' + oItemBE.NOMBRE_AREA + '</td></tr></table>';
              return tblItem;
          }
      </script>



    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }
    </style>



</head>
<body> 
    <form id="form1" runat="server">
        <table style="width:100%">
            <tr>
                <td id="msgValRqr"  colspan="2"> </td>                           
            </tr>
            <tr>
                <td class="Etiqueta" style="width:20%"  >
                    CODIGO
                </td>
                <td style="width:80%">
                    <cc1:EasyTextBox ID="txtCodigo" runat="server" BackColor="#e6e6e6" ReadOnly="true"></cc1:EasyTextBox>
                </td>
            </tr>

            <tr>
                <td class="Etiqueta"  reference="txtNombre">
                    NOMBRE:
                </td>
                <td>
                   
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <cc1:EasyTextBox ID="txtNombre" TextMode="MultiLine" Height="80px" runat="server" required></cc1:EasyTextBox>
                </td>
            </tr>

            <tr>
                <td class="Etiqueta">
                    FORMULA:
                </td>
                <td>
                    
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <cc1:EasyTextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Height="100px"></cc1:EasyTextBox>
                </td>
            </tr>
            <tr>
                <td  class="Etiqueta" reference="EasyAcBuscarPersonal"> AREA</td>
                <td>
                    
                </td>
            </tr>
            <tr>
                <td colspan="2">
                     <cc1:EasyListAutocompletar ID="EasyAcBuscarPersonal" runat="server"  NroCarIni="4"  DisplayText="NOMBRE_AREA" ValueField="COD_AREA" fnOnSelected="onItemSeleccionado" fncTempaleCustom="onDisplayTemplatePersonal" fncTemplateCustomItemList="TemplateItem" CssClass="ContentLisItem" ClassItem="LstItem">
                        <EasyStyle Ancho="Dos"></EasyStyle>
                            <DataInterconect MetodoConexion="WebServiceExterno">
                                <UrlWebService>/General/Busquedas.asmx</UrlWebService>
                                <Metodo>BuscarArea</Metodo>
                                <UrlWebServicieParams>
                                    <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                </UrlWebServicieParams>
                            </DataInterconect>
                    </cc1:EasyListAutocompletar>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
