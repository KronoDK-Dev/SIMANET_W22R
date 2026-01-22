<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportParams.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.ReportParams" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Controls" tagprefix="cc2" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Filtro" tagprefix="cc3" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <script>
       
        function ParamReportBE(_Nombre, _Valor, _FiltroText, _FiltroValor, _TipoDato, _Orden) {
            this.Nombre = _Nombre;
            this.Valor = _Valor;
            this.FiltroText = _FiltroText;
            this.FiltroValor = _FiltroValor;
            this.TipoDato = _TipoDato;
            this.Orden = _Orden;
        }

        var ColletionParamsReport = new Array();
        var ColletionParamsReportClone = new Array();
        var ParamBE = null;
        var Cargado = false;

        //----------- se agrega TRUE A Manager.Task.Excecute ----
        function EasyPopupReportParam_Aceptar() {

            SIMA.Utilitario.Helper.Wait('Procesando...Reporte', 100, function () { });
            var ExpXLS = jNet.get('chkExpXLS');

      if (Cargado == false) { LoadArray(); Cargado = true; }

            var objParams = "";
              ColletionParamsReport.forEach(function (item, i) {
                ColletionParamsReportClone[item.Orden] = item;
            });

            ColletionParamsReportClone.forEach(function (item, i) {

                objParams += ((i == 0) ? '' : '@') + '{' + item.Nombre + ':' + item.Valor + ',FiltroText:' + item.FiltroText + ',FiltroValor:' + item.FiltroValor + ',TipoDato:' + item.TipoDato + '}';

            });

            var FrmDataBits = new FormData();
            FrmDataBits.append('IdReporte', ReportParams.Params[ReportParams.KEYQIDOBJETO]);
            FrmDataBits.append('UserName', ReportParams.Params["UserName"]);
            FrmDataBits.append('oEasyFiltroParamURLws', objParams);
            FrmDataBits.append('UrlApp', Page.Request.ApplicationPath);

            // FrmDataBits.append('ExpXls', ExpXLS.checked);
            /*if (ReportParams.Params[ReportParams.KEYQQUIENLLAMA].toString().Equal("AdministrarReporte")) {
                ReportParams.Data.Tree.Show(objParams);
              }
            return;*/

            var ajax = new XMLHttpRequest();
            ajax.addEventListener('load', function (event) {
                var ResultReportBE = null;
                eval('ResultReportBE=' + event.target.responseText);
                if (ResultReportBE.Estado == 'OK') {//Agrega el archivo creado a la lista de archivos  panel derecho
                    var srtPath = ResultReportBE.PathFile.toString().Replace(SIMA.Utilitario.Constantes.Caracter.Slash, "@").Replace(":", "|");
                    switch (ReportParams.Params[ReportParams.KEYQQUIENLLAMA]) {
                        case "AdministrarReporte":
                            Manager.Task.Excecute(function () {
                                var oParamColletions = new EasyPrevioRpt.ParamCollection();
                                var oParam = new EasyPrevioRpt.Param("rptNamePath", srtPath);
                                oParamColletions.Add(oParam);
                                EasyPrevioRpt.Load(Page.Request.ApplicationPath + "/GestionReportes/RptPrevioInPopup.aspx?", oParamColletions, false);
                                SIMA.Utilitario.Helper.Wait.Close(0);
                                EasyPopupTestReportParam.Close();
                            }, 500, true);
                            break;

                        case "ReportExploreV2":
                            Manager.Task.Excecute(function () {
                                ReportExploreV2.VistaPrevia(ResultReportBE.PathFile.toString());
                                SIMA.Utilitario.Helper.Wait.Close(0);
                                EasyPopupTestReportParam.Close();
                            }, 500, true);
                            break;
                    }

                }

                else {

                    SIMA.Utilitario.Helper.Wait.Close(0);
                    var msgConfig = { Titulo: ResultReportBE.PathFile, Descripcion: ResultReportBE.Descripcion };
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                }
            }
                , false);

            ajax.addEventListener('error', function (event) {
                SIMA.Utilitario.Helper.Wait.Close(0);
                var msgConfig = { Titulo: 'Proceso de Carga', Descripcion: 'Problemas a realizar la carga, es muy probable que el archivo sea demasiado grande' };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();

            }
                , false);


            //Llamar al popopespera

            ajax.open('POST', Page.Request.ApplicationPath + '/GestionReportes/GenerarPdf.aspx', false);
            ajax.send(FrmDataBits);



        }

        /*  SE MODIFICA 19.02.2025
        function EasyPopupReportParam_Aceptar() {
            var ExpXLS = jNet.get('chkExpXLS');

            if (Cargado == false) { LoadArray(); Cargado = true; }
            var objParams = "";
            ColletionParamsReport.forEach(function (item, i) {
                ColletionParamsReportClone[item.Orden] = item;
            });
            ColletionParamsReportClone.forEach(function (item, i) {
                objParams += ((i == 0) ? '' : '@') + '{' + item.Nombre + ':' + item.Valor + ',FiltroText:' + item.FiltroText + ',FiltroValor:' + item.FiltroValor + ',TipoDato:' + item.TipoDato + '}';
            });

            var FrmDataBits = new FormData();
            FrmDataBits.append('IdReporte', ReportParams.Params[ReportParams.KEYQIDOBJETO]);
            FrmDataBits.append('UserName', ReportParams.Params["UserName"]);
            FrmDataBits.append('oEasyFiltroParamURLws', objParams);
            FrmDataBits.append('UrlApp', Page.Request.ApplicationPath);          
           // FrmDataBits.append('ExpXls', ExpXLS.checked);

            /*if (ReportParams.Params[ReportParams.KEYQQUIENLLAMA].toString().Equal("AdministrarReporte")) {
                ReportParams.Data.Tree.Show(objParams);
            }
            return;*/
          /*  
            var ajax = new XMLHttpRequest();
            ajax.addEventListener('load', function (event) {
                    var ResultReportBE = null;
                    eval('ResultReportBE=' + event.target.responseText);

                if (ResultReportBE.Estado == 'OK') {//Agrega el archivo creado a la lista de archivos  panel derecho
                        var srtPath = ResultReportBE.PathFile.toString().Replace(SIMA.Utilitario.Constantes.Caracter.Slash, "@").Replace(":", "|");
                        switch (ReportParams.Params[ReportParams.KEYQQUIENLLAMA]) {
                            case "AdministrarReporte":
                                    Manager.Task.Excecute(function () {
                                        var oParamColletions = new EasyPrevioRpt.ParamCollection();
                                        var oParam = new EasyPrevioRpt.Param("rptNamePath", srtPath);
                                        oParamColletions.Add(oParam);
                                        EasyPrevioRpt.Load(Page.Request.ApplicationPath + "/GestionReportes/RptPrevioInPopup.aspx?", oParamColletions, false);
                                        SIMA.Utilitario.Helper.Wait.Close(0);

                                        EasyPopupTestReportParam.Close();
                                    }, 500);
                                break;
                            case "ReportExploreV2":
                                ReportExploreV2.VistaPrevia(ResultReportBE.PathFile.toString());
                                SIMA.Utilitario.Helper.Wait.Close(0);
                                EasyPopupTestReportParam.Close();
                                break;
                        }
                    
                          
                     }
                     else {
                                SIMA.Utilitario.Helper.Wait.Close(0);
                                var msgConfig = { Titulo: ResultReportBE.PathFile, Descripcion: ResultReportBE.Descripcion };
                                var oMsg = new SIMA.MessageBox(msgConfig);
                                oMsg.Alert();
                     }
                 }
                , false);


            ajax.addEventListener('error', function (event) {
                var msgConfig = { Titulo: 'Proceso de Carga', Descripcion: 'Problemas a realizar la carga, es muy probable que el archivo sea demasiado grande' };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
                , false);

            //Llamar al popopespera
          
            ajax.open('POST', Page.Request.ApplicationPath + '/GestionReportes/GenerarPdf.aspx', false);
            ajax.send(FrmDataBits);
           
        }

        */

       function onDisplayTemplateProyecto(ul, item) {
            var cmll = "\"";
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                        + '     <div class= "flex-column">' + item.NombreProyecto
                        + '         <p><small style="font-weight: bold">Nro PROY:</small> <small style ="color:red">' + item.NroProyecto + '</small>'
                        + '         <small style="font-weight: bold">CLIENTE:</small><small style="color:blue;text-transform: capitalize;">' + item.ClienteRazonSocial + '</small></p>'
                        + '         <span class="badge badge-info ">' + item.LineaNegocio + '</span > '
                        + '     </div>'
                        + '</a>';

            var oCustomTemplateBE = new MiFrmParam_Ctrl1.CustomTemplateBE(ul, item, iTemplate);

            return MiFrmParam_Ctrl1.SetCustomTemplate(oCustomTemplateBE);
            
        }

    </script>

