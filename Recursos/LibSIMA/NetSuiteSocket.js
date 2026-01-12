//Manejo de PROMESAS:  https://web.dev/articles/promises?hl=es
//Instancia el objeto 
NetSuite.LiveChat = {};


NetSuite.Manager = {};
NetSuite.Manager.Infinity = {};
NetSuite.Manager.Infinity.User = {};
NetSuite.Manager.Infinity.User.Contectado = false;
NetSuite.Manager.Infinity.InterfaceLoad = false;//Indica si la interface ID del chat esta cargado  y visible

NetSuite.Manager.Infinity.LimitCountPage = 10;
NetSuite.Manager.Infinity.CountPage = 0;

NetSuite.Manager.Broker = {};
NetSuite.Manager.Broker.Persiana = {};
NetSuite.Manager.Broker.Wind = "BrokerWind";
NetSuite.Manager.Broker.WindContent = "BrokerContent";
NetSuite.Manager.Broker.Persiana.Load = false;

NetSuite.Manager.Broker.Persiana.Open = function (oLoadConfig) {
    oLoadConfig.CtrlName = NetSuite.Manager.Broker.WindContent;
    if (NetSuite.Manager.Broker.Persiana.Load == false) {
        SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
        NetSuite.Manager.Broker.Persiana.Load = true;
    }
    jNet.get(NetSuite.Manager.Broker.Wind).css("width", "100%").css("left", "0").css("padding-top", "110px");

    NetSuite.Manager.Infinity.AcivarPlataforma();
}
NetSuite.Manager.Broker.Persiana.Close = function () {
    //muestra la barra de usuarios
    /*jNet.get("LblContact").css("display", "block");
    jNet.get("LstContact").css("display", "block");*/
    jNet.get(NetSuite.Manager.Broker.Wind).css("width", "0%").css("left", "100%");
}
NetSuite.Manager.Broker.Persiana.Popup = {};//Para las ventanas de servicios

NetSuite.Manager.Data = {};
NetSuite.Manager.Data.Response = function (IdResponse,IdTipo) {
    var oEasyDataInterConect = new EasyDataInterConect();
    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
    oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
    oEasyDataInterConect.Metodo = "Response_Listar";

    var oParamCollections = new SIMA.ParamCollections();
    var oParam = new SIMA.Param("IdResponse", IdResponse);
    oParamCollections.Add(oParam);

    oParam = new SIMA.Param("IdTipo", IdTipo, TipodeDato.Int);
    oParamCollections.Add(oParam);

    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
    oParamCollections.Add(oParam);

    oEasyDataInterConect.ParamsCollection = oParamCollections;

    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
    return oEasyDataResult.getDataTable();
}

NetSuite.Manager.Data.ResponseFind = function (Criterio) {
    var oEasyDataInterConect = new EasyDataInterConect();
    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
    oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
    oEasyDataInterConect.Metodo = "Response_Buscar";

    var oParamCollections = new SIMA.ParamCollections();
    var oParam = new SIMA.Param("Criterio", Criterio);
    oParamCollections.Add(oParam);

    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
    oParamCollections.Add(oParam);

    oEasyDataInterConect.ParamsCollection = oParamCollections;

    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
    return oEasyDataResult.getDataTable();
}

NetSuite.Manager.Data.ResponseChild = function (IdPadre) {
    var oEasyDataInterConect = new EasyDataInterConect();
    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
    oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
    oEasyDataInterConect.Metodo = "Response_ListarSubRespuestas";

    var oParamCollections = new SIMA.ParamCollections();
    var oParam = new SIMA.Param("IdPadre", IdPadre);
    oParamCollections.Add(oParam);

    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
    oParamCollections.Add(oParam);

    oEasyDataInterConect.ParamsCollection = oParamCollections;

    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
    return oEasyDataResult.getDataTable();
}



function ObtenerHora() {
    var ahora = new Date();
    var horas = ahora.getHours().toString().padStart(2, '0');
    var minutos = ahora.getMinutes().toString().padStart(2, '0');
    var segundos = ahora.getSeconds().toString().padStart(2, '0');
    return `${horas}:${minutos}:${segundos}`;
}



NetSuite.Manager.Broker.Response = function (IdBubbleResponse,HTMLText) {    
    var Logo = 'data:image/png;base64,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';
    return '<div class="chat-msg" id="' + "bubble_" + IdBubbleResponse + '"   >'
        + '   <div class="chat-msg-profile">'
        + '      <img class="chat-msg-imgd" src="' + Logo + '" alt="" />'
        + '      <div class="chat-msg-date">Hora:' + ObtenerHora() +'</div>'
        + '   </div>'
        + '   <div class="chat-msg-content" href="#' + IdBubbleResponse + '" id="Content_' + IdBubbleResponse + '"  >'
        + '         <div id="t' + IdBubbleResponse + '" class="chat-msg-text">' + ((HTMLText == undefined) ? "" : HTMLText) + ' </div>';
        + '   </div>'
        + '</div> ';   
}

