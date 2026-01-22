<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SIMANET_W22R.Login" %>
<%@ Register TagPrefix="cc1" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>NetSuite</title>
    
    <script>

        // Evitar errores si EasyLoginCard inyecta msgb_None
        if (typeof msgb_None === 'undefined') {
            var msgb_None = function () { return null; };
        }
    </script>
    
    <!-- Estilos Base -->
    <link href="Recursos/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Recursos/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="Recursos/css/jquery-confirm.min.css" rel="stylesheet"/>
    <link href="Recursos/css/StyleEasy.css" rel="stylesheet"/>
    <link href="Recursos/css/sweetalert2.min.css" rel="stylesheet"/>
    
    <!-- Librerias Base -->
    <script src="Recursos/js/jquery.min.js"></script>
    <script src="Recursos/js/jquery-confirm.min.js"></script>
    <script src="Recursos/js/sweetalert2.min.js"></script>
    <script src="Recursos/js/toastr.min.js"></script>
    
    <!-- Libreria SIMA -->
    <script src="Recursos/LibSIMA/Object.js"></script>
    <script src="Recursos/LibSIMA/AccesoDatosBase.js"></script>

    <style>
        .FondoLog2 {
            background-image: url(Recursos/img/FondoLogin.jpg);
            background-repeat: no-repeat;
        }

        #cabecera {
            height: 100vh;
            width: 100%;
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
                Nueva0 = window.open(Dir, '', 'toolbar=no,location=no,directories=no,status=no,menubar=no,'
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
        function Onclickbtn() {
            EasyLoginCard1_ctl19_ToolBar_Onclick({ Id: "btnLogin", Texto: "Aceptar", Descripcion: "", Icono: "", RunAtServer: "True", ClassName: "btn btn-primary", Ubicacion: "Izquierda" });
        }

    </script>

</head>
<body class="FondoLog" onkeydown="KeyEnter();">
    <form id="form1" runat="server">
        <cc1:EasyLoginCard ID="EasyLoginCard1" runat="server" AutenticacionWindows="False" CadenaLDAP="LDAP://simaperu.com.pe" CssClass="padre" ImagenLogo="Recursos/img/escudo.gif" OnValidacion="EasyLoginCard1_Validacion"></cc1:EasyLoginCard>

        <style type="text/css">
            .CardLogin {
                margin-top: 220px;
                /*margin-right: auto;*/
                margin-left: auto;
                /*padding-right: 15px;*/
                padding-left: 405px;
                width: 100%;
                position: absolute;
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
        /*  var index = 0;
          var text = 'Servicios Industriales de la Marina S.A';
          var speed = 50;
      
          function textEffect() {
              if (index < text.length) {
                  document.getElementById("effect")
                      .innerHTML += text.charAt(index);
                  index++;
                  setTimeout(textEffect, speed);
              }
              else {
                  index = 0;
                  document.getElementById("effect").innerHTML = "";
                  setTimeout(textEffect, 1200);
              }
          }
          textEffect();*/

        window.addEventListener('keydown', detectCapsLock)
        window.addEventListener('keyup', detectCapsLock)

        function detectCapsLock(e) {
            if (e.getModifierState('CapsLock')) {
                // caps lock is on 
                //alert('Mayusculas activas');
            } else {
                // caps lock is off
                //alert('Mayusculas desactivada');
            }
        }

        //amximiza la ventana

        //onload = "FullScreenHelper.request(document);"  

    </script>
</body>
<script>
    if (typeof msgb_AlertType === 'undefined') {
        var msgb_AlertType = function () { return null; };
    }
</script>
</html>
