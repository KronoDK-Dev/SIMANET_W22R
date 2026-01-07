<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleProyecto.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.DetalleProyecto" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc4" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>





<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
   

    <script>
        function onItemSeleccionadoProyecto(value, ItemBE) {
            EasyACCodigo.SetValue(ItemBE.CODIGOPROY, ItemBE.CODIGOPROY);
        }
        function onItemClienteSeleccionado(value, ItemBE) {

        }


        function onDisplayTemplateProyecto(ul, item) {
            var cmll = "\"";
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '<div class= "flex-column">' + item.NOMBREPROY
                + '    <p><small style="font-weight: bold">Nro PROY:</small> <small style ="color:red">' + item.CODIGOPROY + '</small>'
                + '</div>'
                + '</a>';

            var oCustomTemplateBE = new EasyAcBuscarProy.CustomTemplateBE(ul, item, iTemplate);

            return EasyAcBuscarProy.SetCustomTemplate(oCustomTemplateBE);
        }



    </script>

</head>
<body>
    <form id="form1" runat="server">
            <table style="width:100%">
                <tr>
                    <td class="Etiqueta">
                        <asp:Label ID="Label1" runat="server" Text="PROYECTO"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                     <td>&nbsp;</td>

                </tr>
                <tr>
                    <td colspan="4" style="width:100%"> 
                           <cc3:EasyAutocompletar ID="EasyAcBuscarProy" runat="server" NroCarIni="2"  DisplayText="NOMBREPROY" ValueField="CODIGOPROY" fnOnSelected="onItemSeleccionadoProyecto" fncTempaleCustom="onDisplayTemplateProyecto">
                            <EasyStyle Ancho="Dos" TipoTalla="md"></EasyStyle>
                            <DataInterconect MetodoConexion="WebServiceInterno">
                                 <UrlWebService>/GestionProduccion/Proyectos.asmx</UrlWebService>
                                 <Metodo>BProyectoxNombre</Metodo>
                                 <UrlWebServicieParams>
                                     <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session"/>
                                 </UrlWebServicieParams>
                             </DataInterconect>
                        </cc3:EasyAutocompletar>   

                    </td>
                </tr>
                <tr>
                    <td style="width:10%" class="Etiqueta">
                        <asp:Label ID="Label2" runat="server" Text="CODIGO"></asp:Label>
                    </td>
                    <td style="width:30%">
                           <cc3:EasyAutocompletar ID="EasyACCodigo" runat="server" NroCarIni="4"  DisplayText="CODIGOPROY" ValueField="CODIGOPROY" fnOnSelected="onItemSeleccionado" fncTempaleCustom="onDisplayTemplateProyecto" >
                                <EasyStyle Ancho="Dos"></EasyStyle>
                                <DataInterconect MetodoConexion="WebServiceInterno">
                                     <UrlWebService>/GestionProduccion/Proyectos.asmx</UrlWebService>
                                     <Metodo>BProyectoxCodigo</Metodo>
                                     <UrlWebServicieParams>
                                         <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                     </UrlWebServicieParams>
                                 </DataInterconect>
                            </cc3:EasyAutocompletar>   
                    </td>
                    <td style="width:20%" class="Etiqueta">
                        <asp:Label ID="Label4" runat="server" Text="LINEA DE NEGOCIO"></asp:Label>
                    </td>
                     <td>
                          <cc3:EasyDropdownList ID="ddlLineNegocio" runat="server" DataTextField="DESCRIPCION" DataValueField="CODIGO"  MensajeValida="No se ha seleccionado el proceso productivo" Requerido="True" CargaInmediata="True">
                             <EasyStyle Ancho="Dos"></EasyStyle>
                             <DataInterconect MetodoConexion="WebServiceInterno">
                                 <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                 <Metodo>ListarItems</Metodo>
                                 <UrlWebServicieParams>
                                     <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="28" TipodeDato="String" />
                                     <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                 </UrlWebServicieParams>
                             </DataInterconect>
                         </cc3:EasyDropdownList>
                     </td>
                </tr>
                <tr>
                    <td class="Etiqueta">
                        <asp:Label ID="Label3" runat="server" Text="CLIENTE"></asp:Label>
                    </td>
                    <td> </td>
                    <td></td>
                     <td></td>
                </tr>
                <tr>
                    <td colspan="4">   
                         <cc3:EasyAutocompletar ID="EasyAcCliente" runat="server" NroCarIni="4"  DisplayText="RazonSocialCliente" ValueField="IdCliente" fnOnSelected="onItemClienteSeleccionado">
                              <EasyStyle Ancho="Dos"></EasyStyle>
                              <DataInterconect MetodoConexion="WebServiceInterno">
                                   <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                                   <Metodo>BuscarCliente</Metodo>
                                   <UrlWebServicieParams>
                                       <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                   </UrlWebServicieParams>
                               </DataInterconect>
                          </cc3:EasyAutocompletar>   
                    </td>
                </tr>
                <tr>
                    <td class="Etiqueta">
                        <asp:Label ID="Label5" runat="server" Text="DESCRIPCION"></asp:Label>
                    </td>
                    <td></td>
                    <td></td>
                     <td></td>
                </tr>
                <tr>
                    <td colspan="4"><cc4:EasyTexto ID="txtDescripcion" runat="server" Width="100%" TextMode="MultiLine" Height="50px"></cc4:EasyTexto> </td>
                </tr>
            </table>

       

    </form>
    <script>
        DetalleProyecto.OnValidate = function () {
            var msgText = "";
            
            if (EasyAcBuscarProy.GetText().length == 0) {
                var msgConfig = { Titulo: 'Error', Descripcion: 'Origen:OnValidate\n' + 'Mensaje:' + 'No se ha ingreasado Nombre de Proyecto'};
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
                return false;
            }

            if (ddlLineNegocio.GetValue() == "-1") {
                var msgConfig = { Titulo: 'Error', Descripcion: 'Origen:OnValidate\n' + 'Mensaje:No se ha seleccionado Linea de negocio'};
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
                return false;
            }

            if (EasyAcCliente.GetText().length == 0) {
                var msgConfig = { Titulo: 'Error', Descripcion: 'Origen:OnValidate\n' + 'Mensaje:No se ha Ingresado Cliente' };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
                return false;
            }

            return true;
        }

        DetalleProyecto.btnAceptar = function () {
            if (DetalleProyecto.OnValidate()) {
                switch (DetalleProyecto.Params[DetalleProyecto.KEYMODOPAGINA]) {
                    case SIMA.Utilitario.Enumerados.ModoPagina.N:
                        return ((DetalleProyecto.Insertar()==1)?true:false);
                        break;
                    case SIMA.Utilitario.Enumerados.ModoPagina.M:
                        return ((DetalleProyecto.Modificar() == 1) ? true : false);
                        break;

                }
            }
          
        }
        DetalleProyecto.Insertar = function () {
            return DetalleProyecto.Commit(DetalleProyecto.Params[DetalleProyecto.KEYIDPROYECTO]);
        }
        DetalleProyecto.Modificar = function () {
            return DetalleProyecto.Commit(0);
        }

        DetalleProyecto.Commit = function (IdProy) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionProduccion/Proyectos.asmx";
            oEasyDataInterConect.Metodo = "ProyectoInsAct";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdProyecto", IdProy, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Codigo", EasyACCodigo.GetText());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Nombre", EasyAcBuscarProy.GetText());
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Descripcion", jNet.get('txtDescripcion').value);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdCliente", EasyAcCliente.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdLN", ddlLineNegocio.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdEstado", "1", TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdUsuario", DetalleProyecto.Params["IdUsuario"], TipodeDato.Int);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("UserName", DetalleProyecto.Params["UserName"]);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);

            var Result = oEasyDataResult.sendData();
                        
            return Result;
        }
    </script>
</body>
</html>
