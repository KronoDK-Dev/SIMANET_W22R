<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaReporteIndicadores.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.ListaReporteIndicadores" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>




<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   

 <style>
   
     .ItemOP{
         background: #fefefe;
         color: #15428b;
         font: 12px tahoma,arial,sans-serif;
         height: 30px;
         margin-right:2px;
         border: 1px dotted #5394C8;
      }


     .ItemOP td {
         padding:8px;
         height:100%;
     }

     .ItemOP tr:hover {
        background-color: #E1EFFA;
     }

     .ItemSelected{
         background: #2794DD;
         color: white;
         font: 12px tahoma,arial,sans-serif;
         height: 30px;
         margin-right:2px;
         border: 1px dotted #5394C8;
      }


     .ItemSelected td {
         padding:8px;
         height:100%;
     }
    /*Para el Boton anclar*/
    .imgEfect {
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 5px;
    }

    .imgEfect:hover {
      box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
    }

 </style>

    <script>
        function ddlMeses_OnClick(oListItem) {
            var oTbl_btns = jNet.get(document.getElementById('BtnOpcion').childNodes[0]);
            Array.from(oTbl_btns.rows).forEach(function (row) {
                Array.from(row.cells).forEach(function (cell) {
                    var oBtnItem = jNet.get(cell.childNodes[0]);
                    var DataBE = oBtnItem.attr("Data").toString().SerializedToObject();
                    if (DataBE != null) {
                        DataBE.Load = "false";
                        oBtnItem.attr("Data", DataBE.Serialized());
                    }
                });
            });
        }

        function btn_OnClick(e) {
           
            var obtn = jNet.get(e);
            
            var DataBE = obtn.attr("Data").toString().SerializedToObject();
            //Establecer la clase por default
            var oTbl_btns = jNet.get(document.getElementById('BtnOpcion').childNodes[0]);
            Array.from(oTbl_btns.rows).forEach(function(row){
                Array.from(row.cells).forEach(function (cell) {
                    jNet.get(cell.childNodes[0]).attr("class", "ItemOP");
                });
            });
           

            obtn.attr("class", "ItemSelected");
            try {
                if (DataBE.Load == "false") {
                    switch (obtn.id) {
                        case "btn_1":

                            Manager.Task.Excecute(function () {
                                InfoRptBE = ReportIndicadores.NoConformidad.ResumenPorEstados();
                                DataBE.Url = InfoRptBE.PathHTTP;
                                DataBE.UrlBase = InfoRptBE.PathBasico;
                                DataBE.Load = "true";
                                obtn.attr("Data", DataBE.Serialized());
                                jNet.get("iPrevio").attr("src", InfoRptBE.PathHTTP);
                                ReportIndicadores.NoConformidad.DataBtnSelected = DataBE.Serialized();
                            }, 1000);

                            break;
                        case "btn_2":
                            Manager.Task.Excecute(function () {
                                InfoRptBE = ReportIndicadores.NoConformidad.ResumenPorProyecto();
                                DataBE.Url = InfoRptBE.PathHTTP;
                                DataBE.UrlBase = InfoRptBE.PathBasico;
                                DataBE.Load = "true";
                                obtn.attr("Data", DataBE.Serialized());
                                jNet.get("iPrevio").attr("src", InfoRptBE.PathHTTP);
                                ReportIndicadores.NoConformidad.DataBtnSelected = DataBE.Serialized();
                            }, 1000);

                            break;
                        case "btn_3":
                            Manager.Task.Excecute(function () {
                                InfoRptBE = ReportIndicadores.NoConformidad.ResumenPorIP_SIMA();
                                DataBE.Url = InfoRptBE.PathHTTP;
                                DataBE.UrlBase = InfoRptBE.PathBasico;
                                DataBE.Load = "true";
                                obtn.attr("Data", DataBE.Serialized());
                                jNet.get("iPrevio").attr("src", InfoRptBE.PathHTTP);
                                ReportIndicadores.NoConformidad.DataBtnSelected = DataBE.Serialized();
                            }, 1000);
                            break;
                        case "btn_4":
                            Manager.Task.Excecute(function () {
                                InfoRptBE = ReportIndicadores.NoConformidad.ResumenPorTipodeInspeccion();
                                DataBE.Url = InfoRptBE.PathHTTP;
                                DataBE.UrlBase = InfoRptBE.PathBasico;
                                DataBE.Load = "true";
                                obtn.attr("Data", DataBE.Serialized());
                                jNet.get("iPrevio").attr("src", InfoRptBE.PathHTTP);
                                ReportIndicadores.NoConformidad.DataBtnSelected = DataBE.Serialized();
                            }, 1000);
                            break;

                    }

                }
                else {
                    jNet.get("iPrevio").attr("src", DataBE.Url);
                    ReportIndicadores.NoConformidad.DataBtnSelected = DataBE.Serialized();
                }
            }
            catch (ex) {
                var msgConfig = { Titulo: "Error al generar el reporte", Descripcion: ex };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
           
        }

        var ReportIndicadores = {};
        ReportIndicadores.NoConformidad = {};
        ReportIndicadores.NoConformidad.DataBtnSelected = null;
        ReportIndicadores.NoConformidad.ResumenPorEstados = function () {
            try {

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(ListaReporteIndicadores.KEYQAÑO, numAño.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param(ListaReporteIndicadores.KEYQIDMES, ddlMeses.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('UserName', AdministrarInspecion.Params['UserName']);
                oParamCollections.Add(oParam);


                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                oEasyDataInterConect.UrlWebService = "/GestiondeCalidad/Proceso.asmx";
                oEasyDataInterConect.Metodo = 'GenerarReporteNoConformidad';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var GenericEntityBE = oEasyDataResult.getDictionaryBE();

                return GenericEntityBE;
            }
            catch (SIMADataException) {
                var msgConfig = { Titulo: "Error al generar el reporte", Descripcion: SIMADataException.Message };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
        }
        ReportIndicadores.NoConformidad.ResumenPorProyecto= function () {
            try {

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(ListaReporteIndicadores.KEYQAÑO, numAño.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param(ListaReporteIndicadores.KEYQIDMES, ddlMeses.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('UserName', AdministrarInspecion.Params['UserName']);
                oParamCollections.Add(oParam);


                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                oEasyDataInterConect.UrlWebService = "/GestiondeCalidad/Proceso.asmx";
                oEasyDataInterConect.Metodo = 'GenerarReporteNoConformidadResumenProyecto';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var GenericEntityBE = oEasyDataResult.getDictionaryBE();

                return GenericEntityBE;
            }
            catch (SIMADataException) {
                var msgConfig = { Titulo: "Error al generar el reporte", Descripcion: SIMADataException.Message };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
        }

        ReportIndicadores.NoConformidad.ResumenPorIP_SIMA= function () {
            try {
                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(ListaReporteIndicadores.KEYQAÑO, numAño.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param(ListaReporteIndicadores.KEYQIDMES, ddlMeses.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('UserName', AdministrarInspecion.Params['UserName']);
                oParamCollections.Add(oParam);


                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                oEasyDataInterConect.UrlWebService = "/GestiondeCalidad/Proceso.asmx";
                oEasyDataInterConect.Metodo = 'GenerarReporteNoConformidadResumenIP_SIMA';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var GenericEntityBE = oEasyDataResult.getDictionaryBE();

                return GenericEntityBE;
            }
            catch (SIMADataException) {
                var msgConfig = { Titulo: "Error al generar el reporte", Descripcion: SIMADataException.Message };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
        }
        ReportIndicadores.NoConformidad.ResumenPorTipodeInspeccion = function () {
            try {
                //
                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(ListaReporteIndicadores.KEYQAÑO, numAño.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param(ListaReporteIndicadores.KEYQIDMES, ddlMeses.GetValue());
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('UserName', AdministrarInspecion.Params['UserName']);
                oParamCollections.Add(oParam);


                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                oEasyDataInterConect.UrlWebService = "/GestiondeCalidad/Proceso.asmx";
                oEasyDataInterConect.Metodo = 'GenerarReporteNoConformePorTipodeInspeccion';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var GenericEntityBE = oEasyDataResult.getDictionaryBE();

                return GenericEntityBE;
            }
            catch (SIMADataException) {
                var msgConfig = { Titulo: "Error al generar el reporte", Descripcion: SIMADataException.Message };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
        }

        ReportIndicadores.AnclarReport = function () {
            var DataBE = ReportIndicadores.NoConformidad.DataBtnSelected.toString().SerializedToObject();;
            __doPostBack('ibtnAnclar', ReportIndicadores.NoConformidad.DataBtnSelected.toString());
        }


    </script>

</head>
<body>
    <form id="form1" runat="server">
       <table border="0">
           <tr>
               <td colspan="0">
                   <table>
                       <tr style="height:45px;">
                           <td class="Etiqueta" >Periodo</td>
                           <td><cc2:EasyNumericBox ID="numAño" STYLE="width:80px" MaxLength="4" runat="server"></cc2:EasyNumericBox></td>
                           <td class="Etiqueta" >Hasta</td>
                           <td>
                               <cc2:EasyDropdownList ID="ddlMeses" runat="server" DataTextField="DESCRIPCION" DataValueField="CODIGO" MensajeValida="No se ha seleccionado el proceso productivo" Requerido="True" CargaInmediata="True" fnOnSelected="ddlMeses_OnClick">
                                <EasyStyle Ancho="Dos"></EasyStyle>
                                <DataInterconect>
                                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                    <Metodo>ListarItems</Metodo>
                                    <UrlWebServicieParams>
                                        <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="688" TipodeDato="String" />
                                        <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                    </UrlWebServicieParams>
                                </DataInterconect>
                            </cc2:EasyDropdownList>

                           </td>
                       </tr></table>
               </td>
           </tr>
           <tr>
               <td id="BtnOpcion" runat="server" style="width:95%;"></td>
               <td>
                   <img  ID="ImageFijarReport" runat="server"/></td>
           </tr>
           <tr>
               <td  style="width:1200px;height:450px" colspan="2">
                    <iframe  class="scrollbar" runat="server"  id="iPrevio" src="" allowtransparency="true" style="background-color:transparent; solid #000000; bottom:0px; right:0px; width:100%; height:100%; border:none; margin:0; padding:0; overflow:hidden; z-index:999999;"  frameborder="0" > </iframe>
               </td>
           </tr>

       </table>
    </form>
</body>
</html>
