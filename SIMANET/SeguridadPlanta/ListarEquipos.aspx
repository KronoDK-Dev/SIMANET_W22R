<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarEquipos.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.ListarEquipos" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   
    <script>

   
              

                        /*----*----*-----*----*---*--*--**----*----*-----*----*---*--*--**----*----*-----*----*---*--*--**----*----*-----*----*---*--*--**----*----*-----*----*---*--*--*/
                        if (parseInt(oCCTT_TrabajadorPermanenciaBE.Permitido, 10) > 0) {//verifica si el trabajador esta permitido su ingreso dentro del rango de horas establecidas
                            /*----------- SOLO CONTRATISTA-----------------------------------------------------------------------------------------------*/
                            if ((oCCTT_TrabajadorPermanenciaBE.TipoProgramacion == '0') || (oCCTT_TrabajadorPermanenciaBE.TipoProgramacion == '3') || (oCCTT_TrabajadorPermanenciaBE.TipoProgramacion == '8')) { //Solo Contratistas y tripulantes


                                oCCTT_TrabajadorPermanenciaBE.NroPase = (new Controladora.Personal.CCCTT_Pase()).ObtenerNroDisponible(Global_IdLote);
                                //LimitePase=((oCCTT_TrabajadorPermanenciaBE.NroPase="Limitado")?true:false);
                                /*----------------------VERIFICAR RESTRICCIONES-------------------------------------------------------------------------*/
                                if (jNet.get('txtVerificar').value == "SI") {
                                    var oCCTT_PermisoBE = new EntidadesNegocio.Personal.CCTT_PermisoBE();
                                    oCCTT_PermisoBE = (new Controladora.SeguridadIndustrial.CCCTT_ExamenMedico()).AprobacionPersonalContratista(oCCTT_TrabajadorPermanenciaBE.NroDNI);
                                    //excepciones (en algun momento deberian de dejar de estar implementados)
                                    //para el caso de tripulantes los requisitos  como examen medico induccion seran definidos por defecto como aprobados


                                    if ((oCCTT_TrabajadorPermanenciaBE.TipoProgramacion == '3') || (oCCTT_TrabajadorPermanenciaBE.TipoProgramacion == '8')) { oCCTT_PermisoBE.ExamenMedico = 'SI'; oCCTT_PermisoBE.ExamenInduccion = 'SI'; oCCTT_PermisoBE.ExaCovid = 'SI'; }//Valñidacion forzada para Tripulantes
                                    //if(oCCTT_TrabajadorPermanenciaBE.TipoProgramacion=='3'){oCCTT_PermisoBE.ExamenMedico='SI';oCCTT_PermisoBE.ExamenInduccion='SI';oCCTT_PermisoBE.ExaCovid='SI';}//Valñidacion forzada para Tripulantes
                                    //if(oCCTT_TrabajadorPermanenciaBE.TipoProgramacion=='8'){oCCTT_PermisoBE.ExamenMedico='SI';oCCTT_PermisoBE.ExaCovid='SI';}//Valñidacion forzada para ARMADORES

                                    if (oCCTT_TrabajadorPermanenciaBE.TipoProgramacion == 0) { oCCTT_PermisoBE.ExaCovid = 'SI'; }//ya es un requisito de validacion por ello se establece su valor a SI como si se hubiera registrado se solicito quitarlo por la psta medica 11-01-22

                                    if ((oCCTT_PermisoBE.ExamenMedico == 'SI') && (oCCTT_PermisoBE.ExamenInduccion == 'SI') && (oCCTT_PermisoBE.SCTRSalud == 'SI') && (oCCTT_PermisoBE.SCTRPension == 'SI')
                                        && (oCCTT_PermisoBE.ExaCovid == 'SI')
                                    ) {
                                        if (oCCTT_PermisoBE.IdAptitud == SIMA.Utilitario.Enumerados.ExamenAptitud.AptoConRestrincciones) {
                                            ValidaAptitud = true;
                                            ValidarRestricciones(oCCTT_PermisoBE, oCCTT_TrabajadorPermanenciaBE);
                                        }
                                    }
                                    else {
                                        var params = KEYTIPODOCUMENTO + SIMA.Utilitario.Constantes.General.Caracter.SignoIgual + "DNI"
                                            + SIMA.Utilitario.Constantes.General.Caracter.signoAmperson
                                            + KEYNUMERODOCUMENTO + SIMA.Utilitario.Constantes.General.Caracter.SignoIgual + NroDNITrack
                                            + SIMA.Utilitario.Constantes.General.Caracter.signoAmperson + "NPag=0"
                                            + SIMA.Utilitario.Constantes.General.Caracter.signoAmperson + "NuevoGrid=SI"
                                            + SIMA.Utilitario.Constantes.General.Caracter.signoAmperson
                                            + KEYQTIPOPROG + SIMA.Utilitario.Constantes.General.Caracter.SignoIgual + oCCTT_TrabajadorPermanenciaBE.TipoProgramacion
                                            + SIMA.Utilitario.Constantes.General.Caracter.signoAmperson
                                            + KEYQDESCRIPESTADO + SIMA.Utilitario.Constantes.General.Caracter.SignoIgual + MsgValidacionResquisitos(oCCTT_TrabajadorPermanenciaBE.ApellidosyNombres, oCCTT_PermisoBE);


                                        var URLREQUISITOS = SIMA.Utilitario.Helper.General.ObtenerPathApp() + "/Personal/Contratista/ListaResultadosContratistaRequisitos2.aspx?" + params;

                                        (new System.Ext.UI.WebControls.Windows()).DetalleEX('VALIDACION', URLREQUISITOS, this, 820, 230, ["Cancelar"], CerrarRequisitos, WndDetalleEX_OnClose);

                                        //LecturaBloqueada=false;
                                        return null;//No registra el ingreso
                                    }
                                }
                                /***---------------------------------FIN VERIFICAR RESTRICCIONES---------------------------------------------------------------------****/
                            }
                            /*-----------FIN  SOLO CONTRATISTA-----------------------------------------------------------------------------------------------*/
                            if (ValidaAptitud == false) {
                                Consola.Alarma(1, "chimes.wav");
                                //valida COVID para visitas
                                /*----------------------INICIO DE VISITAS------------------------------------------------------------------*/
                                var oCCTT_PermisoBEVis = new EntidadesNegocio.Personal.CCTT_PermisoBE();
                                oCCTT_PermisoBEVis = (new Controladora.SeguridadIndustrial.CCCTT_ExamenMedico()).AprobacionPersonalContratista(oCCTT_TrabajadorPermanenciaBE.NroDNI);

                                // fuerza la validacion por COVID cuando se genera un registro por la opcion Ingreso No Programado y esteblece a SI PARA PERMITIRLE EL INNGRESO sin validacion alguna
                                //if(ForzarIngNoProgPorCOVID!=undefined){oCCTT_PermisoBEVis.ExaCovid='SI';}
                                oCCTT_PermisoBEVis.ExaCovid = 'SI';

                                if (oCCTT_PermisoBEVis.ExaCovid == 'SI') {
                                    Agregar(oCCTT_TrabajadorPermanenciaBE.TipoProgramacion, oCCTT_TrabajadorPermanenciaBE.NroPase, dr);
                                    jNet.get('txtBuscarNro').value = ''; NroDNITrack = ''; LecturaBloqueada = false;
                                }
                                else {
                                    Consola.Alarma(1, "chimes.wav");
                                    var msgCovid = oCCTT_TrabajadorPermanenciaBE.ApellidosyNombres + '<br><br>';
                                    msgCovid = msgCovid + ((oCCTT_PermisoBEVis.ExaCovid == 'NO') ? 'No cuenta con exámen covid o su vigencia expiró <br>' : '');
                                    msgCovid = msgCovid + ((oCCTT_PermisoBEVis.PosiCovid == 'SI') ? ' ACCESO NO PERMITIDO ' : '');
                                    Ext.MessageBox.alert('DIAGNOSTICO COVID', msgCovid);
                                    setTimeout(function () { Ext.MessageBox.hide(); LecturaBloqueada = false; jNet.get('txtBuscarNro').value = ''; NroDNITrack = ''; }, 3000);
                                }
                                /*----------------------FIN VISITAS------------------------------------------------------------------*/

                            }

                        }
                        else {//En caso que su programacion este en la fecha pero su hora de ingreso no esta permitida
                            Consola.Alarma(1, "Alarma.wav"); (new Controladora.Personal.CCCTT_Monitor()).Insertar(NroDNITrack);

                            var fechahoy = new Date();
                            Ext.MessageBox.show({
                                title: 'Seguridad y control !',
                                msg: '<h1>AUTORIZACION</h1><br/><p>Sr.(a) <font style="FONT-SIZE: 10pt; FONT-WEIGHT: bold"> ' + oCCTT_TrabajadorPermanenciaBE.ApellidosyNombres + '</font> no tiene permitido el ingreso a esta hora: ' + fechahoy + '.</p><p>Ud. esta programado para ingresar a entre la(s) </p><p><IMG src="/SimaNetWeb/imagenes/Navegador/BtnOpciones/PostNota.gif" width="32" height="32"> <font style="COLOR: darkred; FONT-SIZE: 11pt; FONT-WEIGHT: bold"> ' + oCCTT_TrabajadorPermanenciaBE.HoraInicio + ' y las ' + oCCTT_TrabajadorPermanenciaBE.HoraTermino + '</font></p>',
                                width: 500, buttons: Ext.MessageBox.OK, icon: Ext.MessageBox.QUESTION
                            });
                            //setTimeout(function(){Ext.MessageBox.hide();}, 3000);
                            setTimeout(function () { Ext.MessageBox.hide(); LecturaBloqueada = false; jNet.get('txtBuscarNro').value = ''; NroDNITrack = ''; }, 3000);
                        }
                        /*----*----*-----*----*---*--*--**----*----*-----*----*---*--*--**----*----*-----*----*---*--*--**----*----*-----*----*---*--*--**----*----*-----*----*---*--*--*/
                        /*jNet.get('txtBuscarNro').value='';
                        NroDNITrack='';
                        LecturaBloqueada=false;*/
                   
               
          
							





    </script>





