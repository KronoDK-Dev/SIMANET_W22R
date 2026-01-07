<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfigurarFirmasAprobadores.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.ConfigurarFirmasAprobadores" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register src="../Controles/Header.ascx" tagname="Header" tagprefix="uc1" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Filtro" tagprefix="cc2" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
      <script>
          /*Imagenm Circular https://codepen.io/siremilomir/pen/jBbQGo */
          var NombreImg = "";
          var oEasyUpLoad = new EasyUpLoad();
          var image = null;
          var loadFile = function (event) {
              var file = event.target.files[0];
              image = jNet.get('imgUpLoad');
              oEasyUpLoad.PaginaProceso = "General/UpLoadMaster.aspx?PathLocal=@" + jNet.get("txtPathFirma").value;

              if (file) {
                  var oIemBE = new EasyUploadFileBE(file);
                  oIemBE.ClientID = file.name;
                  oEasyUpLoad.Clear();
                  image.src = URL.createObjectURL(file);
                  oEasyUpLoad.FileCollections.Add(oIemBE);
                  NombreImg = oIemBE.ClientID;

              }

          }





          function onDisplayTemplatePersonal(ul, item) {
              var cmll = "\"";
              iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                  + '<div class= "flex-column"> <small style="font-weight: bold">PORTA RETRATO:</small>' + item.NroPersonal
                  + '    <p><small style="font-weight: bold">PERSONAL:</small> <small style ="color:red">' + item.ApellidosyNombres + '</small>'
                  + '    <small style="font-weight: bold">AREA:</small><small style="color:blue;text-transform: capitalize;">' + item.NroArea + ' - ' + item.NombreArea + '</small></p>'
                  + '    <span class="badge badge-info badge-pill"> ' + item.NroDocIdentidad + '</span>'
                  + '    <span class="badge badge-info "> ' + item.Email + '</span>'
                  + '</div>'
                  + '<div class="image-parent">'
                  + '<img class=" rounded-circle" width="60px" src="' + ConfigurarFirmasAprobadores.PathFotosPersonal + item.NroDocIdentidad + '.jpg" alt="Jefe de proy:=' + item.ApellidosyNombres + '"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                  + '</div>'
                  + '</a>';

              var oCustomTemplateBE = new EasyAutocompletAct.CustomTemplateBE(ul, item, iTemplate);

              return EasyAutocompletAct.SetCustomTemplate(oCustomTemplateBE);
          }

          function onItemSeleccionado(value, ItemBE) {
              FindDataFirmaPersona(ItemBE.IdPersonal);
          }

          function FindDataFirmaPersona(IdPersona) {
              var oDataTable = new SIMA.Data.DataTable();
              oDataTable = SIMA.Utilitario.Helper.TablaGeneralItem(692, IdPersona);
              if (oDataTable != null) {
                  oDataTable.Rows.forEach(function (oDataRow, i) {
                      var image = jNet.get('imgUpLoad');                     
                      image.src = ConfigurarFirmasAprobadores.PathImagenFirmas + oDataRow["VAR1"]; 
                      NombreImg = oDataRow["VAR1"];
                  });
              }
          }

          MasterConfig.Validar = function () {
              return EasyAutocompletAct.GetValue() == UsuarioBE.IdPersonal;
          }
          MasterConfig.OnAceptar = function () {
             

              if (MasterConfig.Validar() == false) {
                  var msgConfig = { Titulo: "Error ", Descripcion: "Ud, no cuenta con la autorización de realizar cambios de configuracion de otro Usuario" };
                  var oMsg = new SIMA.MessageBox(msgConfig);
                  oMsg.Alert();

                  return;
              }

              try {
                  if ((EasyAutocompletAct.GetValue().length > 0) && (NombreImg.length > 0)) {

                      if (oEasyUpLoad.Count() > 0) {//Se aplica cuando la imagen es cagada por el control
                          oEasyUpLoad.Send();
                          oEasyUpLoad.Clear();//Elimina todos los elementos cargados
                      }
                      var oParamCollections = new SIMA.ParamCollections();
                      var oParam = new SIMA.Param(ConfigurarFirmasAprobadores.KEYQIDPERFIRMANTE, EasyAutocompletAct.GetValue(), TipodeDato.Int);
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param(ConfigurarFirmasAprobadores.KEYQIMGFIRM, NombreImg);
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param(ConfigurarFirmasAprobadores.KEYQIDESTADO, 1, TipodeDato.Int);
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param('IdUsuario', ConfigurarFirmasAprobadores.Params['IdUsuario'], TipodeDato.Int);
                      oParamCollections.Add(oParam);
                      oParam = new SIMA.Param('UserName', ConfigurarFirmasAprobadores.Params['UserName']);
                      oParamCollections.Add(oParam);

                      var oEasyDataInterConect = new EasyDataInterConect();
                      oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                      oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                      oEasyDataInterConect.Metodo = 'ModificarInsertarFirmante';
                      oEasyDataInterConect.ParamsCollection = oParamCollections;

                      var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                      var obj = oEasyDataResult.sendData();
                      return true;
                  }
                  else {
                      var msgConfig = { Titulo: "Error ", Descripcion: "No se ha ingresado personal firmante o falta relacionar la firma" };
                      var oMsg = new SIMA.MessageBox(msgConfig);
                      oMsg.Alert();
                      return false;
                    }
              }
              catch (SIMADataException) {
                  var msgConfig = { Titulo: "Error ", Descripcion: SIMADataException.Message };
                  var oMsg = new SIMA.MessageBox(msgConfig);
                  oMsg.Alert();
                  return false;
              }


          }


      </script>



