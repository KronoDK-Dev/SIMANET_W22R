<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FooterDefault.aspx.cs" Inherits="SIMANET_W22R.FooterDefault" %>

<!DOCTYPE html>

<html django-lang="es">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>



    	

 
	<link href="https://www.marina.mil.pe/static/css/jquery.bxslider.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://www.marina.mil.pe/static/js/fancy-full/lightgallery.css">

	<link href="https://www.marina.mil.pe/static/js/fancy-full/lg-fb-comment-box.css" rel="stylesheet" />
	<link href="https://www.marina.mil.pe/static/js/fancy-full/lg-transitions.css" rel="stylesheet" />




    <link rel="stylesheet" type="text/css" href="https://www.marina.mil.pe/static/css/styles.css?v=001-231130"/>
    <link rel="stylesheet" type="text/css" href="https://www.marina.mil.pe/static/css/bicentenario.css?v=001-231130"/>
	<link rel="stylesheet" type="text/css" href="https://www.marina.mil.pe/static/css/blocks_styl.css?v=001-231130"/>
	
	<link rel="stylesheet" href="https://www.marina.mil.pe/static/css/ccapu.css?v=007-231130">


    <style>
                            .header .wancho {
                                   max-width: 1450px;
                                    width: 100%;
                            }

                            .linkBicentenario{
                                padding: 5px 15px;
                                font-size: 20px;
                                border-radius: 6px;
                                color:#001e38;
                                background-color: #FFA000;
                                }
                            a.linkBicentenario{
                                content: none !important;
                                }
                            a.linkBicentenario:hover{
                                background-color: white;
                                /*color:#001e38;*/
                                }

                            .hLinkInterna a:before {
                                padding-right: 4px;
                                content: none !important;
                                }
                            </style>


</head>
<body>
    <form id="form1" runat="server">
       <footer class="footer">
           <div class="footer-items-top">
               <a href="/es/contacto/" class="f-items-item"><h3>Comunícate con <strong>Nosotros</strong></h3></a>
           </div>
           
           <div class="footer-cnt"><div class="footer-top"><div class="footer-logo">
               <img src="/static/img/footer-logo.png"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;" style="width: auto;" alt="">
            </div>
           <div class="f-items-cnt"><div class="f-item-top f-item1">
               <div class="f-redes"><div class="f-subtitulo"><h3>¡Síguenos <strong>Ahora!</strong></h3></div>
                   <ul class="f-redes-cnt">
                       <li><a class="icon-i-facebook" href="https://www.facebook.com/MGP.Oficial/" target="_blank"></a></li>
                       <li><a class="icon-i-youtube" href="https://www.youtube.com/user/CanalMGPOficial" target="_blank"></a></li>
                       <li><a class="icon-i-twitter" href="https://twitter.com/naval_peru" target="_blank"></a></li>
                       <li><a class="icon-iconos_marina-33" href="https://www.flickr.com/people/marinadeguerradelperu/" target="_blank"></a></li>
                   </ul>
               </div>
               <div class="f-suscribete">
                   <div class="f-subtitulo"><h3>¡Suscribete <strong>Ya!</strong></h3></div>
                       <form action="/forms/suscript/" method="POST" id="wFooterSuscriptContent">
                           <input type="hidden" name="csrfmiddlewaretoken" value="ThnMSJbGPgczw1zmYfMb9n335mZhW216">
                           <input type="text" name="sec_form_id" class="input-form-style" value="nJPzzf93Z2">
                           <input type="text" name="email" class="input-form-style">
                           <div class="f-input">
                               <input type="email" name="correo" placeholder="EMAIL" required="true" class="validate[required,custom[email]]"><button></button>
                           </div>
                       </form>
                   </div>
                </div>
               <div class="f-item-top f-item2">
                   <div class="f-inner-item">
                       <div class="f-sub-item f-naval">
                           <h3>Servicios Industriales de la Marina - SIMA-PERU S.A</h3>
                           <p>Av. de La ContraAlmirante Mora Cdra 36 s/n - La Callao Atención: Lun a Vie de (08:00 a 13:00 y 15:00 a 17:00)</p>
                       </div>
                   </div>
                   <div class="f-inner-item">
                       <div class="f-sub-item f-correo">
                           <h3>Escribenos al:</h3>
                           <a href="mailto:dimar.web@marina.pe">dimar.web@marina.pe</a>
                       </div>
                   </div>
               </div>
               <div class="f-item-top f-item3">
                   <div class="f-inner-item">
                       <div class="f-sub-item f-central">
                           <h3>Central Telefónica</h3>
                           <p><a href="tel:514131100">(01) 413-1100</a></p>
                       </div>
                   </div>
                   <div class="f-inner-item">
                       <a href="/es/wallpapers/" class="f-sub-item f-wallpaper">
                           <h3>Nuestros Servicios</h3>
                           <p>HelpDesk</p>
                       </a>
                   </div>
                   <div class="f-inner-item">
                       <a target="_blank" href="https://reclamos.servicios.gob.pe/?institution_id=103">
                           <img src="https://jahnissi.com.pe/librodereclamaciones.png" width="130" height="140">
                       </a>
                   </div>
               </div>
           </div>
        </div>
       </div><!-- creditos -->
           <section class="footer-copy">
               <div class="footer-copy-cnt">
                    <div class="footer-copy-left">
                       <p> © 2023 Servicios Industriales de La Marina de Guerra del Perú. Todos los derechos Reservados</p>
                    </div>
                    <div class="footer-copy-right"></div>
               </div>
           </section>
      </footer>
    </form>
</body>
</html>