</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%">
            <tr>
                <td>
                    <cc1:EasyGridView ID="grvEquipos" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="LISTA DE EQUIPOS"   Width="100%"  fncExecBeforeServer="" ToolBarButtonClick="OnEasyGridButtonEquipo_Click" OnRowDataBound="grvEquipos_RowDataBound" >
                                 <EasyGridButtons>
                                     <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="False" Texto="Agregar" Ubicacion="Derecha" />
                                 </EasyGridButtons>
                               <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                <DataInterconect MetodoConexion="WebServiceExterno">
                                    <Metodo></Metodo>
                                    <UrlWebServicieParams>
                                        <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="UserName" TipodeDato="String"/>
                                    </UrlWebServicieParams>
                                </DataInterconect>

                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" idgestorfiltro="" RowItemClick="ListarEquipos.GridCellOnClick"></EasyExtended>

                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                            <Columns>
                                <asp:BoundField HeaderText="CODIGO" DataField="Codigo" >
                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="DESCRIPCION" DataField="Descripcion" >
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Cantidad" HeaderText="CANTIDAD">
                                <ItemStyle Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="IN/OUT" DataField="NombreTipoIngreso" >
                                <ItemStyle Width="5%" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemStyle Width="2%" />
                                </asp:TemplateField>
                            </Columns>

                          <HeaderStyle CssClass="HeaderGrilla" />
                          <PagerStyle HorizontalAlign="Center" />
                          <RowStyle CssClass="ItemGrilla" Height="25px" />

                    </cc1:EasyGridView>
                </td>
            </tr>
        </table>    
        <script>
            var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleEquipos.aspx";
            function OnEasyGridButtonEquipo_Click(btnItem, DetalleBE) {
                switch (btnItem.Id) {
                    case "btnAgregar":
                        var oColletionParams = new SIMA.ParamCollections();
                        var oParam = new SIMA.Param(ListarEquipos.KEYQIDPROGRAMACION, ListarEquipos.Params[ListarEquipos.KEYQIDPROGRAMACION]);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(ListarEquipos.KEYQAÑO, ListarEquipos.Params[ListarEquipos.KEYQAÑO]);
                        oColletionParams.Add(oParam);

                        oParam = new SIMA.Param(ListarEquipos.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                        oColletionParams.Add(oParam);

                        EasyPopupEquipoDet.Load(Url, oColletionParams, false);
                        
                        break;
                }
            }

            ListarEquipos.GridCellOnClick = function (oCell, oDataBE) {
                switch (oCell.cellIndex) {
                    case 0:
                        ListarEquipos.Detalle(oDataBE.NroItem);
                        break;
                }
            }
            //
            ListarEquipos.Detalle = function (IdEquipo) {
                var oColletionParams = new SIMA.ParamCollections();
                var oParam = new SIMA.Param(ListarEquipos.KEYQIDPROGRAMACION, ListarEquipos.Params[ListarEquipos.KEYQIDPROGRAMACION]);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(ListarEquipos.KEYQAÑO, ListarEquipos.Params[ListarEquipos.KEYQAÑO]);
                oColletionParams.Add(oParam);
                
                oParam = new SIMA.Param(ListarEquipos.KEYQIDEQUIPO, IdEquipo);
                oColletionParams.Add(oParam);

                oParam = new SIMA.Param(ListarEquipos.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
                oColletionParams.Add(oParam);

                EasyPopupEquipoDet.Load(Url, oColletionParams, false);

            }

            ListarEquipos.Eliminar = function (e) {
                var ConfigMsgb = {
                    Titulo: 'EQUIPO'
                    , Descripcion: "Desea eliminar el registro seleccionado ahora?"
                    , Icono: 'fa fa-question-circle'
                    , EventHandle: function (btn) {
                        if (btn == 'OK') {

                            try {
                                var DataRowBE = grvEquipos.GetDataRow();
                                ListarEquipos.Data.Eliminar(DataRowBE.Periodo, DataRowBE.NroProgramacion,DataRowBE.NroItem);
                                grvEquipos.DeleteRowActive(false);
                            }
                            catch (SIMADataException) {
                                var msgConfig = { Titulo: "Error al Eliminar", Descripcion: SIMADataException.Message };
                                var oMsg = new SIMA.MessageBox(msgConfig);
                                oMsg.Alert();
                            }

                        }
                    }
                };
                var oMsg = new SIMA.MessageBox(ConfigMsgb);
                oMsg.confirm();
                
            }
            ListarEquipos.Data = {};

            ListarEquipos.Data.Eliminar = function (Periodo, IdProgramacion, IdItem) { 
               
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
                oEasyDataInterConect.Metodo = "ContratistaEquipos_Del";

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("Periodo", Periodo, TipodeDato.Int);
                oParamCollections.Add(oParam);

                oParam = new SIMA.Param("IdProgramacion", IdProgramacion, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                oParam = new SIMA.Param("NroItem", IdItem, TipodeDato.Int);
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
    </form>
</body>
</html>
