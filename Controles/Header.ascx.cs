using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using EasyControlWeb;
using EasyControlWeb.Errors;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using Org.BouncyCastle.Asn1.Pkcs;
using SIMANET_W22R;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.HelpDesk;
using SIMANET_W22R.HelpDesk.ChatBot;
using static System.Net.WebRequestMethods;
using static EasyControlWeb.EasyUtilitario.Enumerados;

namespace SIMANET_W22R.Controles
{
    /*
     * Autor:Rosales Azabache Eddy 
     */
    public partial class Header : System.Web.UI.UserControl {
        #region Variables Locales 
        const string NombreFuncion = "SystemMnuOptions";
        #endregion
        public string IdGestorFiltro
        {
            get { return (string)this.ViewState["CtrlFiltroRel"]; }
            set { this.ViewState["CtrlFiltroRel"] = value; }
        }
        public enum TipoLib {
            Style,
            Script,
            ScriptFrag,
        }
        public string[,] StyleBase {
            get { return new string[13, 2]{
                                                  { "bootstrap", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/bootstrap.min.css" }
                                                 /*,{ "jquery-ui",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/1.10.4.jquery-ui.css"} crea conflito con el treeview
                                                 ,{ "Autobusqueda","http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"}*/
                                                 ,{ "Autobusqueda",EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/css/jquery-ui.css"}
                                                 ,{ "bootstrap-datepicker3",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/1.4.1.bootstrap-datepicker3.css"}
                                                 ,{ "jquery-confirm.min.css",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/jquery-confirm.min.css"}
                                                 ,{ "font-awesome.min.css", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/font-awesome.min.css"}
                                                 ,{ "StyleEasy", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/StyleEasy.css"}
                                                 ,{ "StyleEasyAlert", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/Alerts.css"}
                                                 ,{ "EasyStyleProgressBar", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/EasyStyleProgressBar.css"}
                                                 ,{ "EasyNetLiveChat", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/EasyNetLiveChat.css"}
                                                 ,{ "jqx.base", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/jqx.base.css"}
                                                 ,{ "jqx.light", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/jqx.light.css"}
                                                 ,{ "toasscc", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/css/Toas/nostfly.min.css"}
                                                 //Agregado 09-09-2025
                                                 ,{ "cssTree", EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/zTreeStyle.css" }
                                                };
            }
        }

        public string[,] ScriptBase
        {
            get { return new string[24, 2]{
                                                /*  { "Core", "https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"}*/
                                                 { "Core", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/jquery.min.js"}
                                                 ,{ "bootstrap.min",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/4.5.2.bootstrap.min.js"}
                                                 ,{ "jquery-confirm.min",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/jquery-confirm.min.js"}
                                                // ,{ "jspdf.min",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/1.5.3-jspdf.min.js"}
                                                // ,{ "jspdf.plugin.autotable", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/3.5.6-jspdf.plugin.autotable.js"}
                                                 ,{ "Objects", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/LibSIMA/Objetcs.js"}
                                                 ,{ "SM", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/LibSIMA/ScriptManager.js"}
                                                 ,{ "Socket", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/LibSIMA/NetSuiteSocket.js"}
                                                 ,{ "EasyConect",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/LibSIMA/EasyDataInterConect.js"}
                                                 ,{ "AccesoDatosBase", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/LibSIMA/AccesoDatosBase.js"}
                                                 ,{ "SIMA.GidView.Entended", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/LibSIMA/SIMA.GidView.Entended.js"}
                                                 ,{ "HtmlToCanvas", EasyUtilitario.Helper.Pagina.PathSite()+  "/Recursos/LibSIMA/HtmlToCanvas.js"}
                                                 ,{ "EasyControlSetting", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/LibSIMA/EasyControlSetting.js"}
                                                 ,{ "jquery-ui.min", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/jquery-ui.min.js"}
                                                 //,{ "jquery-ui.min", "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"}
                                                 //,{ "jquery-ui.min", "http://code.jquery.com/ui/1.13.0/jquery-ui.min.js"}
                                                 ,{ "datepicker", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/1.4.1.bootstrap-datepicker.min.js"}
                                                 ,{ "bootstrap-waitingfor", EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/bootstrap-waitingfor.js"}
                                                 ,{ "jqxcore",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/jqxcore.js"}
                                                 ,{ "jqxmenu",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/jqxmenu.js"}
                                                // ,{ "menuContext","https://www.jqueryscript.net/demo/simple-dynamic-context-menu/dist/js/simple-context-menu.min.js"}
                                                 ,{ "menuContext",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/simple-context-menu.min.js"}
                                                 ,{ "ConstPrc",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/LibSIMA/ConstanteProcesos.js"}
                                                 ,{ "ConfigBase",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/LibSIMA/MasterConfig.js"}
                                                 ,{ "ToasJs",EasyUtilitario.Helper.Pagina.PathSite()+"/Recursos/Js/Toas/nostfly.min.js"}
                                                 //Agregado 09-08-2025
                                                 ,{ "jsTree",  EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.core.js"}
                                                ,{ "jsTree2",EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.exedit.js"}
                                                ,{ "jsTree3", EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Tree/jquery.ztree.excheck.js"}
                                                ,{ "jsGraph", EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/Js/Chart.min.js"}
                                                



                                                };

            }
        }
        public string[,] InitDefBase
        {
            get
            {
                string PScript = @"var Page = {};
                                        Page.Response = {};
                                        Page.Response.redirect = function (Url) {
                                            window.location.href = Url;
                                        }
                                        Page.Response.OnLoadComplete = null;
                                        Page.Response.CtrlDestino = null;
                                        Page.Response.Load = function (UrlPage) {
                                            if (Page.Response.CtrlDestino != null) {
                                                var fncLink = ((Page.Response.OnLoadComplete != null) ? Page.Response.OnLoadComplete : " + EasyUtilitario.Constantes.Caracteres.ComillaDoble + EasyUtilitario.Constantes.Caracteres.ComillaDoble +@");
                                                jNet.get(Page.Response.CtrlDestino).load(UrlPage, " + EasyUtilitario.Constantes.Caracteres.ComillaDoble + EasyUtilitario.Constantes.Caracteres.ComillaDoble + @", fncLink);
                                            }
                                        }
                                        Page.Request = {};
                                        Page.Request.App_Protocol_Path_Name = "+ EasyUtilitario.Constantes.Caracteres.ComillaDoble + EasyUtilitario.Helper.Pagina.PathSite() + EasyUtilitario.Constantes.Caracteres.ComillaDoble  + @";
                                        Page.Request.ApplicationPath = Page.Request.App_Protocol_Path_Name;
                                        Page.Request.Params = new Array();
                                        ";
                return new string[1, 1] { { PScript } };
            }
        }

        public string[,] InitMenu {
            get
            {
                return new string[1, 1] { { "$.jqx.theme = 'light';" } };
            }
        }

        string[,] TagCtrl = new string[2, 5] {{ "link","href" ,"rel","stylesheet","Estylos Base"}
                                                  ,{ "script","src" ,"type", "text/javascript","Scripts Base"}
                                                 };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // EasyNavigatorBarMenu1.IconColor = "#a8a8a8";
                EasyNavigatorBarMenu1.IconColor = "white";
                EasyNavigatorBarMenu1.IconColorOver = "green";
                this.btnIconMenu.Style.Add("display", "none");
                EasyNavigatorBarMenu1.ImagenLogoHeader = ResolveUrl("~/Recursos/img/header.jpg");
            }
            try
            {
                /*-----------------------------DEFINICION DEL PATH DEL APP---------------------------*/
                RegistrarLibs(Page.Header, TipoLib.ScriptFrag, this.InitDefBase);

                /*---------------Carga Los Stylos y Librerias Base-------------------*/
                RegistrarLibs(Page.Header,TipoLib.Style,this.StyleBase);
                RegistrarLibs(Page.Header, TipoLib.Script, this.ScriptBase);
                RegistrarLibs(Page.Header, TipoLib.ScriptFrag, this.InitMenu);
                /*-------------------------------------------------------------------*/

                LoadOpcionesdeMenu();

                EasyNavigatorBarIconBE oEasyNavigatorBarIconBE = new EasyNavigatorBarIconBE();
                oEasyNavigatorBarIconBE.fa_icon = "fa fa-filter";
                oEasyNavigatorBarIconBE.Text = "Filtrar";
                //  string fcGestorFiltro = ((IdGestorFiltro != null) ? IdGestorFiltro + "_OpenWinModal('" + IdGestorFiltro + "_Crit');" : "");
                string fcGestorFiltro = ((IdGestorFiltro != null) ? IdGestorFiltro + "_Init();" : "");
                oEasyNavigatorBarIconBE.call_fcScript =  fcGestorFiltro; 
                

                EasyNavigatorBarMenu1.OptionsIcon.Add(oEasyNavigatorBarIconBE);

                oEasyNavigatorBarIconBE = new EasyNavigatorBarIconBE();
                oEasyNavigatorBarIconBE.fa_icon = "fa fa-print";
                oEasyNavigatorBarIconBE.Text = "Previo";
                oEasyNavigatorBarIconBE.call_fcScript = "PrintPrevio();";
                EasyNavigatorBarMenu1.OptionsIcon.Add(oEasyNavigatorBarIconBE);



                oEasyNavigatorBarIconBE = new EasyNavigatorBarIconBE();
                oEasyNavigatorBarIconBE.fa_icon = "fa fa-comments-o";
                oEasyNavigatorBarIconBE.Text = "Alerta";
                //oEasyNavigatorBarIconBE.call_fcScript = "NetSuite.LiveChat.Show('ChatRoom');"; 
                oEasyNavigatorBarIconBE.call_fcScript = "LiveChat_OnLoad();";
                EasyNavigatorBarMenu1.OptionsIcon.Add(oEasyNavigatorBarIconBE);



                oEasyNavigatorBarIconBE = new EasyNavigatorBarIconBE();
                oEasyNavigatorBarIconBE.fa_icon = "fa fa-camera-retro";
                oEasyNavigatorBarIconBE.Text = "SnapShot";
                oEasyNavigatorBarIconBE.call_fcScript = "SnapShotFlash();";
                EasyNavigatorBarMenu1.OptionsIcon.Add(oEasyNavigatorBarIconBE);

               /* oEasyNavigatorBarIconBE = new EasyNavigatorBarIconBE();
                oEasyNavigatorBarIconBE.fa_icon = "../../Recursos/img/Infinity.gif";
                oEasyNavigatorBarIconBE.Text = "";
                oEasyNavigatorBarIconBE.TipoImg =true;
                EasyNavigatorBarMenu1.OptionsIcon.Add(oEasyNavigatorBarIconBE);*/

                /*Establece la funcion Script para las opsciones de menu del sistema*/
                EasyNavigatorBarMenu1.fc_OnMenuItem_Click = NombreFuncion;

                /*Obtiene el usuario logueado*/
                EasyNavigatorBarMenu1.SetUser(EasyUtilitario.Helper.Sessiones.Usuario.get());

                //Registra script de funcionalidad del menu options
                Page.RegisterClientScriptBlock("MnuOPSys", ScriptMnuOpSystem());



                string ScriptMenuIco = @"<script>
                                                function PrintPrevio()
                                                    {
                                                        __doPostBack('" + this.btnIconMenu.UniqueID + @"', 'ReportExploreV2');
                                                    }
                                            </script>";
                Page.RegisterClientScriptBlock("IconBTN", ScriptMenuIco);
                string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
                string iconoMsg = "<img style=" + cmll + " width:30px;" + cmll + " src ="+ cmll + "data:image/png;base64,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" + cmll + "/>";
                
                string Iconochat = @"'<div  style=" + cmll + "display: flex;" + cmll + @">'
                                      +'<div class=" + cmll + "logo" + cmll  + @">'
                                        +'<svg viewBox=" +cmll +"0 0 513 513" + cmll +" fill=" + cmll + "currentColor" + cmll +" xmlns=" + cmll + "http://www.w3.org/2000/svg" + cmll + @">'
                                            +'<path d=" + cmll+ "M256.025.05C117.67-2.678 3.184 107.038.025 245.383a240.703 240.703 0 0085.333 182.613v73.387c0 5.891 4.776 10.667 10.667 10.667a10.67 10.67 0 005.653-1.621l59.456-37.141a264.142 264.142 0 0094.891 17.429c138.355 2.728 252.841-106.988 256-245.333C508.866 107.038 394.38-2.678 256.025.05z" + cmll + @"/>'
                                            +'<path d=" + cmll + "M330.518 131.099l-213.825 130.08c-7.387 4.494-5.74 15.711 2.656 17.97l72.009 19.374a9.88 9.88 0 007.703-1.094l32.882-20.003-10.113 37.136a9.88 9.88 0 001.083 7.704l38.561 63.826c4.488 7.427 15.726 5.936 18.003-2.425l65.764-241.49c2.337-8.582-7.092-15.72-14.723-11.078zM266.44 356.177l-24.415-40.411 15.544-57.074c2.336-8.581-7.093-15.719-14.723-11.078l-50.536 30.744-45.592-12.266L319.616 160.91 266.44 356.177z"+ cmll + " fill =" + cmll +"#fff" + cmll + @"/>'
                                        +'</svg>'
                                    +'</div>'
                                    +'  <div style= " + cmll + "padding-left:20px;" +cmll + @">  HelpDesk " + iconoMsg  + @" </div>'
                                    +'</div>'";

                string ScriptLiveChat = @"<script>
                                                 function LiveChat_OnLoad () {
                                                    //Verifica si existe servicio de Listener
                                                    if(NetSuite.Manager.Infinity.User.Contectado==false){
                                                        var msgConfig = { Titulo: 'Advertencia', Descripcion: 'Listener SIMA NetSuiteSocket no se enceuentra activo'};
                                                        var oMsg = new SIMA.MessageBox(msgConfig);
                                                        oMsg.Alert();
                                                        return
                                                    }
                                                    if(UsuarioBE.CodPersonal.toString().length==0){
                                                        var msgConfig = { Titulo: 'Advertencia', Descripcion: 'Maestro de personal SIMANET, Usuario no tiene asociado el código de personal del Mod O7 Solutions'};
                                                        var oMsg = new SIMA.MessageBox(msgConfig);
                                                        oMsg.Alert();
                                                        return
                                                    }

                                                    if(UsuarioBE.IdContacto=='0'){
                                                        var oContactBE = new NetSuite.LiveChat.ContactBE();
                                                            oContactBE.IdContacto = 0;
                                                            oContactBE.Foto = '';
                                                            oContactBE.Nombre = '';
                                                            oContactBE.Tipo=0;
                                                            oContactBE.CodPersonal=UsuarioBE.CodPersonal;

                                                        var oParamCollections = new SIMA.ParamCollections();
                                                        var oParam = new SIMA.Param('IdContacto', oContactBE.IdContacto, TipodeDato.Int);
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param('IsGrupo', oContactBE.Tipo, TipodeDato.Int);
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param('NombreGrupo',oContactBE.Nombre);
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param('FotoGrupo', oContactBE.Foto);
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param('LIB_JS_SRVBROKER', '');
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param('Descripcion', '');
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param('CodPersonal',  oContactBE.CodPersonal);
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                                                            oParamCollections.Add(oParam);

                                                        var oEasyDataInterConect = new EasyDataInterConect();
                                                             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                                                             oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + 'HelpDesk/ChatBot/IChatBotManager.asmx'; 
                                                             oEasyDataInterConect.Metodo = 'IRegistrarContactoyGrupo';
                                                             oEasyDataInterConect.ParamsCollection = oParamCollections;

                                                        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                                                        var objResultBE=oEasyDataResult.sendData().toString().SerializedToObject();
                                                        UsuarioBE.IdContacto=objResultBE.IDCONTACTO

                                                    }
                                                    
                                                    var urlPag = Page.Request.ApplicationPath + '/HelpDesk/ChatBot/EasyNetLiveChat.aspx';
                                                    var oColletionParams = new SIMA.ParamCollections();
                                                    var oParam = new SIMA.Param('QLlama', GlobalEntorno.PageName);
                                                        oColletionParams.Add(oParam);
                                                        " + EasyPopupLiveChat.ClientID + @".Titulo=" + Iconochat + @";
                                                        " + EasyPopupLiveChat.ClientID + @".Load(urlPag, oColletionParams, false);
                                                        NetSuite.LiveChat.WndPopupIface =jNet.get('" + EasyPopupLiveChat.ClientID + @"');
                                                        NetSuite.Manager.Infinity.InterfaceLoad=true;
                                                }
                                                
                                                function LiveChat_OnAceptar(){
                                                    NetSuite.Manager.Infinity.InterfaceLoad=false;
                                                    return true;
                                                }

                                                function LiveChat_OnClose(){
                                                    NetSuite.Manager.Infinity.InterfaceLoad=false;
                                                }

                                                //Implementacones para el control de socket chatbot
                                                window.onload=function(){
                                                    window.ClosePorApp=false;
                                                }
                                                window.onclose = function()
                                                {
                                                  alert('yes');
                                                }
                                                window.onbeforeunload = function(evt){
                                                    alert();

                                                        if(window.ClosePorApp){
                                                            NetSuite.LiveChat.close();//Cierra la conexion con el Listener NetSuiteWebSocket
                                                        }

                                                }

                                         </script>";
                Page.RegisterClientScriptBlock("IconMsg1", ScriptLiveChat);

                string ScriptService = @"<script>
                                                NetSuite.Manager.Broker.Persiana.Popup.Show=function(Setting){
                                                    " +  this.EasyPopupDetalleRQR.ClientID + @".Titulo = Setting.Titulo;
                                                    " +  this.EasyPopupDetalleRQR.ClientID + @".Load(Setting.Pagina,Setting.Parametros,false);
                                                }
                                         </script>";
                Page.RegisterClientScriptBlock("SCPPPSrv", ScriptService);

            }
            catch (Exception ex) {
                
                this.LanzarException("Se esta intentando ingresar de forma INCORRECTA, Error Usuario no Autenticado", ex.TargetSite.Name);
            }
           
        }
        void LoadOpcionesdeMenu() {
            try
            {
                EasyUsuario oEasyUsuario = EasyUtilitario.Helper.Sessiones.Usuario.get();
                if (oEasyUsuario != null)
                {
                    DataTable dtOp = oEasyUsuario.getOpcions();
                    Int64 N_total = 0;
                    if (dtOp is null)
                    {
                        N_total = 0;
                    }
                    else
                    {
                        N_total = dtOp.Rows.Count;
                    }

                    if (N_total > 0)
                    {
                        try
                        {
                            foreach (DataRow dr in dtOp.Select("TipoMenu=1"))
                            {
                                EasyNavigatorBarMenuBE oEasyNavigatorBarMenuBE = new EasyNavigatorBarMenuBE();
                                oEasyNavigatorBarMenuBE.IdOpcion = Convert.ToInt32(dr["IdOpcion"].ToString());
                                oEasyNavigatorBarMenuBE.IdOpcionPadre = Convert.ToInt32(dr["IdPadre"].ToString());
                                oEasyNavigatorBarMenuBE.Nombre = dr["Nombre"].ToString();
                                oEasyNavigatorBarMenuBE.RutaPag = dr["Descripcion"].ToString();
                                DataRow[] drHijos = dtOp.Select("IdPadre='" + oEasyNavigatorBarMenuBE.IdOpcion.ToString() + "' and TipoMenu=1");
                                oEasyNavigatorBarMenuBE.NroSubItems = 0;
                                if (drHijos != null)
                                {
                                    int LenghtCar = 0;
                                    foreach (DataRow drh in drHijos)
                                    {
                                        string NomMenu = drh["Nombre"].ToString();
                                        if (LenghtCar < NomMenu.Length)
                                        {
                                            LenghtCar = NomMenu.Length;
                                        }
                                    }
                                    switch (LenghtCar)
                                    {
                                        case int n when (n >= 0 && n <= 15):
                                            oEasyNavigatorBarMenuBE.AnchoGrp = 130;
                                            break;
                                        case int n when (n >= 16 && n <= 20):
                                            oEasyNavigatorBarMenuBE.AnchoGrp = 180;
                                            break;
                                        case int n when (n >= 21 && n <= 25):
                                            oEasyNavigatorBarMenuBE.AnchoGrp = 185;
                                            break;
                                        case int n when (n >= 26 && n <= 32):
                                            oEasyNavigatorBarMenuBE.AnchoGrp = 220;
                                            break;
                                        case int n when (n >= 33 && n <= 36):
                                            oEasyNavigatorBarMenuBE.AnchoGrp = 260;
                                            break;
                                        case int n when (n >= 37 && n <= 38):
                                            oEasyNavigatorBarMenuBE.AnchoGrp = 310;
                                            break;
                                        case int n when (n >= 39 && n <= 40):
                                            oEasyNavigatorBarMenuBE.AnchoGrp = 280;
                                            break;
                                        case int n when (n >= 41 && n <= 50):
                                            oEasyNavigatorBarMenuBE.AnchoGrp = 330;
                                            break;
                                        case int n when (n >= 51 && n <= 60):
                                            oEasyNavigatorBarMenuBE.AnchoGrp = 335;
                                            break;

                                    }

                                    oEasyNavigatorBarMenuBE.NroSubItems = drHijos.Count();
                                }
                                EasyNavigatorBarMenu1.CollectionMenu.Add(oEasyNavigatorBarMenuBE);
                            }
                        }
                        catch (Exception ex)
                        {

                            this.LanzarException("Usuario Autenticado sin accesos de menú establecidos, Consulte con el Adminstrador de SIMANET", ex.TargetSite.Name);
                        }
                    }
                    else
                    {
                        this.LanzarException("Usuario Autenticado sin accesos de menú establecidos, Consulte con el Adminstrador de SIMANET", "CONEXIÓN");
                    }
                }
                else {
                    // Exception oex = new Exception("Session de usuario a expirado, por favor volver a autenticar");
                    SIMAExceptionSeguridadAccesoForms oex = new SIMAExceptionSeguridadAccesoForms("Session de usuario a expirado, por favor volver a autenticar");
                     (new PaginaBase()).LanzarException(oex);
                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex) {
                (new PaginaBase()).LanzarException(ex);
            }
        }
        protected void EasyNavigatorBarMenu1_HelpSnapShot(EasyControlWeb.Form.Controls.EasySnapShotBE oEasySnapShotBE)
        {
            string NomFile = EasyControlWeb.EasyUtilitario.Helper.Configuracion.Leer("ArchivosAPP", "PathSnapShot") + "Mnu_" + oEasySnapShotBE.IdRef + ".png";
            oEasySnapShotBE.LocalStorage = NomFile;
            EasyControlWeb.EasyUtilitario.Helper.Genericos.SubirArchivo(oEasySnapShotBE.LocalStorage, oEasySnapShotBE.ImgByteArray);
        }

            string PaginaLogin = EasyUtilitario.Helper.Pagina.PathSite()+ "/Login.aspx";
        string ScriptMnuOpSystem() {
            string _sc = @"<script>
                                function " + NombreFuncion  + @"(_key, _Tipo, _IdUser) {
                                    switch(_key){
                                        case 'Key2'://Configuraciones de modulos
                                                LoadConfigMaster();
                                            break;
                                        case 'Key4':
                                            window.ClosePorApp=true;//Indica que la ventana se esta cerrando correctamente mediante el aplicativo en caso sea falso  es un cierre abrupto
                                            Page.Response.redirect('" + PaginaLogin + @"');
                                        break;
                                    
                                    }
                                }
                           </script>
                         ";
            return _sc;
        }
        public void LanzarException(string Mensaje,string TargetSite)
        {
            string[] PagSplit = Page.Request.Url.AbsolutePath.Split('/');
            string Pagina = PagSplit[PagSplit.GetUpperBound(0)];
            string Autorizado = EasyUtilitario.Helper.Configuracion.Leer("FormsFree", Pagina);
            if ((Autorizado == null) || (Autorizado == "0"))
            {
                EasyErrorControls oEasyErrorControls = new EasyErrorControls();
                oEasyErrorControls.Origen = TargetSite; //ex.TargetSite.Name;
                oEasyErrorControls.Mensaje = Mensaje;
                oEasyErrorControls.Pagina = Pagina;
                oEasyErrorControls.LanzarException("OnLoad");
            }
        }

        protected void btnIconMenu_Click(object sender, EventArgs e)
        {
            HttpRequest ContextRequest = ((System.Web.UI.Page)HttpContext.Current.Handler).Request;
            string Argument = ContextRequest["__EVENTARGUMENT"];
            switch (Argument) {
                case "ReportExploreV2":
                    EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                    
                    oEasyNavigatorBE.Texto = "Explorador de Reportes";
                    oEasyNavigatorBE.Descripcion = "Explorador de reportes";
                    oEasyNavigatorBE.Pagina = "/GestionReportes/"+ Argument + ".aspx";
                    (new PaginaBase()).IrA(oEasyNavigatorBE);
                    break;

            }
        }

    

        public void RegistrarLibs(HtmlHead oPagina, TipoLib oTipoLib, string[,] LibRef,bool Secuencia)
        {
            Type csType = this.GetType();
             ClientScriptManager cs = Page.ClientScript;
            int idxTag = ((oTipoLib == TipoLib.Style) ? 0 : 1);
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
            for (int i = 0; i < LibRef.GetLength(0); i++)
            {
                if (!cs.IsClientScriptBlockRegistered(csType, LibRef[i, 0]))
                {
                    StringBuilder csText = new StringBuilder();
                    csText.Append("<" + TagCtrl[idxTag, 0] + " " + TagCtrl[idxTag, 2] +"=" + cmll + TagCtrl[idxTag, 3] + cmll  + " " + TagCtrl[idxTag, 1] +  "=" + cmll + LibRef[i, 1] + cmll + "> </" + TagCtrl[idxTag, 0]  + ">\n");
                    cs.RegisterClientScriptBlock(csType, LibRef[i, 0], csText.ToString());
                }

            }
        }

        public void RegistrarLibs(HtmlHead oPagina, TipoLib oTipoLib , string[,] LibRef) {
            
            int  idxTag = ((oTipoLib == TipoLib.Style) ? 0: 1);
            try
            {
                if (oPagina != null)
                {
                    switch (oTipoLib)
                    {
                        case TipoLib.Style:
                        case TipoLib.Script:
                            oPagina.Controls.Add(new LiteralControl("\n"));
                            oPagina.Controls.Add(new LiteralControl("<!--Registros de " + TagCtrl[idxTag, 4] + "-->\n"));
                            for (int i = 0; i < LibRef.GetLength(0); i++)
                            {
                                HtmlGenericControl CtrlLib = new HtmlGenericControl(TagCtrl[idxTag, 0]);
                                CtrlLib.Attributes["id"] = LibRef[i, 0];
                                CtrlLib.Attributes[TagCtrl[idxTag, 1]] = LibRef[i, 1];
                                CtrlLib.Attributes[TagCtrl[idxTag, 2]] = TagCtrl[idxTag, 3];
                                oPagina.Controls.Add(CtrlLib);

                                oPagina.Controls.Add(new LiteralControl("\n"));
                            }
                            break;
                        case TipoLib.ScriptFrag:
                            oPagina.Controls.Add(new LiteralControl("<script>\n"));
                            for (int i = 0; i < LibRef.GetLength(0); i++)
                            {
                                oPagina.Controls.Add(new LiteralControl(LibRef[i, 0] + "\n"));
                            }
                            oPagina.Controls.Add(new LiteralControl("</script>\n"));
                            break;
                    }
                }
            }
            catch (Exception ex) { 

            }
         
            /*String csName = "scJQuery";
                Type csType = this.GetType();
                ClientScriptManager cs = Page.ClientScript;

                if (!cs.IsClientScriptBlockRegistered(csType, csName))
                {
                    StringBuilder csText = new StringBuilder();
                    csText.Append("<script type=\"text/javascript\" src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js\"> </script>");
                    cs.RegisterClientScriptBlock(csType, csName, csText.ToString());
                }
                */
        }

    }
}
