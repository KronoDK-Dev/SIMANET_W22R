<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaTrabajadorEnFeriado.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.ListaTrabajadorEnFeriado" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>
<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   

	<script>
		 function onDisplayTemplateAutoiza(ul, item) {
			 var cmll = "\""; var iTemplate = null;
				 iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
					 + '<div class= "flex-column">' + item.Nombres
					 + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red">' + item.NroPersonal + '</small>'
					 + '    <small style="font-weight: bold">AREA:</small><small style="color:blue;text-transform: capitalize;">' + item.NombreArea + '</small></p>'
					 + '    <span class="badge badge-info "> ' + item.Email + '</span>'
					 + '</div>'
					 + '<div class="image-parent">'
                     + '<img class=" rounded-circle" width="60px" src="' + ListaTrabajadorEnFeriado.PathFotosPersonal + item.NroDocIdentidad + '.jpg"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
					 + '</div>'
					 + '</a>';

             var oCustomTemplateBE = new acJefe.CustomTemplateBE(ul, item, iTemplate);

             return acJefe.SetCustomTemplate(oCustomTemplateBE);
		}
        function onItemAutorizaSeleccionado(value, ItemBE) {

		}



    </script>
	<style>
		.BaseItemInGrid
		{
			border:1px dotted #99bbe8;
			MARGIN-TOP: 5px;
			background:#dfe8f6;
			color: #15428b;
			cursor:default;
			font:11px tahoma,arial,sans-serif;	
			height:30px;
		}
			.BaseItemInGrid td {
				padding-left:10px;
			}
	</style>
