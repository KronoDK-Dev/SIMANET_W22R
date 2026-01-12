<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalledeNota.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.ITIL.DetalledeNota" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

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
              <td class="Etiqueta">
                  Titulo:
              </td>
          </tr>
          <tr>
             <td>
                 <cc1:EasyTextBox ID="EasyTxtTitulo" runat="server"></cc1:EasyTextBox>
             </td>
          </tr>
          <tr>
              <td class="Etiqueta">
                  Tipo:
              </td>
          </tr>
          <tr>
             <td>
                 <cc1:EasyDropdownList ID="EasyddlTipo" runat="server"></cc1:EasyDropdownList>
             </td>
          </tr>
          <tr>
              <td class="Etiqueta">
                  Descripción:
              </td>
          </tr>
          <tr>
             <td> 
                 <cc1:EasyTextBox ID="EasyTxtDescripcion" runat="server" Rows="5" TextMode="MultiLine"></cc1:EasyTextBox>
             </td>
          </tr>

      </table>
    </form>
    <script>
        DetalledeNota.Aceptar = function () {
            var ResultBE = DetalledeNota.ModificaInserta();
            if (DetalledeNota.ModoEdit == SIMA.Utilitario.Enumerados.ModoPagina.N) {
                var oNote = new oViewNotes.Nota(ResultBE.IdOut, EasyTxtTitulo.GetValue(), EasyTxtDescripcion.GetValue(), "Hoy", EasyddlTipo.GetValue());
                oViewNotes.NewNota(oNote);
            }
            else {
                var oNote = new oViewNotes.Nota(ResultBE.IdOut, EasyTxtTitulo.GetValue(), EasyTxtDescripcion.GetValue(), "Hoy", EasyddlTipo.GetValue());
                oViewNotes.UpdateNota(oNote);
            }

            return true;
        }

        DetalledeNota.ModificaInserta = function () {

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdAccion", DetalledeNota.Params[DetalledeNota.KEYIDACCCION]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdNota", DetalledeNota.Params[DetalledeNota.KEYIDNOTA]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Titulo", EasyTxtTitulo.GetValue());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("Descripcion", EasyTxtDescripcion.GetValue());
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('IdTipoNota', EasyddlTipo.GetValue(), TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + 'HelpDesk/ITIL/GestiondeConfiguracion.asmx';
            oEasyDataInterConect.Metodo = 'ProcedimientoNotaIns';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var obj = oEasyDataResult.sendData();
            return obj.toString().SerializedToObject();
        }


    </script>
</body>
</html>
