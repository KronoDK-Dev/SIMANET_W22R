<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EasyNetLiveChat.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.ChatBot.EasyNetLiveChat" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Filtro" tagprefix="cc2" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<link href="../../Recursos/css/EasyNetLiveChat.css" rel="stylesheet" />

<style>
   
 html {
    scroll-behavior: smooth;
    }

 .status-ContactGrp {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: red;
  border: 2px solid white;
  bottom: 0;
  /*right: 0;*/
  left:10;
  position: absolute;
}



/*BadGet - Insignia usado en los link*/
.badge1{
   /*position: relative;
    margin-left: -5.1%;
    margin-top: 8.5%;
    right:-15px;*/
   right:80px;
   bottom:-100px;
}

    .badge1 {
        display: inline-block;
        min-width: 10px;
        padding: 3px 7px;
        font-size: 12px;
        /* font-weight: 700;*/
        line-height: 1;
        color: red;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        background-color: transparent;
        border-radius: 15px;
        
    }

    .modal-body {
        background-image: url("../../Recursos/img/HeaderChat.png");
        background-repeat: no-repeat;
    }

    .chat-area-header {
        background-color:transparent;
    }
  
    .bot-message {
      background-color: #e0f7fa;
      align-self: flex-start;
    }

</style>

    <style>
        /*Usado en la burbuja de bienvenida*/
        .BubbleAmarillo{
  position: relative;
  padding: 20px 20px 20px 65px;
  background: orange;
  border-radius: 10px;
  margin-bottom: 35px;
  color: white;
}

/* Speach bouble Quote */
.BubbleAmarillo:before{
  content: "\201C"; /*Unicode for Left Double Quote*/
  
  /*Font*/
  font-family: Georgia, serif;
  font-size: 60px;
  font-weight: bold;
  
  /*Positioning*/
  position: absolute;
  left: 20px;
  top: 5px;
}

/* Speech bouble triangle */
.BubbleAmarillo:after{
  content: ' ';
  border: 10px solid;
  border-color: orange transparent transparent orange;
  position: absolute;
  bottom: -20px;
  left: 30px;
}

.wrapperAmarillo{
  margin-bottom: 50px;
}
.wrapperAmarillo img{
  float: left;
  border-radius: 20px;
  margin-right: 20px;
}
   
/*Utilizado la maquina de escribir---------------------------------------------------*/

.typewriter {
font-family: 'Courier New', Courier, monospace;
  font-size: 24px;
  color: #333;
  border-right: 2px solid #333;
  white-space: nowrap;
  /*overflow: hidden;*/
  width: 20ch; /* Ajusta el ancho del texto */
  animation: blink 0.7s step-end infinite;
}

@keyframes blink {
  100% {
    border-color: transparent;
  }
}
/*maquina de escribir--------------------------------*/

    </style>

 