</head>
<body>
    <form id="form1" runat="server">
			


		<table border="0" style="width:100%">
			<tr>
				<td style="display:none">
					 <uc1:Header runat="server" ID="Header" />
				</td>
				<td></td>
			</tr>
			<tr>
				<td style="padding-left: 10px;" class="Etiqueta" >AUTORIZAD POR:</td>
				<td>
				</td>
			</tr>
			<tr>
				<td style="padding-left: 10px;padding-right: 10px;" colspan="2">
					<cc2:EasyAutocompletar ID="acJefe" runat=server  NroCarIni="4"  DisplayText="Nombres" ValueField="idpersonal" fncTempaleCustom="onDisplayTemplateAutoiza"  fnOnSelected="onItemAutorizaSeleccionado" required>
						<EasyStyle Ancho="Dos"></EasyStyle>
								 <DataInterconect MetodoConexion="WebServiceExterno">
									  <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
									  <Metodo>BuscarPersonalSIMA</Metodo>
									  <UrlWebServicieParams>
										  <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
									  </UrlWebServicieParams>
								  </DataInterconect>
					</cc2:EasyAutocompletar>
				</td>
			</tr>
			<tr>
				<td style="padding-left: 10px;" class="Etiqueta" >TRABAJADOR (Nro Doc.)</td>
				<td style="padding-left: 10px;" class="Etiqueta" >FECHAS AUTORIZADAS</td>
			</tr>
			<tr>
				<td style="vertical-align: top;padding-left: 10px;">
					<table>
						<tr>
							<td >
								<cc2:EasyAutocompletar ID="acTrab" runat="server"  NroCarIni="8"  DisplayText="NroDNI" ValueField="NroDNI"  fnOnSelected="onNroDocSeleccionado" fncTempaleCustom="onDisplayTemplateTraba" required>
									<EasyStyle Ancho="Dos"></EasyStyle>
													<DataInterconect MetodoConexion="WebServiceExterno">
														 <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
														 <Metodo>BuscarTrabajaor</Metodo>
														 <UrlWebServicieParams>
															 <cc3:EasyFiltroParamURLws  ParamName="FechaProgIni" Paramvalue="ListaTrabajadorEnFeriado.FechaProgInicio()" ObtenerValor="FunctionScript" />
															 <cc3:EasyFiltroParamURLws  ParamName="FechaProgFin" Paramvalue="ListaTrabajadorEnFeriado.FechaProgFin()" ObtenerValor="FunctionScript" />
															 <cc3:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
														 </UrlWebServicieParams>
													 </DataInterconect>
								</cc2:EasyAutocompletar>
							</td>
						</tr>
						<tr>
							<td style="padding-left: 10px;" noWrap class="Etiqueta" >LISTA DE TRABAJADORES</td>
						</tr>
						<tr>
							<td style="padding-left: 10px;" id="cellLstTrab" runat="server">

							</td>
						</tr>

					</table>
				
				    <asp:Button ID="btnReload" runat="server" OnClick="btnReload_Click" Text="Button" />
				
				</td>
				<td align="top" style="padding-left: 10px;padding-right: 10px;" >
					<asp:calendar id="Calendar1" runat="server" Width="100%" DayNameFormat="Full" NextPrevFormat="FullMonth"
									Height="400px" OnDayRender="Calendar1_DayRender" OnVisibleMonthChanged="Calendar1_VisibleMonthChanged">
									<NextPrevStyle Font-Bold="True" ForeColor="White"></NextPrevStyle>
									<DayHeaderStyle HorizontalAlign="Center" Height="35px" CssClass="HeaderGrilla" VerticalAlign="Middle"></DayHeaderStyle>
									<TitleStyle Font-Bold="True" ForeColor="White" BackColor="Highlight"></TitleStyle>
									<WeekendDayStyle BackColor="#C0C000"></WeekendDayStyle>
									<OtherMonthDayStyle Font-Italic="True" ForeColor="Gray" BackColor="InactiveCaptionText"></OtherMonthDayStyle>
					</asp:calendar>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<cc2:EasyToolBarButtons ID="EasyToolBarBtnOKCancel" runat="server" fnToolBarButtonClick="OnEasyToolbarOKCancel_Click">
						<EasyButtons>
							<cc2:EasyButton ID="btnAceptar" Descripcion="" RunAtServer="False" Texto="Aceptar" Ubicacion="Derecha" />
							<cc2:EasyButton ID="btnCancelar" Descripcion="" RunAtServer="False" Texto="Cancelar" Ubicacion="Derecha" />
						</EasyButtons>
					</cc2:EasyToolBarButtons>
				</td>
			</tr>

		</table>


    </form>
	<script>
		function OnEasyToolbarOKCancel_Click(btnItem, DetalleBE) {
			switch (btnItem.Id) {
				case "btnAceptar":
					Aprobar();
					break;
				case "btnCancelar":
                    alert('cancel');
                    break;
			}
		}

		function onNroDocSeleccionado(value, ItemBE) {
			if (acJefe.GetValue() == "") {
				var msgConfig = { Titulo: 'AUTORIZACIÓN FERIADOS Y DIA NO LABORABLE', Descripcion: 'Ingrese persona responsable de autorizar el ingreso..' };
				var oMsg = new SIMA.MessageBox(msgConfig);
				oMsg.Alert();
			}
			else {
				acTrab.SetValue('', '');
                __doPostBack('btnReload', ItemBE.NroDNI + ',' + ItemBE.ApellidosNombres);
			}
		}

        function onDisplayTemplateTraba(ul, item) {
            var cmll = "\""; var iTemplate = null;
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '<div class= "flex-column">' + item.ApellidosNombres
                + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red"> </small>'
                + '    <small style="font-weight: bold">NRO RUC.:</small><small style="color:blue;text-transform: capitalize;">' + item.NroDNI + '</small></p>'
                + '    <span class="badge badge-info "> otrodato </span > '
                + '</div>'
                + '</a>';

            var oCustomTemplateBE = new acTrab.CustomTemplateBE(ul, item, iTemplate);

            return acTrab.SetCustomTemplate(oCustomTemplateBE);
		}

        ListaTrabajadorEnFeriado.FechaProgInicio = function () {
            return ListaTrabajadorEnFeriado.Params[ListaTrabajadorEnFeriado.KEYQFECHAINI].toString().substring(0, 10).toString().ParseDateToYYYYmmDD('/');
        }
        ListaTrabajadorEnFeriado.FechaProgFin = function () {
            return ListaTrabajadorEnFeriado.Params[ListaTrabajadorEnFeriado.KEYQFECHAFIN].toString().substring(0, 10).toString().ParseDateToYYYYmmDD('/');
        }
    </script>
	<script>
		function Aprobar() {

            var ConfigMsgb = {
                Titulo: 'AUTORIZA FERIADO'
                , Descripcion: 'Desea hacer efectiva esta autorizacion ahora?'
                , Icono: 'fa fa-question-circle'
                , EventHandle: function (btn) {
					if (btn == 'OK') {

                     //   try {
                        //    if (acJefe.GetValue() != ""){
								jNet.get("Calendar1").forEach(function (octrl, i) {
																if (octrl.type.toLowerCase() === "checkbox") {
																	var oParent = jNet.get(octrl.parentNode);
																	if (octrl.checked == true) {
																		AprobacionDefinitiva(oParent.attr('Fecha'), 2);
																	}
																}
															}, 'input');





                           /* }
							else {
                                var msgConfig = { Titulo: 'AUTORIZACIÓN FERIADOS Y DIA NO LABORABLE', Descripcion: 'No se ha ingresado personal que autoriza...!!' };
                                var oMsg = new SIMA.MessageBox(msgConfig);
                                oMsg.Alert();
                            }*/

                       /* }
                        catch (SIMADataException) {
                            var msgConfig = { Titulo: "Error al registrar autorizacion", Descripcion: SIMADataException.Message };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();
                        }*/
                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
		}

		

        function AprobacionDefinitiva(Fecha, Aprobado) {
            jNet.get("cellLstTrab").forEach(function (octrl,i) {
				var oTrabajadorBE = octrl.attr('Data').toString().SerializedToObject();
                ListaTrabajadorEnFeriado.RegistrarAutorizacion(oTrabajadorBE.NroDNI, Fecha, acJefe.GetValue());
            });

		}


        function QuitarTrabajador(e) {
            var Me = e.parentNode.parentNode.parentNode.parentNode;
            jNet.get('cellLstTrab').remove(Me);
		}


		ListaTrabajadorEnFeriado.RegistrarAutorizacion = function (NroDNI,Fecha,IdPersonalAutoriza) {

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("NroDNI", NroDNI);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("FechaAutorizada", Fecha);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdPersonalAutoriza", IdPersonalAutoriza, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdEstado", 1, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
            oEasyDataInterConect.Metodo = 'CalenadrioAutorizaFeriado_ins';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData();
		}
		//establecer el evento a los check ctrls

        jNet.get("Calendar1").forEach(function (octrl, i) {
            if (octrl.type.toLowerCase() === "checkbox") {
                
				octrl.addEvent("click", function () {
                    var oParent = jNet.get(this.parentNode);
					try {
						if (jNet.get("cellLstTrab").children.length > 0) {
							if (acJefe.GetValue() != "") {
                                AprobacionDefinitiva(oParent.attr('Fecha'), ((this.checked == true) ? 1 : 0));
                            }
							else {

                                var msgConfig = { Titulo: 'AUTORIZACIÓN FERIADOS Y DIA NO LABORABLE', Descripcion: 'No se ha ingresado lista de trabajador(es) a ser autorizado' };
                                var oMsg = new SIMA.MessageBox(msgConfig);
                                oMsg.Alert();
                                this.checked = !this.checked;
                            }
                        }
						else {
                            var msgConfig = { Titulo: 'AUTORIZACIÓN FERIADOS Y DIA NO LABORABLE', Descripcion: 'No se ha ingresado personal que autoriza...!!' };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();

                            this.checked = !this.checked;
                        }
                    }
                    catch (Ex) {
                        this.checked = !this.checked;
                    }
				});
                    
                
            }
        }, 'input');


    </script>
</body>
</html>
