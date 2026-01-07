<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarRequerimiento.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Requerimiento.AdministrarRequerimiento" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <script>
       



        Fields = new Array("","","FECHA_AD", "PATHSERVICE","DESCRIPCION","",""); 

        function onLoadTreeNode(oGridView, oRow, NodeBE) {
            //Obtener Datos
            AdministrarRequerimiento.Data.ListaRequerimientoRelacionado(NodeBE.Id).Rows.forEach(function (oDataRow,r) {
                    oGridView.InsertRow(oRow.rowIndex + 1, function (oCellNew, c) {
                        switch (c) {
                            case 0:
                                oCellNew.css("background-color", "white");
                                break;
                            case 1:
                                 var oNodo = new SIMA.GridTree.Nodo();
                                     oNodo.Nivel = parseInt(NodeBE.Nivel)+1;
                                     oNodo.Id = oDataRow["NRO_TICKET"];
                                     oNodo.IdPadre = NodeBE.Id;
                                     oNodo.Text = oDataRow["NRO_TICKET"];
                                     oNodo.TextoySubTexto = false;
                                     oNodo.IsFather = ((parseInt(oDataRow["NROHIJOS"])==0)?false:true); 
                                 var otblNode = SIMA.GridTree.Nodos.Crear(oNodo);
                                oCellNew.insert(otblNode);
                                oCellNew.css("border-left", "3px dotted gray");
                                 break;
                            case 3:
                                 oCellNew.css('padding-left','30px');
                                oCellNew.innerHTML = '<table border="0"><tr><td rowspan=2>' + ITemplateFotoPersonaRQR(oDataRow["NRODOCDNI"]) + '</td> <td>' + ITemplatePathService(oDataRow["PATHSERVICE"].toString()) + '</td></tr><tr><td>' + ITemplateProgressBar(oDataRow["AVANCE"].toString()) +'</td></tr></table>';
                                break;
                            case 5:
                                var ItemAProb = '';
                                AdministrarRequerimiento.Data.ListaAprobadores(oDataRow["ID_REQU"]).Rows.forEach(function (oDataRowAprob, ra) {
                                    ItemAProb += '<div classname = "d-flex mb-5">'
                                                + '  <img src = "' + AdministrarRequerimiento.PathFotosPersonal + oDataRowAprob["NRODOCDNI"] + '.jpg" class="ms-n2 rounded-circle img-fluid" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;" style = "width:32px; height: 32px; object-fit: cover;"/>'
                                                + '</div> ';
                                });
                                oCellNew.innerHTML = '<span>' + ItemAProb + '</span>' ;
                                break;
                            case 6:
                                //oCellNew.innerHTML = '<img src="' + oDataRow["CMEDIA"].toString() + '" title ="' + oDataRow["NOMBREESTADO"].toString() + '"/>';
                                oCellNew.innerHTML = '<img src="' + oDataRow["CMEDIA"].toString() + '"/>';
                                break;
                             default:
                                oCellNew.innerText = ((oDataRow[Fields[c]] == undefined) ? "" : oDataRow[Fields[c]]);
                                oCellNew.css("text-align", "left");
                                 break;
                         }
                    });
            });
        }
        function ITemplateFotoPersonaRQR(NroDoc) {
            return '<img width="45px"   class="ms-n2 rounded-circle img-fluid" src="' + AdministrarRequerimiento.PathFotosPersonal +  NroDoc + '.jpg"/>';
        }
        function ITemplatePathService(Path) {
            var htmlItem = '';
            var ArrayPath = Path.toString().split('|');
            var htmlPath = '    <div class="row" style="margin-left: 0px"> '
                        + '            <div class="btn-group btn-breadcrumb">'
                        + '                <div class="btn btn-primary">'
                        + '                    <i class="fa fa-home"></i>'
                        + '                </div>';

            ArrayPath.reverse().forEach(function (ItemPathText, p) {
                                            if (ArrayPath.length == p) {
                                                htmlItem += '              <div class="btn btn-default">'
                                                    + '                  <i>' + ItemPathText + '</i>'
                                                    + '             </div>';
                                            }
                                            else {
                                                htmlItem += '              <div class="btn btn-default">'
                                                    + '                  <i>' + ItemPathText + '</i>'
                                                    + '              </div>';

                                            }
                                        });
            htmlPath += htmlItem
                        + '              </div>'
                        + '          </div>'
                        + '      </div>';
            return htmlPath;
        }
        function ITemplateProgressBar(Avance) {
            return '         <div class="progress"  style = "width:100%;">'
                + '            <div class="progress-bar" >'
                + '                <span class="progress-bar-text">' + Avance + '%</span>'
                + '            </div>'
                + '        </div>';
        }




      
       function iTemplateAprobador(AprobadorBE,msg) {
           var FotoPersona = AdministrarRequerimiento.PathFotosPersonal + AprobadorBE.NRODOCDNI + ".jpg";
           var cmll = "'";
           var FotoClassName = "ms-n2 rounded-circle img-fluid";
           var imgAprobador = '<img width="80px" style="border: 5px solid rgba(255,255,255,0.5);" class="' + FotoClassName + '" src="' + FotoPersona + '" onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"/>';
           var htmlResponse = '<table><tr><td align="center">' + imgAprobador + '</td></tr><tr><td>' + msg + '</td></tr></table>';
           return htmlResponse;
        }
        
        function ListViewAprobadores_ItemClick(oModo, oListItem, oItemView) {
            switch (oModo) {
                case "Open":

                    var ConfigMsgb = {
                        Titulo: 'SOLICITUD DE APROBACIÓN'
                        , Descripcion: AdministrarRequerimiento.ItemplateSolicitud(oItemView.DataComplete)
                        , Icono: 'fa fa-tag'
                        , EventHandle: function (btn) {
                            if (btn == 'OK') {
                                Manager.Task.Excecute(function () {
                                    var CodState = AdministrarRequerimiento.EnviarEmailSolicitudAprobacion(oItemView.DataComplete);
                                    switch (CodState) {
                                        case "99":                                      
                                            var msgConfig = { Titulo: "Error ", Descripcion: iTemplateAprobador(oItemView.DataComplete,"El Requerimiento se encuentra aprobado,no se enviara mensaje de solicitud de aprobación al aprobador seleccionado")};
                                            var oMsg = new SIMA.MessageBox(msgConfig);
                                            oMsg.Alert();
                                            break;
                                    }
                                   

                                    //alert(NroEnvio);
                                   // var objNotify = jNet.get("EasyGridView1_ntf_" + DetalleBE.ID_REQU + "_0");
                                    //objNotify.innerText = NroEnvio;//Actualiza el nro de mensajes de solicitud enviadas
                                }, 1000);
                            }
                        }
                    };

                    var oMsg = new SIMA.MessageBox(ConfigMsgb);
                    oMsg.confirm();







                    break;
            }
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
                  <td style="width:100%; height:100%">
                      <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="GESTION DE TICKETS" ToolBarButtonClick="OnEasyGridButton_Click" Width="100%" AllowPaging="True" OnRowDataBound="EasyGridView1_RowDataBound" OnEasyGridDetalle_Click="EasyGridView1_EasyGridDetalle_Click" fncExecBeforeServer="" OnPageIndexChanged="EasyGridView1_PageIndexChanged" OnEasyGridButton_Click="EasyGridView1_EasyGridButton_Click">
                          <EasyGridButtons>
                              <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Texto="Agregar" Ubicacion="Derecha" />
                              <cc1:EasyGridButton ID="btnEliminar" Descripcion="" Icono="fa fa-close" MsgConfirm="Desea Eliminar este registro ahora?" RequiereSelecciondeReg="true" SolicitaConfirmar="true" RunAtServer="True" Texto="Eliminar" Ubicacion="Derecha" />
                          </EasyGridButtons>

                              <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                              <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                              <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                 
                              <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                 
                              <Columns>
                                  <asp:BoundField DataField="NRO_TICKET" HeaderText="N° TICKET" >
                                  <ItemStyle HorizontalAlign="Left" />
                                  </asp:BoundField>
                                  <asp:BoundField DataField="FECHA_AD" HeaderText="FECHA" DataFormatString="{0:dd/MM/yyyy}" >
                                  <ItemStyle HorizontalAlign="Left" Width="4%" />
                                  </asp:BoundField>
                                  <asp:BoundField DataField="PATHSERVICE" HeaderText="SERVICIO" >
                                  <ItemStyle HorizontalAlign="Left" />
                                  </asp:BoundField>
                                  <asp:BoundField DataField="DESCRIPCION" HeaderText="DESCRIPCION " >
                                  <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                  </asp:BoundField>
                                  <asp:BoundField HeaderText="APROBADORES" >
                                  <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                  </asp:BoundField>
                                  <asp:TemplateField HeaderText="ESTADO"></asp:TemplateField>
                              </Columns>

                            <HeaderStyle CssClass="HeaderGrilla" />
                            <PagerStyle HorizontalAlign="Center" />
                            <RowStyle CssClass="ItemGrilla" Height="25px" />
                 
                      </cc1:EasyGridView>
                  </td>
              </tr>
     
          </table>
          <cc3:EasyPopupBase ID="EasyPopupDetalle" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage"  Titulo="Detalle de Requerimiento" RunatServer="false" DisplayButtons="true"  CtrlDisplayMensaje="msgValRqr" fncScriptAceptar="AdminstrarUsuariosFirmantes.onPopupAceptar">
          </cc3:EasyPopupBase>







    </form>




    <style>
        .Aprob-badge {
            position: relative;
            top: -3rem;
            left: 4rem;
            width: 3rem;
            height: 3rem;
            text-align: center;
            line-height: 1.5rem;
            font-size: 0.6rem;
            border-radius: 50%;
            color: white;
            border: 1px solid rgb(242, 242, 246);
              background-position: center;
              background-repeat: no-repeat;
              background-size: cover;
              position: relative;
              cursor:pointer;
        }
    </style>
 
    <script>

        function OnEasyGridButton_Click(btnItem, DetalleBE) {
            
            switch (btnItem.Id) {
                case "btnAgregar":
                    AdministrarRequerimiento.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.N,"0");
                    break;
                case "btnEliminar":
                    alert();
                    break;
            }
        }
        AdministrarRequerimiento.Data = {};

        AdministrarRequerimiento.ShowDetalle = function (oModo,IdRequerimiento) {
            var Url = Page.Request.ApplicationPath + "/HelpDesk/Requerimiento/DetalleRequerimiento.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(EasyPopupDetalle.KEYIDREQUERIMIENTO, IdRequerimiento);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(EasyPopupDetalle.KEYMODOPAGINA, oModo);
            oColletionParams.Add(oParam);

            EasyPopupDetalle.Load(Url, oColletionParams, false);
        }

        AdministrarRequerimiento.Data.ListaRequerimientoRelacionado = function (IdRqrPadre) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/AdministrarHD.asmx";
            oEasyDataInterConect.Metodo = "Requerimientos_lst";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdRequerientoPadre", IdRqrPadre);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }

        AdministrarRequerimiento.Data.ListaAprobadores = function (IdRqr) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/AdministrarHD.asmx";
            oEasyDataInterConect.Metodo = "Requerimientos_Aprobador_Lst";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdRequerimiento", IdRqr);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }


        /*-----------------------------------------------------------------------------------------------*/
        AdministrarRequerimiento.ItemplateSolicitud = function (oDetalleBE) {
            var oDataRowRequ = EasyGridView1.GetDataRow();
            var AprobadorBE = null;
            AdministrarRequerimiento.Data.ListaAprobadores(oDataRowRequ["ID_REQU"]).Select("ID_RESPONSABLE", "=", oDetalleBE.ID_RESPONSABLE).forEach(function (oDataResponsable, x) {
                AprobadorBE= oDataResponsable;
            });
            


            var FotoPersona = AdministrarRequerimiento.PathFotosPersonal + oDetalleBE.NRODOCDNI + ".jpg";
            var cmll = "'";
            var FotoClassName = "ms-n2 rounded-circle img-fluid";

            var imgAprob = "";
            if ((AprobadorBE.APROBADO == "0") && (AprobadorBE.TOKENAPROB == undefined)) {
                imgAprob = "sin Imagen";
            }
            else if ((AprobadorBE.APROBADO == "0") && (AprobadorBE.TOKENAPROB != undefined)) {
                imgAprob = SIMA.Utilitario.Constantes.ImgDataURL.IconDesaprobado;
            }
            else {
                imgAprob = SIMA.Utilitario.Constantes.ImgDataURL.IconAprobado;
            }

            var HtmlAprobado = '<div class="Aprob-badge" style="background-image: url(' + cmll + imgAprob + cmll + ');"></div>';

            var HtmMsgSend = '<table><tr><td style="color:gray;font-size: 12px;text-align: center;">Msg enviados..</td><td><div class="notify-badge">' + AprobadorBE.NRO_MSG_APR + '</div><img src="' + SIMA.Utilitario.Constantes.ImgDataURL.CardEMail + '"/></td></tr></table>';

            var MsgTemplate = '<table border=0 width="100%" id="tblSendAprob" style="background-repeat: no-repeat;background-image: url(' + cmll + "../../Recursos/img/ToolBar.jpg" + cmll + ');">'
                + '<tr>'
                + '     <td colspan=2 align="center"><img width="220px"    style="border: 5px solid rgba(255,255,255,0.5);"    class="' + FotoClassName + '" src="' + FotoPersona + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"/>' + HtmlAprobado + '</td>'
                + '</tr>'
                + '<tr>'
                + ' <td>'
                + HtmMsgSend
                + ' </td>'
                + '</tr>'
                + '<tr>'
                + '     <td colspan=2 align="center"><br>Desea enviar una solicitud de aprobación a:' + oDetalleBE.APELLIDOSYNOMBRES + ' a su bandeja de correo ahora? </td>'
                + '</tr>'
                + '</table>';

            return MsgTemplate;
        }
        AdministrarRequerimiento.EnviarEmailSolicitudAprobacion = function (AprobadorBE) {
            var oDataRow = EasyGridView1.GetDataRow();
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("NroDocDNISolicitante", UsuarioBE.NroDocumento);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("ApellidosyNombresSolicitante", UsuarioBE.ApellidosyNombres);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdUsuarioRQR", oDataRow["USU_ADD"], TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdRequerimiento", oDataRow["ID_REQU"]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("PathApp", Page.Request.ApplicationPath);
            oParamCollections.Add(oParam)
            oParam = new SIMA.Param("IdUsuAprobadorRqr", AprobadorBE.ID_RESPONSABLE);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("EmailAprobador", AprobadorBE.EMAIL);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = '/HelpDesk/HDProcesos.asmx';
            oEasyDataInterConect.Metodo = 'EnviaEmailAprobarRequerimiento';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var ResultBE = oEasyDataResult.sendData().toString().SerializedToObject();

            return ResultBE.IdOut;
        }



    </script>

</body>

</html>
