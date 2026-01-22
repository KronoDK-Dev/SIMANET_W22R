<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarTareas.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Atencion.ListarTareas" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <!--referencia a rango https://blog.logrocket.com/creating-custom-css-range-slider-javascript-upgrades/
        musica https://open.spotify.com/episode/55Eb282p44hVJzCJsaOMLg
        otros modelos : https://www.frontendplanet.com/css-range-slider-examples/
                    https://stackoverflow.com/questions/26612700/ticks-for-type-range-html-input
        https://css-tricks.com/value-bubbles-for-range-inputs/-->
</head>
<body>
    <form id="form1" runat="server">
                <table border="0" style="width:100%" >
                       <tr>
                           <td colspan="6"  class="Etiqueta" id="MsgErrTask">
                           </td>

                      </tr>
                    <tr>
                        <td class="Etiqueta" reference="eddlTask">
                            TAREA
                        </td>
                        <td>
                            <cc1:EasyDropdownList ID="eddlTask" runat="server" required></cc1:EasyDropdownList>
                        </td>
                        <td>

                        </td>
                         <td>

                        </td>
                        <td>

                        </td>
                        <td>
                           
                        </td>

                    </tr>

                    <tr>
                        <td colspan="6"  class="Etiqueta" reference="EasyAccion">
                            ACCION A TOMAR:</td>

                   </tr>

                    <tr>
                        <td colspan="6">
                            <cc1:EasyTextBox ID="EasyAccion" runat="server" TextMode="MultiLine" required></cc1:EasyTextBox>
                        </td>

                   </tr>
                     <tr>
                         <td  class="Etiqueta" reference="range3">
                             AVANCE:
                         </td>
                         <td style="width:50%;">
                              <div class="range" style="margin-top:10px;">
                                <input type="range" min="0" max="100" value="20" id="range3" required  runat="server"/> 
                                <div class="value3">0</div>
                             </div>
                         </td>
                         <td valign="center" style="width:10%">%</td>
                         <td valign="center" style="width:10%"></td>
                         <td valign="center" style="width:10%"></td>
                    </tr>
                    <tr>
                        <td colspan="5">
                             
                        </td>
                   </tr>

                </table>
        



    </form>

</body>
    <style>
       .rangeInput {
           -webkit-appearance: none;
           appearance: none; 
           width: 100%;
           cursor: pointer;
           outline: none;
           border-radius: 15px;
           height: 20px;
           height: 6px;
           background: #ccc;
         }
    </style>

    <style>
      .value3{
          font-size: 20px;    
          width: 50px;
          text-align: center;
          font-weight:bold;
            box-shadow: 0 0 0 10px rgba(255,85,0, .2);
            border-radius: 100%;
        }
        /* range 3 */
        #range3 {
          -webkit-appearance: none;
          appearance: none; 
          width: 100%;
          cursor: pointer;
          outline: none;
          border-radius: 15px;
          height: 20px;
          height: 6px;
          background: #ccc;
        }

            #range3::-webkit-slider-thumb {
              -webkit-appearance: none;
              appearance: none; 
              height: 30px;
              width: 30px;
              background: transparent;
              background-image: url("https://ibaslogic.github.io/hosted-assets/smile.png");
              background-size: cover;
              border-radius: 50%;
              transition: .2s ease-in-out;
              transform: rotateZ(var(--thumb-rotate, 0deg));
            }

            /* Thumb: Firefox */
            #range3::-moz-range-thumb {
              height: 30px;
              width: 30px;
              background: transparent;
              background-image: url("https://ibaslogic.github.io/hosted-assets/smile.png");
              background-size: cover;
              border: none;
              border-radius: 50%;
              transform: rotateZ(var(--thumb-rotate, 0deg));
              transition: .2s ease-in-out;
            }

            #range3::-webkit-slider-thumb:hover {
              box-shadow: 0 0 0 10px rgba(255,85,0, .1)
            }
            #range3:active::-webkit-slider-thumb {
              box-shadow: 0 0 0 13px rgba(255,85,0, .2)
            }

            #range3:focus::-webkit-slider-thumb {
              box-shadow: 0 0 0 13px rgba(255,85,0, .2)
            }

            #range3::-moz-range-thumb:hover {
              box-shadow: 0 0 0 10px rgba(255,85,0, .1)
            }
            #range3:active::-moz-range-thumb {
              box-shadow: 0 0 0 13px rgba(255,85,0, .2)
            }
            #range3:focus::-moz-range-thumb {
              box-shadow: 0 0 0 13px rgba(255,85,0, .2)    
            }

            /* range 3 */
            .range-slider {
              flex: 1;
            }

            .sliderticks {
              display: flex;
              justify-content: space-between;
              padding: 0 10px;
            }

            .sliderticks span {
              display: flex;
              justify-content: center;
              width: 1px;
              height: 10px;
              background: #d3d3d3;
              line-height: 40px;
            }

            .range {
              display: flex;
              align-items: center;
              margin-bottom: 1rem;
            }

    </style>
    <script>
        const sliderEl3 = document.querySelector("#range3")
        const sliderValue3 = document.querySelector(".value3")

        

        sliderEl3.addEventListener("input", (event) => {
            SetProgressPaint(event.target.value);
        })

        function SetProgressPaint(Value) {
            const tempSliderValue = Number(Value);
            sliderValue3.textContent = tempSliderValue;
            const progress = (tempSliderValue / sliderEl3.max) * 100;
            sliderEl3.style.background = `linear-gradient(to right, #428bca ${progress}%, #ccc ${progress}%)`;
            sliderEl3.style.setProperty("--thumb-rotate", `${(tempSliderValue / 100) * 2160}deg`);
        }

        var objValue = document.getElementById('range3');
        SetProgressPaint(objValue.value);
    </script>




 
    <script>
        /*referencia a card task
        https://frontendresource.com/css-recipe-cards/
        */
        ListarTareas.Aceptar = function () {
           // if (SIMA.Utilitario.Helper.Form.Validar()) {
                ListarTareas.GuardarDatos();
                EasyTabPlan.RefreshTabSelect();
                return true;
            //}
        }

        ListarTareas.GuardarDatos = function () {


            var IdTarea = ((ListarTareas.Params[ListarTareas.KEYMODOPAGINA] == SIMA.Utilitario.Enumerados.ModoPagina.N.toString()) ? "0" : ListarTareas.Params[ListarTareas.KEYIDTASKITEMCRONOGRAMA]);
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdTarea", IdTarea );
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdItemPlanCrono", ListarTareas.Params[ListarTareas.KEYIDITEMACTCRONOGRAMA]);//CODIGO DEL ITEM DE LA ACTIVIDAD DEL CRONOGRAMA
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdActividadTarea", eddlTask.GetValue());//lA TAREA QUE SE  ENCUENTRA DEFINIDO EN EL PROECDIMIENTO DE CADA ACTIVIDAD
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Descripcion", EasyAccion.GetValue());//LA aCCION A TOMAR EN LA TAREA SELECCIONADA
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("Avance", objValue.value, TipodeDato.Int);//LA aCCION A TOMAR EN LA TAREA SELECCIONADA
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            oEasyDataInterConect.Metodo = 'PlandeTrabajoActividadTareas_ins';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var obj = oEasyDataResult.sendData();

        }

    </script>
</html>
