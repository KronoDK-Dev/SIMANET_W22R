<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReporteCompartir.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.ReporteCompartir" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

 
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%">
            <tr>
                <td>
                     <cc3:EasyAutocompletar ID="acFindUsuario" runat="server" NroCarIni="4"  DisplayText ="ApellidosyNombres"  Width="100%" ValueField="idUsuario" fnOnSelected="ReporteCompartir.onItemSeleccionado" fncTempaleCustom="ReporteCompartir.onDisplayItemUsuario" >
                        <EasyStyle Ancho="Dos"></EasyStyle>
                            <DataInterconect MetodoConexion="WebServiceInterno">
                                <UrlWebService>/GestionReportes/Procesar.asmx</UrlWebService>
                                <Metodo>BuscarUsuarios</Metodo>
                                <UrlWebServicieParams>
                                    <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                </UrlWebServicieParams>
                            </DataInterconect>
                    </cc3:EasyAutocompletar>
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:EasyGridView ID="EasyGridViewCompartir" runat="server" AutoGenerateColumns="False" TituloHeader="DETALLE" ToolBarButtonClick="ReporteCompartir.ToolBarButtonClick" Width="100%" ShowRowNumber="False" fncExecBeforeServer="" BorderColor="White" OnRowDataBound="EasyGridViewCompartir_RowDataBound">
                          <EasyGridButtons>
                              <cc1:EasyGridButton ID="btnEliminar" Descripcion="Eliminar" Icono="" MsgConfirm="Desea dejar de comparir con este usuario ahora?" RequiereSelecciondeReg="True" RunAtServer="False" SolicitaConfirmar="True" Texto="Eliminar" Ubicacion="Derecha" />
                          </EasyGridButtons>
                          <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />

                         <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" ></EasyExtended>

                     <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                         <AlternatingRowStyle CssClass="AlternateItemGrilla" BorderColor="White" BackColor="White" />
                         <Columns>
                             <asp:BoundField DataField="ApellidosyNombres" HeaderText="USUARIO COMPARTIDO">
                             <ItemStyle HorizontalAlign="Left" Width="80%" />
                             </asp:BoundField>
                             <asp:TemplateField HeaderText="VER">
                             <ItemStyle Width="5%"></ItemStyle>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="COMPARTIR">
                                 <ItemStyle Width="5%" />
                             </asp:TemplateField>
                         </Columns>
                         <HeaderStyle CssClass="HeaderGrilla" Height="25px" />
                         <RowStyle CssClass="ItemGrilla" Height="35px" BorderColor="White" BackColor="White" />
                     </cc1:EasyGridView>
                </td>
            </tr>

        </table>
    </form>
       <script>

           ReporteCompartir.ToolBarButtonClick = function (btnItem, DetalleBE) {
               switch (btnItem.Id) {
                   case "btnEliminar":
                       EasyPopupCompartir.ProgressBar.Show('Enviando mensaje por correo');
                       EasyPopupCompartir.Task.Excecute('Enviando mensaje por correo', function () {
                                                                                       ReporteCompartir.Commit(DetalleBE.IdUsuario, ReporteCompartir.Params[ReporteCompartir.KEYQNOMBREOBJETO], DetalleBE.login + "@sima.com.pe", 0);
                                                                                   });
                       break;
               }
           }

           ReporteCompartir.onItemSeleccionado = function (value, ItemBE) {
               EasyPopupCompartir.Task.Excecute('Enviando mensaje por correo', function () {
                                                                                   ReporteCompartir.Commit(ItemBE.idUsuario, ReporteCompartir.Params[ReporteCompartir.KEYQNOMBREOBJETO], ItemBE.login + "@sima.com.pe", 1);
                                                                               });
           }

           ReporteCompartir.Commit = function (IdUsuario, Descripcion, Email, IdEstado) {
               // 
               var oParamCollections = new SIMA.ParamCollections();
               var oParam = new SIMA.Param("IdObjeto", ReporteCompartir.Params[ReporteCompartir.KEYQIDOBJETO], TipodeDato.Int);
               oParamCollections.Add(oParam);
               oParam = new SIMA.Param("IdUsuarioComp", IdUsuario, TipodeDato.Int);
               oParamCollections.Add(oParam);
               oParam = new SIMA.Param("EmailComp", Email);
               oParamCollections.Add(oParam);
               oParam = new SIMA.Param("Descripcion", Descripcion);
               oParamCollections.Add(oParam);
               oParam = new SIMA.Param("Owner", 1, TipodeDato.Int);
               oParamCollections.Add(oParam);
               oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
               oParamCollections.Add(oParam);
               oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
               oParamCollections.Add(oParam);
               oParam = new SIMA.Param("IdEstado", IdEstado, TipodeDato.Int);
               oParamCollections.Add(oParam);

               var oEasyDataInterConect = new EasyDataInterConect();
               oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
               oEasyDataInterConect.UrlWebService = '/GestionReportes/Procesar.asmx';
               oEasyDataInterConect.Metodo = 'CompartirObjeto';
               oEasyDataInterConect.ParamsCollection = oParamCollections;

               var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
               var obj = oEasyDataResult.sendData();
               EasyPopupCompartir.Reload();
           }

           function EasyPopupCompartir_Aceptar() {
               var oDataBE = AdministrarReporte.Navigator.Node.Select.Data;
               AdministrarReporte.LoadUser(oDataBE.IdObjeto);
               return true;
           }


           ReporteCompartir.onDisplayItemUsuario = function (ul, item) {
               var cmll = "\"";
               iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                   + '<div class= "flex-column">' + item.ApellidosyNombres
                   + '    <p><small style="font-weight: bold">Nro PR:</small> <small style ="color:red">' + item.NroPersonal + '</small>'
                   + '    <small style="font-weight: bold">AREA:</small><small style="color:blue;text-transform: capitalize;">' + item.NombreArea + '</small></p>'
                   + '    <span class="badge badge-info "> ' + item.login + '</span>'
                   + '</div>'
                   + '<div class="image-parent">'
                   + '<img class=" rounded-circle" width="60px" src="http://10.10.90.13/fotopersonal/' + item.NroDocDNI + '.jpg"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                   + '</div>'
                   + '</a>';

               var oCustomTemplateBE = new acFindUsuario.CustomTemplateBE(ul, item, iTemplate);

               return acFindUsuario.SetCustomTemplate(oCustomTemplateBE);
           }


       </script>
</body>
</html>