NetSuite.Manager.Broker.ResponseGroup = function (IdBubbleResponse,HTMLText) {
    var Logo = 'data:image/png;base64,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';
    return '<div class="Base-message"  id="' + "bubble_" + IdBubbleResponse + '" >'
            + '       <div class="Base-message-text">'
        + '              <h2  id="' + "Title_" + IdBubbleResponse + '">' + ((HTMLText == undefined) ? "" : HTMLText) + ' </h2>'
            + '              <p1 id="' + "t" + IdBubbleResponse + '"></p1>'
            + '         </div>'
            + '</div> ';
}

NetSuite.Manager.Broker.ResponseSubItem = function (IdBubbleResponse,Icono, HTMLText) {
    return '<div class="chat-msg" id="' + "bubble_" + IdBubbleResponse + '"   >'
            + '   <div class="chat-msg-profile">'
            + '      <div id="t' + IdBubbleResponse + '" class="message-box message-partner" style="cursor:pointer" onclick="alert();">' + ((HTMLText == undefined) ? "" : HTMLText) + '</div>'
            + '   </div>'
            + '</div> ';

}
NetSuite.Manager.Broker.ResponseItemOP = function (IdBubbleResponse, Titulo, Descripcion,oData) {
    var cmll = "\"";
    var strData = "";
    if (oData != undefined) {
        strData = "".BaseSerialized(oData).Replace(cmll, "'");
    }
    return '<blockquote class="bluejeans"  style="cursor:pointer" onclick="NetSuite.Manager.Broker.Servicios(this);">'
        + '     <h1><span class="Cbluejeans" id="Title_' + IdBubbleResponse +'">' + Titulo + '</span>..</h1>'
        + '     <p id="t' + IdBubbleResponse + '" Data="' + strData + '">' + Descripcion + '</p>'
        + ' </blockquote>';
}

NetSuite.Manager.Broker.Request = function (IdBubbleRequest) {
    return ' <div class="chat-msg owner" id="' + "bubble_" + IdBubbleRequest + '"   >'
        + '     <div class="chat-msg-profile">'
        + '          <img class="chat-msg-img" src="' + EasyNetLiveChat.FotoContacto(UsuarioBE.NroDocumento) + '" alt="" />'
        + '          <div class="chat-msg-date">Hora:' + ObtenerHora() +'</div>'
        + '     </div>'
        + '     <div class="chat-msg-content"  href="#' + IdBubbleRequest + '"   id="Content_' + IdBubbleRequest + '" >'
        + '         <div class="chat-msg-text"   id="t' + IdBubbleRequest + '" ></div>';
        + '     </div>'
        + '</div>';
}


///Estaba en la libreria injectada relacionada la serviciio ahora se defni de forma generica y local
NetSuite.Manager.Broker.InjectServicio = function (_DataBE) {
    var oColletionParams = new SIMA.ParamCollections();
    var oParam = "";

    NetSuite.Manager.Broker.ParamsLib(_DataBE.PARAMS, function (PName, PValue) {
        oParam = new SIMA.Param(PName, PValue);
        oColletionParams.Add(oParam);
    });
    oParam = new SIMA.Param("QLlama", "EasyNetLiveChat");
    oColletionParams.Add(oParam);

    var urlPag = Page.Request.ApplicationPath + "/HelpDesk/Incidencia/ListarIncidenciaPorArea.aspx";
    var oLoadConfig = {
        CtrlName: "t" + _DataBE.ID_RESP,
        UrlPage: urlPag,
        ColletionParams: oColletionParams,
        fnOnComplete: function () {
            //  alert('Termino');
        }
    };
    SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
}




NetSuite.Manager.Broker.Servicios = function (e) {
    var FrameBrocker='<div id=[ID]>LOAD SERVICE</div>'
    for (var i in e.children) {
        var objChild = jNet.get(e.children[i]);
        if (objChild.tagName.toUpperCase() == "P") {
            var DataBE = objChild.attr("Data").toString().SerializedToObject();
            if (DataBE != null) {
                if (EasyNetLiveChat.Panel.Body().find("bubble_" + DataBE.ID_RESP) == false) {
                    EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.Manager.Broker.Response(DataBE.ID_RESP, '');
                    var objWriterErr = (new Maquina("t" + DataBE.ID_RESP));
                        document.getElementById("t" + DataBE.ID_RESP).scrollIntoView({ behavior: 'smooth' });
                        objWriterErr.Clear();
                        objWriterErr.typeWriter("Un momento por favor se están cargando los servicios para </br>" + DataBE.RESPUESTA, function () {
                                                                                                                //Ejecutar el inicio de la libreria
                                                                                                                objWriterErr.Clear();
                                                                                                                NetSuite.Manager.Broker.InjectServicio(DataBE);
                                                                                                                document.getElementById("t" + DataBE.ID_RESP).scrollIntoView({ behavior: 'smooth' });
                                                                                                            });
                }
                else {
                  //  alert('Existe');

                    document.getElementById("t" + DataBE.ID_RESP).scrollIntoView({ behavior: 'smooth' });
                }
            }
            else {
                var msgConfig = { Titulo: "Conficuración de Servicio", Descripcion: iTempateNotdefineServicr };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }

        }
    }
}
var iTempateNotdefineServicr = "No define servicios..";


