<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarTaskTimeLine.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.AdministrarTaskTimeLine" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <!--https://codepen.io/htmlcodex/pen/KKVpdNK-->
</head>
<body>
    <form id="form1" runat="server">
        <div class="ScrollPathVertical" id="PanelLT" runat="server">

        </div>
    </form>

  
        <style type="text/css">
            .timeline-dateFlagR {
                width: 54px;
                height: 85px;
                display: inline-block;
                padding: 8px;
                -webkit-clip-path: polygon(0 0,100% 0,100% 80%,50% 100%,0 80%);
                clip-path: polygon(0 0,100% 0,100% 80%,50% 100%,0 80%);
                z-index: 1
            }

           .timeline-dateFlagL {
                width: 54px;
                height: 85px;
                display: inline-block;
                padding: 8px;
                -webkit-clip-path: polygon(0 0,100% 0,100% 80%,50% 100%,0 80%);
                clip-path: polygon(0 0,100% 0,100% 80%,50% 100%,0 80%);
                z-index: 1
            }
        </style>
   

    <style>
	/*
		https://codepen.io/jpag82/pen/Nazayx

	*/
	@property --progress-value {
	  syntax: '<integer>';
	  inherits: false;
	  initial-value: 0;
	}
	/*
		@keyframes html-progress {
		  to { --progress-value:50; }
		}
		*/

		.progress-bar-container{
			opacity: 0.8; 
			position:absolute;
			right:50px;
            top:20px;
		}
		.progress-barC {
		  width: 100px;
		  height: 100px;
		  border-radius: 50%;
  
		  /* to center the percentage value */
		  display: flex;
		  justify-content: center;
		  align-items: center;
		}

		.progress-barC::before {
		  counter-reset: percentage var(--progress-value);
		  content: counter(percentage) '%';
		}


		.html {
		  background: 
			radial-gradient(closest-side, white 59%, transparent 80% 100%),
			conic-gradient(NAVAJOWHITE calc(var(--progress-value) * 1%), transparent 0);
		  animation: html-progress 2s 1 forwards;
		}

		.html::before {
		  animation: html-progress 2s 1 forwards;
		}



		progressC {
		  font-weight:bold;
		  visibility: hidden;
		  width: 0;
		  height: 0;
		}