</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%;">
         <tr>
             <td>
                 <table style="width:100%;">
                     <tr>
                         <td style="width:10%;" class="Etiqueta">Responsable:</td>
                         <td  style="width:90%;"  > 
                             <cc3:EasyAutocompletar ID="EasyAutocompletAct" runat="server" NroCarIni="2"  DisplayText="ApellidosyNombres" ValueField="IdPersonal" fnOnSelected="onItemSeleccionado" Placeholder="Ingrese el Nombre de responsable." fncTempaleCustom="onDisplayTemplatePersonal">
                                 <EasyStyle Ancho="Dos"></EasyStyle>
                                 <DataInterconect MetodoConexion="WebServiceInterno">
                                     <UrlWebService>/RecursosHumanos/Personal.asmx</UrlWebService>
                                    <Metodo>BuscarPersona</Metodo>
                                     <UrlWebServicieParams>
                                         <cc2:EasyFiltroParamURLws  ParamName="PSima" Paramvalue="1" ObtenerValor="Fijo" TipodeDato="Int"/>
                                         <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                     </UrlWebServicieParams>
                                 </DataInterconect>
                             </cc3:EasyAutocompletar>
                         </td>
                     </tr>
                   
                     </table>
             </td>
         </tr>
         <tr>
             <td class="Etiqueta">
                 Firma&nbsp; Asociar/Actualizar</td>
         </tr>
         <tr>
             <td align="center" class="BaseItemInGrid">
                     <input type="file" accept="image/*" name="image" id="file" onchange="loadFile(event)" style="display: none;">
                     <label for="file" style="cursor: pointer;">
                         <img id="imgUpLoad" runat="server" style="width:150px"/> 
                     </label>
             </td>
         </tr>
 </table>
          <asp:TextBox ID="txtPathFirma" runat="server"></asp:TextBox>
    </form>

    <script>
        setTimeout(function () {
                            EasyAutocompletAct.SetValue(UsuarioBE.IdPersonal, UsuarioBE.ApellidosyNombres);
                           FindDataFirmaPersona(UsuarioBE.IdPersonal);
                        },700);
    </script>
</body>
</html>