</head>
<body onclick="ReportParams.Chat.send('Hello World eddy');">
    <form id="form1" runat="server">
        
        <table style="width:100%">
            <tr>
                <td style="width:100%">
                    <cc1:EasyForm ID="EasyForm" runat="server"></cc1:EasyForm>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width:100%">
                        <tr>
                            <td style="width:50%">
                                <asp:CheckBox ID="chkExpXLS" runat="server" Text="Exportar a Excel" Visible="False" />
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
       
    </form>
</body>
    <script>
        ReportParams.Data = {};
        ReportParams.Data.Tree = {};
        ReportParams.Data.Tree.ITemplate = function (objParams) {
            var MsgTemplate = '<table width="100%" align="left">'
            MsgTemplate += '    <tr><td id="ContextTreeData"></td></tr>'
            MsgTemplate += '</table>';

            var urlPag = Page.Request.ApplicationPath + "/GestionReportes/AdministrarMapeoCampos.aspx";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(ReportParams.KEYQIDOBJETO, ReportParams.Params[ReportParams.KEYQIDOBJETO]);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UrlApp", Page.Request.ApplicationPath);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("ParamRpt", objParams.Replace("{", "[").Replace("}", "]").Replace(":", "|").Replace(",", ";"));
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            SIMA.Utilitario.Helper.LoadPageIn("ContextTreeData", urlPag, oParamCollections);
            return MsgTemplate;
        }

        ReportParams.Data.Tree.Show = function (objParams) {
            var ConfigMsgb = {
                Titulo: 'Árbol de Datos'
                , Width: "500px"
                , Descripcion: ReportParams.Data.Tree.ITemplate(objParams)
                , Icono: 'fa fa-tag'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        
                        var AllNodes = treeObjetField.getNodes()[0];
                        AdministrarMapeoCampos.Navigator.SaveRecursivo(AllNodes);
                        
                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }
        ReportParams.Data.Tree.Commit = function (oObjetoMapeoExportBE) {
            
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
            oEasyDataInterConect.Metodo = "MapearDatosInsertaModifica";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdObjeto", ReportParams.Params[ReportParams.KEYQIDOBJETO], TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdDataField", oObjetoMapeoExportBE.IdDataField, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdDataFieldPadre", oObjetoMapeoExportBE.IdDataFieldPadre, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Nombre", oObjetoMapeoExportBE.Nombre);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Alias", oObjetoMapeoExportBE.Alias);
            oParamCollections.Add(oParam);
            
            oParam = new SIMA.Param("Descripcion", oObjetoMapeoExportBE.Descripcion);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Tipo", oObjetoMapeoExportBE.Tipo, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FieldCompute", oObjetoMapeoExportBE.FieldCompute);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Exportar", oObjetoMapeoExportBE.Exportar, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Orden", oObjetoMapeoExportBE.Orden, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Prioridad", oObjetoMapeoExportBE.Prioridad, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdEstado", oObjetoMapeoExportBE.IdEstado, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            
            oEasyDataInterConect.ParamsCollection = oParamCollections;
            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var Result = oEasyDataResult.sendData();
            return Result;
        }

    </script>
   
</html>
