<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarSprint.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.BandejaEntrada.ListarSprint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
<style>
  
.cardTask{
	background-color: #fff;
	width: 880px;
	border-radius: 20px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	padding: 2rem !important;
	background-image: url('../../Recursos/img/ToolBar.jpg');
	background-repeat:repeat-x;
}


.top-container{
	display: flex;
	align-items: center;
}
.profile-image{
	width: 5rem;
	min-width: 10px;
	border: 10px solid rgba(255,255,255,0.5);
}
.name{
	font-size: 15px;
	font-weight: bold;
	color: #272727;
	position: relative;
	top: 8px;
	top: 8px;
}
.middle-container{
	background-color: #eee;
	border-radius: 12px;

}
.middle-container:hover {
	border: 1px solid #5957f9;
}

.dollar{
	font-size: 16px !important;
	color: #5957f9 !important;
	font-weight: bold !important;
}

.Font-Title{
	font-size: 15px;
	color: #272727;
	font-weight: bold;
}

.recent-border{
	border-left: 5px solid #5957f9;
	display: flex;
	align-items: center;

}
.recent-border:hover {
	border-left: 5px solid green;
	display: flex;
	align-items: center;
}

</style>

</head>
<body>
    <form id="form1" runat="server">

    </form>

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
				opacity: 0.5; 
				position:absolute;
				right:50px;
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

</body>
	<script>
		ListarSprint.Eliminar = function (e) {
			var oImg = jNet.get(e);
			ResponsableBE = oImg.attr('DataBE').toString().SerializedToObject();
			if (parseInt(ResponsableBE.AVANCE) != '0') {
                var msgConfig = { Titulo: "VALIDACIÓN", Descripcion: "No es posible realizar la elimnación ,El responsable ya cuenta con información de atención realizada" };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
			}
			else {

				var ConfigMsgb = {
					Titulo: 'ELIMINAR RESPONSABLE'
					, Descripcion: "Desea eliminar a este usuario responsable de la lista de atención ahora?"
					, Icono: 'fa fa-tag'
					, EventHandle: function (btn) {
						if (btn == 'OK') {
							ListarSprint.Data.Eliminar(ResponsableBE.ID_RESPONSABLE);
						}
					}
				};

				var oMsg = new SIMA.MessageBox(ConfigMsgb);
				oMsg.confirm();
			}
		}

		ListarSprint.Data = {};
		ListarSprint.Data.Eliminar = function (IdUsuarioResponsable) {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdResponsable", IdUsuarioResponsable);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdUsuario", UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService == ConnectService.PathNetCore + '/HelpDesk/HDProcesos.asmx';
            oEasyDataInterConect.Metodo = 'RequerimientoResponsableAtencion_Del';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
		}

    </script>
</html>
