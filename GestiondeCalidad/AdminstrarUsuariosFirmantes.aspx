<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminstrarUsuariosFirmantes.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.AdminstrarUsuariosFirmantes" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register src="../Controles/Header.ascx" tagname="Header" tagprefix="uc1" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Filtro" tagprefix="cc2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style>
        .BaseItemInGrid
        {
	        border:1px dotted #99bbe8;
	        MARGIN-TOP: 5px;
	        color: #15428b;
	        cursor:default;
	        font:11px tahoma,arial,sans-serif;	
        }
   </style>

   <script>
       function OnEasyGridFirmantes_Click(btnItem, DetalleBE) {
       }
      
   </script>

</head>
<body>
    <form id="form1" runat="server">
         <table style="width:100%; height:100%" border="0">
               
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>

                    <cc1:EasyGridView ID="EasyGridViewFirmantes" runat="server" AutoGenerateColumns="False" TituloHeader="DETALLE" ToolBarButtonClick="OnEasyGridFirmantes_Click" Width="100%" OnRowDataBound="EasyGridViewFirmantes_RowDataBound">
                         <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                        <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick=""></EasyExtended>

                    <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                        <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                        <Columns>
                            <asp:BoundField DataField="TipoUsuarioFirma" HeaderText="TIPO" >
                            <ItemStyle HorizontalAlign="Left" Width="20%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ApellidosyNombres" HeaderText="APROBADORES">
                            <ItemStyle HorizontalAlign="Left" Width="60%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="FIRMA">
                                <ItemStyle Width="10%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="HeaderGrilla" Height="25px" />
                        <RowStyle CssClass="ItemGrilla" Height="35px" />
                    </cc1:EasyGridView>
                
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtPathFirma" runat="server"></asp:TextBox>
                    <asp:TextBox ID="txtIdInspeccion" runat="server" Width="79px" ></asp:TextBox>
                </td>
            </tr>
        </table>

        <script>
            AdminstrarUsuariosFirmantes.ItemplateSolicitud = function (e) {
                var oImg = jNet.get(e);
                var objContent = oImg.parentNode;
                var orow = ((objContent.tagName == "TD") ? objContent.parentNode.parentNode.parentNode.parentNode.parentNode : objContent.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode);

                var Data = orow.GetData();

                var FotoPersona = AdminstrarUsuariosFirmantes.PathFotosPersonal + Data.NroDocDNI + ".jpg";
                
                var FotoClassName = oImg.attr("ClassN");

                var MsgTemplate = '<table border=0 width="100%" id="tblSendAprob">'
                    + '<tr>'
                    + '     <td colspan=2 align="center"><img width="220px" class="' + FotoClassName + '" src="' + FotoPersona + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;" /></td>'
                    + '</tr>'
                    + '<tr>'
                    + '     <td colspan=2 align="center"><br>Desea enviar una solicitud de aprobación a:' + Data.ApellidosyNombres + ' a su bandeja de correo ahora? </td>'
                    + '</tr>'
                   /*  + '<tr>'
                    + '     <td class="Etiqueta" colspan=2 align="center" >'
                    + '         PLAZO (aprobación)'            
                    + '     </td>'
                    + '</tr>'
                    + '<tr>'
                    + '     <td class="Etiqueta">'
                    + '         TIPO'
                    + '     </td>'
                    + '     <td class="Etiqueta">'
                    + '         TIEMPO'
                    + '     </td>'
                    + '</tr>'
                    + '<tr>'
                    + '     <td>'
                    + '         <select  id="ddlTipoPLazo"  onchange="AdminstrarUsuariosFirmantes.On_ddlTipoPLazo(this);">'
                    + '             <option value="-1">[Seleccionar..]</option>'
                    + '         <optgroup label = "Aprobación por Plazos">'
                    + '             <option value="1" ' + ((Data["IdTipoPlazo"] == "1") ? "selected" : "") + '>Minuto(s)</option>'
                    + '             <option value="2" ' + ((Data["IdTipoPlazo"] == "2") ? "selected" : "") + '>Horas(s)</option>'
                    + '             <option value="3" ' + ((Data["IdTipoPlazo"] == "3") ? "selected" : "") + '>Dias(s)</option>'
                    + '         <optgroup label = "Aprobación a solicitud">'
                    + '             <option value="4" ' + ((Data["IdTipoPlazo"]=="4") ?"selected":"") + '>En espera de Aprobación</option>'
                    + '             <option value="4" selected>En espera de Aprobación</option>'
                    + '         </select>'
                    + '     </td>'
                    + '     <td>'
                    + '         <input style="width:50px" type = "text" id = "txtTime" value="' + Data["TiempoPlazo"] + '" readonly>'
                    + '     </td>'
                    + '</tr>'*/
                    + '</table>';


                return MsgTemplate;
            }
            AdminstrarUsuariosFirmantes.IdTipoPlazo = -1;
           /* AdminstrarUsuariosFirmantes.On_ddlTipoPLazo = function (e) {
                AdminstrarUsuariosFirmantes.IdTipoPlazo = e.options[e.selectedIndex].value;
                if (AdminstrarUsuariosFirmantes.IdTipoPlazo =="4") {
                    jNet.get('txtTime').value = "0";
                }
            }*/
            
            var Data = null;
            AdminstrarUsuariosFirmantes.SolicitaAprobacion = function (e) {
                var oImg = jNet.get(e);
                var objContent = oImg.parentNode;
                var oRow = ((objContent.tagName == "TD") ? objContent.parentNode.parentNode.parentNode.parentNode.parentNode : objContent.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode);

                EasyGridViewFirmantes_OnRowClick(oRow);
                SIMA.GridView.Extended.OnEventClickChangeColor(oRow);
                Data = EasyGridViewFirmantes.GetDataRow(oRow.attr("Guid"));

               
              
                if (Data["IdEstado"].toString().Equal("3")) {
                    var msgConfig = { Titulo: "Validación", Descripcion: "Aprobación ya se encuentra establecida" };
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                }
                else {
                    if (Data.IdPersonaFirmante.length > 0) {
                        var ConfigMsgb = {
                            Titulo: 'SOLICITUD DE APROBACIÓN'
                            , Descripcion: AdminstrarUsuariosFirmantes.ItemplateSolicitud(e)
                            , Icono: 'fa fa-tag'
                            , EventHandle: function (btn) {
                                if (btn == 'OK') {
                                    var tPlazo = "0"; //jNet.get('txtTime').value;
                                    Manager.Task.Excecute(function () {
                                        AdminstrarUsuariosFirmantes.EnviarEmailSolicitudAprobacion(tPlazo);
                                    }, 1000);
                                }
                            }
                        };
                            if (Data.EMail.length > 0) {//Valida Cuenta de correo
                                var oMsg = new SIMA.MessageBox(ConfigMsgb);
                                oMsg.confirm();
                            }
                            else {
                                var msgConfig = { Titulo: "Validación", Descripcion: Data.ApellidosyNombres + "No tiene asocioado su cuenta de Correo.. comunicarse con el areas OTI para pronta su resolución.. "};
                                var oMsg = new SIMA.MessageBox(msgConfig);
                                oMsg.Alert();
                            }
                    }
                    else {
                        var msgConfig = { Titulo: "Validación", Descripcion: "No se ha seleccionado Personal responsable para " + Data.TipoUsuarioFirma };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                    }
                }
            }

            AdminstrarUsuariosFirmantes.ItemplateFind = function (e) {
                var MsgTemplate = '<table width="100%" align="left">'
                    MsgTemplate +='    <tr><td id="contentFind"></td></tr>'
                    MsgTemplate +='</table>';

                var urlPag = Page.Request.ApplicationPath + "/GestiondeCalidad/FindAprobadorRI.aspx";
                var oColletionParams = new SIMA.ParamCollections();

                var oParam = new SIMA.Param(AdminstrarUsuariosFirmantes.KEYMODOPAGINA, 'F');
                    oColletionParams.Add(oParam);

                SIMA.Utilitario.Helper.LoadPageIn("contentFind", urlPag, oColletionParams);

                return MsgTemplate;
            }
            AdminstrarUsuariosFirmantes.AprobadorBE = null;

            AdminstrarUsuariosFirmantes.Find = function (e) {
                var tbl = e.parentNode.parentNode.parentNode.parentNode;
                var orow = jNet.get(tbl.parentNode.parentNode);
                var Data = orow.GetData();

                AdminstrarUsuariosFirmantes.AprobadorBE = null;  
                var ConfigMsgb = {
                    Titulo: 'Buscar ' + Data.TipoUsuarioFirma
                    , Descripcion: AdminstrarUsuariosFirmantes.ItemplateFind(e)
                    , Icono: 'fa fa-binoculars'
                    , EventHandle: function (btn) {
                        if (btn == 'OK') {
                            jNet.get(e).attr("src", AdminstrarUsuariosFirmantes.PathFotosPersonal + AdminstrarUsuariosFirmantes.AprobadorBE.NroDocIdentidad + ".jpg");
                            tbl.rows[0].cells[1].innerText = AdminstrarUsuariosFirmantes.AprobadorBE.ApellidosyNombres;

                            var oDataRow = EasyGridViewFirmantes.GetDataRow();
                            oDataRow["Modo"] = SIMA.Utilitario.Enumerados.ModoPagina.N;
                            oDataRow["IdInspeccion"] = AdminstrarUsuariosFirmantes.Params[AdminstrarUsuariosFirmantes.KEYIDINSPECCION];
                            oDataRow["IdPersonaFirmante"] = AdminstrarUsuariosFirmantes.AprobadorBE.IdPersonal;
                            oDataRow["Descripcion"] = "";
                            oDataRow["Firma"]= AdminstrarUsuariosFirmantes.AprobadorBE.Firma;
                            oDataRow["IdEstado"] = "1";
                            //Datos Complementarios
                            oDataRow["EMail"]= AdminstrarUsuariosFirmantes.AprobadorBE.EMail;
                        }
                    }
                };
                var oMsg = new SIMA.MessageBox(ConfigMsgb);
                oMsg.confirm();
            }



            AdminstrarUsuariosFirmantes.EnviarEmailSolicitudAprobacion = function (TiempoPlazo) {
                /*if (AdminstrarUsuariosFirmantes.IdTipoPlazo == "-1") {
                    var msgConfig = {Titulo: "Validación", Descripcion: "No se ha seleccionado la modalidad de respuesta<br>Vuelva a intentarlo"};
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                    return;
                }*/
               /* else {
                    if (TiempoPlazo.toString().isNumeric() == false) {
                        var msgConfig = {Titulo: "Validación", Descripcion: "No se ha ingresado el valor de tiempo<br>vuela a intentarlo"};
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                        return;
                    }
                }*/
                AdminstrarUsuariosFirmantes.IdTipoPlazo = "4";//Plazo por defecto 
                var oRow = EasyGridViewFirmantes.GetRowActive();
                var oDataRow = EasyGridView1.GetDataRow();
                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("IdInspeccion", oDataRow["IdInspeccion"]);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdPersonalFirmante", Data.IdPersonaFirmante, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdTipoPlazo", AdminstrarUsuariosFirmantes.IdTipoPlazo, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("TiempoPlazo", TiempoPlazo, TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdUsuario", AdminstrarUsuariosFirmantes.Params["IdUsuario"], TipodeDato.Int);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("UserName", AdminstrarUsuariosFirmantes.Params["UserName"]);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("PathApp", Page.Request.ApplicationPath);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("PagPrc", "/GestiondeCalidad/Interoperabilidad.aspx");
                oParamCollections.Add(oParam);

                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                oEasyDataInterConect.Metodo = 'EnviaEmailSolAprobar';
                oEasyDataInterConect.ParamsCollection = oParamCollections;

                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                var obj = oEasyDataResult.sendData();
                if (obj != undefined) {
                    var oImg = jNet.get(oRow.cells[3].children[0]);
                    oImg.attr("src", SIMA.Utilitario.Constantes.ImgDataURL.IconEnEspera);
                    return true;
                }
            }




            AdminstrarUsuariosFirmantes.onPopupAceptar=function() {
                var Exit = true;
                EasyGridViewFirmantes.ItemsforEach(function (orow) {
                    var oDataRow = orow.GetData();
                    if (oDataRow["Modo"].toString().Equal(SIMA.Utilitario.Enumerados.ModoPagina.N)) {
                        try {
                            var oParamCollections = new SIMA.ParamCollections();
                            var oParam = new SIMA.Param(AdministrarInspecion.KEYIDINSPECCION, oDataRow["IdInspeccion"]);
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param(AdministrarInspecion.KEYQIDPERFIRMANTE, oDataRow["IdPersonaFirmante"], TipodeDato.Int);
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param(AdministrarInspecion.KEYQIDTIPOFIRMANTE, oDataRow["IdTipoFirmante"], TipodeDato.Int);
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param(AdministrarInspecion.KEYQDESCRIPCION, oDataRow["Descripcion"]);
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param('IdUsuario', AdministrarInspecion.Params['IdUsuario'], TipodeDato.Int);
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param('UserName', AdministrarInspecion.Params['UserName']);
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param(AdministrarInspecion.KEYQIDESTADO, oDataRow["IdEstado"], TipodeDato.Int);
                            oParamCollections.Add(oParam);

                            var oEasyDataInterConect = new EasyDataInterConect();
                            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                            oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                            oEasyDataInterConect.Metodo = 'ModificarInsertarPeronaFirmantexTipo';
                            oEasyDataInterConect.ParamsCollection = oParamCollections;

                            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                            var obj = oEasyDataResult.sendData();

                            if (obj != undefined) {
                                Exit = true;
                            }
                        }
                        catch (SIMADataException) {
                            var msgConfig = { Titulo: "Error ", Descripcion: SIMADataException.Message };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();
                        }

                    }

                });
                return Exit;
            }



            AdminstrarUsuariosFirmantes.MonitorearAprobacion = function () {
                var oEasyDataInterConect = new EasyDataInterConect();
                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                oEasyDataInterConect.UrlWebService = ConnectService.ControlInspeccionesSoapClient;
                oEasyDataInterConect.Metodo = "ListarUsuariosFirmantes";

                var oParamCollections = new SIMA.ParamCollections();
                var oParam = new SIMA.Param("IdInspeccion", AdminstrarUsuariosFirmantes.Params[AdminstrarUsuariosFirmantes.KEYIDINSPECCION]);
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("IdUsuarioFirmante", "0");
                oParamCollections.Add(oParam);
                oParam = new SIMA.Param("UserName", AdminstrarUsuariosFirmantes.Params["UserName"]);
                oParamCollections.Add(oParam);

                oEasyDataInterConect.ParamsCollection = oParamCollections;

                //Foreach de la grilla
                    EasyGridViewFirmantes.ItemsforEach(function (orow) {
                        var oDataRow = orow.GetData();
                        //if (oDataRow["IdEstado"] != "3") {
                        if (oDataRow["IdEstado"] == "2") {
                            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                            var oDataTable = oEasyDataResult.getDataTable();
                            oDataTable.Select("IdPersonaFirmante", "=", oDataRow["IdPersonaFirmante"]).forEach(function (oDR, i) {
                                if (oDR["IdEstado"].toString().Equal("3")) {
                                    var oImg = jNet.get(orow.cells[3].children[0]);
                                    oImg.attr("src", oImg.attr("imgFirma"));
                                    oImg.css("width", "90px").css("Height", "40px");
                                    //Actualiza el estado en el datarow
                                    oDataRow["IdEstado"] = oDR["IdEstado"].toString();
                                }
                            });
                        }
                    });       

                Manager.Task.Excecute(function () {
                    AdminstrarUsuariosFirmantes.MonitorearAprobacion();
                }, 5000, true);

                Manager.Task.Clear();
            }

            Manager.Task.Excecute(function () {
                                        AdminstrarUsuariosFirmantes.MonitorearAprobacion();
                                    }, 1000,true);
           





        </script>

    </form>
</body>
</html>
