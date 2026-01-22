<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarInspecion.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.AdministrarInspecion" %>
<%@ Register TagPrefix="uc1" TagName="header" Src="~/Controles/Header.ascx" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        /*BadGet - Insignia*/
        .badge1 {
            position: absolute;
            margin-left: -1.1%;
            margin-top: .6%;
        }

        .badge1 {
            display: inline-block;
            min-width: 10px;
            padding: 3px 7px;
            font-size: 12px;
            /* font-weight: 700;*/
            line-height: 1;
            color: red;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            background-color: transparent;
            border-radius: 10px;
        }



        /*BadGet - Insignia*/
        .DocLock {
            position: absolute;
            margin-left: 6;
            margin-top: 1.4%;
        }

        .DocLock {
            display: inline-block;
            min-width: 10px;
            padding: 3px 7px;
            font-size: 12px;
            /* font-weight: 700;*/
            line-height: 1;
            color: red;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            background-color: transparent;
            border-radius: 10px;
        }
    </style>




    <script>
      var RutaFileAjunto = null;
    </script>


    <script>


           function EasyGestorFiltro1_SwichWinOpcion(FieldName, FieldTitle) {
               if (EasyGestorFiltro1_FindFieldInConfig(FieldName, FieldTitle)) {
                   EasyGestorFiltro1_OpenWinModal('EasyGestorFiltro1_Gen', undefined, FieldName);
               }
               else {
                   EasyGestorFiltro1_ModalFromGridView(FieldName, FieldTitle);
               }
           }

           function EasyGestorFiltro1_FindFieldInConfig(FieldName, FieldTitle) {
               var cmll = "\"";
               var Encontrado = false;



               var ddlOP = jNet.get('EasyGestorFiltro1_ddlOperador');
               ddlOP.options[((EasyGestorFiltro1_NroFiltros >= 1) ? 2 : 0)].selected = 'selected';//Selecciona el Operador OR
               EasyGestorFiltro1_txtOperador.SetValue(ddlOP.value);


               var ddlField = jNet.get('EasyGestorFiltro1_ddlCampo');
               ddlField.options[0].selected = 'selected';
               EasyGestorFiltro1_FindOpciones(ddlField);

               var ddlCrit = jNet.get('EasyGestorFiltro1_ddlCriterio');
               ddlCrit.options[0].selected = 'selected';
               EasyGestorFiltro1_txtCriterio.SetValue(ddlCrit.value);

               for (var i = 1; i <= ddlField.options.length - 1; i++) {
                   var ValItem = ddlField.options[i].value;
                   if (ValItem.toString().toLowerCase() == FieldName.toString().toLowerCase()) {
                       ddlField.options[i].selected = 'selected';
                       EasyGestorFiltro1_FindOpciones(ddlField);
                       for (var c = 1; c <= ddlCrit.options.length - 1; c++) {
                           if (ddlCrit.options[c].text == "Contenga") {
                               ddlCrit.options[c].selected = 'selected';
                               EasyGestorFiltro1_txtCriterio.SetValue(ddlCrit.value);
                           }
                       }
                       Encontrado = true;
                   }
               }
               return Encontrado;
           }




           function ImgTemplate(oImg, ApellidosYNombres) {
               var MsgTemplate = '<table width="100%"><tr><td align="center"><img width="220px" class="' + oImg.className + '" src="' + oImg.src + '"/></td></tr> <tr><td align="center">' + ApellidosYNombres + '<br>Desea eliminarlo ahora? </td></tr></table >';
               return MsgTemplate;
           }
           /*para los controles creados de lado del servidor*/
           /****************************************************************************************************************/
           var ListItemActivo = null;
           function ListViewInspector_ItemMouseMove(Target, Source, oItem) {
               ListItemActivo = { Origen: Source, Item: oItem, Target: Target };
           }
           function ListViewInspector_ItemClick(Accion, Source, oItem) {
               switch (Accion) {
                   case "Open":
                       var ItemEncontrado = Source.FindKey(oItem);
                       var ConfigMsgb = {
                           Titulo: 'INSPECTOR/PARTICIPANTES'
                           , Descripcion: ImgTemplate(ItemEncontrado, oItem.Text)
                           , Icono: 'fa fa-question-circle'
                           , EventHandle: function (btn) {
                               if (btn == 'OK') {

                                   try {
                                       var oDataRow = EasyGridView1.GetDataRow();
                                       var CadenadeConexion = Page.Request.ApplicationPath + "/GestiondeCalidad/Proceso.aspx";
                                       var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
                                       var oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYQIDINSPECTOR, oItem.Value);
                                       oParamCollections.Add(oParam);
                                       oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYIDINSPECCION, oDataRow["IdInspeccion"]);
                                       oParamCollections.Add(oParam);
                                       oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYQIDPERSONAL, oItem.DataComplete.IdPersonal);
                                       oParamCollections.Add(oParam);
                                       oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYQIDINSPECTOR_PRINCIPAL, Source.DataComplete.Principal);
                                       oParamCollections.Add(oParam);
                                       oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYQIDESTADO, "0");
                                       oParamCollections.Add(oParam);
                                       oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYQIDPROCESO, Proceso.GestiondeCalidad.InsModInspector);
                                       oParamCollections.Add(oParam);

                                       var OleDBCommand = new SIMA.Data.OleDB.Command();
                                       OleDBCommand.CadenadeConexion = CadenadeConexion;


                                       var obj = OleDBCommand.ExecuteNonQuery(oParamCollections);

                                       if (obj != undefined) {
                                           Source.remove(ItemEncontrado);
                                           return true;
                                       }
                                   }
                                   catch (SIMADataException) {
                                       var msgConfig = { Titulo: "Error al Eliminar Inspector", Descripcion: SIMADataException.Message };
                                       var oMsg = new SIMA.MessageBox(msgConfig);
                                       oMsg.Alert();
                                   }


                               }
                           }
                       };
                       var oMsg = new SIMA.MessageBox(ConfigMsgb);
                       oMsg.confirm();

                       break;
                   case "Close":

                       return false;
                       break;
               }

           }

           function ListViewResponsables_ItemClick(Accion, Source, oItem) {
               switch (Accion) {
                   case "Open":
                       if (oItem.DataComplete.IdTipoTrabajador == 1) {
                           var Url = Page.Request.ApplicationPath + "/GestiondeCalidad/AdministrarDetallePorResponsabledeArea.aspx";
                           var oColletionParams = new SIMA.ParamCollections();
                           var oParam = new SIMA.Param(AdministrarInspecion.KEYIDINSPECCION, Source.DataComplete.IdInspeccion);
                           oColletionParams.Add(oParam);

                           oParam = new SIMA.Param(AdministrarInspecion.KEYQIDPERSONAL, oItem.Value);
                           oColletionParams.Add(oParam);

                           EasyPopupDetalleRespArea.Load(Url, oColletionParams, false);
                       }
                       else {
                           var msgConfig = { Titulo: "Error", Descripcion: "Trabajador contratista no se encuentra autorizado de registrar Información" };
                           var oMsg = new SIMA.MessageBox(msgConfig);
                           oMsg.Alert();
                       }
                       break;
                   case "Delete":
                       var ItemEncontrado = Source.FindKey(oItem);
                       var orowSelected = jNet.get(ItemEncontrado.parentNode.parentNode.parentNode.parentNode);
                       EasyGridView1_OnRowClick(orowSelected);
                       SIMA.GridView.Extended.OnEventClickChangeColor(orowSelected);
                       var ConfigMsgb = {
                           Titulo: 'ELIMINAR RESPONSABLE'
                           , Descripcion: ImgTemplate(ItemEncontrado, oItem.Text)
                           , Icono: 'fa fa-question-circle'
                           , EventHandle: function (btn) {
                               if (btn == 'OK') {
                                   //  try {
                                   var oDataRow = EasyGridView1.GetDataRow();
                                   var oParamCollections = new SIMA.ParamCollections();
                                   var oParam = new SIMA.Param("IdInspeccion", oDataRow["IdInspeccion"]);
                                   oParamCollections.Add(oParam);
                                   oParam = new SIMA.Param("IdTipoPersonal", oItem.DataComplete.IdTipoTrabajador, TipodeDato.Int);
                                   oParamCollections.Add(oParam);
                                   oParam = new SIMA.Param("IdPersonal", oItem.DataComplete.IdPersonal);
                                   oParamCollections.Add(oParam);
                                   oParam = new SIMA.Param("IdEstado", "0", TipodeDato.Int);
                                   oParamCollections.Add(oParam);
                                   oParam = new SIMA.Param('IdUsuario', AdministrarInspecion.Params['IdUsuario'], TipodeDato.Int);
                                   oParamCollections.Add(oParam);
                                   oParam = new SIMA.Param('UserName', AdministrarInspecion.Params['UserName']);
                                   oParamCollections.Add(oParam);

                                   var oEasyDataInterConect = new EasyDataInterConect();
                                   oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                                   oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                                   oEasyDataInterConect.Metodo = 'ActEstadoResponsableArea';
                                   oEasyDataInterConect.ParamsCollection = oParamCollections;

                                   var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                                   var obj = oEasyDataResult.sendData();

                                   if (obj != undefined) {
                                       Source.remove(ItemEncontrado);
                                       return true;
                                   }
                                   /* }
                                    catch (SIMADataException) {
                                        var msgConfig = { Titulo: "Error al Eliminar Inspector", Descripcion: SIMADataException.Message };
                                        var oMsg = new SIMA.MessageBox(msgConfig);
                                        oMsg.Alert();
                                    }*/


                               }
                           }
                       };
                       var oMsg = new SIMA.MessageBox(ConfigMsgb);
                       oMsg.confirm();
                       return false;
                       break;
               }

           }

           /****************************************************************************************************************/

           function ValidaSeguridadRI(oItemRowBE, msg) {
               if (UsuarioBE.IdUsuario == oItemRowBE.IdUsuarioRegistro) {
                   return true;
               }
               var msgConfig = { Titulo: "Alerta", Icono: "fa fa-smile-o", Descripcion: msg };
               var oMsg = new SIMA.MessageBox(msgConfig);
               oMsg.Alert();
               return false;
           }

           function OnEasyGridButton_Click(btnItem, DetalleBE) {
               var otxtTipoOp = jNet.get('txtTipoOp');

               switch (btnItem.Id) {
                   case "btnAgregarInspec":
                       otxtTipoOp.value = '1';
                       ListViewInspectore(DetalleBE.IdInspeccion, 1);
                       EasyPopupBuscarPersonal_EasyAcBuscarPersonal.Clear();
                       EasyPopupBuscarPersonal.Show();
                       break;
                   case "btnInspecPartcicipa":
                       if (ValidaSeguridadRI(DetalleBE, "Usuario no Autorizado para modificar el RI")) {
                           otxtTipoOp.value = '0';
                           ListViewInspectore(DetalleBE.IdInspeccion, 0);
                           EasyPopupBuscarPersonal.Show();
                       }
                       break;
                   case "btnResponsableArea":
                       if (ValidaSeguridadRI(DetalleBE, "Usuario no Autorizado para modificar el RI")) {
                           otxtTipoOp.value = '0';
                           AdministrarInspecion.TipoBusqueda(DetalleBE);
                       }
                       break;
                   case "btnAprobar":
                       if (ValidaSeguridadRI(DetalleBE, "Usuario no Autorizado para modificar el RI")) {
                           ShowVentanaFirmas(DetalleBE.IdInspeccion);
                       }
                       break;
                   case "btnSend":
                       if (ValidaSeguridadRI(DetalleBE, "Usuario no Autorizado para emitir RI seleccionado")) {
                           var urlPag = Page.Request.ApplicationPath + "/GestiondeCalidad/EnviarPorCorreo.aspx";
                           var oColletionParams = new SIMA.ParamCollections();
                           var oParam = new SIMA.Param(AdministrarInspecion.KEYIDINSPECCION, DetalleBE.IdInspeccion);
                           oColletionParams.Add(oParam);
                           oParam = new SIMA.Param(AdministrarInspecion.KEYNROFICHATECNICA, DetalleBE.NroReporte);
                           oColletionParams.Add(oParam);
                           oParam = new SIMA.Param(AdministrarInspecion.KEYQNOMBREPROY, DetalleBE.NombreProyecto);
                           oColletionParams.Add(oParam);
                           oParam = new SIMA.Param(AdministrarInspecion.KEYQRI_BLOQUEDO, DetalleBE.Bloqueado);
                           oColletionParams.Add(oParam);
                           EasyPopupEmailSend.Load(urlPag, oColletionParams, false);

                           /*AdministrarInspecion.VerificadAprobacionAll({IdInspeccion: DetalleBE.IdInspeccion, UserName: AdministrarInspecion.Params["UserName"] }, function () {
       
                           });*/
                       }
                       break;
                   case "btnResumenxArea":
                       var urlPag = Page.Request.ApplicationPath + "/GestiondeCalidad/ListaReporteIndicadores.aspx";
                       var oColletionParams = new SIMA.ParamCollections();
                       var oParam = new SIMA.Param(AdministrarInspecion.KEYIDINSPECCION, '0');
                       oColletionParams.Add(oParam);
                       EasyPopupIndicadores.Load(urlPag, oColletionParams, false);
                       break;
                   /* case "btnTblGeneral":
                        AdministrarInspecion.TablasApoyo.Show();
                        break;*/

               }
           }


           function ShowVentanaFirmas(IdInspeccion) {
               var Url = Page.Request.ApplicationPath + "/GestiondeCalidad/AdminstrarUsuariosFirmantes.aspx";
               var oColletionParams = new SIMA.ParamCollections();
               var oParam = new SIMA.Param(AdministrarInspecion.KEYIDINSPECCION, IdInspeccion);
               oColletionParams.Add(oParam);

               EasyPopupAprobacion.Load(Url, oColletionParams, false);
           }

           function ListViewReponsableArea_OnItemClick(Source, Target, oItemData) { }
           function ListViewResponsableArea(IdInspeccion) {
               var oListView = new SIMA.ListImgView();
               oListView.Ancho = "40px";
               oListView.Alto = "40px";
               oListView.Id = "lvRepArea";
               oListView.NroItemsView = 10;
               oListView.onItemClick = ListViewReponsableArea_OnItemClick;
               /*----------------------------------------------------------------------------------------------------*/
               var oEasyDataInterConect = new EasyDataInterConect();
               oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
               oEasyDataInterConect.UrlWebService = "/GestiondeCalidad/Proceso.asmx";
               oEasyDataInterConect.Metodo = "ListarReponsableArea";

               var oParamCollections = new SIMA.ParamCollections();
               var oParam = new SIMA.Param("IdInspeccion", IdInspeccion);
               oParamCollections.Add(oParam);

               oParam = new SIMA.Param("UserName", AdministrarInspecion.Params["UserName"]);
               oParamCollections.Add(oParam);
               oEasyDataInterConect.ParamsCollection = oParamCollections;

               var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
               var oDataTableUsr = oEasyDataResult.getDataTable();
               if (oDataTableUsr != null) {
                   oDataTableUsr.Rows.forEach(function (oDataRowComp, i) {
                       var DataBE = {
                           NroPersonal: oDataRowComp["IdPersonal"]
                           , NroDocDNI: oDataRowComp["NroDNI"]
                           , ApellidosyNombres: oDataRowComp["NombreResponsable"]
                       };
                       var oImgItem = new SIMA.ListItem(i, oDataRowComp["NombreResponsable"], oDataRowComp["IdPersonal"], AdministrarInspecion.PathFotosPersonal + oDataRowComp["NroDNI"] + '.jpg', DataBE);
                       oListView.ListItems.Add(oImgItem);

                   });

                   /*----------------------------------------------------------------------------------------------------*/
                   oListView.Render(jNet.get('lstReponsable'));//Se pinta el listview y su contenido 
               }
           }


           function ListViewInspectores_OnItemClick(Source, Target, oItemData) { }
           function ListViewInspectore(IdInspeccion, Principal) {
               var oListView = new SIMA.ListImgView();
               oListView.Ancho = "40px";
               oListView.Alto = "40px";
               oListView.Id = "lvInspectores";
               oListView.NroItemsView = 10;
               oListView.onItemClick = ListViewInspectores_OnItemClick;
               /*----------------------------------------------------------------------------------------------------*/
               var oEasyDataInterConect = new EasyDataInterConect();
               oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
               oEasyDataInterConect.UrlWebService = "/GestiondeCalidad/Proceso.asmx";
               oEasyDataInterConect.Metodo = "ListarInspectores";

               var oParamCollections = new SIMA.ParamCollections();
               var oParam = new SIMA.Param("IdInspeccion", IdInspeccion);
               oParamCollections.Add(oParam);

               oParam = new SIMA.Param("UserName", AdministrarInspecion.Params["UserName"]);
               oParamCollections.Add(oParam);
               oEasyDataInterConect.ParamsCollection = oParamCollections;

               var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
               var oDataTableUsr = oEasyDataResult.getDataTable();
               if (oDataTableUsr != null) {
                   oDataTableUsr.Rows.forEach(function (oDataRowComp, i) {
                       if (oDataRowComp["Principal"] == Principal) {
                           var DataBE = {
                               NroPersonal: oDataRowComp["IdPersonal"]
                               , NroDocDNI: oDataRowComp["NroDocIdentidad"]
                               , ApellidosyNombres: oDataRowComp["NombresInspector"]
                           };
                           var oImgItem = new SIMA.ListItem(i, oDataRowComp["NombresInspector"], oDataRowComp["IdPersonal"], AdministrarInspecion.PathFotosPersonal + oDataRowComp["NroDNI"] + '.jpg', DataBE);
                           oListView.ListItems.Add(oImgItem);
                       }
                   });
                   oListView.Render(jNet.get('lstInspectores'));//Se pinta el listview y su contenido 
               }
           }




           //Evento para El control Autocmpletar    
           function onItemSeleccionado(value, ItemBE) {
               // alert(value);
           }

           //Evento para el popup 
           function onItemSeleccionadoResponsable(value, ItemBE) {
               // alert(value);
           }


    </script>

    <script>

           //Implementacion para las aprobaciones

           function OnEasyGridAprobadores_Click(btnItem, DetalleBE) {
               switch (btnItem.Id) {
                   case "btnAgregar":

                       if (EasyAutocompletAct.GetText().length > 0) {
                           var NroFilIniClone = 3
                           var oRow = EasyGridViewActividades.RowClone(NroFilIniClone, function (Celda, index) {
                               if (index == 0) {
                                   if (jNet.get(Celda.parentNode).attr('TipoRow') != '4') {
                                       Celda.innerText = (EasyGridViewActividades.GetNroFila() - (NroFilIniClone - 1));
                                   }
                               }
                               else if (index == 1) {
                                   Celda.innerText = EasyAutocompletAct.GetText();
                               }
                           });

                           oRow.attr('TipoRow', '2');
                           oRow.attr('IdActividad', EasyAutocompletAct.GetValue());

                           EasyAutocompletAct.Clear();
                       }
                       else {
                           var msgConfig = { Titulo: "Administrar Actividad", Descripcion: "Error al intentar crear una actividad" };
                           var oMsg = new SIMA.MessageBox(msgConfig);
                           oMsg.Alert();
                       }
                       break;
                   case "btnEliminar":
                       EasyGridViewActividades.DeleteRowActive(true);
                       break;
               }
           }
        
    </script>




    <script>
        var Forms = {};
           Forms.ColletionError = {};
           Forms.ColletionError.Msgs = new Array();
           Forms.ColletionError.Msgs.Add = function (msg) {
               this[this.length] = new Array();
               this[this.length - 1] = msg;
           }


           function OnEasyGridInspecionesButton_Click(btnItem, DetalleBE) {

               EasyGridViewInspeciones.RowClone(3, function (Celda, index) {
                   var orow = jNet.get(Celda.parentNode);
                   orow.attr("Modo", "N");
                   var ctrl = Celda.children[0];

                   if (index == 0) {
                       $(Celda).empty();//Eliminar todos los controles o script que puedan estar en la celda

                       var date = new Date();
                       var FechaHoy = date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear();

                       $(Celda).append('<input id="new" class="form-control" type="input" value="' + FechaHoy + '"/>');
                       EasyDatepicker.Setting('new', 'dd/mm/yyyy');
                   }
               });


           }

           /*Para el autocmpletado de Gestor de filtros*/
           function onDisplayTemplateNroReporte(ul, item) {
               var cmll = "\"";
               iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                   + '<div class= "flex-column">' + item.NombreProyecto
                   + '    <p><small style="font-weight: bold">CLIENTE:</small> <small style ="color:red">' + item.ClienteRazonSocial + '</small><BR>'
                   + '    <small style="font-weight: bold">JEFE PROY:</small><small style="color:blue;text-transform: capitalize;">' + item.JefeProyecto + '</small><BR>'
                   + '    <small style="font-weight: bold">TIPO PROCESO:</small><small style="color:blue;text-transform: capitalize;">' + item.TipoProceso + '</small></p>'
                   + '    <span class="badge badge-info badge-pill"> ' + item.NroReporte + '</span>'
                   + '    <span class="badge badge-info "> ' + item.LineaNegocio + '</span>'
                   + '</div>'
                   + '<div class="image-parent">'
                   + '<img class=" rounded-circle" width="60px" src="' + AdministrarInspecion.PathFotosPersonal + item.NroDocIdentidad + '.jpg" alt="Jefe de proy:=' + item.JefeProyecto + '"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                   + '</div>'
                   + '</a>';

               var oCustomTemplateBE = new EasyGestorFiltro1_NroReporte.CustomTemplateBE(ul, item, iTemplate);

               return EasyGestorFiltro1_NroReporte.SetCustomTemplate(oCustomTemplateBE);


           }


           /*Para el autocmpletado de Gestor de filtros*/
           function onDisplayTemplatePersonal(ul, item) {
               var cmll = "\""; var iTemplate = null;
               if (AdministrarInspecion.TipoBusquedaPersonal == 1) {
                   iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                       + '<div class= "flex-column">' + item.ApellidosyNombres
                       + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red">' + item.NroPersonal + '</small>'
                       + '    <small style="font-weight: bold">AREA:</small><small style="color:blue;text-transform: capitalize;">' + item.NombreArea + '</small></p>'
                       + '    <span class="badge badge-info "> ' + item.Email + '</span>'
                       + '</div>'
                       + '<div class="image-parent">'
                       + '<img class=" rounded-circle" width="60px" src="' + AdministrarInspecion.PathFotosPersonal + item.NroDocIdentidad + '.jpg"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                       + '</div>'
                       + '</a>';
               } else {
                   iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                       + '<div class= "flex-column">' + item.ApellidosyNombres
                       + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red">' + item.NroDocIdentidad + '</small>'
                       + '</div>'
                       + '<div class="image-parent">'
                       + '<img class=" rounded-circle" width="60px" src="' + AdministrarInspecion.PathFotosPersonal + item.NroDocIdentidad + '.jpg"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                       + '</div>'
                       + '</a>';
               }
               var oCustomTemplateBE = new EasyPopupBuscarPersonal_EasyAcBuscarPersonal.CustomTemplateBE(ul, item, iTemplate);

               return EasyPopupBuscarPersonal_EasyAcBuscarPersonal.SetCustomTemplate(oCustomTemplateBE);


           }





           function RadioTemplate() {
               var MsgTemplate = 'Desea Ud. cambiar el estado del RI ahora?<br><br><table width="100%" align="left">'
               var oDataTable = new SIMA.Data.DataTable('tbl');
               oDataTable = SIMA.Utilitario.Helper.TablaGeneralItem(652, '-1');
               oDataTable.Rows.forEach(function (oDataRow) {
                   MsgTemplate += '<tr> <td align="Left"> <input id="' + oDataRow["CODIGO"] + '" type="radio" name="Estado"  onclick="javascript:IdEstadoSelecccionado  = ' + oDataRow["CODIGO"] + ';"/> <label for="' + oDataRow["CODIGO"] + '">' + oDataRow["Abrev"] + '</label></td> <td> <img  id="img' + oDataRow["CODIGO"] + '"  style="width:45px" src="' + oDataRow["VAR5"] + '"/> </td> </tr>';
               });
               MsgTemplate += '</table>';

               return MsgTemplate;
           }



           var IdEstadoSelecccionado = 0;
           var BinaryImg = null;
           function AdministraEstado(IdInspeccion, IdUsuarioInspector, oRowImg) {

               /*if (AdministrarInspecion.Params["IdUsuario"] != IdUsuarioInspector) {
                   var msgConfig = { Titulo: "Cambio de estado", Descripcion: 'Error al intentar cambiar el estado, Ud. no esta autorizado para realizar esta acción al reistro seleccionado'};
                   var oMsg = new SIMA.MessageBox(msgConfig);
                   oMsg.Alert(); return;
               }*/

               var ConfigMsgb = {
                   Titulo: 'CAMBIO DE ESTADO'
                   , Descripcion: RadioTemplate()
                   , Icono: 'fa fa-tag'
                   , EventHandle: function (btn) {
                       if (btn == 'OK') {
                           try {
                               var oDataRow = EasyGridView1.GetDataRow();
                               //Cambia de estado
                               var CadenadeConexion = Page.Request.ApplicationPath + "/GestiondeCalidad/Proceso.aspx";
                               var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
                               var oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYIDINSPECCION, IdInspeccion);
                               oParamCollections.Add(oParam);

                               oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYQIDESTADO, IdEstadoSelecccionado);
                               oParamCollections.Add(oParam);

                               oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYQIDPROCESO, Proceso.GestiondeCalidad.InspeccionCambioEstado);
                               oParamCollections.Add(oParam);

                               var OleDBCommand = new SIMA.Data.OleDB.Command();
                               OleDBCommand.CadenadeConexion = CadenadeConexion;

                               var obj = OleDBCommand.ExecuteNonQuery(oParamCollections);


                               oRowImg.src = jNet.get("img" + IdEstadoSelecccionado).src;

                               if (obj != undefined) {

                                   return true;
                               }
                           }
                           catch (SIMADataException) {
                               var msgConfig = { Titulo: "Error al intentar cambiar el estado", Descripcion: SIMADataException.Message };
                               var oMsg = new SIMA.MessageBox(msgConfig);
                               oMsg.Alert();
                           }


                       }
                   }
               };
               var oMsg = new SIMA.MessageBox(ConfigMsgb);
               oMsg.confirm();


           }


           function EasyPopupIndicadores_onAceptar() {
               //alert('indicadores');
               return true;
           }

    </script>


