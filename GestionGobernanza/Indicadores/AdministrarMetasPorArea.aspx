<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarMetasPorArea.aspx.cs" Inherits="SIMANET_W22R.GestionGobernanza.Indicadores.AdministrarMetasPorArea" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
    <style>
        .Titulo {
            font-weight: bold;
            text-transform: uppercase;
           
        }
    </style>

 
</head>
<body>
    <form id="form1" runat="server">
          

      

    </form>

    <script>
        var arrTitulo = new Array();
        var arrResult = new Array();
        var arrMeta = new Array();
        function ObtenerData() {
            var tblMaster = jNet.get(AdministrarMetasPorArea.Params[AdministrarMetasPorArea.KEYIDAREAINFO] + "_" + AdministrarMetasPorArea.Params[AdministrarMetasPorArea.KEYIDINDICADOR] + "-" + AdministrarMetasPorArea.Params[AdministrarMetasPorArea.KEYQAÑO]);

            arrTitulo.Clear();
            arrResult.Clear();
            arrMeta.Clear();

            for (var d = 1; d <= tblMaster.rows[3].cells.length-1; d++) {
                arrTitulo.Add(tblMaster.rows[0].cells[d].innerText);

                var otxtValor = tblMaster.rows[3].cells[d].innerText;
                otxtValor = ((otxtValor.length > 0) ? otxtValor :"0");
                arrResult.Add(otxtValor)

                var otxtMeta = tblMaster.rows[4].cells[d].innerText;
                otxtMeta = ((otxtMeta.length > 0) ? otxtMeta : "0");
                arrMeta.Add(otxtMeta)
            }
        }

        function PaintGraph() {
            ObtenerData();

            var densityCanvas = document.getElementById("Chart_" + AdministrarMetasPorArea.Params[AdministrarMetasPorArea.KEYCODAREA]);
            Chart.defaults.global.defaultFontFamily = "Lato";
            Chart.defaults.global.defaultFontSize = 18;

            var densityData = {
                label: 'RESULTADO',
                data: arrResult,
                backgroundColor: 'rgba(0, 99, 132, 0.6)',
                borderColor: 'rgba(0, 99, 132, 1)',
                yAxisID: "y-axis-density"
            };

            var gravityData = {
                label: 'META',
                data: arrMeta,
                backgroundColor: 'rgba(99, 132, 0, 0.6)',
                borderColor: 'rgba(99, 132, 0, 1)',
                yAxisID: "y-axis-gravity"
            };

            var planetData = {
                labels: arrTitulo,
                datasets: [densityData, gravityData]
            };

            var chartOptions = {
                scales: {
                    xAxes: [{
                        barPercentage: 1,
                        categoryPercentage: 0.6
                    }],
                    yAxes: [{
                        id: "y-axis-density"
                    }, {
                        id: "y-axis-gravity"
                    }]
                }
            };

            var barChart = new Chart(densityCanvas, {
                type: 'bar',
                data: planetData,
                options: chartOptions
            });
        }

        PaintGraph();
    </script>



    <script>
        /*Aun no utilizado */
        AdministrarMetasPorArea.DetalleIndicadorShow = function (e) {
            var Url = Page.Request.ApplicationPath + 'DetalleAreaIndicador.aspx';
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarObjetivosAcciones.KEYMODOPAGINA, 'M');
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarObjetivosAcciones.KEYQIDTABLAGENERAL, 86);//Tabla de areas
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarObjetivosAcciones.KEYQIDITEMTABLAGENERAL, 1);//Id area
            oColletionParams.Add(oParam);
            
            oParam = new SIMA.Param(AdministrarMetasPorArea.KEYQIDTABLAGENERALREL, 87);//Tabla de indicadores
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarMetasPorArea.KEYQIDITEMTABLAGENERALREL, 1);//id indicador
            oColletionParams.Add(oParam);


            //EasyPopupDetalleObjetivo.Titulo = Titulo;
            EasyPopupDetalle.Load(Url, oColletionParams, false);
        }


        AdministrarMetasPorArea.DetalleAnalisis = function (e,CodArea) {
            var oHtmlTable = e.parentNode.parentNode;
            var oCelda = jNet.get(oHtmlTable.rows[0].cells[e.cellIndex]);
            var strData = oCelda.attr("Data");
            var MetaBE = strData.toString().SerializedToObject();
            var txtAnalisis = jNet.get("txtA_" + CodArea);
            var txtAcciones = jNet.get("txtAc_" + CodArea);


            txtAnalisis.SetValue(MetaBE.ANALISIS);
            txtAnalisis.attr("objTxt", e.children[0].id);
            txtAnalisis.attr("CodArea", CodArea);
            txtAnalisis.addEvent("blur", function () {
                AdministrarMetasPorArea.txtOnChange(jNet.get(jNet.get(this).attr("objTxt")), jNet.get(this).attr("CodArea"));
            });

            txtAcciones.SetValue(MetaBE.ACCIONES);
            txtAcciones.attr("objTxt", e.children[0].id);
            txtAcciones.attr("CodArea", CodArea);
            txtAcciones.addEvent("blur", function () {
                AdministrarMetasPorArea.txtOnChange(jNet.get(jNet.get(this).attr("objTxt")), jNet.get(this).attr("CodArea"));
            });
        }

        AdministrarMetasPorArea.txtOnChange = function (e,CodArea) {

            var oHtmlTable = e.parentNode.parentNode.parentNode;
            var oCelda = jNet.get(oHtmlTable.rows[0].cells[e.parentNode.cellIndex]);
            var strData = oCelda.attr("Data");
            var txtCtrl = event.target;

            var oDataBE = strData.toString().SerializedToObject();
            switch (txtCtrl.id) {
                case "txtA_" + CodArea:
                    if (txtCtrl.value != oDataBE.ANALISIS) {
                        oDataBE.ANALISIS = txtCtrl.value;
                        oDataBE.IDITEM =AdministrarMetasPorArea.ActualizarDatos(e, oDataBE);
                        
                        //ACTUALIZA LA ENTDAD
                        var BESerializado = ''.toString().BaseSerialized(oDataBE); 
                        oCelda.attr("Data", BESerializado);
                    }

                    break;
                case "txtAc_" + CodArea:
                    if (txtCtrl.value != oDataBE.ACCIONES) {
                        oDataBE.ACCIONES = txtCtrl.value;
                        oDataBE.IDITEM =AdministrarMetasPorArea.ActualizarDatos(e, oDataBE);
                        //ACTUALIZA LA ENTDAD
                        var BESerializado = ''.toString().BaseSerialized(oDataBE); 
                        oCelda.attr("Data", BESerializado);
                    }

                    break;
            }
           
        }


        AdministrarMetasPorArea.OnChange = function (e,CodArea) {
            var OtroTxt = null;
            var oHtmlRow = e.parentNode.parentNode;
            var oHtmlTable = oHtmlRow.parentNode;
            var Numerador = 0;
            var Denominador = 0;
            var Resultado = 0;
            var txtAnalisis = jNet.get("txtA_" + CodArea);
            var txtAcciones = jNet.get("txtAc_" + CodArea);

            var DataIndicadorBE = jNet.get(oHtmlTable.rows[0].cells[e.parentNode.cellIndex]).attr('Data').toString().SerializedToObject();

           

            if (oHtmlRow.rowIndex == 1) {
                OtroTxt = oHtmlTable.rows[2].cells[e.parentNode.cellIndex].children[0]
                Numerador = e.value;
                Denominador = OtroTxt.value;
            }
            else {
                OtroTxt = oHtmlTable.rows[1].cells[e.parentNode.cellIndex].children[0]
                Numerador = OtroTxt.value;
                Denominador = e.value;
            }

            //Verifica si hubo cambios en los datos
            if (((txtAnalisis.value != DataIndicadorBE.NUMERADOR) || (txtAcciones.value != DataIndicadorBE.DENOMINADOR)) || ((txtAnalisis.value != ' ') || (txtAcciones.value,' '))) {

                //dependiendo del tipo de valor si es porcenta o valor se aplicara el cálculo
                if (DataIndicadorBE.PORCVALOR == 1) {//Porcen taje
                    Resultado = ((Numerador / Denominador) * 100);
                }
                else {//Valor
                    Resultado = (Numerador / Denominador);
                }

                if (Resultado.toString() != "NaN") {
                    oHtmlTable.rows[3].cells[e.parentNode.cellIndex].innerText = parseFloat(Resultado.toFixed(2));
                    //Establecer el Color
                    var CellDataColor = jNet.get(oHtmlTable.rows[0].cells[e.parentNode.cellIndex]);
                    for (var i = 1; i <= 3; i++) {
                        var DColorBE = CellDataColor.attr("C_" + i).toString().SerializedToObject();
                        var Cumple = false;

                        var strFormula = "";
                        if ((DColorBE.VALORCONDICION.toString().indexOf("<") != -1) || (DColorBE.VALORCONDICION.toString().indexOf(">")!=-1)) {
                            strFormula = "(" + DColorBE.VALORCONDICION + ")";
                        }
                        else {
                            strFormula = "(" + DColorBE.VALORCONDICION.Replace("=", "==") + ")";
                        }
                        
                        strFormula = strFormula.Replace('R', Resultado);
                        strFormula = strFormula.toString().toUpperCase().Replace("O", ") || (");
                        strFormula = strFormula.toString().toUpperCase().Replace("Y", ") && (");

                        Cumple = eval(strFormula);
                        if (Cumple) {
                            jNet.get(oHtmlTable.rows[3].cells[e.parentNode.cellIndex]).css("background-color", DColorBE.COLOR).css("color", DColorBE.FONTCOLOR);
                            DataIndicadorBE.COLOR = DColorBE.COLOR;
                            DataIndicadorBE.FONTCOLOR = DColorBE.FONTCOLOR;
                        }
                       
                    }

                    //Actualizar los datos de la entidad
                    DataIndicadorBE.NUMERADOR = Numerador;
                    DataIndicadorBE.DENOMINADOR = Denominador;

                    /*-------------------------------------------------------------------------------------------*/
                    DataIndicadorBE.ANALISIS = txtAnalisis.GetValue();
                    DataIndicadorBE.ACCIONES = txtAcciones.GetValue();
                    DataIndicadorBE.RESULTADO = parseFloat(Resultado.toFixed(2));

                    DataIndicadorBE.IDITEM =AdministrarMetasPorArea.ActualizarDatos(e, DataIndicadorBE);

                    //actualiza la configutacion
                    var BESerializado = ''.toString().BaseSerialized(DataIndicadorBE); 
                    jNet.get(oHtmlTable.rows[0].cells[e.parentNode.cellIndex]).attr('Data', BESerializado)
                    //Dibujar resultado
                    PaintGraph();
                }
            }

        }


        AdministrarMetasPorArea.ActualizarDatos = function (e, oDataIndicadorBE) {

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdItem", oDataIndicadorBE.IDITEM, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Periodo", AdministrarMetasPorArea.Params[AdministrarMetasPorArea.KEYQAÑO]);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Numerador", oDataIndicadorBE.NUMERADOR);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Denominador", oDataIndicadorBE.DENOMINADOR);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Analisis", oDataIndicadorBE.ANALISIS);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Acciones", oDataIndicadorBE.ACCIONES);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Resultado", oDataIndicadorBE.RESULTADO);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Color", oDataIndicadorBE.COLOR);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FontColor", oDataIndicadorBE.FONTCOLOR);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdItemPeriodo", oDataIndicadorBE.IDITEMPERIODO, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/GestionGobernanza/Indicadores.asmx';
            oEasyDataInterConect.Metodo = 'AreaindicadorMetasXAperiodo_ins';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var IdResult = oEasyDataResult.sendData();

            return IdResult;          
        }

    </script>
</body>
</html>
