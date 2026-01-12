<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarElementos.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.AdministrarElementos" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <!-- control de secuencia https://codepen.io/dp_lewis/pen/MWYgbOY-->
</head>
<body>
    <form id="form1" runat="server">
       <cc1:EasyGridView ID="EasyGridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="PRE CONDICIONES" ToolBarButtonClick="OnEasyGridButton_Click" Width="100%"    PageSize="5" fncExecBeforeServer="" OnRowDataBound="EasyGridView1_RowDataBound" >
            <EasyGridButtons>
                <cc1:EasyGridButton ID="btnAgregar" Descripcion="" Icono="fa fa-plus-square-o" MsgConfirm="" RunAtServer="False" Texto="Agregar" Ubicacion="Derecha" />
            </EasyGridButtons>

                <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />      

                <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect>

                <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="GridDetalle_OnClick" idgestorfiltro=""></EasyExtended>

                <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
   
                <AlternatingRowStyle CssClass="AlternateItemGrilla" />
   
                <Columns>
                    <asp:BoundField DataField="ID_ACT_ELEM" HeaderText="CÓDIGO" >
                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NOMBRE" HeaderText="NOMBRE" >
                    <ItemStyle HorizontalAlign="Left" Width="90%" />
                    </asp:BoundField>
                    <asp:TemplateField>
                        <ItemStyle Width="2%" />
                    </asp:TemplateField>
                </Columns>

              <HeaderStyle CssClass="HeaderGrilla" />
              <PagerStyle HorizontalAlign="Center" />
              <RowStyle CssClass="ItemGrilla" Height="25px" />
        </cc1:EasyGridView>
    


    </form>

    <script>
        function OnEasyGridButton_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregar":
                    AdministrarElementos.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.N);
                    break;
            }
        }

       

        function GridDetalle_OnClick(oItemRowBE) {
            AdministrarElementos.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.M, oItemRowBE.ID_ACT_ELEM);
        }

        AdministrarElementos.ShowDetalle = function (oModo, IdActElemento) {

            var TabDataBE = EasyTabControl1.TabActivo.attr("Data").toString().SerializedToObject();

            var urlPag = Page.Request.ApplicationPath + "/HelpDesk/Sistemas/DetalleElementos.aspx";
            var oColletionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(AdministrarElementos.KEYMODOPAGINA, oModo);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarElementos.KEYIDTIPOELEMENTO, TabDataBE.CODIGO);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarElementos.KEYNOMBREELEMENTO, TabDataBE.NOMBRE);
            oColletionParams.Add(oParam);


            if (IdActElemento != 0) {
                oParam = new SIMA.Param(AdministrarElementos.KEYIDACTELEMENTO, IdActElemento);
                oColletionParams.Add(oParam);
            }

            EasyPopupDetalleElementos.Titulo = "Detalle de Elementos";
            EasyPopupDetalleElementos.Load(urlPag, oColletionParams, false);
            
        }
        AdministrarElementos.Eliminar = function (e) {
            var ConfigMsgb = {
                Titulo: 'ELIMINAR ELEMENTO'
                , Descripcion: 'Desea eliminar el registro seleccionado ahora?'
                , Icono: 'fa fa-close'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        try {

                            var TabDataBE = EasyTabControl1.TabActivo.attr("Data").toString().SerializedToObject();
                            var GridViewActivo = jNet.get('Grid' + TabDataBE.CODIGO);
                            var oDataRow = GridViewActivo.GetDataRow();

                            var oParamCollections = new SIMA.ParamCollections();
                            var oParam = new SIMA.Param("IdActElemento", oDataRow["ID_ACT_ELEM"].toString());
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                            oParamCollections.Add(oParam);

                            var oEasyDataInterConect = new EasyDataInterConect();
                            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/HelpDesk/Sistemas/GestionSistemas.asmx';
                            oEasyDataInterConect.Metodo = 'ActividadElementos_Del';
                            oEasyDataInterConect.ParamsCollection = oParamCollections;

                            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                            var obj = oEasyDataResult.sendData();

                            EasyTabControl1.RefreshTabSelect();
                        }
                        catch (SIMADataException) {
                            var msgConfig = { Titulo: "Error al intentar Eliminar este registro", Descripcion: SIMADataException.Message };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();
                        }


                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }


        /*DEMO DE VENTANA DE MANTENIMIENTO CON MESSAGEBOX */
        /*
        AdministrarElementos.ItemplateDetalleElemento = function (Modo) {
            var MsgTemplate = '<table width="100%" align="left">'
            MsgTemplate += '    <tr><td id="contentDet"></td></tr>'
            MsgTemplate += '</table>';
            var urlPag = Page.Request.ApplicationPath + "/HelpDesk/Sistemas/DetalleElementos.aspx";
            var oColletionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(AdministrarElementos.KEYMODOPAGINA, Modo);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarElementos.KEYIDTIPOELEMENTO, AdministrarElementos.Params[AdministrarElementos.KEYIDTIPOELEMENTO]);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarElementos.KEYNOMBREELEMENTO, AdministrarElementos.Params[AdministrarElementos.KEYNOMBREELEMENTO]);
            oColletionParams.Add(oParam);

            SIMA.Utilitario.Helper.LoadPageIn("contentDet", urlPag, oColletionParams);
            return MsgTemplate;
        }

        AdministrarElementos.Add = function () {
            var ConfigMsgb = {
                Titulo: AdministrarElementos.Params[AdministrarElementos.KEYNOMBREELEMENTO]
                , Descripcion: AdministrarElementos.ItemplateDetalleElemento(SIMA.Utilitario.Enumerados.ModoPagina.N)
                , Icono: 'fa fa-windows'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        //AdministrarElementos.Params[AdministrarElementos.KEYIDTIPOELEMENTO]
                        if (EasyAcBuscarElementos.GetText().length == 0) {
                            var TDescripcion = EasyTxtDescripcion.GetText();
                            var msgConfig = {
                                Titulo: 'Validar'
                                , Descripcion: "No se ha ingresado Nombre de " + AdministrarElementos.Params[AdministrarElementos.KEYNOMBREELEMENTO]
                                , EventHandle: function (btnPress) {
                                    if (btnPress == "OK") {
                                        AdministrarElementos.Add();
                                        Manager.Task.Excecute(function () {
                                                EasyTxtDescripcion.SetValue(TDescripcion);
                                        }, 500, true);
                                        return true;
                                    }
                                }
                            };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();

                        }
                        else {//Grabar Datos
                            alert("graba");
                        }
                        
                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }
        */
       


    </script>
</body>
</html>
