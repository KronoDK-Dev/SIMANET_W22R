<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarActividadProcedimiento.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.ITIL.AdministrarActividadProcedimiento" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <style type="text/css">

        .handle {
            background-color: lightblue;
            cursor: move;
            text-align: center;
            font: bold 12px sans-serif;
            height: 30px;          
            padding-top:5px;
        }
        #myPaletteDiv {
            background-color: #F5F5F5;
            
            width: 100%;
            height: 100%;
        } 
      #paletteContainer {
        position: absolute;
        bottom: 14px;
        left: 0px;
        right: 0px;
        top: 30px;
      }
        #paletteDraggable {
            border-style: ridge;
            height: 100%;
            width: 123.803px;
        }
</style>


  

      
</head>
<body>
    <form id="form1" runat="server">     
        <table border="0" style="width:100%">
            <tr>
                <td style="width:80%">
                    <div id="myDiagramDiv" style="border: solid 1px black; width: 100%; height: 600px"></div>
                </td>
                <td style="width: 7%; height: 600px;">
                        <div id="paletteDraggable" class="ui-draggable ui-resizable">
                            <div id="paletteDraggableHandle" class="handle ui-draggable-handle"><center>Herramientas</center></div>
                            <div id="paletteContainer">
                                <div id="myPaletteDiv" style="-webkit-tap-highlight-color: rgba(255, 255, 255, 0); cursor: auto;">
                                </div>                                     
                            </div>                                   
                                      
                    </div>                                                          
                </td>
            </tr>
        </table>
    </form>


        <script>
            var myPalette = null;
            var cmll = "\"";
            var Diagrama = {};
            Diagrama.Data = {};
            Diagrama.Drawing = {};
            Diagrama.Drawing.Tools = {};
            Diagrama.Data.ListarBtnOpciones = function () {
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "General/General.asmx";
                oEasyDataInterConect.Metodo = "ListarTodosOracle";

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("IdtblModulo", "19", TipodeDato.Int);//Tipo de Objeto
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                return oEasyDataResult.getDataTable();
            }
            Diagrama.Data.ListarObjetosPorActividad = function () {
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/ITIL/GestiondeConfiguracion.asmx";
                oEasyDataInterConect.Metodo = "ProcedimientoListarPorActividad";

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(AdministrarActividadProcedimiento.KEYIDACTIVIDAD, AdministrarActividadProcedimiento.Params[AdministrarActividadProcedimiento.KEYIDACTIVIDAD]);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                return oEasyDataResult.getDataTable();
            }

            Diagrama.Data.InsertaActualiza = function (oProcedimientoBE) {

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("IdAccion", oProcedimientoBE.IdAccion);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdAccionRel", oProcedimientoBE.IdAccionRel);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdAccionTo", oProcedimientoBE.IdAccionTo);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdTipoOj", oProcedimientoBE.IdTipoObj, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('AccionesBasicas', oProcedimientoBE.AccionBasica);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('Atributo', oProcedimientoBE.Atributo);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('Orden', oProcedimientoBE.Orden, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('IdActividad', oProcedimientoBE.IdActividad);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                oParamCollections.Add(oParam);

                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + 'HelpDesk/ITIL/GestiondeConfiguracion.asmx';
                oEasyDataInterConect.Metodo = 'ProcedimientoModificaInserta';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var obj = oEasyDataResult.sendData();
                return obj.toString().SerializedToObject();
            }
            Diagrama.Data.DelProcedimientoAccion = function (IdAccion) {
                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("IdAccion", IdAccion);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                oParamCollections.Add(oParam);

                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + 'HelpDesk/ITIL/GestiondeConfiguracion.asmx';
                oEasyDataInterConect.Metodo = 'ProcedimientoDelAccionXActividad';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var obj = oEasyDataResult.sendData();
                return obj.toString().SerializedToObject();
            }
            Diagrama.Data.findUpdateLike = function (oNodoKey) {
                myDiagram.model.linkDataArray.forEach(function (oLink, i) {
                    if (oNodoKey == oLink.key) {
                        var oProcedimientoBE = new ProcedimientoBE();
                        oProcedimientoBE.IdAccion = oNodoKey;
                        oProcedimientoBE.IdTipoObj = "6";
                        oProcedimientoBE.AccionBasica = "Link";
                        oProcedimientoBE.IdAccionRel = oLink.from;//oLink.data.from
                        oProcedimientoBE.IdAccionTo = oLink.to;//oLink.data.to

                        var ObjLink = clone(oLink);
                        delete ObjLink.points;
                        delete ObjLink.dash;
                        // var strObjLink = "".toString().BaseSerialized(ObjLink).toString().split(",");
                        var strObjLink = "".toString().BaseSerialized(ObjLink).toString().Replace(",", ";").split(",");

                        var arrPoint = oLink.points;
                        var strPoints = "";
                        if (Array.isArray(arrPoint)) {//se ejecuta ciuando la modificacion proviene desde la etiqueta
                            arrPoint.forEach(function (point, i) {
                                strPoints += ((i > 0) ? ";" : "") + point;
                            });
                        }
                        else {//se ejecuta cuando la modificacion viene desde el drag and drop o al enlazar 2 objetos
                            arrPoint.r.forEach(function (point, i) {
                                strPoints += ((i > 0) ? ";" : "") + point.x + ";" + point.y;
                            });
                        }
                        //La propiedad Dash
                        var arrDash = oLink.dash;
                        var strPDash = "";
                        if (Array.isArray(arrDash)) {
                            arrDash.forEach(function (pDash, i) {
                                strPDash += ((i > 0) ? ";" : "") + pDash;
                            });
                        }
                        strObjLink.splice(strObjLink.length - 1, 0, "points=|" + strPoints + "|");
                        strObjLink.splice(strObjLink.length - 1, 0, "dash=[" + strPDash + "]");
                        strObjLink = strObjLink.toString().Replace("{", "").Replace("}", "").Replace(":", "=").Replace(",", ";").Replace(cmll, "|");

                        oProcedimientoBE.Atributo = strObjLink;
                        oProcedimientoBE.Orden = 0;
                        oProcedimientoBE.IdActividad = AdministrarActividadProcedimiento.Params[AdministrarActividadProcedimiento.KEYIDACTIVIDAD];
                        oProcedimientoBE.IdUsuario = UsuarioBE.IdUsuario;
                        oProcedimientoBE.UserName = UsuarioBE.UserName;

                        var outBE = Diagrama.Data.InsertaActualiza(oProcedimientoBE);

                    }
                }
                );

            }
            Diagrama.Data.SaveObjInDB = function (oNodoKey) {
                myDiagram.model.nodeDataArray.forEach(function (oObj, i) {
                    if (oNodoKey == oObj.key) {
                        var oProcedimientoBE = new ProcedimientoBE();
                        oProcedimientoBE.IdAccion = oNodoKey;
                        oProcedimientoBE.IdTipoObj = oObj.IdTipo;
                        oProcedimientoBE.AccionBasica = oObj.text;
                        oProcedimientoBE.IdAccionRel = ((oObj.group == undefined) ? "0" : oObj.group);
                        oProcedimientoBE.IdAccionTo = "0";
                        oProcedimientoBE.Atributo = "".toString().BaseSerialized(oObj).Replace('"', "|").Replace(':', '=').Replace(',', ';');
                        oProcedimientoBE.Orden = 0;
                        oProcedimientoBE.IdActividad = AdministrarActividadProcedimiento.Params[AdministrarActividadProcedimiento.KEYIDACTIVIDAD];
                        oProcedimientoBE.IdUsuario = UsuarioBE.IdUsuario;
                        oProcedimientoBE.UserName = UsuarioBE.UserName;

                        var outBE = Diagrama.Data.InsertaActualiza(oProcedimientoBE);
                        oProcedimientoBE.IdAccion = outBE.IdOut;
                    }
                }
                );
            }


            Diagrama.Drawing.CreateObject = function (_Graphic) {
                var oGraphic = null;
                switch (_Graphic.IdTipo) {
                    case "3":
                        oGraphic = { "isGroup": true, header: _Graphic.header, "text": _Graphic.text, "key": _Graphic.key, "loc": _Graphic.loc, fill: _Graphic.fill, "dash": [4, 4], "color": _Graphic.color, group: _Graphic.group, IdTipo: _Graphic.IdTipo };
                        break;
                    case "7":
                        oGraphic = { "category": "Comment", "text": _Graphic.text, "key": _Graphic.key, "loc": _Graphic.loc, "size": _Graphic.size, IdTipo: _Graphic.IdTipo };
                        break;
                    default:
                        oGraphic = { "text": _Graphic.text, "key": _Graphic.key, "figure": _Graphic.figure, fill: _Graphic.fill, loc: _Graphic.loc, color: _Graphic.color, size: _Graphic.size, group: _Graphic.group, thickness: _Graphic.thickness, IdTipo: _Graphic.IdTipo };
                }
                return oGraphic;
            }

            Diagrama.Drawing.Paint = function () {
                var nodeDataArray = new Array();
                var linkDataArray = new Array();
                var oDataTable = Diagrama.Data.ListarObjetosPorActividad();

                oDataTable.Select("TIPONODO", "=", 'nodeDataArray').forEach(function (oDataRow, i) {
                    var strobj = "{" + oDataRow["ATRIBUTOS"].Replace("=", ":").Replace(";", ",").Replace("|", cmll) + "}";
                    var objBE = strobj.SerializedToObject();
                    delete objBE.Serialized;//Elimina el metodo para esteblecer el objeto puro
                    nodeDataArray.Add(Diagrama.Drawing.CreateObject(objBE));

                });


                oDataTable.Select("TIPONODO", "=", 'linkDataArray').forEach(function (oDataRow, i) {
                    var strobj = "{" + oDataRow["ATRIBUTOS"].Replace("=", ":").Replace(";", ",").Replace("|", "'") + "}";
                    var objBE = strobj.SerializedToObject();
                    delete objBE.Serialized;
                    var arrp = objBE.points.split(',');
                    objBE.points = new Array();
                    arrp.forEach(function (v, p) { objBE.points.Add(parseInt(v)); });
                    linkDataArray.Add(objBE);
                });


                myDiagram.model = new go.GraphLinksModel(nodeDataArray, linkDataArray);
            }

            Diagrama.Drawing.Tools.Paint = function () {
                var arrObjTool = new Array();
                var GraphPatron = {};
                Diagrama.Data.ListarBtnOpciones().Select("IDITEM", "!=", "6").forEach(function (oDataRow, i) {
                    var strPatron = "{" + oDataRow["BTNTOOL"].toString().Replace("|", cmll) + "}";
                    eval("GraphPatron = " + strPatron + ";");
                    if (oDataRow["IDITEM"].toString().Equal("3")) {
                        oGraphic = { "isGroup": true, "text": GraphPatron.text, "key": GraphPatron.key, "fill": GraphPatron.fill, "dash": GraphPatron.dash, "color": GraphPatron.color, group: 0, "size": GraphPatron.size, IdTipo: GraphPatron.IdTipo, Trama: oDataRow["DESCRIPCION"].toString() };
                    }
                    else if (oDataRow["IDITEM"].toString().Equal("7")) {
                        oGraphic = { "category": "Comment", "text": GraphPatron.text, "key": GraphPatron.key, "size": GraphPatron.size, IdTipo: GraphPatron.IdTipo, Trama: oDataRow["DESCRIPCION"].toString() };
                    }
                    else {
                        oGraphic = { "text": GraphPatron.text, "key": GraphPatron.key, "figure": GraphPatron.figure, fill: GraphPatron.fill, "color": GraphPatron.color, "size": GraphPatron.size, group: GraphPatron.group, IdTipo: GraphPatron.IdTipo, Trama: oDataRow["DESCRIPCION"].toString() };

                    }
                    arrObjTool.Add(oGraphic);
                });

                myPalette = new go.Palette('myPaletteDiv', {
                    nodeTemplate: new go.Node('Auto', {
                        locationSpot: go.Spot.Center,
                        locationObjectName: 'SHAPE',
                        desiredSize: new go.Size(120, 60),
                        minSize: new go.Size(40, 40),
                        resizable: true,
                        resizeCellSize: new go.Size(20, 20),
                        cursor: "pointer",
                        click: function (e, obj) { }//al dar en cada objeto
                        //  copyable: false,
                        //  deletable: true

                    })
                        // these Bindings are TwoWay because the DraggingTool and ResizingTool modify the target properties
                        .bindTwoWay('location', 'loc', go.Point.parse, go.Point.stringify)
                        .bindTwoWay('desiredSize', 'size', go.Size.parse, go.Size.stringify)
                        .add(
                            new go.Shape({ name: 'SHAPE', fill: colors.white, cursor: 'pointer', portId: '', fromLinkable: true, toLinkable: true, fromLinkableDuplicates: true, toLinkableDuplicates: true, fromSpot: go.Spot.AllSides, toSpot: go.Spot.AllSides })
                                .bind('figure')
                                .bind('fill')
                                .bind('stroke', 'color')
                                .bind('strokeWidth', 'thickness')
                                .bind('strokeDashArray', 'dash'),
                            new go.Shape({ width: 100, height: 40, strokeWidth: 0, fill: 'transparent' }),
                            new go.TextBlock({ margin: 1, textAlign: 'center', overflow: go.TextOverflow.Ellipsis, editable: false, alignment: go.Spot.Center, alignmentFocus: go.Spot.Top, margin: 1, font: "12px sans-serif" })
                                .bindTwoWay('text')
                                .bind('stroke', 'color')
                        ),
                    model: new go.GraphLinksModel(arrObjTool)
                });


                /*
                  myPalette.addDiagramListener("InitialLayoutCompleted", diagramEvent => {
                      var pdrag = document.getElementById("paletteDraggable");
                      var palette = diagramEvent.diagram;
                      pdrag.style.width = palette.documentBounds.width + 28 + "px"; // account for padding/borders
                      pdrag.style.height = palette.documentBounds.height + 38 + "px";
                  });
      
                  
                  $(() => {
                      $("#paletteDraggable").draggable({ handle: "#paletteDraggableHandle" }).resizable({
                          // After resizing, perform another layout to fit everything in the palette's viewport
                          stop: () => myPalette.layoutDiagram(true)
                      });
                  }); 
                  */


            }



            function clone(obj) {
                if (null == obj || "object" != typeof obj) return obj;
                var copy = obj.constructor();
                for (var attr in obj) {
                    if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
                }
                return copy;
            }

            Diagrama.Open = function () {
                Manager.Task.Excecute(function () {
                    init();
                    Diagrama.Drawing.Tools.Paint();
                    Diagrama.Drawing.Paint();
                }, 1000, true);
            }

        </script>
    
        <script>
            function ProcedimientoBE(IdAccion, IdAccionRel, IdAccionTo, IdTipoOj, AccionesBasicas, Atributo, Orden, IdActividad, IdUsuario, UserName) {
                this.IdAccion = IdAccion;
                this.IdAccionRel = IdAccionRel;
                this.IdAccionTo = IdAccionTo;
                this.IdTipoObj = IdTipoOj;
                this.AccionBasica = AccionesBasicas;
                this.Atributo = Atributo;
                this.Orden = Orden;
                this.IdActividad = IdActividad;
                this.IdUsuario = IdUsuario;
                this.UserName = UserName;
            }

        </script>

         <script id="code">
             var myDiagram = null;
             var colors = null;
             function init() {
                 // Colors are predefined to allow easy manipulation of themes
                 colors = {
                     red: '#ff3333', blue: '#3358ff', green: '#25ad23', magenta: '#d533ff',
                     purple: '#7d33ff', orange: '#ff6233', brown: '#8e571e', white: '#ffffff',
                     black: '#000000', beige: '#fffcd5', extralightblue: '#d5ebff', extralightred: '#f2dfe0',
                     lightblue: '#a5d2fa', lightgray: '#cccccc', lightgreen: '#b3e6b3', lightred: '#fcbbbd'
                 };


                 myDiagram = new go.Diagram('myDiagramDiv', {
                     padding: 20, // extra space when scrolled all the way
                     grid: new go.Panel('Grid') // a simple 10x10 grid
                         .add(
                             new go.Shape('LineH', { stroke: 'lightgray', strokeWidth: 0.5 }),
                             new go.Shape('LineV', { stroke: 'lightgray', strokeWidth: 0.5 })
                         ),
                     'draggingTool.isGridSnapEnabled': true,
                     handlesDragDropForTopLevelParts: true,
                     mouseDrop: (e) => {
                         var ok = e.diagram.commandHandler.addTopLevelParts(e.diagram.selection, true);
                         if (!ok) e.diagram.currentTool.doCancel();
                         //Identifica el Nodo en arrastre para actualizar su estado
                         var selectedNode = e.diagram.selection.first();
                         var NodeKey = selectedNode.key;
                         if (selectedNode.key.toString().substring(0, 1) == "-") {
                             selectedNode.data.key = '0';
                             strTrama = "{" + selectedNode.data.Trama.toString().Replace("=", ":").Replace(";", ",").Replace("|", cmll) + "}";
                             var obtTramaBE = strTrama.SerializedToObject();


                             delete selectedNode.data['Trama'];

                             var oProcedimientoBE = new ProcedimientoBE();
                             oProcedimientoBE.IdTipoObj = selectedNode.data.IdTipo;
                             oProcedimientoBE.AccionBasica = obtTramaBE.text;
                             oProcedimientoBE.IdAccion = selectedNode.data.key;
                             oProcedimientoBE.IdAccionRel = "0";
                             oProcedimientoBE.IdAccionTo = "0";
                             oProcedimientoBE.Atributo = "";
                             oProcedimientoBE.Orden = 0;
                             oProcedimientoBE.IdActividad = AdministrarActividadProcedimiento.Params[AdministrarActividadProcedimiento.KEYIDACTIVIDAD];
                             oProcedimientoBE.IdUsuario = UsuarioBE.IdUsuario;
                             oProcedimientoBE.UserName = UsuarioBE.UserName;

                             var outBE = Diagrama.Data.InsertaActualiza(oProcedimientoBE);
                             oProcedimientoBE.IdAccion = outBE.IdOut;
                             selectedNode.data.key = oProcedimientoBE.IdAccion;
                             selectedNode.data.group = ((selectedNode.data.group == undefined) ? "0" : selectedNode.data.group);
                             var objSerialized = "".toString().BaseSerialized(selectedNode.data).toString().Replace("{", "").Replace("}", "").Replace(cmll, "|").Replace(":", "=").Replace(",", ";");
                             oProcedimientoBE.Atributo = objSerialized;
                             outBE = Diagrama.Data.InsertaActualiza(oProcedimientoBE);
                         }
                         else {

                             Diagrama.Data.SaveObjInDB(NodeKey);
                             //if (obj.part.adornedPart instanceof go.Link) {
                             //if (selectedNode.part instanceof go.Link) {
                             e.diagram.model.linkDataArray.forEach(function (oLink, i) {
                                 if ((NodeKey == oLink.from) || (NodeKey == oLink.to)) {//Actualiza  puntos del enlace
                                     Diagrama.Data.findUpdateLike(oLink.key);
                                 }
                             });
                             //}
                         }
                     },
                     PartResized: function (e) {
                         var obj = e.subject;
                         Diagrama.Data.SaveObjInDB(obj.key);
                     },
                     commandHandler: new DrawCommandHandler(), // support offset copy-and-paste
                     //  'clickCreatingTool.archetypeNodeData': { text: 'NEW NODE' }, // create a new node by double-clicking in background
                     PartCreated: (e) => {
                         var node = e.subject; // the newly inserted Node -- now need to snap its location to the grid
                         node.location = node.location.copy().snapToGridPoint(e.diagram.grid.gridOrigin, e.diagram.grid.gridCellSize);
                         setTimeout(() => {
                             // and have the user start editing its text
                             e.diagram.commandHandler.editTextBlock();
                         }, 20);
                     },
                     'commandHandler.archetypeGroupData': { isGroup: true, text: 'NEW GROUP' },
                     SelectionGrouped: (e) => {
                         var group = e.subject;
                         setTimeout(() => {
                             // and have the user start editing its text
                             e.diagram.commandHandler.editTextBlock();
                         });
                     },
                     LinkRelinked: (e) => {
                         // re-spread the connections of other links connected with both old and new nodes
                         var oldnode = e.parameter.part;
                         oldnode.invalidateConnectedLinks();
                         var link = e.subject;
                         if (e.diagram.toolManager.linkingTool.isForwards) {
                             link.toNode.invalidateConnectedLinks();
                         } else {
                             link.fromNode.invalidateConnectedLinks();
                         }

                     },
                     'undoManager.isEnabled': true,
                     selectionMoved: function (e) {
                         //implementar cuando se mueve el objeto
                         //  alert();
                     },
                 });

                 myDiagram.addDiagramListener("LinkDrawn", function (e) {
                     var link = e.subject;
                     link.data.key = "pLink1000";//Valor inicial al momento de ser creado se remplazsra despues por su valor generado en la base de datos
                     window.setTimeout(function () {
                         var oBE = myDiagram.model.toJson().toString().SerializedToObject();
                         oBE.linkDataArray.forEach(function (oLink, i) {
                             if (oLink.key == "pLink1000") {
                                 var oProcedimientoBE = new ProcedimientoBE();
                                 oProcedimientoBE.IdAccion = "0";
                                 oProcedimientoBE.IdTipoObj = "6";
                                 oProcedimientoBE.AccionBasica = "Link";
                                 oProcedimientoBE.IdAccionRel = link.data.from;
                                 oProcedimientoBE.IdAccionTo = link.data.to;
                                 oProcedimientoBE.Atributo = "";
                                 oProcedimientoBE.Orden = 0;
                                 oProcedimientoBE.IdActividad = AdministrarActividadProcedimiento.Params[AdministrarActividadProcedimiento.KEYIDACTIVIDAD];
                                 oProcedimientoBE.IdUsuario = UsuarioBE.IdUsuario;
                                 oProcedimientoBE.UserName = UsuarioBE.UserName;

                                 var outBE = Diagrama.Data.InsertaActualiza(oProcedimientoBE);
                                 oProcedimientoBE.IdAccion = outBE.IdOut;
                                 oLink.key = oProcedimientoBE.IdAccion;
                                 link.data.key = oProcedimientoBE.IdAccion;
                                 //Actualiza la propiedad de atributo
                                // alert(outBE.IdOut);

                                 var ObjLink = clone(oLink);
                                 delete ObjLink.points;
                                 var strObjLink = "".toString().BaseSerialized(ObjLink).toString().split(",");

                                 var arrPoint = oLink.points;
                                 var strPoints = "";

                                 if (arrPoint != undefined) {
                                     if (Array.isArray(arrPoint)) {//se ejecuta cuando la modificacion proviene desde la etiqueta
                                         arrPoint.forEach(function (point, i) {
                                             strPoints += ((i > 0) ? ";" : "") + point;
                                         });
                                     }
                                     else {//se ejecuta cuando la modificacion viene desde el drag and drop o al enlazar 2 objetos
                                         arrPoint.r.forEach(function (point, i) {
                                             strPoints += ((i > 0) ? ";" : "") + point.x + ";" + point.y;
                                         });
                                     }
                                 }
                                 var Etiqueta = "".toString().IsNull(oLink.text, "");

                                 strObjLink.splice(strObjLink.length - 1, 0, "points=|" + strPoints + "|");
                                 strObjLink.splice(strObjLink.length - 1, 0, "text =|" + Etiqueta + "|");
                                 strObjLink = strObjLink.toString().Replace("{", "").Replace("}", "").Replace(":", "=").Replace(",", ";").Replace(cmll, "|");
                                 oProcedimientoBE.Atributo = strObjLink;
                                 var outBE = Diagrama.Data.InsertaActualiza(oProcedimientoBE);
                             }
                         });
                     }, 1000);

                 })

                 myDiagram.addDiagramListener('SelectionDeleting', function (e) {
                     var ArrObjDel = new Array();
                     var partIt = e.subject.iterator;
                     partIt.each(function (p) {
                         ArrObjDel.Add(p.data.key);
                     });

                     var ConfigMsgb = {
                         Titulo: 'ELIMINAR ITEM'
                         , Descripcion: "Eliminar items"
                         , Icono: 'fa fa-question-circle'
                         , EventHandle: function (btn) {
                             if (btn == 'OK') {
                                 ArrObjDel.forEach(function (keyDel, d) {
                                     Diagrama.Data.DelProcedimientoAccion(keyDel);
                                 });
                             }
                             else {
                                 Diagrama.Drawing.Paint();
                                 // myDiagram.undo();
                             }
                         }
                     };
                     var oMsg = new SIMA.MessageBox(ConfigMsgb);
                     oMsg.confirm();
                 });

                 myDiagram.nodeTemplate = new go.Node('Auto', {
                     locationSpot: go.Spot.Center,
                     locationObjectName: 'SHAPE',
                     desiredSize: new go.Size(120, 60),
                     minSize: new go.Size(40, 40),
                     resizable: true,
                     resizeCellSize: new go.Size(20, 20),
                     cursor: "pointer",
                     click: function (e, obj) { /*alert(encodeURIComponent(obj.part.data.text));*/ }//al dar en cada objeto

                     //  copyable: false,
                     //  deletable: true

                 })
                     // these Bindings are TwoWay because the DraggingTool and ResizingTool modify the target properties
                     .bindTwoWay('location', 'loc', go.Point.parse, go.Point.stringify)
                     .bindTwoWay('desiredSize', 'size', go.Size.parse, go.Size.stringify)
                     .add(
                         new go.Shape({
                             // the border
                             name: 'SHAPE',
                             fill: colors.white,
                             cursor: 'pointer',
                             portId: '',
                             fromLinkable: true,
                             toLinkable: true,
                             fromLinkableDuplicates: true,
                             toLinkableDuplicates: true,
                             fromSpot: go.Spot.AllSides,
                             toSpot: go.Spot.AllSides
                         })
                             .bind('figure')
                             .bind('fill')
                             .bind('stroke', 'color')
                             .bind('strokeWidth', 'thickness')
                             .bind('strokeDashArray', 'dash'),
                         // this Shape prevents mouse events from reaching the middle of the port
                         new go.Shape({ width: 100, height: 40, strokeWidth: 0, fill: 'transparent' }),
                         new go.TextBlock({
                             margin: 1,
                             textAlign: 'center',
                             overflow: go.TextOverflow.Ellipsis,
                             // textEditor: window.TextEditorSelectBox,
                             editable: true,
                             textEdited: function (tb, oldstr, newstr) {
                                 if (oldstr !== newstr) {
                                     var node = tb.part;
                                     if (node instanceof go.Node) {//Modifica el texto del Objeto
                                         Diagrama.Data.SaveObjInDB(node.data.key);//Actualiza datos 
                                     }
                                 }
                             }

                         })
                             // this Binding is TwoWay due to the user editing the text with the TextEditingTool
                             .bindTwoWay('text')
                             .bind('stroke', 'color')
                     );

                 myDiagram.nodeTemplate.toolTip = go.GraphObject.build('ToolTip') // show some detailed information
                     .add(
                         new go.Panel('Vertical', { maxSize: new go.Size(200, NaN) }) // limit width but not height
                             .add(
                                 new go.TextBlock({ font: 'bold 10pt sans-serif', textAlign: 'center' }).bind('text'),
                                 new go.TextBlock({ font: '10pt sans-serif', textAlign: 'center' }).bind(
                                     'text',
                                     'details'
                                 )
                             )
                     );

                 // Node selection adornment
                 // Include four large triangular buttons so that the user can easily make a copy
                 // of the node, move it to be in that direction relative to the original node,
                 // and add a link to the new node.

                 function makeArrowButton(spot, fig) {
                     var maker = (e, shape) => {
                         e.handled = true;
                         e.diagram.model.commit((m) => {
                             var selnode = shape.part.adornedPart;
                             // create a new node in the direction of the spot
                             var p = new go.Point().setRectSpot(selnode.actualBounds, spot);
                             p.subtract(selnode.location);
                             p.scale(2, 2);
                             p.x += Math.sign(p.x) * 30;
                             p.y += Math.sign(p.y) * 30;
                             p.add(selnode.location);
                             p.snapToGridPoint(e.diagram.grid.gridOrigin, e.diagram.grid.gridCellSize);
                             // make the new node a copy of the selected node
                             var nodedata = m.copyNodeData(selnode.data);
                             // add to same group as selected node
                             m.setGroupKeyForNodeData(nodedata, m.getGroupKeyForNodeData(selnode.data));
                             m.addNodeData(nodedata); // add to model
                             // create a link from the selected node to the new node
                             var linkdata = { from: selnode.key, to: m.getKeyForNodeData(nodedata) };
                             m.addLinkData(linkdata); // add to model
                             // move the new node to the computed location, select it, and start to edit it
                             var newnode = e.diagram.findNodeForData(nodedata);
                             newnode.location = p;
                             e.diagram.select(newnode);
                             setTimeout(() => {
                                 e.diagram.commandHandler.editTextBlock();
                             }, 20);
                         });
                     };
                     return new go.Shape({
                         figure: fig,
                         alignment: spot,
                         alignmentFocus: spot.opposite(),
                         width: spot.equals(go.Spot.Top) || spot.equals(go.Spot.Bottom) ? 25 : 18,
                         height: spot.equals(go.Spot.Top) || spot.equals(go.Spot.Bottom) ? 18 : 25,
                         fill: 'orange',
                         stroke: colors.white,
                         strokeWidth: 4,
                         mouseEnter: (e, shape) => (shape.fill = 'dodgerblue'),
                         mouseLeave: (e, shape) => (shape.fill = 'orange'),
                         isActionable: true, // needed because it's in an Adornment
                         click: maker,
                         contextClick: maker
                     });
                 }

                 // create a button that brings up the context menu
                 function CMButton(options) {
                     return new go.Shape(
                         {
                             fill: 'orange',
                             stroke: 'rgba(0, 0, 0, 0)',
                             strokeWidth: 15,
                             background: 'transparent',
                             geometryString: 'F1 M0 0 b 0 360 -4 0 4 z M10 0 b 0 360 -4 0 4 z M20 0 b 0 360 -4 0 4', // M10 0 A2 2 0 1 0 14 10 M20 0 A2 2 0 1 0 24 10,
                             isActionable: true,
                             cursor: 'context-menu',
                             mouseEnter: (e, shape) => (shape.fill = 'dodgerblue'),
                             mouseLeave: (e, shape) => (shape.fill = 'orange'),
                             click: (e, shape) => {
                                 e.diagram.commandHandler.showContextMenu(shape.part.adornedPart);
                             }
                         },
                         options || {}
                     );
                 }

                 myDiagram.nodeTemplate.selectionAdornmentTemplate = new go.Adornment('Spot')
                     .add(
                         new go.Placeholder({ padding: 10 }),
                         makeArrowButton(go.Spot.Top, 'TriangleUp'),
                         makeArrowButton(go.Spot.Left, 'TriangleLeft'),
                         makeArrowButton(go.Spot.Right, 'TriangleRight'),
                         makeArrowButton(go.Spot.Bottom, 'TriangleDown'),
                         CMButton({ alignment: new go.Spot(0.75, 0) })
                     );

                 // Common context menu button definitions

                 // All buttons in context menu work on both click and contextClick,
                 // in case the user context-clicks on the button.
                 // All buttons modify the node data, not the Node, so the Bindings need not be TwoWay.

                 // A button-defining helper function that returns a click event handler.
                 // PROPNAME is the name of the data property that should be set to the given VALUE.
                 function ClickFunction(propname, value) {
                     return (e, obj) => {
                         e.handled = true; // don't let the click bubble up
                         e.diagram.model.commit((m) => {
                             m.set(obj.part.adornedPart.data, propname, value);
                             //Aqui sensa todas las acciones d cambio de la figura o enlace 24/01/2025
                             var oNodoData = obj.part.adornedPart.data;
                             if (obj.part.adornedPart instanceof go.Link) {
                                 Diagrama.Data.findUpdateLike(oNodoData.key);
                             }
                             else {
                                 Diagrama.Data.SaveObjInDB(oNodoData.key);//Actualiza datos 
                             }
                         });
                     };
                 }

                 // Create a context menu button for setting a data property with a color value.
                 function ColorButton(color, propname) {
                     if (!propname) propname = 'color';
                     return new go.Shape({
                         width: 16,
                         height: 16,
                         stroke: 'lightgray',
                         fill: color,
                         margin: 1,
                         background: 'transparent',
                         mouseEnter: (e, shape) => (shape.stroke = 'dodgerblue'),
                         mouseLeave: (e, shape) => (shape.stroke = 'lightgray'),
                         click: ClickFunction(propname, color),
                         contextClick: ClickFunction(propname, color)
                     });
                 }

                 function LightFillButtons() {
                     // used by multiple context menus
                     return [
                         go.GraphObject.build('ContextMenuButton')
                             .add(
                                 new go.Panel('Horizontal').add(
                                     ColorButton(colors.white, 'fill'),
                                     ColorButton(colors.beige, 'fill'),
                                     ColorButton(colors.extralightblue, 'fill'),
                                     ColorButton(colors.extralightred, 'fill')
                                 )
                             ),
                         go.GraphObject.build('ContextMenuButton')
                             .add(
                                 new go.Panel('Horizontal').add(
                                     ColorButton(colors.lightgray, 'fill'),
                                     ColorButton(colors.lightgreen, 'fill'),
                                     ColorButton(colors.lightblue, 'fill'),
                                     ColorButton(colors.lightred, 'fill')
                                 )
                             )
                     ];
                 }

                 function DarkColorButtons() {
                     // used by multiple context menus
                     return [
                         go.GraphObject.build('ContextMenuButton')
                             .add(
                                 new go.Panel('Horizontal')
                                     .add(
                                         ColorButton(colors.black),
                                         ColorButton(colors.green),
                                         ColorButton(colors.blue),
                                         ColorButton(colors.red)
                                     )
                             )
                             .add(
                                 go.GraphObject.build('ContextMenuButton')
                                     .add(
                                         new go.Panel('Horizontal')
                                             .add(
                                                 ColorButton(colors.white),
                                                 ColorButton(colors.magenta),
                                                 ColorButton(colors.purple),
                                                 ColorButton(colors.orange)
                                             )
                                     )
                             )
                     ];
                 }

                 // Create a context menu button for setting a data property with a stroke width value.
                 function ThicknessButton(sw, propname) {
                     if (!propname) propname = 'thickness';
                     return new go.Shape('LineH', {
                         width: 16,
                         height: 16,
                         strokeWidth: sw,
                         margin: 1,
                         background: 'transparent',
                         mouseEnter: (e, shape) => (shape.background = 'dodgerblue'),
                         mouseLeave: (e, shape) => (shape.background = 'transparent'),
                         click: ClickFunction(propname, sw),
                         contextClick: ClickFunction(propname, sw)
                     });
                 }

                 // Create a context menu button for setting a data property with a stroke dash Array value.
                 function DashButton(dash, propname) {
                     if (!propname) propname = 'dash';
                     return new go.Shape('LineH', {
                         width: 24,
                         height: 16,
                         strokeWidth: 2,
                         strokeDashArray: dash,
                         margin: 1,
                         background: 'transparent',
                         mouseEnter: (e, shape) => (shape.background = 'dodgerblue'),
                         mouseLeave: (e, shape) => (shape.background = 'transparent'),
                         click: ClickFunction(propname, dash),
                         contextClick: ClickFunction(propname, dash)
                     });
                 }

                 function StrokeOptionsButtons() {
                     // used by multiple context menus
                     return [
                         go.GraphObject.build('ContextMenuButton')
                             .add(
                                 new go.Panel('Horizontal')
                                     .add(
                                         ThicknessButton(1),
                                         ThicknessButton(2),
                                         ThicknessButton(3),
                                         ThicknessButton(4)
                                     )
                             ),
                         go.GraphObject.build('ContextMenuButton')
                             .add(
                                 new go.Panel('Horizontal').add(DashButton(null), DashButton([2, 4]), DashButton([4, 4]))
                             )
                     ];
                 }

                 // Node context menu

                 function FigureButton(fig, propname) {
                     if (!propname) propname = 'figure';
                     return new go.Shape({
                         width: 32,
                         height: 32,
                         scale: 0.5,
                         fill: 'lightgray',
                         figure: fig,
                         margin: 1,
                         background: 'transparent',
                         mouseEnter: (e, shape) => (shape.fill = 'dodgerblue'),
                         mouseLeave: (e, shape) => (shape.fill = 'lightgray'),
                         click: ClickFunction(propname, fig),
                         contextClick: ClickFunction(propname, fig)
                     });
                 }




/*
                 function ItemplateDocumentar(e) {
                     var MsgTemplate = '<table width="100%" align="left">'
                     MsgTemplate += '    <tr><td id="contentFind"></td></tr>'
                     MsgTemplate += '</table>';


                     var selectedNode = e.diagram.selection.first();
                     alert(selectedNode.key);

                     var urlPag = Page.Request.ApplicationPath + "/HelpDesk/ITIL/AdministrarDetalleAccion.aspx";
                     var oColletionParams = new SIMA.ParamCollections();

                     var oParam = new SIMA.Param(Administrar.KEYMODOPAGINA, 'F');
                     oColletionParams.Add(oParam);

                     SIMA.Utilitario.Helper.LoadPageIn("contentFind", urlPag, oColletionParams);


                     return MsgTemplate;
                 }*/

                 function DocumentarObjeto(e, obj) {
                     var oModo = SIMA.Utilitario.Enumerados.ModoPagina.M;
                     //Ref: https://gojs.net/latest/intro/contextMenus.html
                   /*  var ConfigMsgb = {
                         Titulo: 'DOCUMENTAR ACCIÓN'
                         , Descripcion: ItemplateDocumentar(e)
                         , Icono: 'fa fa-link'
                         , EventHandle: function (btn) {
                             if (btn == 'OK') {
                                 alert('terminado');
                             }
                         }
                     };
                     var oMsg = new SIMA.MessageBox(ConfigMsgb);
                     oMsg.confirm();*/


                     var selectedNode = e.diagram.selection.first();

                     var urlPag = Page.Request.ApplicationPath + "/HelpDesk/ITIL/AdministrarDetalleAccion.aspx";
                     var oColletionParams = new SIMA.ParamCollections();

                     var oParam = new SIMA.Param(AdministrarActividadProcedimiento.KEYIDACCCION, selectedNode.key);
                     oColletionParams.Add(oParam);
                     EasyPopupProcedimientoNota.Titulo = "Notas";
                     EasyPopupProcedimientoNota.Load(urlPag, oColletionParams, false);




                     /*myDiagram.commit(d => {
                                             const contextmenu = obj.part;
                                             const nodedata = contextmenu.data;
    
                                            }, "changed color");*/
                 }


                 myDiagram.nodeTemplate.contextMenu = go.GraphObject.build('ContextMenu')
                     .add(
                         go.GraphObject.build("ContextMenuButton", {
                             click: DocumentarObjeto,
                             "ButtonBorder.fill": "white",
                             "_buttonFillOver": "gray",
                         }).add(new go.TextBlock("Documentar..")),

                         /* go.GraphObject.build('ContextMenuButton')
                              .add(
                                  new go.Panel('Horizontal')
                                      .add(
                                          FigureButton('Rectangle'),
                                          FigureButton('RoundedRectangle'),
                                          FigureButton('Ellipse'),
                                          FigureButton('Diamond')
                                      )
                              ),*/
                         /*go.GraphObject.build('ContextMenuButton')
                         .add(
                               new go.Panel('Horizontal')
                                   .add(
                                       FigureButton('Parallelogram2'),
                                       FigureButton('ManualOperation'),
                                       FigureButton('Procedure'),
                                       FigureButton('Cylinder1')
                                   )
                           ),*/
                         go.GraphObject.build('ContextMenuButton')
                             .add(
                                 new go.Panel('Horizontal')
                                     .add(
                                         FigureButton('Terminator'),
                                         FigureButton('CreateRequest'),
                                         FigureButton('Document'),
                                         FigureButton('TriangleDown')
                                     )
                             ),
                         ...LightFillButtons(),
                         ...DarkColorButtons(),
                         ...StrokeOptionsButtons()
                     );



                 // Group template  Configuracion de objetos de grupo
                 myDiagram.groupTemplate = new go.Group('Spot', {
                     layerName: 'Background',
                     ungroupable: true,
                     locationSpot: go.Spot.Center,
                     selectionObjectName: 'BODY',
                     computesBoundsAfterDrag: true, // allow dragging out of a Group that uses a Placeholder
                     handlesDragDropForMembers: true, // don't need to define handlers on Nodes and Links
                     mouseDrop: (e, grp) => {
                         // add dropped nodes as members of the group
                         var ok = grp.addMembers(grp.diagram.selection, true);
                         if (!ok) grp.diagram.currentTool.doCancel();

                         var selectedNode = e.diagram.selection.first();
                         Diagrama.Data.SaveObjInDB(selectedNode.key);//Actualiza datos
                         //Buscar los enlaces relacionados al control arrastado al contenedor de procedimientos para reubicas sus coordenas
                         myDiagram.model.linkDataArray.forEach(function (oLink, i) {
                             if ((selectedNode.key == oLink.from) || (selectedNode.key == oLink.to)) {
                                 Diagrama.Data.findUpdateLike(oLink.key);
                             }
                         });

                     },
                     avoidable: false
                 })
                     .bindTwoWay('location', 'loc', go.Point.parse, go.Point.stringify)
                     .add(
                         new go.Panel('Auto', { name: 'BODY' })
                             .add(
                                 new go.Shape({
                                     parameter1: 10,
                                     fill: colors.white,
                                     strokeWidth: 2,
                                     cursor: 'pointer',
                                     fromLinkable: true,
                                     toLinkable: true,
                                     fromLinkableDuplicates: true,
                                     toLinkableDuplicates: true,
                                     fromSpot: go.Spot.AllSides,
                                     toSpot: go.Spot.AllSides
                                 })
                                     .bind('fill')
                                     .bind('stroke', 'color')
                                     .bind('strokeWidth', 'thickness')
                                     .bind('strokeDashArray', 'dash')
                             )
                             .add(new go.Placeholder({ background: 'transparent', margin: 20 })),
                         new go.TextBlock({
                             alignment: go.Spot.Top,
                             alignmentFocus: go.Spot.Bottom,
                             font: 'bold 12pt sans-serif',
                             editable: true,
                             textEdited: function (tb, oldstr, newstr) {
                                 if (oldstr !== newstr) {
                                     var node = tb.part;
                                     myDiagram.model.commit((m) => {
                                         m.set(tb.part.data, "text", newstr);//Modifica el texto del grupo
                                         Diagrama.Data.SaveObjInDB(node.data.key);//Actualiza datos 
                                     });
                                     
                                 }
                             }
                         })
                             .bind('text')
                             .bind('stroke', 'color')
                     );

                 myDiagram.groupTemplate.selectionAdornmentTemplate = new go.Adornment('Spot')
                     .add(
                         new go.Panel('Auto').add(
                             new go.Shape({ fill: null, stroke: 'dodgerblue', strokeWidth: 3 }),
                             new go.Placeholder({ margin: 1.5 })
                         ),
                         CMButton({ alignment: go.Spot.TopRight, alignmentFocus: go.Spot.BottomRight })
                     );

                 myDiagram.groupTemplate.contextMenu = go.GraphObject.build('ContextMenu')
                     .add(
                         ...LightFillButtons(),
                         ...DarkColorButtons(),
                         ...StrokeOptionsButtons()
                     );

                 // Link template Usado al momento de enlazar los objetos del diagrama
                 //********************************************************************************************************** */
                 myDiagram.linkTemplate = new go.Link({
                     layerName: 'Foreground',
                     routing: go.Routing.AvoidsNodes,
                     corner: 10,
                     fromShortLength: 10,
                     toShortLength: 15, // assume arrowhead at "to" end, need to avoid bad appearance when path is thick
                     relinkableFrom: true,
                     relinkableTo: true,
                     reshapable: true,
                     resegmentable: true
                 })
                     .bind('fromSpot', 'fromSpot', go.Spot.parse)
                     .bind('toSpot', 'toSpot', go.Spot.parse)
                     .bind('fromShortLength', 'dir', (dir) => (dir >= 1 ? 10 : 0))
                     .bind('toShortLength', 'dir', (dir) => (dir >= 1 ? 10 : 0))
                     .bindTwoWay('points') // TwoWay due to user reshaping with LinkReshapingTool
                     .add(
                         new go.Shape({ strokeWidth: 2 })
                             .bind('stroke', 'color')
                             .bind('strokeWidth', 'thickness')
                             .bind('strokeDashArray', 'dash'),
                         new go.TextBlock("..."),
                         new go.Shape({
                             // custom arrowheads to create the lifted effect
                             segmentIndex: 0,
                             segmentOffset: new go.Point(15, 0),
                             segmentOrientation: go.Orientation.Along,
                             alignmentFocus: go.Spot.Right,
                             figure: 'circle',
                             width: 15,
                             strokeWidth: 0
                         })
                             .bind('fill', 'color')
                             .bind('visible', 'dir', (dir) => dir === 1),
                         new go.Shape({
                             segmentIndex: -1,
                             segmentOffset: new go.Point(-10, 6),
                             segmentOrientation: go.Orientation.Plus90,
                             alignmentFocus: go.Spot.Right,
                             figure: 'triangle',
                             width: 12,
                             height: 12,
                             strokeWidth: 0
                         })
                             .bind('fill', 'color')
                             .bind('visible', 'dir', (dir) => dir >= 1)
                             .bind('width', 'thickness', (t) => 7 + 3 * t) // custom arrowhead must scale with the size of the while
                             .bind('height', 'thickness', (t) => 7 + 3 * t) // while remaining centered on line
                             .bind('segmentOffset', 'thickness', (t) => new go.Point(-15, 4 + 1.5 * t)),
                         /* new go.Shape({
                              segmentIndex: 0,
                              segmentOffset: new go.Point(15, -6),
                              segmentOrientation: go.Orientation.Minus90,
                              alignmentFocus: go.Spot.Right,
                              figure: 'triangle',
                              width: 12,
                              height: 12,
                              strokeWidth: 0
                          })
                              .bind('fill', 'color')
                              .bind('visible', 'dir', (dir) => dir === 2)
                              .bind('width', 'thickness', (t) => 7 + 3 * t)
                              .bind('height', 'thickness', (t) => 7 + 3 * t)
                              .bind('segmentOffset', 'thickness', (t) => new go.Point(-15, 4 + 1.5 * t)),*/

                         new go.TextBlock("Etiqueta", {
                             alignmentFocus: new go.Spot(0, 1, -4, 0),
                             editable: true,
                             textEdited: function (tb, oldstr, newstr) {
                                 if (oldstr !== newstr) {
                                     var node = tb.part;
                                     if (node instanceof go.Link) {//Modifica el texto del Objeto
                                         Diagrama.Data.findUpdateLike(node.data.key);
                                     }
                                 }
                             }
                         })
                             .bindTwoWay('text') // TwoWay due to user editing with TextEditingTool
                             .bind('stroke', 'color')
                     );
                 //********************************************************************************************************** */
                 myDiagram.linkTemplate.selectionAdornmentTemplate = new go.Adornment() // use a special selection Adornment that does not obscure the link path itself
                     .add(
                         new go.Shape({
                             // this uses a pathPattern with a gap in it, in order to avoid drawing on top of the link path Shape
                             isPanelMain: true,
                             stroke: 'transparent',
                             strokeWidth: 6,
                             pathPattern: makeAdornmentPathPattern(2) // == thickness or strokeWidth
                         }).bind('pathPattern', 'thickness', makeAdornmentPathPattern),
                         CMButton({ alignmentFocus: new go.Spot(0, 0, -6, -4) })
                     );

                 function makeAdornmentPathPattern(w) {
                     return new go.Shape({
                         stroke: 'dodgerblue',
                         strokeWidth: 2,
                         strokeCap: 'square',
                         geometryString: 'M0 0 M4 2 H3 M4 ' + (w + 4).toString() + ' H3'
                     });
                 }

                 // Link context menu
                 // All buttons in context menu work on both click and contextClick,
                 // in case the user context-clicks on the button.
                 // All buttons modify the link data, not the Link, so the Bindings need not be TwoWay.

                 /*------------------------------------------------------------------------------------------------------*/
                 /*-------------------------------------------FLECHAS---------------------------------------------------*/
                 /*------------------------------------------------------------------------------------------------------*/

                 function ArrowButton(num) {
                     var geo = 'M0 0 M8 16 M0 8 L16 8  M12 11 L16 8 L12 5';
                     if (num === 0) {
                         geo = 'M0 0 M16 16 M0 8 L16 8';
                     } else if (num === 2) {
                         geo = 'M0 0 M16 16 M0 8 L16 8  M12 11 L16 8 L12 5  M4 11 L0 8 L4 5';
                     }
                     return new go.Shape({
                         geometryString: geo,
                         margin: 2,
                         background: 'transparent',
                         mouseEnter: (e, shape) => (shape.background = 'dodgerblue'),
                         mouseLeave: (e, shape) => (shape.background = 'transparent'),
                         click: ClickFunction('dir', num),
                         contextClick: ClickFunction('dir', num)
                     });
                 }

                 function AllSidesButton(to) {
                     var setter = (e, shape) => {
                         e.handled = true;
                         e.diagram.model.commit((m) => {
                             var link = shape.part.adornedPart;
                             m.set(link.data, to ? 'toSpot' : 'fromSpot', go.Spot.stringify(go.Spot.AllSides));
                             // re-spread the connections of other links connected with the node
                             (to ? link.toNode : link.fromNode).invalidateConnectedLinks();
                         });
                     };
                     return new go.Shape({
                         width: 12,
                         height: 12,
                         fill: 'transparent',
                         mouseEnter: (e, shape) => (shape.background = 'dodgerblue'),
                         mouseLeave: (e, shape) => (shape.background = 'transparent'),
                         click: setter,
                         contextClick: setter
                     });
                 }

                 function SpotButton(spot, to) {
                     var ang = 0;
                     var side = go.Spot.RightSide;
                     if (spot.equals(go.Spot.Top)) {
                         ang = 270;
                         side = go.Spot.TopSide;
                     } else if (spot.equals(go.Spot.Left)) {
                         ang = 180;
                         side = go.Spot.LeftSide;
                     } else if (spot.equals(go.Spot.Bottom)) {
                         ang = 90;
                         side = go.Spot.BottomSide;
                     }
                     if (!to) ang -= 180;
                     var setter = (e, shape) => {
                         // alert('demo eddy'); Cuando se usa las opciones del menu
                         e.handled = true;
                         e.diagram.model.commit((m) => {
                             var link = shape.part.adornedPart;
                             m.set(link.data, to ? 'toSpot' : 'fromSpot', go.Spot.stringify(side));
                             // re-spread the connections of other links connected with the node
                             (to ? link.toNode : link.fromNode).invalidateConnectedLinks();

                             //Actualiza en la base de datos los cambios
                             Diagrama.Data.findUpdateLike(link.data.key);


                         });
                     };
                     return new go.Shape({
                         alignment: spot,
                         alignmentFocus: spot.opposite(),
                         geometryString: 'M0 0 M12 12 M12 6 L1 6 L4 4 M1 6 L4 8',
                         angle: ang,
                         background: 'transparent',
                         mouseEnter: (e, shape) => (shape.background = 'dodgerblue'),
                         mouseLeave: (e, shape) => (shape.background = 'transparent'),
                         click: setter,
                         contextClick: setter
                     });
                 }

                 //Menu context en la Lknea link
                 //Popup Menu de Tipo de lineas
                 myDiagram.linkTemplate.contextMenu = go.GraphObject.build('ContextMenu')
                     .add(
                         ...DarkColorButtons(),
                         ...StrokeOptionsButtons(),
                         go.GraphObject.build("ContextMenuButton", {
                             click: DocumentarObjeto,
                             "ButtonBorder.fill": "white",
                             "_buttonFillOver": "gray",
                         }).add(new go.TextBlock("Documentarx..")),
                         go.GraphObject.build('ContextMenuButton')
                             .add(new go.Panel('Horizontal').add(ArrowButton(0), ArrowButton(1), ArrowButton(2))
                             ),
                         go.GraphObject.build('ContextMenuButton')
                             .add(
                                 new go.Panel('Horizontal')
                                     .add(
                                         new go.Panel('Spot')
                                             .add(
                                                 AllSidesButton(false),
                                                 SpotButton(go.Spot.Top, false),
                                                 SpotButton(go.Spot.Left, false),
                                                 SpotButton(go.Spot.Right, false),
                                                 SpotButton(go.Spot.Bottom, false)
                                             ),
                                         new go.Panel('Spot', { margin: new go.Margin(0, 0, 0, 2) })
                                             .add(
                                                 AllSidesButton(true),
                                                 SpotButton(go.Spot.Top, true),
                                                 SpotButton(go.Spot.Left, true),
                                                 SpotButton(go.Spot.Right, true),
                                                 SpotButton(go.Spot.Bottom, true)
                                             )
                                     )
                             )
                     );

         

                 /*view-source:file:///C:/Users/EROSALES/Downloads/Robot.html
                     Configuracion de la paleta de herraientas 
                     referencia: https://stackoverflow.com/questions/51419194/format-and-align-text-in-gojs-chart
                 */
             }
           // window.addEventListener('DOMContentLoaded', init);


         </script>

    <script>

        //Diagrama.Open();
    </script>
      <script>
        /*  document.addEventListener("DOMContentLoaded", function () {
                                                              init();
                                                              Diagrama.Drawing.Tools.Paint();
                                                              Diagrama.Drawing.Paint();
                                                          });*/
      </script>
</body>
</html>
