<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarActividadxProyecto.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.AdministrarActividadxProyecto" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <script>
        function OnEasyGridButton_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregarAct":
                    var oParamCollections = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministrarActividadxProyecto.KEYIDPROYECTO, DetalleBE.IdProyecto);
                    oParamCollections.Add(oParam);
                    EasyPopupActividades.Load(Page.Request.ApplicationPath + "/GestiondeCalidad/ListarActividades.aspx?", oParamCollections);
                    break;
            }
        }


        function OnEasyGridActividades_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregar":

                    if (EasyAutocompletAct.GetText().length > 0) {
                        var oRow = EasyGridViewActividades.RowClone(3, function (Celda, index) {
                            if (index == 0) {
                                if (jNet.get(Celda.parentNode).attr('Tiporow') != '4') {
                                   Celda.innerText = EasyGridViewActividades.GetNroFila();
                                }
                            }
                            else if (index == 1) {
                                Celda.innerText = EasyAutocompletAct.GetText();
                            }
                        });
                        
                        oRow.attr('Tiporow', '2');
                        oRow.attr('IdActividad', EasyAutocompletAct.GetValue());

                        EasyAutocompletAct.Clear();
                    }
                    else {
                        var msgConfig = { Titulo: "Administrar Actividad", Descripcion: "Error al intentar crear una actividad"};
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                    }
                    break;
                case "btnEliminar":
                    EasyGridViewActividades.DeleteRowActive(true);
                    break;
            }
        }




        function EasyPopupActividadesAceptar() {

            EasyGridViewActividades.ItemsforEach(function (oRow) {
                if ((oRow.attr('Modo') == 'N') || (oRow.attr('Modo') == 'E')) {

                    try {

                        var oParamCollections = new SIMA.ParamCollections();
                        var oParam = new SIMA.Param('IdProyecto', ListarActividades.Params[AdministrarActividadxProyecto.KEYIDPROYECTO] );
                        oParamCollections.Add(oParam);
                        oParam = new SIMA.Param('NombreActividad', oRow.cells[1].innerText);
                        oParamCollections.Add(oParam);
                        oParam = new SIMA.Param('IdEstado', ((oRow.attr('Modo') == 'E') ? '0' : '1'));
                        oParamCollections.Add(oParam);
                        oParam = new SIMA.Param('IdUsuario', AdministrarActividadxProyecto.Params["IdUsuario"]);
                        oParamCollections.Add(oParam);
                        oParam = new SIMA.Param('UserName', AdministrarActividadxProyecto.Params['UserName']);
                        oParamCollections.Add(oParam);

                        var oEasyDataInterConect = new EasyDataInterConect();
                        oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                        oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                        oEasyDataInterConect.Metodo = 'ModificarInsertarActividadProyecto';
                        oEasyDataInterConect.ParamsCollection = oParamCollections;

                        //Se conecta y Obtiene los datos en formato DataTable
                        var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                        var obj = oEasyDataResult.sendData();
                        if (obj != undefined) {
                            return true;
                        }
                    }
                    catch (SIMADataException) {
                        var msgConfig = { Titulo: "Administrar Actividad", Descripcion: SIMADataException.Message };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                    }
                 }
             });

            EasyPopupActividades.Close();

        }

        function onGridProyectosDetalle_click(DetalleBE) {
                EasyPopupDetalle_EasyForm1_txtCodigoProy.SetValue(DetalleBE.NroProyecto);
                EasyPopupDetalle_EasyForm1_txtNombreProy.SetValue(DetalleBE.NombreProyecto);
                EasyPopupDetalle_EasyForm1_txtCliente.SetValue(DetalleBE.ClienteRazonSocial);
            
            EasyPopupDetalle.Show();
        }

        function EasyPopupDetalle_Aceptar() {
            EasyPopupDetalle.Close();
        }


        function onDisplayTemplate(ul, item) {
            var cmll = "\"";
            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                            + '<div class= "flex-column">' + item.NombreProyecto
                            + '  <p><small style="font-weight: bold">CLIENTE:</small> <small style ="color:red">' + item.ClienteRazonSocial + '</small></p>'
                            + '</div>'
                        + '</a> ';


            var oCustomTemplateBE = new EasyGestorFiltro1_IdProyecto.CustomTemplateBE(ul, item, iTemplate);

            return EasyGestorFiltro1_IdProyecto.SetCustomTemplate(oCustomTemplateBE);


        }



    </script>

    

