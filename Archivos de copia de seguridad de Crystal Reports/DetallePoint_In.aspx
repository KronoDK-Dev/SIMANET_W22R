<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetallePoint_In.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.DetallePoint_In" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>


    <script>     
        /* Referencia a la pagina de ejemplos de breadcrum
        https://bootsnipp.com/snippets/y4Qa
        pagina de referencia de los modelos de los Card
        https://htmlcss3tutorials.com/how-to-create-bootstrap-5-cards-templates/
        */

        function onItemSeleccionado(value, ItemBE) {
            if (DetallePoint_In.Params[DetallePoint_In.KEYIDTIPOELEMENTO] == "2") {
                ShowPathSource(ItemBE.PATHSYS);
                DetallePoint_In.IdActividadElemntoOrigen = ItemBE.ID_ACT_ELEM;//Actiidad Origen de la busqueda
                
            }
            else {
                DetallePoint_In.IdActividadElemntoOrigen = null;//Actiidad Origen de la busqueda
            }
        }
        function ShowPathSource(strPath) {
            var oPathContent = jNet.get('PathContent');
            oPathContent.clear();
            oPathContent.innerHTML = PathSystem(strPath,780);
        }

        function ObtenerIdElemento() {
            
            return ((DetallePoint_In.Params[DetallePoint_In.KEYIDTIPOELEMENTO]=="2")?"4":"2");
        }

        function PathSystem(strPaths, width) {            
            var HtmlPaths = "";
            var Paths = strPaths.toString().split('|');
            Paths.reverse().forEach(function (ItemPathText, p) {
                HtmlPaths += '             <div  class="btn btn-default">' + ItemPathText + '</div>';
            });
            var ContentOver = '<div class="container">';
            if (width != undefined) {
                ContentOver = '<div class="container ScrollPath" style="width: ' + width + 'px;">';
            }
            var PathContent = ContentOver
                + '     <div class="row">'
                + '         <div class="btn-group btn-breadcrumb">'
                + '             <div class="btn btn-primary style="padding-left:50px;" ><i class="fa fa-home"></i></div>'
                + HtmlPaths
                + '         </div>'
                + '     </div>'
                + ' </div> ';
            return   PathContent ;
        }


        function onDisplayTemplate(ul, item) {
            
            var cmll = "\""; var iTemplate = null;
            if (DetallePoint_In.Params[DetallePoint_In.KEYIDTIPOELEMENTO] == "2") {
                iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '                 <div class="card" style="width:100%;background-color: transparent;border-style: none;">'
                    + '                     <div class="card-footer text-muted">'
                    + '                         ' + item.NOMBRE
                    + '                     </div>'
                    + '                     <div class="card-body">'
                    + '                         <DIV class="card-subtitle mb-2 text-muted">' + item.DESCRIPCION + '</DIV>'
                    + '                     </div>'
                    + '                     <div class="card-header" style="background-color: "f1f3f4;">'
                    + '                        ' + PathSystem(item.PATHSYS)
                    + '                     </div>'
                    + '                 </div>'
                    + '</a>';
            }
            else {
                iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '                 <div class="card" style="width:100%;background-color: transparent;border-style: none;">'
                    + '                     <div class="card-footer text-muted">'
                    + '                         ' + item.NOMBRE
                    + '                     </div>'
                    + '                 </div>'
                    + '</a>';
            }
            var oCustomTemplateBE = new EasyAcBuscarPuntoOut.CustomTemplateBE(ul, item, iTemplate);

            return EasyAcBuscarPuntoOut.SetCustomTemplate(oCustomTemplateBE);

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
              <cc3:EasyAutocompletar ID="EasyAcBuscarPuntoOut" runat="server" NroCarIni="2"  DisplayText="NOMBRE" ValueField="ID_ELEM" fnOnSelected="onItemSeleccionado"  fncTempaleCustom="onDisplayTemplate">
                    <EasyStyle Ancho="Dos"></EasyStyle>
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
      <tr>
            <td  class="Etiqueta">
                ORIGEN: 
            </td>
      </tr>
      <tr>
          <td id="PathContent">

          </td>
      </tr>       
  </table>

    </form>

    <script>
        DetallePoint_In.IdActividadElemntoOrigen = null;
        DetallePoint_In.Aceptar = function () {
            //validar y guardar
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdActElemento", DetallePoint_In.Params[DetallePoint_In.KEYIDACTELEMENTO]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdActividad", DetallePoint_In.Params[DetallePoint_In.KEYIDACTIVIDAD]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdActividadElemOrg", DetallePoint_In.IdActividadElemntoOrigen);//Reemplazar por el ID_ACT_ELEM_ORG
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Nombre", EasyAcBuscarPuntoOut.GetText());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Descripcion", EasyTxtDescripcion.GetText());
            oParamCollections.Add(oParam);
            //oParam = new SIMA.Param("IdElemento", ((EasyAcBuscarPuntoOut.GetValue().length == 0) ? "0" : EasyAcBuscarPuntoOut.GetValue()));
            var IdElemento = "";//Modificado 24-04-2025
            if (DetallePoint_In.Params[DetallePoint_In.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.M) {//Para el cso modifique el nombre y su valor se haya perdido
                IdElemento = EasyAcBuscarPuntoOut.GetValueOld();
            }
            else {
                IdElemento = ((EasyAcBuscarPuntoOut.GetValue().length == 0) ? "0" : EasyAcBuscarPuntoOut.GetValue());
            }
            oParam = new SIMA.Param("IdElemento", IdElemento);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdTipoElemento", DetallePoint_In.Params[DetallePoint_In.KEYIDTIPOELEMENTO], TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/HelpDesk/Sistemas/GestionSistemas.asmx';
            oEasyDataInterConect.Metodo = 'ActividadElementos_InsMod';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var obj = oEasyDataResult.sendData();

            EasyTabControl1.RefreshTabSelect();
            return true;

        }
    </script>
</body>
</html>
