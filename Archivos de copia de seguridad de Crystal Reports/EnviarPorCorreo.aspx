<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnviarPorCorreo.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.EnviarPorCorreo" %>
<%@ Register TagPrefix="cc3" Namespace="EasyControlWeb.Form.Controls" Assembly="EasyControlWeb" %>
<%@ Register TagPrefix="cc2" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
   <style>
        .ItemDE {
                    background:  #fefefe;
                    color: #15428b;
                    cursor: default;
                    font: 11px tahoma,arial,sans-serif;
                    height: 40px;
                    display:inline-block;
                    margin-right:2px;
        }

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

  


    <script>
        function onItemContacto(value, ItemBE) {

            var NomCtrlItem = "ctrl_" + ItemBE.IdPersonal;
            var tblEMail = jNet.get("tblEmail");
            var cellContact = jNet.get(tblEMail.rows[2].cells[1]);
            cellContact.css("padding-top", "5px");
            cellContact.css("padding-left", "5px");
            //Busca el item y si lo encuentra lo lo crea

            if (cellContact.find(NomCtrlItem) == true) { EasyBuscaContacto.Clear(); return true; }

            var item = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(1, 3);
            item.attr("id", NomCtrlItem);
            item.attr("class", "ItemContact");
            var Inject = "";
            Inject = Inject.Serialized(ItemBE, false);
            item.attr("DataBE", Inject);

            var oimg = jNet.create('IMG');
            oimg.attr("src", EnviarPorCorreo.PathFotosPersonal + ItemBE.NroDocIdentidad + ".jpg");
            
                oimg.attr("width", "35px");
                oimg.attr("class", "ms-n2 rounded-circle img-fluid");
            
            var cello = jNet.get(item.rows[0].cells[0])
                cello.insert(oimg);
                cello.css("padding-left","15px");

                item.rows[0].cells[1].innerText = ItemBE.ApellidosyNombres;
                if (SIMA.Utilitario.Helper.Data.ValidarEmail(ItemBE.Email) == false) {
                    jNet.get(item.rows[0].cells[1]).css("text-decoration", "underline");
                    jNet.get(item.rows[0].cells[1]).css("color", "red");
                }

                oimg = jNet.create('IMG');
                oimg.attr("src", SIMA.Utilitario.Constantes.ImgDataURL.ImgClose);
                oimg.attr("DataBE", Inject);
                oimg.addEvent("click", function () {
                    var desInject = this.attr("DataBE");
                    var DataBE = desInject.SerializedToObject();
                    var objItem = jNet.get("ctrl_" + DataBE.IdPersonal);

                    var tblEMail = jNet.get("tblEmail");
                    var cellContact = jNet.get(tblEMail.rows[2].cells[1]);
                    cellContact.remove(objItem);
                });

            var cell1 = jNet.get(item.rows[0].cells[2])

                cell1.insert(oimg);

            cellContact.insert(item);

            EasyBuscaContacto.Clear();

        }

       /* function validarEmail(email) {
            const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            return regex.test(email);
        }*/
      

        //evento que se ejecuta al momento de presionar el boton aceptar del popup send qu se encuentra en AdministrarInspeccion
        function EasyPopupEnviaCorreo_onAceptar() {
            var tblEMail = jNet.get("tblEmail");
            var cellContact = jNet.get(tblEMail.rows[2].cells[1]);

            //Elabora la cadena de contactos
            var LstContact = "";
            cellContact.forEach(function (oCtrl, i) {
                var desInject = oCtrl.attr("DataBE");
                var DataBE = desInject.SerializedToObject();
                if (SIMA.Utilitario.Helper.Data.ValidarEmail(DataBE.Email) == true) {
                    LstContact += DataBE.Email + ",";
                }
            });
            jNet.get('lstParaEmail').value = LstContact;
            //Ruta fisica del reporte
            jNet.get("txtNomFileAdjunto").value = RutaFileAjunto;
            //Asunto
            jNet.get("txtAsunto").value = jNet.get("_txtAsunto").value;

            return Validar();
        }
        function Validar() {
            var msgText = "";
            var boolValida = true;
            if ((jNet.get('lstParaEmail').value.length == 0) && (jNet.get("txtAsunto").value.length == 0)) {
                msgText ="No se ha ingresado la lista de contactos y mensaje para el envio de correo";
                boolValida = false;
            }
            else if ((jNet.get('lstParaEmail').value.length > 0) && (jNet.get("txtAsunto").value.length == 0)) {
                msgText ="No se ha ingresado mensaje ";
                boolValida = false;
            }
            else if ((jNet.get('lstParaEmail').value.length ==0) && (jNet.get("txtAsunto").value.length > 0)) {
                msgText ="No se ha ingresado lista de contactos";
                boolValida = false;
            }
            if (boolValida == false) {
                var msgConfig = { Titulo: "Validación", Descripcion: msgText };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
            return boolValida;
        }

        function EasyDisplay(strIdRow) {
            switch (strIdRow) {
                case "RowMsg":
                    jNet.get(strIdRow).css("display", "block");
                    jNet.get("RowPrevio").css("display", "none");
                    break;
                case "RowPrevio":
                    jNet.get(strIdRow).css("display", "block");
                    jNet.get("RowMsg").css("display", "none");
                    break;
            }
        }


        function onTemplateItemCorreo(ul, item) {
            
            var cmll = "\"";
            var IcoEmail = ((SIMA.Utilitario.Helper.Data.ValidarEmail(item.Email) == true) ? SIMA.Utilitario.Constantes.ImgDataURL.CardEMail : SIMA.Utilitario.Constantes.ImgDataURL.CardSinEmail);
            var ItemUser = '<table style="width:100%">'
                            + ' <tr>'
                + '     <td rowspan="3" align="center" style="width:5%"><img class=" rounded-circle" width = "25px" src = "' + EnviarPorCorreo.PathFotosPersonal + item.NroDocIdentidad + '.jpg"  onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                            + '     <td class="Etiqueta" style="width:85%">' + item.ApellidosyNombres + '</td>'
                            + '     <td rowspan="3" align="center" style="width:10%"><img class=" rounded-circle" width = "25px" src = "' + IcoEmail + '" onerror = "this.onerror=null;this.src=SIMA.Utilitario.Constantes.ImgDataURL.ImgSF;"></td>'
                            + ' </tr>'
                            + ' <tr>'
                            + '    <td>' + item.NombreArea + '</td>'
                            + ' </tr>'
                            + ' <tr>'
                            + '     <td>' + item.Email + '</td>'
                            + '</tr>'
                            + '</table>';

            iTemplate = '<a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">'
                + ItemUser
                + '</a>';

            
         
            //var oCustomTemplateBE = new EasyGestorFiltro1_NroReporte.CustomTemplateBE(ul, item, iTemplate);
            var oCustomTemplateBE = new EasyBuscaContacto.CustomTemplateBE(ul, item, iTemplate);
            

            return EasyBuscaContacto.SetCustomTemplate(oCustomTemplateBE);


        }
    </script>
</head>
<body >
    <form id="form1" runat="server">
        <table id="tblEmail" runat="server">
            <tr>
                <td class="Etiqueta">DE:</td>
                <td style="margin-top:15px; width:100%;"> 
                    <cc3:EasyCardPerfil ID="EasyCardPerfil1" runat="server" BackColor="#F4F4F4"  BorderColor="#666666" BorderStyle="Dotted" BorderWidth="1px" >
                        <PathFoto>
                        </PathFoto>
                        <ApellidosyNombres>
                        </ApellidosyNombres>
                        <Area>
                        </Area>
                        <Email>
                        </Email>
                        <CssClassLine1>
                        Etiqueta</CssClassLine1>
                        <CssClassLine2>
                        Etiqueta</CssClassLine2>
                        <CssClassLine3>
                        </CssClassLine3>
                    </cc3:EasyCardPerfil>
                </td>
            </tr>
            <tr>
                <td class="Etiqueta">PARA:</td>
                <td style="width: 100%">
                     <cc3:EasyAutocompletar ID="EasyBuscaContacto" runat="server" NroCarIni="4"  DisplayText="ApellidosyNombres" ValueField="IdPersonal" fnOnSelected="onItemContacto" fncTempaleCustom="onTemplateItemCorreo" >
                                    <EasyStyle Ancho="Dos"></EasyStyle>
                                    <DataInterconect MetodoConexion="WebServiceInterno">
                                        <UrlWebService>/RecursosHumanos/Personal.asmx</UrlWebService>
                                        <Metodo>BuscarPersona</Metodo>
                                        <UrlWebServicieParams>
                                            <cc2:EasyFiltroParamURLws  ParamName="PSima" Paramvalue="1" ObtenerValor="Fijo" TipodeDato="Int"/>
                                            <cc2:EasyFiltroParamURLws  ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                        </UrlWebServicieParams>
                                    </DataInterconect>
                     </cc3:EasyAutocompletar>   
                </td>
            </tr>
            <tr>
                <td></td>
                <td ID="lstPara" style=" width:100%;border: 1px  dotted #696666;">

                </td>
            </tr>
            <tr>
                <td colspan="2" class="Etiqueta">ARCHIVO ADJUNTO</td>
            </tr>
            <tr>
                <td colspan="2" style=" width:100%;"></td>
            </tr>
            <tr>
                <td colspan="2" class="Etiqueta">MENSAJE</td>
            </tr>
            <tr>
                <td colspan="2" style=" width:100%;border: 1px  dotted #696666;">
                    <table border="0px" style="width:100%;height:100%">
                        <tr id="RowMsg">
                            <td style="width:800px">
                                <cc3:EasyTextBox ID="_txtAsunto"  Width="100%" runat="server" TextMode="MultiLine" Height="80px"></cc3:EasyTextBox>
                            </td>
                         </tr>
                        <tr id="RowPrevio" style="display:none;">
                            <td  style="width:800px;height:250px">
                                 <iframe  class="scrollbar" runat="server"  id="iPrevio" src="" allowtransparency="true" style="background-color:transparent; solid #000000; bottom:0px; right:0px; width:100%; height:100%; border:none; margin:0; padding:0; overflow:hidden; z-index:999999;"  frameborder="0" > </iframe>
                            </td>
                        </tr>
                    </table>
                    
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

