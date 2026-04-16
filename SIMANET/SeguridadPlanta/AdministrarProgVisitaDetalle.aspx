<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarProgVisitaDetalle.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.AdministrarProgVisitaDetalle" %>
<%@ Register TagPrefix="uc1" TagName="header" Src="~/Controles/Header.ascx" %>
<%@ Register TagPrefix="cc1" Assembly="EasyControlWeb" Namespace="EasyControlWeb" %>
<%@ Register TagPrefix="cc2" Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" %>
<%@ Register TagPrefix="cc3" Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" %>
<%@ Register TagPrefix="cc6" Assembly="EasyControlWeb" Namespace="EasyControlWeb" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <script>
         function fnPasaItem_NroRucSeleccionado(value, ItemBE) {
             // pasa valores enviados a otro objeto autocomplete
             acRSocial.SetValue(ItemBE.IDPROVEEDOR, ItemBE.RAZONSOCIAL);
         }

         function fnMuestraResultados_busquedaRUC(ul, item) {
             var cmll = "\""; var iTemplate = null;
             iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                 + '<div class= "flex-column">' + item.RAZONSOCIAL
                 + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red"> </small>'
                 + '    <small style="font-weight: bold">NRO RUC.:</small><small style="color:blue;text-transform: capitalize;">' + item.NROPROVEEDOR + '</small></p>'
                 + '    <span class="badge badge-info "> otrodato </span > '
                 + '</div>'
                 + '</a>';

             var oCustomTemplateBE = new acProveedor.CustomTemplateBE(ul, item, iTemplate);

             return acProveedor.SetCustomTemplate(oCustomTemplateBE);

         }

         function fnPasaItem_RazonSocialSeleccionado(value, ItemBE) {
             acProveedor.SetValue(ItemBE.IDPROVEEDOR, ItemBE.NROPROVEEDOR);
         }

         fnCargaSeleccionado = function (value, ItemBE) {
         }

         function fnMuestraResultados_busquedaPersonal(ul, item) {

             var cmll = "\""; var iTemplate = null;
             iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                 + '<div class= "flex-column">' + item.Nombres
                 + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red">' + item.NroPersonal + '</small>'
                 + '    <small style="font-weight: bold">AREA:</small><small style="color:blue;text-transform: capitalize;">' + item.NombreArea + '</small></p>'
                 + '    <span class="badge badge-info "> ' + item.Email + '</span>'
                 + '</div>'
                 + '<div class="image-parent">'
                 + '<img class=" rounded-circle" width="60px" src="' + AdministrarProgVisitaDetalle.PathFotosPersonal + item.NroDocIdentidad + '.jpg"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                 + '</div>'
                 + '</a>';

             var oCustomTemplateBE = new eac_ConocimientoA.CustomTemplateBE(ul, item, iTemplate);
             return eac_ConocimientoA.SetCustomTemplate(oCustomTemplateBE);
         }

         function fnItemSeleccionado(value, ItemBE) {
         }

         function fnEstiloItem(oItemBE) {
             // BuscarPersonal es nombre de la pagina
             var iFoto = AdministrarProgVisitaDetalle.PathFotosPersonal + oItemBE.NroDocIdentidad + ".jpg";
             var tblItem = '<table border="0"> <tr> <td  style="width:30px;height:30px;object-fit:cover;"><img  class="rounded-circle"  style="width:30px;" src="' + iFoto + '"/></td> <td   style="width:70%" >' + oItemBE.Nombres + '</td><td>' + oItemBE.Email + '</td></tr></table>';
             return tblItem;
         }

     </script>
