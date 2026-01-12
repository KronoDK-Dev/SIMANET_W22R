<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleServicio.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.ITIL.DetalleServicio" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Controls" tagprefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc5" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
</head>
<body>
    <form id="form1" runat="server">

        <cc1:EasyForm ID="EasyFormDetalleSrv" runat="server" OnCommitTransaccion="EasyForm1_CommitTransaccion" ShowButtonsOk_Cancel="False" ClassName="form-row" CssClass="row g-3">
        <Cabecera Titulo="DETALLE DE SERVICIO / PRODUCTO" Descripcion="" Snippetby=""></Cabecera>
            <Secciones>
                <cc1:EasyFormSeccion Titulo="">
                    <ItemsCtrl>
                        <cc1:EasyAutocompletar ID="aucServicio" runat="server" DisplayText="NOMBRE" EnableOnChange="False" Placeholder="Ingrese Nombre del proyecto a Localizar"  Etiqueta="Nombre del Servicio"  NroCarIni="2" Requerido="True" ValueField="ID_SERV_PROD"  MensajeValida="Ingresar Nombre de servicio" >
                            <EasyStyle Ancho="Doce"/>
                            <DataInterconect MetodoConexion="WebServiceExterno">
                                <UrlWebService>/HelpDesk/ITIL/GestiondeConfiguracion.asmx</UrlWebService>
                                <Metodo>BuscarServicioPorNombre</Metodo>
                                <UrlWebServicieParams>
                                    <cc5:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                                </UrlWebServicieParams>
                            </DataInterconect>
                         </cc1:EasyAutocompletar>

                        <cc2:EasyCheckBox ID="chkInterno" runat="server" Checked="True" Etiqueta="demo"  Text="Interno/Externo">
                        <easystyle ancho="Ocho" ClassLabel="form-label" > </easystyle>
                        </cc2:EasyCheckBox>

                        <cc2:EasyCheckBox ID="chkSrvProd" runat="server" Checked="True" Etiqueta="demo"  Text="(Servicio/Sub Servicio)  ó Producto">
                        <easystyle ancho="Ocho" ClassLabel="form-label" > </easystyle>
                        </cc2:EasyCheckBox>
                        <cc1:EasyTextBox ID="txtDescrip" runat="server" autocomplete="off" CssClass="form-control" Height="100PX" data-validate="true" Placeholder="Descripción del Servicio" Requerido="False" TextMode="MultiLine">
                            <EasyStyle Ancho="Doce"></EasyStyle>
                        </cc1:EasyTextBox>
                    </ItemsCtrl>
                </cc1:EasyFormSeccion>
               
            </Secciones>
        </cc1:EasyForm>

    </form>
    <script>
        EasyFormDetalleSrv_aucServicio.UrlWebService = ConnectService.PathNetCore + "HelpDesk/ITIL/GestiondeConfiguracion.asmx";
       
    </script>
</body>
</html>
