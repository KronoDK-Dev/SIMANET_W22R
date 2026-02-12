<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarResponsablePorArea.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.AdministrarResponsablePorArea" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>



<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc4" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc5" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    

      <script>

          function onDisplayTemplateArea(ul, item) {

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

              var oCustomTemplateBE = new aucArea.CustomTemplateBE(ul, item, iTemplate);
              return aucArea.SetCustomTemplate(oCustomTemplateBE);
          }




          //Evento para El control Autocmpletar    
          function onItemSeleccionado(value, ItemBE) {
              AdministrarResponsablePorArea.ListarResponsables();
          }



          function TemplateItem(oItemBE) {
              var Foto = SIMA.Utilitario.Constantes.ImgDataURL.Home;
              var tblItem = '<table border="0"> <tr> <td  style="width:auto;height:30px;"><img  style="width:20px;" src="' + Foto + '"/></td> <td   style="width:90%" >' + oItemBE.NOMBRE_AREA + '</td></tr></table>';
              return tblItem;
          }



          function onItemPersonalSeleccionado(value, ItemBE) {
              if (ItemBE.EXISTE != '0') {
                  var msgConfig = { Titulo: "AGREGAR RESPONSABLE", Descripcion: 'No es posible completar esta acción </br>el registro de responsable que desea agregar ya existe' };
                  var oMsg = new SIMA.MessageBox(msgConfig);
                  oMsg.Alert();
                  aucPersona.SetValue('0', '');
              }
              else {
                  AdministrarResponsablePorArea.GuardarDatos(ItemBE);
                  AdministrarResponsablePorArea.ListarResponsables();
                  aucPersona.SetValue("","");
              }
          }







          function onDisplayTemplatePersonal(ul, item) {

              var cmll = "\"";
              var IcoEmail = SIMA.Utilitario.Constantes.ImgDataURL.IconoParam;
              var FotoPersonal = AdministrarResponsablePorArea.PathFotosPersonal + item.NRODNI + '.jpg';
              var ItemUser = '<table style="width:100%">'
                  + ' <tr>'
                  + '     <td rowspan="3" align="center" style="width:5%"><img class=" rounded-circle" width = "25px" src = "' + FotoPersonal + '"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                  + '     <td class="Etiqueta" style="width:85%">' + item.APELLIDOSNOMBRES+ '</td>'
                  + '     <td rowspan="3" align="center" style="width:10%"><img class=" rounded-circle" width = "25px" src = "' + IcoEmail + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                  + ' </tr>'
                  + ' <tr>'
                  + '     <td>' + item.CODAREA + '</td>'
                  + '</tr>'
                  + '</table>';

              iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                  + ItemUser
                  + '</a>';

              var oCustomTemplateBE = new aucArea.CustomTemplateBE(ul, item, iTemplate);
              return aucArea.SetCustomTemplate(oCustomTemplateBE);
          }

          function GetCodArea() {
              return aucArea.GetValue();
          }
      </script>


</head>
<body> 
    <form id="form1" runat="server">
        <table style="width:100%;height:100%"  border="0">
            <tr>
                <td>
                     <uc1:Header runat="server" ID="Header" />
                </td>
            </tr>
            <tr>
                <td align="center">
                     <table style="width:50%;height:50%" >
                         <tr>
                             <td  style="width:10%;" class="Etiqueta">
                                 AREA:
                             </td>
                             <td  style="width:90%;">
                                  <cc1:EasyAutocompletar ID="aucArea" runat="server"  NroCarIni="4"  DisplayText="NOMBRE_AREA" ValueField="IDAREA" fnOnSelected="onItemSeleccionado" fncTempaleCustom="onDisplayTemplateArea">
                                     <EasyStyle Ancho="Dos"></EasyStyle>
                                         <DataInterconect MetodoConexion="WebServiceExterno">
                                             <UrlWebService>/GestionGobernanza/Indicadores.asmx</UrlWebService>
                                             <Metodo>BuscarArea</Metodo>
                                         </DataInterconect>
                                 </cc1:EasyAutocompletar>

                             </td>
                         </tr>
                         <tr>
                             <td class="Etiqueta">
                                 RESPONSABLE:
                             </td>
                             <td>
                                 <cc1:EasyAutocompletar ID="aucPersona" runat="server"  NroCarIni="4"  DisplayText="APELLIDOSNOMBRES" ValueField="NRODNI" fnOnSelected="onItemPersonalSeleccionado" fncTempaleCustom="onDisplayTemplatePersonal">
                                        <EasyStyle Ancho="Dos"></EasyStyle>
                                        <DataInterconect MetodoConexion="WebServiceExterno">
                                             <UrlWebService>/General/Busquedas.asmx</UrlWebService>
                                             <Metodo>BuscarPeronalPorTipo</Metodo>
                                             <UrlWebServicieParams>
                                                 <cc3:EasyFiltroParamURLws  ParamName="CodArea" Paramvalue="GetCodArea()" ObtenerValor="FunctionScript"/>
                                                 <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                             </UrlWebServicieParams>
                                         </DataInterconect>
                                     </cc1:EasyAutocompletar>
                             </td>
                         </tr>

                         <tr>
                             <td colspan="2" class="Etiqueta">
                                 LISTA DE RESPONSABLE:
                             </td>
                         </tr>
                         <tr>
                             <td colspan="2" id="RespContent">
             
                             </td>
                         </tr>

                     </table>
                </td>
            </tr>

        </table>
       
    <script>
        AdministrarResponsablePorArea.GuardarDatos = function (ItemReponSeleccionadoBE) {

           

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdItem", ItemReponSeleccionadoBE.IDITEM);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("CodArea", aucArea.GetValue());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("CodEmp", ItemReponSeleccionadoBE.CODEMP);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("CodCeo", ItemReponSeleccionadoBE.CODCEO);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdUsuarioRepon", ItemReponSeleccionadoBE.IDUSUARIO);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
            oEasyDataInterConect.Metodo = 'ResponsablePorArea_Ins';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData();

            return true;
        }


        AdministrarResponsablePorArea.ListarResponsables = function () {

            var DataAreaBE = aucArea.GetItemSelected();

            var urlPag = Page.Request.ApplicationPath + "/GestionGobernanza/Indicadores/ListaReponsablePorArea.aspx";
            var oColletionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(AdministrarResponsablePorArea.KEYCODAREA, aucArea.GetValue());
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarResponsablePorArea.KEYCODEMP, DataAreaBE.COD_EMP);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarResponsablePorArea.KEYCODSUC, DataAreaBE.COD_SUC);
            oColletionParams.Add(oParam);


            var oLoadConfig = {
                CtrlName: "RespContent",
                UrlPage: urlPag,
                ColletionParams: oColletionParams,
                fnOnComplete: function () {
                    //alert('Terminado');
                }
            };


            SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
        }


        AdministrarResponsablePorArea.EliminarResponsable = function (IDTBL,IDITEM) {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdTabla", IDTBL);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdItem", IDITEM);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
            oEasyDataInterConect.Metodo = 'ResponsablePorArea_Del';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData();
        }
    </script>
        <asp:HyperLink ID="HyperLink1"  style="display:block" runat="server" NavigateUrl="~/SIMANET/SeguridadPlanta/AdministrarProgramacionContratista.aspx">HyperLink</asp:HyperLink>
       
    </form>

    </body>
</html>
