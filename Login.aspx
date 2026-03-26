<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SIMANET_W22R.Login" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>


      <!--estilos base-->
    <link href="Recursos/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Recursos/css/font-awesome.min.css" rel="stylesheet"/>
    
    <!--Librria Base-->
    <script src="Recursos/LibSIMA/util-deps.js"></script>
    <script src="Recursos/Js/jquery.min.js"></script>
    
    <!-- ***************************************************************************************************** -->
    <link href="Recursos/css/jquery-confirm.min.css" rel="stylesheet" />
    <script src="Recursos/Js/jquery-confirm.min.js"></script>
    <!-- ***************************************************************************************************** -->
   
    <link href="Recursos/css/StyleEasy.css" rel="stylesheet" />
    
    <script>
        // Bootstrap del namespace SIMA (y ramas usadas por la base)
        window.SIMA = window.SIMA || {};
        SIMA.Data = SIMA.Data || {};
    </script>

    <script>
        // sima-bootstrap: crea y congela SIMA para que no lo sobreescriban
        (function (w) {
            "use strict";

            // 1) Bootstrap de SIMA y ramas usadas por la base
            if (!w.SIMA) w.SIMA = {};
            if (!w.SIMA.Data) w.SIMA.Data = {};

            // 2) Congelar las referencias de nivel superior para evitar "var SIMA = new Object()"
            try {
                Object.defineProperty(w, 'SIMA', {
                    value: w.SIMA,
                    writable: false,        // ← clave: impide reasignación global
                    configurable: false,
                    enumerable: true
                });
            } catch (_) { }

            try {
                Object.defineProperty(w.SIMA, 'Data', {
                    value: w.SIMA.Data,
                    writable: false,        // ← idem para SIMA.Data
                    configurable: false,
                    enumerable: true
                });
            } catch (_) { }

            // (opcional) Page mínimo para que llamadas de config no colapsen en login
            w.Page = w.Page || { Request: { ApplicationPath: "", Params: {} } };
        })(window);
    </script>

    <script src="Recursos/LibSIMA/ScriptManager.js"></script>
    <script src="Recursos/LibSIMA/EasyDataInterConect.js"></script> <!-- BASE SIMA (aquí se declaran SIMA.Param y SIMA.ParamCollections) -->
    <script src="Recursos/LibSIMA/Objetcs.js"></script>
    <script src="Recursos/LibSIMA/MasterConfig.js"></script>
    <script src="Recursos/LibSIMA/AccesoDatosBase.js"></script>

    <script src="Recursos/Js/full-screen-helper.min.js"></script>

    <style>
        .FondoLog2 {
            background-image: url(Recursos/img/FondoLogin.jpg);
             background-repeat: no-repeat;       
        }


        #cabecera {
          height : 100vh;
          width:100%;
          min-height: 400px;
          text-align: center;
          color: #fff;
          background-image: url(Recursos/img/FondoLogin.jpg);
          background-repeat: no-repeat;
          background-position: center;
          background-size: cover;
        }


    </style>

    <script>

        function fullscreen() {
           if (window.location.search.indexOf("realwindow") == -1) {
                Vieja0 = window.self;
                Vieja0.opener = window.self;
                Ancho = screen.availWidth;
                Alto = screen.availHeight;
                Dir = window.location + "?realwindow=1";
                Nueva0 = window.open(Dir, '','toolbar=no,location=no,directories=no,status=no,menubar=no,' 
                    + 'scrollbars=1,resizable=no,copyhistory=1,channelmode=1,fullscreen=1 ,width=' + Ancho + ',' 
                                            + 'height=' + Alto + ',top=0,left=0', 'replace');
                Vieja0.close();
                
            }

            var el = document.documentElement;
            var rfs = // for newer Webkit and Firefox
                el.requestFullScreen
                || el.webkitRequestFullScreen
                || el.mozRequestFullScreen
                || el.msRequestFullScreen
                ;
        }

        function KeyEnter() {
            if (event.keyCode == 13) {

                // EasyLoginCard1_ctl19_ToolBar_Onclick({ Id: 'btnLogin', Texto: 'Aceptar', Descripcion: '', Icono: '', RunAtServer: 'True', ClassName: 'btn btn-primary', Ubicacion: 'Izquierda' });
                //  window.setTimeout(Onclickbtn(), 1000);
                //  __doPostBack('EasyLoginCard1$ctl19$CmdCommit', "btnLogin");
                //__doPostBack('EasyLoginCard1$ctl19$CmdCommit', '');

                $('EasyLoginCard1_ctl19_CmdCommit').click();

                
            }
        }
        function Onclickbtn(){
            EasyLoginCard1_ctl19_ToolBar_Onclick({ Id: "btnLogin", Texto: "Aceptar", Descripcion: "", Icono: "", RunAtServer: "True", ClassName: "btn btn-primary", Ubicacion: "Izquierda" });
        }

    </script>
   

