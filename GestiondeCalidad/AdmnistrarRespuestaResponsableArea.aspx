<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdmnistrarRespuestaResponsableArea.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.AdmnistrarRespuestaResponsableArea" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>


<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc5" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <script>
        function OnEasyGridButton_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregar":
                    var Url = Page.Request.ApplicationPath + "/GestiondeCalidad/DetalleRespuestaResponsableArea.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdmnistrarRespuestaResponsableArea.KEYIDINSPECCION, DetalleBE.IdInspeccion);
                    oColletionParams.Add(oParam);


                    oParam = new SIMA.Param(AdmnistrarRespuestaResponsableArea.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                    oColletionParams.Add(oParam);


                    EasyPopupAnotacion.Load(Url, oColletionParams, false);
                    break;
            }

        }

        function DetalleDeAnotacion(e, IdDetalleResponsableArea) {
            var oHtmlRow = jNet.get(e.parentNode);
            try {
               
                    var oColletionParams = new SIMA.ParamCollections();
                    var Url = Page.Request.ApplicationPath + "/GestiondeCalidad/DetalleRespuestaResponsableArea.aspx";

                    var oParam = new SIMA.Param(AdmnistrarRespuestaResponsableArea.KEYQIDETALLERPTARESPAREA, IdDetalleResponsableArea);
                    oColletionParams.Add(oParam);


                    oParam = new SIMA.Param(AdmnistrarRespuestaResponsableArea.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
                    oColletionParams.Add(oParam);


                    EasyPopupAnotacion.Load(Url, oColletionParams, false);
               
            }
            catch (err) {

            }
        }


        function EasyPopupAnotacion_Aceptar() {
            try {
                if ((DetalleRespuestaResponsableArea.IdEstado != '3') && (DetalleRespuestaResponsableArea.IdEstado != '4')) {
                    var oDataRow = EasyGridRpta.GetDataRow();

                  
                    var _IdDetRepArea = DetalleRespuestaResponsableArea.Params[DetalleRespuestaResponsableArea.KEYQIDETALLERPTARESPAREA];

                    var oParamCollections = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param('IdDetalleResponsableArea', ((_IdDetRepArea == undefined) ? "0" : _IdDetRepArea));
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param('IdInspeccion', oDataRow["IdInspeccion"]);
                    oParamCollections.Add(oParam);
                    oParam = new SIMA.Param('IdPersonal', jNet.get("txtIdPersonal").value);
                    oParamCollections.Add(oParam);
                    oParam = new SIMA.Param('Observacion', jNet.get("txtAnotacion").value);
                    oParamCollections.Add(oParam);
                    oParam = new SIMA.Param('IdEstado', '1');
                    oParamCollections.Add(oParam);
                    oParam = new SIMA.Param('IdUsuario', DetalleRespuestaResponsableArea.Params["IdUsuario"]);
                    oParamCollections.Add(oParam);
                    oParam = new SIMA.Param('UserName', DetalleRespuestaResponsableArea.Params['UserName']);
                    oParamCollections.Add(oParam);

                   
                    var oEasyDataInterConect = new EasyDataInterConect();
                    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                    oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                    oEasyDataInterConect.Metodo = 'DetalleResponsableXAreaModyInsert';
                    oEasyDataInterConect.ParamsCollection = oParamCollections;

                    //Se conecta y Obtiene los datos en formato DataTable
                    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                    var obj = oEasyDataResult.sendData();

                    if (obj != undefined) {
                        __doPostBack('btnRefresh', '');
                        return true;
                    }

                }
                else {
                    var msgConfig = { Titulo: "Error de actualizacion", Descripcion: 'No esta permitido ya realizar cambios.. e probable que se haya vizualizado o revisado!<br> si desea puede generar otra nota para su revición!'};
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                    return false;
                }
            }
            catch (SIMADataException) {
                var msgConfig = { Titulo: "Error al Eliminar Responsable", Descripcion: SIMADataException.Message };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
        }


        function ImgEstadoTemplate(IdNewEstado, Mensaje) {

            var MsgTemplate = '<table width="100%"><tr><td align="center"><img width="220px"  src="' + arrEstadoRPT[IdNewEstado] + '"/></td></tr> <tr><td align="center">' + Mensaje + '</td></tr></table >';
            return MsgTemplate;
        }
        function EstablecerParaLectura(oImgCrtrl,IdNewEstado) {
            var ConfigMsgb = {
                Titulo: 'Control de notas'
                , Descripcion: ImgEstadoTemplate(IdNewEstado, 'Desea que esta anotación este disponible a los inspectores encargados para su lectura y revisión ahora?')
                , Icono: 'fa-file-text-o'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        var oImgRow = jNet.get(oImgCrtrl);
                        oImgRow.src = arrEstadoRPT[IdNewEstado];//Modo de lectura
                        var oHtmlrow = jNet.get(oImgRow.parentNode.parentNode);
                        oHtmlrow.attr("exec", "NO");

                        var oParamCollections = new SIMA.ParamCollections();
                        var oParam = new SIMA.Param('IdDetalleResponsableArea', oImgRow.attr('IdDetalleResponsableArea'));
                        oParamCollections.Add(oParam);
                        oParam = new SIMA.Param('IdEstado', '2');
                        oParamCollections.Add(oParam);
                        oParam = new SIMA.Param('UserName', AdmnistrarRespuestaResponsableArea.Params['UserName']);
                        oParamCollections.Add(oParam);

                        var oEasyDataInterConect = new EasyDataInterConect();
                        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                        oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                        oEasyDataInterConect.Metodo = 'ActualizaEstadoDetalleResponsable';
                        oEasyDataInterConect.ParamsCollection = oParamCollections;

                        //Se conecta y Obtiene los datos en formato DataTable
                        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                        oEasyDataResult.sendData();

                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }
    </script>






</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%;"  border="0">
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" /> </td>
            </tr>
            <tr>
                <td style="padding-left:20px">
                    
               </td>
            </tr>
            <tr>
                <td style="width:100%; height:100%">
                    <cc1:EasyGridView ID="EasyGridRpta" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Proyectos en Inspección" ToolBarButtonClick="OnEasyGridButton_Click" Width="100%"  AllowPaging="True" OnRowDataBound="EasyGridRpta_RowDataBound">
                        <EasyGridButtons>
                            <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-list-alt" MsgConfirm="" RunAtServer="False" Texto="Agregar Notas" Ubicacion="Derecha" RequiereSelecciondeReg="True" />
                        </EasyGridButtons>
                            <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                       
                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                       
                            <Columns>
                                <asp:BoundField DataField="NroReporte" HeaderText="NRO INSPECCION">
                                <ItemStyle Width="4%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="PROYECTO">
                                    <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Top" Wrap="False" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Descripcion" HeaderText="DESCRIPCION">
                                <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Recomendaciones" HeaderText="RECOMENDACIONES">
                                <ItemStyle Width="20%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="RESPUESTA">
                                    <ItemStyle Width="40%" HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                            </Columns>

                          <HeaderStyle CssClass="HeaderGrilla" />
                          <PagerStyle HorizontalAlign="Center" />
                          <RowStyle CssClass="ItemGrilla" Height="25px" />
                       
                    </cc1:EasyGridView>
                </td>
            </tr>
        </table>
     
        
        <cc5:EasyTexto ID="txtIdPersonal" runat="server"></cc5:EasyTexto>
     
        
        <asp:Button ID="btnRefresh" runat="server" OnClick="btnRefresh_Click" Text="Button" />
     
        
        <cc3:EasyPopupBase ID="EasyPopupAnotacion" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Asignar Reponsable de aprobación" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupAnotacion_Aceptar">
        </cc3:EasyPopupBase>

      <button class="btnclass" style="display: none">Right Click Me</button>

        <cc3:EasyContextMenu ID="EasyContextMenu1" runat="server" LstClass=".context-area,.btn-context,.context-link,.btnclass" Width="45px"  >
            <EasyMnuButtons>
                <cc3:EasyButtonMenuContext ID="mnu1" Descripcion="" Icono="fa fa-facebook"  RunAtServer="True" Texto="Enviar Correo" />
            </EasyMnuButtons>
        </cc3:EasyContextMenu>

      
      

    </form>
    

   
    <style>
      .context-menu-style {
        background: white;
      }
      .context-menu-style .scm-item:hover {
        background: #24283c;
      }
    </style>
    <script>
        /*
        $(".context-area,.btn-context,.context-link").simpleContextMenu({
            class: null,
            onShow: function () {
                console.log("context menu shown");
            },
            onHide: function () {
                console.log("context menu hide");
            },
            options: [
                {
                    label: "Share On Facebook",
                    icon: '<i class="fa fa-facebook"></i>',
                    action: () => alert("Facebook"),
                },
                {
                    label: "Share On Twitter",
                    icon: '<i class="fa fa-twitter"></i>',
                    action: () => alert("Twitter"),
                },
                {
                    label: "Share On Pinterest",
                    icon: '<img class=" rounded-circle" width = "40px" src = "' + SIMA.Utilitario.Constantes.ImgDataURL.CardEMail + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">',
                    action: () => alert("Pinterest"),
                },
                {
                    label: "Share On Linkedin",
                    icon: '<i class="fa fa-linkedin"></i>',
                    action: () => alert("Linkedin"),
                },
                {
                    label: "Share On Reddit",
                    icon: '<i class="fa fa-reddit"></i>',
                    action: () => alert("Reddit"),
                },
            ],
        });*/
    </script>
 
       <script>
           $('#prev').on('click', function () {
               $('#menu ul').animate({
                   scrollLeft: '-=150'
               }, 300, 'swing');
           });

           $('#next').on('click', function () {
               $('#menu ul').animate({
                   scrollLeft: '+=150'
               }, 300, 'swing');
           });
       </script>

</body>
</html>
