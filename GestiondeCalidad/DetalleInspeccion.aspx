<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleInspeccion.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.DetalleInspeccion" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc5" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    
    <script>
        function onItemSeleccionadoa(value, ItemBE) {
           // alert(value);
        }


        function MiFechaSeleccionada(valorFecha) {
            //alert(valorFecha);
        }


        function onSelectedProyecto(value, ItemBE) {
            EasyForm1_txtNroProy.SetValue(ItemBE.NroProyecto);
            EasyForm1_txtLN.SetValue(ItemBE.LineaNegocio);
            EasyForm1_txtCliente.SetValue(ItemBE.ClienteRazonSocial);
        }

        function onDisplayTemplateProyecto(ul, item) {
            var cmll = "\"";
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '<div class= "flex-column">' + item.NombreProyecto
                + '    <p><small style="font-weight: bold">Nro PROY:</small> <small style ="color:red">' + item.NroProyecto + '</small>'
                + '    <small style="font-weight: bold">CLIENTE:</small><small style="color:blue;text-transform: capitalize;">' + item.ClienteRazonSocial + '</small></p>'
                + '    <span class="badge badge-info ">' + item.LineaNegocio + '</span > '
                + '</div>'
                + '</a>';

            var oCustomTemplateBE = new EasyForm1_aucProyecto.CustomTemplateBE(ul, item, iTemplate);

            return EasyForm1_aucProyecto.SetCustomTemplate(oCustomTemplateBE);
        }



        function onSelectedTallerContratista(value, ItemBE) {
        }


        function ddlInspeccion_onItemSelected(ListItem) {
          // alert(ListItem.text);
        }
        function FechaInspeccion_onSelect(fecha) {
           // alert(fecha);
        }

        function UnLoad_onCompletado(WinUpLoad, oCollectionsFile) {
            oCollectionsFile.forEach(function (oFileBE) {
               // alert(oFileBE.Nombre);
            });

           // WinUpLoad.Close();
        }


        function ListView_OnSelect(Accion, Id, item) {
            switch (Accion) {
                case "Delete":
                   // var otxtDeleteFile = jNet.get('txtDeleteFile');
                    //otxtDeleteFile.value = EasyForm1_EasyUpLoad1_LFiles.Serialized(item);
                    return true;
                    break;
                case "Link":
                    window.open(item.Url);
                break;
            }
                
            
        }

    </script>

   