</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
        <asp:Button ID="ibtnAnclar" runat="server" Text="AnclarRpt" OnClick="ibtnAnclar_Click" />
        <table style="width: 100%;" border="0">
            <tr>
                <td>
                    <uc1:header runat="server" id="Header" idgestorfiltro="EasyGestorFiltro1" />
                </td>
            </tr>
            <tr>
                <td style="width: 100%; height: 100%">
                    <cc1:easygridview id="EasyGridView1" runat="server" autogeneratecolumns="False" showfooter="True" tituloheader="Gestion de Calidad" toolbarbuttonclick="OnEasyGridButton_Click" width="100%" allowpaging="True" onrowdatabound="EasyGridView1_RowDataBound" oneasygriddetalle_click="EasyGridView1_EasyGridDetalle_Click" onpageindexchanged="EasyGridView1_PageIndexChanged" oneasygridbutton_click="EasyGridView1_EasyGridButton_Click" pagesize="5" fncexecbeforeserver="AdministrarInspecion.fncExecBeforeServer">
                        <easygridbuttons>
                            <cc1:easygridbutton id="btnAgregar" descripcion="" icono="fa fa-plus-square-o" msgconfirm="" runatserver="True" texto="Agregar" ubicacion="Derecha" />
                            <cc1:easygridbutton id="btnInfoRel" descripcion="" icono="fa fa-newspaper-o" requiereselecciondereg="True" runatserver="True" solicitaconfirmar="False" texto="Informe Relacionado" ubicacion="Derecha" />
                            <cc1:easygridbutton id="btnEliminar" descripcion="" icono="fa fa-close" msgconfirm="Desea Eliminar este registro" requiereselecciondereg="true" solicitaconfirmar="true" runatserver="True" texto="Eliminar" ubicacion="Derecha" />
                            <cc1:easygridbutton id="btnInspecPartcicipa" descripcion="" icono="fa fa-users" msgconfirm="" requiereselecciondereg="True" runatserver="False" solicitaconfirmar="False" texto="Inpector Participante" ubicacion="Centro" />
                            <cc1:easygridbutton id="btnResponsableArea" descripcion="" icono="fa fa-user-secret" msgconfirm="" requiereselecciondereg="true" runatserver="False" solicitaconfirmar="False" texto="Responsable" ubicacion="Centro" />
                            <cc1:easygridbutton id="btnAprobar" descripcion="Aprueba con la firma" icono="fa fa-check-circle-o" msgconfirm="" requiereselecciondereg="true" runatserver="False" solicitaconfirmar="False" texto="Aprobadores" ubicacion="Centro" />
                            <cc1:easygridbutton id="btnImprimir" descripcion="Vista previa Ficha Inspección" icono="fa fa-print" msgconfirm="" requiereselecciondereg="True" runatserver="True" solicitaconfirmar="False" texto="" ubicacion="Footer" />
                            <cc1:easygridbutton id="btnSend" descripcion="Enviar por correo ficha de inspección" icono="fa fa-envelope-o" msgconfirm="" requiereselecciondereg="True" runatserver="False" solicitaconfirmar="False" texto="" ubicacion="Footer" />
                            <cc1:easygridbutton id="btnResumenxArea" texto="" descripcion="" icono="fa fa-bar-chart" runatserver="False" requiereselecciondereg="False" solicitaconfirmar="False" msgconfirm="" ubicacion="Footer"></cc1:easygridbutton>
                        </easygridbuttons>

                        <easystylebtn classname="btn btn-primary" fontsize="1em" textcolor="white" />
                        <datainterconect metodoconexion="WebServiceInterno">
                            <urlwebservice>/GestiondeCalidad/Proceso.asmx</urlwebservice>
                            <metodo>TreeListarInspeciones</metodo>
                            <urlwebservicieparams>
                                <cc2:easyfiltroparamurlws obtenervalor="Fijo" paramname="IdInspeccion" paramvalue="0" tipodedato="String" />
                                <cc2:easyfiltroparamurlws obtenervalor="Fijo" paramname="IdUsuario" paramvalue="1" tipodedato="Int" />
                                <cc2:easyfiltroparamurlws obtenervalor="Fijo" paramname="UserName" paramvalue="UserName" tipodedato="String" />
                            </urlwebservicieparams>
                        </datainterconect>

                        <easyextended itemcolormousemove="#CDE6F7" itemcolorseleccionado="#ffcc66" rowitemclick="" rowcellitemclick="" idgestorfiltro="EasyGestorFiltro1"></easyextended>

                        <easyrowgroup groupeddepth="0" colinirowmerge="0"></easyrowgroup>

                        <alternatingrowstyle cssclass="AlternateItemGrilla" />

                        <columns>
                            <asp:BoundField DataField="NroReporte" HeaderText="N° REPORTE" />
                            <asp:BoundField DataField="Fecha" HeaderText="FECHA DE INSPECCION" SortExpression="Fecha" DataFormatString="{0:dd/MM/yyyy}">
                                <itemstyle horizontalalign="Center" width="4%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TipoInspeccion" HeaderText="TIPO DE INSPECCION" SortExpression="TipoInspeccion">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NombreProyecto" HeaderText="PROYECTO / CLIENTE" SortExpression="NombreProyecto">
                                <itemstyle horizontalalign="Left" verticalalign="Top" wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Descripcion" HeaderText="DESCRIPCION">
                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="30%" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="INSPECTOR(PRINCIPAL/PARTICIPANTES)" />
                            <asp:BoundField HeaderText="PERSONAL ENCARGADO" />
                            <asp:BoundField DataField="TipoProceso" HeaderText="PROCESO CONTRUCTIVO" SortExpression="TipoProceso">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TipoSIstema" HeaderText="SISTEMA /  MODULO  /ZONA /PRUEBAS" SortExpression="TipoSIstema">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Estado"></asp:TemplateField>
                        </columns>

                        <headerstyle cssclass="HeaderGrilla" />
                        <pagerstyle horizontalalign="Center" />
                        <rowstyle cssclass="ItemGrilla" height="25px" />

                    </cc1:easygridview>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/GestionReportes/AdministrarReporte.aspx" ForeColor="White">HyperLink</asp:HyperLink>
                    <cc3:easytextbox id="EasytxtTipoTrabajador" runat="server"></cc3:easytextbox>
                </td>
            </tr>
        </table>

        <cc2:easygestorfiltro id="EasyGestorFiltro1" runat="server" classheader="HeaderGrilla" titulo="GESTION DE FILTROS-INSPECCION" classitem="ItemGrilla" classitemalternating="AlternateItemGrilla" easyfiltrocampos-capacity="8" displaybuttoninterface="false" onprocesscompleted="EasyGestorFiltro1_ProcessCompleted" onitemcriterio="EasyGestorFiltro1_ItemCriterio">
            <cc2:easyfiltrocampo descripcion="Proyecto" nombre="NroReporte">
                <datainterconect metodoconexion="WebServiceInterno">
                    <urlwebservice>/GestiondeCalidad/Proceso.asmx</urlwebservice>
                    <metodo>BuscarProyInspec</metodo>
                    <urlwebservicieparams>
                        <cc2:easyfiltroparamurlws paramname="UserName" paramvalue="UserName" obtenervalor="Session" />
                    </urlwebservicieparams>
                </datainterconect>
                <easycontrolasociado templatetype="EasyITemplateAutoCompletar" nrocarini="0" textfield="NombreProyecto" valuefield="NroReporte" fnctempalecustom="onDisplayTemplateNroReporte" />
            </cc2:easyfiltrocampo>
            <cc2:easyfiltrocampo descripcion="Fecha de Inspección" nombre="FechaReal" tipodedato="Date">
                <datainterconect metodoconexion="WebServiceInterno"></datainterconect>
                <easycontrolasociado templatetype="EasyITemplateDatepicker" formatoutput="yyyymmdd" formatinput="dd/mm/yyyy" />

            </cc2:easyfiltrocampo>
            <cc2:easyfiltrocampo descripcion="Razon Social Cliente" nombre="IdCliente" tipodedato="String">
                <datainterconect metodoconexion="WebServiceInterno">
                    <urlwebservice>/GestiondeCalidad/Proceso.asmx</urlwebservice>
                    <metodo>BuscarProyectoXCliente</metodo>
                    <urlwebservicieparams>
                        <cc2:easyfiltroparamurlws paramname="UserName" paramvalue="UserName" obtenervalor="Session" />
                    </urlwebservicieparams>
                </datainterconect>
                <easycontrolasociado nrocarini="4" templatetype="EasyITemplateAutoCompletar" textfield="RazonSocialCliente" valuefield="IdCliente" />
            </cc2:easyfiltrocampo>

            <cc2:easyfiltrocampo descripcion="Taller o Contratista" nombre="IdEntidad" tipodedato="String">
                <datainterconect metodoconexion="WebServiceInterno">
                    <urlwebservice>/GestiondeCalidad/Proceso.asmx</urlwebservice>
                    <metodo>BuscarAreaEntidad_Inspeccion</metodo>
                    <urlwebservicieparams>
                        <cc2:easyfiltroparamurlws paramname="UserName" paramvalue="UserName" obtenervalor="Session" />
                    </urlwebservicieparams>
                </datainterconect>
                <easycontrolasociado nrocarini="4" templatetype="EasyITemplateAutoCompletar" textfield="TalleoContratista" valuefield="IdEntidad" />
            </cc2:easyfiltrocampo>

            <cc2:easyfiltrocampo descripcion="Estado de Inspeccion" nombre="IdEstado" tipodedato="Int">
                <datainterconect metodoconexion="WebServiceInterno">
                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                    <metodo>ListarItems</metodo>
                    <urlwebservicieparams>
                        <cc2:easyfiltroparamurlws obtenervalor="Fijo" paramname="IdTabla" paramvalue="652" tipodedato="String" />
                        <cc2:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" tipodedato="String" />
                    </urlwebservicieparams>
                </datainterconect>

                <easycontrolasociado templatetype="EasyITemplateDropdownList" textfield="Descripcion" valuefield="Codigo" />
            </cc2:easyfiltrocampo>


            <cc2:easyfiltrocampo descripcion="Tipo de Inspeccion" nombre="IdTipoInspeccion" tipodedato="Int">
                <datainterconect metodoconexion="WebServiceInterno">
                    <urlwebservice>/General/TablasGenerales.asmx</urlwebservice>
                    <metodo>ListarItems</metodo>
                    <urlwebservicieparams>
                        <cc2:easyfiltroparamurlws obtenervalor="Fijo" paramname="IdTabla" paramvalue="653" tipodedato="String" />
                        <cc2:easyfiltroparamurlws obtenervalor="Session" paramname="UserName" paramvalue="UserName" tipodedato="String" />
                    </urlwebservicieparams>
                </datainterconect>

                <easycontrolasociado templatetype="EasyITemplateDropdownList" textfield="Descripcion" valuefield="Codigo" />
            </cc2:easyfiltrocampo>

            <cc2:easyfiltrocampo descripcion="Inspector " nombre="IdUsuarioRegistro">
                <datainterconect metodoconexion="WebServiceInterno">
                    <urlwebservice>/GestiondeCalidad/Proceso.asmx</urlwebservice>
                    <metodo>BuscarAprobadores</metodo>
                    <urlwebservicieparams>
                        <cc2:easyfiltroparamurlws paramname="UserName" paramvalue="UserName" obtenervalor="Session" />
                    </urlwebservicieparams>
                </datainterconect>
                <easycontrolasociado templatetype="EasyITemplateAutoCompletar" nrocarini="0" textfield="ApellidosyNombres" valuefield="idUsuario" fnctempalecustom="AdministrarInspecion.ItemplateAprobador" />
            </cc2:easyfiltrocampo>

        </cc2:easygestorfiltro>



        <cc3:easypopupbase id="EasyPopupBuscarPersonal" runat="server" titulo="Agregar Inspector Principal / Secundario" runatserver="true" displaybuttons="true" onclick="EasyPopupBase1_onClick">
            <table style="width: 100%">
                <tr>
                    <td style="width: 100%">
                        <cc3:easyautocompletar id="EasyAcBuscarPersonal" runat="server" nrocarini="4" displaytext="ApellidosyNombres" valuefield="IdPersonal" fnonselected="onItemSeleccionado" fnctempalecustom="onDisplayTemplatePersonal">
                            <easystyle ancho="Dos"></easystyle>
                            <datainterconect metodoconexion="WebServiceInterno">
                                <urlwebservice>/RecursosHumanos/Personal.asmx</urlwebservice>
                                <metodo>BuscarPersona</metodo>
                                <urlwebservicieparams>
                                    <cc2:easyfiltroparamurlws paramname="PSima" paramvalue="1" obtenervalor="Fijo" tipodedato="Int" />
                                    <cc2:easyfiltroparamurlws paramname="UserName" paramvalue="UserName" obtenervalor="Session" />
                                </urlwebservicieparams>
                            </datainterconect>
                        </cc3:easyautocompletar>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 35px; padding-left: 10px;" id="lstInspectores"></td>
                </tr>
            </table>
        </cc3:easypopupbase>




        <cc3:easypopupbase id="EasyPopupBase2" runat="server" titulo="Agregar Responable" runatserver="true" displaybuttons="true" onclick="EasyPopupBase2_Click">
            <table style="width: 100%">
                <tr>
                    <td style="width: 100%">
                        <cc3:easyautocompletar id="EasyAutocompletar2" runat="server" nrocarini="4" displaytext="ApellidosyNombres" valuefield="IdPersonal" fnonselected="onItemSeleccionadoResponsable" fnctempalecustom="onDisplayTemplatePersonal">
                            <easystyle ancho="Dos"></easystyle>
                            <datainterconect metodoconexion="WebServiceInterno">
                                <urlwebservice>/RecursosHumanos/Personal.asmx</urlwebservice>
                                <metodo>BuscarPersona</metodo>
                                <urlwebservicieparams>
                                    <cc2:easyfiltroparamurlws paramname="PSima" paramvalue="AdministrarInspecion.BuscarPersonalPorTipo()" obtenervalor="FunctionScript" tipodedato="Int" />
                                    <cc2:easyfiltroparamurlws paramname="UserName" paramvalue="UserName" obtenervalor="Session" />
                                </urlwebservicieparams>
                            </datainterconect>
                        </cc3:easyautocompletar>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 35px; padding-left: 10px;" id="lstReponsable"></td>
                </tr>

            </table>

        </cc3:easypopupbase>


        <cc3:easypopupbase id="EasyPopupAprobacion" runat="server" modal="fullscreen" modocontenedor="LoadPage" titulo="Asignar Reponsable de aprobación" runatserver="false" displaybuttons="true" fncscriptaceptar="AdminstrarUsuariosFirmantes.onPopupAceptar">
        </cc3:easypopupbase>

        <cc3:easypopupbase id="EasyPopupEmailSend" runat="server" modal="fullscreen" modocontenedor="LoadPage" titulo="Enviar Adjunto" runatserver="true" displaybuttons="true" fncscriptaceptar="EasyPopupEnviaCorreo_onAceptar" onclick="EasyPopupEmailSend_Click">
        </cc3:easypopupbase>

        <cc3:easypopupbase id="EasyPopupDetalleRespArea" runat="server" modal="fullscreen" modocontenedor="LoadPage" titulo="Respuesta Responsable de área" runatserver="true" displaybuttons="true" fncscriptaceptar="function(){}" onclick="EasyPopupEmailSend_Click">
        </cc3:easypopupbase>

        <cc3:easypopupbase id="EasyPopupIndicadores" runat="server" modal="fullscreen" modocontenedor="LoadPage" titulo="Reporte de Indicadores" runatserver="false" displaybuttons="true" fncscriptaceptar="EasyPopupIndicadores_onAceptar">
        </cc3:easypopupbase>

        <cc3:easypopupbase id="EasyPopupTablaItems" runat="server" modal="fullscreen" modocontenedor="LoadPage" titulo="Lista de Items" runatserver="false" displaybuttons="true" fncscriptaceptar="AdministrarTblGeneraltems.onAceptar">
        </cc3:easypopupbase>


        <cc3:easycontextmenu id="EasyContextEquipo" runat="server" lstclass=".context-area,.btn-context,.context-link,.ms-n2" width="45px" fncmnuitem_onclick="onPopupMenuClick">
            <easymnubuttons>
                <cc3:easybuttonmenucontext id="mnuOpen" descripcion="" icono="fa fa-list-alt" runatserver="False" texto="Detalle de Información" />
                <cc3:easybuttonmenucontext id="mnuEliminar" descripcion="" icono="fa fa-window-close-o" runatserver="False" texto="Eliminar" />
            </easymnubuttons>
        </cc3:easycontextmenu>


        <asp:TextBox ID="txtTipoOp" runat="server" Width="61px"></asp:TextBox>
        <asp:TextBox ID="TxtUserName" runat="server" Width="61px">1</asp:TextBox>


        <asp:TextBox ID="lstParaEmail" runat="server"></asp:TextBox>
        <asp:TextBox ID="txtNomFileAdjunto" runat="server"></asp:TextBox>
        <asp:TextBox ID="txtAsunto" runat="server"></asp:TextBox>



        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/HelpDesk/Sistemas/Administrar.aspx?IdAct=2024-1">HyperLink</asp:HyperLink>

        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/HelpDesk/Requerimiento/AdministrarRequerimiento.aspx" BackColor="#FFFF99">nuevo</asp:HyperLink>

        <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/HelpDesk/ITIL/BaseServioAreaDisponibles.aspx?IdContact=5">test</asp:HyperLink>
    </form>







    <script>
    function MiTemplate() {
               return '<p class="notification-text">'
                   + '<strong>FRamirez</strong>, <strong>Aprobado con observaciones</strong> por favor verificar las imagenes con corresponden<strong>reunion inmediata</strong>'
                   + '</p>'
                   + '<span class="notification-timer">hace unos segundos</span>';
           }

           SIMA.Notificacion = function (oStruct) {
               this.show = function () {
                   document.body.appendChild(Base());
                   window.setTimeout(function () {
                       var Sonido = new Audio('http://localhost:7001/Archivos/Sound/msg.wav');
                       Sonido.load();
                       Sonido.play();
                   }, 2000);
               }

               function Base() {
                   var _wNotify = jNet.create("div");
                   _wNotify.attr("Id", oStruct.Id);
                   _wNotify.attr("class", "notify");
                   _wNotify.insert(Header("Nueva Notificación"));//Crea la cabecera
                   _wNotify.insert(Body());//Crea el cuerpo
                   return _wNotify;
               }
               /*---------CABECERA----------------------------*/
               function Header(Titulo) {
                   var _wNotifyHeader = jNet.create("div");
                   _wNotifyHeader.attr("class", "notification-header");
                   var _Title = jNet.create("h3");
                   _Title.attr("class", "notification-title");
                   _Title.innerText = oStruct.Titulo;

                   var _Close = jNet.create("div");
                   _Close.attr("class", "notification-title");

                   var _i = jNet.create("i");
                   _i.attr("class", "fa fa-times");
                   _i.attr("IdNotify", oStruct.Id);
                   _i.addEvent("click", function () {
                       var idNotify = jNet.get(this).attr("IdNotify");
                       var Notify = jNet.get(idNotify);
                       Notify.attr("class", "HiddeNotify");
                       (new Audio(Page.Request.ApplicationPath + '/Archivos/Sound/chimes.wav')).play();
                       oStruct.onClose('eddy in');
                   });
                   _Close.insert(_i);

                   _wNotifyHeader.insert(_Title);
                   _wNotifyHeader.insert(_Close);
                   return _wNotifyHeader;
               }

               function Body() {
                   var nBody = jNet.create("div");
                   nBody.attr("class", "notification-container");
                   nBody.insert(NotifyMedia());
                   nBody.insert(NotifyContent());
                   return nBody;
               }

               function NotifyMedia() {
                   var _Media = jNet.create("div");
                   _Media.attr("class", "notification-media");
                   var _Img = jNet.create("img");
                   _Img.attr("src", oStruct.ImgMedia).attr("class", "notification-user-avatar");

                   var _reaction = jNet.create("div");
                   _reaction.attr("class", "notification-reaction");
                   var _i = jNet.create("i");
                   _i.attr("class", "fa fa-thumbs-up");
                   _reaction.insert(_i);

                   _Media.insert(_Img);
                   _Media.insert(_reaction);
                   return _Media;
               }

               function NotifyContent() {
                   var statusColor = "position: absolute;right: 15px;top: 50%;transform: translateY(-50%); width: 15px;height: 15px;border-radius: 50 %;background-color: red;";
                   var HtmlStatus = '<span style="' + statusColor + '"></span>';

                   var _NContent = jNet.create("div");
                   _NContent.attr("class", "notification-content");
                   _NContent.innerHTML = oStruct.iTemplate;

                   var _span = jNet.create('span');
                   _span.attr("class", "notification-status");
                   _NContent.insert(_span);

                   return _NContent;
               }


           }

           window.setTimeout(function () {
               var oStruct = { Id: "NNota", Titulo: "nuevo Mensaje", ImgMedia: "http://10.10.90.13/fotopersonal/18018828.jpg", iTemplate: MiTemplate(), onClose: function (msg) { alert(msg); }, IdEstado: 0 };
               var oNotificacion = new SIMA.Notificacion(oStruct);
               oNotificacion.show();
           }, 2000);



           function Cerrar(e) {
               alert('cerrado');
           }
    </script>




