<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarDocTimeLine.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.AdministrarDocTimeLine" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls.Cards" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    

    <style>
       

*,
*:before,
*:after {
	box-sizing: border-box;
}

:root {
	--c-grey-100: #f4f6f8;
	--c-grey-200: #e3e3e3;
	--c-grey-300: #b2b2b2;
	--c-grey-400: #7b7b7b;
	--c-grey-500: #3d3d3d;

	--c-blue-500: #688afd;
}

/* Some basic CSS overrides */
body {
	background-color:white;
	line-height: 1.5;
	min-height: 100vh;
	font-family: "Outfit", sans-serif;
}
	
buttonLT,
input,
select,
textarea {
	font: inherit;
}

a {
	color: inherit;
}
	
/* End basic CSS override */

.timeline {
	width: 85%;
	max-width: 700px;
	margin-left: auto;
	margin-right: auto;
	display: flex;
	flex-direction: column;
	padding: 32px 0 32px 32px;
	border-left: 1px solid var(--c-grey-200);
	font-size: 1.125rem;
}

.Subtimeline {
	width: 85%;
	max-width: 700px;
	margin-left: auto;
	margin-right: auto;
	display: flex;
	flex-direction: column;
	padding: 32px 0 32px 32px;
	border-left: 2px dashed var(--c-grey-200);
	font-size: 1.125rem;
}


.timeline-item {
	display: flex;
	gap: 24px;
	& + * {
		margin-top: 24px;
	}
	& + .extra-space {
		margin-top: 48px;
	}
}

.new-comment {
	width: 100%;
	input {
		border: 1px solid var(--c-grey-200);
		border-radius: 6px;
		height: 48px;
		padding: 0 16px;
		width: 100%;
		&::placeholder {
			color: var(--c-grey-300);
		}

		&:focus {
			border-color: var(--c-grey-300);
			outline: 0; // Don't actually do this
			box-shadow: 0 0 0 4px var(--c-grey-100);
		}
	}
}

.timeline-item-icon {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-left: -52px;
	flex-shrink: 0;
	overflow: hidden;
	box-shadow: 0 0 0 6px #fff;
	svg {
		width: 20px;
		height: 20px;
	}

	&.faded-icon {
		background-color: var(--c-grey-100);
		color: var(--c-grey-400);
	}

	&.filled-icon {
		background-color: var(--c-blue-500);
		color: #fff;
	}
}

.timeline-item-description {
	display: flex;
	padding-top: 6px;
	gap: 8px;
	color: var(--c-grey-400);

	img {
		flex-shrink: 0;
	}
	a {
		color: var(--c-grey-500);
		font-weight: 500;
		text-decoration: none;
		&:hover,
		&:focus {
			outline: 0; // Don't actually do this
			color: var(--c-blue-500);
		}
	}
}

.avatarLT {
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 50%;
	overflow: hidden;
	aspect-ratio: 1 / 1;
	flex-shrink: 0;
	width: 40px;
	height: 40px;
	&.small {
		width: 28px;
		height: 28px;
	}

	img {
		object-fit: cover;
	}
}

.comment {
	margin-top: 12px;
	color: var(--c-grey-500);
	border: 1px solid var(--c-grey-200);
	box-shadow: 0 4px 4px 0 var(--c-grey-100);
	border-radius: 6px;
	padding: 16px;
	font-size: 1rem;
}

.buttonLT {
	border: 0;
	padding: 0;
	display: inline-flex;
	vertical-align: middle;
	margin-right: 4px;
	margin-top: 12px;
	align-items: center;
	justify-content: center;
	font-size: 1rem;
	height: 32px;
	padding: 0 8px;
	background-color: var(--c-grey-100);
	flex-shrink: 0;
	cursor: pointer;
	border-radius: 99em;

	&:hover {
		background-color: var(--c-grey-200);
	}

	&.square {
		border-radius: 50%;
		color: var(--c-grey-400);
		width: 32px;
		height: 32px;
		padding: 0;
		svg {
			width: 24px;
			height: 24px;
		}

		&:hover {
			background-color: var(--c-grey-200);
			color: var(--c-grey-500);
		}
	}
}

.show-replies {
	color: var(--c-grey-300);
	background-color: transparent;
	border: 0;
	padding: 0;
	margin-top: 16px;
	display: flex;
	align-items: center;
	gap: 6px;
	font-size: 1rem;
	cursor: pointer;
	svg {
		flex-shrink: 0;
		width: 24px;
		height: 24px;
	}

	&:hover,
	&:focus {
		color: var(--c-grey-500);
	}
}

.avatarLT-list {
	display: flex;
	align-items: center;
	& > * {
		position: relative;
		box-shadow: 0 0 0 2px #fff;
		margin-right: -8px;
	}
}

    </style>





	<style>

