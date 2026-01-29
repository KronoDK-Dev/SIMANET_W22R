<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleObjetoSeccion.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.DetalleObjetoSeccion" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Controls" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
   
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width:100%">
                <tr>
                    <td>NOMBRE:</td>
                    <td style="width: 100%">
                        <cc1:EasyTextBox ID="txtNombre" runat="server">
                        <EasyStyle Ancho="Siete"></EasyStyle>
                        </cc1:EasyTextBox>
                    </td>
                </tr>
                <tr>
                    <td>DESCRIPCION</td>
                    <td>
                        <cc1:EasyTextBox ID="txtDescripcion" runat="server" Height="50px" TextMode="MultiLine" Width="100%">
                        <EasyStyle Ancho="Nueve"></EasyStyle>
                        </cc1:EasyTextBox>
                    </td>
                </tr>
                <tr id="trParam" runat="server">
                    <td>PARÁMETRO</td>
                    <td>
                        <cc1:EasyTextBox ID="txtParametro" runat="server"><EasyStyle Ancho="Siete"></EasyStyle></cc1:EasyTextBox>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
    <script>
        DetalleObjetoSeccion.iTemplateTipoControl = function () {
            var cmll = "\"";
            var divContent = jNet.create("div");

            SIMA.Utilitario.Helper.TablaGeneralItem(672).Rows.forEach(function (oDataRow, f) {
                var CodigoCtrl = oDataRow["CODIGO"];
                if ((CodigoCtrl > 1) && (CodigoCtrl != 7)) {
                    //Crea a tabla representativa de control
                    var Ctrl = SIMA.Utilitario.Helper.HtmlControlsDesign.HtmlTable(1, 2);
                    var strData = "";
                    oDataRow.Columns.forEach(function (oDataColumn, c) {
                        strData += ((c == 0) ? "" : ",") + oDataColumn.Name + ":" + cmll + oDataRow[oDataColumn.Name] + cmll;
                    });
                    strData = "{" + strData + "}";
                    Ctrl.attr("id", "Ctrl_" + CodigoCtrl).attr("Data", strData).attr("class", "ItemDisponible");

                    var img = jNet.create("img");
                    img.attr("src", oDataRow["DESCRIPCION"].toString());
                    img.attr("width", "20px");

                    jNet.get(Ctrl.rows[0].cells[0]).insert(img);
                    Ctrl.rows[0].cells[1].innerText = oDataRow["VAR1"];
                    jNet.get(Ctrl.rows[0].cells[1]).css("width", "90%");
                    jNet.get(Ctrl.rows[0].cells[1]).attr("align", "Left");

                    Ctrl.attr("onclick", "DetalleObjeto_Reporte.iTemplateTipoControl_ObjOnClick(this);");//Se estalece como atributo el evento click genera un string, no funciona con el addEvent pues genera un objeto

                    divContent.insert(Ctrl);
                }


            });
            return divContent.innerHTML;
        }

        DetalleObjetoSeccion.iTemplateTipoControl_ObjOnClick = function (e) {
            DetalleObjeto_Reporte.ObjCtrlSelected = jNet.get(e).attr("Data").toString().SerializedToObject();
            var objContent = jNet.get(e.parentNode);
            objContent.forEach(function (ochild, i) {
                var oDataBE = ochild.attr("Data").toString().SerializedToObject();
                nclass = ((oDataBE.CODIGO == DetalleObjeto_Reporte.ObjCtrlSelected.CODIGO) ? "ItemSelected" : "ItemDisponible");
                ochild.attr("class", nclass);
            });
        }
    </script>
</html>