<script>
    /*
        --https://jsfiddle.net/XNnHC/1808/
    */
       

    function MsgBE(_IdContactOrg, _IdContactDes, _IdMsg, _Texto) {
        this.IdContactOrg = _IdContactOrg;
        this.IdContactDes = _IdContactDes;
        this.IdMsg = _IdMsg;
        this.Texto = _Texto;
    }


    
    const toggleButton = document.querySelector('.dark-light');
    const colors = document.querySelectorAll('.color');

    colors.forEach(color => {
      color.addEventListener('click', (e) => {
        colors.forEach(c => c.classList.remove('selected'));
        const theme = color.getAttribute('data-color');
        document.body.setAttribute('data-theme', theme);
        color.classList.add('selected');
      });
    });

    toggleButton.addEventListener('click', () => {
      document.body.classList.toggle('dark-mode');
    });

 const ConfigButton = document.querySelector('.settings');

    ConfigButton.addEventListener('click', () => {
        //Evaluar si se encuentra en la lista de usuarios del servicio
        var PerteneceAlGrupo = false;
        EasyNetLiveChat.Data.LstMiembroGrupoSeleccionado(EasyAcFindContacto.GetValue()).Rows.forEach(function (oDR, i) {
            if (oDR.IDPERSONAL == UsuarioBE.CodPersonal) {
                PerteneceAlGrupo = true;
            }
        });


        if (PerteneceAlGrupo == false) {
            if (EasyNetLiveChat.ServicioExistFileJs == false) {
                var msgConfig = { Titulo: "Conficuración de Servicio", Descripcion: "No define con configuracion de servicio" };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
            else {
                NetSuite.Manager.Broker.Persiana.Show(oContactoDestinoBE.IdContacto);//El contacto o grupo seleccionado
            }

        }
        else {
            var msgConfig = { Titulo: "SERVICIO", Descripcion: "No esta permitido usar esta funcionalidad, Usuario pertenece al grup de servicios" };
            var oMsg = new SIMA.MessageBox(msgConfig);
            oMsg.Alert();
        }

    });


</script>


<style>
    .Brokeroverlay{    
        height: 90%;
        width: 0;
        position: fixed; 
        z-index: 1; 
        left: 100%;
        top: 70px;
        background-color: white; 
        background-image: url("../../Recursos/img/HeaderChat.png");
        background-repeat: no-repeat;
        overflow-x: hidden; 
        transition: 1s; 
        color:blue;
    }
  
      .closeBack {
        margin: -0.375rem -0.375rem -0.375rem auto;
        height: 5rem;
        width: 2rem;
        display: inline-flex;
        border-radius: 0.5rem;
        border-color:#606c88;
        background-color:darkgray;
        padding: 0.375rem;
        color: rgba(255, 255, 255, 1);
        border: none;
        position:absolute;
        top:50%;
        right:10px;
        cursor:pointer;
      }

  .closeBack svg {
    height: 4.25rem;
    width: 1.25rem;
  }

  .closeBack:hover {
   background-image: url("../../Recursos/img/ToolBar.jpg");
  }


</style>

</head>
<body style="width:80%;background-color: coral;">
    <form id="form1" runat="server" >         
        <div style="width:100%;height:600px;">
                             <div class="header" id="ChatHeader">
                                 <div  class="search-bar1"  style="width:100%">
                                        <cc3:EasyAutocompletar ID="EasyAcFindContacto" Width="100%" runat="server" NroCarIni="1"  DisplayText="NOMBRECONTACTO" ValueField="ID_CONTACT" fnOnSelected="EasyNetLiveChat.OnItemSelected" fncTempaleCustom="EasyNetLiveChat.ItemplateContactos">
                                            <EasyStyle Ancho="Dos"></EasyStyle>
                                            <DataInterconect MetodoConexion="WebServiceExterno">
                                                <UrlWebService>http:</UrlWebService>
                                                <Metodo>ListarContatos</Metodo>
                                                <UrlWebServicieParams>
                                                    <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                                </UrlWebServicieParams>
                                            </DataInterconect>
                                        </cc3:EasyAutocompletar>   
                                 </div>
                                 <div class="user-settings">
                                     <div class="dark-light">
                                         <svg viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                             <path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z" />
                                         </svg>
                                     </div>
                                     <div class="settings">
                                         <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                             <circle cx="12" cy="12" r="3" />
                                             <path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-2 2 2 2 0 01-2-2v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83 0 2 2 0 010-2.83l.06-.06a1.65 1.65 0 00.33-1.82 1.65 1.65 0 00-1.51-1H3a2 2 0 01-2-2 2 2 0 012-2h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 010-2.83 2 2 0 012.83 0l.06.06a1.65 1.65 0 001.82.33H9a1.65 1.65 0 001-1.51V3a2 2 0 012-2 2 2 0 012 2v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 0 2 2 0 010 2.83l-.06.06a1.65 1.65 0 00-.33 1.82V9a1.65 1.65 0 001.51 1H21a2 2 0 012 2 2 2 0 01-2 2h-.09a1.65 1.65 0 00-1.51 1z" />
                                         </svg>
                                     </div>
                                 </div>
                             </div>
                         <div id= "HeadContact" class="chat-area-header" style="margin-bottom: 25px;">
                                <div id="LblContact" class="chat-area-title" ></div>
                                <div id="LstContact" class="chat-area-group"></div>
                         </div>
            

                         <div class="chat-area" style="height:75%;overflow-x: hidden;">
                             <div id="ContentChat" class="chat-area-main" style="width:100%;height:100%;">

                             </div>
                         </div>

                         <div id="ChatFooter" class="chat-area-footer">
                              
                         </div> 
                            <!--Init IBroker Service*******************************************************************************************-->
                            <div  id="BrokerWind" class="Brokeroverlay ">
                                <button type="button" class="closeBack"  onclick="NetSuite.Manager.Broker.Persiana.Close()">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" enable-background="new 0 0 48 48"><circle fill="#fff" cx="24" cy="24" r="24"/><path fill="#444" d="M20.293 15.707l8.293 8.293-8.293 8.293c-.391.391-.391 1.024 0 1.414.391.391 1.024.391 1.414 0l9-9c.186-.186.293-.444.293-.707 0-.263-.107-.521-.293-.707l-9-9c-.391-.391-1.024-.391-1.414 0-.39.391-.391 1.024 0 1.414z"/></svg>
                                </button>
                                <!-- Overlay content -->
                                <div id="BrokerContent" class="overlay-content"></div>
                            </div> 
                            <!--End IBroker Service*********************************************************************************************-->


                        <div>  
                    </div>
                </div>


        <!--**********************************************************************************************************-->
              <!--
                  ===== SHARE MODAL ===== 
                  https://freefrontend.com/css-modal-windows/
                  -->

                <main class="share__modal">
                    <div class="share__modal__header">
                        <span>Aplicaciones</span>
                        <button type="button" class="close_modal_btn">
                          <i class="bx bx-x bx-sm"></i>
                        </button>
                      </div>

                      <div id="appContent" class="share__modal_content">
                        <!-- ===== SHARING OPTIONS ===== -->
                        
                      </div>
                
                </main>
          <!--**********************************************************************************************************-->

        <script>
            /*=============== SHOW MODAL ===============*/
            var modal = document.querySelector(".share__modal");
            function closeModal() {
                modal.classList.remove("show-modal");
            }
            /*====== ESC BUTTON TO CLOSE MODAL ======*/
           document.addEventListener("keydown", (e) => {
                if (e.key === "Escape") {
                    closeModal();
                }
           });

            EasyNetLiveChat.ItemplateApp = function (oDataBE) {
                return '<li class="list__item">'
                    + '     <div class="icon_holder" data-icon="twitter">'
                    + '          <img src="' + oDataBE["CMEDIA"] + '" class="social__logo" alt="twitter-logo" />'
                    + '     </div>'
                    + '     <span>' + oDataBE["RESPUESTA"] + '</span>'
                    + '</li>';
            }

            EasyNetLiveChat.ListarAplicaciones = function () {
                
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/ChatBot/IChatBotManager.asmx";
                oEasyDataInterConect.Metodo = "AplicacionesdeServicios_lst";

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("IdTipo", 4, TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
                oParamCollections.Add(oParam);

                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                return oEasyDataResult.getDataTable();
            }

            try {
                //Cargar las aplicaciones vinculadas a os servicios
                var ContentAPP = jNet.get('appContent');
                ContentAPP.clear();
                var strHTML = "";
                var ulApp = '<ul id="lsApp" class="list"> </ul>'.toString().HtmlToDOMobj();
                var ulApp = jNet.get(ulApp);
                var cmll = "\"";
                EasyNetLiveChat.ListarAplicaciones().Rows.forEach(function (DataRow, r) {
                    var lItm = jNet.get(EasyNetLiveChat.ItemplateApp(DataRow).toString().HtmlToDOMobj());
                    lItm.attr("Data", ''.Serialized(DataRow).Replace(cmll, "'"));
                    lItm.addEvent("click", function () {
                        var strBE = jNet.get(this).attr("Data");
                        var DataBE = strBE.tostring().SerializedToObject();
                        alert(DataBE.RESPUESTA);
                    });
                    ulApp.insert(lItm);
                });
                ContentAPP.insert(ulApp);

            }
            catch (ex) {
                alert(ex);
            }
        </script>

        <style>
            @import url("https://fonts.googleapis.com/css2?family=Inter:wght@200;300;400;600&display=swap");
            *,
            *::before,
            *::after {
              box-sizing: border-box;
            }
            * {
              margin: 0;
              padding: 0;
              box-sizing: border-box;
              font-family: "Inter", sans-serif;
            }

            :root {
              /*========== Colors ==========*/
              --Header-color: #0277BD;

              --first-color: #373d46;
              --modal-bg-color: #fff;
              --text-input-bg: #f8f9fa;
              --text-color: #95989d;
              --container-bg: #c7ad91;
              --btn-color: #ddc0a1;

              /* ===== SOCIAL ICONS BACKGROUND COLOR =====  */
              --twitter: #e8f6fe;
              --whatsapp: #e9fbf0;
              --facebook: #e8f1fe;
              --reddit: #ffece6;
              --discord: #f1f3fb;
              --messenger: #e6f3ff;
              --telegram: #e6f3fa;
              --wechat: #f2f7ea;

              /*========== Font and typography ==========*/

              --normal-font-size: 0.88rem;
              --large-font-size: 1.25rem;
              --share-link-span: 0.9869em;
              --share-input-font-size: 0.8em;

              /*========== z index ==========*/
              --z-modal: 1000;
            }

            @media screen and (min-width: 991px) {
              :root {
                --large-font-size: 1.5rem;
                --normal-font-size: 1rem;
                --share-link-span: 1.1em;
                --share-input-font-size: 1em;
              }
            }

           
            ul li {
              margin: 0;
              padding: 0;
              list-style-type: none;
            }
        
            .share__modal_btn{
              background-color: #857361;
              padding: 0.9em 1.5em;
              font-size: var(--share-link-span);
              text-transform: capitalize;
              border-radius: 0.7em;
              box-shadow: 0 10px 10px -2px rgba(0, 0, 0, 0.1);
              color: #eee;
              letter-spacing: 0.25px;
            }
            .share__modal_btn:hover{
              background-color: #6f6051;
            }
            .share__modal{
              background-color: var(--modal-bg-color);
              position: absolute;
              /*bottom: 50;*/
              width: 100%;
              height: 50%;
              display: grid;
              align-items: flex-end;
              overflow: auto;
              box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.2);
              border-radius: 1.3em 1em 0 0;
              z-index: var(--z-modal);
              opacity: 0;
              transition: 0.5s ease;
              visibility: hidden;
            }
            .share__modal_content{
             /* padding: 1.5em;*/
              display: flex;
              flex-direction: column;
              row-gap: 2.6em;
            }

            .share__modal__header{
              position:absolute;
              top:0;
              display: flex;
              align-items: start;
              justify-content: space-between;
            }
            .share__modal__header span {
              font-size: var(--large-font-size);
              font-weight: 400;
              color: var(--Header-color);
              text-transform: capitalize;
              opacity: 0.88;
              padding: 1em;
            }


            .close_modal_btn{
              color: black;

            }
            .list{
              display: grid;
              grid-template-columns: repeat(3,1fr);
              grid-gap: 1.125em;
            }
            .list__item{
              display: flex;
              flex-direction: column;
              row-gap: 0.5em;
              align-items: center;
              justify-content: center;
              text-transform: capitalize;
              color: var(--first-color);
              font-size: var(--normal-font-size);
              font-weight: 500;
              opacity: 0.9;
              cursor: pointer;
            }
            .icon_holder{
              width: 4.5em;
              height: 4.5em;
              border-radius: 50%;
              display: flex;
              align-items: center;
              justify-content: center;
            }
            .social__logo{
              width: 2em;
              height: 2em;
            }
            [data-icon="twitter"]{
              background-color: var(--twitter);
            }
            [data-icon="facebook"]{
              background-color: var(--facebook);
            }
            [data-icon="reddit"]{
              background-color: var(--reddit);
            }
            [data-icon="discord"]{
              background-color: var(--discord);
            }
            [data-icon="whatsapp"]{
              background-color: var(--whatsapp);
            }
            [data-icon="messenger"]{
              background-color: var(--messenger);
            }
            [data-icon="telegram"]{
              background-color: var(--telegram);
            }
            [data-icon="wechat"]{
              background-color: var(--wechat);
            }
          
            .copy_icon{
              position: absolute;
              right: 1.5em;
              top: 1em;
              color: var(--first-color);
              cursor: pointer;
            }
            .show-modal{
              opacity: 1;
              visibility: visible;
            }
            /*=============== BREAKPOINTS ===============*/
            @media screen and (min-width:768px) {         

              .share__modal{
                width: 28em;
                height: 30em;
                border-radius: 1.3em;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%,-50%);
                overflow: hidden;
              }
              .share__modal_content{
                  position:absolute;
                  top:50px;
                  padding: 2.5em;
              }
              .list{
                grid-template-columns: repeat(4,1fr);
                row-gap: 1.5em;
                column-gap: 1em;
              }
            }


        </style>
        <!--**********************************************************************************************************-->










































     
        <style>
             .Base-message {
            background-color:antiquewhite ;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .Base-message-text h2 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .Base-message-text p1 {
            font-size: 0.95rem;
            opacity: 0.9;
            max-width: 400px;
        }
        </style>

        <style>
            /*blckquote*/
            blockquote{
                      display:block;
                      background: #fff;
                      /*padding: 15px 20px 15px 45px;*/
                   
                      padding: 5px 10px 5px 30px;
                      margin: 0 0 10px;
                      position: relative;
  
                      /*Font*/
                      font-family: Georgia, serif;
                      font-size:40px;
                     /* line-height: 1.2;*/
                      color: #666;

                      /*Box Shadow - (Optional)*/
                      -moz-box-shadow: 2px 2px 15px #ccc;
                      -webkit-box-shadow: 2px 2px 15px #ccc;
                      box-shadow: 2px 2px 15px #ccc;

                      /*Borders - (Optional)*/
                      border-left-style: solid;
                      border-left-width: 10px;
                      border-right-style: solid;
                      border-right-width: 2px;    
                    }
            
                    blockquote:hover{
                         border-top: 1px dashed blue; 
                         border-bottom: 1px dashed blue; 
                         border-left-style: solid;
                         border-left-width: 10px;
                         border-right-style: solid;
                         border-right-width: 2px;
                         background-color:#7fb6d4;
                         cursor:pointer;
                    }

                    blockquote::before{
                      content: "\201C"; /*Unicode for Left Double Quote*/
  
                      /*Font*/
                      font-family: Georgia, serif;
                      font-size: 40px;
                      font-weight: bold;
                      color: #999;
  
                      /*Positioning*/
                      position: absolute;
                      left: 10px;
                      top:5px;
  
                    }

                    blockquote::after{
                      /*Reset to make sure*/
                      content: "";
                    }

                    blockquote h1 span {
                        font-size: 20px;
                    }
 

                    /*Blue Jeans Color Palette*/
                    blockquote.bluejeans{
                      border-left-color: #5e9de6;
                      border-right-color: #4b8ad6;
                    }

        </style>



    </form>
</body>

     <script>
         var btns = [
                      ['Left',true,'<svg xmlns = "http://www.w3.org/2000/svg" viewBox = "0 0 24 24" fill = "none" stroke = "currentColor" stroke-width="1.5" stroke - linecap="round" stroke - linejoin="round" class="feather feather-video"><path d = "M23 7l-7 5 7 5V7z" /><rect x="1" y="5" width="15" height="14" rx="2" ry="2"/></svg>']
                     , ['Left', true,'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-image"><rect x = "3" y = "3" width = "18" height = "18" rx = "2" ry = "2" /><circle cx="8.5" cy="8.5" r="1.5" /><path d="M21 15l-5-5L5 21"/></svg>']
                     , ['Left', true,'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus-circle">< circle cx = "12" cy = "12" r = "10" /><path d="M12 8v8M8 12h8"/></svg>']
                     , ['Left', true,'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-paperclip">< path d = "M21.44 11.05l-9.19 9.19a6 6 0 01-8.49-8.49l9.19-9.19a4 4 0 015.66 5.66l-9.2 9.19a2 2 0 01-2.83-2.83l8.49-8.48"/></svg>']
                     , ['Center', true,'<input type="text" placeholder="Escribe un mensaje aquí..." style="border-width:1px;  border-style: dotted;border-color: gray;" onkeydown="EasyNetLiveChat.InputMensaje(this);"/>']
                     , ['Rigth', true,'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-smile"><circle cx = "12" cy = "12" r = "10" /><path d="M8 14s1.5 2 4 2 4-2 4-2M9 9h.01M15 9h.01"/></svg>']
                     , ['Rigth', false,'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-thumbs-up"><path d = "M14 9V5a3 3 0 00-3-3l-4 9v11h11.28a2 2 0 002-1.7l1.38-9a2 2 0 00-2-2.3zM7 22H4a2 2 0 01-2-2v-7a2 2 0 012-2h3"/></svg>']
                   ];


         var oContactoDestinoBE = null;

         var oContactoSendDestinoSeleccionadoBE = null;
         var cmll = "\"";
         EasyNetLiveChat.PathUrlServiceChat = ConnectService.PathNetCore + "HelpDesk/ChatBot/IChatBotManager.asmx";

         EasyNetLiveChat.FotoContacto = function (NroDocumento) {
             return GlobalEntorno.PathFotosPersonal + NroDocumento + ".jpg";
         }
         EasyNetLiveChat.Data = {};
         EasyNetLiveChat.Render = {};
         EasyNetLiveChat.Panel = {};
         EasyNetLiveChat.Panel.Tools = {}
         EasyNetLiveChat.Panel.Tools.OnClick = function (e) {
             switch (e.attr('id')) {
                 case "btnIncidencia":
                     if (modal) {
                        modal.classList.add("show-modal");
                     }

                     break;
             }
         } 
         EasyNetLiveChat.Panel.Header = function () {return jNet.get('ChatHeader');}
         EasyNetLiveChat.Panel.Contactos = {};
         EasyNetLiveChat.Panel.Contactos.Right = function () {
             var obj = jNet.get('LstContact');
             return obj;
         }
        


         EasyNetLiveChat.Panel.Contactos.Left = function () { return jNet.get('LblContact'); }
         EasyNetLiveChat.Panel.Body = function () { return jNet.get('ContentChat'); }
         EasyNetLiveChat.Panel.Footer = function () { return jNet.get('ChatFooter'); }

         EasyNetLiveChat.Panel.Footer.Controls = [
                                                    ['Left', false, '<svg xmlns = "http://www.w3.org/2000/svg" viewBox = "0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-video"><path d = "M23 7l-7 5 7 5V7z"/><rect x="1" y="5" width="15" height="14" rx="2" ry="2"/></svg>']
                                                  , ['Left', false, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-image"><rect x = "3" y = "3" width = "18" height = "18" rx = "2" ry = "2" /><circle cx="8.5" cy="8.5" r="1.5"/><path d="M21 15l-5-5L5 21"/></svg>']
                                                  , ['Left', false, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus-circle"><circle cx="12" cy="12" r="10"/><path d="M12 8v8M8 12h8"/></svg>']
                                                  , ['Left', true, '<svg id="btnIncidencia" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-paperclip" onclick="EasyNetLiveChat.Panel.Tools.OnClick(jNet.get(this));"><path d = "M21.44 11.05l-9.19 9.19a6 6 0 01-8.49-8.49l9.19-9.19a4 4 0 015.66 5.66l-9.2 9.19a2 2 0 01-2.83-2.83l8.49-8.48"/></svg>']
                                                  , ['Center', true, '<input type="text" placeholder="Escribe un mensaje aquí..." style="border-width:1px;  border-style: dotted;border-color: gray;" onkeydown="EasyNetLiveChat.InputMensaje(this);"/>']
                                                  , ['Rigth', false, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-smile"><circle cx = "12" cy = "12" r = "10"/><path d="M8 14s1.5 2 4 2 4-2 4-2M9 9h.01M15 9h.01"/></svg>']
                                                  , ['Rigth', false, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-thumbs-up"><path d = "M14 9V5a3 3 0 00-3-3l-4 9v11h11.28a2 2 0 002-1.7l1.38-9a2 2 0 00-2-2.3zM7 22H4a2 2 0 01-2-2v-7a2 2 0 012-2h3"/></svg>']
                                                 ];
         EasyNetLiveChat.Panel.Footer.Controls.Load = function () {
             var _Footer = EasyNetLiveChat.Panel.Footer();
             EasyNetLiveChat.Panel.Footer.Controls.forEach((btn, i) => {
                 if (btn[1] == true) {
                     _Footer.innerHTML += btn[2];
                 }
             });
         }
         //Inicia la Carga de Controles
         EasyNetLiveChat.Panel.Footer.Controls.Load();
         //mensaje de bienvenida
         var HtmlParte = '<img width="30px" src="' + SIMA.Utilitario.Constantes.ImgDataURL.LogoEscudoSIMA + '" />';
         EasyNetLiveChat.Panel.Body().innerHTML = NetSuite.Manager.Bienvenida(HtmlParte);


         /*
            incorporado el 05-02-2025 desde la lib NetSuiteSocket
            INI
         */
         EasyNetLiveChat.ItemplateChatContenido = function (oContenidoBE) {
             var cmll = "\"";
             var strBE = "";
             var htmlLike = EasyNetLiveChat.ItemplateChatContenidoLikes(oContenidoBE.AllLikes);
             strBE = strBE.Serialized(oContenidoBE).Replace(cmll, "'");

             return '         <div class="chat-msg-text"  Data="' + strBE + '"  id="' + oContenidoBE.IdContenido + '" onclick="NetSuite.LiveChat.bubble.Click(this);"   >' + oContenidoBE.Texto + ((htmlLike == undefined) ? "" : htmlLike) + '</div>';
         }
         EasyNetLiveChat.ItemplateChatContenidoLikes = function (AllMensajeContenidoLikes) {
             var pos = 100;
             var strHTMLLike = "";
             if (AllMensajeContenidoLikes == null) { return ""; }
             AllMensajeContenidoLikes.forEach(function (oMensajeContenidoLikesBE, i) {
                 var _Likes = "+" + oMensajeContenidoLikesBE.NroLikes
                 strHTMLLike += '<span class="badge1 rounded-pill text-danger"   style=" right: ' + pos + 'px">' + oMensajeContenidoLikesBE.NroLikes + '<img style="width:20px" src = "' + oMensajeContenidoLikesBE.Icono + '" /> </span>';
                 pos = pos + 30;
             });
             return strHTMLLike;
         }
         /*FIN */


         EasyNetLiveChat.ItemplateContactos = function (ul, item) {
             var Foto = ((item.ISGRUPO == 1) ? item.FOTO_GRUPO : EasyNetLiveChat.FotoContacto(item.NRODOCUMENTO)); 
             var IcoEmail = ((SIMA.Utilitario.Helper.Data.ValidarEmail(item.EMAIL) == true) ? SIMA.Utilitario.Constantes.ImgDataURL.CardEMail : SIMA.Utilitario.Constantes.ImgDataURL.CardSinEmail);
             var ItemUser = '<table style="width:100%">'
                             + ' <tr>'
                             + '     <td rowspan="3" align="center" style="width:15%"><img class=" rounded-circle" width = "45px"  height="45px" src = "' + Foto + '"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                             + '     <td class="Etiqueta" style="width:85%">' + item.NOMBRECONTACTO + '</td>'
                             + '     <td rowspan="3" align="center" style="width:10%"><img class=" rounded-circle" width = "25px" src = "' + IcoEmail + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                             + ' </tr>'
                             + ' <tr>'
                             + '    <td>' + item.SITUACION + '</td>'
                             + ' </tr>'
                             + ' <tr>'
                             + '     <td>' + item.EMAIL + '</td>'
                             + '</tr>'
                             + '</table>';

             iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                 + ItemUser
                 + '</a>';

             var oCustomTemplateBE = new EasyAcFindContacto.CustomTemplateBE(ul, item, iTemplate);

             return EasyAcFindContacto.SetCustomTemplate(oCustomTemplateBE);
         }

         EasyNetLiveChat.ITemplateLstUsuarioContacto = function (Modalidad, _ContactoDestinoBE) {
             var cmll = "\"";
             var strData = "";
             strData = strData.Serialized(_ContactoDestinoBE).Replace(cmll,"'");
             var iTemplate = ' <div style="border-color: transparent;">' + '<img class="chat-area-profile" style="width:35px;height:35px;" src="' + _ContactoDestinoBE.Foto + '" alt="' + _ContactoDestinoBE.Nombre + '" Data="' + strData + '" Modalidad= "' + Modalidad + '"onclick="EasyNetLiveChat.Panel.Contactos.onClick(this);" />' + '<div  class="status-ContactGrp"></div></div>'; 
             return iTemplate;
         }
         EasyNetLiveChat.ITemplateInfoContacto = function (_ContactoDestinoBE) {
             var cmll = "\"";
             var strData = "";
             strData = strData.Serialized(_ContactoDestinoBE).Replace(cmll, "'");
             var iTemplate = '';
             var Modalidad = ((_ContactoDestinoBE.Tipo == 1) ? EasyNetLiveChat.Enum.Modalidad.GrupoDestino : "Usuario");
             iTemplate = '<div style="border-color: transparent;">' + '<img class="chat-area-profile" style="width:35px;height:35px;" src="' + _ContactoDestinoBE.Foto + '" alt="' + _ContactoDestinoBE.Nombre + '" Data="' + strData + '" Modalidad= "'+ Modalidad +'" onclick="EasyNetLiveChat.Panel.Contactos.onClick(this);" />' + '<div  class="status-ContactGrp"></div></div>';
             return iTemplate;
         }


         EasyNetLiveChat.ITemplateLstUsuarioContactoCount = function (NroAdd) {
             var iTemplate = '<span>+' + NroAdd + '</span>';
             return iTemplate;
         }

         EasyNetLiveChat.Modalidad = null;
         EasyNetLiveChat.Enum = {};
         EasyNetLiveChat.Enum.Modalidad = {
             ContactDestino: "CD",
             GrupoDestino:"GD",
             UsuSend: "US",
             Grupo: "Grp",
         }
         //Evento del contacto que envia los mensajes
         EasyNetLiveChat.Panel.Contactos.onClick = function (e) {
             var cmll = "\"";
             var ImgUsuario = jNet.get(e);
             var Modalidad = ImgUsuario.attr("Modalidad");
             var strData = ImgUsuario.attr("Data").toString();
             var oContactoBE = strData.SerializedToObject();//Informacion del Contacto

             EasyNetLiveChat.Modalidad = Modalidad;

             switch (Modalidad) {
                 case EasyNetLiveChat.Enum.Modalidad.ContactDestino:
                     //Usuario Destino Seleccionado
                     oContactoSendDestinoSeleccionadoBE = oContactoBE;
                     NetSuite.LiveChat.WndPopupIface.Task.Excecute('Load historial chat..', function () {
                         /*parametros de ingreso Contacto Origen - Destino */
                         EasyNetLiveChat.Render.ChatHistoryDialogo(oContactoDestinoBE.IdContacto, oContactoBE.IdContacto);
                     });
                     
                     break;
                 case EasyNetLiveChat.Enum.Modalidad.GrupoDestino:
                     //if (EasyNetLiveChat.Data.VerificarPertenezcoAlGrupo(value))
                     if (oContactoBE.IdContacto != UsuarioBE.IdContacto) {//ContactoBE viene a ser el Usuario o Grupo Seleccionado y 
                         EasyNetLiveChat.Render.ChatHistoryDialogo(UsuarioBE.IdContacto, oContactoBE.IdContacto);//Verifica los Mensaje recibidos al grupo (ContactoBE) del usuario(UsuarioBE-Usuario logueado)
                     }                     
                     break;
                 case "Usuario":
                     break;

             }
         }

         EasyNetLiveChat.IdMiembroGrupoSeleccionado = 0;

         EasyNetLiveChat.ServicioExistFileJs = false;
         EasyNetLiveChat.OnItemSelected = function (value, ItemBE) {
             
             //Registra la libreria relacionada a l grupo y por ende al servicio o incidencia
             NetSuite.Manager.Broker.RegistrarLib(ItemBE.LIB_JS_SRVBROKER.toString().Replace(" ", ""));

             //Datos del Contacto Destino
             oContactoDestinoBE = new NetSuite.LiveChat.ContactBE();
             oContactoDestinoBE.IdContacto = ItemBE.ID_CONTACT
             oContactoDestinoBE.Foto = ((ItemBE.ISGRUPO == '1') ? ItemBE.FOTO_GRUPO : EasyNetLiveChat.FotoContacto(ItemBE.NRODOCUMENTO));
             oContactoDestinoBE.Nombre = ItemBE.NOMBRECONTACTO;
             oContactoDestinoBE.Tipo = ItemBE.ISGRUPO;

             //Implementado 28-10-2025
             EasyNetLiveChat.DisplaySelected.ContactoInfo(oContactoDestinoBE);
         }

         EasyNetLiveChat.DisplaySelected = {};
         EasyNetLiveChat.DisplaySelected.ContactoInfo = function (oContactoDestinoBE) {
             EasyNetLiveChat.Panel.Contactos.Right().clear();

             EasyNetLiveChat.Panel.Contactos.Left().clear();
             EasyNetLiveChat.Panel.Contactos.Left().innerHTML = EasyNetLiveChat.ITemplateInfoContacto(oContactoDestinoBE);
             EasyNetLiveChat.Panel.Contactos.Right().clear();

             NetSuite.LiveChat.WndPopupIface.Task.Excecute('Load historial chat..', function () {
                 if (EasyNetLiveChat.Data.VerificarPertenezcoAlGrupo(oContactoDestinoBE.IdContacto)) {
                     EasyNetLiveChat.Render.ContactosSendMSGtoGRP(oContactoDestinoBE.IdContacto);
                 }
                 else {
                     EasyNetLiveChat.Render.MiembrosdeGrupoSeleccionado(oContactoDestinoBE);
                 }
                 //Actualiza Estado
                 var ContactosBE = [].slice.call(EasyNetLiveChat.Panel.Contactos.Right().children);
                 ContactosBE.forEach(function (CtrlContacto) {
                     var oImgContacto = CtrlContacto.children[0];
                     var oContactoBE = jNet.get(oImgContacto).attr("Data").toString().SerializedToObject();
                     var oHtmlStatus = jNet.get(CtrlContacto.children[1]);
                     oHtmlStatus.css('background-color', oContactoBE.ColorEstado);
                 });
                 EasyNetLiveChat.Render.ChatHistoryDialogo(UsuarioBE.IdContacto, oContactoDestinoBE.IdContacto);
             });
         }



         EasyNetLiveChat.Render.ContactosSendMSGtoGRP = function (IdGrupoServicios) {
             var Cant = 0;
             EasyNetLiveChat.Data.LstMiembroContactosSendToGRP(IdGrupoServicios).Rows.forEach(function (oDR, i) {
             var ContactSendBE = new NetSuite.LiveChat.ContactBE();
                 ContactSendBE.IdContacto = oDR.ID_CONTACT_ORG;
                 ContactSendBE.Nombre = oDR.NOMBRECONTACTO;
                 ContactSendBE.CodPersonal = oDR.IDPERSONAL;
                 ContactSendBE.Foto = EasyNetLiveChat.FotoContacto(oDR.NRODOCUMENTO);
                 ContactSendBE.EMail = oDR.EMAIL;
                 ContactSendBE.ColorEstado = oDR.COLORESTADO;
                 //Verificar realsi los usuarios estan conectados
                 EasyNetLiveChat.Panel.Contactos.Right().innerHTML += EasyNetLiveChat.ITemplateLstUsuarioContacto(EasyNetLiveChat.Enum.Modalidad.ContactDestino, ContactSendBE);
                    Cant = i;
                });
                if (Cant > 1) {
                    EasyNetLiveChat.Panel.Contactos.Right().innerHTML += EasyNetLiveChat.ITemplateLstUsuarioContactoCount(Cant);
                }
         } 
         EasyNetLiveChat.Render.MiembrosdeGrupoSeleccionado = function (_ContactoDestinoBE) {
             if (_ContactoDestinoBE.Tipo == 1) {//Grupo de Usuarios
                 var Cant = 0;
                 EasyNetLiveChat.Data.LstMiembroGrupoSeleccionado(_ContactoDestinoBE.IdContacto).Rows.forEach(function (oDR, i) {
                     //Verificar si los usuarios estan conectados
                     var oContactBE = new NetSuite.LiveChat.ContactBE();
                     oContactBE.IdContacto = oDR.ID_CONTACT;
                     oContactBE.IdMiembro = oDR.ID_MIEMBRO;
                     oContactBE.CodPersonal = oDR.IDPERSONAL;
                     oContactBE.IdEstado = oDR.IDESTCHAT;
                     oContactBE.ColorEstado = oDR.COLORESTADO;
                     oContactBE.Foto = EasyNetLiveChat.FotoContacto(oDR.NRODOCUMENTO);;
                     oContactBE.Nombre = oDR.APELLIDOSYNOMBRES;
                     EasyNetLiveChat.Panel.Contactos.Right().innerHTML += EasyNetLiveChat.ITemplateLstUsuarioContacto("Grupo", oContactBE);
                     Cant = i;
                 });
                 if (Cant > 1) {
                     EasyNetLiveChat.Panel.Contactos.Right().innerHTML += EasyNetLiveChat.ITemplateLstUsuarioContactoCount(Cant);
                }
             }
         } 
         EasyNetLiveChat.Render.ChatHistoryDialogo = function(IdContactoOrg, IdContactDes) {
             EasyNetLiveChat.Panel.Body().clear();

             EasyNetLiveChat.Data.ListarHistorialChatDialogo(IdContactoOrg, IdContactDes).Rows.forEach(function (oDR, i) {
                     var oContactBE = new NetSuite.LiveChat.ContactBE();
                         oContactBE.Foto = EasyNetLiveChat.FotoContacto(oDR.NRODOCUMENTO);;

                    var _MensajeBE = new NetSuite.LiveChat.MensajeBE();
                        _MensajeBE.ContactoFrom = oContactBE;
                        _MensajeBE.IdMsg = oDR.ID_MSG;
                        _MensajeBE.AllContenidoBE = EasyNetLiveChat.Data.ListaHistorialChatContenido(_MensajeBE.IdMsg);

                    if (IdContactoOrg == oDR.ID_CONTACT_ORG) {

                         EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.LiveChat.ItemplateChatOwner(_MensajeBE);
                     }
                     else {
                         EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.LiveChat.ItemplateChatContact(_MensajeBE);
                     }
             });
             //Objeto Creado en Header.ascx
             NetSuite.LiveChat.WndPopupIface.ProgressBar.Hide();
         }

         EasyNetLiveChat.Data.LstMiembroContactosSendToGRP = function (IdGrupoServicios) {
             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
             oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
             oEasyDataInterConect.Metodo = "LstContactSendtoGrupo";

             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("IdContactGrupo", IdGrupoServicios, TipodeDato.Int);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
             oParamCollections.Add(oParam);

             oEasyDataInterConect.ParamsCollection = oParamCollections;

             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
             return oEasyDataResult.getDataTable();
         }
         EasyNetLiveChat.Data.LstMiembroGrupoSeleccionado = function (IdContacto) {
             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
             oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
             oEasyDataInterConect.Metodo = "ListarMiembros";

             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("IdContacto", IdContacto, TipodeDato.Int);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
             oParamCollections.Add(oParam);

             oEasyDataInterConect.ParamsCollection = oParamCollections;

             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
             return oEasyDataResult.getDataTable();
         }
         EasyNetLiveChat.Data.VerificarPertenezcoAlGrupo = function (IdContactoGrupo) {

             EasyNetLiveChat.IdMiembroGrupoSeleccionado = 0;

             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
             oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
             oEasyDataInterConect.Metodo = "IsMiembrodeGrupo";

             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("IdContactGrupo", IdContactoGrupo, TipodeDato.Int);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("CodPersona", UsuarioBE.CodPersonal);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
             oParamCollections.Add(oParam);

             oEasyDataInterConect.ParamsCollection = oParamCollections;

             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);

             oEasyDataResult.getDataTable().Rows.forEach(function (oDR, i) {
                 //Verificar si los usuarios estan conectados
                 EasyNetLiveChat.IdMiembroGrupoSeleccionado = oDR["ID_MIEMBRO"];

             });

             return (EasyNetLiveChat.IdMiembroGrupoSeleccionado == 0) ? false : true;


         }

         EasyNetLiveChat.Data.ListarHistorialChatDialogo = function (IdContactoOrg, IdContactDes) {
             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
             oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
             oEasyDataInterConect.Metodo = "LstHistorialDialogo";

             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("IdContactoOrg", IdContactoOrg);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("IdContactoDes", IdContactDes, TipodeDato.Int);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
             oParamCollections.Add(oParam);

             oEasyDataInterConect.ParamsCollection = oParamCollections;
             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
             return oEasyDataResult.getDataTable();
         }

         EasyNetLiveChat.Data.ListarHistorialChatDialogoContenido = function(IdMsg){
             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
             oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
             oEasyDataInterConect.Metodo = "LstHistorialDialogoContenido";

             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("Idmsg", IdMsg);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
             oParamCollections.Add(oParam);

             oEasyDataInterConect.ParamsCollection = oParamCollections;
             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
             
             return oEasyDataResult.getDataTable();
         }

         // EasyNetLiveChat.Badget = function (IdContents) {
         EasyNetLiveChat.Data.Badget = function (IdContents) {
             //var strHTMLLike = "";
             var CollectionMsgLike = new Array();
             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
             oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
             oEasyDataInterConect.Metodo = "LstHistorialDialogoContenidoLikes";

             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("IdContents", IdContents);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
             oParamCollections.Add(oParam);

             oEasyDataInterConect.ParamsCollection = oParamCollections;

             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
             //var pos = 100;
             try {
                 oEasyDataResult.getDataTable().Rows.forEach(function (oDataRow, i) {
                     //var _Likes = "+" + oDataRow.NROLIKE
                     //strHTMLLike += '<span class="badge1 rounded-pill text-danger"   style=" right: ' + pos + 'px">' + _Likes + '<img style="width:20px" src = "' + oDataRow.CMEDIA + '" /> </span>';
                     //pos = pos + 30;
                     var oMensajeContenidoLikesBE = new NetSuite.LiveChat.MensajeContenidoLikesBE();
                        oMensajeContenidoLikesBE.NroLikes = oDataRow.NROLIKE;
                        oMensajeContenidoLikesBE.Icono = oDataRow.CMEDIA;
                     CollectionMsgLike.Add(oMensajeContenidoLikesBE);
                 });
             }
             catch (ex) {

             }
             //  return strHTMLLike;
             return CollectionMsgLike; 
         }

         EasyNetLiveChat.Data.ListaHistorialChatContenido = function (IdMsg) {
             var CollectionMsgContenido = new Array();
             EasyNetLiveChat.Data.ListarHistorialChatDialogoContenido(IdMsg).Rows.forEach(function (oDataRow, i) {
                 var MensajeContenidoBE = new NetSuite.LiveChat.MensajeContenidoBE();
                 MensajeContenidoBE.IdMsg = IdMsg;
                 MensajeContenidoBE.IdContenido = oDataRow.ID_CONTENTS;
                 MensajeContenidoBE.Texto = oDataRow.TEXT;
                 MensajeContenidoBE.AllLikes = EasyNetLiveChat.Data.Badget(oDataRow.ID_CONTENTS);

                 if (oDataRow.IDINFO != '0') {//tIENE QUE SER CAMBIADO POR UN CAMPO QUE INDIQUE EL ORIGEN DE LA INFORMACION
                     //Implementaar interface de servicio o incidenca
                     MensajeContenidoBE.Texto = NetSuite.Manager.Broker.onItemMsgBubble(oDataRow);
                 }
                 CollectionMsgContenido.Add(MensajeContenidoBE);
             });
             return CollectionMsgContenido;
         }

         EasyNetLiveChat.Data.GuardarMensaje = function (oMensajeBE) {
             var ContactoFromBE = oMensajeBE.ContactoFrom;
             var ContactoToBE = oMensajeBE.ContactoTo;
             var oMensajeContenidoBE = oMensajeBE.AllContenidoBE[0];

             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("IdMiembro", ContactoFromBE.IdMiembro, TipodeDato.Int);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("Texto", oMensajeContenidoBE.Texto);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("IdContactOrg", ContactoFromBE.IdContacto, TipodeDato.Int);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("IdContactDes", ContactoToBE.IdContacto, TipodeDato.Int);
             oParamCollections.Add(oParam);

             oParam = new SIMA.Param("IdTablaInfo", ((oMensajeBE.IdTablaInfo == undefined) ? "7" : oMensajeBE.IdTablaInfo));
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("IdInfo", ((oMensajeBE.IdInfo == undefined) ? "0" : oMensajeBE.IdInfo));
             oParamCollections.Add(oParam);

             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
             oEasyDataInterConect.UrlWebService = EasyNetLiveChat.PathUrlServiceChat;
             oEasyDataInterConect.Metodo = "RegistrarMensajeyContenidoClient";
             oEasyDataInterConect.ParamsCollection = oParamCollections;

             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
             return oEasyDataResult.sendData().toString().SerializedToObject();
         }

         var Pos = 0;
         EasyNetLiveChat.InputMensaje = function (e) {
             if (event.keyCode === 13) {

                 if (oContactoDestinoBE != null) {

                     var oMensajeBE = new NetSuite.LiveChat.MensajeBE();
                     oMensajeBE.TipoMsg = 1;//Mensaje Normal desde la interface
                     switch (EasyNetLiveChat.Modalidad) {
                         case EasyNetLiveChat.Enum.Modalidad.ContactDestino:
                             var oCntOrigenBE = new NetSuite.LiveChat.ContactBE();
                             oCntOrigenBE.IdContacto = oContactoDestinoBE.IdContacto;
                             oCntOrigenBE.IdMiembro = EasyNetLiveChat.IdMiembroGrupoSeleccionado;//Id del Miebro del Grupo seleccionado que correponde al usuario logueado 
                             oCntOrigenBE.Tipo = oContactoDestinoBE.Tipo;
                             oCntOrigenBE.Foto = EasyNetLiveChat.FotoContacto(UsuarioBE.NroDocumento);
                             oCntOrigenBE.Nombre = UsuarioBE.ApellidosyNombres;

                             var oCntDestinoBE = new NetSuite.LiveChat.ContactBE();
                             oCntDestinoBE = oContactoSendDestinoSeleccionadoBE;
                             //Eatblece parametros de envio
                             oMensajeBE.ContactoFrom = oCntOrigenBE;
                             oMensajeBE.ContactoTo = oCntDestinoBE;
                             //Insertar en la BD
                             oMensajeBE.IdMsg = '0';
                                // oMensajeBE.MessageHTML = e.value;
                                var MensajeContenidoBE = new NetSuite.LiveChat.MensajeContenidoBE();
                                    MensajeContenidoBE.IdMsg = oMensajeBE.IdMsg;
                                    MensajeContenidoBE.IdContenido = 0;
                                    MensajeContenidoBE.Texto = e.value;
                                    MensajeContenidoBE.AllLikes = null;
                             var CollectionMsgContenido = new Array();
                             CollectionMsgContenido.Add(MensajeContenidoBE);
                             oMensajeBE.AllContenidoBE = CollectionMsgContenido;

                             var jSonBE = EasyNetLiveChat.Data.GuardarMensaje(oMensajeBE);
                             oMensajeBE.IdMsg = jSonBE.OutIdMsg;

                             MensajeContenidoBE.IdMsg = oMensajeBE.IdMsg;
                             MensajeContenidoBE.IdContenido = jSonBE.OutIdContenido;
                             //Cuando se recibe de unusuario remoto
                            // alert('desde remoto');
                             break;
                         case EasyNetLiveChat.Enum.Modalidad.GrupoDestino:
                         default:
                             var oContactFromBE = new NetSuite.LiveChat.ContactBE();
                             oContactFromBE.IdContacto = UsuarioBE.IdContacto;
                             oContactFromBE.IdMiembro = UsuarioBE.IdContacto;
                             oContactFromBE.Foto = EasyNetLiveChat.FotoContacto(UsuarioBE.NroDocumento);
                             oContactFromBE.Nombre = UsuarioBE.ApellidosyNombres;

                             //Eatblece parametros de envio
                             oMensajeBE.ContactoFrom = oContactFromBE;
                             oMensajeBE.ContactoTo = oContactoDestinoBE;

                                 var MensajeContenidoBE = new NetSuite.LiveChat.MensajeContenidoBE();
                                     MensajeContenidoBE.IdMsg = oMensajeBE.IdMsg;
                                     MensajeContenidoBE.IdContenido = 0;
                                     MensajeContenidoBE.Texto = e.value;
                                     MensajeContenidoBE.AllLikes = null;
                             var CollectionMsgContenido = new Array();
                             CollectionMsgContenido.Add(MensajeContenidoBE);
                             oMensajeBE.AllContenidoBE = CollectionMsgContenido;

                             var jSonBE = EasyNetLiveChat.Data.GuardarMensaje(oMensajeBE);
                             oMensajeBE.IdMsg = jSonBE.OutIdMsg;
                             MensajeContenidoBE.IdMsg = oMensajeBE.IdMsg;
                             MensajeContenidoBE.IdContenido = jSonBE.OutIdContenido;
                             //Cuando el usuario envia a u grupo seleccionado
                            // alert('desde local');
                             break;
                     }

                     NetSuite.LiveChat.EnviaMensaje(oMensajeBE);
                     location.href = '#' + oMensajeBE.IdMsg;
                   
                     Pos++;
                     e.value = "";
                 }
                 else {//inicio del chatbots
                     var TextFindValue = e.value;
                     if (TextFindValue.length == 0) { return true; }

                     var idSysMsg = generateUUID();
                     EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.Manager.Broker.Request(idSysMsg);
                     document.getElementById("t" + idSysMsg).scrollIntoView({ behavior: 'smooth' });

                     //Escribe el texto ingresao para busqueda
                     (new Maquina("t" + idSysMsg)).typeWriter(TextFindValue, function () {
                         idSysMsg = generateUUID();//genera un nuevo id para el control bubble
                         EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.Manager.Broker.Response(idSysMsg, '');

                         document.getElementById("t" + idSysMsg).scrollIntoView({ behavior: 'smooth' });

                         (new Maquina("t" + idSysMsg)).typeWriter('Espere un momento por favor... ', function () {
                                                                                                         var existe = false;
                                                                                                         var Pref = "t";
                                                                                                                    NetSuite.Manager.Data.ResponseFind(TextFindValue).Rows.forEach(function (oDrow, r) {

                                                                                                                        if (r > 0) {
                                                                                                                            idSysMsg = generateUUID();//genera un nuevo id para el control bubble
                                                                                                                            if (parseInt(oDrow["NROHIJOS"].toString()) > 0) {
                                                                                                                                Pref = "t";
                                                                                                                                EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.Manager.Broker.Response(idSysMsg, 'Espere un momento por favor : ' + idSysMsg);
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                Pref = "Title_";
                                                                                                                                EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.Manager.Broker.ResponseItemOP(idSysMsg, oDrow["RESPUESTA"].toString(), oDrow["COMENTARIO"], oDrow);
                                                                                                                            }

                                                                                                                        }
                                                                                                                        else {
                                                                                                                            if (oDrow["IDTIPO"] == "3") {
                                                                                                                                var objBubble = jNet.get("bubble_" + idSysMsg);
                                                                                                                                EasyNetLiveChat.Panel.Body().remove(objBubble);//remueve la burbuja estandar

                                                                                                                                Pref = "Title_";
                                                                                                                                idSysMsg = generateUUID();
                                                                                                                                EasyNetLiveChat.Panel.Body().innerHTML += NetSuite.Manager.Broker.ResponseItemOP(idSysMsg, oDrow["RESPUESTA"].toString(), oDrow["COMENTARIO"], oDrow);
                                                                                                                                //objWrite = jNet.get(Pref + idSysMsg);
                                                                                                                            }
                                                                                                                        }

                                                                                                                     var objWriter = (new Maquina(Pref + idSysMsg));
                                                                                                                   
                                                                                                                     if (parseInt(oDrow["NROHIJOS"].toString()) > 0) {
                                                                                                                        
                                                                                                                         objWriter.Clear();
                                                                                                                         objWriter.typeWriter(oDrow["RESPUESTA"].toString(), function () {
                                                                                                                                                                                 objWriter.Enter();
                                                                                                                                                                                 if (oDrow["COMENTARIO"] != undefined) {
                                                                                                                                                                                     objWriter.typeWriter(oDrow["COMENTARIO"].toString(), function () {
                                                                                                                                                                                         SubResponse(oDrow["ID_RESP"].toString(), jNet.get(Pref + idSysMsg));
                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                         });
                                                                                                                                                                                 }
                                                                                                                                                                                 else {
                                                                                                                                                                                     if (parseInt(oDrow["NROHIJOS"].toString()) > 0) {
                                                                                                                                                                                         SubResponse(oDrow["ID_RESP"].toString(), jNet.get(Pref + idSysMsg));
                                                                                                                                                                                     }
                                                                                                                                                                                 }

                                                                                                                                                                             });
                                                                                                                     }
                                                                                                                     else {                                                                                                                        
                                                                                                                         objWriter.Clear();
                                                                                                                         objWriter.typeWriter(oDrow["RESPUESTA"].toString(), function () {
                                                                                                                           //  alert();
                                                                                                                             objWriter.Enter();
                                                                                                                             if (oDrow["COMENTARIO"] != undefined) {
                                                                                                                                 objWriter.typeWriter(oDrow["COMENTARIO"].toString(), function () {
                                                                                                                                     if (parseInt(oDrow["NROHIJOS"].toString()) > 0) {
                                                                                                                                         SubResponse(oDrow["ID_RESP"].toString(), jNet.get(Pref + idSysMsg));
                                                                                                                                     }
                                                                                                                                 });
                                                                                                                             }
                                                                                                                             else {
                                                                                                                                 if (parseInt(oDrow["NROHIJOS"].toString()) > 0) {
                                                                                                                                     SubResponse(oDrow["ID_RESP"].toString(), jNet.get(Pref + idSysMsg));
                                                                                                                                 }
                                                                                                                             }

                                                                                                                         });
                                                                                                                        
                                                                                                                     }
                                                                                                                     document.getElementById(Pref + idSysMsg).scrollIntoView({ behavior: 'smooth' });
                                                                                                                     existe = true;//flag que 
                                                                                                                 });

                            

                                                                                                                if (existe == false) {
                                                                                                                    var objWriterErr = (new Maquina(Pref + idSysMsg))
                                                                                                                    objWriterErr.Clear();
                                                                                                                    objWriterErr.typeWriter("No se encontro respuesta a esta petición.. intente otra vez");
                                                                                                                 }
                                                                                                             });

                     });

                     e.value='';
                 }
             }
           
         }


         function Maquina(CtrlName) {
             var htmlInject = '<div id="[ID]">Loandig..</div>';
             let index = 0;
             var Me = this;
             var text = null;
             var Largo = 0;
            
             this.typeWriter = function (Cadena, fnc) {
                 if ((Cadena != undefined) || (Cadena != null)) {
                     index = 0;
                     text = Cadena;
                     Largo = text.length;
                 }
                
                 if (index < Largo) {
                     switch (text.charAt(index)) {
                         case "<":
                             this.Enter();
                             index = index + this.Enter(true).length;
                             break;
                         case "#":
                             this.Enter();
                             var html = htmlInject.replace("[ID]", "P" + CtrlName);
                             document.getElementById(CtrlName).innerHTML += html;
                             index = index + 4;
                             //Cargar la Pagina en el control

                             /*var oColletionParams = new SIMA.ParamCollections();
                             var oParam = new SIMA.Param(Default.KEYIDGENERAL, 0);
                             oColletionParams.Add(oParam);

                             urlPag = Page.Request.ApplicationPath + "/HelpDesk/ITIL/ListarServicioXArea.aspx";
                             var oLoadConfig = {
                                 CtrlName: "P" + CtrlName,
                                 UrlPage: urlPag,
                                 ColletionParams: oColletionParams,
                             };
                             SIMA.Utilitario.Helper.LoadPageInCtrl(oLoadConfig);
                             */

                             break;
                     }

                     document.getElementById(CtrlName).innerHTML += text.charAt(index);
                     index++;
                     setTimeout(function () { Me.typeWriter(null, fnc); }, 50);
                 }
                 else {
                     if ((fnc != undefined) || (fnc != null)) {
                         fnc();
                     }

                 }

             }
             this.Clear = function () {
                 document.getElementById(CtrlName).innerHTML ='';
             }
             this.Enter = function (Return) {
                 var Carri = '</br>';
                 if ((Return!=undefined)&&(Return==true)) {
                     return Carri;
                 }
                 else {
                     document.getElementById(CtrlName).innerHTML += Carri;
                 }
             }
         }


         function SubResponse(IdPadre, oBubble) {

             NetSuite.Manager.Data.ResponseChild(IdPadre).Rows.forEach(function (_drow, r) {
                 gidSysMsg = generateUUID();
                 switch (_drow["IDTIPO"].toString()) {
                     case "3":
                         oBubble.innerHTML += NetSuite.Manager.Broker.ResponseItemOP(gidSysMsg, _drow["RESPUESTA"].toString(), _drow["COMENTARIO"].toString(), _drow);
                       //  var oBubbleOption = jNet.get("t" + gidSysMsg);
                        // oBubbleOption.attr("Data", ''.BaseSerialized(_drow));
                         break;
                     case "2":
                         oBubble.innerHTML += NetSuite.Manager.Broker.ResponseGroup(gidSysMsg, _drow["RESPUESTA"].toString());
                         break;

                 }
                 
                 document.getElementById("t" + gidSysMsg).scrollIntoView({ behavior: 'smooth' });//para el scroll
                 if (parseInt(_drow["NROHIJOS"].toString()) > 0) {
                     SubResponse(_drow["ID_RESP"].toString(), jNet.get("t" + gidSysMsg));
                 }
             });
         }


     </script>

    <STYLE>
        .message-box {
              padding: 6px 10px;
              border-radius: 6px 0 6px 0;
              position: relative;
              background: rgba(100, 170, 0, .1);
              border: 2px solid rgba(100, 170, 0, .1);
              color: #6c6c6c;
              font-size: 12px;
            }

            .message-box:after {
              content: "";
              position: absolute;
              border: 10px solid transparent;
              border-top: 10px solid rgba(100, 170, 0, .2);
              border-right: none;
              bottom: -22px;
              right: 10px;
            }
            
            .message-partner {
              background: rgba(0, 114, 135, .1);
              border: 2px solid rgba(0, 114, 135, .1);
              align-self: flex-start;
            }

            .message-partner:after {
              right: auto;
              bottom: auto;
              top: -22px;
              left: 9px;
              border: 10px solid transparent;
              border-bottom: 10px solid rgba(0, 114, 135, .2);
              border-left: none;
            }
    </STYLE>




</html>
