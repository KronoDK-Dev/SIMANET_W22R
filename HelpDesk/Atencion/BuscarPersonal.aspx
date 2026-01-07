<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BuscarPersonal.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.BuscarPersonal" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
       <script>

       function onDisplayTemplatePersonal(ul, item) {

           var cmll = "\"";
           var IcoEmail = ((SIMA.Utilitario.Helper.Data.ValidarEmail(item.Email) == true) ? SIMA.Utilitario.Constantes.ImgDataURL.CardEMail : SIMA.Utilitario.Constantes.ImgDataURL.CardSinEmail);
           var ItemUser = '<table style="width:100%">'
               + ' <tr>'
               + '     <td rowspan="3" align="center" style="width:5%"><img class=" rounded-circle" width = "25px" src = "' + BuscarPersonal.PathFotosPersonal + item.NRODOCDNI + '.jpg"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
               + '     <td class="Etiqueta" style="width:85%">' + item.APELLIDOSYNOMBRES + '</td>'
               + '     <td rowspan="3" align="center" style="width:10%"><img class=" rounded-circle" width = "25px" src = "' + IcoEmail + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
               + ' </tr>'
               + ' <tr>'
               + '    <td>' + item.PUESTO + '</td>'
               + ' </tr>'
               + ' <tr>'
               + '     <td>' + item.EMAIL + '</td>'
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
           var Foto = BuscarPersonal.PathFotosPersonal + oItemBE.NRODOCDNI + ".jpg";
           var tblItem = '<table border="0"> <tr> <td  style="width:auto;height:30px;"><img  class="rounded-circle img-fluid"  style="width:100px;" src="' + Foto + '"/></td> <td   style="width:90%" >' + oItemBE.APELLIDOSYNOMBRES + '</td></tr></table>';
           return tblItem;
       }
       </script>

</head>
<body>
    <form id="form1" runat="server">
       <table style="width:100%">
           <tr>
               <td  id="MsgText">
                   
               </td>
           </tr>
            <tr>
                 <td  id="MsgSugiere">
         
                 </td>
             </tr>
           <tr>
               <td  class="Etiqueta">
                   Búsqueda de usuarios participantes:
               </td>
           </tr>
           <tr>
               <td>
                    <cc1:EasyListAutocompletar ID="EasyAcBuscarPersonal" runat="server"  NroCarIni="4"  DisplayText="APELLIDOSYNOMBRES" ValueField="IDPERSONALO7" fnOnSelected="onItemSeleccionado" fncTempaleCustom="onDisplayTemplatePersonal" fncTemplateCustomItemList="TemplateItem" CssClass="ContentLisItem" ClassItem="LstItem"  required>
                         <EasyStyle Ancho="Dos"></EasyStyle>
                             <DataInterconect MetodoConexion="WebServiceExterno">
                                 <UrlWebService>/General/Busquedas.asmx</UrlWebService>
                                 <Metodo>BuscarPeronal</Metodo>
                                 <UrlWebServicieParams>
                                     <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                 </UrlWebServicieParams>
                             </DataInterconect>
                     </cc1:EasyListAutocompletar>

               </td>
           </tr>

       </table>
    </form>
    <script>
        BuscarPersonal.Data = {};
        BuscarPersonal.Aceptar = function () {
            if (EasyAcBuscarPersonal.GetCollection().length == 0) {
                var Config = {
                    Titulo: 'Usuarios participantes',
                    Descripcion: 'No se ha elaborado el o la lista de usuarios a participar..',
                    Tipo: SIMA.Message.Type.Advertencia
                };
                var oAlert = new SIMA.Alert(Config);
                oAlert.Flat(jNet.get("MsgText"));


                Config = {
                    Titulo: 'Sugerencia',
                    Descripcion: 'Buscar e incluir uno o mas usuario participantes de esta conclusión en la lista',
                    Tipo: SIMA.Message.Type.Atencion
                };
                oAlert = new SIMA.Alert(Config);
                oAlert.Flat(jNet.get("MsgSugiere"));
                
            }
            else {
                EasyAcBuscarPersonal.GetCollection().forEach(function (ItemBE, i) {
                    BuscarPersonal.Data.Guardar(ItemBE.IDPERSONALO7);
                });
                EasyPopupTaskLineaTiempo.Reload();
                return true;
            }
        }

        BuscarPersonal.Data.Guardar = function (IdPersonal) {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdParticipante", BuscarPersonal.Params[BuscarPersonal.KEYIDTASKPARTICIPA]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdPersonal", IdPersonal, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdHistorial", BuscarPersonal.Params[BuscarPersonal.KEYIDTASKITEMHISTORY]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            oEasyDataInterConect.Metodo = 'TareaHistorialParticipantes_ins';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var obj = oEasyDataResult.sendData();
        }

    </script>
</body>
</html>
