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
                    break;
                case "TabItem_2":
                    //Cargar Lista de CTRS
                    DetalleProgramacion.LoadCSTR();
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
                       <cc2:EasyDatepicker ID="FFin" runat="server" fncSelectDate="DetalleProgramacion.FechaFinOnSelected" required></cc2:EasyDatepicker>
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
                 <td><cc2:EasyTextBox ID="txtRegIng" runat="server" required></cc2:EasyTextBox></td>
                 <td  class="Etiqueta" reference="txtDocRef">DOC. REF</td>
                 <td colspan="5"><cc2:EasyTextBox ID="txtDocRef" runat="server" required></cc2:EasyTextBox></td>
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
                <td  class="Etiqueta">SCTR</td>
                <td></td>
                <td class="Etiqueta">INICIO</td>
                <td></td>
                <td class="Etiqueta">TERMINO</td>   
                <td></td>   
                <td></td>   
            </tr>
            <tr>
                  <td class="Etiqueta" reference="txtPension">PESNSION:</td>
                  <td colspan="1"> <cc2:EasyTextBox ID="txtPension" runat="server" required cc2:EasyTextBox/></td>
                  <td>
                      <cc2:EasyDatepicker ID="FSegIni" runat="server" fncSelectDate="DetalleProgramacion.FechaSCTRPensionIni" required></cc2:EasyDatepicker>

                  </td>
                  <td reference="FSegIni"></td>
                  <td><cc2:EasyDatepicker ID="FSegFin" runat="server" fncSelectDate="DetalleProgramacion.FechaSCTRPensionFin" required></cc2:EasyDatepicker> </td>
                  <td reference="FSegFin"></td>   
                  <td></td>   
            </tr>
            <tr>
                 <td class="Etiqueta"  reference="txtSalud">SALUD:</td>
                 <td colspan="1"><cc2:EasyTextBox ID="txtSalud" runat="server" required></cc2:EasyTextBox></td>
                 <td><cc2:EasyDatepicker ID="FSegIniS" runat="server" required></cc2:EasyDatepicker></td>
                 <td reference="FSegIniS"></td>
                 <td><cc2:EasyDatepicker ID="FSegFinS" runat="server" required></cc2:EasyDatepicker></td>
                 <td reference="FSegFinS"></td>   
                 <td></td>   
            </tr>

            <tr>
                <td colspan="7" id="ContentSCTR">
                   
                </td>
            </tr>
        </table>

    </form>
