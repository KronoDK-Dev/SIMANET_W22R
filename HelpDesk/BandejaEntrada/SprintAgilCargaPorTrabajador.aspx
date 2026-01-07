<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SprintAgilCargaPorTrabajador.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.BandejaEntrada.SprintAgilCargaPorTrabajador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
		<!--referencia: https://bbbootstrap.com/snippets/bootstrap-task-card-wall-template-22803202
                        https://getcssscan.com/css-checkboxes-examples
		-->
</head>
<body>
    <form id="form1" runat="server">
        <div class="container ScrollPathVertical" style="height:550px;">
             <div class="row" id="Contenedor" runat="server">
             
             
             </div>
        </div>
    </form>


    <script>
        SprintAgilCargaPorTrabajador.Data = {};
        SprintAgilCargaPorTrabajador.Data.ResponsableAtencion = {};
        SprintAgilCargaPorTrabajador.Aceptar = function () {
            const collection = document.getElementsByName("Recurso");
            for (let i = 0; i < collection.length; i++) {

                var ochk = jNet.get(collection[i]);
                var IdRespAtencion = ochk.attr('idRespAten');
                var IdPersonal = ochk.attr('id');
                var IdEstado = 0;
                if (ochk.attr('ASIGNADO') == "1"){
                    IdEstado = ((ochk.checked == true) ? 1 : 0);
                    SprintAgilCargaPorTrabajador.Data.ResponsableAtencion.ModificaInserta(IdRespAtencion, IdPersonal, IdEstado);
                }
                else if (ochk.checked==true)
                {
                    IdEstado = 1;
                    SprintAgilCargaPorTrabajador.Data.ResponsableAtencion.ModificaInserta(IdRespAtencion, IdPersonal, IdEstado);
                }
            }
            return true;
        }


        SprintAgilCargaPorTrabajador.Data.ResponsableAtencion.ModificaInserta=function(IdResponsable,IdPersonal,IdEstado){
            var oParamCollections = new SIMA.ParamCollections();

            var oParam = new SIMA.Param("IdResponsable", IdResponsable);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdRequerimiento", SprintAgilCargaPorTrabajador.Params[SprintAgilCargaPorTrabajador.KEYIDREQUERIMIENTO]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdPersonal", IdPersonal);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdEstado", IdEstado, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            oEasyDataInterConect.Metodo = 'RequerimientoResponsableAtencion_InsMod';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var obj = oEasyDataResult.sendData();
        }
        
    </script>

  
	<style>
         .ScrollPathVertical {
             margin: 0 auto;
             overflow:hidden;
             padding-top: 5px;
             padding-bottom: 5px;
         }
         .ScrollPathVertical:hover {
             overflow-y: scroll;
         }
	</style>

    <style>
        img {
          max-width: 100%;
          display: block;
        }
        ul {
          list-style: none;
        }

        /* Utilities */
        .card::after,
        .card img {
          border-radius: 50%; 
        }
        /*body,*/
        .card,
        .stats {
          display: flex;
        }

        .card {
          padding: 2.5rem 2rem;
          border-radius: 10px;
          background-color: rgba(255, 255, 255, .5);
          max-width: 480px;
          box-shadow: 0 0 30px rgba(0, 0, 0, .15);
          margin: 1rem;
          position: relative;
          transform-style: preserve-3d;
          overflow: hidden;
        }


        .card:hover {
            background-color: #ffcc66;
            cursor:pointer;
        }


        .card::before,
        .card::after {
          content: '';
          position: absolute;
          z-index: -1;
        }
        .card::before {
          width: 450px;
          height: 100%;
          border: 1px solid #FFF;
          border-radius: 10px;
          top: -.7rem;
          left: -.7rem;
        }

        .card img {
          width: 5rem;
          min-width: 80px;
         /* box-shadow: 0 0 0 5px #FFF;*/
          border: 10px solid rgba(255,255,255,0.5);
        }

        /*---selected*/
        .cardSelect::after,
        .cardSelect img {
          border-radius: 50%; 
        }
        .cardSelect {
          padding: 2.5rem 2rem;
          border-radius: 10px;
          border: 2px solid #0469a7;
          background-attachment: fixed;
          background-image: url('../../Recursos/img/ToolBar.jpg');
          background-repeat: no-repeat;
          background-position: 20% 100%; 
          max-width: 480px;
          box-shadow: 0 0 30px rgba(0, 0, 0, .15);
          margin: 1rem;
          position: relative;
          transform-style: preserve-3d;
          overflow: hidden;
        }

        .cardSelect:hover {
            border: 2px solid gray;
            background-color: #ffcc66;
            cursor:pointer;
        }

        .cardSelect::before,
        .cardSelect::after {
          content: '';
          position: absolute;
          z-index: -1;
        }
        .cardSelect::before {
          width: 450px;
          height: 100%;
          border: 1px solid #FFF;
          border-radius: 10px;
          top: -.7rem;
          left: -.7rem;
        }

        .cardSelect img {
          width: 5rem;
          min-width: 80px;
           border: 10px solid rgba(255,255,255,0.5);
        }
        /*-------*/


        .infos {
          margin-left: 1.5rem;
        }

        .name {
          margin-bottom: 1rem;
        }
        .name h2 {
          font-size: 1.1rem;
          font-family: Snell Roundhand, cursive;
          color:#000080;

        }
        .name h4 {
          font-size: .8rem;
          color: #439aff
        }

        .text {
          font-size: .7rem;
          margin-bottom: 1rem;
          color:#8e8e8e;
        }

        .stats {
          margin-bottom: 1rem;
        }
        .stats li {
          min-width: 5rem;
        }
        .stats li h3 {
          font-size: .99rem;
        }
        .stats li h4 {
          font-size: .75rem;
        }

        .links button {
          font-family: 'Poppins', sans-serif;
          min-width: 120px;
          padding: .5rem;
          border: 1px solid #222;
          border-radius: 5px;
          font-weight: bold;
          cursor: pointer;
          transition: all .25s linear;
        }
        .links .follow,
        .links .view:hover {
          background-color: #222;
          color: #FFF;
        }
        .links .view,
        .links .follow:hover{
          background-color: transparent;
          color: #222;
        }

        @media screen and (max-width: 450px) {
          .card {
            display: block;
          }
          .infos {
            margin-left: 0;
            margin-top: 1.5rem;
          }
          .links button {
            min-width: 100px;
          }
        }
    </style>

  
    <style>
      .checkbox-wrapper-34 {
        --blue: #0D7EFF;
        --g08: #E1E5EB;
        --g04: #848ea1;
      }

      .checkbox-wrapper-34 .tgl {
        display: none;
      }
      .checkbox-wrapper-34 .tgl,
      .checkbox-wrapper-34 .tgl:after,
      .checkbox-wrapper-34 .tgl:before,
      .checkbox-wrapper-34 .tgl *,
      .checkbox-wrapper-34 .tgl *:after,
      .checkbox-wrapper-34 .tgl *:before,
      .checkbox-wrapper-34 .tgl + .tgl-btn {
        box-sizing: border-box;
      }
      .checkbox-wrapper-34 .tgl::selection,
      .checkbox-wrapper-34 .tgl:after::selection,
      .checkbox-wrapper-34 .tgl:before::selection,
      .checkbox-wrapper-34 .tgl *::selection,
      .checkbox-wrapper-34 .tgl *:after::selection,
      .checkbox-wrapper-34 .tgl *:before::selection,
      .checkbox-wrapper-34 .tgl + .tgl-btn::selection {
        background: none;
      }
      .checkbox-wrapper-34 .tgl + .tgl-btn {
        outline: 0;
        display: block;
        width: 57px;
        height: 27px;
        position: relative;
        cursor: pointer;
        user-select: none;
        font-size: 12px;
        font-weight: 400;
        color: #fff;
      }
      .checkbox-wrapper-34 .tgl + .tgl-btn:after,
      .checkbox-wrapper-34 .tgl + .tgl-btn:before {
        position: relative;
        display: block;
        content: "";
        width: 44%;
        height: 100%;
      }
      .checkbox-wrapper-34 .tgl + .tgl-btn:after {
        left: 0;
      }
      .checkbox-wrapper-34 .tgl + .tgl-btn:before {
        display: inline;
        position: absolute;
        top: 7px;
      }
      .checkbox-wrapper-34 .tgl:checked + .tgl-btn:after {
        left: 56.5%;
      }

      .checkbox-wrapper-34 .tgl-ios + .tgl-btn {
        background: var(--g08);
        border-radius: 20rem;
        padding: 2px;
        transition: all 0.4s ease;
        box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.1);
      }
      .checkbox-wrapper-34 .tgl-ios + .tgl-btn:after {
        border-radius: 2em;
        background: #fff;
        transition: left 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275), padding 0.3s ease, margin 0.3s ease;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2);
      }
      .checkbox-wrapper-34 .tgl-ios + .tgl-btn:before {
        content: "No";
        left: 28px;
        color: var(--g04);
        transition: left 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
      }
      .checkbox-wrapper-34 .tgl-ios + .tgl-btn:active {
        box-shadow: inset 0 0 0 30px rgba(0, 0, 0, 0.1);
      }
      .checkbox-wrapper-34 .tgl-ios + .tgl-btn:active:after {
        padding-right: 0.4em;
      }
      .checkbox-wrapper-34 .tgl-ios:checked + .tgl-btn {
        background: var(--blue);
      }
      .checkbox-wrapper-34 .tgl-ios:checked + .tgl-btn:active {
        box-shadow: inset 0 0 0 30px rgba(0, 0, 0, 0.1);
      }
      .checkbox-wrapper-34 .tgl-ios:checked + .tgl-btn:active:after {
        margin-left: -0.4em;
      }
      .checkbox-wrapper-34 .tgl-ios:checked + .tgl-btn:before {
        content: "Si";
        left: 4px;
        color: #fff;
      }
    </style>





    <script>
        let Checkboxes = document.getElementsByClassName('tgl');
        for (const box of Checkboxes) {
            box.addEventListener('change', (event) => {
                let parent = event.target.parentNode.parentNode.parentNode.parentNode;
                if (event.target.checked) {
                    parent.className = 'cardSelect';
                } else {
                    //Buscar si tiene definicion de actividades
                    var NroAct = SprintAgilCargaPorTrabajador.ListarSprints(jNet.get(event.target).attr('id')).Rows.Count();
                    if (NroAct == 0){
                        parent.className = 'card';
                    }
                    else {
                        var msgConfig = { Titulo: "ERROR DE DESASIGNAR", Descripcion: "Colaborador cuenta ya con (" + NroAct + ") actividades definidas para este requerimiento, por lo tanto no es posible su anulación" };
                          var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                        event.target.checked = true;
                    }
                }
            });
        }



        SprintAgilCargaPorTrabajador.ListarSprints = function (IdPers) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "HelpDesk/AdministrarHD.asmx";
            oEasyDataInterConect.Metodo = "RequerimientoResponsableSprint_lst";

            var PersonalBE = AdministrarAtencion.Data.ObtenerCodArea();

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdRequerimiento", SprintAgilCargaPorTrabajador.Params[SprintAgilCargaPorTrabajador.KEYIDREQUERIMIENTO]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdPersonal", IdPers);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdPlandeTrabajo", "0");
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }




    </script>
    


</body>
</html>
