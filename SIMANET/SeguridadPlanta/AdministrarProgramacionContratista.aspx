<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarProgramacionContratista.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.AdministrarProgramacionContratista" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
  

</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%;">
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" />
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyGridView ID="EasyGRContrata"   AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Programación de Contratistas" ToolBarButtonClick="OnEasyGridButton_Click" Width="100%" AllowPaging="True" runat="server" fncExecBeforeServer="" OnRowDataBound="EasyGRContrata_RowDataBound" OnPageIndexChanged="EasyGRContrata_PageIndexChanged" OnEasyGridButton_Click="EasyGRContrata_EasyGridButton_Click">
                            <EasyGridButtons>
                                <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RequiereSelecciondeReg="False" RunAtServer="False" SilenceWait="True" SolicitaConfirmar="False" Texto="Agregar" Ubicacion="Derecha" />
                                <cc1:EasyGridButton ID="btnEliminar" Descripcion="" Icono="fa fa-close" MsgConfirm="Desea eliminar ahora el registro seleccionado?" RequiereSelecciondeReg="True" RunAtServer="True" SilenceWait="False" SolicitaConfirmar="True" Texto="Eliminar" Ubicacion="Derecha" />
                                <cc1:EasyGridButton ID="btnTrabEquipo" Descripcion="" Icono="fa fa-user-plus" RequiereSelecciondeReg="True" RunAtServer="False" SilenceWait="False" Texto="Trabajadores / Equipos" Ubicacion="Centro" />
                            </EasyGridButtons>
                            <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                            <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect>
                            
                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="AdministrarProgramacionContratista.GridCellOnClick" IdGestorFiltro="EasyGestorFiltro1"></EasyExtended>

                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                            <Columns>
                             <asp:BoundField DataField="NroProg" HeaderText="N° PROGR." />
                             <asp:BoundField DataField="NroDocumentodeRef" HeaderText="NRO DOC. REF." SortExpression="NroDocumentodeRef" >
                             <ItemStyle HorizontalAlign="Left" Width="8%" />
                             </asp:BoundField>
                             <asp:BoundField DataField="NroProveedor" HeaderText="NRO R.U.C" SortExpression="NroProveedor" >
                             <ItemStyle HorizontalAlign="Left" />
                             </asp:BoundField>
                             <asp:BoundField DataField="RazonSocialProveedor" HeaderText="RAZON SOCIAL" SortExpression="RazonSocialProveedor" >
                             <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Wrap="False" />
                             </asp:BoundField>
                             <asp:BoundField DataField="NombreNave" HeaderText="NOMBRE NAVE" >
                             <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                             </asp:BoundField>
                             <asp:TemplateField HeaderText="FECHA">
                                 <ItemStyle Width="8%" HorizontalAlign="Center" />
                                </asp:TemplateField>
                             <asp:TemplateField HeaderText="HORA">
                                 <ItemStyle Width="8%" />
                                </asp:TemplateField>
                             <asp:BoundField HeaderText="NRO TRAB." DataField="NroTrab" >
                                <ItemStyle Width="4%" />
                                </asp:BoundField>
                         </Columns>
                           <HeaderStyle CssClass="HeaderGrilla" />
                           <PagerStyle HorizontalAlign="Center" />
                           <RowStyle CssClass="ItemGrilla" Height="25px" />
                        </cc1:EasyGridView>
                </td>
            </tr>

        </table>
        <cc2:EasyPopupBase ID="EasyPopInfoGen" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="PROGRAMACIÓN CONTRATISTA"   ValidarDatos="true"  RunatServer="false" DisplayButtons="true" fncScriptAceptar="DetalleProgramacion.Aceptar" OnClick="EasyPopInfoGen_Click" ></cc2:EasyPopupBase>
        <cc2:EasyPopupBase ID="EasyPopupPrv" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="PROVEEDOR"   ValidarDatos="true"  RunatServer="false" DisplayButtons="true" fncScriptAceptar="DetalleProveedor.Aceptar"></cc2:EasyPopupBase>
        <cc2:EasyPopupBase ID="EasyPopupTrabEqui" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="TRABAJADORES Y EQUIPOS"   ValidarDatos="false"  RunatServer="true" DisplayButtons="true" fncScriptAceptar="AdministrarProgramacionContratista.TrabajadorEquipoAceptar" OnClick="EasyPopupTrabEqui_Click"  ></cc2:EasyPopupBase>
        <cc2:EasyPopupBase ID="EasyPopupEquipoDet" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="DETALLE EQUIPO"   ValidarDatos="true"  RunatServer="false" DisplayButtons="true"  fncScriptAceptar="DetalleEquipos.Aceptar"  ></cc2:EasyPopupBase>
        <cc2:EasyPopupBase ID="EasyPopupTrabajador" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="DETALLE TRABAJADOR"   ValidarDatos="true"  RunatServer="false" DisplayButtons="true"  fncScriptAceptar="DetalleTrabajador.Aceptar"  ></cc2:EasyPopupBase>
        <cc2:EasyPopupBase ID="EasyPopupReprogramaTrab" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="REPROGRAMACION DE TRABAJADOR"   ValidarDatos="true"  RunatServer="false" DisplayButtons="true"  fncScriptAceptar="ReprogramarTrabajador.Aceptar"  ></cc2:EasyPopupBase>



        <cc3:EasyGestorFiltro ID="EasyGestorFiltro1" runat="server" EasyFiltroCampos-Capacity="4" Titulo="FILTRA INFO. CONTRATISTA" OnProcessCompleted="EasyGestorFiltro1_ProcessCompleted">
            <cc3:EasyFiltroCampo Descripcion="Nro Programacion" Nombre="NroProg" TipodeDato="String">
                <DataInterconect MetodoConexion="WebServiceInterno">
                </DataInterconect>
                <EasyControlAsociado LstValueField="" MaxLength="0" TemplateType="EasyITemplateTextBox" />
            </cc3:EasyFiltroCampo>
            <cc3:EasyFiltroCampo Descripcion="Documento Ref." Nombre="NroDocumentodeRef" TipodeDato="String">
                <DataInterconect MetodoConexion="WebServiceInterno">
                </DataInterconect>
                <EasyControlAsociado LstValueField="" MaxLength="0" TemplateType="EasyITemplateTextBox" />
            </cc3:EasyFiltroCampo>
            <cc3:EasyFiltroCampo Descripcion="RUC PROVEEDOR" Nombre="NroProveedor" TipodeDato="String">
                <DataInterconect MetodoConexion="WebServiceExterno">
                    <ConfigPathSrvRemoto>PathBaseWSCore</ConfigPathSrvRemoto>
                    <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                    <Metodo>BuscarProveedorXrUC</Metodo>
                    <UrlWebServicieParams>
                        <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                    </UrlWebServicieParams>
                </DataInterconect>
                <EasyControlAsociado fncTempaleCustom="AdministrarProgramacionContratista.onDisplayTemplateProveedor" LstValueField="" MaxLength="0" NroCarIni="4" TemplateType="EasyITemplateAutoCompletar" TextField="NROPROVEEDOR" ValueField="IDPROVEEDOR" />
            </cc3:EasyFiltroCampo>

              <cc3:EasyFiltroCampo Descripcion="Razón Social" Nombre="RazonSocialProveedor" TipodeDato="String">
                  <DataInterconect MetodoConexion="WebServiceExterno">
                      <ConfigPathSrvRemoto>PathBaseWSCore</ConfigPathSrvRemoto>
                      <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                      <Metodo>BuscarProveedorXRSocial</Metodo>
                      <UrlWebServicieParams>
                          <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                      </UrlWebServicieParams>
                  </DataInterconect>
                  <EasyControlAsociado fncTempaleCustom="AdministrarProgramacionContratista.onDisplayTemplateProveedor" LstValueField="" MaxLength="0" NroCarIni="4" TemplateType="EasyITemplateAutoCompletar" TextField="RAZONSOCIAL" ValueField="RAZONSOCIAL" />
              </cc3:EasyFiltroCampo>

             <cc3:EasyFiltroCampo Descripcion="Jefe de Proyectos" Nombre="IdJefeProyecto" TipodeDato="String">
                 <DataInterconect MetodoConexion="WebServiceExterno">
                     <ConfigPathSrvRemoto>PathBaseWSCore</ConfigPathSrvRemoto>
                     <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                     <Metodo>BuscarPersonalSIMA</Metodo>
                     <UrlWebServicieParams>
                         <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                     </UrlWebServicieParams>
                 </DataInterconect>
                 <EasyControlAsociado fncTempaleCustom="AdministrarProgramacionContratista.onDisplayTemplatePersonal" LstValueField="" MaxLength="0" NroCarIni="4" TemplateType="EasyITemplateAutoCompletar" TextField="Nombres" ValueField="idpersonal" />
             </cc3:EasyFiltroCampo>

             <cc3:EasyFiltroCampo Descripcion="Area Destino" Nombre="IdArea" TipodeDato="String">
                 <DataInterconect MetodoConexion="WebServiceExterno">
                     <ConfigPathSrvRemoto>PathBaseWSCore</ConfigPathSrvRemoto>
                     <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                     <Metodo>BuscarAreaSIMA</Metodo>
                     <UrlWebServicieParams>
                         <cc3:EasyFiltroParamURLws  ParamName="IdCentroOperativo" Paramvalue="2" ObtenerValor="Fijo" TipodeDato="Int"/>
                         <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                     </UrlWebServicieParams>
                 </DataInterconect>
                 <EasyControlAsociado fncTempaleCustom="AdministrarProgramacionContratista.onDisplayTemplateArea" LstValueField="" MaxLength="0" NroCarIni="4" TemplateType="EasyITemplateAutoCompletar" TextField="NombreArea" ValueField="IDAREA" />
             </cc3:EasyFiltroCampo>

            <cc3:EasyFiltroCampo Descripcion="C.I.A Seguros" Nombre="idCIASeguros" TipodeDato="String">
                <DataInterconect MetodoConexion="WebServiceExterno">
                    <ConfigPathSrvRemoto>PathBaseWSCore</ConfigPathSrvRemoto>
                    <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                    <Metodo>BuscarCiaReguros</Metodo>
                    <UrlWebServicieParams>
                        <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                    </UrlWebServicieParams>
                </DataInterconect>
                <EasyControlAsociado fncTempaleCustom="AdministrarProgramacionContratista.onDisplayTemplateCIASeg" LstValueField="" MaxLength="0" NroCarIni="4" TemplateType="EasyITemplateAutoCompletar" TextField="DESCRIPCION" ValueField="CODIGO" />
            </cc3:EasyFiltroCampo>
        </cc3:EasyGestorFiltro>

    </form>
    <script>

        function OnEasyGridButton_Click(btnItem, DetalleBE) {

          
            switch (btnItem.Id) {
                case "btnAgregar":

                    var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleProgramacion.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQIDPROGRAMACION, "0");
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQAÑO, "0");
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                    oColletionParams.Add(oParam);

                    EasyPopInfoGen.Load(Url, oColletionParams, false);

                    break;

                case "btnTrabEquipo":
                    AdministrarProgramacionContratista.AdministrarTrabajadoresyEquipos(DetalleBE);
                    
                    break;
            }
        }

        AdministrarProgramacionContratista.TrabajadorEquipoAceptar = function () {
            return true;
        }


        AdministrarProgramacionContratista.AdministrarTrabajadoresyEquipos = function (oDetalleBE) {
            var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DefaultContratista.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQIDPROGRAMACION, oDetalleBE.NroProgramacion);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQAÑO, oDetalleBE.Periodo);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQFECHAINI, oDetalleBE.FechaInicio);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQFECHAFIN, oDetalleBE.FechaTermino);
            oColletionParams.Add(oParam);
            //falta envia la hora de inicio y la hora de fin de la programacion
            oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQHORAINI, oDetalleBE.HoraInicio);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQHORAFIN, oDetalleBE.HoraTermino);
            oColletionParams.Add(oParam);

            EasyPopupTrabEqui.Load(Url, oColletionParams, false);
        }

        AdministrarProgramacionContratista.InformacionGeneral = function (oItemRowBE) {

            var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleProgramacion.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQIDPROGRAMACION, oItemRowBE.NroProgramacion);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQAÑO, oItemRowBE.Periodo);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
            oColletionParams.Add(oParam);


            EasyPopInfoGen.Load(Url, oColletionParams, false);
       
        }

        AdministrarProgramacionContratista.DetalleProveedor = function (oItemRowBE) {

            var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleProveedor.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQQUIENLLAMA, "AdministrarProgramacionContratista");
            oColletionParams.Add(oParam);

            EasyPopupPrv.Load(Url, oColletionParams, false);
        }

        AdministrarProgramacionContratista.GridCellOnClick = function (oCell, oDataBE) {
            switch (oCell.cellIndex) {
                case 0:
                    AdministrarProgramacionContratista.InformacionGeneral(oDataBE);
                    break;
            }
        }

    </script>

      <script>
          AdministrarProgramacionContratista.onDisplayTemplateProveedor = function(ul, item) {
              var cmll = "\""; var iTemplate = null;
              iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                  + '<div class= "flex-column">' + item.RAZONSOCIAL
                  + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red"> </small>'
                  + '    <small style="font-weight: bold">NRO RUC.:</small><small style="color:blue;text-transform: capitalize;">' + item.NROPROVEEDOR + '</small></p>'
                  + '    <span class="badge badge-info "> ... </span > '
                  + '</div>'
                  + '</a>';

              var oCustomTemplateBE = new EasyGestorFiltro1_NroProveedor.CustomTemplateBE(ul, item, iTemplate);

              return EasyGestorFiltro1_NroProveedor.SetCustomTemplate(oCustomTemplateBE);
          }
          AdministrarProgramacionContratista.onDisplayTemplatePersonal=function(ul, item) {

              var cmll = "\""; var iTemplate = null;
              iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                  + '<div class= "flex-column">' + item.Nombres
                  + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red">' + item.NroPersonal + '</small>'
                  + '    <small style="font-weight: bold">AREA:</small><small style="color:blue;text-transform: capitalize;">' + item.NombreArea + '</small></p>'
                  + '    <span class="badge badge-info "> ' + item.Email + '</span>'
                  + '</div>'
                  + '<div class="image-parent">'
                  + '<img class=" rounded-circle" width="60px" src="' + AdministrarProgramacionContratista.PathFotosPersonal + item.NroDocIdentidad + '.jpg"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                  + '</div>'
                  + '</a>';

              var oCustomTemplateBE = new EasyGestorFiltro1_IdJefeProyecto.CustomTemplateBE(ul, item, iTemplate);

              return EasyGestorFiltro1_IdJefeProyecto.SetCustomTemplate(oCustomTemplateBE);


          }
          AdministrarProgramacionContratista.onDisplayTemplateArea=function(ul, item) {

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

              var oCustomTemplateBE = new EasyGestorFiltro1_IdArea.CustomTemplateBE(ul, item, iTemplate);
              return EasyGestorFiltro1_IdArea.SetCustomTemplate(oCustomTemplateBE);
          }
          AdministrarProgramacionContratista.onDisplayTemplateCIASeg = function (ul, item) {
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

              var oCustomTemplateBE = new EasyGestorFiltro1_idCIASeguros.CustomTemplateBE(ul, item, iTemplate);
              return EasyGestorFiltro1_idCIASeguros.SetCustomTemplate(oCustomTemplateBE);
          }
      </script>
</body>
</html>
