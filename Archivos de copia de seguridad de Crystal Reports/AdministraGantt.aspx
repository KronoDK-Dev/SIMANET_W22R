<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministraGantt.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.AdministraGantt" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%">
            <tr>
                <td class="Etiqueta" style="width:5%">
                    AVANCE:
                </td>
                <td style="width:30%" id="ContentProgress" runat="server">
                </td>
                <td style="width:65%">

                </td>
            </tr>
            <tr>
                <td colspan="3">
                      <cc1:EasyGridView ID="EasyGridSprint" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="LISTA DE ACTIVIDADES" Width="100%"  ToolBarButtonClick="OnEasyGridToolBarAct_Click"  fncExecBeforeServer="" OnRowDataBound="EasyGridSprint_RowDataBound"  >
                          <EasyGridButtons>
                              <cc1:EasyGridButton ID="btnTarea" Descripcion="" Icono="fa fa-tasks" MsgConfirm=""  RequiereSelecciondeReg="true" RunAtServer="False" Texto="Agregar Tarea" Ubicacion="Derecha" />
                          </EasyGridButtons>

                              <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                 <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect>
                              <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="" RowCellItemClick="" idgestorfiltro="EasyGestorFiltro1"></EasyExtended>

                              <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
        
                              <AlternatingRowStyle CssClass="AlternateItemGrilla" />
        
                              <Columns>
                                  <asp:BoundField DataField="ID_ITEM" HeaderText="ITEM" >
                                  <ItemStyle HorizontalAlign="Left" Width="2%" Wrap="False" />
                                  </asp:BoundField>
                                  <asp:BoundField DataField="ACTIVIDAD" HeaderText="ACTIVIDAD">
                                  <ItemStyle HorizontalAlign="Left" Width="20%" />
                                  </asp:BoundField>
                                  <asp:BoundField HeaderText="FECHA INICIO" DataFormatString="{0:dd/MM/yyyy}" DataField="F_INICIO" >
                                  <HeaderStyle HorizontalAlign="Center" />
                                  <ItemStyle HorizontalAlign="Left" Width="2%" />
                                  </asp:BoundField>
                                  <asp:BoundField HeaderText="ACCIONES-TAREAS" DataField="ACCION" >
                                  <ItemStyle HorizontalAlign="Left" Width="40%" />
                                  </asp:BoundField>
                                  <asp:TemplateField HeaderText="AVANCE">
                                      <ItemStyle Width="20%" />
                                  </asp:TemplateField>
                                  <asp:TemplateField>
                                      <ItemStyle Width="2%" />
                                  </asp:TemplateField>
                              </Columns>

                            <HeaderStyle CssClass="HeaderGrilla" />
                            <PagerStyle HorizontalAlign="Center" />
                            <RowStyle CssClass="ItemGrilla" Height="25px" />
        
                      </cc1:EasyGridView>           
                </td>
            </tr>
        </table>



    </form>
    <script>
        function OnEasyGridToolBarAct_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnTarea":
                   
                    var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/ListarTareas.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(AdministraGantt.KEYIDREQUERIMIENTO, AdministraGantt.Params[AdministraGantt.KEYIDREQUERIMIENTO]);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministraGantt.KEYIDACTIVIDAD, DetalleBE.ID_ACTIVIDAD);
                    oColletionParams.Add(oParam);//Usado para listar las tareas disponibles para su uso

                    oParam = new SIMA.Param(AdministraGantt.KEYIDPERSONAL, UsuarioBE.CodPersonal);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministraGantt.KEYIDRESPONSABLEATE, DetalleBE.ID_RESP_ATE);
                    oColletionParams.Add(oParam);//debera se usuado para admnistrar advividades en eñ cronograma
                    //Item del Cronograma
                    oParam = new SIMA.Param(AdministraGantt.KEYIDITEMACTCRONOGRAMA, DetalleBE.ID_ITEM);
                    oColletionParams.Add(oParam);

                    oParam = new SIMA.Param(AdministraGantt.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.N);
                    oColletionParams.Add(oParam);


                    EasyPopupTarea.Load(Url, oColletionParams, false);//Llama a la ventana de mantenimiento detalle


                    break;
            }
          
        }


        AdministraGantt.DetalledeTarea = function (IdTarea,IdItemCronograma, IdActividad) {

     
            var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/ListarTareas.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministraGantt.KEYIDREQUERIMIENTO, AdministraGantt.Params[AdministraGantt.KEYIDREQUERIMIENTO]);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministraGantt.KEYIDACTIVIDAD, IdActividad);
            oColletionParams.Add(oParam);//Usado para listar las tareas disponibles para su uso

            oParam = new SIMA.Param(AdministraGantt.KEYIDPERSONAL, UsuarioBE.CodPersonal);
            oColletionParams.Add(oParam);

            //Item del Cronograma
            oParam = new SIMA.Param(AdministraGantt.KEYIDITEMACTCRONOGRAMA, IdItemCronograma);//Para el detalle
            oColletionParams.Add(oParam);
                                                    
            oParam = new SIMA.Param(AdministraGantt.KEYIDTASKITEMCRONOGRAMA, IdTarea);//Para el detalle
            oColletionParams.Add(oParam);
            
            oParam = new SIMA.Param(AdministraGantt.KEYMODOPAGINA, SIMA.Utilitario.Enumerados.ModoPagina.M);
            oColletionParams.Add(oParam);


            EasyPopupTarea.Load(Url, oColletionParams, false);//Llama a la ventana de mantenimiento detalle

        }

        AdministraGantt.EliminarTarea = function (IdTarea) {
            var ConfigMsgb = {
                Titulo: 'TAREA DE ACTIVIDAD'
                , Descripcion: "Desea ud, eliminar esta tarea ahora?"
                , Icono: 'fa fa-question-circle'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {

                        try {
                            var oParamCollections = new SIMA.ParamCollections();
                            var oParam = new SIMA.Param("IdTarea", IdTarea);
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                            oParamCollections.Add(oParam);
                            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                            oParamCollections.Add(oParam);

                            var oEasyDataInterConect = new EasyDataInterConect();
                            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
                            oEasyDataInterConect.Metodo = 'PlandeTrabajoActividadTareas_Del';
                            oEasyDataInterConect.ParamsCollection = oParamCollections;

                            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                            var obj = oEasyDataResult.sendData();

                            return true;
                        }
                        catch (SIMADataException) {
                            var msgConfig = { Titulo: "Error al Eliminar Tarea", Descripcion: SIMADataException.Message };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();
                        }


                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }


        AdministraGantt.EliminarActividad = function (IdCronogramaActividad) {
            var ConfigMsgb = {
                Titulo: 'ACTIVIDAD'
                , Descripcion: "Desea ud, eliminar esta actividad ahora?"
                , Icono: 'fa fa-question-circle'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        try {
                                var oParamCollections = new SIMA.ParamCollections();
                                var oParam = new SIMA.Param("IdCronogramaActividad", IdCronogramaActividad);
                                oParamCollections.Add(oParam);
                                oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                                oParamCollections.Add(oParam);
                                oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                                oParamCollections.Add(oParam);

                                var oEasyDataInterConect = new EasyDataInterConect();
                                oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                                oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
                                oEasyDataInterConect.Metodo = 'PlanCronogramaActividad_del';
                                oEasyDataInterConect.ParamsCollection = oParamCollections;

                                var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                                var obj = oEasyDataResult.sendData();
                                //Refresca
                                EasyTabPlan.RefreshTabSelect();
                        }
                        catch (SIMADataException) {
                            var msgConfig = { Titulo: "Error al Eliminar Tarea", Descripcion: SIMADataException.Message };
                            var oMsg = new SIMA.MessageBox(msgConfig);
                            oMsg.Alert();
                        }


                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        }

        AdministraGantt.Task = {};
        AdministraGantt.Task.LineaTiempo = function (IdTask, Nombre, Descripcion,Avance) {
            var Url = Page.Request.ApplicationPath + "/HelpDesk/Atencion/AdministrarTaskTimeLine.aspx";
            var oColletionParams = new SIMA.ParamCollections();
            var oParam = new SIMA.Param(AdministraGantt.KEYIDTASKITEMCRONOGRAMA, IdTask);
            oColletionParams.Add(oParam);
            oParam = new SIMA.Param(AdministraGantt.KEYNOMBRETAREA, Nombre);
            oColletionParams.Add(oParam);
            oParam = new SIMA.Param(AdministraGantt.KEYDECRIPCIONTAREA, Descripcion);
            oColletionParams.Add(oParam);
            oParam = new SIMA.Param(AdministraGantt.KEYAVANCE, Avance);
            oColletionParams.Add(oParam);
            
            EasyPopupTaskLineaTiempo.Titulo = "Línea de Tiempo (Tarea)";
            EasyPopupTaskLineaTiempo.Load(Url, oColletionParams, false);//Llama a la ventana de mantenimiento detalle
        }


      
    </script>
</body>


        <style>
@import "bourbon";

* {
  @include box-sizing(border-box);
}
 .caja {
      width: 100%;
    /*  height: 100px;*/
      background-color: #f0f0f0;
      border-radius: 15px;
      box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.2);
  }


.recipe-card {
  background: #fff;
  margin: 4em auto;
 /* width: 100%;
  max-width: 496px;*/
  @include border-top-radius(5px);
  @include border-bottom-radius(5px);

  aside {
    position: relative;

    img {
      @include border-top-radius(5px);
    }

    .button {
      background: #57abf2;
      display: inline-block;
      position: absolute;
      top: 80%;
      right: 3%;
      width: em(65);
      height: em(65);
      border-radius: em(65);
      line-height: em(65);
      text-align: center;

      .icon {
        vertical-align: middle;
      }
    }
  }

  article {
    padding: 1.25em 1.5em;

    ul {
      list-style: none;
      margin: 0.5em 0 0;
      padding: 0;
      li {
        display: inline-block;
        margin-left: 1em;
        line-height: 1em;
        &:first-child {
          margin-left: 0;
        }

        .icon {
            vertical-align: bottom;
        }

        span:nth-of-type(2) {
          margin-left: 0.5em;
          font-size: 0.8em;
          font-weight: 300;
          vertical-align: middle;
          color: #838689;
        }
      }
    }

    h2, h3 {
      margin: 0;
      font-weight: 300;
    }

    h2 {
      font-size: em(28);
      color: #222222;
    }

    h3 {
      font-size: em(15);
      color: #838689;
    }

    p {
      margin: 1.25em 0;
      font-size: em(13);
      font-weight: 400;
      color: #222222;

      span {
        font-weight: 700;
        color: #000000;
      }
    }

    .TituloAccion {
      margin: 2em 0 0.5em;
      color:#439aff;
      text-decoration: underline;
      cursor:pointer;
    }
    .Parrafo {
        margin: 2em 0 0.5em;
    }
  }

  .icon {
      display: inline;
      display: inline-block;
      background-image: url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/203277/recipe-card-icons.svg);
      background-repeat: no-repeat;
  }

  .icon-calories,.icon-calories\:regular {
      background-position: 0 0;
      width: 16px;
      height: 19px;
  }

  .icon-clock,.icon-clock\:regular {
      background-position: 0 -19px;
      width: 20px;
      height: 20px;
  }

  .icon-level,.icon-level\:regular {
      background-position: 0 -39px;
      width: 16px;
      height: 19px;
  }

  .icon-play,.icon-play\:regular {
      background-position: 0 -58px;
      width: 21px;
      height: 26px;
  }

  .icon-users,.icon-users\:regular {
      background-position: 0 -84px;
      width: 18px;
      height: 18px;
  }
}
    </style>


</html>
