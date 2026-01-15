<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarIndicadoresPorArea.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.ListarIndicadoresPorArea" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
      <style>
          .Titulo {
              font-weight: bold;
              text-transform: uppercase;
               color:red;
          }
      </style>
    
       <script>
           function onChangePeriodo(oLisItem) {
              // alert();
              /* alert(AdministrarMetasPorArea.Params[AdministrarMetasPorArea.KEYIDAREAINFO]);
               alert(AdministrarMetasPorArea.Params[AdministrarMetasPorArea.KEYIDINDICADOR]);


               alert(oLisItem.value);*/
           }
       </script>

</head>
<body> 
    <form id="form1" runat="server">
        <table id="tblServicios" style="width:100%;height:100%"  border="0" >            
             <tr>
                 <td>
                     <table>
                          <tr>
                             <td class="Etiqueta">
                                 PERIODO:
                             </td>
                             <td style="width:10%">
                                   <cc3:EasyDropdownList ID="ddlPeriodo" runat="server" CargaInmediata="True"  DataTextField="NOMBRE" DataValueField="CODIGO" MensajeValida="No se ha seleccionado PERIODO" fnOnSelected="onChangePeriodo" >
                                      <EasyStyle Ancho="Dos"></EasyStyle>
                                      <DataInterconect  MetodoConexion="WebServiceExterno">
                                          <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                          <Metodo>ListarTodosOracle</Metodo>
                                          <UrlWebServicieParams>
                                              <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdtblModulo" Paramvalue="102" TipodeDato="Int" />
                                              <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                          </UrlWebServicieParams>
                                      </DataInterconect>
                                </cc3:EasyDropdownList>
                             </td>
                             <td style="width:100%">

                             </td>
                         </tr>
                     </table>
                 </td>
             </tr>
             <tr>
                 <td class="Etiqueta">INDICADORES ASOCIADOS..</td>
             </tr>
             <tr>
                 <td id="LsIndicadores"  runat="server">
    
                </td>
             </tr>
             <tr>
                 <td class="Etiqueta">EVALUACION DE METAS:</td>
             </tr>
             <tr>
                 <td id="DetIndicador" style="width:100%; height:100%"  runat="server">
                 
                 </td>
             </tr>
        </table>       

        <cc3:EasyPopupBase ID="EasyPopupDetalle" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="INDICADORES"  ValidarDatos="true" CtrlDisplayMensaje="msgValRqr"  RunatServer="false" DisplayButtons="true"></cc3:EasyPopupBase>

    </form>
        <script>

            ListarIndicadoresPorArea.AdministraIndicador = function (tblNodo, CodArea) {

                    if (tblNodo.attr("Bloqueado") == "1") { return; }


                    var ddlAño = jNet.get("ddl_" + CodArea); 
                    if (ddlAño.GetValue() == "-1") {
                        var msgConfig = { Titulo: "PERIODO", Descripcion: 'No se ha selecciondo un periodo, selecionar para continuar..' };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                        return;
                    }

                    var strData = tblNodo.attr("Data").toString().Replace("\"", "'");
                    var IndicadorBE = strData.toString().SerializedToObject();

                    var bContentProgress = jNet.get("Prog_" + CodArea + "_" + IndicadorBE.IDINDICADOR + "_ContentProgress");
                    bContentProgress.css('display', "block");

                    var urlPag = Page.Request.ApplicationPath + "/GestionGobernanza/Indicadores/AdministrarMetasPorArea.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(ListarIndicadoresPorArea.KEYIDAREAINFO, IndicadorBE.IDITEMINFOCOMPLE);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(ListarIndicadoresPorArea.KEYIDINDICADOR, IndicadorBE.IDINDICADOR);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(ListarIndicadoresPorArea.KEYCODAREA, CodArea);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(ListarIndicadoresPorArea.KEYQAÑO, ddlAño.GetValue());
                    oColletionParams.Add(oParam);

                    var oLoadConfig = {
                        CtrlName: "DetInd_" + CodArea,
                        UrlPage: urlPag,
                        ColletionParams: oColletionParams,
                        fnOnComplete: function () {
                            bContentProgress.css('display', "none");
                        }
                    };
                    

                    SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
                

            }


            ListarIndicadoresPorArea.ConfigIndicador = function (e, IdAreaInfo, IdIndicador) {
                var oDataTable = ListarIndicadoresPorArea.ListarCriterioXIndicador(IdAreaInfo, IdIndicador);

                var tblCond = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(oDataTable.Rows.Count(), 2);
                tblCond.attr("id", "tblmsg_" + IdAreaInfo + "_" + IdIndicador).css("width","200px");

                oDataTable.Rows.forEach(function (item, f) {
                    var Cell0 = jNet.get(tblCond.rows[f].cells[0]);
                        Cell0.innerText = item.NOMBRECOLOR
                        Cell0.attr("class", "Etiqueta")
                            .css("background-color", item.COLOR)
                            .css("color", item.FONTCOLOR)
                            .css("padding-left", "20px");

                    var Cell1 = jNet.get(tblCond.rows[f].cells[1]);
                    Cell1.innerText = item.VALORCONDICION;
                    Cell1.css("color", "white").css("font-weight", "bold")
                         .css("padding-left", "20px");;

                });

              

                var ConfigMsgb = {
                    Titulo: "CONDICIONAL DE INDICADOR"
                    , Descripcion: tblCond.outerHTML
                    , Icono: 'fa fa-tag'
                    , EventHandle: function (btn) {
                        if (btn == 'OK') {
                            
                        }
                    }
                };
                var oMsg = new SIMA.MessageBox(ConfigMsgb);
                oMsg.confirm();

                //Establece el color de fondo de msgbox
                Manager.Task.Excecute(function () {
                    var objContent = jNet.get("tblmsg_" + IdAreaInfo + "_" + IdIndicador);
                    var oContentMsg = jNet.get(objContent.parentNode.parentNode.parentNode.parentNode);
                    oContentMsg.attr("align", "center");
                    oContentMsg.css("background-image", "url('../../Recursos/img/ToolBar.jpg')")
                        .css("background-repeat", "repeat-x")
                        .css("width", oConfig.width)
                        .css("cursor", "pointer")
                        .css("box-shadow", "rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px;");
                }, 100, true);


            }

            ListarIndicadoresPorArea.ListarCriterioXIndicador = function (oIdAreaInfo,oIdIndicador) {
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
                oEasyDataInterConect.Metodo = "ListarIndicadorCondicion";

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("IdArea", oIdAreaInfo , TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdIndicador", oIdIndicador, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                return oEasyDataResult.getDataTable();
            }
            
        /*

            AdministrarMetasPorArea.PopupEstados = function () {
                  var Config = {
                        Titulo: 'LISTA DE INDICADORES POR AREA'
                    , IdTabla: 87
                    , IdSelected: 1
                    , ArrNotIn: [0]
                    , OrigenDB: "Oracle"
                    , width: "500px"
                    , TextField: "ABREV"
                    , IdUerySelector:0//ListarTodos
                    , fncRowDataBound: function (ItemBE) {
                          var strBE = ''.toString().BaseSerialized(ItemBE);
                    return '<table><tr><td>' + ItemBE["NOMBRE"].toString() +'</td></tr></table>';
                      }
                    , fncOK: function (ItemBE) {
                        alert();
                 
                      }
                  };
                    // SIMA.Utilitario.Helper.PopupTablaItems(Config);
                    SIMA.Utilitario.Helper.PopupOptions(Config);
              }*/
        </script>
    
</body>
</html>