</body>
<script>


       AdministrarInspecion.ItemplateAprobador = function (ul, item) {
           var cmll = "\""; var iTemplate = null;
           var ImgFirma = AdministrarInspecion.PathImagenFirmas + item.Firma;
           var ItemUser = '<table style="width:100%">'
               + ' <tr>'
               + '     <td rowspan="3" align="center" style="width:5%"><img class=" rounded-circle" width = "60px" src = "' + AdministrarInspecion.PathFotosPersonal + item.NroDocIdentidad + '.jpg"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
               + '     <td class="Etiqueta" style="font-size: 14px;width:75%">' + item.ApellidosyNombres + '</td>'
               + '     <td rowspan="3" align="center" style="width:40%"><img width = "80px" height="50px" src = "' + ImgFirma + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSFNormal;"></td>'
               + ' </tr>'
               + ' <tr>'
               + '    <td style="font-size: 10px;color:gray;">' + item.NombreArea + '</td>'
               + ' </tr>'
               + ' <tr>'
               + '     <td  style="font-weight: bold; font-size: 12px;color:gray; font-style: italic;">' + item.Email + '</td>'
               + '</tr>'
               + '</table>';

           iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
               + ItemUser
               + '</a>';

           var oCustomTemplateBE = new EasyGestorFiltro1_IdUsuarioRegistro.CustomTemplateBE(ul, item, iTemplate);

           return EasyGestorFiltro1_IdUsuarioRegistro.SetCustomTemplate(oCustomTemplateBE);
       }






       function onPopupMenuClick(btn) {
           switch (btn.Id) {
               case "mnuEliminar":
                   if (ListItemActivo.Target.toString().indexOf('LsvInspectores') != -1) {
                       ListViewInspector_ItemClick("Open", ListItemActivo.Origen, ListItemActivo.Item);
                   }
                   else {
                       ListViewResponsables_ItemClick("Delete", ListItemActivo.Origen, ListItemActivo.Item);
                   }
                   break;
               default:
                   ListViewResponsables_ItemClick("Open", ListItemActivo.Origen, ListItemActivo.Item);
                   break;
           }
       }

       AdministrarInspecion.iTemplateTipoBusqueda = function () {
           var MsgTemplate = 'Seleccionar Tipo de Busqueda?<br><br><table width="100%" align="left">'
           MsgTemplate += '<tr> <td align="Left"> <input id="t1" type="radio" name="Estado"  onclick="javascript:AdministrarInspecion.TipoBusquedaPersonal = 1;"/><label for="t1">  Personal SIMA </label> </td></tr>';
           MsgTemplate += '<tr> <td align="Left"> <input id="t2" type="radio" name="Estado"  onclick="javascript:AdministrarInspecion.TipoBusquedaPersonal = 2;"/><label for="t2">  Personal CONTRATISTA </label> </td></tr>';
           MsgTemplate += '</table>';
           return MsgTemplate;
       }

       AdministrarInspecion.TipoBusqueda = function (oDetalleBE) {
           oDetalleBE.IdInspeccion
           ListViewResponsableArea(oDetalleBE.IdInspeccion);
           EasyPopupBase2_EasyAutocompletar2.Clear();
           AdministrarInspecion.TipoBusquedaPersonal = ((oDetalleBE.IdOrigen == 3) ? 1 : 2);
           EasyPopupBase2.Titulo = ((AdministrarInspecion.TipoBusquedaPersonal == 1) ? 'RESPONSABLE SIMA' : 'RESPONSABLE CONTRATISTA');
           EasyPopupBase2.Show();
       }


       AdministrarInspecion.TipoBusquedaPersonal = 0;
       AdministrarInspecion.BuscarPersonalPorTipo = function () {
           EasytxtTipoTrabajador.SetValue(AdministrarInspecion.TipoBusquedaPersonal);
           return AdministrarInspecion.TipoBusquedaPersonal;
       }

       AdministrarInspecion.fncExecBeforeServer = function (btnItem, ItemRowBE) {
           switch (btnItem.Id) {
               case "btnImprimir":
                   /*if (UsuarioBE.IdUsuario == ItemRowBE.IdUsuarioRegistro) {
                       return true;
                   }
                       var msgConfig = { Titulo: "Alerta", Icono: "fa fa-smile-o", Descripcion: "Usuario no Autorizado para emitir esta RI" };
                       var oMsg = new SIMA.MessageBox(msgConfig);
                       oMsg.Alert();
                   return false;*/
                   return ValidaRIInServer(ItemRowBE, "Usuario no Autorizado para emitir esta RI", function () { return true; });

                   // return AdministrarInspecion.VerificadAprobacionAll({ IdInspeccion: ItemRowBE.IdInspeccion, UserName: AdministrarInspecion.Params["UserName"] }, function () { return true; });
                   break;
               case "btnInfoRel":
                   return ValidaRIInServer(ItemRowBE, "Usuario No Autorizado para relacionar un RI nuevo con uno existente de otro Inspector", function () { return true; });
                   break;
               default:
                   return true;//Permite la ejecuicion de los otros botones del lado del servidor 

           }
       }

       function ValidaRIInServer(oItemRowBE, msg, fncExecute) {
           if (UsuarioBE.IdUsuario == oItemRowBE.IdUsuarioRegistro) {
               return fncExecute();
           }
           else {

               var msgConfig = { Titulo: "Alerta", Icono: "fa fa-smile-o", Descripcion: msg };
               var oMsg = new SIMA.MessageBox(msgConfig);
               oMsg.Alert();
           }
           return false;
       }

       AdministrarInspecion.VerificadAprobacionAll = function (RIBE, fncExecute) {
           var NroAprobados = 0;
           var oEasyDataInterConect = new EasyDataInterConect();
           oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
           oEasyDataInterConect.UrlWebService = ConnectService.ControlInspeccionesSoapClient;
           oEasyDataInterConect.Metodo = "ListarUsuariosFirmantes";

           var oParamCollections = new SIMA.ParamCollections();
           var oParam = new SIMA.Param("IdInspeccion", RIBE.IdInspeccion);
           oParamCollections.Add(oParam);
           oParam = new SIMA.Param("IdUsuarioFirmante", "0");
           oParamCollections.Add(oParam);
           oParam = new SIMA.Param("UserName", RIBE.UserName); //AdministrarInspecion.Params["UserName"]
           oParamCollections.Add(oParam);

           oEasyDataInterConect.ParamsCollection = oParamCollections;

           var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
           var oDataTable = oEasyDataResult.getDataTable();
           if (oDataTable != null) {
               oDataTable.Rows.forEach(function (oDR, i) {
                   if (oDR["IdEstado"].toString().Equal("3")) {
                       NroAprobados++;
                   }
               });
           }
           if (NroAprobados.toString().Equal("3")) {
               return fncExecute();
           }
           else {
               var msgConfig = { Titulo: "Alerta", Icono: "fa fa-smile-o", Descripcion: "Reporte no cumple con el Nro de APROBACIONES Necesarias para su emisión" };
               var oMsg = new SIMA.MessageBox(msgConfig);
               oMsg.Alert();
           }
           return false;
       }

