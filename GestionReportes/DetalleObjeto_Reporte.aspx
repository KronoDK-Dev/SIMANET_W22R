<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleObjeto_Reporte.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.DetalleObjeto_Reporte" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        .ItemDisponible {
            background: #fefefe;
            color: #15428b;
            font: 12px tahoma,arial,sans-serif;
            margin-top: 5px;
            margin-right: 15px;
            margin-bottom: 5px;
            border: 1px dotted #5394C8;
            height: 35px;
            width: 100%;
        }


            .ItemDisponible td {
                padding-left: 5px;
                padding-right: 5px;
                height: 35px;
            }

            .ItemDisponible tr:hover {
                background-color: #E1EFFA;
            }

        .ItemSelected {
            background: #2794DD;
            color: white;
            font: 12px tahoma,arial,sans-serif;
            margin-top: 5px;
            margin-bottom: 5px;
            border: 1px dotted #5394C8;
            height: 35px;
            width: 100%;
        }

            .ItemSelected td {
                padding-left: 5px;
                padding-right: 5px;
                height: 35px;
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
</head>
<body>
    <form id="form1" runat="server">
        <table border="0px" style="width: 100%;">
            <tr>
                <td class="Etiqueta" colspan="2">NOMBRE REPORTE</td>
            </tr>
            <tr>
                <td class="Etiqueta" colspan="2">
                    <cc3:EasyTextBox ID="txtNombreRpt" runat="server" Width="100%"></cc3:EasyTextBox>
                </td>
            </tr>
            <tr>
                <td class="Etiqueta">ARCHIVO DE REPORTE</td>
                <td style="width: 80%">&nbsp;</td>
            </tr>

            <tr>
                <td class="Etiqueta">Nombre (.rpt)
                </td>
                <td style="width: 80%">
                    <cc3:EasyAutocompletar ID="EasyFindFileRpt" runat="server" NroCarIni="4" DisplayText="Nombre" ValueField="Ruta" fnOnSelected="DetalleObjeto_Reporte.onEasyFindFileRpt_Selected" fncTempaleCustom="DetalleObjeto_Reporte.onDisplayTemplateFile">
                        <EasyStyle Ancho="Dos"></EasyStyle>
                        <DataInterconect MetodoConexion="WebServiceInterno">
                            <UrlWebService>/GestionReportes/Procesar.asmx</UrlWebService>
                            <Metodo>ListarArchivosDeDirectorio</Metodo>
                            <UrlWebServicieParams>
                                <cc2:EasyFiltroParamURLws ParamName="RutaBase" Paramvalue="GetRutaReporte();" ObtenerValor="FunctionScript" />
                                <cc2:EasyFiltroParamURLws ParamName="Ext" Paramvalue=".rpt" ObtenerValor="Fijo" />
                                <cc2:EasyFiltroParamURLws ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                            </UrlWebServicieParams>
                        </DataInterconect>
                    </cc3:EasyAutocompletar>
                </td>
            </tr>

            <tr>
                <td class="Etiqueta">Ruta:
                </td>
                <td>
                    <asp:TextBox ID="txtRutaRpt" runat="server" Style="width: 100%; color: dimgrey" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                </td>

            </tr>
            <tr>
                <td class="Etiqueta" colspan="2">DATA INTERCONECT</td>
            </tr>
            <tr>
                <td class="Etiqueta" colspan="2">Página de Servicio (.asmx)
                </td>
            </tr>
            <tr>

                <td colspan="2" style="width: 100%">
                    <cc3:EasyAutocompletar ID="EasyListaServiciosRpt" runat="server" NroCarIni="4" DisplayText="Nombre" ValueField="Ruta" fnOnSelected="DetalleObjeto_Reporte.onEasyListaServiciosRpt_Selected" fncTempaleCustom="DetalleObjeto_Reporte.onDisplayTemplateFile" Width="100%">
                        <EasyStyle Ancho="Dos"></EasyStyle>
                        <DataInterconect MetodoConexion="WebServiceInterno">
                            <UrlWebService>/GestionReportes/Procesar.asmx</UrlWebService>
                            <Metodo>ListarArchivosDeDirectorio</Metodo>
                            <UrlWebServicieParams>
                                <cc2:EasyFiltroParamURLws ParamName="RutaBase" Paramvalue="GetRutaApp();" ObtenerValor="FunctionScript" />
                                <cc2:EasyFiltroParamURLws ParamName="Ext" Paramvalue=".asmx" ObtenerValor="Fijo" />
                                <cc2:EasyFiltroParamURLws ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                            </UrlWebServicieParams>
                        </DataInterconect>
                    </cc3:EasyAutocompletar>

                </td>

            </tr>
            <tr>
                <td colspan="2" style="width: 100%">
                    <asp:TextBox ID="txtPathWebServiceSelected" ReadOnly="true" runat="server" CssClass="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Etiqueta" colspan="2">Método
                                                        <asp:Image ID="imgFnc" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 100%">
                    <cc3:EasyAutocompletar ID="EasyListarMetodosRpt" runat="server" NroCarIni="2" DisplayText="Metodo" ValueField="Id" fnOnSelected="DetalleObjeto_Reporte.EasyListarMetodosRpt" Width="100%" fncTempaleCustom="DetalleObjeto_Reporte.EasyMetodosTemplate">
                        <EasyStyle Ancho="Dos"></EasyStyle>
                        <DataInterconect MetodoConexion="WebServiceInterno">
                            <UrlWebService>/GestionReportes/Procesar.asmx</UrlWebService>
                            <Metodo>BuscarMetodoWebService</Metodo>
                            <UrlWebServicieParams>
                                <cc2:EasyFiltroParamURLws ParamName="RutaBase" Paramvalue="GetNameSpaceDLL();" ObtenerValor="FunctionScript" />
                                <cc2:EasyFiltroParamURLws ParamName="PathWS" Paramvalue="GetRutaPaginaServicioASMX();" ObtenerValor="FunctionScript" />
                                <cc2:EasyFiltroParamURLws ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                            </UrlWebServicieParams>
                        </DataInterconect>
                    </cc3:EasyAutocompletar>

                </td>
            </tr>

            <tr>
                <td colspan="2" class="Etiqueta" align="center" style="border-bottom-style: dotted; border-bottom-color: gray; border-bottom-width: 1px; height: 35px;">PARÁMETROS</td>

            </tr>
            <tr>
                <td colspan="2" style="width: 100%">
                    <table style="width: 100%">
                        <tr>
                            <td class="Etiqueta" style="width: 30%">Disponibles</td>
                            <td></td>
                            <td class="Etiqueta" style="width: 60%">
                                <asp:Image ID="imgConfig" runat="server" />
                                Configurados
                            </td>
                        </tr>
                        <tr>
                            <td id="LstParamRpt" style="border: solid 1px darkgray; padding-left: 5px; padding-right: 5px; padding-top: 5px"></td>
                            <td style="padding-left: 15px; padding-right: 15px">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Image ID="ImgAdd" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Image ID="ImgRemove" runat="server" />
                                        </td>
                                    </tr>

                                </table>

                            </td>
                            <td style="border: solid 1px darkgray" valign="top">
                                <cc1:EasyGridView ID="EasyGridViewParamConfig" runat="server" AutoGenerateColumns="False" TituloHeader="PARÁMETROS CONFIGURADOS" Width="100%" ShowRowNumber="False" ToolBarButtonClick="DetalleObjeto_Reporte.OnEasyGridButton_Click" OnRowDataBound="EasyGridViewParamConfig_RowDataBound">
                                    <EasyGridButtons>
                                        <cc1:EasyGridButton Id="btnAgregarSeccion" Descripcion="" Icono="" MsgConfirm="Desea Agregar una nueva  sección ahora?" RequiereSelecciondeReg="False" RunAtServer="False" SolicitaConfirmar="False" Texto="Add Sección" Ubicacion="Derecha" />
                                    </EasyGridButtons>
                                    <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />

                                    <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick=""></EasyExtended>

                                    <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                                    <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                                    <Columns>
                                        <asp:BoundField DataField="Nombre" HeaderText="SECCION Y PARAMETRO">
                                            <ItemStyle HorizontalAlign="Left" Width="50%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Ref1" HeaderText="NOMBRE">
                                            <ItemStyle HorizontalAlign="Left" Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Ref2" HeaderText="TIPO"></asp:BoundField>
                                        <asp:BoundField DataField="ValorDefault" HeaderText="VAL DEFAULT"></asp:BoundField>
                                        <asp:TemplateField HeaderText="CTRL ASOCIADO">
                                            <ItemStyle HorizontalAlign="Left" Width="40%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="HeaderGrilla" Height="25px" />
                                    <RowStyle CssClass="ItemGrilla" Height="35px" />
                                </cc1:EasyGridView>


                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2"></td>
            </tr>
        </table>
        <input id="hPathRptConfig" runat="server" type="hidden" />

        <cc3:EasyPopupBase ID="EasyAdmSeccion" runat="server" Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Administrar Sección" RunatServer="false" DisplayButtons="true"></cc3:EasyPopupBase>
    </form>
</body>
<script type="text/javascript">

    function GetRutaReporte() {
        var strKeyValue = SIMA.Utilitario.Helper.Configuracion.Leer('ConfigBase', 'PathFileSourceRpts');
        return strKeyValue;
    }
    function GetRutaApp() {
        return DetalleObjeto_Reporte.PhysicalApplicationPath;
    }
    function GetNameSpaceDLL() {
        return DetalleObjeto_Reporte.NameSpaceBaseDll;
    }


    function GetRutaPaginaServicioASMX() {
        var strPath = jNet.get("txtPathWebServiceSelected").value + SIMA.Utilitario.Constantes.Caracter.Slash + EasyListaServiciosRpt.GetText();
        return strPath;
    }

    DetalleObjeto_Reporte.onDisplayTemplateFile = function (ul, item) {
        var cmll = "\"";
        iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
            + '         <div class= "flex-column">' + item.Nombre
            + '             <p><small style="font-weight: bold">FECHA DE CREACIÓN:</small> <small style ="color:red">' + item.FCreacion + '</small><br>'
            + '             <small style="font-weight: bold">UBICACIÓN:</small><small style="color:blue;text-transform: capitalize;">' + item.Ruta.Replace('.', String.fromCharCode(92, 92)) + '</small></p>'
            + '             <span class="badge badge-info "> ' + item.FAcceso + '</span>'
            + '         </div>'
            + '</a>';
        var oCustomTemplateBE = new EasyFindFileRpt.CustomTemplateBE(ul, item, iTemplate);
        return EasyFindFileRpt.SetCustomTemplate(oCustomTemplateBE);
    }

    DetalleObjeto_Reporte.EasyMetodosTemplate = function (ul, item) {
        var cmll = "\"";
        var arrParam = item.LstParametros.split(',');
        var strParam = "";
        arrParam.forEach(function (item, i) {
            var Tipo_Param = item.split(' ');
            strParam += '<td style="color: blue; font-family: Arial; font-size: 15px;text-align: center;">' + Tipo_Param[0] + '</td>' + '<td style="color: #80b3ff; font-family: Arial; font-size: 14px;padding-left:5px;padding-right:10px">' + Tipo_Param[1] + ((i == (arrParam.length - 1)) ? "" : ",") + '</td>';
        });

        iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" >'
            + '<div class= "flex-column">'
            + '<table><tr height="35px"> <td style="color:#000099; font-family: Arial; font-size: 16px;font-weight: bold;">' + item.Metodo + '</td> <td style="color:red; font-family: Arial; font-size: 18px;font-weight: bold;">(</td>' + strParam + '</td> <td style="color:red; font-family: Arial; font-size: 18px;font-weight: bold;">)</td> </tr></table>'
            + '</div>'
            + '</a>';
        var oCustomTemplateBE = new EasyListarMetodosRpt.CustomTemplateBE(ul, item, iTemplate);
        return EasyListarMetodosRpt.SetCustomTemplate(oCustomTemplateBE);
    }

    DetalleObjeto_Reporte.ParamsSeccionTemplate = function (oObjetoBE, Modo) {
        // USADO EN : DetalleObjeto_Reporte.AddParam
        //              DetalleObjeto_Reporte.OnEasyGridButton_Click : btnAgregarSeccion
        var MsgTemplate = '<table width="100%" align="left">'
        MsgTemplate += '    <tr><td id="ContextAdmSecc"></td></tr>'
        MsgTemplate += '</table>';

        var urlPag = Page.Request.ApplicationPath + "/GestionReportes/DetalleObjetoSeccion.aspx";
        var oColletionParams = new SIMA.ParamCollections();

        var oParam = new SIMA.Param(AdministrarReporte.KEYMODOPAGINA, Modo);//Se puede eliminar
        oColletionParams.Add(oParam);

        oParam = new SIMA.Param(DetalleObjeto_Reporte.KEYQNOMBREOBJETO, oObjetoBE.Nombre);//Nombre del parametro
        oColletionParams.Add(oParam);
        oParam = new SIMA.Param(DetalleObjeto_Reporte.KEYQDESCRIPCION, oObjetoBE.Descripcion);//Nombre del parametro
        oColletionParams.Add(oParam);


        oParam = new SIMA.Param(DetalleObjeto_Reporte.KEYQNOMBREPARAM, oObjetoBE.Parametro);//Nombre del parametro
        oColletionParams.Add(oParam);

        oParam = new SIMA.Param(DetalleObjeto_Reporte.KEYQTIPOPARAM, oObjetoBE.Tipo);//Tipo de Dato del parametro
        oColletionParams.Add(oParam);

        oParam = new SIMA.Param(DetalleObjeto_Reporte.KEYQIDTIPOOBJETO, oObjetoBE.TipoObj);//Tipo de objeto parametro
        oColletionParams.Add(oParam);


        SIMA.Utilitario.Helper.LoadPageIn("ContextAdmSecc", urlPag, oColletionParams);
        return MsgTemplate;
    }

    DetalleObjeto_Reporte.iTemplateTipoControl_ObjOnClick = function (e) {
        DetalleObjeto_Reporte.ObjCtrlSelected = jNet.get(e).attr("Data").toString().SerializedToObject();
        var objContent = jNet.get(e.parentNode);
        objContent.forEach(function (ochild, i) {
            var oDataBE = ochild.attr("Data").toString().SerializedToObject();
            nclass = ((oDataBE.CODIGO == DetalleObjeto_Reporte.ObjCtrlSelected.CODIGO) ? "ItemSelected" : "ItemDisponible");
            ochild.attr("class", nclass);
        });
    }

    DetalleObjeto_Reporte.iTemplateTipoControl = function () {
        var cmll = "\"";
        var divContent = jNet.create("div");

        var oDataTable = new SIMA.Data.DataTable('tbl');
        oDataTable = SIMA.Utilitario.Helper.TablaGeneralItem(672);
        //Crear la tabla de opciones
        oDataTable.Rows.forEach(function (oDataRow, f) {
            var CodigoCtrl = oDataRow["CODIGO"];
            if ((CodigoCtrl > 1) && (CodigoCtrl != 7)) {
                //Crea a tabla representativa de control
                var Ctrl = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(1, 2);
                var strData = "";
                oDataRow.Columns.forEach(function (oDataColumn, c) {
                    strData += ((c == 0) ? "" : ",") + oDataColumn.Name + ":" + cmll + oDataRow[oDataColumn.Name] + cmll;
                });
                strData = "{" + strData + "}";
                Ctrl.attr("id", "Ctrl_" + CodigoCtrl).attr("Data", strData).attr("class", "ItemDisponible");

                var img = jNet.create("img");
                img.attr("src", oDataRow["DESCRIPCION"].toString());
                img.attr("width", "20px");

                jNet.get(Ctrl.rows[0].cells[0]).insert(img);
                Ctrl.rows[0].cells[1].innerText = oDataRow["VAR1"];
                jNet.get(Ctrl.rows[0].cells[1]).css("width", "90%");
                jNet.get(Ctrl.rows[0].cells[1]).attr("align", "Left");

                Ctrl.attr("onclick", "DetalleObjeto_Reporte.iTemplateTipoControl_ObjOnClick(this);");//Se estalece como atributo el evento click genera un string, no funciona con el addEvent pues genera un objeto

                divContent.insert(Ctrl);
            }


        });
        return divContent.innerHTML;
    }

</script>

<script type="text/javascript">
    DetalleObjeto_Reporte.onEasyFindFileRpt_Selected = function (value, ItemBE) {
        var PathFile = ItemBE.Ruta.Replace('.', String.fromCharCode(92)).substring(0, (ItemBE.Ruta.length - 1));
        var PathRptConfig = jNet.get("hPathRptConfig").value;
        PathFile = PathFile.toString().Replace(PathRptConfig, "");
        jNet.get("txtRutaRpt").value = PathFile;
    }

    DetalleObjeto_Reporte.onEasyListaServiciosRpt_Selected = function (value, ItemBE) {
        var PathService = ItemBE.Ruta.Replace('.', '/');
        var PathApp = ItemBE.RutaBase.toString().Replace('.', '/');
        PathApp = PathService.toString().Replace(PathApp, "")
        jNet.get("txtPathWebServiceSelected").value = '/' + PathApp.toString().substring(0, PathApp.length - 1);
    }

    var ReiniciaParametros = false;
    DetalleObjeto_Reporte.EasyListarMetodosRpt = function (value, ItemBE) {
        //Limpia la grilla de cualquier otra cofiguracion
        EasyGridViewParamConfig.Clear();
        //Libera el arreglo de los parámetros que son removidos
        DetalleObjeto_Reporte.LstParamRemove.Clear();

        var oDataTable = new SIMA.Data.DataTable('tbl');
        oDataTable = DetalleObjeto_Reporte.MetodoSeleccionado.DataParametros(ItemBE.Metodo);
        oDataTable.Rows.forEach(function (oDataRow) {
            DetalleObjeto_Reporte.LstParamRemove.Add(oDataRow["Parametro"]);
        });
        DetalleObjeto_Reporte.MetodoSeleccionado.PaintParametros(ItemBE.Metodo);

        if (DetalleObjeto_Reporte.Params[DetalleObjeto_Reporte.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.M) { ReiniciaParametros = true; }
    }

    DetalleObjeto_Reporte.BackupParam = function (_gUid) {
        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "GestionReportes/AdministrarReportes.asmx";
        oEasyDataInterConect.Metodo = "BackupParam";

        var oParamCollections = new SIMA.ParamCollections();
        var oParam = new SIMA.Param("Guid", _gUid);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("IdObjeto", AdministrarReporte.Navigator.Node.Select.Data.IdObjeto);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("UserName", DetalleObjeto_Reporte.Params["UserName"]);
        oParamCollections.Add(oParam);

        oEasyDataInterConect.ParamsCollection = oParamCollections;
        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
        var Result = oEasyDataResult.sendData();
    }



    //Lista los parametros del Metodo seleccionado
    DetalleObjeto_Reporte.MetodoSeleccionado = {};

    DetalleObjeto_Reporte.MetodoSeleccionado.DataParametros = function (Metodo) {
        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
        oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
        oEasyDataInterConect.Metodo = "ListarParametrosdeMetodo";

        var oParamCollections = new SIMA.ParamCollections();
        var oParam = new SIMA.Param("Metodo", Metodo);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("PathBase", GetNameSpaceDLL());
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("PathWS", GetRutaPaginaServicioASMX());
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("UserName", DetalleObjeto_Reporte.Params["UserName"]);
        oParamCollections.Add(oParam);

        oEasyDataInterConect.ParamsCollection = oParamCollections;

        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
        var oDataTable = new SIMA.Data.DataTable('tbl');
        return oEasyDataResult.getDataTable();
    }

    DetalleObjeto_Reporte.MetodoSeleccionado.PaintParametros = function (Metodo) {
        var cmll = SIMA.Utilitario.Constantes.Caracter.Comilla;
        try {
            var oDataTable = new SIMA.Data.DataTable('tbl');
            oDataTable = DetalleObjeto_Reporte.MetodoSeleccionado.DataParametros(Metodo);

            var objLstParam = jNet.get('LstParamRpt');
            objLstParam.clear();

            oDataTable.Rows.forEach(function (oDataRow) {
                var Existe = false;
                Existe = ((DetalleObjeto_Reporte.LstParamRemove.Find(oDataRow["Parametro"]) != null) ? true : false);

                if (Existe) {
                    var tblItemParam = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(1, 2)
                    tblItemParam.attr("id", "p_" + oDataRow["Parametro"]);
                    tblItemParam.attr("class", "ItemDisponible");
                    var CellText = jNet.get(tblItemParam.rows[0].cells[1]);
                    CellText.innerText = oDataRow["Parametro"] + "(" + oDataRow["Tipo"] + ")";
                    CellText.attr("Align", "left").css("width", "90%");
                    var strData = "";
                    oDataRow.Columns.forEach(function (oDataColumn, c) {
                        strData += oDataColumn.Name + ":" + cmll + oDataRow[oDataColumn.Name] + cmll + ",";
                    });
                    strData += "TipoObj:" + cmll + "9" + cmll;//Indica que estos objetos por defecto son parametros
                    strData += ",Metodo:" + cmll + Metodo + cmll;//Metodo a la que perteneces estos parámetros
                    strData += ",Nombre:" + cmll + "" + cmll;
                    strData += ",Descripcion:" + cmll + "" + cmll;
                    strData = "{" + strData + "}";
                    tblItemParam.attr("Data", strData);
                    var oimg = jNet.create("img");
                    oimg.attr("src", SIMA.Utilitario.Constantes.ImgDataURL.IconoParam);
                    jNet.get(tblItemParam.rows[0].cells[0]).insert(oimg);

                    tblItemParam.addEvent("click", function () {
                        DetalleObjeto_Reporte.ParamSelected = jNet.get(this).attr("Data").toString().SerializedToObject();
                        var objContent = jNet.get(tblItemParam.parentNode);
                        objContent.forEach(function (ochild, i) {
                            var oDataBE = ochild.attr("Data").toString().SerializedToObject();
                            nclass = ((oDataBE.Parametro == DetalleObjeto_Reporte.ParamSelected.Parametro) ? "ItemSelected" : "ItemDisponible");
                            ochild.attr("class", nclass);
                        });
                    });
                    objLstParam.insert(tblItemParam);
                }

            });
        }
        catch (SIMADataException) {
            var msgConfig = { Titulo: "Error-Parametros", Descripcion: SIMADataException.Message };
            var oMsg = new SIMA.MessageBox(msgConfig);
            oMsg.Alert();
        }
    }

    DetalleObjeto_Reporte.ListaSeccionyParametrosConfig = function () {
        try {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
            oEasyDataInterConect.Metodo = "ListaObjectoChildrens";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdObjetoPadre", DetalleObjeto_Reporte.Params[DetalleObjeto_Reporte.KEYQIDOBJETO], TipodeDato.Int);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }
        catch (SIMADataException) {
            var ex = SIMADataException;
        }
    }


    DetalleObjeto_Reporte.OnEasyGridButton_Click = function (btnItem, DetalleBE) {

        switch (btnItem.Id) {
            case "btnAgregarSeccion":
                var ConfigMsgb = {
                    Titulo: 'Agregar Seccion de parámetros'
                    , Descripcion: DetalleObjeto_Reporte.ParamsSeccionTemplate({ Parametro: null, Tipo: null, TipoObj: "8" }, SIMA.Utilitario.Enumerados.ModoPagina.N)
                    , Icono: 'fa fa-list-alt'
                    , EventHandle: function (btn) {
                        if (btn == 'OK') {
                            try {
                                var NodoSelectDataBE = AdministrarReporte.Navigator.Node.Select.Data;
                                var oRow = EasyGridViewParamConfig.RowClone(3, function (Celda, index) {
                                    switch (index) {
                                        case 0:
                                            //crear la tabla de nodo principal
                                            var oNodo = new SIMA.GridTree.Nodo();
                                            oNodo.Nivel = 1;
                                            oNodo.Id = 1;
                                            oNodo.Text = jNet.get('txtNombre').value;
                                            oNodo.Descripcion = jNet.get('txtDescripcion').value;
                                            oNodo.TextoySubTexto = true;
                                            oNodo.IsFather = true;
                                            Celda.insert(SIMA.GridTree.Nodos.Crear(oNodo));
                                            break;

                                        case 4:
                                            Celda.insert(CtrlBase("EasyFormSeccion", SIMA.Utilitario.Constantes.ImgDataURL.IconSeccion));
                                            break;
                                    }
                                });
                                oRow.attr('Tiporow', '2');
                                //Agrega el registro al objeto datatable relacionado a la grilla
                                var oDataRow = oRow.GetData();
                                oDataRow["IdObjeto"] = 0;
                                oDataRow["IdPadre"] = NodoSelectDataBE.IdObjeto;//Id del registro seleccionado en el treeview
                                oDataRow["Nombre"] = jNet.get('txtNombre').value;
                                oDataRow["Ref1"] = "";
                                oDataRow["Ref2"] = "";
                                oDataRow["IdTipo"] = 8;
                                oDataRow["Descripcion"] = jNet.get('txtDescripcion').value;
                                oDataRow["ValorDefault"] = 0;
                                oDataRow["IdTipoControl"] = 1;
                                oDataRow["TipoControl"] = "EasyFormSeccion";
                                oDataRow["IdNodo"] = (oRow.rowIndex + 1).toString();
                                oDataRow["NroHijos"] = 0;
                                oDataRow["Nivel"] = 1;
                                EasyGridViewParamConfig.SetDataRow(oDataRow);
                            }
                            catch (SIMADataException) {
                                var msgConfig = { Titulo: "Error al intentar guardar la sección", Descripcion: SIMADataException.Message };
                                var oMsg = new SIMA.MessageBox(msgConfig);
                                oMsg.Alert();
                            }
                        }
                    }
                };
                var oMsg = new SIMA.MessageBox(ConfigMsgb);
                oMsg.confirm();
                break;

        }
    }

    function CtrlBase(Texto, Icono) {
        var oimg = jNet.create('img');
        oimg.attr("src", Icono);

        var CtrlTbl = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(1, 2);
        jNet.get(CtrlTbl.rows[0].cells[0]).insert(oimg);
        CtrlTbl.rows[0].cells[1].innerText = Texto;
        jNet.get(CtrlTbl.rows[0].cells[1]).attr("align", "left");

        CtrlTbl.attr("class", "BaseItem");
        CtrlTbl.attr("width", "100%");
        return CtrlTbl;
    }

    DetalleObjeto_Reporte.ParamSelected = null;//Representa el parametro activo o seleccionado
    DetalleObjeto_Reporte.ObjCtrlSelected = null;//Control activo o seleccionado

    function UltimoNrodeHijos(oRow) {
        var UltNroFila = oRow.rowIndex;
        var oDataRowActive = oRow.GetData();
        EasyGridViewParamConfig.ItemsforEach(function (Row) {
            var oDataRow = Row.GetData();
            var NodoId = oDataRow.IdNodo.toString().substring(0, oDataRowActive.IdNodo.toString().length);
            if (NodoId == oDataRowActive.IdNodo) {
                UltNroFila++;
            }
        });

        return UltNroFila;
    }



    DetalleObjeto_Reporte.ModifyParam = function (e) {
        var NodoSelectDataBE = AdministrarReporte.Navigator.Node.Select.Data;//Item Seleccionado del treeview
        var CtrlParam = jNet.get(e);
        DetalleObjeto_Reporte.ParamSelected = CtrlParam.attr("Data").toString().SerializedToObject();

        var ConfigMsgb = {
            Titulo: 'Modificar Parámetro'
            , Width: "600px"
            , Descripcion: DetalleObjeto_Reporte.ParamsSeccionTemplate(DetalleObjeto_Reporte.ParamSelected, SIMA.Utilitario.Enumerados.ModoPagina.M)
            , Icono: 'fa fa-tag'
            , EventHandle: function (btn) {
                if (btn == 'OK') {
                    // try {
                    CtrlParam.rows[0].cells[CtrlParam.rows[0].cells.length - 1].innerText = jNet.get('txtNombre').value;
                    CtrlParam.rows[1].cells[CtrlParam.rows[1].cells.length - 1].innerText = jNet.get('txtDescripcion').value;

                    var oDataParam = CtrlParam.attr("Data").toString().SerializedToObject();

                    var oRow = EasyGridViewParamConfig.GetRowActive();
                    var oDataRowActive = oRow.GetData();
                    oDataRowActive["Nombre"] = jNet.get('txtNombre').value;
                    oDataRowActive["Descripcion"] = jNet.get('txtDescripcion').value;
                    /* }
                     catch (SIMADataException) {
                         var msgConfig = { Titulo: "Error al intentar guardar el parámetro", Descripcion: "DetalleObjeto_Reporte.AddParam:" + SIMADataException.Message };
                         var oMsg = new SIMA.MessageBox(msgConfig);
                         oMsg.Alert();
                     }*/
                }
            }
        };
        var oMsg = new SIMA.MessageBox(ConfigMsgb);
        oMsg.confirm();



    }


    //Asignar parametros a la configuracion
    DetalleObjeto_Reporte.AddParam = function () {
        var NodoSelectDataBE = AdministrarReporte.Navigator.Node.Select.Data;//Item Seleccionado del treeview
        var oRow = EasyGridViewParamConfig.GetRowActive();
        if (oRow == null) {
            var msgConfig = { Titulo: "Error", Descripcion: "No se ha seleccionado sección de grupo para asignar los parámetros.." };
            var oMsg = new SIMA.MessageBox(msgConfig);
            oMsg.Alert();
            return;
        }
        var oDataRowActive = oRow.GetData();
        //Valida si la fila seleccionada de la grilla es de tipo SECCION
        if (oDataRowActive.IdTipoControl != 1) {
            var msgConfig = { Titulo: "Error", Descripcion: "La fila seleccionada no es una sección de grupo.." };
            var oMsg = new SIMA.MessageBox(msgConfig);
            oMsg.Alert();
            return;
        }

        //Valida si se ha seleccionado una seccion
        if ((oDataRowActive != undefined) && (oDataRowActive["IdTipoControl"] == 1)) {
            var ConfigMsgb = {
                Titulo: 'Configurar Parámetro'
                , Descripcion: DetalleObjeto_Reporte.ParamsSeccionTemplate(DetalleObjeto_Reporte.ParamSelected, SIMA.Utilitario.Enumerados.ModoPagina.N)
                , Icono: 'fa fa-tag'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        // try {
                        var CtrlParam = jNet.get("p_" + jNet.get('txtParametro').value);
                        CtrlParam.addEvent("click", function () {
                            DetalleObjeto_Reporte.ModifyParam(this);
                        });

                        var oDataParam = CtrlParam.attr("Data").toString().SerializedToObject();

                        oDataRowActive["NroHijos"] = parseInt(oDataRowActive["NroHijos"]) + 1;
                        var NewPos = UltimoNrodeHijos(oRow);//Aqui l Ultimo nro de fila obtenido del grupo
                        var rowNew = EasyGridViewParamConfig.InsertRow(NewPos, function (Celda, i) {
                            switch (i) {
                                case 0:
                                    CtrlParam.attr("class", "ItemDisponible");
                                    CtrlParam.rows[0].cells[1].innerText = jNet.get('txtNombre').value;
                                    Celda.insert(CtrlParam);
                                    break
                                case 1:
                                    Celda.innerText = jNet.get('txtParametro').value;
                                    break
                                case 2:
                                    Celda.innerText = DetalleObjetoSeccion.Params[DetalleObjetoSeccion.KEYQTIPOPARAM];
                                    break
                                case 4://Inserta el objeto de tipo parametro en la celda
                                    Celda.attr('align', 'right');
                                    Celda.insert(DetalleObjeto_Reporte.Btn_link_Ctrl());

                                    break;
                            }

                        });
                        //Actualiza la data----------------------------------------------------------------------
                        oDataParam.Nombre = jNet.get('txtNombre').value;
                        oDataParam.Descripcion = jNet.get('txtDescripcion').value;
                        CtrlParam.attr("Data", oDataParam.Serialized());
                        //----------------------------------------------------------------------------------------
                        var oDataRow = rowNew.GetData();
                        oDataRow["IdObjeto"] = 0;
                        oDataRow["IdPadre"] = "0";//Id del registro seleccionado en el treeview
                        oDataRow["Nombre"] = oDataParam.Nombre;
                        oDataRow["Ref1"] = oDataParam.Parametro;//Nombre del parametro 
                        oDataRow["Ref2"] = oDataParam.Tipo;
                        oDataRow["Ref3"] = oDataParam.Posicion;
                        oDataRow["IdTipo"] = 9;
                        oDataRow["Descripcion"] = oDataParam.Descripcion;
                        oDataRow["ValorDefault"] = 0;
                        oDataRow["IdTipoControl"] = 0;//Toma valor de cero por que al parametro aun no se le define a que control estara asignado
                        oDataRow["TipoControl"] = "";
                        oDataRow["IdNodo"] = oDataRowActive["IdNodo"].toString() + "." + NewPos.toString();
                        oDataRow["NroHijos"] = 0;
                        oDataRow["Nivel"] = 2;
                        EasyGridViewParamConfig.SetDataRow(oDataRow);


                        /* }
                         catch (SIMADataException) {
                             var msgConfig = { Titulo: "Error al intentar guardar el parámetro", Descripcion: "DetalleObjeto_Reporte.AddParam:" + SIMADataException.Message };
                             var oMsg = new SIMA.MessageBox(msgConfig);
                             oMsg.Alert();
                         }*/
                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();

        }
        else {
            var msgConfig = { Titulo: "Error", Descripcion: "No se ha seleccionado una sección<br>para configurar un parámetro deberá  de seleccionar una SECCION de grupo" };
            var oMsg = new SIMA.MessageBox(msgConfig);
            oMsg.Alert();
        }
    }


    DetalleObjeto_Reporte.Btn_link_Ctrl = function () {
        var btnAdd = jNet.create('img');
        btnAdd.attr("src", SIMA.Utilitario.Constantes.ImgDataURL.IconToolBar);
        btnAdd.addEvent("click", ListarCtrlaVincular);
        return btnAdd;
    }

    function ListarCtrlaVincular() {
        var oCellContent = jNet.get(this.parentNode);
        //Todos los tipos de controles
        var ConfigMsgb = {
            Titulo: 'VINCULAR CONTROL'
            , Descripcion: DetalleObjeto_Reporte.iTemplateTipoControl()
            , Icono: 'fa fa-link'
            , EventHandle: function (btn) {
                if (btn == 'OK') {
                    var oCtrlDataBE = DetalleObjeto_Reporte.ObjCtrlSelected;
                    var oCtrlObj = jNet.get("Ctrl_" + oCtrlDataBE.CODIGO).clone();

                    oCtrlObj.attr("id", "Ctrl_Link_" + oCtrlDataBE.CODIGO).attr("border", "4px");
                    oCtrlObj.css("height", "30px");

                    //Agregar una celda al control para r el boton eliminar
                    var oCellDel = jNet.create("td");
                    var oImgDel = jNet.create("img");
                    var oStr = "";
                    oImgDel.attr("CODIGO", oCtrlDataBE.CODIGO);
                    oImgDel.addEvent("click", EliminarCtrlLink);
                    oImgDel.attr("src", SIMA.Utilitario.Constantes.ImgDataURL.ImgClose);
                    oCellDel.insert(oImgDel);
                    jNet.get(oCtrlObj.rows[0]).insert(oCellDel);

                    oCellContent.clear();
                    //Obtener los datos de la fila al que contiene el parametros al cual se vilculara el control
                    var oFilaActiva = jNet.get(oCellContent.parentNode);
                    var oDataRow = oFilaActiva.GetData();
                    oDataRow["IdTipoControl"] = oCtrlDataBE.CODIGO;
                    oCellContent.insert(oCtrlObj);
                }
            }
        };
        var oMsg = new SIMA.MessageBox(ConfigMsgb);
        oMsg.confirm();
    }

    function EliminarCtrlLink(e) {
        var objImg = ((e.tagName == undefined) ? this : e);
        var _Codigo = jNet.get(objImg).attr("CODIGO");
        var oCellContent = jNet.get(jNet.get("Ctrl_Link_" + _Codigo).parentNode);

        var ConfigMsgb = {
            Titulo: 'Eliminar enlace..'
            , Descripcion: "Desea eliminar este enlace del Control al parámetro  ahora?"
            , Icono: 'fa fa-chain-broken'
            , EventHandle: function (btn) {
                if (btn == 'OK') {
                    try {
                        oCellContent.clear();
                        oCellContent.attr('align', 'right');
                        //Creare el boton linkcontrol
                        oCellContent.insert(DetalleObjeto_Reporte.Btn_link_Ctrl());
                        //Desasocia el control de la data
                        var oDataRow = EasyGridViewParamConfig.GetRowActive().GetData();
                        oDataRow["IdTipoControl"] = "0";
                    }
                    catch (SIMADataException) {
                        var msgConfig = { Titulo: "Error al intentar eliminar este enlace", Descripcion: SIMADataException.Message };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                    }
                }
            }
        };
        var oMsg = new SIMA.MessageBox(ConfigMsgb);
        oMsg.confirm();
    }


    DetalleObjeto_Reporte.LstParamRemove = new Array();
    //Quita el parametro de la configuracion
    DetalleObjeto_Reporte.RemoveParam = function () {
        var ConfigMsgb = {
            Titulo: 'Eliminar Configuración..'
            , Descripcion: "Desea eliminar esta configuración ahora?"
            , Icono: 'fa fa-cogs'
            , EventHandle: function (btn) {
                if (btn == 'OK') {
                    var otr = EasyGridViewParamConfig.GetRowActive();
                    var odr = otr.GetData();
                    var NodoPadre = odr["IdNodo"];

                    if (odr["IdTipoControl"] = "1") {
                        EasyGridViewParamConfig.ItemsforEach(function (oRow, i) {
                            var odrNodo = oRow.GetData();
                            var NodoComparado = odrNodo["IdNodo"].toString();
                            var GuidDel = odrNodo["Guid"];
                            var FragNodo = NodoComparado.substring(0, NodoPadre.length);
                            if (NodoPadre == FragNodo) {
                                //Buscar Nombre de Parametro en el datatable
                                EasyGridViewParamConfig.DeleteRow(GuidDel);
                                var oRows = oDT_EasyGridViewParamConfig.Select("Guid", "=", GuidDel);
                                var _DataRow = oRows[0];
                                if (_DataRow["IdTipo"].toString().Equal('9')) {//Tipo Parametro
                                    DetalleObjeto_Reporte.LstParamRemove.Add(_DataRow["Ref1"]);
                                }
                            }
                        });
                    }
                    else {
                        EasyGridViewParamConfig.DeleteRowActive();
                        var oRows = oDT_EasyGridViewParamConfig.Select("Guid", "=", GuidDel);
                        var _DataRow = oRows[0];
                        if (_DataRow["IdTipo"].toString().Equal('9')) {//Tipo Parametro
                            DetalleObjeto_Reporte.LstParamRemove.Add(_DataRow["Ref1"]);
                        }
                    }
                    DetalleObjeto_Reporte.MetodoSeleccionado.PaintParametros(EasyListarMetodosRpt.GetText());
                }
            }
        };
        var oMsg = new SIMA.MessageBox(ConfigMsgb);
        oMsg.confirm();
    }
</script>


<script>

    EasyPopupReporteCarpeta.Validar = function () {
        var msg = ""; Valido = true;
        var msgConfig = null;

        if (EasyListaServiciosRpt.GetText().length == 0) {
            msgConfig = { Titulo: "Error", Descripcion: "No se ha ingresado el Nombre del servicio" };
            var oMsg = new SIMA.MessageBox(msgConfig);
            oMsg.Alert();
            return false;
        }
        if (EasyListarMetodosRpt.GetText().length == 0) {
            msgConfig = { Titulo: "Error", Descripcion: "No se ha ingresado el método de extraccioón de información" };
            var oMsg = new SIMA.MessageBox(msgConfig);
            oMsg.Alert();
            return false;
        }

        var NroItemParams = jNet.get('LstParamRpt').children.length;
        if (NroItemParams > 0) {
            msgConfig = { Titulo: "Error", Descripcion: "Aun quedan pendientes parámetros a configurar.." };
            var oMsg = new SIMA.MessageBox(msgConfig);
            oMsg.Alert();
            return false;
        }
        //Verifica si aun existen parametros que faltan por configurar
        if ((NroItemParams > 0) && (EasyGridViewParamConfig.RowCount() > 0)) {
            msgConfig = { Titulo: "Error", Descripcion: "No es posible guardar la informción, Existen parámetros sin faltan configurar" };
            var oMsg = new SIMA.MessageBox(msgConfig);
            oMsg.Alert();
            return false;
        }

        var Config = true;
        if (EasyGridViewParamConfig.RowCount() > 0) {
            EasyGridViewParamConfig.ItemsforEach(function (oRow) {
                var CtrlChild = oRow.cells[4].children[0];
                if (CtrlChild.tagName == "IMG") { Config = false; }
            });

            if (Config == false) {
                msgConfig = { Titulo: "Error", Descripcion: "algunos parámetros no estan asociados a controles..." };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
                return false;
            }

        }

        return true;
    }

    EasyPopupReporteCarpeta.Reporte = {};
    EasyPopupReporteCarpeta.Reporte.Agregar = function () {
        var oObjetoBE = new ObjetoBE();
        oObjetoBE.IdObjeto = 0;
        oObjetoBE.IdPadre = DetalleObjeto_Reporte.Params[DetalleObjeto_Reporte.KEYQIDOBJETO];
        oObjetoBE.Nombre = jNet.get("txtNombreRpt").value;
        oObjetoBE.IdTipo = "2";
        oObjetoBE.IdTipoControl = "0";
        oObjetoBE.Descripcion = "";
        oObjetoBE.Ref1 = jNet.get("txtRutaRpt").value + SIMA.Utilitario.Constantes.Caracter.Backslash + EasyFindFileRpt.GetText();
        oObjetoBE.Ref2 = jNet.get("txtPathWebServiceSelected").value + SIMA.Utilitario.Constantes.Caracter.Slash + EasyListaServiciosRpt.GetText();
        oObjetoBE.Ref3 = EasyListarMetodosRpt.GetText();
        oObjetoBE.Ref4 = ".pdf";
        oObjetoBE.IdUsuarioAnalista = UsuarioBE.IdUsuario;
        oObjetoBE.IdUsuarioSolicitante = UsuarioBE.IdUsuario;
        oObjetoBE.IdEstado = "1";
        oObjetoBE.IdUsuario = UsuarioBE.IdUsuario;
        oObjetoBE.UserName = UsuarioBE.UserName;
        oObjetoBE.OrdenXNivel = 0;
        var iResult = AdministrarReporte.Commit(oObjetoBE);//sE ENCUENTRA EN E FORMULARIO ADMINISTRAR
        oObjetoBE.IdObjeto = iResult;

        AdministrarReporte.Navigator.Node.Select = { Data: oObjetoBE };
        return oObjetoBE.IdObjeto;
    }

    EasyPopupReporteCarpeta.Reporte.Modificar = function () {
        var oObjetNodoBE = AdministrarReporte.Navigator.Node.Select.Data;
        var oObjetoBE = new ObjetoBE();
        oObjetoBE.IdObjeto = DetalleObjeto_Reporte.Params[DetalleObjeto_Reporte.KEYQIDOBJETO];
        oObjetoBE.IdPadre = oObjetNodoBE.IdPadre;
        oObjetoBE.Nombre = jNet.get("txtNombreRpt").value;
        oObjetoBE.IdTipo = oObjetNodoBE.IdTipo;
        oObjetoBE.IdTipoControl = oObjetNodoBE.IdTipoControl;
        oObjetoBE.Descripcion = oObjetNodoBE.Descripcion;
        oObjetoBE.Ref1 = jNet.get("txtRutaRpt").value + SIMA.Utilitario.Constantes.Caracter.Backslash + EasyFindFileRpt.GetText();
        oObjetoBE.Ref2 = jNet.get("txtPathWebServiceSelected").value + SIMA.Utilitario.Constantes.Caracter.Slash + EasyListaServiciosRpt.GetText();
        oObjetoBE.Ref3 = EasyListarMetodosRpt.GetText();
        oObjetoBE.Ref4 = ".pdf";
        oObjetoBE.IdUsuarioAnalista = oObjetNodoBE.IdUsuarioAnalista;
        oObjetoBE.IdUsuarioSolicitante = oObjetNodoBE.IdUsuarioSolicitante;
        oObjetoBE.IdEstado = "1";
        oObjetoBE.IdUsuario = UsuarioBE.IdUsuario;
        oObjetoBE.OrdenXNivel = 0;
        oObjetoBE.UserName = UsuarioBE.UserName;

        var iResult = AdministrarReporte.Commit(oObjetoBE);//sE ENCUENTRA EN E FORMULARIO ADMINISTRAR
        oObjetoBE.IdObjeto = iResult;

        return oObjetoBE.IdObjeto;
    }

    EasyPopupReporteCarpeta.Reporte.Administrar = function () {
        switch (DetalleObjeto_Reporte.Params[DetalleObjeto_Reporte.KEYMODOPAGINA]) {
            case SIMA.Utilitario.Enumerados.ModoPagina.N:
                return EasyPopupReporteCarpeta.Reporte.Agregar();
                break;
            case SIMA.Utilitario.Enumerados.ModoPagina.M:
                return EasyPopupReporteCarpeta.Reporte.Modificar();
                break;
        }
    }


    EasyPopupReporteCarpeta.Reporte.Params = {};
    EasyPopupReporteCarpeta.Reporte.Params.Eliminar = function () {
        oDT_EasyGridViewParamConfig.Select("Modo", "=", "E").forEach(function (_DataRow, i) {
            var oObjetoBE = new ObjetoBE();
            oObjetoBE.IdObjeto = _DataRow["IdObjeto"];
            oObjetoBE.IdPadre = _DataRow["IdPadre"];
            oObjetoBE.Nombre = _DataRow["Nombre"];
            oObjetoBE.IdTipo = _DataRow["IdTipo"];
            oObjetoBE.IdTipoControl = _DataRow["IdTipoControl"];
            oObjetoBE.Descripcion = _DataRow["Descripcion"];
            oObjetoBE.Ref1 = _DataRow["Ref1"];
            oObjetoBE.Ref2 = _DataRow["Ref2"];
            oObjetoBE.Ref3 = _DataRow["Ref3"];//Orden del parámetro
            oObjetoBE.Ref4 = null;
            oObjetoBE.OrdenXNivel = i;
            oObjetoBE.IdUsuarioAnalista = _DataRow["IdUsuarioAnalista"];
            oObjetoBE.IdUsuarioSolicitante = _DataRow["IdUsuarioSolicitante"];
            oObjetoBE.IdEstado = "0";
            oObjetoBE.IdUsuario = DetalleObjeto_Reporte.Params["IdUsuario"];
            oObjetoBE.UserName = DetalleObjeto_Reporte.Params["UserName"];

            var iResult = AdministrarReporte.Commit(oObjetoBE);
        });
    }
    EasyPopupReporteCarpeta.Reporte.Params.Guardar = function () {
        var DataReport = AdministrarReporte.Navigator.Node.Select.Data;
        var IdSeccion = 0;

        oDT_EasyGridViewParamConfig.Select("Modo", "=", "M").forEach(function (_DataRow, i) {

            var oObjetoBE = new ObjetoBE();
            oObjetoBE.IdObjeto = _DataRow["IdObjeto"];
            oObjetoBE.IdPadre = _DataRow["IdPadre"];
            oObjetoBE.Nombre = _DataRow["Nombre"];
            oObjetoBE.IdTipo = _DataRow["IdTipo"];
            oObjetoBE.IdTipoControl = _DataRow["IdTipoControl"];
            oObjetoBE.Descripcion = _DataRow["Descripcion"];
            oObjetoBE.Ref1 = _DataRow["Ref1"];
            oObjetoBE.Ref2 = _DataRow["Ref2"];
            oObjetoBE.Ref3 = _DataRow["Ref3"];//Orden del parámetro
            oObjetoBE.Ref4 = null;
            oObjetoBE.IdUsuarioAnalista = _DataRow["IdUsuarioAnalista"];
            oObjetoBE.IdUsuarioSolicitante = _DataRow["IdUsuarioSolicitante"];
            oObjetoBE.IdEstado = "1";
            oObjetoBE.IdUsuario = DetalleObjeto_Reporte.Params["IdUsuario"];
            oObjetoBE.UserName = DetalleObjeto_Reporte.Params["UserName"];
            oObjetoBE.OrdenXNivel = i;
            AdministrarReporte.Commit(oObjetoBE);
        });
        //Inserta los nuevos parametros


        oDT_EasyGridViewParamConfig.Select("Modo", "=", "N").forEach(function (_DataRow, i) {
            var oObjetoBE = new ObjetoBE();
            oObjetoBE.IdObjeto = 0;//_DataRow["IdObjeto"];
            oObjetoBE.IdPadre = ((_DataRow["IdTipo"].toString().Equal("8")) ? DataReport.IdObjeto : IdSeccion);
            oObjetoBE.Nombre = _DataRow["Nombre"];
            oObjetoBE.IdTipo = _DataRow["IdTipo"];
            oObjetoBE.IdTipoControl = _DataRow["IdTipoControl"];
            oObjetoBE.Descripcion = _DataRow["Descripcion"];
            oObjetoBE.Ref1 = _DataRow["Ref1"];
            oObjetoBE.Ref2 = _DataRow["Ref2"];
            oObjetoBE.Ref3 = ((_DataRow["Ref3"] == undefined) ? null : _DataRow["Ref3"]);//Orden del parámetro
            oObjetoBE.Ref4 = null;
            oObjetoBE.IdUsuarioAnalista = 0;
            oObjetoBE.IdUsuarioSolicitante = 0;
            oObjetoBE.OrdenXNivel = i;
            oObjetoBE.IdEstado = "1";
            oObjetoBE.IdUsuario = DetalleObjeto_Reporte.Params["IdUsuario"];
            oObjetoBE.UserName = DetalleObjeto_Reporte.Params["UserName"];
            if (oObjetoBE.IdTipo == SIMA.Utilitario.Enumerados.TipoObjeto.Secciondeparametros) {
                IdSeccion = AdministrarReporte.Commit(oObjetoBE);
                _DataRow["IdObjeto"] = IdSeccion;
            }
            else {
                oObjetoBE.IdPadre = IdSeccion;
                var IdResult = AdministrarReporte.Commit(oObjetoBE);
                _DataRow["IdObjeto"] = IdResult;
                // _DataRow["IdPadre"] = IdSeccion;
            }
        });
    }




    var expad = false;
    EasyPopupReporteCarpeta.Aceptar = function () {



        if (EasyPopupReporteCarpeta.Validar()) {
            var Idobj = EasyPopupReporteCarpeta.Reporte.Administrar();

            // Adminitrar PARAMETROS
            // EasyPopupReporteCarpeta.Reporte.Params.Eliminar(); cuando se estabilice con el nuevo planteamiento se debera de eliminar esta funcion
            if (ReiniciaParametros == true) {
                DetalleObjeto_Reporte.BackupParam(generateUUID());
                ReiniciaParametros = false;
            }

            EasyPopupReporteCarpeta.Reporte.Params.Guardar();
            try {
                // AdministrarReporte.Navigator.Node.SelectActivate();
                if (AdministrarReporte.Navigator.Node.Select.children.length >= 1) {
                    AdministrarReporte.Navigator.Node.Select.children.forEach(function (NodeChild, i) {
                        treeObjet.removeNode(NodeChild, false);
                    });
                    AdministrarReporte.Navigator.Node.Select.Load = false;
                    treeObjet.updateNode(AdministrarReporte.Navigator.Node.Select);

                    AdministrarReporte.Navigator.LoadChilds(AdministrarReporte.Navigator.Node.Select);
                    treeNode.Load = true;
                    treeObjet.updateNode(AdministrarReporte.Navigator.Node.Select);
                }
                SIMA.Utilitario.Helper.ClearContent("treePropiedades");
            }
            catch (ex) {
            }
            return true;
        }
    }
</script>
</html>
