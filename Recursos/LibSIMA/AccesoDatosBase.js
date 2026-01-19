/*
 * Objetivo: Permita conectarse  con un web services para obtener la data y transformarla a
 * un Obj DataTable de lado del cliente
 */

SIMA.Data.OleDB = {};
 

SIMA.Data.OleDB.Command = function () {
    this.CadenadeConexion = "";
    this.ExecuteDataSet = function (oParamCollections) {
        //var oDataTable = new SIMA.Data.DataTable();
        //oDataTable = base(this.CadenadeConexion, oParamCollections.get());
       // try {
           // var ObjectResult = base(this.CadenadeConexion, oParamCollections.get());
            var oCallBack = new CallBack();
            var ObjectResult = oCallBack.ReturnObjFromSever(this.CadenadeConexion.Replace("?","") + "?" + oParamCollections.toString());
       /* }
        catch (error) {
            throw error;
        }*/
        return ObjectResult;
    }
    this.ExecuteNonQuery = function (oParamCollections) {
        var obj = null; var EntityBE = null;
        var oDataTable = new SIMA.Data.DataTable();
        //oDataTable = base(this.CadenadeConexion, oParamCollections.get());
        try {
            //var ObjectResult = base(this.CadenadeConexion, oParamCollections.get());
            var oCallBack = new CallBack();
            var ObjectResult = oCallBack.ReturnObjFromSever(this.CadenadeConexion.Replace("?", "") + "?" + oParamCollections.toString());

            if (ObjectResult instanceof SIMA.Data.DataTable) {
                oDataTable = ObjectResult;
                if (oDataTable.Rows.Count() == 1) {
                    var oDataRow = oDataTable.Rows[0];
                    obj = oDataRow[oDataRow.Columns[0].Name];
                }
                else if (oDataTable.Rows.Count() >1) {
                    throw new SIMA.DataException("Esta intentando usar ExecuteNoQUery para recuperar un conjunto de resultados<br> se sugiere utilizar ExecuteDataSet");
                }
            }
            else {
                obj = ObjectResult;
            }
        }
        catch (error) {
            throw error;
        }

        return obj;
    }
    //Implementado para la llamada a los servicios --no se usa
    function base(_CadenadeConexion, _Params) {
        if (_Params instanceof SIMA.Data.OleDB.ParamCollections) {
            throw new SIMA.ExcepcionDominio.ErrorComponente("System.Data.ParamCollections in class::System.Data.OleDB");
        }
        var objResult = null;
        var _DataTable = new SIMA.Data.DataTable();
        var LstCampoDB;
        try {
            $.ajax({
                url: _CadenadeConexion,
                data: _Params,
                async: false,
                method: 'get',
                dataType: 'xml',
                success: function (response, status, xmlData) {
                    alert(response);
                    // $(response).find("Table").each(function (idx) {//La propiedad  TableName del Objeto DataTable resultante su valor debe de ser "Table"
                    var NodoRaiz = response.childNodes[0].localName;
                    NodoRaiz = ((NodoRaiz == "DataTable") ? "Table" : NodoRaiz);
                    switch (NodoRaiz) {
                        case "Table":
                            $(response).find(NodoRaiz).each(function (idx) {//La propiedad  TableName del Objeto DataTable resultante su valor debe de ser "Table"
                                if (idx >= 0) {
                                    var Me = this;
                                    if (idx == 0) {//Captura los campos por unica vez
                                        LstCampoDB = Array.prototype.slice.call(Me.children);//Lista de campos del archivo XML
                                        LstCampoDB.forEach(function (oField) {
                                            var oDataColumn = new SIMA.Data.DataColumn(oField.nodeName);
                                            _DataTable.Columns.Add(oDataColumn);
                                        });
                                    }
                                    var oDataRow = _DataTable.newRow();
                                    LstCampoDB.forEach(function (oField) {
                                        oDataRow[oField.nodeName] = $(Me).find(oField.nodeName).text();
                                        oDataRow.Columns[oField.nodeName] = $(Me).find(oField.nodeName).text();//Modif:21-12-2022
                                    });
                                    _DataTable.Rows.Add(oDataRow);
                                    //------TrataMientos de errores-----------------------------------puede generarse un throw en una actualizacion proxima
                                    //Verificar Si elObj DataTable es resultante de errores
                                    var oDataColum = new SIMA.Data.DataColumn();
                                    oDataColum = _DataTable.Columns[0];
                                    if (oDataColum.Name === "PaginaError") {
                                        throw new SIMA.WebServiceDataException("AccesoDatosBase:this.Base", _DataTable.Rows[0].Columns["PaginaError"] + "<br>" + _DataTable.Rows[0].Columns["Mensaje"]);
                                    }
                                    //------TrataMientos de errores-----------------------------------
                                }
                            });
                            objResult = _DataTable;
                            break;
                        case "string":
                            var EntityBE = null;
                            $(response).find(NodoRaiz).each(function (idx) {//para el caso que el servicio devielva un string
                                var Me = this;//Deinicion debe ser siempre dentro del each
                                EntityBE = Me.innerHTML.toString().SerializedToObject();
                            });
                            objResult = EntityBE;
                            break;
                        default:
                            var oBaseBE = {}, strEntity = "", cmll = "\"";
                            var strFNC = "", strParamfnc = "", strParamValuefnc = "", strBodyfnc = "", strEstableceValor = "";
                            $(response).find(NodoRaiz).each(function (idx) {//La propiedad  TableName del Objeto DataTable resultante su valor debe de ser "Table"
                                if (idx >= 0) {
                                    var Me = this;
                                    if (idx == 0) {//Captura los campos por unica vez
                                        LstCampoDB = Array.prototype.slice.call(Me.children);//Lista de campos del archivo XML
                                        LstCampoDB.forEach(function (oField, i) {
                                            var Param = "_" + oField.nodeName;
                                            strParamfnc += ((i == 0) ? "" : ",") + Param;
                                            strBodyfnc += "     this." + oField.nodeName + "=" + Param + ";\n";
                                        });
                                        //
                                        strFNC = "function " + NodoRaiz + "(" + strParamfnc + "){\n"
                                            + strBodyfnc
                                            + "}\n";
                                        //Crea la clase
                                        eval(strFNC);
                                        //Crea Una Instancia
                                        eval("o" + NodoRaiz + "= new " + NodoRaiz + "();");
                                    }
                                    //Asigan valores a la instancia
                                    LstCampoDB.forEach(function (oField, i) {
                                        strEstableceValor += "o" + NodoRaiz + "." + oField.nodeName + "=" + cmll + $(Me).find(oField.nodeName).text() + cmll + ";\n";

                                    });
                                    eval(strEstableceValor);
                                    //Asigna la Instanca a una variable materilizada
                                    strEntity = "oBaseBE=o" + NodoRaiz + ";";
                                    eval(strEntity);
                                }
                            });
                            objResult = oBaseBE;
                            break;
                    }

                },
                error: function (err) {
                    throw new SIMA.WebServiceException("Recibe:Objects.js  AccesoDatosBase:this.Base", err.responseText);
                }
            });
        }
        catch (error) {
                throw error;

           // if (error instanceof SIMA.WebServiceException) {
            //    throw new SIMA.WebServiceException(error.Point + '<br> ObjectError:SIMA.WebServiceException', error.Message);
            //}
        }
        return objResult;
    }
}