</head>
<body>
    <form id="form1" runat="server">
           <table style="width:100%;" border="0">
            <tr>
                <td>
                    <uc1:Header runat="server" ID="Header" IdGestorFiltro="EasyGestorFiltro1" /> </td>
            </tr>
            <tr>
                <td style="width:100%; height:100%">
                    <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="Listado de Proyectos por clientes"  Width="100%"  AllowPaging="True" ToolBarButtonClick="OnEasyGridButton_Click" PageSize="15" OnPageIndexChanged="EasyGridView1_PageIndexChanged">
                        <EasyGridButtons>
                            <cc1:EasyGridButton ID="btnAgregarAct" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="False" Texto="Actividades" Ubicacion="Derecha" RequiereSelecciondeReg="True" />
                        </EasyGridButtons>
                            <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                            <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="onGridProyectosDetalle_click" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                            <EasyRowGroup GroupedDepth="1" ColIniRowMerge="0"></EasyRowGroup>
                       
                            <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                       
                            <Columns>
                                <asp:BoundField DataField="ClienteRazonSocial" HeaderText="CLIENTE" >
                                <ItemStyle Width="30%" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NroProyecto" HeaderText="COD PROJECT" >
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NombreProyecto" HeaderText="PROYECTO" SortExpression="NombreProyecto" >
                                <ItemStyle HorizontalAlign="Left" Width="60%" />
                                </asp:BoundField>
                            </Columns>

                          <HeaderStyle CssClass="HeaderGrilla" />
                          <PagerStyle HorizontalAlign="Center" />
                          <RowStyle CssClass="ItemGrilla" Height="25px" />
                       
                    </cc1:EasyGridView>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>

        <cc2:EasyGestorFiltro ID="EasyGestorFiltro1" runat="server" ClassHeader="HeaderGrilla" ClassItem="ItemGrilla" ClassItemAlternating="AlternateItemGrilla"  EasyFiltroCampos-Capacity="4"  DisplayButtonInterface="False" OnProcessCompleted="EasyGestorFiltro1_ProcessCompleted">

            <cc2:EasyFiltroCampo Descripcion="Proyecto" Nombre="IdProyecto" TipodeDato="String">
                <DataInterconect MetodoConexion="WebServiceInterno">
                    <UrlWebService>/GestiondeCalidad/Proceso.asmx</UrlWebService>
                     <Metodo>BuscarProyectoXNombre</Metodo>
                    <UrlWebServicieParams>
                        <cc2:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" />
                    </UrlWebServicieParams>
                </DataInterconect>
                <EasyControlAsociado TemplateType="EasyITemplateAutoCompletar" NroCarIni="0" TextField="NombreProyecto"  ValueField="IdProyecto" fncTempaleCustom="onDisplayTemplate" />
            </cc2:EasyFiltroCampo>

            <cc2:EasyFiltroCampo Descripcion="Código del Proyecto" Nombre="NroProyecto">
                <EasyControlAsociado TemplateType="EasyITemplateTextBox" />
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

        </cc2:EasyGestorFiltro>




         <cc3:EasyPopupBase ID="EasyPopupActividades" runat="server"  Modal="fullscreen" ModoContenedor="LoadPage" Titulo="Listado de actividades" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupActividadesAceptar">
        </cc3:EasyPopupBase>
        
        <cc3:EasyPopupBase ID="EasyPopupDetalle" runat="server"  Modal="fullscreen" ModoContenedor="Contenedor" Titulo="Detalle de Proyecto" RunatServer="false" DisplayButtons="true" fncScriptAceptar="EasyPopupDetalle_Aceptar">
             
             

            <cc4:EasyForm ID="EasyForm1" runat="server" ClassName="form-row" CssClass="row g-3" ShowButtonsOk_Cancel="False">
            <Cabecera Titulo="DETALLE DE PROYECTO" Descripcion="Proyecto disponible para asignación de actividades" Snippetby=""></Cabecera>
                        <Secciones>
                            <cc4:EasyFormSeccion Titulo="DATOS DEL PROYECTO">
                                <ItemsCtrl>
                                    <cc3:EasyTextBox ID="txtCodigoProy" runat="server" autocomplete="off" CssClass="form-control" data-validate="true" Etiqueta="CODIGO" Requerido="False">
                                    <EasyStyle Ancho="Cuatro"></EasyStyle>
                                    </cc3:EasyTextBox>
                                </ItemsCtrl>
                            </cc4:EasyFormSeccion>
                        </Secciones>

                        <Secciones>
                            <cc4:EasyFormSeccion Titulo="">
                                <ItemsCtrl>
                                    <cc3:EasyTextBox ID="txtNombreProy" runat="server" autocomplete="off"  TextMode="MultiLine" Height="50px" CssClass="form-control"  data-validate="true" Etiqueta="NOMBRE" Requerido="False">
                                    <EasyStyle Ancho="Nueve"></EasyStyle>
                                    </cc3:EasyTextBox>
                                </ItemsCtrl>
                            </cc4:EasyFormSeccion>
                        </Secciones>
                        <Secciones>
                            <cc4:EasyFormSeccion Titulo="">
                                <ItemsCtrl>
                                    <cc3:EasyTextBox ID="txtCliente" runat="server" autocomplete="off"    CssClass="form-control"  data-validate="true" Etiqueta="CLIENTE" Requerido="False">
                                    <EasyStyle Ancho="Nueve"></EasyStyle>
                                    </cc3:EasyTextBox>
                                </ItemsCtrl>
                            </cc4:EasyFormSeccion>
                        </Secciones>
            </cc4:EasyForm> 

       </cc3:EasyPopupBase>
    </form>
</body>
</html>