</head>
<body>
    <form id="form1" runat="server">
 
        <cc3:EasyTabControl ID="TabProg" fncTabOnClick="TabOnClickSelected" runat="server"></cc3:EasyTabControl>
     
        <!-- 1er TAB -->
        <table style="width:100%;" border="0" id="tblProg" >
            <tr class="tr-responsive">
                <td class="Etiqueta" reference="eDDLTipoVisita">TIPO VISITA:</td>
                <td colspan="10">
                    <cc3:EasyDropdownList ID="eDDLTipoVisita" runat="server" CargaInmediata="True"
                        DataTextField="DESCRIPCION" DataValueField="CODIGO"
                        EnableOnChange="True"  AutoPostBack="True">
                        <EasyStyle Ancho="Uno"></EasyStyle>
                        <DataInterconect MetodoConexion="WebServiceExterno">
                            <UrlWebService>http://10.10.90.4:8000/Core/General/General.asmx</UrlWebService>
                            <Metodo>ListarItemTablas</Metodo>
                            <UrlWebServicieParams>
                                <cc2:EasyFiltroParamURLws ObtenerValor="Fijo"    ParamName="IdTablaGeneral" Paramvalue="26"       TipodeDato="String" />
                                <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName"       Paramvalue="UserName" TipodeDato="String" />
                            </UrlWebServicieParams>
                        </DataInterconect>
                    </cc3:EasyDropdownList>

                </td>
               <td></td>
            </tr>

            <tr class="tr-responsive">
                <td class="Etiqueta" reference="eac_AreaDestino">ÁREA DESTINO:</td>
                <td colspan="10">
                      <!-- Conexion local para personalizar manejo de errores -->
                   <cc3:EasyAutocompletar ID="eac_AreaDestino" runat="server" Width="35%" 
                         DisplayText  ="NombreArea" ValueField= "IDAREA" NroCarIni="3" 
                         fnOnSelected ="fnCargaSeleccionado"  EnableOnChange="True"
                         MensajeValida="Este dato es obligatorio" >
                      <EasyStyle Ancho="Dos" TipoTalla="sm"></EasyStyle>
                      <DataInterconect MetodoConexion="WebServiceInterno">
                          <UrlWebService>/SIMANET/SeguridadPlanta/Visitas.asmx</UrlWebService>
                          <Metodo>ListarAreaPorNombre</Metodo>
                            <UrlWebServicieParams>
                                <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                          </UrlWebServicieParams>
                            </DataInterconect>
                        </cc3:EasyAutocompletar>
                </td>
               <td></td>
            </tr>


              <tr class="tr-responsive">
                  <td class="Etiqueta" reference="eac_ConocimientoA">CONOCIMIENTO A:</td>
                  <td colspan="10">
                      <!-- Conexion local para personalizar manejo de errores -->
                      <cc3:EasyListAutocompletar  ID="eac_ConocimientoA" runat="server"  NroCarIni="2"  
                          DisplayText="Nombres" ValueField="idpersonal"
                          fncTempaleCustom="fnMuestraResultados_busquedaPersonal"  
                          fnOnSelected="fnItemSeleccionado" 
                          fncTemplateCustomItemList="fnEstiloItem"
                          CssClass="ContentLisItem" ClassItem="LstItem" >
                         <EasyStyle Ancho="Dos"></EasyStyle>
                             <DataInterconect MetodoConexion="WebServiceExterno">
                                  <UrlWebService>http://10.10.90.4:8000/Core/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                  <Metodo>BuscarPersonalSIMA</Metodo>
                                  <UrlWebServicieParams>
                                      <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                  </UrlWebServicieParams>
                              </DataInterconect>

                     </cc3:EasyListAutocompletar>
                  </td>
                 <td></td>
              </tr>

            <tr class="tr-responsive">  <!--  12 cols  -->
                 <td class="Etiqueta" >FECHA INICIO:</td>
                 <td>
                    <cc3:EasyDatepicker ID="dpcFechaIni" runat="server" FormatoFecha="dd/mm/yyyy" Hoy="" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Width="92px">
                    </cc3:EasyDatepicker>
                 </td>
                 <td></td>
                 <td class="Etiqueta" >FECHA TERMINO:</td>
                 <td>
                    <cc3:EasyDatepicker ID="dpcFechaFin" runat="server" FormatoFecha="dd/mm/yyyy" Hoy="" autocomplete="off" CssClass="form-control" data-validate="true" Requerido="False" Width="92px" >
                    </cc3:EasyDatepicker>
                 </td>
                <td></td>
                <td class="Etiqueta" >HORA INGRESO:</td>
                <td> <input type="time" id="dtHora" runat="server" class="form-control" /> </td>
                <td></td>
                <td class="Etiqueta" >NRO. POLIZA:</td>
                <td><cc3:EasyTextBox ID="txtPoliza" runat="server"></cc3:EasyTextBox></td>
                <td></td>
            </tr>
            
           <tr class="tr-responsive">  <!--  12 cols  -->
             <td class="Etiqueta" >ASUNTO:</td>
             <td colspan="10">
                 <cc3:EasyTextBox ID="txtAsunto" runat="server"
                   TextMode="MultiLine" MaxLength="2000">
                 </cc3:EasyTextBox></td>
             <td></td>
           </tr>

            <!--  -->
             <tr class="tr-responsive">
                   <td class="Etiqueta" reference="acProveedor" >NRO. RUC:</td>
                   <td class="Etiqueta" colspan="7" reference="acRSocial" >RAZON SOCIAL:</td>
                  <td></td>
            </tr>
          
            <tr class="tr-responsive">
                <td>
                    <cc3:EasyAutocompletar ID="acProveedor" runat="server"  NroCarIni="4"  DisplayText="NROPROVEEDOR" ValueField="IDPROVEEDOR"  
                        fnOnSelected="fnPasaItem_NroRucSeleccionado" fncTempaleCustom="fnMuestraResultados_busquedaRUC" >
                        <EasyStyle Ancho="Dos"></EasyStyle>
                            <DataInterconect MetodoConexion="WebServiceExterno">
                                 <UrlWebService>https://mesadeayuda.sima.com.pe:448/Core/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                 <Metodo>BuscarProveedorXrUC</Metodo>
                                 <UrlWebServicieParams>
                                     <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                 </UrlWebServicieParams>
                             </DataInterconect>
                    </cc3:EasyAutocompletar>
                </td>
                 
                <td colspan=7>
                       <cc3:EasyAutocompletar ID="acRSocial" runat="server"  NroCarIni="4"  DisplayText="RAZONSOCIAL" ValueField="IDPROVEEDOR"  
                           fnOnSelected="fnPasaItem_RazonSocialSeleccionado" fncTempaleCustom="fnMuestraResultados_busquedaRUC" >
                          <EasyStyle Ancho="Dos"></EasyStyle>
                              <DataInterconect MetodoConexion="WebServiceExterno">
                                   <UrlWebService>https://mesadeayuda.sima.com.pe:448/Core/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                   <Metodo>BuscarProveedorXRSocial</Metodo>
                                   <UrlWebServicieParams>
                                       <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                   </UrlWebServicieParams>
                               </DataInterconect>
                      </cc3:EasyAutocompletar>
                </td>
                 <td> <img id="btnNewPrv" runat="server" 
                     src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAwUExURQAAAKbK8KDAwMDAwP///0BAgICgwGCgwP/78KCgwGCAwODggEBgwECAwMDcwAAAAIFwGqgAAAAQdFJOU////////////////////wDgI10ZAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAAc0lEQVQoU1WPSRLDIAwEQQsRGKP//zbaXHH6Nq0pJJoWvQMAqv4EEQGjtm6MMT5AJBMZQzggImy4sPlaLkQublYNpsfrX1g2MYk2rfuekVNkI/K74St8SzViB7Bd+jT23v0RNbfjUpxzsK4NUY8lr98mql/FMAeEtBlvCQAAAABJRU5ErkJggg==" />
                 </td>
            </tr>
             <!--
            <tr>
                <td  class="Etiqueta"  reference="FInicio">F.INICIO:</td>
                <td>
                    <cc3:EasyDatepicker ID="FInicio" runat="server" ></cc3:EasyDatepicker>
                </td>
                <td class="Etiqueta" reference="FFin">F.TERMINO:</td>                   
                <td>
                       <cc3:EasyDatepicker ID="FFin" runat="server" ></cc3:EasyDatepicker>
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                 <td class="Etiqueta"  reference="HIni">H.INICIO:</td>
                 <td colspan="2"><cc3:EasyTimePicker ID="dpHIni" runat="server" /></td>
                 <td class="Etiqueta" reference="HFin">H.TOLERANCIA</td>
                 <td> <cc3:EasyTimePicker ID="dpHFin" runat="server" /></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
  
             <tr>
                 <td  class="Etiqueta" reference="acJefeProy">JEFE DE PROY.:</td>
                 <td colspan="7">
                       
                 </td>
                 <td></td>
             </tr>
             <tr>
                 <td  class="Etiqueta" reference="txtRegIng">NRO REG ING</td>
                 <td><cc3:EasyTextBox ID="txtRegIng" runat="server" ></cc3:EasyTextBox></td>
                 <td  class="Etiqueta" reference="txtDocRef">DOC. REF</td>
                 <td colspan="5"><cc3:EasyTextBox ID="txtDocRef" runat="server" ></cc3:EasyTextBox></td>
                 <td></td>
             </tr>            

            <tr>
                <td class="Etiqueta" reference="txtTrabReal">TRAB. A REALIZAR</td>
                <td colspan="7"><cc3:EasyTextBox ID="txtTrabReal" Height="60" TextMode="MultiLine" runat="server" ></cc3:EasyTextBox></td>
                <td></td>
            </tr>

            <tr>
                <td class="Etiqueta" reference="acAreaTrab">AREA DE TRAB.</td>
                <td colspan="7">
                     <cc3:EasyAutocompletar ID="acAreaTrab" runat="server"  NroCarIni="4"  DisplayText="NombreArea" ValueField="IDAREA"  fncTempaleCustom="onDisplayTemplateArea" fnOnSelected="onItemAreaSeleccionado" required>
                          <EasyStyle Ancho="Dos"></EasyStyle>
                              <DataInterconect MetodoConexion="WebServiceExterno">
                                   <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                   <Metodo>BuscarAreaSIMA</Metodo>
                                   <UrlWebServicieParams>
                                       <cc2:EasyFiltroParamURLws  ParamName="IdCentroOperativo" Paramvalue="2" ObtenerValor="Fijo" TipodeDato="Int"/>
                                       <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                   </UrlWebServicieParams>
                               </DataInterconect>
                      </cc3:EasyAutocompletar>
                </td>
                 <td></td>
            </tr>

            <tr>
                <td class="Etiqueta" reference="txtNombreNave">NOMBRE NAVE</td>
                <td colspan="7"><cc3:EasyTextBox ID="txtNombreNave" runat="server" required></cc3:EasyTextBox></td>
                 <td></td>
            </tr>

            <tr>
                <td class="Etiqueta"  reference="txtContacto">CONTACTO</td>
                <td colspan="7"><cc3:EasyTextBox ID="txtContacto" runat="server" required></cc3:EasyTextBox></td>
                 <td></td>
            </tr>

            <tr>
                <td class="Etiqueta" reference="txtObservaciones">OBSERVACINES</td>
                <td colspan="7"><cc3:EasyTextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Height="80" required></cc3:EasyTextBox></td>
                <td></td>
            </tr>
            -->
     </table>
    
    </form>
</body>
</html>
