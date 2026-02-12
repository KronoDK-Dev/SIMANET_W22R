<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleProgramacion.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.DetalleProgramacion" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>




<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>



    <script>
        function onItemNroRucSeleccionado(value, ItemBE) {
            acRSocial.SetValue(ItemBE.IDPROVEEDOR, ItemBE.RAZONSOCIAL);
        }
        function onItemRSocialSeleccionado(value, ItemBE) {
            acProveedor.SetValue(ItemBE.IDPROVEEDOR, ItemBE.NROPROVEEDOR);
        }
        function onItemPersonalSeleccionado(value, ItemBE) {
            
        }

        function onDisplayTemplateProveedor(ul, item) {           
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

        function onItemCiaSeguroSeleccionado(value, ItemBE) {
            
        }
        function onItemAreaSeleccionado(value, ItemBE) {

        }


        function TabOnClickSelected(oTab) {
            var idTab = oTab.attr('id').Replace("TabProg_", "");
            switch (idTab) {
                case "TabItem_1":

                    /*Manager.Task.Excecute(function () {
                        try {
                            init();
                            Diagrama.Drawing.Tools.Paint();
                            Diagrama.Drawing.Paint();
                        }
                        catch (ex) {
                            //  alert(ex);
                        }
                    }, 1500, true);*/
                    break;
            }
        }

        function TemplateItemArea(oItemBE) {
            var Foto = SIMA.Utilitario.Constantes.ImgDataURL.Home;
            var tblItem = '<table border="0"> <tr> <td  style="width:auto;height:30px;"><img  style="width:20px;" src="' + Foto + '"/></td> <td   style="width:90%" >' + oItemBE.NombreArea + '</td></tr></table>';
            return tblItem;
        }


        function onDisplayTemplateArea(ul, item) {

            var cmll = "\"";
            var IcoEmail = SIMA.Utilitario.Constantes.ImgDataURL.IconoParam;
            var ItemUser = '<table style="width:100%">'
                + ' <tr>'
                + '     <td rowspan="3" align="center" style="width:5%"><img class=" rounded-circle" width = "25px" src = "' + SIMA.Utilitario.Constantes.ImgDataURL.Home + '"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                + '     <td class="Etiqueta" style="width:85%">' + item.NombreArea + '</td>'
                + '     <td rowspan="3" align="center" style="width:10%"><img class=" rounded-circle" width = "25px" src = "' + IcoEmail + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                + ' </tr>'
                + ' <tr>'
                + '     <td>' + item.NROAREA + '</td>'
                + '</tr>'
                + '</table>';

            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + ItemUser
                + '</a>';

            var oCustomTemplateBE = new acAreaTrab.CustomTemplateBE(ul, item, iTemplate);
            return acAreaTrab.SetCustomTemplate(oCustomTemplateBE);
        }


        function onDisplayTemplatePersonal(ul, item) {
           
            var cmll = "\""; var iTemplate = null;
                iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '<div class= "flex-column">' + item.Nombres
                    + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red">' + item.NroPersonal + '</small>'
                    + '    <small style="font-weight: bold">AREA:</small><small style="color:blue;text-transform: capitalize;">' + item.NombreArea + '</small></p>'
                    + '    <span class="badge badge-info "> ' + item.Email + '</span>'
                    + '</div>'
                    + '<div class="image-parent">'
                    + '<img class=" rounded-circle" width="60px" src="' + DetalleProgramacion.PathFotosPersonal + item.NroDocIdentidad + '.jpg"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                    + '</div>'
                    + '</a>';

            var oCustomTemplateBE = new acJefeProy.CustomTemplateBE(ul, item, iTemplate);

            return acJefeProy.SetCustomTemplate(oCustomTemplateBE);


        }


        function onDisplayTemplateCIASeg(ul, item) {

            var cmll = "\"";
            var IcoEmail = SIMA.Utilitario.Constantes.ImgDataURL.IconoParam;
            var ItemUser = '<table style="width:100%">'
                + ' <tr>'
                + '     <td rowspan="3" align="center" style="width:5%"><img class=" rounded-circle" width = "25px" src = "' + SIMA.Utilitario.Constantes.ImgDataURL.Home + '"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                + '     <td class="Etiqueta" style="width:85%">' + item.DESCRIPCION + '</td>'
                + '     <td rowspan="3" align="center" style="width:10%"><img class=" rounded-circle" width = "25px" src = "' + IcoEmail + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                + ' </tr>'
                + ' <tr>'
                + '     <td>' + item.CODIGO + '</td>'
                + '</tr>'
                + '</table>';

            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + ItemUser
                + '</a>';

            var oCustomTemplateBE = new acCiaSeguro.CustomTemplateBE(ul, item, iTemplate);
            return acCiaSeguro.SetCustomTemplate(oCustomTemplateBE);
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <cc2:EasyTabControl ID="TabProg" fncTabOnClick="TabOnClickSelected" runat="server"></cc2:EasyTabControl>
        
        <table style="width:100%;visibility:hidden" border="0" id="tblProg" >
             <tr>
                   <td class="Etiqueta" reference="acProveedor" >NRO. RUC:</td>
                   <td class="Etiqueta" colspan="7" reference="acRSocial" >RAZON SOCIAL:</td>
               
                  <td></td>
            </tr>
            <tr>
                <td>
                    <cc2:EasyAutocompletar ID="acProveedor" runat="server"  NroCarIni="4"  DisplayText="NROPROVEEDOR" ValueField="IDPROVEEDOR"  fnOnSelected="onItemNroRucSeleccionado" fncTempaleCustom="onDisplayTemplateProveedor" required>
                        <EasyStyle Ancho="Dos"></EasyStyle>
                            <DataInterconect MetodoConexion="WebServiceExterno">
                                 <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                 <Metodo>BuscarProveedorXrUC</Metodo>
                                 <UrlWebServicieParams>
                                     <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                 </UrlWebServicieParams>
                             </DataInterconect>
                    </cc2:EasyAutocompletar>
                </td>
                <td colspan=7>
                       <cc2:EasyAutocompletar ID="acRSocial" runat="server"  NroCarIni="4"  DisplayText="RAZONSOCIAL" ValueField="IDPROVEEDOR"  fnOnSelected="onItemRSocialSeleccionado" fncTempaleCustom="onDisplayTemplateProveedor" required>
                          <EasyStyle Ancho="Dos"></EasyStyle>
                              <DataInterconect MetodoConexion="WebServiceExterno">
                                   <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                   <Metodo>BuscarProveedorXRSocial</Metodo>
                                   <UrlWebServicieParams>
                                       <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                   </UrlWebServicieParams>
                               </DataInterconect>
                      </cc2:EasyAutocompletar>
                </td>
                 <td> <img id="btnNewPrv" runat="server" /></td>
            </tr>

            <tr>
                <td  class="Etiqueta"  reference="FInicio">F.INICIO:</td>
                <td>
                    <cc2:EasyDatepicker ID="FInicio" runat="server" required></cc2:EasyDatepicker>
                </td>
                <td class="Etiqueta" reference="FFin">F.TERMINO:</td>                   
                <td>
                       <cc2:EasyDatepicker ID="FFin" runat="server" required></cc2:EasyDatepicker>
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                 <td class="Etiqueta"  reference="HIni">H.INICIO:</td>
                 <td colspan="2"><cc2:EasyTimePicker ID="dpHIni" runat="server" /></td>
                 <td class="Etiqueta" reference="HFin">H.TOLERANCIA</td>
                 <td> <cc2:EasyTimePicker ID="dpHFin" runat="server" /></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
          
             <tr>
                 <td  class="Etiqueta" reference="acJefeProy">JEFE DE PROY.:</td>
                 <td colspan="7">
                        <cc2:EasyAutocompletar ID="acJefeProy" runat=server  NroCarIni="4"  DisplayText="Nombres" ValueField="idpersonal" fncTempaleCustom="onDisplayTemplatePersonal"  fnOnSelected="onItemPersonalSeleccionado" required>
                            <EasyStyle Ancho="Dos"></EasyStyle>
                                <DataInterconect MetodoConexion="WebServiceExterno">
                                     <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                     <Metodo>BuscarPersonalSIMA</Metodo>
                                     <UrlWebServicieParams>
                                         <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                     </UrlWebServicieParams>
                                 </DataInterconect>

                        </cc2:EasyAutocompletar>
                 </td>
                 <td></td>
             </tr>
             <tr>
                 <td  class="Etiqueta" reference="txtRegIng">NRO REG ING</td>
                 <td  colspan="3"><cc2:EasyTextBox ID="txtRegIng" runat="server" required></cc2:EasyTextBox></td>
                 <td  class="Etiqueta" reference="txtDocRef">DOC. REF</td>
                 <td  colspan="3"><cc2:EasyTextBox ID="txtDocRef" runat="server" required></cc2:EasyTextBox></td>

                 <td></td>
             </tr>            

            <tr>
                <td class="Etiqueta" reference="txtTrabReal">TRAB. A REALIZAR</td>
                <td colspan="7"><cc2:EasyTextBox ID="txtTrabReal" Height="60" TextMode="MultiLine" runat="server" required></cc2:EasyTextBox></td>
                <td></td>
            </tr>

            <tr>
                <td class="Etiqueta" reference="acAreaTrab">AREA DE TRAB.</td>
                <td colspan="7">
                     <cc2:EasyAutocompletar ID="acAreaTrab" runat="server"  NroCarIni="4"  DisplayText="NombreArea" ValueField="IDAREA"  fncTempaleCustom="onDisplayTemplateArea" fnOnSelected="onItemAreaSeleccionado" required>
                          <EasyStyle Ancho="Dos"></EasyStyle>
                              <DataInterconect MetodoConexion="WebServiceExterno">
                                   <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                   <Metodo>BuscarAreaSIMA</Metodo>
                                   <UrlWebServicieParams>
                                       <cc3:EasyFiltroParamURLws  ParamName="IdCentroOperativo" Paramvalue="2" ObtenerValor="Fijo" TipodeDato="Int"/>
                                       <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                   </UrlWebServicieParams>
                               </DataInterconect>
                      </cc2:EasyAutocompletar>
                </td>
                 <td></td>
            </tr>

            <tr>
                <td class="Etiqueta" reference="txtNombreNave">NOMBRE NAVE</td>
                <td colspan="7"><cc2:EasyTextBox ID="txtNombreNave" runat="server" required></cc2:EasyTextBox></td>
                 <td></td>
            </tr>

            <tr>
                <td class="Etiqueta"  reference="txtContacto">CONTACTO</td>
                <td colspan="7"><cc2:EasyTextBox ID="txtContacto" runat="server" required></cc2:EasyTextBox></td>
                 <td></td>
            </tr>

            <tr>
                <td class="Etiqueta" reference="txtObservaciones">OBSERVACINES</td>
                <td colspan="7"><cc2:EasyTextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Height="80" required></cc2:EasyTextBox></td>
                <td></td>
            </tr>
        </table>

        <table id="tblSecSeguro" border="0" style="width:100%; visibility:hidden">
             <tr>
                 <td class="Etiqueta"  reference="acCiaSeguro">CIA</td>
                 <td colspan="7">
                        <cc2:EasyAutocompletar ID="acCiaSeguro" runat="server"  NroCarIni="4"  DisplayText="DESCRIPCION" ValueField="CODIGO"  fnOnSelected="onItemCiaSeguroSeleccionado" fncTempaleCustom="onDisplayTemplateCIASeg" required>
                             <EasyStyle Ancho="Dos"></EasyStyle>
                                 <DataInterconect MetodoConexion="WebServiceExterno">
                                      <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                      <Metodo>BuscarCiaReguros</Metodo>
                                      <UrlWebServicieParams>
                                          <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                      </UrlWebServicieParams>
                                  </DataInterconect>

                         </cc2:EasyAutocompletar>
                 </td>
                 <td></td>
             </tr>
            <tr>
                <td colspan="4" class="Etiqueta">
                    FECHA
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>

            <tr>
                <td class="Etiqueta" reference="FSegIni">INICIO</td>
                <td><cc2:EasyDatepicker ID="FSegIni" runat="server" required></cc2:EasyDatepicker></td>
                <td class="Etiqueta" reference="FSegFin">FIN</td>
                <td><cc2:EasyDatepicker ID="FSegFin" runat="server" required></cc2:EasyDatepicker></td>
                <td class="Etiqueta" colspan="4"></td>
            </tr>
            <tr>
                <td colspan="4" class="Etiqueta">SCTR</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                  <td class="Etiqueta" reference="txtPension">PESNSION:</td>
                  <td colspan="1"> <cc2:EasyTextBox ID="txtPension" runat="server" required></cc2:EasyTextBox></td>
                  <td></td>
                  <td class="Etiqueta"  reference="txtSalud">SALUD:</td>
                  <td colspan="1"><cc2:EasyTextBox ID="txtSalud" runat="server" required></cc2:EasyTextBox></td>
                  <td></td>   
                  <td></td>   
            </tr>
        </table>

    </form>
</body>
    <script>
        DetalleProgramacion.Aceptar = function () {

            if (DetalleProgramacion.Params[DetalleProgramacion.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.N) {
                DetalleProgramacion.Insertar();
            }
            else {
                DetalleProgramacion.Modificar();
            }
            return true;
        }

        DetalleProgramacion.Insertar = function () {
            var oParamCollections = new SIMA.ParamCollections();

            oParam = new SIMA.Param("IdEntidad", acProveedor.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdJefeProyecto", acJefeProy.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NroRegistroIngreso", txtRegIng.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NroDocumentodeRef", txtDocRef.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FechaInicio", FInicio.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FechaTermino", FFin.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("HoraInicio", dpHIni.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("HoraTermino", dpHFin.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdCIASeguros", acCiaSeguro.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FechaInicioPoliza", FSegIni.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FechaTerminoPoliza", FSegFin.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NroPensionPoliza", txtPension.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NroSaludPoliza", txtSalud.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("TrabajosARealizar", txtTrabReal.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdLugardeTrabajo", acAreaTrab.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NombreNave", txtNombreNave.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NombreContacto", txtContacto.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Observaciones", txtObservaciones.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("TipoProgramacion", 0, TipodeDato.Int);
            oParamCollections.Add(oParam);


            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/SIMANET/SeguridadPlanta/Contratista.asmx';
            oEasyDataInterConect.Metodo = 'ContratistaProgramacion_Ins';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData();

        }

        DetalleProgramacion.Modificar = function () {

                var oParamCollections = new SIMA.ParamCollections();

                var oParam = new SIMA.Param("NroProgramacion", DetalleProgramacion.Params[DetalleProgramacion.KEYQIDPROGRAMACION], TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("Periodo", DetalleProgramacion.Params[DetalleProgramacion.KEYQAÑO], TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdEntidad", acProveedor.GetValue() , TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdJefeProyecto", acJefeProy.GetValue(), TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("NroRegistroIngreso", txtRegIng.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("NroDocumentodeRef", txtDocRef.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("FechaInicio", FInicio.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("FechaTermino", FFin.GetValue() );
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("HoraInicio", dpHIni.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("HoraTermino", dpHFin.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdCIASeguros", acCiaSeguro.GetValue(), TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("FechaInicioPoliza", FSegIni.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("FechaTerminoPoliza", FSegFin.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("NroPensionPoliza", txtPension.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("NroSaludPoliza", txtSalud.GetValue() );
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("TrabajosARealizar", txtTrabReal.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdLugardeTrabajo", acAreaTrab.GetValue(), TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("NombreNave", txtNombreNave.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("NombreContacto", txtContacto.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("Observaciones", txtObservaciones.GetValue() );
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);

                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/SIMANET/SeguridadPlanta/Contratista.asmx';
                oEasyDataInterConect.Metodo = 'ProgramacionContratista_act';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var ResultBE = oEasyDataResult.sendData();
            }
    
        DetalleProgramacion.Proveedor = function () {
            AdministrarProgramacionContratista.DetalleProveedor();
        }
    </script>
</html>
