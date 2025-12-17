<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleElementos.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.DetalleElementos" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    

    <script>     
        function onItemSeleccionado(value, ItemBE) {
            // alert(value);
        }

        function ObtenerIdElemento() {
            return DetalleElementos.Params[DetalleElementos.KEYIDTIPOELEMENTO];
        }
        function ObtenerIdActividad() {
            return DetalleElementos.Params[DetalleElementos.KEYIDACTELEMENTO];
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
                    <cc3:EasyAutocompletar ID="EasyAcBuscarElementos" runat="server" NroCarIni="4"  DisplayText="NOMBRE" ValueField="ID_ELEM" fnOnSelected="onItemSeleccionado" >
                          <EasyStyle Ancho="Dos"></EasyStyle>
                          <DataInterconect MetodoConexion="WebServiceExterno">
                               <UrlWebService>?</UrlWebService>
                               <Metodo>ActividadElementos_Buscar</Metodo>
                               <UrlWebServicieParams>
                                   <cc2:EasyFiltroParamURLws  ParamName="IdActividad" Paramvalue="ObtenerIdActividad()" ObtenerValor="FunctionScript"/>
                                   <cc2:EasyFiltroParamURLws  ParamName="IdTipoElemento" Paramvalue="ObtenerIdElemento()" ObtenerValor="FunctionScript"/>
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
        </table>
    </form>
    <script>
        EasyPopupDetalleElementos.Aceptar = function () {
          
            //validar y guardar
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdActElemento", "0");
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdActividad", AdministrarElementos.Params[AdministrarElementos.KEYIDACTIVIDAD]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdActividadoRG", "");
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Nombre", EasyAcBuscarElementos.GetText());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Descripcion", EasyTxtDescripcion.GetText());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdElemento", ((EasyAcBuscarElementos.GetValue().length == 0) ? "0" : EasyAcBuscarElementos.GetValue()));
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdTipoElemento", AdministrarElementos.Params[AdministrarElementos.KEYIDTIPOELEMENTO], TipodeDato.Int);
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