</head>
<body  class="FondoLog" onkeydown="KeyEnter();">
    <form id="form1" runat="server">
        <cc1:EasyLoginCard ID="EasyLoginCard1" runat="server" AutenticacionWindows="False" CadenaLDAP="LDAP://simaperu.com.pe" CssClass="padre" ImagenLogo="Recursos/img/escudo.gif" OnValidacion="EasyLoginCard1_Validacion" ></cc1:EasyLoginCard>
           
        
    <style type="text/css">
           .CardLogin  {
               margin-top: 220px;
                /*margin-right: auto;*/
                margin-left: auto;
                /*padding-right: 15px;*/
                padding-left: 405px;
                width: 100%;
                position:absolute;
            }
       


     </style>
     <cc1:EasyClockDigital ID="EasyClockDigital1" runat="server" />
 
   <section id="cabecera">
      <div class="contenedor">
          <h1>SIMA PERU S.A</h1>
        <h1>Profesionales en la Industria Naval y Metal Mecanica</h1>
        <p>tecnología de Desarrollo Web.</p>
      </div>
    </section>

   
    </form>
 
   
<script>
    // Elige el/los inputs donde quieres detectar CapsLock (recomendado)
    const targets = [
        document.getElementById('txtUsuario'),
        document.getElementById('txtPassword')
    ].filter(Boolean);

    // Si no tienes ids, puedes mantener window:
    const sources = targets.length ? targets : [window];

    function detectCapsLock(e) {
        // Normaliza: puede venir de window, input, etc.
        e = e || window.event;

        // 1) Camino feliz: API estándar si existe
        let isCapsOn = false;
        if (typeof e.getModifierState === 'function') {
            isCapsOn = e.getModifierState('CapsLock');
        } else {
            // 2) Fallback: deducción por letra + Shift
            const k = e.key || '';
            const isLetter = k.length === 1 && k.toLowerCase() !== k.toUpperCase();
            if (isLetter) {
                const isUpper = (k === k.toUpperCase() && k !== k.toLowerCase());
                const isShift = !!e.shiftKey;
                // mayúscula sin Shift OR minúscula con Shift => Caps ON
                isCapsOn = (isUpper && !isShift) || (!isUpper && isShift);
            } else {
                // No es letra, no inferimos cambio
                return;
            }
        }

        // 3) Muestra/oculta tu aviso (ajusta a tu UI)
        const aviso = document.getElementById('capsLockWarning');
        if (aviso) {
            aviso.style.display = isCapsOn ? 'block' : 'none';
            aviso.textContent = isCapsOn ? '¡Bloq Mayús activado!' : '';
        } else {
            // Si prefieres alert/console por ahora:
            // if (isCapsOn) console.log('Bloq Mayús activado');
        }
    }

    // Adjunta listeners
    sources.forEach(src => {
        src.addEventListener('keydown', detectCapsLock, false);
        src.addEventListener('keyup', detectCapsLock, false);
    });
</script>
<!-- Un pequeño placeholder para el aviso -->
<div id="capsLockWarning" style="display:none;color:#c00;font-weight:600;margin-top:.25rem;"></div>
</body>
   
</html>
