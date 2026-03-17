<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaTrabajadores.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.ListaTrabajadores" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc3" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
</head>
<body>
    <form id="form1" runat="server">
         <table style="width:100%;" border="0" >
             <tr>
                 <td class="Etiqueta">
                     NRO DOCUMENTO:
                 </td>
                 <td style="width:20%">
                     <cc1:EasyAutocompletar ID="acTrabajador" runat="server"  NroCarIni="8"  DisplayText="NroDNI" ValueField="NroDNI"  fnOnSelected="onNroDocSeleccionado" fncTempaleCustom="onDisplayTemplateTrabajador" required>
                         <EasyStyle Ancho="Dos"></EasyStyle>
                             <DataInterconect MetodoConexion="WebServiceExterno">
                                  <UrlWebService>/SIMANET/SeguridadPlanta/Contratista.asmx</UrlWebService>
                                  <Metodo>BuscarTrabajaor</Metodo>
                                  <UrlWebServicieParams>
                                      <cc2:EasyFiltroParamURLws  ParamName="FechaProgIni" Paramvalue="DefaultContratista.FechaProgInicio()" ObtenerValor="FunctionScript" />
                                      <cc2:EasyFiltroParamURLws  ParamName="FechaProgFin" Paramvalue="DefaultContratista.FechaProgFin()" ObtenerValor="FunctionScript" />
                                      <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                  </UrlWebServicieParams>
                              </DataInterconect>
                     </cc1:EasyAutocompletar>
                 </td>
                 <td>
                     <img id="ibtnAdd" runat="server"/>
                 </td>
                 <td style="width:50%">
                     
                 </td>
                 <td style="width:10%">
                     <cc1:EasyToolBarButtons ID="tbCalendario" runat="server">
                         <EasyButtons>
                             <cc1:EasyButton ID="dblCalendar" Descripcion="" Icono="fa fa-calendar" RunAtServer="False" Texto="Feriados" Ubicacion="Derecha" />
                         </EasyButtons>
                     </cc1:EasyToolBarButtons>
                 </td>
             </tr>
             <tr>
                 <td id="ContentTrab" colspan="5" style="width:100%">
                     <cc3:EasyGridView ID="grvTrabajadores" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="TRABAJADORES CONTRATISTAS"   Width="100%" fncExecBeforeServer="" ToolBarButtonClick="OnEasyGridButton_Click" OnRowDataBound="grvTrabajadores_RowDataBound" >

                             <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                 <DataInterconect MetodoConexion="WebServiceExterno">
                                     <UrlWebService></UrlWebService>
                                     <Metodo></Metodo>
                                     <UrlWebServicieParams>
                                         <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="UserName" TipodeDato="String"/>
                                     </UrlWebServicieParams>
                                 </DataInterconect>

                             <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" idgestorfiltro="" RowItemClick="ListaTrabajadores.GridCellOnClick"></EasyExtended>

                             <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                             <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                             <Columns>
                                 <asp:BoundField HeaderText="NRO DNI" DataField="NroDNI" >
                                 <ItemStyle HorizontalAlign="Left" Width="10%" />
                                 </asp:BoundField>
                                 <asp:BoundField HeaderText="APELLIDOS Y NOMBRES" DataField="Nombres" >
                                 <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                 </asp:BoundField>
                                 <asp:TemplateField HeaderText="SCTR">
                                     <ItemStyle Width="15%" />
                                 </asp:TemplateField>
                                 <asp:TemplateField HeaderText="EXAMEN">
                                     <ItemStyle Width="15%" />
                                 </asp:TemplateField>
                                 <asp:BoundField DataField="tFechaInicio" HeaderText="F.INICIO" />
                                 <asp:BoundField DataField="tFechaTermino" HeaderText="F.TERMINO" />
                                 <asp:TemplateField></asp:TemplateField>
                             </Columns>

                           <HeaderStyle CssClass="HeaderGrilla" />
                           <PagerStyle HorizontalAlign="Center" />
                           <RowStyle CssClass="ItemGrilla" Height="25px" />

                     </cc3:EasyGridView>
                 </td>
             </tr>
         </table>
    </form>
      <script>

          ListaTrabajadores.CrearRegTrabajador = function () {
              var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleTrabajador.aspx";
              var oColletionParams = new SIMA.ParamCollections();
              var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQQUIENLLAMA,"ListaTrabajadores");
              oColletionParams.Add(oParam);

              oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
              oColletionParams.Add(oParam);


              EasyPopupTrabajador.Load(Url, oColletionParams, false);
          }
          ListaTrabajadores.DetalleReprogramar= function (NroDocumento,ApellidosyNombres) {
              var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/ReprogramarTrabajador.aspx";
              var oColletionParams = new SIMA.ParamCollections();
              var oParam = new SIMA.Param(AdministrarProgramacionContratista.KEYQQUIENLLAMA, "ListaTrabajadores");
              oColletionParams.Add(oParam);

              oParam = new SIMA.Param(ListaTrabajadores.KEYQAÑO, ListaTrabajadores.Params[ListaTrabajadores.KEYQAÑO]);
              oColletionParams.Add(oParam);

              oParam = new SIMA.Param(ListaTrabajadores.KEYQIDPROGRAMACION, ListaTrabajadores.Params[ListaTrabajadores.KEYQIDPROGRAMACION]);
              oColletionParams.Add(oParam);

              oParam = new SIMA.Param(ListaTrabajadores.KEYQNRODOC, NroDocumento);
              oColletionParams.Add(oParam);

              oParam = new SIMA.Param(ListaTrabajadores.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
              oColletionParams.Add(oParam);

              EasyPopupReprogramaTrab.Load(Url, oColletionParams, false);
          }


          ListaTrabajadores.OnNull=function(oItemRowBE) {
          } 

          ListaTrabajadores.GridCellOnClick = function (oCell,oDataBE) {
              switch (oCell.cellIndex) {
                  case 0:
                      ListaTrabajadores.DetalleReprogramar(oDataBE.NroDni, oDataBE.Nombres);
                      break;
                  case 2:
                      ListaTrabajadores.ListadoAutorizadoPorTrabajador(oDataBE);
                      break;
              }
          } 


          ListaTrabajadores.Data = {};

          ListaTrabajadores.Eliminar = function (e) {
                  var ConfigMsgb = {
                      Titulo: 'TRABAJADOR'
                      , Descripcion: "Desea eliminar el registro de trabajador ahora?"
                      , Icono: 'fa fa-question-circle'
                      , EventHandle: function (btn) {
                          if (btn == 'OK') {

                              try {
                                  var DataRowBE = grvTrabajadores.GetDataRow();
                                  ListaTrabajadores.Data.EliminarTrabadorinProg(DataRowBE.Periodo, DataRowBE.NroProgramacion, DataRowBE.NroDni, 0);
                                  grvTrabajadores.DeleteRowActive(false);
                              }
                              catch (SIMADataException) {
                                  var msgConfig = { Titulo: "Error al Eliminar Responsable", Descripcion: SIMADataException.Message };
                                  var oMsg = new SIMA.MessageBox(msgConfig);
                                  oMsg.Alert();
                              }

                          }
                      }
          };
          var oMsg = new SIMA.MessageBox(ConfigMsgb);
          oMsg.confirm();
          }


          ListaTrabajadores.ListadoAutorizadoPorTrabajador = function (AutorizadoBE) {
              var HTMLLst = '';
              var HTMLTRow = '';
              var idx = 0;
              var cmll = "\"";
              var cmlls = "'";

              ListaTrabajadores.Data.ListarDiasAutorizados(AutorizadoBE.NroDni, AutorizadoBE.tFechaInicio.substring(0, 10), AutorizadoBE.tFechaTermino.substring(0, 10)).Rows.forEach(function (oDataRow,r) {
                  var Fecha = oDataRow.FechaAutorizada;
                  var Color = "Color:" + ((oDataRow.IdEstado == "1") ? "Red" : "blue") + ";";

                  var activo = ((oDataRow.IdEstado == "2") ? "checked=" + cmll + "checked" + cmll : "");
                  HTMLTRow += '<tr><td style="' + Color + '">' + Fecha + '</td><td><span Data=" ' + ''.BaseSerialized(oDataRow).toString().Replace(cmll, cmlls) +  '" ><input id="chk' + r + '" type="checkbox" ' + activo + ' onclick="ListaTrabajadores.Data.Autorizar(this);" /></span></td></tr>';

              });

              HTMLLst = '<table border="0">' + HTMLTRow + '</table>';

              var srtHTML = '<TABLE border="0"  style="WIDTH:100%;">'
                  + '		<TR><TD noWrap style="FONT-SIZE: 10pt; FONT-WEIGHT: bold" align="left">NRO DOCUMENTO:</TD><TD style="WIDTH:100%; FONT-SIZE: 10pt;" align="left">' + AutorizadoBE.NroDni + '</TD></TR>'
                  + '		<TR><TD noWrap style="FONT-SIZE: 10pt; FONT-WEIGHT: bold" align="left">APELLIDOS Y NOMBRES:</TD><TD style="WIDTH:100%; FONT-SIZE: 10pt;" align="left">' + AutorizadoBE.Nombres + '</TD></TR>'
                  + '		<TR><TD style="PADDING-LEFT: 5px; HEIGHT: 10px; FONT-SIZE: 10pt; BORDER-TOP: #808080 1px dotted" colspan="2" align="center">Listado de dias domingos y feriados autorizados</TD></TR>'
                  + '		<TR>'
                  + '			<TD width="100%"  HEIGHT: "100%" align="center" colspan="2" valign="top">'
                  + HTMLLst
                  + '			</TD>'
                  + '		</TR>'
                  + '</TABLE>';
              //Ext.MessageBox.alert('DIAS AUTORIZADOS', srtHTML);

              var msgConfig = {
                  Titulo: "Dias Autorizados.."
                  ,Width: "500px"
                  ,IncluirFondo:true
                  , Descripcion: srtHTML
                  , EventHandle: function (btn) {
                                    if (btn == "OK") {
                                          ListaTrabajadores.LocalDB.forEach(function (_AutorizaIngFeriadoBE) {
                                                ListaTrabajadores.RegistrarAutorizacion(_AutorizaIngFeriadoBE);
                                          });
                                            //la Grilla
                                            DefaultContratista.ListarTrabajadores();
                                        }
                                 }
              };
              var oMsg = new SIMA.MessageBox(msgConfig);
              oMsg.Alert();
          
          }
          ListaTrabajadores.LocalDB = new Array();

          ListaTrabajadores.Data.Autorizar=function(e) {
              var oParent = jNet.get(e.parentNode);
              var AutorizaIngFeriadoBE = oParent.attr('Data').toString().SerializedToObject();
              AutorizaIngFeriadoBE.IdEstado = ((e.checked == true) ? 2 : 1);
              //Almacena en una db Local temporal
              ListaTrabajadores.LocalDB.Add(AutorizaIngFeriadoBE);
          }


          ListaTrabajadores.RegistrarAutorizacion = function (oAutorizaIngFeriadoBE) {

              var oParamCollections = new SIMA.ParamCollections();
              var oParam = new SIMA.Param("NroDNI", oAutorizaIngFeriadoBE.NroDNI);
              oParamCollections.Add(oParam);

              oParam = new SIMA.Param("FechaAutorizada", oAutorizaIngFeriadoBE.FechaAutorizada);
              oParamCollections.Add(oParam);

              oParam = new SIMA.Param("IdPersonalAutoriza", oAutorizaIngFeriadoBE.IdPersonalAutoriza, TipodeDato.Int);
              oParamCollections.Add(oParam);

              oParam = new SIMA.Param("IdEstado", oAutorizaIngFeriadoBE.IdEstado, TipodeDato.Int);
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



          ListaTrabajadores.Data.ListarDiasAutorizados = function (NroDNI,FIniProg,FFinProg) {
              var oEasyDataInterConect = new EasyDataInterConect();
              oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
              oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
              oEasyDataInterConect.Metodo = "AutorizacionFeriadosPorTrabajador_lst";

              var oParamCollections = new SIMA.ParamCollections();
              var oParam = new SIMA.Param("NroDNI", NroDNI);
              oParamCollections.Add(oParam);

              oParam = new SIMA.Param("FechaIniProg", FIniProg);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              oParam = new SIMA.Param("FechaFinProg", FFinProg);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;


              oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
              return oEasyDataResult.getDataTable();
          }


          ListaTrabajadores.Data.EliminarTrabadorinProg = function (Periodo,IdProgramacion,NroDNI, IdEstado) {
              var oEasyDataInterConect = new EasyDataInterConect();
              oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
              oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
              oEasyDataInterConect.Metodo = "ProgramacionTrabajador_eli";

              var oParamCollections = new SIMA.ParamCollections();
              var oParam = new SIMA.Param("Periodo", Periodo, TipodeDato.Int);
              oParamCollections.Add(oParam);

              oParam = new SIMA.Param("IdProgramacion", IdProgramacion, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              oParam = new SIMA.Param("NroDNI", NroDNI);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              oParam = new SIMA.Param("IdEstado", IdEstado, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
              oParamCollections.Add(oParam);
              oEasyDataInterConect.ParamsCollection = oParamCollections;

              var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
              var ResultBE = oEasyDataResult.sendData();
          }
      </script>
</body>
</html>