SIMA.Data.OleDB.Param =  function (_Text,_Value) {
    this.Text = _Text;
    this.Value = _Value;
}
SIMA.Data.OleDB.Param.prototype = new SIMA.Param;//Hereda de la clase Base


SIMA.Data.OleDB.ParamCollections = function () {
    this.get = function () {
        var cmll = "'";
        var strParam = "";
        this.getCollection().forEach(function (item,i) {
            strParam += ((i==0)?"":",") + item.Text + ":" + cmll + item.Value + cmll;
        });
        //strParam = strParam.substring(0, strParam.length - 1);
        eval("var oParamsBE = {" + strParam + "}");
        this.Clear();//Borra para dejar disponible a otras instancias
        return oParamsBE;
    }
    this.Clear();
}
SIMA.Data.OleDB.ParamCollections.prototype = new SIMA.ParamCollections;



SIMA.ExcepcionDominio = {};
SIMA.ExcepcionDominio.ErrorComponente = function (Componente = "") {
    this.name = Componente;
    this.message = "No se permite una instancia distinta de " + Componente;
    this.NroLinea = this.lineNumber;
}
SIMA.ExcepcionDominio.prototype = new Error;






var CallBack = function () {
    var isIE = false;
    this.req = null;
    //var oDataTable = new SIMA.Data.DataTable();
    var oObject = null;
    this.ReturnObjFromSever = function (url) {
        if (window.XMLHttpRequest) {
            this.req = new XMLHttpRequest();
            this.EstablecerProcesoASerEjecutado();
            this.req.open("GET", url, false);
            this.req.send();
        }
        else if (window.ActiveXObject) {
            this.isIE = true;
            this.req = new ActiveXObject("Microsoft.XMLHTTP");// Crea el nuevo objeto
            if (this.req) {
                this.EstablecerProcesoASerEjecutado();// Cuando el documento está listo, invoca a la función de Proceso
                this.req.open("GET", url, false);// Asigna el método, el URL y demás parámetros
                this.req.send();// Envía el pedido
            }
        }
        return oObject;
    }
    //--------------------------------------------------------------------------------------
    //Define la Llamada a los Procesos invocandolos el cual deberan de estar implementados en el Archivo JS FrameCallBack
    this.EstablecerProcesoASerEjecutado = function () {
        //Siempre el Parametro de Indice Cero debera de ser el Identificador del Proceso
        var oreq = this.req;	//var oDataTable = new System.Data.DataTable("Table");
        
        this.req.onreadystatechange = function () {// Otros estados son: 0 = uninitialized <-> 1 = loading <-> 2 = loaded <-> 3 = interactive <-> 4 = complete
            if (oreq.readyState == 4) {	// Solo si el documento ya está cargado
                // Sólo si hay respuesta positiva "OK", esto es enviado por el servidor
                if (oreq.status == 200) {
                    var TipoObj = Array.prototype.slice.call(oreq.responseXML.all);
                    var itemsXml = null;
                    if (TipoObj.length == 1) { throw new SIMA.DataException("No existen Datos"); }

                    switch (TipoObj[1].tagName) {
                        case "Entity":
                            var NodoRaiz = "Entity";
                            itemsXml = oreq.responseXML.getElementsByTagName("Entity");


                            var oBaseBE = {}, strEntity = "", cmll = "\"";
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
                            oObject = oBaseBE;

                            break;
                        case "Table":
                            var oDataTable = new SIMA.Data.DataTable();
                            itemsXml = oreq.responseXML.getElementsByTagName("Table");
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
                                oObject = oDataTable;
                            }
                            else {
                                throw new SIMA.DataException("No existen Datos");
                            }
                            break;
                        case "DictionaryBE":
                            itemsXml = oreq.responseXML.getElementsByTagName("DictionaryBE");
                            var rowsCollection = Array.prototype.slice.call(itemsXml);
                            rowsCollection.forEach(function (oRow, RowIndex) {
                                var Fields = Array.prototype.slice.call(oRow.children);
                                EntityBE = Fields[0].textContent.toString().SerializedToObject();
                            });
                            oObject = EntityBE;
                            break;
                        case "Error":
                            itemsXml = oreq.responseXML.getElementsByTagName("Error");
                            var rowsCollection = Array.prototype.slice.call(itemsXml);

                            rowsCollection.forEach(function (oRow, RowIndex) {
                                var Fields = Array.prototype.slice.call(oRow.children);
                                //throw new SIMA.WebServiceException(Fields[1].textContent, Fields[2].textContent);    
                                var msgConfig = {Titulo: "Error", Descripcion: "ORIGEN:" + Fields[1].textContent + "<br> MENSAJE:" + Fields[2].textContent};
                                var oMsg = new SIMA.MessageBox(msgConfig);
                                oMsg.Alert();
                            });
                            
                            break;

                    }

                  
                  
                    if ((itemsXml != null) && (itemsXml.length != 0)) {

                        //------TrataMientos de errores-----------------------------------puede generarse un throw en una actualizacion proxima
                        //Verificar Si elObj DataTable es resultante de errores
                        var oDataColum = new SIMA.Data.DataColumn();
                        oDataColum = oDataTable.Columns[0];
                        if (oDataColum.Name === "PaginaError") {
                            throw new SIMA.WebServiceDataException("AccesoDatosBase:this.Base", _DataTable.Rows[0].Columns["PaginaError"] + "<br>" + _DataTable.Rows[0].Columns["Mensaje"]);
                        }
                        //------TrataMientos de errores-----------------------------------
                    }
                    else {
                        alert('Entity');
                    }


                }
                else {
                    window.alert("Hubo un problema al intentar obtener el documento XML:\n" + oreq.statusText);
                }
            }
        }
    }

}