NetSuite.Manager.Broker.ParamsLib = function (QParams, fncTask) {
    if ((QParams!=undefined)&&(QParams.Replace(' ','').length > 0)) {
        var qs = QParams.match(/\w+=\w+/g);
        var _GET = {};
        var t, i = qs.length;
        while (i--) {
            t = qs[i].split("=");
            _GET[t[0]] = t[1];
            eval('var ' + t[0] + '="' + t[1] + '";');
            if (fncTask != undefined) {
                fncTask(t[0], t[1]);
            }
        }
    }
}



NetSuite.Manager.Broker.RegistrarLib = function (LibJSSRV,ParamsCollection,fncLoadLib) {

    if (LibJSSRV.length == 0) { return; }

    var sInfo = ScriptManager.GetInfo(Page.Request.ApplicationPath + "/Recursos/LibSIMA/ChatBotServiceBroker" + LibJSSRV);

    if (ParamsCollection != undefined) {
        ParamsCollection.forEach(function (Param, i) {
            sInfo.Params.Add(Param);
        });
    }

    //Registra la Libreria en la pagina 
    var objScriptInfo = ScriptManager.Using(sInfo, fncLoadLib);

    return sInfo;
}





NetSuite.Manager.StatusConect = function () {
    NetSuite.Manager.Infinity.User.Contectado = true;
    NetSuite.Manager.Infinity.AcivarPlataforma();
    var StatusUsu = jNet.get(document.getElementsByClassName('status-circle')[0]);
    StatusUsu.css('background-color', 'green')
        .css('border-radius', '50%')
        .css('border', '2px solid white');
    StatusUsu.clear();
    //Actualiza el estado del contacto
    NetSuite.LiveChat.Data.UpDEstadoContacto(UsuarioBE.CodPersonal, 1);
}

var imgMeta = 'data:image/png;base64,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';

NetSuite.Manager.Bienvenida = function (htmlPart) {
    var responses = new Array();
    NetSuite.Manager.Data.Response("0", "1").Rows.forEach(function (oDataRow, i) {
        responses.Add(oDataRow["RESPUESTA"].toString());
    });
    var botResponse = responses[Math.floor(Math.random() * responses.length)];
    return '    <div class="row">'
        + '     <div class="col-md-10">'
        + '          <p class="BubbleAmarillo">'
        + '              ' + botResponse.Replace("[USERNAME]", UsuarioBE.UserName)
        + '          </p>'
        + '          <div class="wrapperAmarillo">'
        //+ '              <img src="' + imgMeta + '" />'    
        + ((htmlPart == undefined) ? "" : htmlPart);
        +'          </div>'
        +'      </div>'
        +'  </div>';
}

NetSuite.Manager.ImgLatencia = function () {
    return jNet.create('img').attr("width", "30px")
        .attr("height", "30px")
        .attr("src", Page.Request.ApplicationPath + "/Recursos/img/Infinity.gif");
}
NetSuite.Manager.TestingSocketListener = function () {
    var StatusUsu = jNet.get(document.getElementsByClassName('status-circle')[0]);
    if (StatusUsu.attr('Testing') == undefined) {
        StatusUsu.css('background-color', 'transparent')
                 .css('border', '2px solid transparent')
                 .attr('Testing', 'true');
        StatusUsu.clear();
        StatusUsu.insert(NetSuite.Manager.ImgLatencia());
    }
}