.input,
.textarea {
  border: 1px solid #ccc;
  font-family: inherit;
  font-size: inherit;
  padding: 1px 6px;
}


.textarea {
  display: block;
  width: 100%;
  overflow: hidden;
  resize: both;
  min-height: 40px;
  line-height: 20px;
}

.textarea[contenteditable]:empty::before {
  color: gray;
}

/* Just for demo 
* {
  box-sizing: border-box;
}*/

	</style>

	<style>
		.footerright {
    display: inline-flex;
    align-items: center;
    height: 100%;
    gap: 1rem;
    justify-content: right;
}
.tnlink3 {
    display: inline-flex;
    height: max-content;
    width: max-content;
    justify-content: center;
    align-items: center;
    color: #0007;
    font-size: 1rem;
    background: #fff;
    border: 0;
}

	</style>


	<style>
/* Popup container - can be anything you want */
.popup {
  position: relative;
  display: inline-block;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* The actual popup */
.popup .popuptext {
  visibility: hidden;
  width: 260px;
 /* background-color: #555;
  color: #fff;*/
  text-align: center;
  border-radius: 6px;
  padding: 8px 0;
  position: absolute;
  z-index: 1;
  bottom: 125%;
  left: 50%;
  margin-left: -80px;
  background: url('http://localhost/SIMANET_W22R/Recursos/img/NavTree.jpg');
}

/* Popup arrow */
.popup .popuptext::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

/* Toggle this class - hide and show the popup */
.popup .show {
  visibility: visible;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}

/* Add animation (fade in the popup) */
@-webkit-keyframes fadeIn {
  from {opacity: 0;} 
  to {opacity: 1;}
}

@keyframes fadeIn {
  from {opacity: 0;}
  to {opacity:1 ;}
}
</style>


	<script>
		var cmll = SIMA.Utilitario.Constantes.Caracter.ComillaSimle;

		EasyControl.IconEdit = '	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">'
							+ '			<path fill="none" d="M0 0h24v24H0z"/>'
							+ '			<path fill="currentColor" d="M12.9 6.858l4.242 4.243L7.242 21H3v-4.243l9.9-9.9zm1.414-1.414l2.121-2.122a1 1 0 0 1 1.414 0l2.829 2.829a1 1 0 0 1 0 1.414l-2.122 2.121-4.242-4.242z" />'
							+ '		</svg>';
        EasyControl.IconFlecha = '	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">'
							+ '			<path fill="none" d="M0 0h24v24H0z"/>'
							+ '			<path fill="currentColor" d="M12 13H4v-2h8V4l8 8-8 8z"/>'
							+ '		</svg>'

		EasyControl.IconComent = '';/*'  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">'
							+ '         <path fill="none" d="M0 0h24v24H0z" />'
							+ '         <path fill="currentColor" d="M6.455 19L2 22.5V4a1 1 0 0 1 1-1h18a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H6.455zM7 10v2h2v-2H7zm4 0v2h2v-2h-2zm4 0v2h2v-2h-2z"/>'
							+ '     </svg>';*/




		EasyControl.ITemplateComentLike = function (oLike) {
					var htmlBE = "".toString().BaseSerialized(oLike).toString().Replace(SIMA.Utilitario.Constantes.Caracter.Comilla, SIMA.Utilitario.Constantes.Caracter.ComillaSimle);
            return '         <button type="button" class="buttonLT"><img src="' + oLike.Icono + '" style="width:20px" Data="' + htmlBE + '"/><p style="font-size: 12px;color: gray;">' + oLike.Cantidad + '</p></button>';
		}


		EasyControl.TimeLine = function (_Id) {
			/*Variables de eventos para usus imterno */
			var onClickTB = null;
			var onNewComment = null;
			var onLinkSelect = null;
			/*variables internas*/
			var txtCommetID = null;
			var DatosUsuario = null;
			//var TemplateEditNew = "TemplateEdit" + _Id;
			var TemplateEditNewComent = '';
			var nIdBase = "";
			var Me = this;
			this.Comentarios = new Array();
			this.EditComentario = {};
			this.EditComentario.ToolBar = {};
			this.EditComentario.ToolBar.OnClick = null;
            this.EditComentario.ToolBar.Buttons = new Array();
            this.EditComentario.ToolBar.Button = function (ID, ICONO, COLOR) {
                this.Id = ID;
				this.Icono = ICONO;
				this.Color = COLOR;
			}

            this.EmoticonsCollections = new Array();
            this.EmoticonBE = function (ID, NOMBRE, ICONO) {
				this.Id = ID;
				this.Nombre = NOMBRE;
				this.Icono = ICONO;
			}

			//Evento Seleccion tipo de link
			this.OnLinkSelected = null;


			this.ItemplateComentarioEdit = function (IdComent,IdComentPadre) {
				var ToolCard = ''; btnItems = "";
				//Agrega Boton por defecto
				this.EditComentario.ToolBar.Buttons.Clear();
                var oButton = new oTimeLine.EditComentario.ToolBar.Button("btn_" + IdComent, "fa fa-floppy-o fa-2x", "gray");
                this.EditComentario.ToolBar.Buttons.Add(oButton);

                this.EditComentario.ToolBar.Buttons.forEach(function (obtn, i) {
                    btnItems += '			<div class="btnEditComent_' + _Id + '" id="' + obtn.Id + '"  ContentEdit="' + IdComent + '">  <i  class="' + obtn.Icono + '" style="color: ' + obtn.Color + '; cursor: pointer;"></i></div>';
                });

                ToolCard = '		<div class="footerright" id="tbc_' + IdComent + '">' + btnItems + '		</div>';
                txtCommetID = "txtEdit_" + IdComent;
				TemplateEditNewComent = "TemplateEdit_" + IdComent;

                var strTemplate = '<li class="timeline-item" id="' + TemplateEditNewComent + '" >'
                    + '		<span class="timeline-item-icon | avatarLT-icon">'
                    + '			<i class="avatarLT">'
                    + '				<img src="' + this.Usuario.Foto + '" style="max-width: 100%;"/>'
                    + '			</i>'
                    + '		</span>'
                    + '		<table style="width:100%">'
                    + '			<tr>'
                    + '				<td style="width:100%">'
                    + '					<div class="new-comment">'
                    + '						<textarea id="' + txtCommetID + '"  IdComentPadre="' + IdComentPadre + '"  placeholder="Adiconar comentario..."  class="textarea resize-ta"></textarea>'
                    + '					</div>'
                    + '				</td>'
                    + '			</tr>'
                    + '			<tr>'
                    + '				<td style="width:200px" align="right">'
                    + ToolCard
                    + '				</td>'
                    + '			</tr>'	
                    + '		</table>'
					+ ' </li> ';
				return strTemplate.toString().HtmlToDOMobj();
			}

            function getListaProbadores(_ItemBE) {
                var strHtmlLstAProb = ""; NroProba = 0;
                if (_ItemBE.ListaAprobados.length > 0) {
                    _ItemBE.ListaAprobados.forEach(function (ItemAprobador, i) {
                        strHtmlLstAProb += ' <i class="avatarLT | small">'
                            + '		<img src="https://assets.codepen.io/285131/hat-man.png" style="max-width: 100%;"/>'
                            + '  </i>';
                        NroProba = (i + 1);
                    });
                    return { Nro: 'Show ' + NroProba + 'replies', HtmlLst: '         <span class="avatarLT-list">' + strHtmlLstAProb + '         </span>' };
                }
                else {
                    return { Nro: '', HtmlLst: '' };
                }
            }
            function getListaLikes(_ItemBE) {
                var strHtmlLikes = "";
				_ItemBE.ListaLikes.forEach(function (oLike, l) {
                    strHtmlLikes += EasyControl.ITemplateComentLike(oLike);
				});
                return strHtmlLikes;
			}

			this.ItemplateComentario = function (IconoBase, oItemBE) {
                var IdContent = "c_" + oItemBE.Id;
                var DataAprobadores = getListaProbadores(oItemBE);
                var HtmlLikes = getListaLikes(oItemBE);
				var SerializedData = "";
				var htmlEmoticon = "";
				Me.EmoticonsCollections.forEach(function (oEmoticonBE, e) {//Coleccion de emoticones dispnibles para calificar a los comentarios
                    htmlEmoticon += '<td><img class="EmoOption" src="' + oEmoticonBE.Icono + '" Data="' + "".toString().BaseSerialized(oEmoticonBE).Replace(SIMA.Utilitario.Constantes.Caracter.Comilla, SIMA.Utilitario.Constantes.Caracter.ComillaSimle) + '" style="width:30px;padding-left: 5px;" /></td>';
				});

                //Replica de la clase  [EasyControl.TLItem]
                SerializedData = "{ Id:'" + oItemBE.Id + "', Foto:'" + oItemBE.Foto + "',Nombres: '" + oItemBE.Nombres + "', Comentario: '" + oItemBE.Comentario.toString().Replace("'", "") + "', FechaShort: '" + oItemBE.FechaShort + "', FechaLarge: '" + oItemBE.FechaLarge + "', Tipo: '" + +oItemBE.Tipo + "',ListaLikes:''}";

                var strTemplate = '<li class="timeline-item | extra-space" id="' + IdContent + '"  Data="' + SerializedData + '" >'
                    + ' <span class="timeline-item-icon | filled-icon">'
                    + IconoBase
                    + ' </span>'
                    + ' <div class="timeline-item-wrapper">'
                    + '     <div class="timeline-item-description">'
                    + '         <i class="avatarLT | small">'
                    + '             <img src="' + oItemBE.Foto + '" style="max-width: 100%;"/>'
                    + '         </i>'
                    + '         <span><a href="#">' + oItemBE.Nombres + '</a> comentado en <time datetime="' + oItemBE.FechaShort + '">' + oItemBE.FechaLarge + '</time></span>'
                    + '     </div>'
                    + '     <div class="comment">'
                    + '         <p>' + oItemBE.Comentario + '</p>'
                    + '			<table style="width: 100%;">'
                    + '				<tr>'
                    + '					<td id="ItemAllLikes_' + oItemBE.Id + '">'
                    + HtmlLikes
                    + '					</tr>'
                    + '				</tr>'
                    + '				<tr>'
					+ '					<td id="Like_' + oItemBE.Id + '"  class="LinkBaseOP' + _Id + '" align="left"  style="font-size: 12px;color: gray; vertical-align: center;cursor:pointer;" >'
					+ '						<div class="popup" >'
                    + '							<img  src="' + SIMA.Utilitario.Constantes.ImgDataURL.MeGusta + '" style="width:20px"/>  Me gusta'
                    + '							<span class="popuptext" id="LikePopup_' + oItemBE.Id + '"><table> <tr DataIDComent="' + oItemBE.Id + '" >' + htmlEmoticon + '</tr></table></span>'
                    + '						</div>'
                    + '					</tr>'
                    + '				</tr>'
                    + '			</table>'
                    + '		</div>'
                    + '		<button class="show-replies" id="btnRP_' + oItemBE.Id + '" SubOL="SubC' + oItemBE.Id + '"  type="button" >'
                    + '         <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-forward" width="44" height="44" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    + '             <path stroke="none" d="M0 0h24v24H0z" fill="none"/>'
                    + '             <path d="M15 11l4 4l-4 4m4 -4h-11a4 4 0 0 1 0 -8h1"/>'
                    + '         </svg>'
                    + DataAprobadores.Nro
                    + DataAprobadores.HtmlLst
                    + '     </button>'
                    + ' 	<ol id="SubC' + oItemBE.Id + '"  >'
                    + ' 	</ol>'
                    + '		</div>'
					+ ' </li>';
				
                return strTemplate.toString().HtmlToDOMobj();
            }



            this.Render = function (Content) {
                nIdBase = 'Content_' + _Id;
				var htmlBase = '<ol class="timeline" id="' + nIdBase + '"></ol>';

                var oTLBase = jNet.get(htmlBase.toString().HtmlToDOMobj());
				jNet.get(Content).insert(oTLBase);
				//Inserta la primera line para edicion de los nuevos comentarios
                var TemplateCommentEdit = this.ItemplateComentarioEdit(nIdBase,"0");
                oTLBase.insert(TemplateCommentEdit);
				//Carga LOs Comentarios y subContearios anteriores
				Me.Comentarios.forEach(function (ItemComment, p) {
					var ObjItem = jNet.get(Me.ItemplateComentario(EasyControl.IconComent, ItemComment));
					oTLBase.insert(ObjItem);
                    if (ItemComment.SubComentarios.length > 0) {
                        SubComentarios(ItemComment);
					}
				});

				//etablece el evento click a una variable local para que pueda ser accedido
				onClickTB = this.EditComentario.ToolBar.OnClick;
				onNewComment = this.NewComentario;
				onLinkSelect = this.OnLinkSelected;
				//variables internas
				DatosUsuario = this.Usuario;

				//Asigna eventos aControles Internos
				/*------------------------------------------------------------------------------------------------------------------------*/
				this.EventAttach_SaveComentario = function () {
					[].slice.call(document.getElementsByClassName('btnEditComent_'+_Id)).forEach(function (ctrlBtn, i) {
						var oBtn = jNet.get(ctrlBtn);
						var IdOlContentEdit = oBtn.attr("ContentEdit");
						oBtn.addEvent("click", function () {
							var MeBtn = this;
							var otxtEditComent = jNet.get("txtEdit_" + IdOlContentEdit);
                            var strHtmlComent = otxtEditComent.value.toString().Replace('\n', '<br>');
							//var IdBtn = this.id;
							//Por ahora se usuara con el boton SAVE
							//...........................................................
							if (strHtmlComent.length == 0) {
								var msgConfig = { Titulo: "COMENTARIOS", Descripcion: "No se ha ingresado comentario!!!" };
								var oMsg = new SIMA.MessageBox(msgConfig);
								oMsg.Alert();
								return;
							}
							//...........................................................
							if (onClickTB == null) {// valida si si tiene asociado una funcion
								var msgConfig = { Titulo: "Error Asociar eventos", Descripcion: '[TimeLine].EditComentario.ToolBar.OnClick no tiene evento asociado<br>Crear un evento o funcion  y que devuelva un IDreg yluego asociarlo' };
								var oMsg = new SIMA.MessageBox(msgConfig);
								oMsg.Alert();
								return;
							}
							//...........................................................

							var ConfigMsgb = {
								Titulo: 'GRABAR COMENTARIO'
								, Descripcion: "Desea grabar el comentario ahora?"
								, Icono: 'fa fa-question-circle'
								, EventHandle: function (btn) {
									if (btn == 'OK') {
										//Obtener txtIdcoemntario

                                        var idRegComent = onClickTB(MeBtn, strHtmlComent, otxtEditComent.attr("IdComentPadre"));
										if ((idRegComent == undefined) || (idRegComent.length == 0)) {
											var msgConfig = { Titulo: "Error Asociar eventos", Descripcion: 'Se esperaba un valor, la funcion asociada a<br> [TimeLine].EditComentario.ToolBar.OnClick<br> no esta retornando un valor valido' };
											var oMsg = new SIMA.MessageBox(msgConfig);
											oMsg.Alert();
											return;
										}

										var oItem = new EasyControl.TLItem();
										oItem.Id = idRegComent;
										oItem.Foto = DatosUsuario.Foto;
										oItem.Nombres = DatosUsuario.ApellidosyNombres;
										oItem.Comentario = strHtmlComent;
										oItem.FechaShort = SIMA.Utilitario.Helper.Fecha.Hoy('-');
										oItem.FechaLarge = SIMA.Utilitario.Helper.Fecha.Hoy('-');
										oItem.Tipo = 4;

										onNewComment("TemplateEdit_" +IdOlContentEdit,oItem);//Inserta el comentario en lña linea de tiempo
                                        otxtEditComent.value = '';

										Me.EventAttach_ShowPopup();
									}
								}
							};
							var oMsg = new SIMA.MessageBox(ConfigMsgb);
							oMsg.confirm();


						});
                    
					});
                }
				/*------------------------------------------------------------------------------------------------------------------------*/
				//todos los botones de seleccion de links que existas con dicho nombre clase
				this.EventAttach_ShowPopup=function() {
                    [].slice.call(document.getElementsByClassName("popup")).forEach(function (opLinks, l) {

                        var oBtnLink = jNet.get(opLinks);
                        oBtnLink.addEvent("click", function () {
                            var p = this.children[1];
                            var popup = document.getElementById(p.id);
                            popup.classList.toggle("show");//Muestra los emoticones disponibles para su seleccion
                        });
                    });
				}

				this.EventAttach_ItemAllLikes = function () {
                    [].slice.call(document.getElementsByClassName("EmoOption")).forEach(function (opLinks, l) {
                        var oBtnLink = jNet.get(opLinks);
						oBtnLink.addEvent("click", function () {
							var Yo = jNet.get(this);
							var _EmoticonSeleccionadoBE = Yo.attr("Data").toString().SerializedToObject();
							
							var IdComent = jNet.get(this.parentNode.parentNode).attr('DataIDComent');
                            var oItemComentMetaData = jNet.get('c_' + IdComent).attr("Data").toString().SerializedToObject();//Obtene la estructura del Item comentario de la metadata
							var oItemComentBE = new EasyControl.TLItem();
								oItemComentBE.Id = oItemComentMetaData.Id;
								oItemComentBE.Foto = oItemComentMetaData.Foto;
								oItemComentBE.Nombres = oItemComentMetaData.Nombres;
								oItemComentBE.Comentario = oItemComentMetaData.Comentario.toString().Replace("'", "");
								oItemComentBE.FechaShort = oItemComentMetaData.FechaShort;
								oItemComentBE.FechaLarge = oItemComentMetaData.FechaLarge;
								oItemComentBE.Tipo = oItemComentMetaData.Tipo;

							var oLinkeds = jNet.get('ItemAllLikes_' + IdComent);
							oLinkeds.forEach(function (ItemBtn, c) {//Obtiene la Lista de reaciones del comentario seleccionado
								var oImg = jNet.get(ItemBtn.children[0]);
								var oParrafo = ItemBtn.children[1];
								var ReaccionBE = oImg.attr('Data').toString().SerializedToObject();
								oItemComentBE.ListaLikes.Add(ReaccionBE);
							});
								
                            if (onLinkSelect != null) {
								if (onLinkSelect(oItemComentBE, _EmoticonSeleccionadoBE) == true) {//Si es aprobada la seleccion agragar a la colleccion de Likes de  comentario seleccionado
									var strHtmlLikes = "";
									var Encontrado = false;
										oItemComentBE.ListaLikes.forEach(function (oLike, l) {
											if (oLike.IdTipo == _EmoticonSeleccionadoBE.Id) {//Incrementa segun el retorno si es true
												oLike.Cantidad++;
                                                Encontrado = true;
											}
                                            strHtmlLikes += EasyControl.ITemplateComentLike(oLike);
										});
									
                                    if ((oItemComentBE.ListaLikes.length == 0) || (Encontrado==false)) {
									//Agrega el Linked seleccionado para este comentario
                                        var oLike = new oItemComentBE.ReaccionesBE();
											oLike.IdTipo = _EmoticonSeleccionadoBE.Id;
											oLike.Icono = _EmoticonSeleccionadoBE.Icono;
											oLike.Cantidad = '1';
											oItemComentBE.ListaLikes.Add(oLike);
                                        strHtmlLikes += EasyControl.ITemplateComentLike(oLike);
									}

									oLinkeds.clear();
									oLinkeds.innerHTML = strHtmlLikes;
								}
							}
							
                        });


                    });
				}

				this.EventReply_ItemAll = function () {
					[].slice.call(document.getElementsByClassName("show-replies")).forEach(function (obtnReply, r) {
						var obtn = jNet.get(obtnReply);
						obtn.addEvent("click", function () {
							var Yo = jNet.get(this);
							var IdSubOL = Yo.attr("SubOL");
							var SubOL = jNet.get(IdSubOL);
                            var IdItemComent = IdSubOL.toString().Replace("SubC", "");
							if (document.getElementById("TemplateEdit_" + IdItemComent) == undefined) { 
								var objContentEdit = Me.ItemplateComentarioEdit(IdItemComent, IdItemComent);
                                SubOL.insert(objContentEdit);
                                SubOL.insertBefore(objContentEdit, SubOL.children[0]);//Reubica a la pocision Cero
								Me.EventAttach_SaveComentario();
							}
							Yo.css("visibility", "hidden");
						});
					});
				}

                /*------------------------------------------------------------------------------------------------------------------------*/

				//Asigna Los eventos a los elementos de los comentarios
				this.EventAttach_SaveComentario();
                this.EventAttach_ShowPopup();
				this.EventAttach_ItemAllLikes();
				this.EventReply_ItemAll();

				/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

                
               
			}

            function SubComentarios(oSubITem) {
                var IdSubComm = 'SubC' + oSubITem.Id;
                var ContentSubComment = jNet.get(IdSubComm);
                oSubITem.SubComentarios.forEach(function (oItemSubComment, p) {
                    ContentSubComment.insert(jNet.get(Me.ItemplateComentario(EasyControl.IconComent, oItemSubComment)));
                    if (oItemSubComment.SubComentarios.length > 0) {
                        SubComentarios(oItemSubComment);
                    }
                });
			}

			this.NewComentario = function (IdOlContect,oItemComent) {
                var OlContentComent = jNet.get(IdOlContect);
                OlContentComent.insertAdjacentHTML("afterend", Me.ItemplateComentario(EasyControl.IconComent, oItemComent).outerHTML);

				Manager.Task.Excecute(function () {
														Me.EventAttach_ItemAllLikes();
													}, 1000,true);

			}
			
			this.Usuario = {};
			this.Usuario.Id = null;
			this.Usuario.ApellidosyNombres = null;
			this.Usuario.Foto = null;
		}
		
		
		EasyControl.TLItem = function (ID, FOTO, NOMBRES, COMENTARIO, FECHASHORT, FECHALARGE, HTMLCONTENIDO, TIPO) {
			var Me = this;
			this.Id = ID;
			this.Data = null;
			this.Foto = FOTO;
			this.Nombres = NOMBRES;
			this.Comentario = COMENTARIO;
			this.FechaShort = FECHASHORT;
			this.FechaLarge = FECHALARGE;
			this.Tipo = TIPO;
            this.ListaLikes = new Array()
			this.ListaAprobados = new Array()
			this.SubComentarios = new Array();
            this.ReaccionesBE = function (TIPO, ICONO, CANTIDAD) {
				this.IdTipo = TIPO;
				this.Icono = ICONO;
				this.Cantidad = CANTIDAD;
			}

		}
	
    </script>
	







</head>
<body>
	<!--demo mcard  https://freefrontend.com/css-cards/
		https://www.bootdey.com/snippets/view/events-card-widget
		-->
	 <form id="form1" runat="server">
			<div class="container py-5" style="padding-left:17px;padding-top:-10px;">
				<div class="row justify-content-center">
					<div class="card shadow-sm mb-4" style="width:100%">
					   <div class="card-body" id="Contenedor" runat="server">
								

					   </div>
					</div>
				</div>
			</div>			

		 
	</form>
		




	<script>
		//Tab de control de cambios
        var oTabSelected = EasyTabControlCambio.TabActivo;
		
		AdministrarDocTimeLine.Data = {};
		AdministrarDocTimeLine.Data.LstReacciones = function (IdComentario) {
			 var oEasyDataInterConect = new EasyDataInterConect();
				oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
				 oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
				 oEasyDataInterConect.Metodo = "ActividaDocumentacionReaccion_Listar";

			var oParamCollections = new SIMA.ParamCollections();
			var oParam = new SIMA.Param("IdDocumentacion", IdComentario);
				 oParamCollections.Add(oParam);
 
				 oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
				 oParamCollections.Add(oParam);
				 oEasyDataInterConect.ParamsCollection = oParamCollections;
           
            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
		}

		AdministrarDocTimeLine.Data.ListarComentariosXTipo = function (IdPadre) {
			

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
            oEasyDataInterConect.Metodo = "ActividadDocumentacion_Listar";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdActividad", AdministrarDocTimeLine.Params[AdministrarDocTimeLine.KEYIDACTIVIDAD]);
			oParamCollections.Add(oParam);
			
            oParam = new SIMA.Param("IdTipoDoc", oTabSelected.Params[AdministrarDocTimeLine.KEYIDTIPODOCUM]);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdPadre", IdPadre);
            oParamCollections.Add(oParam);
            
            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
		}

		AdministrarDocTimeLine.LoadComentario = function () {
            AdministrarDocTimeLine.Data.ListarComentariosXTipo("0").Rows.forEach(function (oDataRow, f) {
																							var DataBE = "".Serialized(oDataRow, true);
																								oItem = new EasyControl.TLItem();
																								oItem.Id = DataBE.ID_DOC;
																								oItem.Foto = GlobalEntorno.PathFotosPersonal + DataBE.NRODOCDNI + ".jpg";
																								oItem.Nombres = DataBE.APELLIDOSYNOMBRES;
																								oItem.Comentario = DataBE.DESCRIPCION;
																								oItem.FechaShort = DataBE.FECHA_ADD;
																								oItem.FechaLarge = DataBE.FECHA_ADD;
																								oItem.Tipo = 4;
																								//Carga de reacciones 
																								AdministrarDocTimeLine.Data.LstReacciones(DataBE.ID_DOC).Rows.forEach(function (oDR, fc) {
																									var oItemReac = new oItem.ReaccionesBE();
																									oItemReac.IdTipo = oDR.IDTIPOREAC;
																									oItemReac.Icono = oDR.ICONO;
																									oItemReac.Cantidad = oDR.CANT;
																									oItem.ListaLikes.Add(oItemReac);
																								});
																								if (parseInt(DataBE.NROHIJOS) > 0) {
																									oTimeLine.Comentarios.Add(oItem);
																									AdministrarDocTimeLine.LoadSubComentario(oItem);
																								}
																								else {
                                                                                                    oTimeLine.Comentarios.Add(oItem);
																								}
																								
																							                                                                                    
																						});
		}
		AdministrarDocTimeLine.LoadSubComentario = function (oItemPadre) {
			AdministrarDocTimeLine.Data.ListarComentariosXTipo(oItemPadre.Id).Rows.forEach(function (oDataRow, f) {
																					var DataBE = "".Serialized(oDataRow, true);
																					oItem = new EasyControl.TLItem();
																					oItem.Id = DataBE.ID_DOC;
																					oItem.Foto = GlobalEntorno.PathFotosPersonal + DataBE.NRODOCDNI + ".jpg";
																					oItem.Nombres = DataBE.APELLIDOSYNOMBRES;
																					oItem.Comentario = DataBE.DESCRIPCION;
																					oItem.FechaShort = oItem.FECHA_ADD;
																					oItem.FechaLarge = oItem.FECHA_ADD;
																					oItem.Tipo = 4;
																					//Carga Los comentarios
																					AdministrarDocTimeLine.Data.LstReacciones(DataBE.ID_DOC).Rows.forEach(function (oDR, fc) {
																																					var oItemReac = new oItem.ReaccionesBE();
																																					oItemReac.IdTipo = oDR.IDTIPOREAC;
																																					oItemReac.Icono = oDR.ICONO;
																																					oItemReac.Cantidad = oDR.CANT;
																																					oItem.ListaLikes.Add(oItemReac);
																					});
																					oItemPadre.SubComentarios.Add(oItem);
																					if (parseInt(DataBE.NROHIJOS) > 0) {
                                                                                       AdministrarDocTimeLine.LoadSubComentario(oItem);
																					}
																					
																					//oTimeLine.Comentarios.Add(oItem);
																						/*oItem.ListaLikes = new Array()
																						  oItem.ListaAprobados */

																				});

		}


		AdministrarDocTimeLine.Data.GuardarComentario = function (oBtn, Comentario,IdComentPadre) {		
				var oParamCollections = new SIMA.ParamCollections();
				var oParam = new SIMA.Param("IdDocumento", "0");
						oParamCollections.Add(oParam);
					oParam = new SIMA.Param("IdDocPadre", IdComentPadre);
						oParamCollections.Add(oParam);
					oParam = new SIMA.Param("IdActividad", AdministrarDocTimeLine.Params[AdministrarDocTimeLine.KEYIDACTIVIDAD]);
						oParamCollections.Add(oParam);
			//oParam = new SIMA.Param("IdTipoDoc", AdministrarDocTimeLine.Params[AdministrarDocTimeLine.KEYIDTIPODOCUM], TipodeDato.Int);
					oParam = new SIMA.Param("IdTipoDoc", oTabSelected.Params[AdministrarDocTimeLine.KEYIDTIPODOCUM], TipodeDato.Int);
						oParamCollections.Add(oParam);
					oParam = new SIMA.Param("Descripcion", Comentario);
						oParamCollections.Add(oParam);
					oParam = new SIMA.Param("IdPersonal", UsuarioBE.CodPersonal);
						oParamCollections.Add(oParam);
					oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
						oParamCollections.Add(oParam);
					oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
						oParamCollections.Add(oParam);
      
					var oEasyDataInterConect = new EasyDataInterConect();
					oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
					oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
					oEasyDataInterConect.Metodo = 'ActividaComentarios_InsAct';
					oEasyDataInterConect.ParamsCollection = oParamCollections;

					var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
					var ResultBE = oEasyDataResult.sendData().toString().SerializedToObject();
			
            return ResultBE.IdOut;
		}
    </script>


	<script>

		var strData = oTabSelected.attr("Data").toString().Replace(SIMA.Utilitario.Constantes.Caracter.Comilla, SIMA.Utilitario.Constantes.Caracter.ComillaSimle);
        var TabDataBE = strData.SerializedToObject();
        EasyControl.IconComent = TabDataBE.CMEDIA.toString().Replace('|', SIMA.Utilitario.Constantes.Caracter.ComillaSimle);

        var oTimeLine = new EasyControl.TimeLine("TimeLineBase_" + oTabSelected.Params[AdministrarDocTimeLine.KEYIDTIPODOCUM]);
			oTimeLine.Usuario.Id = 86;
			oTimeLine.Usuario.Foto = GlobalEntorno.PathFotosPersonal + UsuarioBE.NroDocumento + ".jpg";
			oTimeLine.Usuario.ApellidosyNombres = UsuarioBE.ApellidosyNombres;
		AdministrarDocTimeLine.LoadComentario();
		//var oButton = new oTimeLine.EditComentario.ToolBar.Button("Print", "fa fa-print", "red");
		//		oTimeLine.EditComentario.ToolBar.Buttons.Add(oButton);
		oTimeLine.OnLinkSelected = function (oItemBE, oEmoticonBE) {
			//Almacena en la BD el nuevo valor de link			
			return true;// autiriza al control  agregar o incrementar el conteo de likes del comentaio
		}

		//Asocia el evento click con un evento externo
        oTimeLine.EditComentario.ToolBar.OnClick = AdministrarDocTimeLine.Data.GuardarComentario;

		//Carga La Lista de Emotiocones a usar
		SIMA.Utilitario.Helper.TablaGeneralItem(61, 0, 'OracleDB').Rows.forEach(function (oRow,r) {
            var oEmoticonBE = new oTimeLine.EmoticonBE();
			oEmoticonBE.Id = oRow.CODIGO;
			oEmoticonBE.Nombre = oRow.NOMBRE;
            oEmoticonBE.Icono = oRow.CMEDIA;
			oTimeLine.EmoticonsCollections.Add(oEmoticonBE);
		});
		
        oTimeLine.Render("contentTime_"+ oTabSelected.Params[AdministrarDocTimeLine.KEYIDTIPODOCUM]);

		
      

    </script>


	<script>
        function calcHeight(value) {
            let numberOfLineBreaks = (value.match(/\n/g) || []).length;
            let newHeight = 20 + numberOfLineBreaks * 20 + 12 + 2;
            return newHeight;
        }

        var textarea = document.querySelector(".resize-ta");
        textarea.addEventListener("keyup", () => {
            textarea.style.height = calcHeight(textarea.value) + "px";
        });
    </script>

</body>
</html>
