<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarProyecto.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.AdministrarProyecto" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
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
             <cc1:EasyGridView ID="EasyGridProy" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Gestion de Calidad" ToolBarButtonClick="AdministrarProyecto.onEasyGridProyToolbarButtomClick " Width="100%" AllowPaging="True" OnPageIndexChanged="EasyGridProy_PageIndexChanged">
                 <EasyGridButtons>
                     <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="False" Texto="Agregar" Ubicacion="Derecha" />
                     <cc1:EasyGridButton ID="btnEliminar" Descripcion="" Icono="fa fa-close" MsgConfirm="Desea Eliminar este registro" RequiereSelecciondeReg="true" SolicitaConfirmar="true" RunAtServer="False" Texto="Eliminar" Ubicacion="Derecha" />
                 </EasyGridButtons>
                     <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                     <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick=" AdministrarProyecto.onRowCellItemClick" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                     <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                
                     <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                
                     <Columns>
                         <asp:BoundField DataField="NroProyecto" HeaderText="CODIGO" >
                         <ItemStyle Width="5%" HorizontalAlign="Left" />
                         </asp:BoundField>
                         <asp:BoundField DataField="NombreProyecto" HeaderText="NOMBRE" >
                         <ItemStyle Width="30%" HorizontalAlign="Left" />
                         </asp:BoundField>
                         <asp:BoundField DataField="ClienteRazonSocial" HeaderText="CLIENTE" >
                         <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="40%" Wrap="False" />
                         </asp:BoundField>
                         <asp:BoundField DataField="Descripcion" HeaderText="DESCRIPCION" >
                         <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                         </asp:BoundField>
                     </Columns>

                   <HeaderStyle CssClass="HeaderGrilla" />
                   <PagerStyle HorizontalAlign="Center" />
                   <RowStyle CssClass="ItemGrilla" Height="25px" />
                
             </cc1:EasyGridView>
         </td>
     </tr>

 </table>


        
        <cc3:EasyPopupBase ID="EasyPopupDetalleProy" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Detalle Proyecto" RunatServer="true" DisplayButtons="true" fncScriptAceptar="DetalleProyecto.btnAceptar" OnClick="EasyPopupDetalleProy_Click">
        </cc3:EasyPopupBase>


     
    </form>

    <script>

        AdministrarProyecto.onEasyGridProyToolbarButtomClick = function (btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregar":
                    AdministrarProyecto.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.N,0);
                    break;
                case "btnEliminar":
                    // SE DEBERA DE VERIFICAR SI DICHO REGISTRO CONTIENE INFORMACION RELACIONADA PARA NO ELIMINAR

                    var oEasyDataInterConect = new EasyDataInterConect();
                    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                    oEasyDataInterConect.UrlWebService = "/GestionProduccion/Proyectos.asmx";
                    oEasyDataInterConect.Metodo = "ProyectoInsAct";

                    var oParamCollections = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param("IdProyecto", DetalleBE.IdProyecto, TipodeDato.Int);
                    oParamCollections.Add(oParam);
                    oParam = new SIMA.Param("Codigo", DetalleBE.NroProyecto);
                    oParamCollections.Add(oParam);
                    oParam = new SIMA.Param("Nombre", DetalleBE.NombreProyecto);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("Descripcion", DetalleBE.Descripcion);
                    oParamCollections.Add(oParam);
                    oParam = new SIMA.Param("IdCliente", DetalleBE.IdCliente, TipodeDato.Int);
                    oParamCollections.Add(oParam);
                    oParam = new SIMA.Param("IdLN", DetalleBE.CodigoLN, TipodeDato.Int);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("IdEstado", "0", TipodeDato.Int);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("IdUsuario", AdministrarProyecto.Params["IdUsuario"], TipodeDato.Int);
                    oParamCollections.Add(oParam);

                    oParam = new SIMA.Param("UserName", AdministrarProyecto.Params["UserName"]);
                    oParamCollections.Add(oParam);

                    oEasyDataInterConect.ParamsCollection = oParamCollections;

                    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                    var Result = oEasyDataResult.sendData();

                    EasyGridProy.DeleteRowActive(true);

                    break;
            }
        }

        AdministrarProyecto.onRowCellItemClick=function(ItemRowBE){
            
            AdministrarProyecto.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.M,ItemRowBE.IdProyecto);
        }

        AdministrarProyecto.ShowDetalle = function (Modo,Id) {
            var Url = Page.Request.ApplicationPath + "/GestiondeCalidad/DetalleProyecto.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarProyecto.KEYMODOPAGINA, Modo);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarProyecto.KEYIDPROYECTO, Id);
            oColletionParams.Add(oParam);

            EasyPopupDetalleProy.Load(Url, oColletionParams, false);
        }

    </script>
</body>
</html>
