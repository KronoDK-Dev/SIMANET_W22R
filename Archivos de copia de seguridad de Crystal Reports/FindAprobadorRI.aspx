<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FindAprobadorRI.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.FindAprobadorRI" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Filtro" tagprefix="cc2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style>
        input{
            outline: none;
            box-shadow: 0px 0px 5px gray;
            border:1px solid black;
        }

        input:focus {
            outline: none;
            box-shadow: 0px 0px 5px blue;
            border:1px solid white;
        }
        input:focus:hover {
            outline: none;
            box-shadow: 0px 0px 5px blue;
            border:1px solid white;
            border-radius:0;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%" border="2">
         <tr>
             <td style="width:100%">
                 <cc3:EasyAutocompletar ID="EasyAcFindAprobador" runat="server" NroCarIni="1"  DisplayText="ApellidosyNombres" ValueField="IdPersonal" fnOnSelected="FindAprobadorRI.OnItemSelected" fncTempaleCustom="FindAprobadorRI.ItemplateAprobador" >
                     <EasyStyle Ancho="Dos"></EasyStyle>
                     <DataInterconect MetodoConexion="WebServiceInterno">
                          <UrlWebService>/GestiondeCalidad/Proceso.asmx</UrlWebService>
                          <Metodo>BuscarAprobadores</Metodo>
                          <UrlWebServicieParams>
                              <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                          </UrlWebServicieParams>
                      </DataInterconect>
                 </cc3:EasyAutocompletar>   
             </td>
         </tr>
  </table>
    </form>
</body>
    <script>
      
        FindAprobadorRI.ItemplateAprobador = function (ul, item) {
            var cmll = "\""; var iTemplate = null;
            var ImgFirma = FindAprobadorRI.PathImagenFirmas + item.Firma;
            var ItemUser = '<table style="width:100%">'
                + ' <tr>'
                + '     <td rowspan="3" align="center" style="width:5%"><img class=" rounded-circle" width = "60px" src = "' + FindAprobadorRI.PathFotosPersonal + item.NroDocIdentidad + '.jpg"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                + '     <td class="Etiqueta" style="font-size: 14px;width:75%">' + item.ApellidosyNombres + '</td>'
                + '     <td rowspan="3" align="center" style="width:40%"><img width = "80px" height="50px" src = "' + ImgFirma + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSFNormal;"></td>'
                + ' </tr>'
                + ' <tr>'
                + '    <td style="font-size: 10px;color:gray;">' + item.NombreArea + '</td>'
                + ' </tr>'
                + ' <tr>'
                + '     <td  style="font-weight: bold; font-size: 12px;color:gray; font-style: italic;">' + item.Email + '</td>'
                + '</tr>'
                + '</table>';

            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + ItemUser
                + '</a>';

            var oCustomTemplateBE = new EasyAcFindAprobador.CustomTemplateBE(ul, item, iTemplate);

            return EasyAcFindAprobador.SetCustomTemplate(oCustomTemplateBE);
        }

        FindAprobadorRI.OnItemSelected = function (value, ItemBE) {
            AdminstrarUsuariosFirmantes.AprobadorBE=ItemBE;
        }
    </script>
    
</html>
