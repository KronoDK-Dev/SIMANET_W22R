<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleStakeHolder.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.DetalleStakeHolder" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
    <script>     

        function onTemplateItemPersonal(ul, item) {

            var cmll = "\"";
            var IcoEmail = ((SIMA.Utilitario.Helper.Data.ValidarEmail(item.EMAIL) == true) ? SIMA.Utilitario.Constantes.ImgDataURL.CardEMail : SIMA.Utilitario.Constantes.ImgDataURL.CardSinEmail);
            var ItemUser = '<table style="width:100%">'
                + ' <tr>'
                + '     <td rowspan="3" align="center" style="width:5%"><img class=" rounded-circle" width = "25px" src = "' + DetalleStakeHolder.PathFotosPersonal + item.NRODOCDNI + '.jpg"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
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

            var oCustomTemplateBE = new EasyAcBuscarInteresado.CustomTemplateBE(ul, item, iTemplate);
            return EasyAcBuscarInteresado.SetCustomTemplate(oCustomTemplateBE);
        }

        function onItemSeleccionado(value, ItemBE) {
            // alert(value);
        }

        function ObtenerIdElemento() {
            return DetalleElementos.Params[DetalleElementos.KEYIDTIPOELEMENTO];
        }


        var NombreImg = "";
        var oEasyUpLoad = new EasyUpLoad();
        var PathFirma = SIMA.Utilitario.Helper.Configuracion.Leer('ConfigModSistemas', 'SysPathFirma');
            oEasyUpLoad.PaginaProceso = "General/UpLoadMaster.aspx?PathLocal=@" + PathFirma;
        var image = null;

        var loadFile = function (event) {
            var file = event.target.files[0];
            image = jNet.get('imgUpLoad');
            if (file) {
                var oIemBE = new EasyUploadFileBE(file);
                oIemBE.ClientID = file.name;
                oEasyUpLoad.Clear();
                image.src = URL.createObjectURL(file);
                image.attr("NomFileOld", file.name);
                oEasyUpLoad.FileCollections.Add(oIemBE);
                NombreImg = oIemBE.ClientID;
               
            }

        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%">
     <tr>
         <td id="lblNombreElemento"  class="Etiqueta" runat="server">
             
         </td>
     </tr>
     <tr>
         <td style="width:100%">
             <cc3:EasyAutocompletar ID="EasyAcBuscarInteresado" runat="server" NroCarIni="4"  DisplayText="APELLIDOSYNOMBRES" ValueField="PTRCODTRA" fnOnSelected="onItemSeleccionado" fncTempaleCustom="onTemplateItemPersonal">
                   <EasyStyle Ancho="Dos"></EasyStyle>
                   <DataInterconect MetodoConexion="WebServiceExterno">
                        <UrlWebService>?</UrlWebService>
                        <Metodo>BuscarPeronal</Metodo>
                        <UrlWebServicieParams>
                            <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                        </UrlWebServicieParams>
                    </DataInterconect>
           </cc3:EasyAutocompletar>   
         </td>
     </tr>
     <tr>
         <td  class="Etiqueta">
             DESCRIPCION: 
         </td>
     </tr>
     <tr>
         <td>
             <cc3:EasyTextBox ID="EasyTxtDescripcion" runat="server" TextMode="MultiLine" Height="200px" Width="100%"></cc3:EasyTextBox>
         </td>
     </tr>
     <tr id="trFirma" runat="server">
        <td align="center" class="BaseItemInGrid">
            <table>
                <tr>
                    <td class="Etiqueta">
                        Click aquí para Buscar archivo imagen de firma
                    </td>
                </tr>
                <tr>
                    <td>
                          <input type="file" accept="image/*" name="image" id="file" onchange="loadFile(event)" style="display: none;">
                          <label for="file" style="cursor: pointer;">
                              <img id="imgUpLoad" runat="server" style="width:150px"/> 
                          </label>
                    </td>
                </tr>

            </table>
         </td>
    </tr>
 </table>
    </form>

      <script>
          DetalleStakeHolder.Validar = function () {
              var msgText = "";
              var Validado = true;
              if (EasyAcBuscarInteresado.GetValue().toString().length == 0) {
                  msgText = 'No se ha Ingresado apellidos del personal ' + DetalleStakeHolder.Params[DetalleStakeHolder.KEYNOMBREELEMENTO];
                  Validado = false;
              }

              if (DetalleStakeHolder.Params[DetalleStakeHolder.KEYIDTIPOSTAKEHOLDER]=="2") {
                  if (oEasyUpLoad.Count() == 0) {
                      if (msgText.length > 0) {
                          msgText += "</br>Tambien no se ha seleccionado archivo de firma a guardar"
                      }
                      else {
                          msgText = "No se ha seleccionado archivo de firma a guardar"
                      }
                      Validado = false;
                  }
              }

              if (Validado == false) {
                  var msgConfig = { Titulo: "Validación", Descripcion: msgText };
                  var oMsg = new SIMA.MessageBox(msgConfig);
                  oMsg.Alert();
              }
              return Validado;
          }

          function ObtenerFileName(PathName) {
              var arrFile = PathName.split('/');
              return arrFile.pop();
          }

          EasyPopupDetalleElementos.Aceptar = function () {
              if (DetalleStakeHolder.Validar()) {//Se aplica cuando la imagen es cagada por el control

                  var oParamCollections = new SIMA.ParamCollections();
                  var oParam = new SIMA.Param("IdStakeHolder", DetalleStakeHolder.Params[DetalleStakeHolder.KEYIDTAKEHOLDER]);
                  oParamCollections.Add(oParam);
                  oParam = new SIMA.Param("IdActividad", DetalleStakeHolder.Params[DetalleStakeHolder.KEYIDACTIVIDAD]);
                  oParamCollections.Add(oParam);
                  oParam = new SIMA.Param("IdPersonal", EasyAcBuscarInteresado.GetValue());
                  oParamCollections.Add(oParam);
                  oParam = new SIMA.Param("Descripcion", EasyTxtDescripcion.GetValue());
                  oParamCollections.Add(oParam);
                  //  oParam = new SIMA.Param("IdTipoStakeHolder", DetalleStakeHolder.Params[DetalleStakeHolder.KEYIDTIPOELEMENTO], TipodeDato.Int);
                  oParam = new SIMA.Param("IdTipoStakeHolder", DetalleStakeHolder.Params[DetalleStakeHolder.KEYIDTIPOSTAKEHOLDER], TipodeDato.Int);
                  oParamCollections.Add(oParam);
                  var oImg = jNet.get('imgUpLoad');
                  var NomFile = ObtenerFileName(oImg.attr("src"));
                  if (DetalleStakeHolder.Params[DetalleStakeHolder.KEYIDTIPOELEMENTO] == "2") {//Aplica solo para el caso de aprobadores
                      if (NomFile != oImg.attr("NomFileOld")) {
                          NomFile = oImg.attr("NomFileOld");
                          oEasyUpLoad.Send();
                      }
                  }
                  oParam = new SIMA.Param("NombreImg", NomFile);
                  oParamCollections.Add(oParam);
                  oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                  oParamCollections.Add(oParam);
                  oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                  oParamCollections.Add(oParam);

                  var oEasyDataInterConect = new EasyDataInterConect();
                  oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                  oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/HelpDesk/Sistemas/GestionSistemas.asmx';
                  oEasyDataInterConect.Metodo = 'ActividadElementos_StakeHolder_InsUp';
                  oEasyDataInterConect.ParamsCollection = oParamCollections;

                  var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                  var obj = oEasyDataResult.sendData();

                  EasyTabControl1.RefreshTabSelect();

                  return true;
              }
          }

      </script>

</body>
</html>
