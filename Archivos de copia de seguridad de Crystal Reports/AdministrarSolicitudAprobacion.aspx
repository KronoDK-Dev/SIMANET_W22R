<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarSolicitudAprobacion.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.AdministrarSolicitudAprobacion" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <style>
         .ItemContact {
                 border: 1px dotted #5394C8;
                background: #fefefe;
                color: #15428b;
                cursor: default;
                font: 11px tahoma,arial,sans-serif;
                height: 40px;
                display:inline-block;
                margin-right:2px;
    }

.ItemContact td {
    padding: 2px;
    cursor: hand;
}

.ItemContact tr:hover {
    background-color: #E1EFFA;
}

  </style>
<style>
    .ItemDisponible{
    background: #fefefe;
    color: #15428b;
    font: 12px tahoma,arial,sans-serif;
    margin-top:5px;
    margin-right:15px;
    margin-bottom:5px;
    border: 1px dotted #5394C8;
    height: 35px;        
    width:100%;
 }


.ItemDisponible td {
    padding-left:5px;
    padding-right:5px;       
    height:35px;
}

.ItemDisponible tr:hover {
   background-color: #E1EFFA;
}

.ItemSelected{
    background: #2794DD;
    color: white;
    font: 12px tahoma,arial,sans-serif;
    margin-top:5px;
    margin-bottom:5px;
    border: 1px dotted #5394C8;
    height: 35px;
    width:100%;
 }