</head>
<body >
    <form id="form1" runat="server" >
       <table style="width:100%" border="0">
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" /> </td>
            </tr>
            <tr>
                <td style="padding-left:20px">
                    <cc2:EasyForm ID="EasyForm1" runat="server" ClassName="form-row" CssClass="row g-3" ShowButtonsOk_Cancel="True" OnCommitTransaccion="EasyForm1_CommitTransaccion">
                        <Cabecera Titulo="FICHA DE INSPECCION" Descripcion="Registro de Inspeccion" Snippetby=""></Cabecera>
                        <Secciones>
                            <cc2:EasyFormSeccion Visible="true" colapsable="true">
                                <Titulo>PROYECTO</Titulo>
                                <ItemsCtrl>
                                    <cc1:EasyAutocompletar ID="aucProyecto" runat="server" DisplayText="NombreProyecto" EnableOnChange="False" Placeholder="Ingrese Nombre del proyecto a Localizar"  Etiqueta="Nombre del Proyecto" fnOnSelected="onSelectedProyecto" NroCarIni="3" Requerido="True" ValueField="IdProyecto" fncTempaleCustom="onDisplayTemplateProyecto" MensajeValida="Ingresar Proyecto a inspeccionar" >
                                        <EasyStyle Ancho="Cinco" />
                                        <DataInterconect MetodoConexion="WebServiceInterno">
                                            <UrlWebService>/GestiondeCalidad/Proceso.asmx</UrlWebService>
                                            <Metodo>BuscarProyectoXNombre</Metodo>
                                            <UrlWebServicieParams>
                                                <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                            </UrlWebServicieParams>
                                        </DataInterconect>
                                    </cc1:EasyAutocompletar>
                                </ItemsCtrl>
                            </cc2:EasyFormSeccion>
                       	    <cc2:EasyFormSeccion Visible="false" colapsable="true" >
                                <Titulo>
                                </Titulo>
                                <ItemsCtrl>
                                    <cc1:EasyTextBox ID="txtNroProy" runat="server" autocomplete="off" CssClass="form-control" data-validate="true"  Requerido="False" Etiqueta="Nro Ficha">
                                        <EasyStyle Ancho="Dos"></EasyStyle>                                    
                                        </cc1:EasyTextBox> 
                                    <cc1:EasyTextBox ID="txtLN" runat="server" autocomplete="off" CssClass="form-control" data-validate="true"  Requerido="False" Etiqueta="Linea de Negocio">
                                        <EasyStyle Ancho="Tres"></EasyStyle>                                    
                                        </cc1:EasyTextBox>        
                                        <cc1:EasyTextBox ID="txtCliente" runat="server" autocomplete="off" CssClass="form-control" data-validate="true"  Requerido="False" Etiqueta="Cliente">
                                            <EasyStyle Ancho="Seis"></EasyStyle>                                    
                                            </cc1:EasyTextBox>
                                </ItemsCtrl>
                            </cc2:EasyFormSeccion>
                            <cc2:EasyFormSeccion>
                                 <Titulo>INSPECCION</Titulo>
                                 <ItemsCtrl>
                                    <cc1:EasyTextBox ID="TxtNroReporte" runat="server" autocomplete="off" CssClass="form-control" data-validate="true"  Requerido="False" Etiqueta="Nro Reporte">
                                        <EasyStyle Ancho="Dos"></EasyStyle>                                    
                                        </cc1:EasyTextBox> 
                                    <cc1:EasyDatepicker ID="dpFechaInspeccion" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" EnableOnChange="False" Etiqueta="Fecha Inspección" FormatoFecha="dd/mm/yyyy" Hoy="" Placeholder="ingrese fecha Inspección" Requerido="True" fncSelectDate="FechaInspeccion_onSelect" MensajeValida="Fecha de inspección obligatoria">                                    
                                            <EasyStyle Ancho="Dos"></EasyStyle>                                    
                                            </cc1:EasyDatepicker>
                                     <cc1:EasyDropdownList ID="ddlClasificacion" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" DataTextField="DESCRIPCION" DataValueField="CODIGO" EnableOnChange="True" Etiqueta="Clasificación" fnOnSelected="ddlInspeccion_onItemSelected" MensajeValida="No se ha seleccionado Tipo de inspección" Requerido="True" CargaInmediata="true">
                                        <EasyStyle Ancho="Dos" />
                                          <DataInterconect MetodoConexion="WebServiceInterno">
                                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                    <Metodo>ListarItems</Metodo>
                                                    <UrlWebServicieParams>
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="690" TipodeDato="String" />
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="erosales" TipodeDato="String" />
                                                    </UrlWebServicieParams>
                                            </DataInterconect>
                                    </cc1:EasyDropdownList>
                                 </ItemsCtrl>
                            </cc2:EasyFormSeccion>
                             <cc2:EasyFormSeccion >
                                 <Titulo></Titulo>
                                 <ItemsCtrl>
                                     <cc1:EasyDropdownList ID="ddlTipoInpeccion" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" DataTextField="DESCRIPCION" DataValueField="CODIGO" EnableOnChange="True" Etiqueta="T. de Inspección key[F6]" fnOnSelected="ddlInspeccion_onItemSelected" MensajeValida="No se ha seleccionado Tipo de inspección" Requerido="True" CargaInmediata="true">
                                        <EasyStyle Ancho="Dos" />
                                          <DataInterconect MetodoConexion="WebServiceInterno">
                                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                    <Metodo>ListarItems</Metodo>
                                                    <UrlWebServicieParams>
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="653" TipodeDato="String" />
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                    </UrlWebServicieParams>
                                            </DataInterconect>
                                    </cc1:EasyDropdownList>
                                      <cc1:EasyDropdownList ID="ddlTipoProceso" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" DataTextField="DESCRIPCION" DataValueField="CODIGO" EnableOnChange="True" Etiqueta="Proceso Constructivo key[F7]" fnOnSelected="ddlInspeccion_onItemSelected" MensajeValida="No se ha seleccionado el proceso productivo" Requerido="True" CargaInmediata="true">
                                        <EasyStyle Ancho="Tres" />
                                          <DataInterconect MetodoConexion="WebServiceInterno">
                                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                    <Metodo>ListarItems</Metodo>
                                                    <UrlWebServicieParams>
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="654" TipodeDato="String" />
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                    </UrlWebServicieParams>
                                            </DataInterconect>
                                    </cc1:EasyDropdownList>
                                      <cc1:EasyDropdownList ID="ddTipoSistema" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" DataTextField="DESCRIPCION" DataValueField="CODIGO" EnableOnChange="True" Etiqueta="Sistema/Modulo key[F8]" fnOnSelected="ddlInspeccion_onItemSelected" MensajeValida="No se ha seleccionado Sistema o Modulo" Requerido="True" CargaInmediata="true">
                                        <EasyStyle Ancho="Cuatro" />
                                          <DataInterconect MetodoConexion="WebServiceInterno">
                                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                    <Metodo>ListarItems</Metodo>
                                                    <UrlWebServicieParams>
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="655" TipodeDato="String" />
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                                    </UrlWebServicieParams>
                                            </DataInterconect>
                                    </cc1:EasyDropdownList>
                                      <cc1:EasyDropdownList ID="ddlNorma" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" DataTextField="DESCRIPCION" DataValueField="CODIGO" EnableOnChange="True" Etiqueta="Norma key[F9]" fnOnSelected="ddlInspeccion_onItemSelected" MensajeValida="No se ha seleccionado Normativa" Requerido="True" CargaInmediata="true">
                                        <EasyStyle Ancho="Dos" />
                                          <DataInterconect MetodoConexion="WebServiceInterno">
                                              <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                                    <Metodo>ListarItems</Metodo>
                                                    <UrlWebServicieParams>
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="659" TipodeDato="String" />
                                                        <cc5:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="erosales" TipodeDato="String" />
                                                    </UrlWebServicieParams>
                                            </DataInterconect>
                                    </cc1:EasyDropdownList>
                                 </ItemsCtrl>
                             </cc2:EasyFormSeccion>
                            <cc2:EasyFormSeccion>
                                <Titulo></Titulo>
                                <ItemsCtrl>
                                    <cc1:EasyAutocompletar ID="aucBuscaTallerContrat" runat="server" DisplayText="NombreAreaoEmpresa" EnableOnChange="False" Placeholder="Ingrese Nombre del Taller o Contratista a localizar"  Etiqueta="RESPONSABLE DEL TRABAJO(Taller o Contratista)" fnOnSelected="onSelectedTallerContratista" NroCarIni="3" Requerido="True" ValueField="IdNumeroOrigen"  MensajeValida="Ingresar Nombre de Area(Taller) o Empresa Contratista" >
                                        <EasyStyle Ancho="Once" />
                                        <DataInterconect MetodoConexion="WebServiceInterno">
                                            <UrlWebService >/GestiondeCalidad/Proceso.asmx</UrlWebService>
                                            <Metodo>BAreaoEmpresa</Metodo>
                                            <UrlWebServicieParams>
                                                <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdUsuario" Paramvalue="IdUsuario" TipodeDato="Int" />
                                                <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                            </UrlWebServicieParams>
                                        </DataInterconect>
                                    </cc1:EasyAutocompletar>
                                </ItemsCtrl>
                            </cc2:EasyFormSeccion>
                              <cc2:EasyFormSeccion>
                                  <Titulo></Titulo>
                                 <ItemsCtrl>
                                        <cc1:EasyTextBox ID="txtDescripcion" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Descripcion del Analisis" MensajeValida="Ingrese aquí una descripción. " Requerido="True" Rows="5" TextMode="MultiLine" MaxLength="1200">                                                                                        
                                        <EasyStyle Ancho="Once" TipoTalla="sm"></EasyStyle>                                            
                                        </cc1:EasyTextBox>
                                      <cc1:EasyTextBox ID="txtRecomendaciones" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="Recomendaciones" MensajeValida="Ingrese aquí una recomendación" Requerido="True" Rows="5" TextMode="MultiLine" MaxLength="990">                                                                                
                                        <EasyStyle Ancho="Once" TipoTalla="lg"></EasyStyle>                                      
                                        </cc1:EasyTextBox>
                                 </ItemsCtrl>
                            </cc2:EasyFormSeccion>

                            <cc2:EasyFormSeccion>
                                <Titulo></Titulo>
                                <ItemsCtrl>
                                    <cc1:EasyUpLoad ID="EasyUpLoad1" runat="server" DisplayButtons="True" Etiqueta="Subir Archivos" fncListViewItemClick="ListView_OnSelect"  fncOnComplete="UnLoad_onCompletado" fncScriptAceptar="oEasyForm1_EasyUpLoad1_Exe.Send" ItemFileClass="BaseItem" Modal="fullscreen" ModoContenedor="Contenedor" PaginaProceso="General/UpLoadMaster.aspx" RunatServer="False">
                                        <PathLocalyWeb CarpetaTemporal="C:\AppWebs\AppTest\Archivos\Calidad\AllFiles\Temporal\" UrlTemporal="http://10.10.90.4:7001/Archivos/Calidad/AllFiles/Temporal/" UrlFinal="http://10.10.90.4:7001/Archivos/Calidad/AllFiles/Final/"   CarpetaFinal="C:\AppWebs\AppTest\Archivos\Calidad\AllFiles\Final\"/>
                                        <EasyStyle Ancho="Seis" />
                                    </cc1:EasyUpLoad>
                                  
                                </ItemsCtrl>
                            </cc2:EasyFormSeccion>
                        </Secciones>
                    </cc2:EasyForm>

                </td>
            </tr>
            <tr>
                
                <td>
                    <cc1:EasyPopupBase ID="EasyPopupTablaItems" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Lista de Items" RunatServer="false" DisplayButtons="true" fncScriptAceptar="AdministrarTblGeneraltems.onAceptar" >
                    </cc1:EasyPopupBase>    

                </td>
            </tr>
        </table>
      
    </form>
