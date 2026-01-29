<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleAreaIndicador.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.DetalleAreaIndicador" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <script>
        function onChangePlazo(oLisItem) {
            DetalleAreaIndicador.LoadPlazos(oLisItem.value);
        }
    </script>
</head>
<body> 
    <form id="form1" runat="server">
       <table style="width:100%" border="0">
           <tr>
               <td colspan="6" id="msgValRqr">
                   
               </td>
          </tr>
           <tr>
               <td class="Etiqueta">
                   AREA:
               </td>
               <td>
                   <input id="hIdAreaInfo" type="hidden" runat="server" />                   
               </td>
               <td>
               </td>
               <td>
               </td>
               <td>
               </td>
               <td  class="Etiqueta">PROCESO:
               </td>

           </tr>
           <tr>
                <td colspan="5">
                    <cc1:EasyTextBox ID="txtNombreArea" runat="server" BackColor="Silver" ForeColor="White" ReadOnly="True"></cc1:EasyTextBox>
                </td>
               <td>
                     <cc1:EasyDropdownList ID="ddlProceso" runat="server" CargaInmediata="True" required DataTextField="NOMBRE" DataValueField="IDITEM" MensajeValida="No se ha seleccionado ESTADO" >
                         <EasyStyle Ancho="Dos"></EasyStyle>
                         <DataInterconect  MetodoConexion="WebServiceExterno">
                             <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                             <Metodo>ListarTodosOracle</Metodo>
                             <UrlWebServicieParams>
                                 <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdtblModulo" Paramvalue="98" TipodeDato="Int" />
                                 <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                             </UrlWebServicieParams>
                         </DataInterconect>
                   </cc1:EasyDropdownList>
               </td>
           </tr>
            <tr>
                <td class="Etiqueta" colspan="6">
                    FORMULA DE CÁLCULO:
                </td>
            </tr>
            <tr>
                 <td colspan="6">
                     <cc1:EasyTextBox ID="txtFormula" runat="server" BackColor="Silver" ForeColor="White" ReadOnly="True"></cc1:EasyTextBox>
                 </td>
            </tr>

             <tr>
                  <td class="Etiqueta" colspan="6" reference="txtFuente">
                      FUENTE DE INFORMACION:
                  </td>
              </tr>
              <tr>
                   <td colspan="6">
                       <cc1:EasyTextBox ID="txtFuente"  required runat="server"></cc1:EasyTextBox>
                   </td>
              </tr>
           <tr>
               <td class="Etiqueta" reference="ddlUnidad">U.M</td>
                    <td>
                       <cc1:EasyDropdownList ID="ddlUnidad" runat="server" CargaInmediata="True" required DataTextField="NOMBRE" DataValueField="IDITEM" MensajeValida="No se ha seleccionado ESTADO" >
                              <EasyStyle Ancho="Dos"></EasyStyle>
                              <DataInterconect  MetodoConexion="WebServiceExterno">
                                  <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                  <Metodo>ListarTodosOracle</Metodo>
                                  <UrlWebServicieParams>
                                      <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdtblModulo" Paramvalue="95" TipodeDato="Int" />
                                      <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                  </UrlWebServicieParams>
                              </DataInterconect>
                        </cc1:EasyDropdownList>
                   </td>
               <td class="Etiqueta" reference="ddlSentido">SENTIDO</td>
               <td>
                      <cc1:EasyDropdownList ID="ddlSentido" runat="server" CargaInmediata="True" required DataTextField="NOMBRE" DataValueField="IDITEM" MensajeValida="No se ha seleccionado ESTADO" >
                          <EasyStyle Ancho="Dos"></EasyStyle>
                          <DataInterconect  MetodoConexion="WebServiceExterno">
                              <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                              <Metodo>ListarTodosOracle</Metodo>
                              <UrlWebServicieParams>
                                  <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdtblModulo" Paramvalue="96" TipodeDato="Int" />
                                  <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                              </UrlWebServicieParams>
                          </DataInterconect>
                    </cc1:EasyDropdownList>
               </td>
               <td class="Etiqueta" reference="ddlMedicion">PLAZO:</td>
               <td>
                     <cc1:EasyDropdownList ID="ddlMedicion" runat="server" CargaInmediata="True" required DataTextField="NOMBRE" DataValueField="IDITEM" MensajeValida="No se ha seleccionado ESTADO" fnOnSelected="onChangePlazo" >
                          <EasyStyle Ancho="Dos"></EasyStyle>
                          <DataInterconect  MetodoConexion="WebServiceExterno">
                              <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                              <Metodo>ListarTodosOracle</Metodo>
                              <UrlWebServicieParams>
                                  <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdtblModulo" Paramvalue="85" TipodeDato="Int" />
                                  <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                              </UrlWebServicieParams>
                          </DataInterconect>
                    </cc1:EasyDropdownList>

               </td>

           </tr>
           <tr>
               <td class="Etiqueta">CALIFICACION:</td>
           </tr>
           <tr>
               <td id="tblCond" runat="server" colspan="6">

               </td>
           </tr>
           <tr>
               <td  class="Etiqueta">META: </td>
           </tr>
           <tr>
               <td id="tblContentPlazo" runat="server" colspan="6">

               </td>
           </tr>
       </table>
    </form>

    <script>
        DetalleAreaIndicador.LoadPlazos = function (IdTipoPlazo) {
            var urlPag = Page.Request.ApplicationPath + "/GestionGobernanza/Indicadores/ListadodeMetasPorArea.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(DetalleAreaIndicador.KEYIDAREAINFO, jNet.get('hIdAreaInfo').attr('value'));
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(DetalleAreaIndicador.KEYIDTIPOPLAZO, IdTipoPlazo);
            oColletionParams.Add(oParam);

            var oLoadConfig = {
                CtrlName: "tblContentPlazo",
                UrlPage: urlPag,
                ColletionParams: oColletionParams,
            };
            SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
        }

        DetalleAreaIndicador.LoadPlazos(ddlMedicion.GetValue());
    </script>

</body>
</html>
