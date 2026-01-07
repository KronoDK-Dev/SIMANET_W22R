<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarPoint_In_Out.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.AdministrarPoint_In_Out" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls.Cards" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>



    

	<style>
.PathHistory {
  list-style: none;
  display: inline-block;
}
.PathHistory .icon {
  font-size: 14px;
}
.PathHistory li {
  float: left;
}
.PathHistory li a {
  color: #FFF;
  display: block;
  background: #3498db;
  text-decoration: none;
  position: relative;
  height: 40px;
  line-height: 40px;
  padding: 0 10px 0 5px;
  text-align: center;
  margin-right: 23px;
}
.PathHistory li:nth-child(even) a {
  background-color: #2980b9;
}
.PathHistory li:nth-child(even) a:before {
  border-color: #2980b9;
  border-left-color: transparent;
}
.PathHistory li:nth-child(even) a:after {
  border-left-color: #2980b9;
}
.PathHistory li:first-child a {
  padding-left: 15px;
  -moz-border-radius: 4px 0 0 4px;
  -webkit-border-radius: 4px;
  border-radius: 4px 0 0 4px;
}
.PathHistory li:first-child a:before {
  border: none;
}
.PathHistory li:last-child a {
  padding-right: 15px;
  -moz-border-radius: 0 4px 4px 0;
  -webkit-border-radius: 0;
  border-radius: 0 4px 4px 0;
}
.PathHistory li:last-child a:after {
  border: none;
}
.PathHistory li a:before, .PathHistory li a:after {
  content: "";
  position: absolute;
  top: 0;
  border: 0 solid #3498db;
  border-width: 20px 10px;
  width: 0;
  height: 0;
}
.PathHistory li a:before {
  left: -20px;
  border-left-color: transparent;
}
.PathHistory li a:after {
  left: 100%;
  border-color: transparent;
  border-left-color: #3498db;
}
/*----------------fondo al pasar el mouse ----------------*/
.PathHistory li a:hover {
  background-color: red;
}
.PathHistory li a:hover:before {
  border-color: red;
  border-left-color: transparent;
}
.PathHistory li a:hover:after {
  border-left-color: red;  
}
/*--------------------------------*/
.PathHistory li a:active {
  background-color: #16a085;
}
.PathHistory li a:active:before {
  border-color: #16a085;
  border-left-color: transparent;
}
.PathHistory li a:active:after {
  border-left-color: #16a085;
}
		
	</style>

    
	<style>
		.version-badge {
    font-size: 0.8rem;
    padding: 0.35em 0.65em;
}

.changelog-item {
    position: relative;
    padding-left: 20px;
}

.changelog-item::before {
    content: "";
    position: absolute;
    left: 0;
    top: 8px;
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background-color: #0d6efd;
}

.timeline-line {
    position: absolute;
    left: 3px;
    top: 20px;
    bottom: -8px;
    width: 2px;
    background-color: #dee2e6;
}