.ItemSelected td {
    padding-left:5px;
    padding-right:5px;       
    height:35px;
}
</style>



    <script>
        function OnEasyGridButton_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnSend":
                    var ConfigMsgb = {
                        Titulo: 'ENVIAR MENSAJE'
                        , Descripcion: AdministrarSolicitudAprobacion.ItemplateMsgSupervisor(DetalleBE.NroMsgRecibe)
                        , Icono: 'fa fa-tag'
                        , EventHandle: function (btn) {
                            var otxtMsg = jNet.get("txtMsg");
                            if (btn == 'OK') {
                                Manager.Task.Excecute(function () {
                                    if (otxtMsg.value.length > 0) {
                                        var oParamCollections = new SIMA.ParamCollections();
                                        var oParam = new SIMA.Param("IdInspeccion", DetalleBE.IdInspeccion);
                                        oParamCollections.Add(oParam);

                                        oParam = new SIMA.Param("IdPersonalFirmante", DetalleBE.IdPersonaFirmante, TipodeDato.Int);
                                        oParamCollections.Add(oParam);

                                        oParam = new SIMA.Param("EMailDestino", DetalleBE.EMail);
                                        oParamCollections.Add(oParam);
                                        oParam = new SIMA.Param("Mensaje", otxtMsg.value);
                                        oParamCollections.Add(oParam);
                                        oParam = new SIMA.Param("UserName", AdministrarSolicitudAprobacion.Params["UserName"]);
                                        oParamCollections.Add(oParam);

                                        var oEasyDataInterConect = new EasyDataInterConect();
                                        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                                        oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                                        oEasyDataInterConect.Metodo = 'EMailToInspector';
                                        oEasyDataInterConect.ParamsCollection = oParamCollections;

                                        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                                        var obj = oEasyDataResult.sendData();
                                        if (obj != undefined) {

                                            return true;
                                        }
                                    }
                                    else {
                                        var msgConfig = { Titulo: "Advertencia", Descripcion: "No se ha ingresado Mensaje a enviar... <br>ingreso por favor un mensaje.." };
                                        var oMsg = new SIMA.MessageBox(msgConfig);
                                        oMsg.Alert();
                                    }
                                     
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
<body bottomMargin="0" leftMargin="0" rightMargin="0" topMargin="0">
    <form id="form1" runat="server">
          <table style="width:100%;"  border="0">
       <tr>
           <td>
               <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" /> </td>
       </tr>
       <tr>
           <td style="width:100%; height:100%">
               <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True"  TituloHeader="Listado de Solicitudes.." ToolBarButtonClick="OnEasyGridButton_Click" Width="100%" AllowPaging="True"  PageSize="5" OnRowDataBound="EasyGridView1_RowDataBound" OnPageIndexChanged="EasyGridView1_PageIndexChanged">
                   <EasyGridButtons>
                       <cc1:EasyGridButton ID="btnSend" Descripcion="Enviar por correo ficha de inspección" Icono="fa fa-envelope-o" MsgConfirm="" RequiereSelecciondeReg="True" RunAtServer="False" SolicitaConfirmar="False" Texto="" Ubicacion="Footer" />
                   </EasyGridButtons>
                       <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                       <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="AdministrarSolicitudAprobacion.AprobarDesaprobar" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                       <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                  
                       <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                  
                       <Columns>
                           <asp:TemplateField HeaderText="SOLICITANTE">
                               <ItemStyle Width="90px" />
                           </asp:TemplateField>
                           <asp:BoundField DataField="NroReporte" HeaderText="N° REPORTE" >
                           <ItemStyle HorizontalAlign="Left" />
                           </asp:BoundField>
                           <asp:BoundField DataField="TipoInspeccion" HeaderText="TIPO DE INSPECCION" SortExpression="TipoInspeccion" >
                           <ItemStyle HorizontalAlign="Left" />
                           </asp:BoundField>
                           <asp:BoundField DataField="ClienteRazonSocial" HeaderText=" CLIENTE" SortExpression="ClienteRazonSocial" >
                           <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Wrap="False" />
                           </asp:BoundField>
                           <asp:BoundField DataField="Descripcion" HeaderText="DESCRIPCION" >
                           <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                           </asp:BoundField>
                           <asp:BoundField DataField="TipoProceso" HeaderText="PROCESO CONTRUCTIVO" SortExpression="TipoProceso" >
                           <ItemStyle HorizontalAlign="Left" />
                           </asp:BoundField>
                           <asp:BoundField DataField="TipoSIstema" HeaderText="SISTEMA /  MODULO  /ZONA /PRUEBAS" SortExpression="TipoSIstema" >
                           <ItemStyle HorizontalAlign="Left" />
                           </asp:BoundField>
                           <asp:TemplateField HeaderText="ESTADO"></asp:TemplateField>
                           <asp:TemplateField HeaderText="APROB&lt;br&gt;DESAPROB"></asp:TemplateField>
                       </Columns>

                     <HeaderStyle CssClass="HeaderGrilla" />
                     <PagerStyle HorizontalAlign="Center" />
                     <RowStyle CssClass="ItemGrilla" Height="25px" />
                  
               </cc1:EasyGridView>
           </td>
       </tr>
   </table>


     <cc2:EasyGestorFiltro ID="EasyGestorFiltro1" runat="server" ClassHeader="HeaderGrilla"  Titulo="GESTION DE FILTROS-INSPECCION"    ClassItem="ItemGrilla" ClassItemAlternating="AlternateItemGrilla"  EasyFiltroCampos-Capacity="8"  DisplayButtonInterface="false" OnProcessCompleted="EasyGestorFiltro1_ProcessCompleted" OnItemCriterio="EasyGestorFiltro1_ItemCriterio">
     <cc2:EasyFiltroCampo Descripcion="Proyecto" Nombre="NroReporte">
         <DataInterconect MetodoConexion="WebServiceInterno">
             <UrlWebService>/GestiondeCalidad/Proceso.asmx</UrlWebService>
             <Metodo>BuscarProyInspec</Metodo>
             <UrlWebServicieParams>
                 <cc2:EasyFiltroParamURLws ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
             </UrlWebServicieParams>
         </DataInterconect>
         <EasyControlAsociado TemplateType="EasyITemplateAutoCompletar" NroCarIni="0" TextField="NombreProyecto"  ValueField="NroReporte" fncTempaleCustom="onDisplayTemplateNroReporte" />
     </cc2:EasyFiltroCampo>
     <cc2:EasyFiltroCampo Descripcion="Fecha de Inspección" Nombre="FechaReal" TipodeDato="Date" >
         <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect>
         <EasyControlAsociado TemplateType="EasyITemplateDatepicker" FormatOutPut="yyyymmdd" FormatInPut="dd/mm/yyyy" />
  
     </cc2:EasyFiltroCampo>
      <cc2:EasyFiltroCampo Descripcion="Razon Social Cliente" Nombre="IdCliente" TipodeDato="String">
          <DataInterconect MetodoConexion="WebServiceInterno">
              <UrlWebService>/GestiondeCalidad/Proceso.asmx</UrlWebService>
              <Metodo>BuscarProyectoXCliente</Metodo>
              <UrlWebServicieParams>
                  <cc2:EasyFiltroParamURLws ParamName="UserName" Paramvalue="UserName"  ObtenerValor="Session"  />
              </UrlWebServicieParams>
          </DataInterconect>
          <EasyControlAsociado NroCarIni="4" TemplateType="EasyITemplateAutoCompletar"  TextField  ="RazonSocialCliente"  ValueField="IdCliente" />
      </cc2:EasyFiltroCampo>

      <cc2:EasyFiltroCampo Descripcion="Taller o Contratista" Nombre="IdEntidad" TipodeDato="String">
          <DataInterconect MetodoConexion="WebServiceInterno">
              <UrlWebService>/GestiondeCalidad/Proceso.asmx</UrlWebService>
              <Metodo>BuscarAreaEntidad_Inspeccion</Metodo>
              <UrlWebServicieParams>
                  <cc2:EasyFiltroParamURLws ParamName="UserName" Paramvalue="UserName"  ObtenerValor="Session"  />
              </UrlWebServicieParams>
          </DataInterconect>
          <EasyControlAsociado NroCarIni="4" TemplateType="EasyITemplateAutoCompletar"  TextField  ="TalleoContratista"  ValueField="IdEntidad" />
      </cc2:EasyFiltroCampo>

      <cc2:EasyFiltroCampo Descripcion="Estado de Inspeccion" Nombre="IdEstado" TipodeDato="Int">
           <DataInterconect MetodoConexion="WebServiceInterno">
                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                <Metodo>ListarItems</Metodo>
                <UrlWebServicieParams>
                    <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="652" TipodeDato="String" />
                    <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                </UrlWebServicieParams>
         </DataInterconect>

      <EasyControlAsociado TemplateType="EasyITemplateDropdownList" TextField  ="Descripcion"  ValueField="Codigo" />
     </cc2:EasyFiltroCampo>


      <cc2:EasyFiltroCampo Descripcion="Tipo de Inspeccion" Nombre="IdTipoInspeccion" TipodeDato="Int">
           <DataInterconect MetodoConexion="WebServiceInterno">
                <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                <Metodo>ListarItems</Metodo>
                <UrlWebServicieParams>
                    <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="653" TipodeDato="String" />
                    <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                </UrlWebServicieParams>
         </DataInterconect>

      <EasyControlAsociado TemplateType="EasyITemplateDropdownList" TextField  ="Descripcion"  ValueField="Codigo" />
     </cc2:EasyFiltroCampo>


 </cc2:EasyGestorFiltro>



        <script>
            function onDisplayTemplateNroReporte(ul, item) {
                var cmll = "\"";
                iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                    + '<div class= "flex-column">' + item.NombreProyecto
                    + '    <p><small style="font-weight: bold">CLIENTE:</small> <small style ="color:red">' + item.ClienteRazonSocial + '</small><BR>'
                    + '    <small style="font-weight: bold">JEFE PROY:</small><small style="color:blue;text-transform: capitalize;">' + item.JefeProyecto + '</small><BR>'
                    + '    <small style="font-weight: bold">TIPO PROCESO:</small><small style="color:blue;text-transform: capitalize;">' + item.TipoProceso + '</small></p>'
                    + '    <span class="badge badge-info badge-pill"> ' + item.NroReporte + '</span>'
                    + '    <span class="badge badge-info "> ' + item.LineaNegocio + '</span>'
                    + '</div>'
                    + '<div class="image-parent">'
                    + '<img class=" rounded-circle" width="60px" src="' + AdministrarSolicitudAprobacion.PathFotosPersonal + item.NroDocIdentidad + '.jpg" alt="Jefe de proy:=' + item.JefeProyecto + '"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                    + '</div>'
                    + '</a>';

                var oCustomTemplateBE = new EasyGestorFiltro1_NroReporte.CustomTemplateBE(ul, item, iTemplate);

                return EasyGestorFiltro1_NroReporte.SetCustomTemplate(oCustomTemplateBE);

            }




        </script>



    <script>

        AdministrarSolicitudAprobacion.ItemplateMsgSupervisor = function (NroMsg) {
            var oRow = EasyGridView1.GetRowActive();
            var Ctrl = oRow.cells[1].children[0];

            var oDiv = jNet.get(Ctrl).clone();
            if (NroMsg > 0) {
                jNet.get(oDiv.children[1]).attr("width", "150px");
            }
            else {
                jNet.get(oDiv).attr("width", "150px");//imagen
            }

            var MsgTemplate = '<table border=0 width="100%">'
                + '<tr>'
                + '     <td align="center">' + oDiv.outerHTML + '</td>'
                + '</tr>'
                + '<tr>'
                + '     <td align="center">Ingreses aquí el mensaje<br><input type="text" id="txtMsg"  width="100%"/> </td>'
                + '</tr>'
                + '</table>';

            return MsgTemplate;
        }


        AdministrarSolicitudAprobacion.ItemplateSolicitud = function (e) {
            var oImg = jNet.get(e);
            var strMsg = Data.ApellidosyNpmbresUS + ' esta solicitando la aprobación de la siguiente RI <br>' ;
            var Tipomsg = ((Data.IdTipoPlazo == "4") ? " El cual está a la espera de su aprobación" : 'cuyo plazo establecido se ejecutará en ' + Data.TiempoPlazo + ' ' + Data.PlazoNombre);

            var MsgTemplate = '<table border=0 width="100%" id="tblSendAprob">'
                + '<tr>'
                + '     <td colspan=2 align="center"><img width="220px" class="ms-n2 rounded-circle img-fluid" src="' + oImg.src + '" /></td>'
                + '</tr>'
                + '<tr>'
                + '     <td colspan=2 align="center"><br>' + strMsg + Tipomsg + '</td>'
                + '</tr>'
                + '</table>';


            return MsgTemplate;
        }

        
        AdministrarSolicitudAprobacion.ItemplateAprobDesaprob = function (e) {
            var oImg = jNet.get(e);
            var MsgTemplate = '<div>'
                            + ' <table border = 0 width = "100%"  class="ItemDisponible" Data = "{Estado:3}" onclick = "javascript:AdministrarSolicitudAprobacion.OnSelected(this);" > '
                            + ' <tr>'
                            + '     <td  align="right" width="20%"><img width="80px" src="' + SIMA.Utilitario.Constantes.ImgDataURL.IconAprobado + '" /></td>'
                            + '     <td  align="left">APROBAR</td>'
                            + ' </tr>'
                            + ' </table>'
                            + ' <table border=0 width="100%"  class="ItemDisponible" Data="{Estado:4}"   onclick="javascript:AdministrarSolicitudAprobacion.OnSelected(this);">'
                            + ' <tr>'
                            + '     <td  align="left" width="20%"><img width="80px" src="' + SIMA.Utilitario.Constantes.ImgDataURL.IconDesaprobado + '" /></td>'
                            + '     <td  align="left">DESAPROBAR</td>'
                            + ' </tr>'
                            + ' </table>'
                            + ' </div>';

            return MsgTemplate;
        }



        var Data = null;
        AdministrarSolicitudAprobacion.InfoSolicitud = function (e) {

            var oRow = jNet.get(e.parentNode.parentNode);//Obtiene la fila de la grilla
            EasyGridView1_OnRowClick(oRow);
            SIMA.GridView.Extended.OnEventClickChangeColor(oRow);
            Data = EasyGridView1.GetDataRow(oRow.attr("Guid"));

            var ConfigMsgb = {
                Titulo: 'ENVIAR MENSAJE'
                , Descripcion: AdministrarSolicitudAprobacion.ItemplateSolicitud(e)
                , Icono: 'fa fa-tag'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }



        AdministrarSolicitudAprobacion.AprobadoDesaprobado = null;
        AdministrarSolicitudAprobacion.OnSelected = function (e) {
            var DataActiva = jNet.get(e).attr("Data").toString().SerializedToObject();
            AdministrarSolicitudAprobacion.AprobadoDesaprobado = DataActiva.Estado;
            var objContent = jNet.get(e.parentNode);
            objContent.forEach(function (ochild, i) {
                var oDataBE = ochild.attr("Data").toString().SerializedToObject();
                nclass = ((oDataBE.Estado == AdministrarSolicitudAprobacion.AprobadoDesaprobado) ? "ItemSelected" : "ItemDisponible");
                ochild.attr("class", nclass);
            });
        }

        AdministrarSolicitudAprobacion.AprobarDesaprobar = function (e) {
            var oRow = jNet.get(e.parentNode.parentNode);//Obtiene la fila de la grilla
            EasyGridView1_OnRowClick(oRow);
            SIMA.GridView.Extended.OnEventClickChangeColor(oRow);
            Data = EasyGridView1.GetDataRow(oRow.attr("Guid"));
            if (Data["IdEstadoAProb"].toString().Equal("3")) {
                var msgConfig = { Titulo: "Advertencia", Descripcion: "El RI ya se encuentra aprobada" };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
            else {

                var ConfigMsgb = {
                                    Titulo: 'APROBAR/DESAPROBAR'
                                    , Descripcion: AdministrarSolicitudAprobacion.ItemplateAprobDesaprob(e)
                                    , Icono: 'fa fa-tag'
                                    , EventHandle: function (btn) {
                                                        if (btn == 'OK') {
                                                            var oParamCollections = new SIMA.ParamCollections();
                                                            var oParam = new SIMA.Param("IdInspeccion", Data["IdInspeccion"]);
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param("IdPersonalFirmante", Data["IdPersonaFirmante"], TipodeDato.Int);
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param("_TokenID", Data["Token"]);
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param("IdEstado", AdministrarSolicitudAprobacion.AprobadoDesaprobado, TipodeDato.Int);
                                                            oParamCollections.Add(oParam);
                                                            oParam = new SIMA.Param("UserName", AdministrarSolicitudAprobacion.Params["UserName"]);
                                                            oParamCollections.Add(oParam);

                                                            var oEasyDataInterConect = new EasyDataInterConect();
                                                            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                                                            oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                                                            oEasyDataInterConect.Metodo = 'AprobarSolicitudFI';
                                                            oEasyDataInterConect.ParamsCollection = oParamCollections;

                                                            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                                                            var obj = oEasyDataResult.sendData();
                                                            if (obj != undefined) {
                                                                jNet.get(e).attr("src", ((AdministrarSolicitudAprobacion.AprobadoDesaprobado == 3) ? SIMA.Utilitario.Constantes.ImgDataURL.IconAprobado : SIMA.Utilitario.Constantes.ImgDataURL.IconDesaprobado));
                                                                return true;
                                                            }
                                                        }
                                     }
                                };
                var oMsg = new SIMA.MessageBox(ConfigMsgb);
                oMsg.confirm();

            }

        }


        AdministrarSolicitudAprobacion.VistaPreviaFI = function (e) {
            var cmll = "\"";
            var oRow = jNet.get(e.parentNode.parentNode);//Obtiene la fila de la grilla
            EasyGridView1_OnRowClick(oRow);
            SIMA.GridView.Extended.OnEventClickChangeColor(oRow);
           
            Page.Postback.CallBtn("btnPrevioRpt", "{Guid:" + cmll + oRow.attr("Guid") + cmll + "}");
            
        }







    </script>
          <asp:Button ID="btnPrevioRpt" runat="server" OnClick="btnPrevioRpt_Click" Text="PrevioRpt" />

    </form>

    </body>
</html>