NetSuite.Manager.Infinity.WorkingFrame = function () {
    // NetSuite.LiveChat = new _NetSuite.Chat(SIMA.Utilitario.Helper.Configuracion.Leer("ConfigBase", "NetSuteSocket") + "platform=WebID" + "&App=SIMANetSuiteWeb&name=" + UsuarioBE.UserName + "&CodPer=" + UsuarioBE.CodPersonal + "&IdContac=" + UsuarioBE.IdContacto);
    var oConect = new _NetSuite.Chat(SIMA.Utilitario.Helper.Configuracion.Leer("ConfigBase", "NetSuteSocket") + "platform=WebID" + "&App=SIMANetSuiteWeb&name=" + UsuarioBE.UserName + "&CodPer=" + UsuarioBE.CodPersonal + "&IdContac=" + UsuarioBE.IdContacto);
        oConect.then(function (wSocket) {
                        NetSuite.LiveChat = wSocket;
                        NetSuite.Manager.StatusConect();
                    }).catch(function (err) {
                        NetSuite.Manager.TestingSocketListener();
                        NetSuite.LiveChat = null;
                    });

    if (NetSuite.LiveChat instanceof WebSocket) {
        NetSuite.LiveChat.LinkService = null;//Funcion que permite el enlace de la implementacion LibBroker
        /*----------------------------------------------------------------------------------------------------------------*/
        /*Eventoa de conectividad*/
        /*----------------------------------------------------------------------------------------------------------------*/
        NetSuite.LiveChat.onclose = function (event) {
            NetSuite.Manager.Infinity.User.Contectado = false;
            NetSuite.Manager.TestingSocketListener();
            NetSuite.LiveChat.Data.UpDEstadoContacto(UsuarioBE.CodPersonal, 2);//Close Listener o servicio NetSuiteSockry
            ConSleep = 1000;
            NetSuite.Manager.Infinity.CircleConeccion(true);


            if (event.wasClean) {
               // alert('Conexión cerrada correctamente, code=' + event.code + ' reason=' + event.reason);
            } else {
                // e.g. server process killed or network down
                // event.code is usually 1006 in this case
               // alert('[close] La conexión se perdió');
            }
            //NetSuite.LiveChat = null;//velve a inicializar
        };
      

        NetSuite.LiveChat.onerror = function (error) {
            NetSuite.Manager.Infinity.User.Contectado = false;
            NetSuite.LiveChat.Data.UpDEstadoContacto(UsuarioBE.CodPersonal, 2);
        }

        NetSuite.LiveChat.onmessage = function (evt) {
            var ObjectResult = evt.data.split('|');
            var oPaqueteBE = ObjectResult[1].toString().SerializedToObject();

            if (NetSuite.Manager.Infinity.InterfaceLoad == true) {
                switch (ObjectResult[0]) {
                    case "chatPaqueteBE"://Adicional que confirma que se ha conectado
                        if (oContactoDestinoBE != null) {
                            NetSuite.LiveChat.MiembrosGrupo.Estado(oPaqueteBE.codPersonal, "green");
                        }
                        break;
                    case "PaqueteBE":
                        if (oContactoDestinoBE != null) {//Contacto seleccionado
                            if (((oPaqueteBE.IdContactoTo == UsuarioBE.IdContacto) && (oPaqueteBE.IdContactoFrom == oContactoDestinoBE.IdContacto)) && (oPaqueteBE.IdContactoFrom != UsuarioBE.IdContacto)) {

                                EasyNetLiveChat.Data.LstMiembroGrupoSeleccionado(oPaqueteBE.IdContactoFrom).Rows.forEach(function (oDataRow, i) {
                                    //Verificar si los usuarios estan conectados
                                    var oContactBE = new NetSuite.LiveChat.ContactBE();
                                    oContactBE.Foto = EasyNetLiveChat.FotoContacto(oDataRow.NRODOCUMENTO);
                                    oContactBE.IdContacto = oDataRow.ID_CONTACT;
                                    oContactBE.IdMiembro = oDataRow.ID_MIEMBRO;
                                    oContactBE.Nombre = oDataRow.APELLIDOSYNOMBRES;

                                    //if ((oContactBE.IdMiembro == oPaqueteBE.IdMiembro) ||(oContactBE.IdMiembro != oPaqueteBE.IdMiembro)) {
                                    if (oContactBE.IdMiembro == oPaqueteBE.IdMiembro) {
                                        var oMensajeBE = new NetSuite.LiveChat.MensajeBE();
                                        oMensajeBE.ContactoFrom = oContactBE;
                                        oMensajeBE.IdMsg = oPaqueteBE.IdMsg;
                                        oMensajeBE.AllContenidoBE = EasyNetLiveChat.Data.ListaHistorialChatContenido(oPaqueteBE.IdMsg);

                                        EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.LiveChat.ItemplateChatContact(oMensajeBE);
                                        //11-08-2025 desplazamiento del mensaje
                                        document.getElementById(oPaqueteBE.IdMsg).scrollIntoView({ behavior: 'smooth' });
                                    }
                                });
                            }
                            else if ((oContactoSendDestinoSeleccionadoBE != undefined)
                                && (oPaqueteBE.IdContactoTo == oContactoDestinoBE.IdContacto)
                                && (oPaqueteBE.IdContactoFrom == oContactoSendDestinoSeleccionadoBE.IdContacto)
                            ) {

                                var oContactBE = new NetSuite.LiveChat.ContactBE();
                                oContactBE.Foto = oContactoSendDestinoSeleccionadoBE.Foto;
                                oContactBE.IdContacto = oContactoSendDestinoSeleccionadoBE.IdContacto;
                                oContactBE.IdMiembro = oContactoSendDestinoSeleccionadoBE.IdContacto;
                                oContactBE.Nombre = oContactoSendDestinoSeleccionadoBE.Nombre;

                                var oMensajeBE = new NetSuite.LiveChat.MensajeBE();
                                oMensajeBE.ContactoFrom = oContactBE;
                                oMensajeBE.IdMsg = oPaqueteBE.IdMsg;
                                oMensajeBE.AllContenidoBE = EasyNetLiveChat.Data.ListaHistorialChatContenido(oPaqueteBE.IdMsg);

                                EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.LiveChat.ItemplateChatContact(oMensajeBE);
                                //11-08-2025 desplazamiento del mensaje
                                document.getElementById(oPaqueteBE.IdMsg).scrollIntoView({ behavior: 'smooth' });
                            }
                            else if ((oPaqueteBE.IdContactoFrom == oContactoDestinoBE.IdContacto)) {//and contactoto del paquete sea igual al contacto destino seleccionado

                                if ((oPaqueteBE.IdContactoTo == oContactoSendDestinoSeleccionadoBE.IdContacto) && (EasyNetLiveChat.IdMiembroGrupoSeleccionado != oPaqueteBE.IdMiembro)) {//si estoy en el grupo saber a quien se envia y que no muestre el mensaje al miembro del grupo que evia
                                    //Buscar El contacto del grupo que envio
                                    var oContactBE = new NetSuite.LiveChat.ContactBE();
                                    //Buscar de los miembros del grupo quien envio el mensaje
                                    EasyNetLiveChat.Data.LstMiembroGrupoSeleccionado(oPaqueteBE.IdContactoFrom).Select("ID_MIEMBRO", "=", oPaqueteBE.IdMiembro).forEach(function (oDataContactSend, x) {
                                        oContactBE.Foto = EasyNetLiveChat.FotoContacto(oDataContactSend.NRODOCUMENTO);
                                        oContactBE.IdContacto = oDataContactSend.ID_CONTACT;
                                        oContactBE.IdMiembro = oDataContactSend.ID_MIEMBRO;
                                        oContactBE.Nombre = oDataContactSend.APELLIDOSYNOMBRES;
                                    });

                                    var oMensajeBE = new NetSuite.LiveChat.MensajeBE();
                                    oMensajeBE.ContactoFrom = oContactBE;
                                    oMensajeBE.IdMsg = oPaqueteBE.IdMsg;
                                    oMensajeBE.AllContenidoBE = EasyNetLiveChat.Data.ListaHistorialChatContenido(oPaqueteBE.IdMsg);

                                    EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.LiveChat.ItemplateChatOwner(oMensajeBE);
                                    //11-08-2025 desplazamiento del mensaje
                                    document.getElementById(oPaqueteBE.IdMsg).scrollIntoView({ behavior: 'smooth' });
                                }
                            }
                            else if (
                                (oContactoSendDestinoSeleccionadoBE == null)
                                ||
                                (oContactoSendDestinoSeleccionadoBE == undefined)
                            ) {
                                //verificar  si el contacto que envia obtener datos idpersonal y verificar cn el usuario ogueado con el codpersonal si son iguales no mostrar mensaje
                                var oContactBETmp = new NetSuite.LiveChat.ContactBE();
                                EasyNetLiveChat.Data.LstMiembroGrupoSeleccionado(oPaqueteBE.IdContactoFrom).Select("ID_MIEMBRO", "=", oPaqueteBE.IdMiembro).forEach(function (oDataContactSend, x) {
                                    oContactBETmp.IdContacto = oDataContactSend.ID_CONTACT;
                                    oContactBETmp.IdMiembro = oDataContactSend.ID_MIEMBRO;
                                    oContactBETmp.Nombre = oDataContactSend.APELLIDOSYNOMBRES;
                                });

                                if (oContactBETmp.IdContacto != oPaqueteBE.IdContactoFrom) {
                                    new Nostfly({
                                        openAnimate: 'nostfly-open-slide-up',
                                        content: 'No se ha seleccionado contacto que emite se debera mostrar remitente y contenido',
                                        closeAnimate: 'your-custom-class'
                                    });
                                }
                            }
                        }
                        else {

                            new Nostfly({
                                header: 'Supports HTML',
                                content: '<table border="5px"><tr><td> ' + ObjectResult + '</td></tr></table>',
                            });
                        }
                        break;
                    case "chatCloseContact":
                        var oPaqueteBE = ObjectResult[1].toString().SerializedToObject();
                        if (oContactoDestinoBE != null) {
                            NetSuite.LiveChat.MiembrosGrupo.Estado(oPaqueteBE.codPersonal, "red");
                        }
                        break;
                }
            }
            else {
                //en caso la ventana de mensajes este desactivada
                if (oPaqueteBE.IdContactoTo != undefined) {
                    if (NetSuite.LiveChat.MiembrosGrupo.DisplayAlertMsgRecibe(oPaqueteBE.IdContactoTo) == true) {


                        new Nostfly({
                            // Or: 'nostfly-open-slide-left', 'nostfly-open-slide-down', 'nostfly-open-fade'
                            header: 'recibido',
                            content: NetSuite.LiveChat.ItemplateMsgRecibidoNoWind(oPaqueteBE),
                            openAnimate: 'nostfly-open-slide-up',
                            // Or: 'nostfly-close-slide-left', 'nostfly-close-slide-up', 'nostfly-close-slide-down', 'nostfly-close-fade'
                            //closeAnimate: 'your-custom-class'
                            closeAnimate: 'nostfly-close-slide-left'//, 'nostfly-close-slide-up', 'nostfly-close-slide-down', 'nostfly-close-fade'
                        });

                        //alert(NetSuite.LiveChat.ItemplateMsgRecibidoNoWind(oPaqueteBE));

                    }
                    else if (NetSuite.LiveChat.MiembrosGrupo.DisplayAlertMsgRecibe(oPaqueteBE.IdContactoFrom) == true) {
                    }
                }
            }

        }
        /*----------------------------------------------------------------------------------------------------------------*/
    }

}