.card-footer {
    padding: 1.5rem;
    background-color: transparent;
    border-top: 0;
}

	</style>


   
    <script>
        function ViewLog_ItemLog_ToolBar(oBtn, oItemLog) {
            var TabDataBE = EasyTabControl1.TabActivo.attr("Data").toString().SerializedToObject();
            switch (oBtn.Id) {
                case "Edit":
                    AdministrarPoint_In_Out.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.M, oItemLog.Id);
                    break;
                case "btnDel":
                    var ConfigMsgb = {
                        Titulo: TabDataBE.NOMBRE
                        , Descripcion: 'Desea eliminar el registro seleccionado ahora?'
                        , Icono: oBtn.Icono
                        , EventHandle: function (btn) {
                            if (btn == 'OK') {
                                try {

                                    var oParamCollections = new SIMA.ParamCollections();
                                    var oParam = new SIMA.Param("IdActElemento", oItemLog.Id);
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
                                    //EasyViewLog1.DeleteItem(oItemLog.Id);
                                }
                                catch (SIMADataException) {
                                    var msgConfig = { Titulo: "Error al intentar Eliminar este registro", Icono: oBtn.Icono, Descripcion: SIMADataException.Message };
                                    var oMsg = new SIMA.MessageBox(msgConfig);
                                    oMsg.Alert();
                                }


                            }
                        }
                    };
                    var oMsg = new SIMA.MessageBox(ConfigMsgb);
                    oMsg.confirm();
                    break;
                case "btnAdjunto":
                    var msgConfig = { Titulo: "Adjuntar archivo", Icono: oBtn.Icono, Descripcion: "por implementar el adjuntar archivos" };
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();

                    break;
                case "btnCalendar":
                    var msgConfig = { Titulo: "Calendarización de parámetros", Icono: oBtn.Icono, Descripcion: "por implementar el tiempo limite de recepción del parámetro para iniciar la actividad"};
                    var oMsg = new SIMA.MessageBox(msgConfig);
                    oMsg.Alert();
                    break;
            }

         
           /* var oEasyItemLog = new EasyItemLog();
            oEasyItemLog.Id = oItemLog.Id;
            oEasyItemLog.Titulo = "Titulo Cambiado";
            oEasyItemLog.Descripcion = "cambio de descripsci";
            oEasyItemLog.Icono = oItemLog.Icono;
            EasyViewLog1.EditItem(oEasyItemLog);*/

        }
    </script>
    <script>
        function ToolBarCarOnClick(obtn, IdCtrlParent) {

            alert("ToolBarCarOnClick " + IdCtrlParent);

           // alert(obtn.Id);

            /*var oCard = jNet.get(IdCtrlParent);
                EasyViewCard1.DeleteItem(IdCtrlParent);*/
        }


        function demo(oEasyPanelUsers, obtn) {
            var oEasyUserButton = new EasyUserButton();
            oEasyUserButton.Id = "Edd";
            oEasyUserButton.PathImagen = GlobalEntorno.PathFotosPersonal + "18018828.jpg";
            oEasyPanelUsers.Add(oEasyUserButton);

            alert(obtn.Id);
            
        }

        function EventCards(Evento, IdCard) {
            var oCard = jNet.get(IdCard);
            var oDataBE = oCard.attr('JSonData').toString().SerializedToObject();
            switch (Evento) {
                case "OnComent":
                    AdministrarPoint_In_Out.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.M, oDataBE.Id); 
                    break;
            }
            
            //alert(oCard.attr('JSonData'));

            //alert(Evento);
        }



    </script>

</head>
<body>
    <form id="form1" runat="server">
   

        <cc1:EasyViewLog ID="EasyViewLog1" runat="server">
          
        </cc1:EasyViewLog>

        
     
    </form>
    <script>
        EasyViewLog1_onToolBarClick = function (e) {
            //alert(e.attr("id"));
            AdministrarPoint_In_Out.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.N,0);
        }


        AdministrarPoint_In_Out.ShowDetalle = function (oModo, IdActElemento) {

            var TabDataBE = EasyTabControl1.TabActivo.attr("Data").toString().SerializedToObject();

            var urlPag = Page.Request.ApplicationPath + "/HelpDesk/Sistemas/DetallePoint_In.aspx";
            var oColletionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(AdministrarPoint_In_Out.KEYMODOPAGINA, oModo);
            oColletionParams.Add(oParam);

            //-------------Para saber si es Un Punto de Ingreso o Punto de Salida------------------------
            oParam = new SIMA.Param(AdministrarPoint_In_Out.KEYIDTIPOELEMENTO, TabDataBE.CODIGO);
            oColletionParams.Add(oParam);
            oParam = new SIMA.Param(AdministrarPoint_In_Out.KEYNOMBREELEMENTO, TabDataBE.NOMBRE);
            oColletionParams.Add(oParam);
            //-------------------------------------------------------------------------------------------

            oParam = new SIMA.Param(AdministrarPoint_In_Out.KEYIDACTIVIDAD, AdministrarPoint_In_Out.Params[AdministrarPoint_In_Out.KEYIDACTIVIDAD]);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarPoint_In_Out.KEYIDACTELEMENTO, IdActElemento);
            oColletionParams.Add(oParam);
            
            EasyPopupParamInOut.Titulo = TabDataBE.NOMBRE;
            EasyPopupParamInOut.Load(urlPag, oColletionParams, false);

        }

    </script>
</body>
</html>
