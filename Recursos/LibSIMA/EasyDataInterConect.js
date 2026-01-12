TipodeDato = {
    String: "String",
    Int: "Int",
    Double: "Double"
}


SIMA.Param = function (_Name, _Value, _Tipo) {
    this.Nombre = _Name;
    this.Valor = _Value;
    this.Tipo = ((_Tipo == undefined) ? TipodeDato.String : _Tipo);
}

SIMA.ParamCollections = function () {
    var Collections = new Array();
    this.Add = function (oParam) {
        Collections[Collections.length] = new Array();
        Collections[Collections.length - 1] = oParam;
    }
    this.getCollection = function () {
        return Collections;
    }
    this.Clear = function () {
       /* while (Collections.length > 0) {
            Collections.pop();
        }*/
        Collections.Clear();
    }
    this.toString = function () {
        var strParams = "";
        Collections.forEach(function (oParam, i) {
            strParams += ((i == 0) ? "" : "&") + oParam.Nombre + "=" + oParam.Valor;
        });
        //this.Clear();
        return strParams;
    }
    this.Clear();
}

ModoInterConect= {
    PaginaASPX: "PaginaASPX", 
    WebServiceInterno: "WebServiceInterno",
    WebServiceExterno: "WebServiceExterno"
}
EasyDataInterConect = function () {
    this.MetododeConexion = null;
    this.UrlWebService = null;
    this.Metodo = null;
    this.ParamsCollection = null;
}
EasyDataResult = function (EasyDataInterConect) {
    var cmll = "\"";
    var KEYQTIPO_RETORNO = "TipReturn";
    var oEasyDataInterConect = EasyDataInterConect;
    this.getDataTable = function () {
        var dtBase = new SIMA.Data.DataTable();
        var oDataTable = new SIMA.Data.DataTable();
        try {
            dtBase = this.get("Table");
            if (dtBase == null) {
                oDataTable.Rows.Count = function () { return 0 };
            }
            else {
                oDataTable = dtBase;
            }
        }
        catch (error) {
            alert(error);
        }
        return oDataTable;
    }
    this.getEntity = function () {
        return this.get("Entity");
    }
    this.getDictionaryBE = function () {
        return this.get("DictionaryBE");
    }
    /*Procesos de actuaizaciones de datos */
    this.sendData=function(){
        return this.get("NonQuery");
    }

    this.get = function (IdTipoObjReturn,CtrSourceCall) {
        var ObjectRst = null;
        var oBaseBE = {};
        var Request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"))
        formData = new FormData();
        formData.append("MtdCn", oEasyDataInterConect.MetododeConexion);
        var UrlPath = ((oEasyDataInterConect.MetododeConexion == ModoInterConect.WebServiceInterno) ? Page.Request.ApplicationPath : "") + oEasyDataInterConect.UrlWebService;
        formData.append("UrlWS", UrlPath);
        formData.append("MtdWS", oEasyDataInterConect.Metodo);
        formData.append("TipReturn", IdTipoObjReturn);

        var lstParams = "";
        var lstParamsTipo = "";

        if ((oEasyDataInterConect.ParamsCollection != undefined) && (oEasyDataInterConect.ParamsCollection != null)) {
            oEasyDataInterConect.ParamsCollection.getCollection().forEach(function (oParams, i) {
                var xValor = "";
                if (oParams.Valor == undefined) {
                    xValor = oParams.Valor;
                }
                else {
                    xValor = oParams.Valor.toString().Replace(',', '�');
                }
                lstParams += ((i == 0) ? "" : ",") + oParams.Nombre + ":" + cmll + xValor + cmll;
                lstParamsTipo += ((i == 0) ? "" : ",") + oParams.Nombre + ":" + cmll + oParams.Tipo + cmll;
            });
        }
        lstParams = "{" + lstParams + "}";
        lstParamsTipo = "{" + lstParamsTipo + "}";

        formData.append("ParamsSW", lstParams);
        formData.append("ParamsSWTipo", lstParamsTipo);
        /*------------------------------------------------------------------------------------------------------------*/
        //Inicial la impementacion sobreescrita del or procedimientos
        Request.onreadystatechange = function () {
            if (Request.readyState === XMLHttpRequest.DONE) {
                if (Request.status === 200) {
                    var TipoObj = Array.prototype.slice.call(Request.responseXML.all);
                    var itemsXml = null;
                    if (TipoObj.length == 1) { throw new SIMA.DataException("No existen Datos"); }

                    switch (TipoObj[1].tagName) {
                        case "Entity":
                            var NodoRaiz = "Entity";
                            itemsXml = Request.responseXML.getElementsByTagName("Entity");

                            var strEntity = "", cmll = "\"";
                            var strFNC = "", strParamfnc = "", strParamValuefnc = "", strBodyfnc = "", strEstableceValor = "";

                            var rowsCollection = Array.prototype.slice.call(itemsXml);
                            rowsCollection.forEach(function (oRow, RowIndex) {
                                var fieldColletions = Array.prototype.slice.call(oRow.children);
                                fieldColletions.forEach(function (oField, i) {
                                    var Param = "_" + oField.nodeName;
                                    strParamfnc += ((i == 0) ? "" : ",") + Param;
                                    strBodyfnc += "     this." + oField.nodeName + "=" + Param + ";\n";

                                });
                                strFNC = "function " + NodoRaiz + "(" + strParamfnc + "){\n"
                                    + strBodyfnc
                                    + "}\n";
                                //Crea la clase
                                eval(strFNC);
                                //Crea Una Instancia
                                eval("o" + NodoRaiz + "= new " + NodoRaiz + "();");

                                //Asigan valores a la instancia
                                fieldColletions.forEach(function (oField, i) {
                                    strEstableceValor += "o" + NodoRaiz + "." + oField.nodeName + "=" + cmll + oField.textContent + cmll + ";\n";

                                });
                                eval(strEstableceValor);
                                //Asigna la Instanca a una variable materilizada
                                strEntity = "oBaseBE=o" + NodoRaiz + ";";
                                eval(strEntity);

                            });
                            ObjectRst = oBaseBE;

                            break;
                        case "Table":
                            var oDataTable = new SIMA.Data.DataTable();
                            itemsXml = Request.responseXML.getElementsByTagName("Table");
                            if ((itemsXml != null) && (itemsXml.length != 0)) {
                                var rowsCollection = Array.prototype.slice.call(itemsXml);
                                rowsCollection.forEach(function (oRow, RowIndex) {
                                    var collumnColletions = Array.prototype.slice.call(oRow.children);
                                    collumnColletions.forEach(function (oField, CellIndex) {
                                        if (RowIndex == 0) {
                                            var oDataColumn = new SIMA.Data.DataColumn(oField.nodeName);
                                            oDataTable.Columns.Add(oDataColumn);
                                        }
                                    });
                                    var oDataRow = oDataTable.newRow();
                                    //Inicia el llenado de los datos po cada registro
                                    oDataTable.Columns.forEach(function (oField, FieldIndex) {
                                        oDataRow[oField.Name] = $(oRow).find(oField.Name).text();
                                    });
                                    oDataTable.Rows.Add(oDataRow);
                                });
                                ObjectRst = oDataTable;
                            }
                            else {
                                throw new SIMA.DataException("No existen Datos");
                            }
                            break;
                        case "DictionaryBE":
                            itemsXml = Request.responseXML.getElementsByTagName("DictionaryBE");
                            var rowsCollection = Array.prototype.slice.call(itemsXml);
                            rowsCollection.forEach(function (oRow, RowIndex) {
                                var Fields = Array.prototype.slice.call(oRow.children);
                                EntityBE = Fields[0].textContent.toString().SerializedToObject();
                            });
                            ObjectRst = EntityBE;
                            break;
                        case "NonQuery":
                            itemsXml = Request.responseXML.getElementsByTagName("NonQuery");
                            var rowsCollection = Array.prototype.slice.call(itemsXml);
                            var objValor = null;
                            rowsCollection.forEach(function (oRow, RowIndex) {
                                var Fields = Array.prototype.slice.call(oRow.children);
                                objValor = Fields[0].textContent.toString();
                            });
                            ObjectRst = objValor;
                            break;
                        case "Error":
                          //  if ((CtrSourceCall != undefined) && (CtrSourceCall !='EasyAutocompletar')) {//para evitar el mensaje de error de este control que soporta ediciony busqueda
                                itemsXml = Request.responseXML.getElementsByTagName("Error");
                                var rowsCollection = Array.prototype.slice.call(itemsXml);

                                rowsCollection.forEach(function (oRow, RowIndex) {
                                    var Fields = Array.prototype.slice.call(oRow.children);
                                    //throw new SIMA.WebServiceException(Fields[1].textContent, Fields[2].textContent);    
                                    var msgConfig = { Titulo: "Error", Descripcion: "ORIGEN:" + Fields[1].textContent + "<br> MENSAJE:" + Fields[2].textContent };
                                    var oMsg = new SIMA.MessageBox(msgConfig);
                                    oMsg.Alert();
                                });
                           // }
                            break;

                    }
                }
                else {
                     var msgConfig = { Titulo: "Error", Descripcion: "Hubo un problema al intentar obtener el documento XML:\n MENSAJE:" + Request.statusText };
                     var oMsg = new SIMA.MessageBox(msgConfig);
                     oMsg.Alert();
                 }
            }
        }

        Request.open('POST', Page.Request.ApplicationPath + '/General/EasyDataInterConectPrc.aspx', false);
        Request.send(formData);

        return ObjectRst;
    }
}

//EasyDataInterConect.prototype = new XMLHttpRequest;