</script>

<script>
        

       $(document).ready(function () {
           //https://www.programaresfacil.co/codigos-de-teclado-keycode/
           var arrKeys = new Array();
           SIMA.Utilitario.Helper.TablaGeneralApoyo(695).Rows.forEach(function (oDataRow, f) {
               arrKeys.Add({ Key: oDataRow["VAR1"], Value: oDataRow["VAR2"], IdTabla: oDataRow["CODIGO"], NOMBRE: oDataRow["NOMBRE"], Objeto: oDataRow["VAR3"] });
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
                               var oParam = new SIMA.Param(AdministrarInspecion.KEYQIDTABLAGENERAL, Itemkey.IdTabla);
                               oColletionParams.Add(oParam);
                               oParam = new SIMA.Param(AdministrarInspecion.KEYQDESCRIPCION, Itemkey.NOMBRE);
                               oColletionParams.Add(oParam);
                               oParam = new SIMA.Param(AdministrarInspecion.KEYQQUIENLLAMA, "AdministrarInspecion");
                               oColletionParams.Add(oParam);
                               EasyPopupTablaItems.Load(urlPag, oColletionParams, false);

                               event.preventDefault();
                               break;

                       }

                   }
               });
           });

       });
</script>

<script>

         /* function connect() {
              var loc = window.location, new_uri;
              if (loc.protocol === "https:") {
                  new_uri = "wss:";
              } else {
                  new_uri = "ws:";
              }
              new_uri += "//" + loc.host;
              new_uri += loc.pathname + "/to/ws";

              ws.onopen = function () {
                  alert("About to send data");
                  ws.send("Hello World"); // I WANT TO SEND THIS MESSAGE TO THE SERVER!!!!!!!!
                  alert("Message sent!");
              };

              ws.onmessage = function (evt) {
                  alert("About to receive data");
                  var received_msg = evt.data;
                  alert("Message received = " + received_msg);
              };
              ws.onclose = function () {
                  // websocket is closed.
                  alert("Connection is closed...");
              };
          }*/

           /*  var socket = new WebSocket('ws://localhost:8080/websession');
              socket.onopen = function() {
                  // alert('handshake successfully established. May send data now...');
                  socket.send("Hi there from browser.");
                };
                      socket.onmessage = function (evt) {
                        //alert("About to receive data");
                        var received_msg = evt.data;
                      alert("Message received = "+received_msg);
                    };
                      socket.onclose = function() {
                          alert('connection closed');
                };*/

</script>
</html>
