var objInfoBE = ScriptManager.Find("ITILService");

//objInfoBE.Params.GetParamValue("LoadData")

//Se ejecutara al momento de enviar el mensaje
NetSuite.LiveChat.SendMsgDelegate = function (IdMsg) {}


function CargarRequerimientosConMSG(IdContacto) {
    var oEasyDataInterConect = new EasyDataInterConect();
    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
    oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/AdministrarHD.asmx";
    oEasyDataInterConect.Metodo = "RequerimientosInMSG_lst";

    var oParamCollections = new SIMA.ParamCollections();
    var oParam = new SIMA.Param("IdContacto", IdContacto, TipodeDato.Int);
    oParamCollections.Add(oParam);


    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
    oParamCollections.Add(oParam);

    oEasyDataInterConect.ParamsCollection = oParamCollections;

    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
    return oEasyDataResult.getDataTable();
}


function ObtenerDatosdeGrupo(IdGrupo) {
    var oEasyDataInterConect = new EasyDataInterConect();
    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
    oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
    oEasyDataInterConect.Metodo = "DetalleContactoXID";

    var oParamCollections = new SIMA.ParamCollections();
    var oParam = new SIMA.Param("Id", IdGrupo, TipodeDato.Int);
    oParamCollections.Add(oParam);
    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
    oParamCollections.Add(oParam);

    oEasyDataInterConect.ParamsCollection = oParamCollections;

    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
    return oEasyDataResult.getEntity();
}
function GrabaRquqerimientodeIncidencia() {
    //DetalleIncidnecia

    var oParamCollections = new SIMA.ParamCollections();
    var oParam = new SIMA.Param("Descripcion", EasyTxtDescripcion.GetValue());
    oParamCollections.Add(oParam);
    oParam = new SIMA.Param("IdServicioArea", DetalleIncidnecia.Params[DetalleIncidnecia.KEYIDSERVICIOAREA]);
    oParamCollections.Add(oParam);
    oParam = new SIMA.Param("CodigoPersonal", UsuarioBE.CodPersonal);
    oParamCollections.Add(oParam);
    oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
    oParamCollections.Add(oParam);
    oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
    oParamCollections.Add(oParam);


    var oEasyDataInterConect = new EasyDataInterConect();
    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
    oEasyDataInterConect.UrlWebService = "/HelpDesk/Procesar.asmx"
    oEasyDataInterConect.Metodo = "GuardarRequerimiento";
    oEasyDataInterConect.ParamsCollection = oParamCollections;

    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
    return oEasyDataResult.sendData().toString();
}


NetSuite.Manager.Broker.Persiana.Popup.Aceptar = function () {

    

    var IdRqr = GrabaRquqerimientodeIncidencia();

    //Carga informacion del grup que brinda servcio de atencion de incidnecias
    var CBContactoGrupoBE = ObtenerDatosdeGrupo(DetalleIncidnecia.Params[DetalleIncidnecia.KEYIDCONTACTO]);


    oContactoDestinoBE = new NetSuite.LiveChat.ContactBE();
    oContactoDestinoBE.IdContacto = CBContactoGrupoBE.IdContacto;
    oContactoDestinoBE.Foto = CBContactoGrupoBE.FotoGrupo;
    oContactoDestinoBE.Nombre = CBContactoGrupoBE.NombreGrupo; 
    oContactoDestinoBE.Tipo = 1//Incidencia

    //Display informacion de chat con el contacto destino
    EasyAcFindContacto.SetValue(oContactoDestinoBE.IdContacto, oContactoDestinoBE.Nombre);

    EasyNetLiveChat.DisplaySelected.ContactoInfo(oContactoDestinoBE);

    var oMensajeBE = new NetSuite.LiveChat.MensajeBE();

    var oContactFromBE = new NetSuite.LiveChat.ContactBE();
    oContactFromBE.IdContacto = UsuarioBE.IdContacto;
    oContactFromBE.IdMiembro = UsuarioBE.IdContacto;
    oContactFromBE.Foto = EasyNetLiveChat.FotoContacto(UsuarioBE.NroDocumento);
    oContactFromBE.Nombre = UsuarioBE.ApellidosyNombres;
    

    //oContactFromBE.IdMsg = pos;//Este valor debe de ser obtenido desde la BD al crear el regisro de mesajes
    //Eatblece parametros de envio
    oMensajeBE.ContactoFrom = oContactFromBE;

    oMensajeBE.ContactoTo = oContactoDestinoBE;

    var MensajeContenidoBE = new NetSuite.LiveChat.MensajeContenidoBE();
    MensajeContenidoBE.IdMsg = oMensajeBE.IdMsg;
    MensajeContenidoBE.IdContenido = 0;
    MensajeContenidoBE.Texto = "Por Requerimiento";//NetSuite.LiveChat.LinkService.TemplateBubble(null);;
    MensajeContenidoBE.AllLikes = null;
    var CollectionMsgContenido = new Array();
    CollectionMsgContenido.Add(MensajeContenidoBE);
    oMensajeBE.AllContenidoBE = CollectionMsgContenido;
    //Almacena en la BD
    oMensajeBE.IdTablaInfo = "31";//Tabla de requerimientos
    oMensajeBE.IdInfo = IdRqr;//Vincuo con el requerimiento generado

    var jSonBE = EasyNetLiveChat.Data.GuardarMensaje(oMensajeBE);
    oMensajeBE.IdMsg = jSonBE.OutIdMsg;
    MensajeContenidoBE.IdMsg = oMensajeBE.IdMsg;
    MensajeContenidoBE.IdContenido = jSonBE.OutIdContenido;


    NetSuite.LiveChat.EnviaMensaje(oMensajeBE);


    //Carga los eventros del contacto
    NetSuite.Manager.Broker.LoadEvent(DetalleIncidnecia.Params[DetalleIncidnecia.KEYIDCONTACTO]);



    return true;
}

