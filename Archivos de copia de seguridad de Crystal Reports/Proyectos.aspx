<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Proyectos.aspx.cs" Inherits="SIMANET_W22R.GestionComercial.Administracion.Proyectos" %>
<%@ Register TagPrefix="cc6" Namespace="EasyControlWeb" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc2" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc3" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="uc1" TagName="Header" Src="~/Controles/Header.ascx" %>
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/StyleEasy.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/Personalizado.css") %> ">
<script src="<%= ResolveUrl("~/Recursos/js/jquery-3.6.4.min.js") %> "></script>
<script src="<%= ResolveUrl("~/Recursos/js/toastr.min.js") %> "></script>
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/toastr.min.css") %> ">
<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Recursos/css/sweetalert2.min.css") %> ">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet" /> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title>Proyectos</title>
  <script>
     function Espera() {
         SIMA.Utilitario.Helper.Wait('Proyectos', 1000, function () { });
     }
 </script>
</head>
<body>
    <form id="form1" runat="server">
    <table id="tblReport" style="width:100%"  border="0" >
    <tr>
        <td colspan="7" >
            <uc1:Header runat="server" ID="header" />
        </td>
    </tr>
    <!-- 07 columnas -->
    <tr>
       <td width="20px"></td>      
        <td width="10%"> 
             <asp:Label ID="lblCEO" runat="server" Text="Centro Operativo: " Width="150px" ></asp:Label><br/>
            
            <cc3:EasyDropdownList ID="eDDLCentros" runat="server" CargaInmediata="True" Width="150px"  
                DataTextField="NOMBRE" DataValueField="NROCENTROOPERATIVO" 
                EnableOnChange="True"  OnSelectedIndexChanged="fnRefrescaUD"  AutoPostBack="True" >
                <EasyStyle Ancho="Uno"></EasyStyle>
                <DataInterconect MetodoConexion="WebServiceInterno">
                   <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                    <Metodo>ListaCentrosOperativosPorPerfil</Metodo>
                    <UrlWebServicieParams>
                        <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="IdUsuario" Paramvalue="IdUsuario" TipodeDato="String" />
                        <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                    </UrlWebServicieParams>
                </DataInterconect>
            </cc3:EasyDropdownList>
        </td>
        <td width="10%"> 
               <asp:Label ID="lblUO" runat="server" Text="Unidad Operativa: " Width="150px"></asp:Label><br/>
              <cc3:EasyDropdownList ID="eDDLUnidadO" runat="server" CargaInmediata="True" Width="150px"  
                  DataTextField="NOMBRE" DataValueField="CODIGO" 
                  EnableOnChange="True"  OnSelectedIndexChanged="fnRefrescaLN"  AutoPostBack="True" >
                  <EasyStyle Ancho="Uno"></EasyStyle>
                  <DataInterconect MetodoConexion="WebServiceInterno">
                      <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                      <Metodo>ListaUnidad_OpexCEO</Metodo>
                      <UrlWebServicieParams>
                          <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" 
                              ParamName="sCodigo" Paramvalue="eDDLCentros" TipodeDato="String" />
                          <cc2:EasyFiltroParamURLws ObtenerValor="Session" 
                              ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                      </UrlWebServicieParams>
                  </DataInterconect>
              </cc3:EasyDropdownList>
          
        </td>  


        <td width="14%">
           <div>
            <asp:Label ID="lblLineaN" runat="server" Text="Linea Negocio: " style="display:inline-block;"></asp:Label> <br/>
            <cc3:EasyDropdownList ID="eDDLLineas" runat="server" CargaInmediata="True" 
                DataTextField="NOMBRE" DataValueField="CODIGO" OnSelectedIndexChanged="FnRefrescaSLN" AutoPostBack="True" >
                <EasyStyle Ancho="Uno"></EasyStyle>
                <DataInterconect MetodoConexion="WebServiceInterno">
                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                    <Metodo>ListaLineasNegxCEOxUO</Metodo>
                    <UrlWebServicieParams>
                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" 
                            ParamName="V_CEO" Paramvalue="eDDLCentros" TipodeDato="String"  />
                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" 
                            ParamName="V_UNDOPE"   Paramvalue="eDDLUnidadO" TipodeDato="String" />
                        <cc2:EasyFiltroParamURLws ObtenerValor="Session"
                            ParamName="USERNAME" Paramvalue="UserName" TipodeDato="String" />
                    </UrlWebServicieParams>
                </DataInterconect>
            </cc3:EasyDropdownList>
           </div> 

        </td> 
        <td width="10%">
           <div>
            <asp:Label ID="lblSLineaN" runat="server" Text="Sub Linea: " style="display:inline-block;"></asp:Label> <br/>
            <cc3:EasyDropdownList ID="eDDLSLineas" runat="server" CargaInmediata="True" 
                DataTextField="NOMBRE" DataValueField="CODIGO" >
                <EasyStyle Ancho="Uno"></EasyStyle>
                <DataInterconect MetodoConexion="WebServiceInterno">
                    <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                    <Metodo>ListaSubLineasNegxCEOxUOxL</Metodo>
                    <UrlWebServicieParams>
                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" 
                            ParamName="V_CEO" Paramvalue="eDDLCentros" TipodeDato="String"  />
                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" 
                            ParamName="V_UNDOPE"   Paramvalue="eDDLUnidadO" TipodeDato="String" />
                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" 
                            ParamName="V_LINEA"   Paramvalue="eDDLLineas" TipodeDato="String" />
                        <cc2:EasyFiltroParamURLws ObtenerValor="Session"
                            ParamName="USERNAME" Paramvalue="UserName" TipodeDato="String" />
                    </UrlWebServicieParams>
                </DataInterconect>
            </cc3:EasyDropdownList>
           </div> 

        </td> 
        <td>
                <asp:Label ID="lblbusqueda" runat="server" Text="Criterio Búsqueda: "></asp:Label><br/>
               <cc3:EasyTextBox ID="etbCriterio" runat="server" onkeydown="checkEnter(event)" Width="25%" style="display:inline-block;"  ></cc3:EasyTextBox>
               <asp:Button ID="btnBuscar" runat="server" Text="Buscar"  CssClass="button-celeste"  Icono ="fa fa-search"   OnClick="btnBuscar_Click" OnClientClick="Espera();"  />

        </td> 


        <td width="20px"></td>      
    </tr>

    <tr>
        <td width="20px"></td>      
        <td colspan="5" >
            <cc6:EasyGridView ID="EGVproyectos" runat="server" CssClass="STgridview"
                AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Proyectos" 
                AllowPaging="True" PageSize="10" Width="100%"
                ToolBarButtonClick="OnEasyGridButton_Click" 
                OnEasyGridButton_Click ="EGV_EasyGridButton_Click"
                OnPageIndexChanging    ="EGV_PageIndexChanged"   
                OnEasyGridDetalle_Click="EGV_EasyGridDetalle_Click" 
                 >
                <EasyGridButtons>
                    <cc6:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="True" Texto="Agregar" Ubicacion="Izquierda" />
                    
                </EasyGridButtons>

                <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                <DataInterconect MetodoConexion="WebServiceInterno">
                    <UrlWebService>/GestionComercial/Proceso.asmx</UrlWebService>
                    <Metodo>ListarProyectos</Metodo>
                    <UrlWebServicieParams>

                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_CEO"         Paramvalue="eDDLCentros" TipodeDato="String" />
                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_UND_OPER"      Paramvalue="eDDLUnidadO" TipodeDato="String" />
                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_LINEA"    Paramvalue="eDDLSLineas" TipodeDato="String" />                       
                        <cc2:EasyFiltroParamURLws ObtenerValor="FormControl" ParamName="V_FILTRO"      Paramvalue="etbCriterio" TipodeDato="String" />
                        <cc2:EasyFiltroParamURLws ObtenerValor="Fijo"        ParamName="V_FEC_STR_INI" Paramvalue="" TipodeDato="String" />
                        <cc2:EasyFiltroParamURLws ObtenerValor="Fijo"        ParamName="V_FEC_STR_FIN" Paramvalue="" TipodeDato="String" />
                    </UrlWebServicieParams>
                </DataInterconect>
                
                <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>
                <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                <Columns>
                    <asp:BoundField DataField="COD_PRY" HeaderText="PROYECTO" />
                    <asp:BoundField DataField="COD_DIV" HeaderText="SUBLINEA" />
                    <asp:BoundField DataField="DES_PRY" HeaderText="DESCRIPCIÓN" />
                    <asp:BoundField DataField="V_PRY_UNDOPER" HeaderText="UNIDAD OPERA" />          
                    <asp:BoundField DataField="FEC_REG" HeaderText="F. REGISTRO" />
                    <asp:BoundField DataField="V_PRY_COD_JEFEPROY" HeaderText="JEFE_PROY" />
                    <asp:BoundField DataField="EST_ATL" HeaderText="ESTADO" />
             
                </Columns>
                
                <HeaderStyle CssClass="HeaderGrilla" />
                <PagerStyle HorizontalAlign="Center" />
                <RowStyle CssClass="ItemGrilla" Height="25px" />

            </cc6:EasyGridView>
        </td> 
        <td width="20px"></td>      
    </tr>
</table>
    </form>
</body>
       <script>
           toastr.options = {
               "closeButton": true,
               "debug": false,
               "newestOnTop": false,
               "progressBar": true,
               "positionClass": "toast-top-right",
               "preventDuplicates": false,
               "onclick": null,
               "showDuration": "300",
               "hideDuration": "1000",
               "timeOut": "5000",
               "extendedTimeOut": "1000",
               "showEasing": "swing",
               "hideEasing": "linear",
               "showMethod": "fadeIn",
               "hideMethod": "fadeOut"
           };
       </script>
</html>