NetSuite.Manager.Infinity.AcivarPlataforma = function () {
    NetSuite.LiveChat.bubble = {};
    NetSuite.LiveChat.bubble.Style = {};

    NetSuite.LiveChat.bubble.Style.Father = "chat-msg";
    NetSuite.LiveChat.bubble.Style.FatherOwner = "chat-msg owner";
    NetSuite.LiveChat.bubble.Style.FatherOwnerSelect = ".owner .chat-msg-text-Select";

    NetSuite.LiveChat.bubble.Style.MsgText = "chat-msg-text";
    NetSuite.LiveChat.bubble.Style.MsgTextSelect = "chat-msg-text-Select";

    
    NetSuite.LiveChat.bubble.Style.MsgContent = "chat-msg-content";
    NetSuite.LiveChat.bubble.Style.MsgContentSelect = "chat-msg-content-Select";


    NetSuite.LiveChat.bubble.SelectBE = function (_Id, _Class, _IdChild, _ChildClass) {
        this.Id = _Id;
        this.Class = _Class;
        this.IdChild = _IdChild;
        this.ChildClass = _ChildClass;
    };
    var obubbleSelectBE = new NetSuite.LiveChat.bubble.SelectBE();

    NetSuite.LiveChat.bubble.Click = function (e) {
        var htmlBubble = jNet.get(e);
        var htmlChatMsg = jNet.get(htmlBubble.parentNode);
      
        if (obubbleSelectBE.IdChild == undefined) {
            obubbleSelectBE.Id = htmlChatMsg.attr("id");
            obubbleSelectBE.Class = htmlChatMsg.attr("class");
            //Hijo
            obubbleSelectBE.IdChild = htmlBubble.attr("id");
            obubbleSelectBE.ChildClass = htmlBubble.attr("class");
            //Establecer el estilo de seleccion
            htmlBubble.attr("class", NetSuite.LiveChat.bubble.Style.MsgTextSelect);
        }
        else if (obubbleSelectBE.IdChild != htmlBubble.attr("id")) {
            var HtmlChatMsgOld = jNet.get(obubbleSelectBE.Id);
            HtmlChatMsgOld.attr("class", obubbleSelectBE.Class);
            var HtmlChildChatMsgOld = jNet.get(obubbleSelectBE.IdChild);

            HtmlChildChatMsgOld.attr("class", obubbleSelectBE.ChildClass);

            //Nueva seleccion
            obubbleSelectBE.Id = htmlChatMsg.attr("id");
            obubbleSelectBE.Class = htmlChatMsg.attr("class");
            //Hijo
            obubbleSelectBE.IdChild = htmlBubble.attr("id");
            obubbleSelectBE.ChildClass = htmlBubble.attr("class");
            //Establecer el estilo de seleccion
            htmlBubble.attr("class", NetSuite.LiveChat.bubble.Style.MsgTextSelect);
        }
        try {
            //Evento debe de estar implementada externamente en la libreria que se carga dinamicamente propio del caso de implementacion
            NetSuite.LiveChat.bubble.OnClick(htmlBubble);
        }
        catch (ex) {
            
        }
    }

    //NetSuite.LiveChat.WindPopupInterface = jNet.get(document.getElementsByName('EasyPopupLiveChat')[0]);
    NetSuite.LiveChat.PaqueteBE = function (_IdContactoFrom, _IdCOntactoTo, _IdMiembro, _Foto, _IdMsg, _CodAux, _ApellidosyNombres) {
        this.IdContactoFrom = _IdContactoFrom;
        this.IdContactoTo = _IdCOntactoTo;
        this.IdMiembro = _IdMiembro;
        this.Foto = _Foto;
        this.ApellidosyNombres = _ApellidosyNombres;
        this.IdMsg = _IdMsg;
        this.CodAux = _CodAux;
    }
    NetSuite.LiveChat.ContactBE = function (_IdContacto, _Foto, _Nombre, _Tipo, _IdMiembro, _Email, _CodPersonal, _IdEstado, _ColorEstado) {
        this.IdContacto = _IdContacto;
        this.Foto = _Foto;
        this.Nombre = _Nombre;
        this.Tipo = _Tipo;
        this.IdMiembro = _IdMiembro;
        this.Email = _Email;
        this.CodPersonal = _CodPersonal;
        this.IdEstado = _IdEstado;
        this.ColorEstado = _ColorEstado

    }

    NetSuite.LiveChat.MensajeBE = function (_ContactoFrom, _ContactoTo, _IdMsg, _MessageHTML, _ContenidoBE, _TIPOMSG, _IDTBLINFO,_IDINFO) {
        this.ContactoFrom = _ContactoFrom;
        this.ContactoTo = _ContactoTo;
        this.IdMsg = _IdMsg;
        this.AllContenidoBE = _ContenidoBE;
        this.TipoMsg = _TIPOMSG;
        this.IdTablaInfo = _IDTBLINFO;
        this.IdInfo = _IDINFO;
    }
    NetSuite.LiveChat.MensajeContenidoBE = function (_IdMsg, _IdContenido, _Texto, _AllLikes) {
        this.IdMsg = _IdMsg;
        this.IdContenido = _IdContenido;
        this.Texto = _Texto;
        this.AllLikes = _AllLikes;
    }
    NetSuite.LiveChat.MensajeContenidoLikesBE = function (_IdContenido, _NroLike, _Icono) {
        this.IdContenido = _IdContenido;
        this.NroLikes = _NroLike;
        this.Icono = _Icono;
    }



    NetSuite.LiveChat.ITemplateMessaje = function (oContactoBE, Texto) {
        var strBE = "";
        return '<div class="chat-msg-text" Data="' + strBE.Serialized(oContactoBE) + '" id="' + oContactoBE.IdMsg + '" > ' + Texto + '</div > ';
    }

    /**
     * 
     * template de mensajes
     * 
     */
    NetSuite.LiveChat.ItemplateChatContact = function (_MensajeBE) {
        var oContactoBE = _MensajeBE.ContactoFrom;
        var HtmlMsgContenido = "";
        _MensajeBE.AllContenidoBE.forEach(function (oContenidoBE, i) {
            HtmlMsgContenido += EasyNetLiveChat.ItemplateChatContenido(oContenidoBE);
        });
        var ITContact = '<div class="chat-msg" id="' + "bubble_" + _MensajeBE.IdMsg + '"   >'
            + '   <div class="chat-msg-profile">'
            + '      <img class="chat-msg-img" src="' + oContactoBE.Foto + '" alt="" />'
            + '      <div class="chat-msg-date">Mensaje visto 1.22pm</div>'
            + '   </div>'
            + '   <div class="chat-msg-content"  href="#' + _MensajeBE.IdMsg + '" id="Content_' + _MensajeBE.IdMsg + '"  >'
            + HtmlMsgContenido
            + '   </div>'
            + '</div> ';
        return ITContact;
    }

    NetSuite.LiveChat.ItemplateChatOwner = function (_MensajeBE) {
        var oContactoBE = _MensajeBE.ContactoFrom;
        var HtmlMsgContenido = "";
        _MensajeBE.AllContenidoBE.forEach(function (oContenidoBE, i) {
            HtmlMsgContenido += EasyNetLiveChat.ItemplateChatContenido(oContenidoBE);
        });


        var ITContact = ' <div class="chat-msg owner" id="' + "bubble_" + _MensajeBE.IdMsg + '"   >'
            + '     <div class="chat-msg-profile">'
            + '          <img class="chat-msg-img" src="' + oContactoBE.Foto + '" alt="" />'
            + '          <div class="chat-msg-date">Mensaje enviado 2.50pm</div>'
            + '     </div>'
            + '     <div class="chat-msg-content"   href="#' + _MensajeBE.IdMsg + '"   id="Content_' + _MensajeBE.IdMsg + '" >'
            + HtmlMsgContenido
            + '     </div>'
            + '</div>';
        return ITContact;
    }

    NetSuite.LiveChat.SendMsgDelegate = null;
    NetSuite.LiveChat.EnviaMensaje = function (oMensajeBE) {
        try {
            var strEntity = "";
            EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.LiveChat.ItemplateChatOwner(oMensajeBE);
            var oPaqueteBE = new NetSuite.LiveChat.PaqueteBE();
            oPaqueteBE.IdContactoFrom = oMensajeBE.ContactoFrom.IdContacto;
            oPaqueteBE.IdMiembro = oMensajeBE.ContactoFrom.IdMiembro;
            oPaqueteBE.IdContactoTo = oMensajeBE.ContactoTo.IdContacto;
            oPaqueteBE.IdMsg = oMensajeBE.IdMsg;
            oPaqueteBE.Foto = oMensajeBE.ContactoFrom.Foto;
            oPaqueteBE.ApellidosyNombres = oMensajeBE.ContactoFrom.Nombre;
            NetSuite.LiveChat.send("PaqueteBE|" + strEntity.toString().Serialized(oPaqueteBE));
            //verificar si el contacto obedece a un servicio
            if ((NetSuite.LiveChat.SendMsgDelegate != undefined) || (NetSuite.LiveChat.SendMsgDelegate !=null)){
                NetSuite.LiveChat.SendMsgDelegate(oMensajeBE.IdMsg);
            }

        }
        catch (ex) {
            alert(ex);
        }
    }

  
    NetSuite.LiveChat.MiembrosGrupo = {};
    NetSuite.LiveChat.MiembrosGrupo.Estado = function (CodigoPersonal, ColorEsatdo) {
        var MiembroGrupoBE = [].slice.call(EasyNetLiveChat.Panel.Contactos.Right().children);
        MiembroGrupoBE.forEach(function (CtrlContacto) {
            var oImgContacto = CtrlContacto.children[0];
            var oContactoBE = jNet.get(oImgContacto).attr("Data").toString().SerializedToObject();
            if (oContactoBE.CodPersonal == CodigoPersonal) {
                jNet.get(CtrlContacto.children[1]).css('background-color', ColorEsatdo);
            }
        });
    }

    /*--------Verifica si el mensaje es para el usuario loguedo---------------------------------------------------- */
    NetSuite.LiveChat.MiembrosGrupo.DisplayAlertMsgRecibe = function (IdContactoOIdGrupo) {
        var EsParaMi = false;
        NetSuite.LiveChat.MiembrosGrupo.Verificar(IdContactoOIdGrupo).Rows.forEach(function (oDataRow, r) {
            if (oDataRow["IDPERSONAL"].toString() == UsuarioBE.CodPersonal) {
                EsParaMi = true;
            }
        })
        return EsParaMi;
    }

    NetSuite.LiveChat.MiembrosGrupo.Verificar = function (IdContactoOIdGrupo) {
        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/ChatBot/IChatBotManager.asmx";
        oEasyDataInterConect.Metodo = "ListarMiembros";

        var oParamCollections = new SIMA.ParamCollections();
        var oParam = new SIMA.Param("IdContacto", IdContactoOIdGrupo, TipodeDato.Int);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
        oParamCollections.Add(oParam);

        oEasyDataInterConect.ParamsCollection = oParamCollections;

        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
        return oEasyDataResult.getDataTable();
    }
    /*------------------------------------------------------------ */
   
    NetSuite.LiveChat.ItemplateMsgRecibidoNoWind = function (_PaqueteBE) {
        return '<div class="card-container">'
            + ' <div class="card u-clearfix">'
            + '     <div class="card-body">'
            + '          <span class="card-number card-circle subtle">01dddd</span>'
            + '          <span class="card-author subtle">John Smith</span>'
            + '          <h2 class="card-title">New Brunch Recipe</h2>'
            + '          <span class="card-description subtle">These last few weeks I have been working hard on a new brunch recipe for you all.</span>'
            + '          <div class="card-read">Read</div>'
            + '              <span class="card-tag card-circle subtle">C</span>'
            + '          </div>'
            + '        <img src="https://s15.postimg.cc/temvv7u4r/recipe.jpg" alt="" class="card-media" />'
            + '    </div>'
            + '    <div class="card-shadow"></div>'
            + '</div> ';
    }

   /* NetSuite.LiveChat.ImgLatencia = function () {
        return jNet.create('img').attr("width", "30px")
            .attr("height", "30px")
            .attr("src", Page.Request.ApplicationPath + "/Recursos/img/Infinity.gif");
    }*/
   
    NetSuite.LiveChat.Data = {};
    NetSuite.LiveChat.Data.UpDEstadoContacto = function (CodPersonal, IdEstado) {
        var oEasyDataInterConect = new EasyDataInterConect();
        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
        oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/ChatBot/IChatBotManager.asmx";
        oEasyDataInterConect.Metodo = "ActualizaEstadoContacto";

        var oParamCollections = new SIMA.ParamCollections();
        var oParam = new SIMA.Param("CodPersonal", CodPersonal);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("IdEstado", IdEstado, TipodeDato.Int);
        oParamCollections.Add(oParam);
        oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
        oParamCollections.Add(oParam);

        oEasyDataInterConect.ParamsCollection = oParamCollections;

        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
        oEasyDataResult.sendData();
    }

    NetSuite.LiveChat.TemplateChat = function () {
        var MsgTemplate = '<div   style="width:100%;height:600px;">'
            + ' </div>';
        var urlPag = Page.Request.ApplicationPath + "/General/ChatBox/EasyNetLiveChat.aspx";
        var oColletionParams = new SIMA.ParamCollections();
        var oParam = new SIMA.Param(Default.KEYIDGENERAL, 0);
        oColletionParams.Add(oParam);

        var oLoadConfig = {
            CtrlName: 'ContentChat',
            UrlPage: urlPag,
            ColletionParams: oColletionParams,
        };
        SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);

        urlPag = Page.Request.ApplicationPath + "/General/ChatBox/EasyNetLiveChatFind.aspx";
        var oLoadConfig = {
            CtrlName: 'Buscar',
            UrlPage: urlPag,
            ColletionParams: oColletionParams,
        };
        SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);


        return MsgTemplate;
    }
    NetSuite.LiveChat.Show = function (oContent) {

        var ConfigMsgb = {
            Titulo: 'Chat'
            , Width: '500px'
            , Descripcion: NetSuite.LiveChat.TemplateChat()
            , Icono: 'fa fa-paper-plane'
            , EventHandle: function (btn) {
                if (btn == 'OK') {
                }
            }
        };
        var oMsg = new SIMA.MessageBox(ConfigMsgb);
        oMsg.confirm();
    }

    NetSuite.LiveChat.Enum = {};
    NetSuite.LiveChat.Enum.Estado = {
        Conectado: "1"
        , NoConectado: "2"
        , SendMsg: "3"
    };

    //

}



var ConSleep = 1000;
NetSuite.Manager.Infinity.CircleConeccion = function (EnabledSocket) {
    if ((EnabledSocket != undefined) && (EnabledSocket == true)) {
        Manager.Task.Excecute(function () {
                NetSuite.Manager.Infinity.WorkingFrame();
               if (NetSuite.Manager.Infinity.User.Contectado == false) {
                    if (SIMA.Utilitario.Helper.Configuracion.Leer("ConfigBase", "NetSuteSocketEnable") == "1") {
                        NetSuite.Manager.Infinity.CircleConeccion(EnabledSocket);
                    }
                }
                NetSuite.Manager.Infinity.CountPage++;
        }, ConSleep, true);
    }

}
NetSuite.Manager.Infinity.CircleConeccion(true);