</body>
    <script>
        DetalleProgramacion.FechaSCTRPensionIni = function (Fecha) {
           // alert(FSegFin.GetValue())

            if (Number(Fecha.toString().DateFormatYYYYmmdd('/')) > Number(FSegFin.GetValue().toString().DateFormatYYYYmmdd('/'))) {
                var msgConfig = { Titulo: 'Alerta', Descripcion: 'Fecha de inicio  no puede ser mayor que la fecha de termino.. vuelva a intentarlo' };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
                FSegIni.SetValue(SIMA.Utilitario.Helper.Hora.Hoy());
            }
        }


        DetalleProgramacion.FechaSCTRPensionFin = function (Fecha) {
            if (Number(Fecha.toString().DateFormatYYYYmmdd('/')) < Number(FSegIni.GetValue().toString().DateFormatYYYYmmdd('/'))) {
                var msgConfig = { Titulo: 'Alerta', Descripcion: 'Fecha de Termino  no puede ser menor que la fecha de inicio.. vuelva a intentarlo' };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
                FSegFin.SetValue(SIMA.Utilitario.Helper.Hora.Hoy());
            }
        }




        DetalleProgramacion.FechaFinOnSelected = function (Fecha) {
            if (DetalleProgramacion.Params[DetalleProgramacion.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.M) {
                if (Number(Fecha.toString().DateFormatYYYYmmdd('/')) > Number(sctrBE.FechaTermino.toString().DateFormatYYYYmmdd('/'))) {

                    var msgConfig = { Titulo: 'Alerta', Descripcion: 'Fecha de termino no puede ser mayor a la establecida.. vuelva a intentarlo' };
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                    FFin.SetValue(sctrBE.FechaTermino);
                }

                if (Number(Fecha.toString().DateFormatYYYYmmdd('/')) < Number(FInicio.GetValue().toString().DateFormatYYYYmmdd('/'))) {
                    var msgConfig = { Titulo: 'Alerta', Descripcion: 'Fecha de termino no puede ser menor a la fecha de Inicio.. vuelva a intentarlo' };
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                    FFin.SetValue(sctrBE.FechaTermino);
                }
            }
        }

        DetalleProgramacion.LoadCSTR = function () {

            if (DetalleProgramacion.Params[DetalleProgramacion.KEYMODOPAGINA] != SIMA.Utilitario.Enumerados.ModoPagina.N) {

                var UrlPag = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/AdministrarSCTR.aspx";
                var oColletionParams = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(DetalleProgramacion.KEYQIDENTIDAD, acProveedor.GetValue());
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(DetalleProgramacion.KEYQAÑO, DetalleProgramacion.Params[DetalleProgramacion.KEYQAÑO]);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(DetalleProgramacion.KEYQIDPROGRAMACION, DetalleProgramacion.Params[DetalleProgramacion.KEYQIDPROGRAMACION]);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(DetalleProgramacion.KEYQNROSALUD, txtSalud.GetValue());
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(DetalleProgramacion.KEYQPENSION, txtPension.GetValue());
                oColletionParams.Add(oParam);

                var oLoadConfig = {
                    CtrlName: "ContentSCTR",
                    UrlPage: UrlPag,
                    ColletionParams: oColletionParams,
                    fnOnComplete: function () {
                        //AdministrarReporte.Navigator.Node.Select.icon = AdministrarReporte.Navigator.Node.Select.iconOld;

                    }
                };

                SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
            }
        }

        DetalleProgramacion.Aceptar = function () {

            if (DetalleProgramacion.Params[DetalleProgramacion.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.N) {
                var IdProg = DetalleProgramacion.Insertar();
                var arrKey = IdProg.toString().split('-');
                var Año = arrKey[0];
                var NroProgr= arrKey[1];
                //Registro del primer  SCTR 
               var idSctrPension = DetalleProgramacion.InsertarSCTR(1, Año, NroProgr,txtPension.GetValue(), FSegIni.GetValue(), FSegFin.GetValue());
               var idSctrSalud = DetalleProgramacion.InsertarSCTR(2, Año, NroProgr, txtSalud.GetValue(), FSegIniS.GetValue(), FSegFinS.GetValue());



                //abre la pantalla para  el registro de los trabajadores
                var DetalleBE = { Periodo: Año, NroProgramacion: NroProgr, FechaInicio: FInicio.GetValue(), FechaTermino: FFin.GetValue(), HoraInicio: dpHIni.GetValue(), HoraTermino: dpHFin.GetValue()};
                AdministrarProgramacionContratista.AdministrarTrabajadoresyEquipos(DetalleBE);

               // DetalleProgramacion.CallDetalleSCTR('N', acProveedor.GetValue(), txtPension.GetValue(), txtSalud.GetValue(), 0);
            }
            else {//Al modificar la porogramacion
                var idSctrPension = "";
                var idSctrSalud = "";
                DetalleProgramacion.Modificar();

         

                //Si Existen diferencia entre las fechas de los SCTR  se procedera a clonar con las nuevas fecha y a establecer como no vigente lo anterior
                if (DetalleProgramacion.ValidarSCTR(1)) {
                    //desactivar SCTR

                    if (sctrBE.IdSCTRp != undefined) {
                        DetalleProgramacion.EliminarSCTRActivo(sctrBE.IdSCTRp);
                    }
                    idSctrPension = DetalleProgramacion.InsertarSCTR(1, DetalleProgramacion.Params[DetalleProgramacion.KEYQAÑO], DetalleProgramacion.Params[DetalleProgramacion.KEYQIDPROGRAMACION], txtPension.GetValue(), FSegIni.GetValue(), FSegFin.GetValue());
                    DetalleProgramacion.ListarTrabajadores().Rows.forEach(function (oDataRow, r) {
                        AdministrarProgramacionContratista.RegistrarTrabajadorSCTR(idSctrPension, "0", oDataRow["NroDni"].toString(), 1);
                    });

                }
                if (DetalleProgramacion.ValidarSCTR(2)) {
                    //desactivar SCTR
                    if (sctrBE.IdSCTRs != undefined) {
                        DetalleProgramacion.EliminarSCTRActivo(sctrBE.IdSCTRs);
                    }

                    idSctrSalud = DetalleProgramacion.InsertarSCTR(2, DetalleProgramacion.Params[DetalleProgramacion.KEYQAÑO], DetalleProgramacion.Params[DetalleProgramacion.KEYQIDPROGRAMACION], txtSalud.GetValue(), FSegIniS.GetValue(), FSegFinS.GetValue());

                    DetalleProgramacion.ListarTrabajadores().Rows.forEach(function (oDataRow, r) {
                        AdministrarProgramacionContratista.RegistrarTrabajadorSCTR(idSctrSalud, "0", oDataRow["NroDni"].toString(), 1);
                    });

                }

                /*EasyGRSCTR.ItemsforEach(function (oRow) {
                    var oDataRow = oRow.GetData();
                    alert(oDataRow["IdSCTR"]);
                });
                */

            }
            return true;
        }

        DetalleProgramacion.ListarTrabajadores = function () {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
            oEasyDataInterConect.Metodo = "ProgramacionTrabajador_lst";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("Periodo", DetalleProgramacion.Params[DetalleProgramacion.KEYQAÑO], TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdProgramacion", DetalleProgramacion.Params[DetalleProgramacion.KEYQIDPROGRAMACION], TipodeDato.Int);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            oParam = new SIMA.Param("NroDNI", "");
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;


            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }

        DetalleProgramacion.ValidarSCTR = function (IdTipo) {
            var CrearSCTR = false;
            switch (IdTipo) {
                case 1://Pension
                    if ((sctrBE.pFIni != FSegIni.GetValue()) || (sctrBE.pFFin != FSegFin.GetValue())) {
                        CrearSCTR=true;
                    }
                    break;
                case 2://Salud
                    if ((sctrBE.pFIni != FSegIni.GetValue()) || (sctrBE.pFFin != FSegFin.GetValue())) {
                        CrearSCTR=true;
                    }
                    break;

            }
            return CrearSCTR;

        }

        DetalleProgramacion.EliminarSCTRActivo = function (IdSCTR) {
            var oParamCollections = new SIMA.ParamCollections();
            oParam = new SIMA.Param("IdSCTR", IdSCTR);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/SIMANET/SeguridadPlanta/Contratista.asmx';
            oEasyDataInterConect.Metodo = 'SCTR_Eli';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData();

            return ResultBE;
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

            oParam = new SIMA.Param("FechaInicioPolizaS", FSegIniS.GetValue());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FechaTerminoPolizaS", FSegFinS.GetValue());
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

            return ResultBE;
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

                oParam = new SIMA.Param("FechaInicioPolizaS", FSegIniS.GetValue());
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("FechaTerminoPolizaS", FSegFinS.GetValue());
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


        //Inocado en el Aceptar de la programacion y tambien en el ACEPTAR de l detalle del SCTR
        DetalleProgramacion.InsertarSCTR = function (IdTipo,Periodo,NroProg,nroCTRS, FechaIni, FechaFin) {

            var oParamCollections = new SIMA.ParamCollections();

            oParam = new SIMA.Param("NroSCTR", nroCTRS);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdEntidad", acProveedor.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Periodo", Periodo, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("NroProg", NroProg, TipodeDato.Int);
            oParamCollections.Add(oParam);


            oParam = new SIMA.Param("FechaIni", FechaIni);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FechaFin", FechaFin);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdTipo", IdTipo, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/SIMANET/SeguridadPlanta/Contratista.asmx';
            oEasyDataInterConect.Metodo = 'SCTR_ins';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var IdResult = oEasyDataResult.sendData();

            return IdResult;
        }


    </script>
</html>
