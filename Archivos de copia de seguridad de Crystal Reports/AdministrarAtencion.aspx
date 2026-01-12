<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarAtencion.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.BandejaEntrada.AdministrarAtencion" %>

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




     Fields = new Array("", "", "", "FECHA", "", "DESCRIPCION", "", "");

     function onLoadTreeNode(oGridView, oRow, NodeBE) {
         //Obtener Datos
         AdministrarAtencion.Data.ListaRequerimientoRelacionado(NodeBE.Id).Rows.forEach(function (oDataRow, r) {
            var oDataRowFila= oGridView.InsertRow(oRow.rowIndex + 1, function (oCellNew, c) {
                                                                            switch (c) {
                                                                                case 0:
                                                                                    oCellNew.css("background-color", "white");
                                                                                    break;
                                                                                case 1:
                                                                                    var oNodo = new SIMA.GridTree.Nodo();
                                                                                    oNodo.Nivel = parseInt(NodeBE.Nivel) + 1;
                                                                                    oNodo.Id = oDataRow["NRO_TICKET"];
                                                                                    oNodo.IdPadre = NodeBE.Id;
                                                                                    oNodo.Text = oDataRow["NRO_TICKET"];
                                                                                    oNodo.TextoySubTexto = false;
                                                                                    oNodo.IsFather = ((parseInt(oDataRow["NROHIJOS"]) == 0) ? false : true);
                                                                                    var otblNode = SIMA.GridTree.Nodos.Crear(oNodo);
                                                                                    jNet.get(otblNode.rows[0].cells[otblNode.rows[0].cells.length - 1]).attr("nowrap", "nowrap");
                                                                                    oCellNew.insert(otblNode);
                                                                                    oCellNew.css("border-left", "3px dotted gray");
                                                                                    break;
                                                                                case 2:
                                                                                    var CardMgs = ""
                                                                                    if (oDataRow["NRO_MSG_APR"].toString() != "0") {
                                                                                        CardMgs = '<div class="notify-badge">' + oDataRow["NRO_MSG_APR"].toString() + '</div><img src="' + SIMA.Utilitario.Constantes.ImgDataURL.CardEMail + '" width="40px">'
                                                                                    }


                                                                                    oCellNew.css('padding-left', '30px');
                                                                                    oCellNew.innerHTML = '<table border="0">'
                                                                                                        + '     <tr>'
                                                                                                        + '         <td rowspan=2>'
                                                                                                        +               ITemplateFotoPersonaRQR(oDataRow["NRODOCDNI"])
                                                                                                        + '         </td>'
                                                                                                        + '         <td>'
                                                                                                        +               oDataRow["APELLIDOSYNOMBRES"].toString()
                                                                                                        + '         </td>'
                                                                                                        + '         <td rowspan=2>'
                                                                                                        + CardMgs
                                                                                                        + '         </td>'
                                                                                                        + '     </tr>'
                                                                                                        + '     <tr>'
                                                                                                        + '         <td>'
                                                                                                        +               oDataRow["AREASOLICITANTE"].toString()
                                                                                                        + '         </td>'
                                                                                                        + '     </tr>'
                                                                                                        + '</table>';
                                                                                    break;
                                                                                case 4:
                                                                                    oCellNew.css('padding-left', '0px');
                                                                                    oCellNew.innerHTML = ITemplatePathService(oDataRow["PATHSERVICE"].toString());
                                                                                    break;
                                                                                case 6:
                                                                                    var ItemAProb = '';
                                                                                    AdministrarAtencion.Data.ListaAprobadores(oDataRow["ID_REQU"]).Rows.forEach(function (oDataRowAprob, ra) {
                                                                                        ItemAProb += '<div classname = "d-flex mb-5">'
                                                                                            + '  <img src = "' + AdministrarAtencion.PathFotosPersonal + oDataRowAprob["NRODOCDNI"] + '.jpg" class="ms-n2 rounded-circle img-fluid" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;" style = "width:32px; height: 32px; object-fit: cover;"/>'
                                                                                            + '</div> ';
                                                                                    });
                                                                                    oCellNew.innerHTML = '<span>' + ItemAProb + '</span>';
                                                                                    break;
                                                                                case 7:
                                                                                    oCellNew.innerHTML = ITemplateProgressBar(oDataRow["PORCAVANCE"].toString());
                                                                                    break;
                                                                                case 8:
                                                                                    oCellNew.innerHTML = '<img src="' + oDataRow["ICONOEST"].toString() + '"/>';
                                                                                    break;
                                                                                default:
                                                                                    oCellNew.innerText = ((oDataRow[Fields[c]] == undefined) ? "" : oDataRow[Fields[c]]);
                                                                                    oCellNew.css("text-align", "left");
                                                                                    break;
                                                                            }
                    });
                     //Enlaza la fila con la Data
                     var ohtmlRow= oDataRowFila.GetData();
                     var oDaraRoeNew = EasyGridView1.GetDataRow(ohtmlRow["Guid"]);
                     oDataRow.Columns.forEach(function (dc, c) {
                         if ((dc.Name != "Guid") && (dc.Name != "Modo")){
                             oDaraRoeNew[dc.Name] = oDataRow[dc.Name];
                         }
                     });
         });
     }
     function ITemplateFotoPersonaRQR(NroDoc) {
         return '<img width="45px"   class="ms-n2 rounded-circle img-fluid" src="' + AdministrarAtencion.PathFotosPersonal + NroDoc + '.jpg"/>';
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
                    <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="GESTION DE TICKETS" Width="100%" AllowPaging="True" fncExecBeforeServer="" ToolBarButtonClick="OnEasyGridButton_Click" OnRowDataBound="EasyGridView1_RowDataBound" OnEasyGridDetalle_Click="EasyGridView1_EasyGridDetalle_Click" OnEasyGridButton_Click="EasyGridView1_EasyGridButton_Click" OnRowCreated="EasyGridView1_RowCreated" OnPageIndexChanged="EasyGridView1_PageIndexChanged" >
                        <EasyGridButtons>
                            <cc1:EasyGridButton ID="btnAsignar" Descripcion="" Icono="fa fa-users" MsgConfirm="" RunAtServer="false"  Texto="Asignar" RequiereSelecciondeReg="true" Ubicacion="Centro" />
                            <cc1:EasyGridButton ID="btnSolAprob" Descripcion="" Icono="fa fa-check-circle-o" MsgConfirm="Desea Solicitar la parobación de la atención del requeriiento ahora?" RequiereSelecciondeReg="true" SolicitaConfirmar="false" RunAtServer="False" Texto="Solicitar aprobación" Ubicacion="Centro" />
                            <cc1:EasyGridButton ID="btnAgregarRqr" Descripcion="" Icono="fa fa-tag" MsgConfirm="" RequiereSelecciondeReg="true"  RunAtServer="True" Texto="New Requerimiento Relacionado" Ubicacion="Derecha" />
                        </EasyGridButtons>

                            <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect>
                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
               
                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />
               
                            <Columns>
                                <asp:BoundField DataField="NRO_TICKET" HeaderText="N° TICKET" >
                                <ItemStyle HorizontalAlign="Left" Width="2%" Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="SOLICITANTE">
                                    <ItemStyle Width="20%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Fecha" HeaderText="FECHA" DataFormatString="{0:dd/MM/yyyy}" >
                                <ItemStyle HorizontalAlign="Left" Width="2%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PATHSERVICE" HeaderText="SERVICIO" >
                                <ItemStyle HorizontalAlign="Left" Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DESCRIPCION" HeaderText="DESCRIPCION " >
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="RESPONSABLES" >
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" Width="5%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="AVANCE">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle Width="20%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ESTADO"></asp:TemplateField>
                            </Columns>

                          <HeaderStyle CssClass="HeaderGrilla" />
                          <PagerStyle HorizontalAlign="Center" />
                          <RowStyle CssClass="ItemGrilla" Height="25px" />
               
                    </cc1:EasyGridView>
                </td>
            </tr>
   
        </table>

            <cc3:EasyPopupBase ID="EasyPopupSprint" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Recursos (Carga y Capacidades)" RunatServer="false" DisplayButtons="true" >
            </cc3:EasyPopupBase>

            <cc3:EasyPopupBase ID="EasyPopupSprintAgil" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Estado de Recursos" RunatServer="false" DisplayButtons="true"  fncScriptAceptar="SprintAgilCargaPorTrabajador.Aceptar">
            </cc3:EasyPopupBase>


         </form>
</body>
  
      
     <script>
         AdministrarAtencion.Data = {};
         
        /* AdministrarAtencion.Data.ObtenerDatosdelUsuario = function () {

             AdministrarAtencion.ListarAccesoUsuarioArea();

             return "710";
         }*/
         /*AdministrarAtencion.ListarAccesoUsuarioArea = function(){
             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
             oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/GestionPersonal/Personal.asmx";
             oEasyDataInterConect.Metodo = "DetallePersonaO7xCodigo";

             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("IdPersonal", UsuarioBE.IdPersonal);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
             oParamCollections.Add(oParam);
             oEasyDataInterConect.ParamsCollection = oParamCollections;

             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
             return oEasyDataResult.getEntity();

         }*/
         function ListViewResponsable_ItemClick(oModo,oListItem,oItemView) {
             switch (oModo) {
                 case "Open":

                     var Url = Page.Request.ApplicationPath + "/HelpDesk/BandejaEntrada/ListarSprint.aspx";
                     var oColletionParams = new SIMA.ParamCollections();
                     var oParam = new SIMA.Param(AdministrarAtencion.KEYIDREQUERIMIENTO, oItemView.DataComplete["IdRequerimiento"]);
                     oColletionParams.Add(oParam);

                     oParam = new SIMA.Param(AdministrarAtencion.KEYIDPERSONAL, oItemView.DataComplete["IdPersonal"]);
                     oColletionParams.Add(oParam);

                     EasyPopupSprint.Load(Url, oColletionParams, false);



                     break;
             }
             
         }



         AdministrarAtencion.ItemplateSolicitud = function (oDetalleBE) {
             var FotoPersona = AdministrarAtencion.PathFotosPersonal + oDetalleBE.NRODOCDNI + ".jpg";
             var cmll = "'";
             var FotoClassName = "ms-n2 rounded-circle img-fluid";

             var MsgTemplate = '<table border=0 width="100%" id="tblSendAprob" style="background-repeat: no-repeat;background-image: url(' + cmll +"../../Recursos/img/ToolBar.jpg" + cmll+ ');">'
                 + '<tr>'
                 + '     <td colspan=2 align="center"><img width="220px"    style="border: 5px solid rgba(255,255,255,0.5);"    class="' + FotoClassName + '" src="' + FotoPersona + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;" /></td>'
                 + '</tr>'
                 + '<tr>'
                 + '     <td colspan=2 align="center"><br>Desea enviar una solicitud de aprobación a:' + oDetalleBE.APELLIDOSYNOMBRES + ' a su bandeja de correo ahora? </td>'
                 + '</tr>'
                 + '</table>';
            
             return MsgTemplate;
         }

         AdministrarAtencion.EnviarEmailSolicitudAprobacion = function () {
             var oDataRow = EasyGridView1.GetDataRow();
             // NroDocDNISolicitante,string ApellidosyNombresSolicitante,int IdUsuarioRQR, string IdRequerimiento,string UserName
             var oParamCollections = new SIMA.ParamCollections();
             var oParam = new SIMA.Param("NroDocDNISolicitante", UsuarioBE.NroDocumento);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("ApellidosyNombresSolicitante", UsuarioBE.ApellidosyNombres);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("IdUsuarioRQR", oDataRow["USU_ADD"], TipodeDato.Int);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("IdRequerimiento", oDataRow["ID_REQU"]);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("PathSvrCore", Page.Request.ApplicationPath);
             oParamCollections.Add(oParam)
             oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
             oParamCollections.Add(oParam);
             oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
             oParamCollections.Add(oParam);

             var oEasyDataInterConect = new EasyDataInterConect();
             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
             oEasyDataInterConect.UrlWebService = '/HelpDesk/HDProcesos.asmx';
             oEasyDataInterConect.Metodo = 'EnviaEmailAprobarServicio';
             oEasyDataInterConect.ParamsCollection = oParamCollections;

             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
             var ResultBE = oEasyDataResult.sendData().toString().SerializedToObject();
             return ResultBE.IdOut;
         }


         function OnEasyGridButton_Click(btnItem, DetalleBE) {
         
             switch (btnItem.Id) {
                 case "btnAgregar":
                     
                     break;
                 case "btnAsignar":
                     AdministrarAtencion.SprintAgilClickUp(DetalleBE.ID_REQU);
                     break;
                 case "btnSolAprob":
                   
                    
                     if (DetalleBE.IDESTADO == 8) {//Espera la aprobacion del usario
                         var ConfigMsgb = {
                             Titulo: 'SOLICITUD DE APROBACIÓN'
                             , Descripcion: AdministrarAtencion.ItemplateSolicitud(DetalleBE)
                             , Icono: 'fa fa-tag'
                             , EventHandle: function (btn) {
                                 if (btn == 'OK') {
                                     Manager.Task.Excecute(function () {
                                         var NroEnvio = AdministrarAtencion.EnviarEmailSolicitudAprobacion();
                                         var objNotify = jNet.get("EasyGridView1_ntf_" + DetalleBE.ID_REQU + "_0");
                                         objNotify.innerText = NroEnvio;//Actualiza el nro de mensajes de solicitud enviadas
                                     }, 1000);
                                 }
                             }
                         };

                         var oMsg = new SIMA.MessageBox(ConfigMsgb);
                         oMsg.confirm();
                     }
                     else {
                         var msgConfig = { Titulo: "APROBACION", Descripcion: "para solicitar la aprobación del servicios el requerimiento debe estar en fase 8" };
                         var oMsg = new SIMA.MessageBox(msgConfig);
                         oMsg.Alert();
                     }

                     break;
             }
         }
         
         AdministrarAtencion.SprintAgilClickUp = function (IdRequerimiento) {
             var Url = Page.Request.ApplicationPath + "/HelpDesk/BandejaEntrada/SprintAgilCargaPorTrabajador.aspx";
             var oColletionParams = new SIMA.ParamCollections();
             var oParam = new SIMA.Param(AdministrarAtencion.KEYIDREQUERIMIENTO, IdRequerimiento);
             oColletionParams.Add(oParam);

             EasyPopupSprintAgil.Load(Url, oColletionParams, false);
         }

     </script>



    <script>

        AdministrarAtencion.Data.ListaRequerimientoRelacionado = function (IdRqrPadre) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/AdministrarHD.asmx";
            oEasyDataInterConect.Metodo = "BandejadeEntrada";

            var PersonalBE= AdministrarAtencion.Data.ObtenerCodArea();
            
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("CodigoArea", PersonalBE.CodigoArea);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdRqrPadre", IdRqrPadre);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }

        AdministrarAtencion.Data.ObtenerCodArea = function () {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/GestionPersonal/Personal.asmx";
            oEasyDataInterConect.Metodo = "DetallePersonaO7xCodigo";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdPersonal", UsuarioBE.CodPersonal,TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getEntity();
        }





        AdministrarAtencion.Data.ListaAprobadores = function (IdRqr) {
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

      

    </script>


    <script>
        /*
        SIMA.Utilitario.Helper.TablaGeneralItem("50", 0, 'Oracle').Rows.forEach(function (Item, i) {
            SIMA.Utilitario.Constantes.ImgDataURL.IconSystem.AddName("Icon" + Item.CODIGO, Item.CMEDIA);
        });
        */


        var ConfigMsgb = {
            Titulo: 'CAMBIO DE ESTADO'
            , Descripcion: RadioTemplate()
            , Icono: 'fa fa-tag'
            , EventHandle: function (btn) {
                if (btn == 'OK') {
                    try {
                       /* var oDataRow = EasyGridView1.GetDataRow();
                        //Cambia de estado
                        var CadenadeConexion = Page.Request.ApplicationPath + "/GestiondeCalidad/Proceso.aspx";
                        var oParamCollections = new SIMA.Data.OleDB.ParamCollections();
                        var oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYIDINSPECCION, IdInspeccion);
                        oParamCollections.Add(oParam);

                        oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYQIDESTADO, IdEstadoSelecccionado);
                        oParamCollections.Add(oParam);

                        oParam = new SIMA.Data.OleDB.Param(AdministrarInspecion.KEYQIDPROCESO, Proceso.GestiondeCalidad.InspeccionCambioEstado);
                        oParamCollections.Add(oParam);

                        var OleDBCommand = new SIMA.Data.OleDB.Command();
                        OleDBCommand.CadenadeConexion = CadenadeConexion;

                        var obj = OleDBCommand.ExecuteNonQuery(oParamCollections);


                        oRowImg.src = jNet.get("img" + IdEstadoSelecccionado).src;

                        if (obj != undefined) {

                            return true;
                        }*/
                    }
                    catch (SIMADataException) {
                        var msgConfig = { Titulo: "Error al intentar cambiar el estado", Descripcion: SIMADataException.Message };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                    }


                }
            }
        };
        var oMsg = new SIMA.MessageBox(ConfigMsgb);
        oMsg.confirm();

    </script>
        
</html>
