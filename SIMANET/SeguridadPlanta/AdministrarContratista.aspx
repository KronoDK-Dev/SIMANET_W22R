<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarContratista.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SegudidadIndustrial.AdministrarContratista" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   

        <script>
            function OnEasyGridAprobadores_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregar":

                    if (EasyAutocompletAct.GetText().length > 0) {
                        var NroFilIniClone=3
                        var oRow = EasyGridViewActividades.RowClone(NroFilIniClone, function (Celda, index) {
                            if (index == 0) {
                                if (jNet.get(Celda.parentNode).attr('TipoRow') != '4') {
                                    Celda.innerText = (EasyGridViewActividades.GetNroFila() - (NroFilIniClone-1));
                                }
                            }
                            else if (index == 1) {
                                Celda.innerText = EasyAutocompletAct.GetText();
                            }
                        });

                        oRow.attr('TipoRow', '2');
                        oRow.attr('IdActividad', EasyAutocompletAct.GetValue());

                        EasyAutocompletAct.Clear();
                    }
                    else {
                        var msgConfig = { Titulo: "Administrar Actividad", Descripcion: "Error al intentar crear una actividad" };
                        var oMsg = new SIMA.MessageBox(msgConfig);
                        oMsg.Alert();
                    }
                    break;
                case "btnEliminar":
                    EasyGridViewActividades.DeleteRowActive(true);
                    break;
            }
        }
        </script>


</head>
<body>

    <form id="form1" runat="server">
        <table style="width:100%;"  border="0">
              <tr>
                  <td>
                    

                  </td>
              </tr>
              <tr>
                  <td style="width:100%; height:100%">
                     
                  </td>
              </tr>     
         </table>
    </form>

</body>
</html>
