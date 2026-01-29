<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarPropiedades.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.AdministrarPropiedades" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <style>
        .NodoParam{
              Color:Blue;
        }
        .NodoParam td {
            font-weight:bold;
            font-size:16px;
            Color:Blue;
        }
       input[type=checkbox] {
              margin-left :10px;
              margin-top :10px;
              transform: scale(1.5);
            }
      
    </style>

    <script>
        function ExpandeCollapse(oImg,IdNodo,NroFila){
            var oldSrc = oImg.src;
            var Visibilidad = ((oImg.src==SIMA.Utilitario.Constantes.ImgDataURL.IconTreePlus)?"BLOCK":"NONE");
            oImg.src=((oldSrc==SIMA.Utilitario.Constantes.ImgDataURL.IconTreePlus)?SIMA.Utilitario.Constantes.ImgDataURL.IconTreeMinus:SIMA.Utilitario.Constantes.ImgDataURL.IconTreePlus);
        }
        function onClick_SelectedRow(e) {
            var oRow = e.parentNode.parentNode;
            document.querySelector(oRow).click();
           //SIMA.GridView.Extended.OnEventClickChangeColor(oRow);
        }
        function on_ddlSeleted(ListItem) {
            var oRow = jNet.get(ListItem.parentNode.parentNode.parentNode);
            var _RowExist = EasyGridViewPropiedades.RowFind(oRow.attr("Guid"));
            var _Data = _RowExist.GetData();
            var _VaLor = "";
            if (AdministrarPropiedades.Params[AdministrarPropiedades.KEYQIDTIPOCONTROL] == "8") {
                _VaLor = ListItem.text;
                if (_Data["Valor"].toString().NotEqual(_VaLor)) {
                    AdministrarPropiedades.Modificar(_Data, _VaLor);
                }
            }
            else {
                _VaLor = ListItem.value;
                if (_Data["Valor"].toString().NotEqual(_VaLor)) {
                    AdministrarPropiedades.Modificar(_Data, _VaLor);
                }
            }
        }

        function on_txtChange(e) {
            var oRow = jNet.get(e.parentNode.parentNode);
            var _RowExist = EasyGridViewPropiedades.RowFind(oRow.attr("Guid"));
            var _Data = _RowExist.GetData();

            var _VaLor = e.GetValue();
            if (_Data["Valor"].toString().NotEqual(_VaLor)) {
                AdministrarPropiedades.Modificar(_Data, _VaLor);
            }
        }
        function on_Checked(e) {
            var oRow = jNet.get(e.parentNode.parentNode);
            var _RowExist = EasyGridViewPropiedades.RowFind(oRow.attr("Guid"));
            var _Data = _RowExist.GetData();
            
            AdministrarPropiedades.Modificar(_Data, ((event.target.checked==true)?"True":"False"));

           /* var _DataR = EasyGridViewPropiedades.GetDataRow();
            var _VaLor = e.GetValue();
            if (_DataR["Valor"].toString().NotEqual(_VaLor)) {
                AdministrarPropiedades.Modificar(_DataR, _VaLor);
            }*/
        }


        function DataCopy(Source, Target) {
            if (null == Source || "object" != typeof Source) return Source;
            for (var attr in Source) {
                if (attr != "Guid") {
                    if (Source.hasOwnProperty(attr)) Target[attr] = Source[attr];
                }
            }
        }

        function onPropertyItemWebServiceSeleccionado(value, ItemBE) {
            var PathService = ItemBE.Ruta;//.Replace('.', '/');
            var PathApp = GetRutaApp();
            PathService = PathService.toString().Replace(PathApp, "")
            PathService = "/" + PathService.Replace(".", "/"); 
            PathService = PathService.toString().substring(0, (PathService.length-1));

            jNet.get("txtPathWebServiceSelectedP").value = PathService;
            /*--------------------------------------------------------------------------------------------------*/
            var _Row = EasyGridViewPropiedades.GetRowActive();
            _dr = _Row.GetData();
          
            var id = AdministrarPropiedades.Modificar(_dr, GetRutaPaginaServicioASMX());//Almacena el metodo
            /*--------------------------------------------------------------------------------------------------*/
        }

     
        function GetRutaApp() {
            return AdministrarPropiedades.PhysicalApplicationPath;
        }
        function GetNameSpaceDLL() {
            return AdministrarPropiedades.NameSpaceBaseDll;
        }


        function GetRutaPaginaServicioASMX() {
            var strPath = jNet.get("txtPathWebServiceSelectedP").value + SIMA.Utilitario.Constantes.Caracter.Slash + EasyListaServiciosRpt.GetText();
            return strPath;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
      
                    <cc1:EasyGridView ID="EasyGridViewPropiedades" runat="server" AutoGenerateColumns="False" TituloHeader="DETALLE" ToolBarButtonClick="" Width="100%" OnRowDataBound="EasyGridViewPropiedades_RowDataBound" ShowRowNumber="False" fncExecBeforeServer="">
                         <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />

                        <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" ></EasyExtended>

                    <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                        <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                        <Columns>
                            <asp:BoundField DataField="Nombre" HeaderText="ATRIBUTO">
                            <ItemStyle HorizontalAlign="Left" Width="20%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="VALOR">
                            <ItemStyle Width="80%"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="HeaderGrilla" Height="25px" />
                        <RowStyle CssClass="ItemGrilla" Height="35px" />
                    </cc1:EasyGridView>

                    <asp:TextBox ID="txtPathWebServiceSelectedP" ReadOnly="true" runat="server" CssClass="form-control"></asp:TextBox>
    </form>
</body>
    <script>

        function OnEasyGridDetalle_Click(ItemRowBE) {
          //  alert();
        }

        AdministrarPropiedades.AgregarParametros = function (RowContent,IdObj) {
            alert(IdObj);
        }

        AdministrarPropiedades.HtmlTemplate = function (ul, item) {
            var cmll = "\"";
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '<div class= "flex-column">' + item.Nombre
                + '    <p><small style="font-weight: bold">FECHA DE CREACIÓN:</small> <small style ="color:red">' + item.FCreacion + '</small><br>'
                + '    <small style="font-weight: bold">UBICACIÓN:</small><small style="color:blue;text-transform: capitalize;">' + item.Ruta.Replace('.', String.fromCharCode(92, 92)) + '</small></p>'
                + '    <span class="badge badge-info "> ' + item.FAcceso + '</span>'
                + '</div>'
                + '</a>';
            return iTemplate;
        }

        AdministrarPropiedades.EasyMetodosHTMLTemplate = function (ul, item) {
            var cmll = "\"";
            var arrParam = item.LstParametros.split(',');
            var strParam = "";
            arrParam.forEach(function (item, i) {
                var Tipo_Param = item.split(' ');
                if (i == 0) {
                    
                    strParam += '<td style="color: green; font-family: Arial; font-size: 15px;text-align: center;"><mark>' + Tipo_Param[0] + '</mark></td>' + '<td style="color: #80b3ff; font-family: Arial; font-size: 14px;padding-left:5px;padding-right:10px"><b><mark>' + Tipo_Param[1] + ((i == (arrParam.length - 1)) ? "" : ",") + '</b></mark></td>';
                }
                else {
                    strParam += '<td style="color: blue; font-family: Arial; font-size: 15px;text-align: center;">' + Tipo_Param[0] + '</td>' + '<td style="color: #80b3ff; font-family: Arial; font-size: 14px;padding-left:5px;padding-right:10px">' + Tipo_Param[1] + ((i == (arrParam.length - 1)) ? "" : ",") + '</td>';
                }
            });

            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" >'
                + '<div class= "flex-column">'
                + '<table><tr height="35px"> <td style="color:#000099; font-family: Arial; font-size: 16px;font-weight: bold;">' + item.Metodo + '</td> <td style="color:red; font-family: Arial; font-size: 18px;font-weight: bold;">(</td>' + strParam + '</td> <td style="color:red; font-family: Arial; font-size: 18px;font-weight: bold;">)</td> </tr></table>'
                + '</div>'
                + '</a>';
            return iTemplate;
        }

        AdministrarPropiedades.EasyMetodosTemplate = function (ul, item) {
            var oCustomTemplateBE = new EasyListarMetodosRpt.CustomTemplateBE(ul, item, AdministrarPropiedades.EasyMetodosHTMLTemplate(ul, item));
            return EasyListarMetodosRpt.SetCustomTemplate(oCustomTemplateBE);
        }

        AdministrarPropiedades.BackupParam = function (_gUid) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore  + "GestionReportes/AdministrarReportes.asmx";
            oEasyDataInterConect.Metodo = "BackupParam";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("Guid", _gUid);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdObjeto", AdministrarReporte.Navigator.Node.Select.Data.IdObjeto);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", AdministrarPropiedades.Params["UserName"]);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;
            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var Result = oEasyDataResult.sendData();
        }




        AdministrarPropiedades.EasyListarParametroMetodoSelected = function (value, ItemBE) {
            //Array que contendra los controles encontrados en los atributia dependientes de UrlWebServicieParams
            var arrCtrlAttr = new Array();

            /*var oRowParam = EasyGridViewParam.GetRowActive();
            var oDataRowParam = oRowParam.GetData();*/

            var oDataRowParam = AdministrarReporte.Navigator.Node.Select.Data;
            var strObjTostr = "";
            var _Row = EasyGridViewPropiedades.GetRowActive();
            _dr = _Row.GetData();


            //Eliminar los parametros del Metodo seleccionado
            AdministrarPropiedades.BackupParam(generateUUID());

            //ALmacena los valores del metodo seleccionado
            /*--------------------------------------------------------------------------------------------------*/
            AdministrarPropiedades.Modificar(_dr, ItemBE.Metodo);//Almacena el metodo
            /*--------------------------------------------------------------------------------------------------*/

            var rowIni = (_Row.rowIndex + 2);
            //Se deberá  de obtener el id del atributo UrlWebServicieParams, para usar su defincion segun los  hijos 

            var oDataTable = new SIMA.Data.DataTable('tbl');
            oDataTable = AdministrarPropiedades.Metodo.DataParametros(ItemBE.Metodo);//Lista los parametros del metodo seleccionado

            var NomCtrl = oDataRowParam["TipoControl"].toString();//Asociado al parametro
            var IdGrp = 0;

            oDataTable.Rows.forEach(function (oDataRow, i) {
                if (NomCtrl.toString().Equal("EasyAutocompletar") || NomCtrl.toString().Equal("EasyListAutocompletar")) {
                    if (oDataRow["Posicion"].toString().NotEqual("0")) {// 0 Obvia el primer parametro que esta resevardo para el control en la busqueda
                        if (oDataRow["Posicion"].toString().Equal("1")) {
                            EasyGridViewPropiedades.ItemsforEach(function (oRow, i) {
                                if (oRow.rowIndex == rowIni) {
                                    var _Data = oRow.GetData();
                                    _Data["IdGrp"] = IdGrp;
                                    _Data["OrdenParam"] = rowIni;//Orden de los campos de control de parametros 
                                    var CtrlNodo = jNet.get(oRow.cells[0].children[0]);
                                    if (_Data["IdAtributo"].toString().Equal("18") ||
                                        _Data["IdAtributo"].toString().Equal("31") ||
                                        _Data["IdAtributo"].toString().Equal("64") ||
                                        _Data["IdAtributo"].toString().Equal("20") ||
                                        _Data["IdAtributo"].toString().Equal("33") ||
                                        _Data["IdAtributo"].toString().Equal("66")) {
                                        CtrlNodo.attr("class", "NodoParam");
                                    }
                                    var objCtrl = jNet.get(oRow.cells[1].children[0]);
                                    arrCtrlAttr.Add({ HtmlNodo: CtrlNodo.clone(), Ctrl: objCtrl.clone(), Data: _Data });//Almacena control y data

                                    if (_Data["IdAtributo"].toString().Equal("21")
                                        || _Data["IdAtributo"].toString().Equal("34")
                                        || _Data["IdAtributo"].toString().Equal("67")) {
                                        objCtrl.SetDefault();
                                        AdministrarPropiedades.Modificar(_Data, "0");
                                    }
                                    else if (_Data["IdAtributo"].toString().Equal("18")
                                        || _Data["IdAtributo"].toString().Equal("31")
                                        || _Data["IdAtributo"].toString().Equal("64")) {
                                        objCtrl.SetValue(oDataRow["Parametro"].toString());
                                        AdministrarPropiedades.Modificar(_Data, oDataRow["Parametro"].toString());
                                    }
                                    else if (_Data["IdAtributo"].toString().Equal("20")
                                        || _Data["IdAtributo"].toString().Equal("33")
                                        || _Data["IdAtributo"].toString().Equal("66")) {//Tipo de datos                                    
                                          objCtrl.SetValue(oDataRow["Tipo"].toString());
                                          AdministrarPropiedades.Modificar(_Data, oDataRow["Tipo"].toString());
                                    }
                                    else {
                                        objCtrl.SetValue("");
                                        AdministrarPropiedades.Modificar(_Data, "");
                                    }
                                    rowIni++;
                                }

                            });
                          
                        }
                        else {
                            //Continua con los siguientes campos crear 3 Filas
                            //Aqui el for de la data con los atributos del UrlWebServicieParams
                            arrCtrlAttr.forEach(function (itemCtrl, i) {
                                EasyGridViewPropiedades.InsertRow(rowIni, function (_Col, i) {
                                    var _Data = itemCtrl.Data;//Data de la fila de referencia ya existente
                                    var _RowNew = _Col.parentNode;
                                    var _DataNew = _RowNew.GetData();
                                    DataCopy(_Data, _DataNew);
                                    _DataNew["IdGrp"] = IdGrp;
                                    _DataNew["OrdenParam"] = rowIni;//Orden de los campos de control de parametros 
                                    _DataNew["IdAttValor"] = "0";
                                    switch (i) {
                                        case 0:
                                            _Col.attr("align", "left");
                                            var NClon = jNet.get(itemCtrl.HtmlNodo).clone();
                                            _Col.insert(NClon);//Nodo del parámetro
                                            if (_DataNew["IdAtributo"].toString().Equal("18") ||
                                                _DataNew["IdAtributo"].toString().Equal("31") ||
                                                _DataNew["IdAtributo"].toString().Equal("64") ||
                                                _DataNew["IdAtributo"].toString().Equal("20") ||
                                                _DataNew["IdAtributo"].toString().Equal("33") ||
                                                _DataNew["IdAtributo"].toString().Equal("66")
                                                ) {
                                                NClon.attr("class", "NodoParam");
                                            }
                                            _Col.insert(NClon);
                                            break;
                                        case 1:
                                            var ctr = itemCtrl.Ctrl.clone();
                                            ctr.attr("id", "Ctrl" + _RowNew.rowIndex.toString());
                                            if (_DataNew["IdAtributo"].toString().Equal("21")
                                                || _DataNew["IdAtributo"].toString().Equal("34")
                                                || _DataNew["IdAtributo"].toString().Equal("67")) {
                                                ctr.selectedIndex = 0;
                                                ctr.addEvent("blur", function () { on_ddlSeleted(this); });
                                                AdministrarPropiedades.Modificar(_DataNew, "0");
                                            }
                                            else if (_DataNew["IdAtributo"].toString().Equal("18")
                                                || _DataNew["IdAtributo"].toString().Equal("31")
                                                || _DataNew["IdAtributo"].toString().Equal("64")) {
                                                ctr.attr("value", oDataRow["Parametro"].toString());
                                                ctr.addEvent("blur", function () { on_txtChange(this); });
                                                AdministrarPropiedades.Modificar(_DataNew, oDataRow["Parametro"].toString());
                                            }
                                            else if (_DataNew["IdAtributo"].toString().Equal("20")
                                                || _DataNew["IdAtributo"].toString().Equal("33")
                                                || _DataNew["IdAtributo"].toString().Equal("66")) {//Tipo de datos                                    
                                                ctr.attr("value", oDataRow["Tipo"].toString());
                                                AdministrarPropiedades.Modificar(_DataNew, oDataRow["Tipo"].toString());
                                            }
                                            else {
                                                ctr.value = "";
                                                ctr.addEvent("blur", function () { on_txtChange(this); });
                                                AdministrarPropiedades.Modificar(_DataNew, "");
                                            }

                                            _Col.insert(ctr);
                                            break;
                                    }
                                });
                                rowIni++;
                            });
                        }

                        IdGrp++;
                    }
                }
                else if (NomCtrl.toString().Equal("EasyDropdownList")) {//Para el capo que el control sea ddl
                    if (oDataRow["Posicion"].toString().Equal("0")) {
                        EasyGridViewPropiedades.ItemsforEach(function (oRow, i) {
                            if (oRow.rowIndex == rowIni) {
                                var _Data = oRow.GetData();
                                _Data["IdGrp"] = IdGrp;
                                _Data["OrdenParam"] = rowIni;//Orden de los campos de control de parametros 
                                var CtrlNodo = jNet.get(oRow.cells[0].children[0]);
                                if (_Data["IdAtributo"].toString().Equal("18") ||//ParamName
                                    _Data["IdAtributo"].toString().Equal("31") ||
                                    _Data["IdAtributo"].toString().Equal("64") ||
                                    _Data["IdAtributo"].toString().Equal("20") ||//TipodeDato
                                    _Data["IdAtributo"].toString().Equal("33") ||
                                    _Data["IdAtributo"].toString().Equal("66")) {
                                    CtrlNodo.attr("class", "NodoParam");
                                }

                                var objCtrl = jNet.get(oRow.cells[1].children[0]);
                                arrCtrlAttr.Add({ HtmlNodo: CtrlNodo.clone(), Ctrl: objCtrl.clone(), Data: _Data });//Almacena control clonado de las celdas y data

                                if (_Data["IdAtributo"].toString().Equal("21")
                                    || _Data["IdAtributo"].toString().Equal("34")
                                    || _Data["IdAtributo"].toString().Equal("67")) {//tipo de obtencion del valor
                                    objCtrl.SetDefault();
                                    AdministrarPropiedades.Modificar(_Data, "0");//ddList contiene el tipo de obtencion de los datos
                                }
                                else if (_Data["IdAtributo"].toString().Equal("18")
                                    || _Data["IdAtributo"].toString().Equal("31")
                                    || _Data["IdAtributo"].toString().Equal("64")) {//ParamName
                                        objCtrl.SetValue(oDataRow["Parametro"].toString());
                                        objCtrl.attr("readonly", "readonly");
                                        objCtrl.attr("class","form-control");
                                        AdministrarPropiedades.Modificar(_Data, oDataRow["Parametro"].toString());
                                }
                                else if (_Data["IdAtributo"].toString().Equal("20")
                                    || _Data["IdAtributo"].toString().Equal("33")
                                    || _Data["IdAtributo"].toString().Equal("66")) {//TipodeDato
                                        objCtrl.SetValue(oDataRow["Tipo"].toString());
                                        objCtrl.attr("readonly", "readonly");
                                        objCtrl.attr("class","form-control");
                                        AdministrarPropiedades.Modificar(_Data, oDataRow["Tipo"].toString());
                                }
                                else {
                                    objCtrl.SetValue("");
                                    AdministrarPropiedades.Modificar(_Data, "");
                                }
                                rowIni++;
                            }
                        });
                    }
                    else {
                        //Continua con los siguientes campos crear 3 Filas
                        //Aqui el for de la data con los atributos del UrlWebServicieParams
                        arrCtrlAttr.forEach(function (itemCtrl, i) {
                            EasyGridViewPropiedades.InsertRow(rowIni, function (_Col, i) {
                                var _Data = itemCtrl.Data;//Data de la fila de referencia ya existente
                                var _RowNew = _Col.parentNode;
                                var _DataNew = _RowNew.GetData();
                                DataCopy(_Data, _DataNew);
                                _DataNew["IdGrp"] = IdGrp;
                                _DataNew["OrdenParam"] = rowIni;//Orden de los campos de control de parametros 
                                _DataNew["IdAttValor"] = "0";
                                switch (i) {
                                    case 0:
                                        _Col.attr("align", "left");
                                        var NClon = jNet.get(itemCtrl.HtmlNodo).clone();
                                        _Col.insert(NClon);//Nodo del parámetro

                                        if (_DataNew["IdAtributo"].toString().Equal("18") ||
                                            _DataNew["IdAtributo"].toString().Equal("31") ||
                                            _DataNew["IdAtributo"].toString().Equal("64") ||
                                            _DataNew["IdAtributo"].toString().Equal("20") ||
                                            _DataNew["IdAtributo"].toString().Equal("33") ||
                                            _DataNew["IdAtributo"].toString().Equal("64") ||
                                            _DataNew["IdAtributo"].toString().Equal("66") 
                                        ){
                                            NClon.attr("class","NodoParam");
                                        }

                                        break;
                                    case 1:
                                        var ctr = itemCtrl.Ctrl.clone();
                                        ctr.attr("id", "Ctrl" + _RowNew.rowIndex.toString());
                                        if (_DataNew["IdAtributo"].toString().Equal("21")
                                            || _DataNew["IdAtributo"].toString().Equal("34")
                                            || _DataNew["IdAtributo"].toString().Equal("67")) {
                                            ctr.selectedIndex = 0;
                                            ctr.addEvent("blur", function () { on_ddlSeleted(this); });
                                            AdministrarPropiedades.Modificar(_DataNew, "0");
                                        }
                                        else if (_DataNew["IdAtributo"].toString().Equal("18")
                                            || _DataNew["IdAtributo"].toString().Equal("31")
                                            || _DataNew["IdAtributo"].toString().Equal("64")) {
                                            ctr.attr("value", oDataRow["Parametro"].toString());
                                            ctr.attr("readonly", "readonly");
                                            ctr.attr("class", "form-control");

                                            ctr.addEvent("blur", function () { on_txtChange(this); });
                                            AdministrarPropiedades.Modificar(_DataNew, oDataRow["Parametro"].toString());
                                        }
                                        else if (_DataNew["IdAtributo"].toString().Equal("20")
                                            || _DataNew["IdAtributo"].toString().Equal("33")
                                            || _DataNew["IdAtributo"].toString().Equal("66")) {//Tipo de datos                                    
                                            ctr.attr("value", oDataRow["Tipo"].toString());
                                            ctr.attr("readonly", "readonly");
                                            ctr.attr("class", "form-control");
                                            AdministrarPropiedades.Modificar(_DataNew, oDataRow["Tipo"].toString());
                                        }
                                        else {
                                            ctr.value = "";
                                            ctr.addEvent("blur", function () { on_txtChange(this); });
                                            AdministrarPropiedades.Modificar(_DataNew, "");
                                        }
                                        _Col.insert(ctr);
                                        break;
                                }
                            });
                            rowIni++;
                        });
                    }
                    IdGrp++;
                }
              
            });
        }

       


        AdministrarPropiedades.Metodo = {};
        AdministrarPropiedades.Metodo.DataParametros = function (Metodo) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
            oEasyDataInterConect.Metodo = "ListarParametrosdeMetodo";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("Metodo", Metodo);
            oParamCollections.Add(oParam);
            //  oParam = new SIMA.Param("PathBase", jNet.get('TxtPathServicio').value);
            oParam = new SIMA.Param("PathBase", GetNameSpaceDLL());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("PathWS", GetRutaPaginaServicioASMX());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", AdministrarPropiedades.Params["UserName"]);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var oDataTable = new SIMA.Data.DataTable('tbl');
            return oEasyDataResult.getDataTable();
        }


     

        AdministrarPropiedades.Modificar = function (oDataRow, Valor) {
            var oObjetoConfigAttrBE = new ObjetoConfigAttrBE();
                oObjetoConfigAttrBE.IdAtributoValor = oDataRow["IdAttValor"];
                oObjetoConfigAttrBE.IdObjeto = oDataRow["IdObjeto"];
                oObjetoConfigAttrBE.IdAtributo = oDataRow["IdAtributo"];
                oObjetoConfigAttrBE.Valor = Valor;
                oObjetoConfigAttrBE.Orden = oDataRow["OrdenParam"];
                oObjetoConfigAttrBE.IdGrp = oDataRow["IdGrp"];
                oObjetoConfigAttrBE.IdUsuario = AdministrarPropiedades.Params["IdUsuario"];
                oObjetoConfigAttrBE.UserName = AdministrarPropiedades.Params["UserName"];

            var id = AdministrarPropiedades.Commit(oObjetoConfigAttrBE);
            if (id != -1) {
                oDataRow["Valor"] = Valor;
                oDataRow["IdAttValor"]=id;
                return id;
            }
        }

        AdministrarPropiedades.Commit = function (oObjetoConfigAttrBE) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
            oEasyDataInterConect.Metodo = "ModificarInsertarObjetoConfigAttr";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdAtributoValor", oObjetoConfigAttrBE.IdAtributoValor, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdObjeto", oObjetoConfigAttrBE.IdObjeto, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdAtributo", oObjetoConfigAttrBE.IdAtributo, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Valor", oObjetoConfigAttrBE.Valor);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdGrp", oObjetoConfigAttrBE.IdGrp, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("OrdenParam", oObjetoConfigAttrBE.Orden, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdUsuario", oObjetoConfigAttrBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", oObjetoConfigAttrBE.UserName);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;         
            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);

            var Result = oEasyDataResult.sendData();
            oObjetoConfigAttrBE.IdAtributoValor = Result;
            return oObjetoConfigAttrBE.IdAtributoValor;
        }


    </script>
</html>