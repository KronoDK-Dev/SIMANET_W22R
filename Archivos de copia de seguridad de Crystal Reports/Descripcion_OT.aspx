<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Descripcion_OT.aspx.cs" Inherits="SIMANET_W22R.GestionProduccion.OT.Descripcion_OT" %>
<!-- ************ REFERENCIAS A LOS CONTROLES ************* -->
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc5" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<!-- <%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %> -->
<!-- <%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc4" %> -->

<!-- ******************************************************************* -->
<!-- ************ REFERENCIAS A ESTILOS ************* -->
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/StyleEasy.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/Personalizado.css") %> ">
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Descripcion de Orden de Trabajo</title>
        <script>
        function actualizar_autorizacion(idtrabajador, estado) {
            alert(idtrabajador);
        }

        function OnEasyGridButton_Click(btn, data) {
            // alert();
            pbConfirmar.Show();
        }

        function fnPopup() {

            pbConfirmar.Show();
        }

        function Espera() {
            SIMA.Utilitario.Helper.Wait('OT', 1000, function () { });
        }

        </script>
    <style type="text/css">
        .auto-style1 {
            height: 26px;
            color: #020f73;
        }
     
     
    </style>
</head>
<body>
    <form id="form1" runat="server">
       <!-- **************** inicio tabla contenido de la pagina****************************************** --->
        <table style="width:100%;"  border="0" class="responsive-table">
         <!-- **************************cabecera******************************** --->
         <tr>
                <td class="auto-style1">
                    <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" /> 
                </td>
                <td>   </td>
          </tr>
         <!-- ******  cuerpo CON EASY FROM **************************************************** -->
        <tr>
            <td colspan ="3" >
                <center>
                      <h1 class="display-6">DESCRIPCIÓN DE OT</h1>
                      <p class="lead mb-0">Modificación de la descripción de la Orden de Trabajo</p>
                      <p class="font-italic"></p>
                </center>
            </td> 
        </tr>  
            <!-- ******cuerpo**************************************************** -->
         <tr>
         <td> 
         
               <table class="responsive-table" border="0"  >
                  <!--   *******fila espacio************ w-100*************  -->                           
                 <tr>
                     <td colspan="3" >  <h2> FILTROS DE BÚSQUEDA</h2> </td>
                 </tr> 
                 <tr>
                     <td colspan="3">&nbsp;</td>
                  </tr>
                 <!--   ************class="auto-style2"***********  estilo color (fondo actual=#fff  nuevo fondo=#e5ecef): form-control (Bootstrap.min.css) sin_borde *********  -->                            
                 <tr>
                     <td width="15%" >
                         <asp:Label ID="Label2" runat="server" Text="N° de Orden de Trabajo:" CssClass="tabulacion-control"
                             BorderWidth="0px" Width="100%"></asp:Label>
                     </td>
                     <td colspan="2">
                       <cc3:EasyNumericBox ID="enbOTs" runat="server" CssClass="input-control" NroDecimales="0" STYLE="width:110px" EnableOnChange="True" 
                           Requerido="True" MensajeValida="Este dato es obligatorio" Etiqueta="N° OT">
                         <EasyStyle Ancho="Dos" TipoTalla="xs"></EasyStyle>
                     </cc3:EasyNumericBox>
                     </td>
                 </tr>
               <!--   *******fila espacio*************************  -->    
                 <tr>
                     
                     <td colspan="3">
                         &nbsp;</td>
                 </tr>
               <!--   ********************************  -->       
                  <tr>
                    <td  width="15%">
                        <asp:Label ID="Label1" runat="server" Text="Línea de Negocio:" CssClass="tabulacion-control" 
                            BorderWidth="0px" Width="100%"></asp:Label>
                    </td>
                    <td class="auto-style2" width="25%" >
                          <cc3:EasyDropdownList ID="EDDL_LineaNegocio" runat="server" Width="90%" 
                           OnSelectedIndexChanged="EDDL_LineaNegocio_SelectedIndexChanged"
                           EnableOnChange="True"  
                           autocomplete="on" CssClass="input-control" Requerido="True" AutoPostBack="True" MensajeValida="Este dato es obligatorio" Etiqueta="Línea de Negocio">
                       </cc3:EasyDropdownList>
                      </td>
                      <td>
                         <asp:ImageButton ID="btnCarga" runat="server" ImageAlign="Middle" ToolTip ="Buscar OT" CssClass="image-button"   
                        ImageUrl="~/Recursos/img/buscar.png" OnClick="btnCarga_Click" Width="50px" Height="35px"  />
                      <asp:Panel ID="pnlMessage" runat="server"></asp:Panel>
       
                    </td>
                </tr>
                <!--   *******fila espacio*************************  -->                           
               
                 <tr>
                     <td >&nbsp;</td>
                     <td colspan="2">    &nbsp;</td>
                 </tr>

                 <tr>
                     <td  width="15%" >
                         <asp:Label ID="Label3" runat="server" Text="Descripción:" CssClass="tabulacion-control" 
                              BorderWidth="0px" Width="100%"></asp:Label>
                     </td>
                     <td  class="auto-style1"  >
                            <asp:Label ID="lblDescripción" runat="server" Text="" CssClass="input-control auto-resize-label " 
                              BorderWidth="0px" Width="100%"></asp:Label>
        
                     </td>
                     <td >
                        
                     </td>
                 </tr>
              <!--   *******fila espacio*************************  -->    
                 <tr>
                     <td colspan="3">
                         &nbsp;</td>
                 </tr>
                   <!--   *******fila espacio*************************  -->    
                   <tr>
                     
                       <td colspan="3">
                           &nbsp;</td>
                   </tr>
                  <!--   ********************************  -->     
                  <tr>
                     <td colspan="3" >  <h2> DATOS DE ACTUALIZACIÓN</h2> </td>
                 </tr>  
                      <!--   ********************************  -->    
                   <tr>
                      <td colspan="2"  > 
                         <!--  -->
 
                        <asp:Label ID="lblmensaje" runat="server" Text="" BorderWidth="0px"
                            CssClass="form-control alert-warning" Width ="100%" ></asp:Label>
     
                      </td>
                       <td >&nbsp;</td>
                  </tr>
       
                 <tr>
                     <td width="15%" class="auto-style3">
                         <asp:Label ID="Label4" runat="server" Text="Usuario Solicitante Cambio:" CssClass="tabulacion-control"
                              BorderWidth="0px" Width="100%"></asp:Label>
                     </td>
                    <td width="28%">
                          <cc3:EasyAutocompletar ID="EAC_usuarios" runat="server" Width="35%" DisplayText="V_DESCRIPCION" ValueField="CODIGO" 
                              fnOnSelected="Descripcion_OT.onEasyFind_Selected" 
                              fncTempaleCustom="Descripcion_OT.onDisplayTemplateUsuUNIX" 
                              MensajeValida="Este dato es obligatorio" EnableOnChange="True" Etiqueta="Usuario Solicita">
                        <EasyStyle Ancho="Dos" TipoTalla="sm"></EasyStyle>
                        <DataInterconect MetodoConexion="WebServiceInterno">
                            <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                            <Metodo>ListaU</Metodo>
                              <UrlWebServicieParams>
                                  <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                            </UrlWebServicieParams>
                              </DataInterconect>
                          </cc3:EasyAutocompletar>
 

                     </td>
                     <td >&nbsp;</td>
                 </tr>
                <!--   *******fila espacio*************************  -->    
                 <tr>
                     <td colspan="3"  > </asp:Panel></td>
                
                 </tr>
                 <!--   *******fila espacio*************************  -->    
                <tr>
                    <td colspan ="3" >&nbsp;</td>
                </tr>

                <!--   ********************************  -->   
              <!--   ********************************  -->   
                  <tr>
                     <td  width="15%">   
                         <asp:Label ID="Label6" runat="server" Text="DESCRIPCIÓN A ACTUALIZAR:" CssClass="tabulacion-control"
                              BorderWidth="0px" Width="100%" Visible ="true" ></asp:Label></td>
                        <td colspan="2">
                            <cc3:EasyTextBox ID="ETdescripcion" runat="server" Width="33%"
                                
                                MensajeValida="Este dato es obligatorio" 
                                Requerido="True"
                                TextMode="MultiLine" Font-Size="Large" MaxLength="2000" Etiqueta="Descripcion upd"></cc3:EasyTextBox>

                            
                     </td>
                 </tr>  
                 <!--   *******fila espacio*************************  -->    
                <tr>
                    <td >&nbsp;</td>
                </tr>

                   <tr>
                     <td  width="15%">   
                      
                     </td>

                    <td colspan="2">
                        <asp:Button ID="btnActualizar" runat="server" Text="Aceptar"  CssClass="button-celeste" 
                            onClientClick="javascript:if(!confirm('Esta seguro Actualizar la Descripción de la OT?') ) { return false; } else { Espera(); }  ;"  
                            OnClick="btnActualizar_Click" />
                     </td> 
                 </tr>
               <!--   *******fila espacio*************************  -->    
                <tr>
                    <td >&nbsp;</td>
                </tr>

               </table>
         </td>
          <td>

         </td>
     </tr> 
     
        </table>
       <!-- ****************fin tabla****************************************** --->
    </form>
       <!-- **************** BLOQUE DE PROCEDIMIENTO Y FUNCIONES JAVASCRIPT ****************************************** --->
    <script>
        // para usar esta funcion: <cc2:EasyFiltroParamURLws ObtenerValor="FunctionScript" ParamName="v_ambiente" Paramvalue="Descripcion_OT.ObteberAmbiente" TipodeDato="String"></cc2:EasyFiltroParamURLws>
        Descripcion_OT.ObtenerAmbiente = function () {
            return IMA.Utilitario.Helper.Configuracion.Leer("Seguridad", "Ambiente");
        }

        Descripcion_OT.onEasyFind_Selected = function (value, ItemBE) {
           
        }
        Descripcion_OT.onDisplayTemplateUsuUNIX = function (ul, item) {
            var cmll = "\"";
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + '         <div class= "flex-column">' + item.V_DESCRIPCION
                + '             <p><small style="font-weight: bold">User:</small> <small style ="color:red">' + item.CODIGO + '</small><br>'
            //    + '             <img class=" rounded-circle" width="60px" src="' + Descripcion_OT.PathFotosPersonal + item.NroDocIdentidad + '.jpg" alt="Usuario:=' + item.V_DESCRIPCION + '"  onerror="this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;">'
                + '         </div>'
                + '</a>';
            var oCustomTemplateBE = new EAC_usuarios.CustomTemplateBE(ul, item, iTemplate);
            return EAC_usuarios.SetCustomTemplate(oCustomTemplateBE);
        }

    </script>

</body>
</html>