</body>
     <script>
         //https://www.programaresfacil.co/codigos-de-teclado-keycode/

         $(document).ready(function () {
             var arrKeys = new Array();
             SIMA.Utilitario.Helper.TablaGeneralApoyo(695).Rows.forEach(function (oDataRow, f) {
                 arrKeys.Add({ Key: oDataRow["VAR1"], Value: oDataRow["VAR2"], IdTabla: oDataRow["CODIGO"], NOMBRE: oDataRow["NOMBRE"], Objeto: oDataRow["VAR3"]});
                                                                         });

             document.addEventListener('keydown', event => {
                 arrKeys.forEach(function (Itemkey) {
                     if (event.altKey && event.keyCode.toString().Equal(Itemkey.Value)) {
                         switch (Itemkey.Key) {
                             case "F6":
                             case "F7":
                             case "F8":
                             case "F9":
                                 var urlPag = Page.Request.ApplicationPath + "/General/AdministrarTblGeneraltems.aspx";
                                 var oColletionParams = new SIMA.ParamCollections();
                                 var oParam = new SIMA.Param(DetalleInspeccion.KEYQIDTABLAGENERAL, Itemkey.IdTabla);
                                 oColletionParams.Add(oParam);
                                 oParam = new SIMA.Param(DetalleInspeccion.KEYQDESCRIPCION, Itemkey.NOMBRE);
                                 oColletionParams.Add(oParam);
                                 oParam = new SIMA.Param(DetalleInspeccion.KEYQQUIENLLAMA, "DetalleInspeccion");
                                 oColletionParams.Add(oParam);
                                 EasyPopupTablaItems.Load(urlPag, oColletionParams, false);
                                 DetalleInspeccion.ObjetoSelect = "EasyForm1_" + Itemkey.Objeto + ".LoadData();";
                                 event.preventDefault();
                                 break;
                            
                         }

                     }
                 });
             });

         });
         DetalleInspeccion.ObjetoSelect = null;
     </script>
</html>