//Invocado Internamente para ser acoplado al mensaje relacionado con dicha informaciom
NetSuite.Manager.Broker.onItemMsgBubble = function (oDataInfo) {
    //Aqui buscar en el datatable previamente cargada de requerimientos relacionado con los mensajes
    var strHtml = "";
    
    if (DataTableRqr != null) {
        DataTableRqr.Select("ID_MSG", "=", oDataInfo.ID_MSG).forEach(function (oDataRow, i) {

            var ArrayPath = oDataRow.PATHSERVICE.toString().split('|');
            var htmlItem = '';
            ArrayPath.reverse().forEach(function (ItemPathText, p) {
                htmlItem += '        <div class="btn btn-default">' + ItemPathText + '</div>';
            });

            var iTemplatePath = '<div class="container ScrollPath" style="width: px;">'
                + '<div class="row">'
                + '    <div id="EasyPathService_BarPath" class="btn-group btn-breadcrumb">'
                + '        <div class="btn btn-primary">'
                + '            <div class="fa fa-home"></div>'
                + '        </div>'
                + htmlItem
                + '    </div>'
                + '</div>'
                + '</div>';

            var iTemplateProgress = '<div class="progress">'
                + '  <div class="progress-bar"  style = "width: ' + oDataRow["AVANCE"] + '%; ">'
                + '      <span class="progress-bar-text">' + oDataRow["AVANCE"] + '%</span>'
                + '  </div>'
                + '</div>';


            strHtml = '<table>'
                + '  <tr>'
                + '     <td>'
                + iTemplatePath
                + '     </td>'
                + '   </tr>'
                + '   <tr>'
                + '     <td>'
                + oDataRow["TEXT"]
                + '     </td>'
                + '  </tr>'
                + '  <tr>'
                + '     <td>'
                + iTemplateProgress
                + '     </td>'
                + '  </tr>'
                + '</table>';

        });
    }
    else {
        strHtml = 'Sin Exito';
    }
    return strHtml;
}

//Evento implementado y llamado al momento de dat click a la burbuja de mensajes
NetSuite.LiveChat.bubble.OnClick = function (oMgsItem) {
    alert(oMgsItem);
}




var DataTableRqr = null;
//Metodo sobreescrito que particulariza la informacion segun la linreria relacionada al grupoi
NetSuite.Manager.Broker.LoadEvent = function (idGrupoContacto) {
        try {
            if (idGrupoContacto != undefined) {
                DataTableRqr = CargarRequerimientosConMSG(idGrupoContacto);
            }
            else {
                DataTableRqr =  (EasyAcFindContacto.GetValue());
            }
        }
        catch (ex) {
            
            DataTableRqr = CargarRequerimientosConMSG(EasyAcFindContacto.GetValue());
        }
}
//alert('Registrado');