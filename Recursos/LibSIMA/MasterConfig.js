var Calidad = {};
Calidad.TablasApoyo = {};
Calidad.TablasApoyo.ItemSelected = null;


Calidad.TablasApoyo.ITempateListarTodos = function () {
    var cmll = "'";
    var MsgTemplate = 'Seleccionar Tabla de Apoyo?<br><br><div>'
    SIMA.Utilitario.Helper.TablaGeneralApoyo(695).Rows.forEach(function (oDataRow, f) {
        var strData = "";
        oDataRow.Columns.forEach(function (oDataColumn, c) {
            strData += ((c == 0) ? "" : ",") + oDataColumn.Name + ":" + cmll + oDataRow[oDataColumn.Name] + cmll;
        });
        strData = "{" + strData + "}";

        MsgTemplate += '<table class="ItemDisponible" Data="' + strData + '" width="100%" onclick="javascript:Calidad.TablasApoyo.OnSelected(this);"><tr> <td align="Left" >' + oDataRow["NOMBRE"].toString() + '</td><td align="right">' + "Alt + [" + oDataRow["VAR1"].toString() + "]" + '</td></tr></table>';
    });
    MsgTemplate += '</div>';
    return MsgTemplate;
}
Calidad.TablasApoyo.OnSelected = function (e) {
    Calidad.TablasApoyo.ItemSelected = jNet.get(e).attr("Data").toString().SerializedToObject();
    var objContent = jNet.get(e.parentNode);
    objContent.forEach(function (ochild, i) {
        var oDataBE = ochild.attr("Data").toString().SerializedToObject();
        nclass = ((oDataBE.CODIGO == Calidad.TablasApoyo.ItemSelected.CODIGO) ? "ItemSelected" : "ItemDisponible");
        ochild.attr("class", nclass);
    });
}

Calidad.TablasApoyo.Show = function () {
        var strPath = window.location.href;
        var PagActual = strPath.split('?')[0].split('/');
        var NombrePagActual = PagActual[PagActual.length - 1].toString().Replace(".aspx","");//Obtiene el nombre de la pagina actual

        var ConfigMsgb = {
            Titulo: "TABLAS DE APOYO"
            , Descripcion: Calidad.TablasApoyo.ITempateListarTodos()
            , Icono: 'fa fa-list-alt'
            , EventHandle: function (btn) {
                if (btn == 'OK') {
                    var urlPag = Page.Request.ApplicationPath + "/General/AdministrarTblGeneraltems.aspx";
                    var oColletionParams = new SIMA.ParamCollections();
                    var oParam = new SIMA.Param(GlobalEntorno.KEYQIDTABLAGENERAL, Calidad.TablasApoyo.ItemSelected.CODIGO);
                    oColletionParams.Add(oParam);
                    oParam = new SIMA.Param(GlobalEntorno.KEYQDESCRIPCION, Calidad.TablasApoyo.ItemSelected.NOMBRE);
                    oColletionParams.Add(oParam);
                    oParam = new SIMA.Param(GlobalEntorno.KEYQQUIENLLAMA, NombrePagActual);
                    oColletionParams.Add(oParam);
                    EasyPopupTablaItems.Load(urlPag, oColletionParams, false);

                }
            }
        };
        var oMsg = new SIMA.MessageBox(ConfigMsgb);
        oMsg.confirm();
    }