</style>






    <script>
        AdministrarTaskTimeLine.TimeLine = {};
        AdministrarTaskTimeLine.AgregarEvento = function () {
            if (AdministrarTaskTimeLine.Params[AdministrarTaskTimeLine.KEYAVANCE] == "100") {
                var msgConfig = { Titulo: "VALIDACIÓN", Descripcion: 'El avance de la tarea ya se encuentra al 100% por lo tanto no es posible agregar o modificar eventos a la tarea' };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
            else {
                AdministrarTaskTimeLine.Detalle("0", SIMA.Utilitario.Enumerados.ModoPagina.N);
            }
        } 

        AdministrarTaskTimeLine.Detalle = function (IdHistory,Modo) {
            var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/DetalleTaskTimeLine.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministrarTaskTimeLine.KEYIDTASKITEMHISTORY, IdHistory);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarTaskTimeLine.KEYIDTASKITEMCRONOGRAMA, AdministrarTaskTimeLine.Params[AdministrarTaskTimeLine.KEYIDTASKITEMCRONOGRAMA]);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarTaskTimeLine.KEYMODOPAGINA, Modo);
            oColletionParams.Add(oParam);

            EasyPopupTaskLineaTiempoDet.Load(Url, oColletionParams, false);//Llama a la ventana de mantenimiento detalle
        }

        AdministrarTaskTimeLine.TimeLine.ToolBar = function (btnAccion, btn) {
            if (AdministrarTaskTimeLine.Params[AdministrarTaskTimeLine.KEYAVANCE] == "100") {
                var msgConfig = { Titulo: "VALIDACIÓN", Descripcion: 'El avance de la tarea ya se encuentra al 100% por lo tanto no es posible agregar o modificar eventos a la tarea'};
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
            else {

                var oBtn = jNet.get(btn);
                oDataBE = oBtn.attr("Data").toString().SerializedToObject();
                switch (btnAccion) {
                    case "Edit":
                        AdministrarTaskTimeLine.Detalle(oDataBE.ID_HISTORY, SIMA.Utilitario.Enumerados.ModoPagina.M);
                        break;
                    case "Del":
                        var ConfigMsgb = {
                            Titulo: 'HISTORIAL DE TAREA'
                            , Descripcion: "Desea ud, eliminar este item historia de tarea ahora?"
                            , Icono: 'fa fa-question-circle'
                            , EventHandle: function (btn) {
                                if (btn == 'OK') {
                                    try {
                                        AdministrarTaskTimeLine.Eliminar(oDataBE.ID_HISTORY);
                                        EasyTabPlan.RefreshTabSelect();
                                    }
                                    catch (SIMADataException) {
                                        var msgConfig = { Titulo: "Error al Eliminar Item Historial de atención", Descripcion: SIMADataException.Message };
                                        var oMsg = new SIMA.MessageBox(msgConfig);
                                        oMsg.Alert();
                                    }
                                }
                            }
                        };
                        var oMsg = new SIMA.MessageBox(ConfigMsgb);
                        oMsg.confirm();


                        break;
                    case "UpLoad":

                        var msgConfig = { Titulo: "EN implementación", Descripcion: 'En proceso de implementación' };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                        break;
                    case "User":
                        var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/BuscarPersonal.aspx";
                        var oColletionParams = new SIMA.ParamCollections();
                        var oParam = new SIMA.Param(AdministrarTaskTimeLine.KEYIDTASKITEMHISTORY, oDataBE.ID_HISTORY);
                        oColletionParams.Add(oParam);
                        oParam = new SIMA.Param(AdministrarTaskTimeLine.KEYIDTASKPARTICIPA, "0");
                        oColletionParams.Add(oParam);

                        EasyPopupBuscarPersona.Load(Url, oColletionParams, false);//Llama a la ventana de mantenimiento detalle

                        break;

                }
            }
        }

        AdministrarTaskTimeLine.Eliminar = function (IdHistory) {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdHistorial", IdHistory);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            oEasyDataInterConect.Metodo = 'PlanCronogramaActividadTaskHistory_del';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var obj = oEasyDataResult.sendData();
        }

    </script>



    <style>
         .ScrollPathVertical {
             margin: 0 auto;
             overflow: hidden;
             padding-top: 5px;
             padding-bottom: 5px;
             height:600px;
            }
         .ScrollPathVertical:hover {
                overflow-y: scroll;
            }
        
.footerRigth {

    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items:  flex-end;
    text-align: center;
    position: relative;
    bottom: 0;
    left: 0;
    border-style: solid;
    border-color: transparent;   
}
.footerLeft {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items:  flex-start;
    text-align: center;
    position: relative;
    bottom: 0;
    right: 0;
    border-style: solid;
    border-color: transparent;
}
a.dateit,
a.locit {
    padding-right: 4px;
    font-family: Roboto;
    line-height: normal;
    font-size: 12.5px;
    cursor:pointer;
}
    .locit {
    padding-right: 4px;
    font-family: Roboto;
    line-height: normal;
    font-size: 12.5px;
    cursor:pointer;
}
    </style>















    <style>
        body {
  color: #213546;
  background: #ffffff;
  font-family: Arial, Helvetica, sans-serif;
}

.title {
  position: relative;
  margin-top: 5px;
  width: 100%;
  text-align: center;
}

.timeline {
  position: relative;
  width: 100%;
  padding: 30px 0;
}

.timeline .timeline-container {
  position: relative;
  width: 100%;
}

.timeline .timeline-end,
.timeline .timeline-start,
.timeline .timeline-year {
  position: relative;
  width: 100%;
  text-align: center;
  z-index: 1;
}

.timeline .timeline-end p,
.timeline .timeline-start p,
.timeline .timeline-year p {
  display: inline-block;
  width: 80px;
  height: 80px;
  margin: 0;
  padding: 30px 0;
  text-align: center;
  background: linear-gradient(#4F84C4, #00539C);
  border-radius: 100px;
  box-shadow: 0 0 5px rgba(0, 0, 0, .4);
  color: #ffffff;
  font-size: 14px;
  text-transform: uppercase;
}

.timeline .timeline-year {
  margin: 30px 0;
}

.timeline .timeline-continue {
  position: relative;
  width: 100%;
  padding: 60px 0;
}

.timeline .timeline-continue::after {
  position: absolute;
  content: "";
  width: 1px;
  height: 100%;
  top: 0;
  left: 50%;
  margin-left: -1px;
  background: #4F84C4;
}

.timeline .row.timeline-left,
.timeline .row.timeline-right .timeline-date {
  text-align: right;
}

.timeline .row.timeline-right,
.timeline .row.timeline-left .timeline-date {
  text-align: left;
}

.timeline .timeline-date {
  font-size: 14px;
  font-weight: 600;
  margin: 41px 0 0 0;
}

.timeline .timeline-date::after {
  content: '';
  display: block;
  position: absolute;
  width: 14px;
  height: 14px;
  top: 45px;
  background: linear-gradient(#4F84C4, #00539C);
  box-shadow: 0 0 5px rgba(0, 0, 0, .4);
  border-radius: 15px;
  z-index: 1;
}

.timeline .row.timeline-left .timeline-date::after {
  left: -7px;
}

.timeline .row.timeline-right .timeline-date::after {
  right: -7px;
}

.timeline .timeline-box,
.timeline .timeline-launch {
  position: relative;
  display: inline-block;
  margin: 15px;
  padding: 20px;
  border: 1px solid #dddddd;
  border-radius: 6px;
  background: #ffffff;
}

.timeline .timeline-launch {
  width: 100%;
  margin: 15px 0;
  padding: 0;
  border: none;
  text-align: center;
  background: transparent;
}

.timeline .timeline-box::after,
.timeline .timeline-box::before {
  content: '';
  display: block;
  position: absolute;
  width: 0;
  height: 0;
  border-style: solid;
}

.timeline .row.timeline-left .timeline-box::after,
.timeline .row.timeline-left .timeline-box::before {
  left: 100%;
}

.timeline .row.timeline-right .timeline-box::after,
.timeline .row.timeline-right .timeline-box::before {
  right: 100%;
}

.timeline .timeline-launch .timeline-box::after,
.timeline .timeline-launch .timeline-box::before {
  left: 50%;
  margin-left: -10px;
}

.timeline .timeline-box::after {
  top: 26px;
  border-color: transparent transparent transparent #ffffff;
  border-width: 10px;
}

.timeline .timeline-box::before {
  top: 25px;
  border-color: transparent transparent transparent #dddddd;
  border-width: 11px;
}

.timeline .row.timeline-right .timeline-box::after {
  border-color: transparent #ffffff transparent transparent;
}

.timeline .row.timeline-right .timeline-box::before {
  border-color: transparent #dddddd transparent transparent;
}

.timeline .timeline-launch .timeline-box::after {
  top: -20px;
  border-color: transparent transparent #dddddd transparent;
}

.timeline .timeline-launch .timeline-box::before {
  top: -19px;
  border-color: transparent transparent #ffffff transparent;
  border-width: 10px;
  z-index: 1;
}

.timeline .timeline-box .timeline-icon {
  position: relative;
  width: 40px;
  height: auto;
  float: left;
}

.timeline .timeline-icon i {
  font-size: 25px;
  color: #4F84C4;
}

.timeline .timeline-box .timeline-text {
  position: relative;
  width: calc(100% - 40px);
  float: left;
}

.timeline .timeline-launch .timeline-text {
  width: 100%;
}

.timeline .timeline-text h3 {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 3px;
}

.timeline .timeline-text p {
  font-size: 14px;
  font-weight: 400;
  margin-bottom: 0;
}


/*-----------------R*/
.timeline .timeline-box .timeline-textR {
  position: relative;
  width: calc(100% - 40px);
  float:right;
}

.timeline .timeline-launch .timeline-textR {
  width: 100%;
}

.timeline .timeline-textR h3 {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 3px;
}

.timeline .timeline-textR p {
  font-size: 14px;
  font-weight: 400;
  margin-bottom: 0;
  margin-left:20px;
}






@media (max-width: 768px) {
  .timeline .timeline-continue::after {
    left: 40px;
  }

  .timeline .timeline-end,
  .timeline .timeline-start,
  .timeline .timeline-year,
  .timeline .row.timeline-left,
  .timeline .row.timeline-right .timeline-date,
  .timeline .row.timeline-right,
  .timeline .row.timeline-left .timeline-date,
  .timeline .timeline-launch {
    text-align: left;
  }

  .timeline .row.timeline-left .timeline-date::after,
  .timeline .row.timeline-right .timeline-date::after {
    left: 47px;
  }

  .timeline .timeline-box,
  .timeline .row.timeline-right .timeline-date,
  .timeline .row.timeline-left .timeline-date {
    margin-left: 55px;
  }

  .timeline .timeline-launch .timeline-box {
    margin-left: 0;
  }

  .timeline .row.timeline-left .timeline-box::after {
    left: -20px;
    border-color: transparent #ffffff transparent transparent;
  }

  .timeline .row.timeline-left .timeline-box::before {
    left: -22px;
    border-color: transparent #dddddd transparent transparent;
  }

  .timeline .timeline-launch .timeline-box::after,
  .timeline .timeline-launch .timeline-box::before {
    left: 30px;
    margin-left: 0;
  }
}
    </style>

    <style>
        
.card-attribute {
    padding-bottom: 1.5em;
    border-top: 2px solid var(--var-line-dark);
}

.small-avatar {
    width: 2em;
    border-radius: 200px;
    outline: 2px solid white;
    margin-right: 1.4em;
}
    </style>
</body>
</html>
