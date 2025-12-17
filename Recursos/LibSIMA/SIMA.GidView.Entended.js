



SIMA.GridView = new Object();
SIMA.GridView.Extended = new Object();
//Paginacion
SIMA.GridView.Paginacion = new Object();
SIMA.GridView.Paginacion.Enumeracion = {
                                        Circular:"1"
                                       }
SIMA.GridView.Paginacion.Extended = new Object();
SIMA.GridView.Extended.getDataRow = function (GridViewName) {
    oNroReg = $('#' + GridViewName + '_txtIdRegSelected').val();//El nombre del control txt proviene del easygridview control
    var oGridviewDataTable = null;
    eval("oGridviewDataTable= oDT_" + GridViewName);
    return oGridviewDataTable.Rows[oNroReg-1];
}
/*--------------------------------------------------------------------------------------------------------------------*/
SIMA.GridView.ViewReport = new Object();
SIMA.GridView.ViewReport.PrintPDF = function (GridViewName, Titulo) {
    var oEasyGridView = document.getElementById(GridViewName);
    try {
        var ConfigReport = {
            orientation: SIMA.ReportXI.Papel.Orientacion.Vertical,
            unit: 'mm',
            format: eval(SIMA.ReportXI.Papel.Formato.A4),
            AutoPrint: { variant: 'non-conform' }
        };

        var oReportXI = new SIMA.ReportXI(ConfigReport);
        oReportXI.HeaderStyle = { lineWidth: 0.2, fillColor: [241, 196, 15], fontSize: 15 };
        oReportXI.FooterStyle = { fillColor: [241, 196, 15], fontSize: 15, };
        oReportXI.BodyStyle = { fillColor: [52, 73, 94], textColor: 240 };
        oReportXI.AlternateStyle = { fillColor: [74, 96, 117] };

        var oImagenLogo = new SIMA.Logo(undefined, 10, 10);
        oReportXI.Seccion.Header.Add(oImagenLogo);

        var oFormato = new SIMA.ReportXI.Texto.Format(SIMA.ReportXI.FontName.Helvetica, 16, SIMA.ReportXI.FontType.Bold, SIMA.ReportXI.Texto.Color.gray);
        var oTextBox = new SIMA.TextBox(Titulo, 100, 30, oFormato);
        oReportXI.Seccion.Header.Add(oTextBox);

        oFormato = new SIMA.ReportXI.Texto.Format(SIMA.ReportXI.FontName.Times, 12, SIMA.ReportXI.FontType.Normal, SIMA.ReportXI.Texto.Color.gray);
        oTextBox = new SIMA.TextBox("Fecha:", 225, 20, oFormato);
        oReportXI.Seccion.Header.Add(oTextBox);

        oTextBox = new SIMA.TextBox(SIMA.Utilitario.Helper.Fecha.Hoy('-'), 240, 20, oFormato);
        oReportXI.Seccion.Header.Add(oTextBox);

        oTextBox = new SIMA.TextBox("Hora:", 225, 25, oFormato);
        oReportXI.Seccion.Header.Add(oTextBox);

        oTextBox = new SIMA.TextBox(SIMA.Utilitario.Helper.Hora.Hoy(), 240, 25, oFormato);
        oReportXI.Seccion.Header.Add(oTextBox);

        var oTable = new SIMA.TableXI();
        oTable.DataSource = oDT_EasyGridView1;//
        oTable.DataBoundColumns = eval(oEasyGridView.getAttribute("DataBoundColumns"));
        oTable.HeaderStyle = { lineWidth: 0.2, fillColor: [241, 196, 15], fontSize: 15 };
        oTable.FooterStyle = { fillColor: [241, 196, 15], fontSize: 15, };
        oTable.BodyStyle = { fillColor: [52, 73, 94], textColor: 240 };
        oTable.AlternateStyle = { fillColor: [74, 96, 117] };

        var oTableRow = null;
        var oTableCell = null;


        for (var f = 1; f <= oEasyGridView.rows.length - 1; f++) {
            var _Row = oEasyGridView.rows[f];
            if (_Row.getAttribute("TipoRow") == SIMA.TableXI.TipoRow.Header) {
                oTableRow = new SIMA.TableXI.Row(SIMA.TableXI.TipoRow.Header);
                for (var c = 0; c <= oEasyGridView.rows[f].cells.length - 1; c++) {
                    var _Cell = oEasyGridView.rows[f].cells[c];
                    if ((_Cell.getAttribute("colSpan") != null) && (_Cell.getAttribute("rowSpan") != null)) {
                        oTableCell = new SIMA.TableXI.Col(_Cell.innerText, _Cell.getAttribute("colSpan"), _Cell.getAttribute("rowSpan"), { halign: 'center' });
                    }
                    else if ((_Cell.getAttribute("colSpan") != null) && (_Cell.getAttribute("rowSpan") == null)) {
                        oTableCell = new SIMA.TableXI.Col(_Cell.innerText, _Cell.getAttribute("colSpan"), 1, { halign: 'center' });
                    }
                    else if ((_Cell.getAttribute("colSpan") == null) && (_Cell.getAttribute("rowSpan") != null)) {
                        oTableCell = new SIMA.TableXI.Col(_Cell.innerText, 1, _Cell.getAttribute("rowSpan"), { halign: 'center' });
                    }
                    else if ((_Cell.getAttribute("colSpan") == null) && (_Cell.getAttribute("rowSpan") == null)) {
                        oTableCell = new SIMA.TableXI.Col(_Cell.innerText);
                    }
                    oTableRow.Columns.Add(oTableCell);
                }
                oTable.Rows.Add(oTableRow);
            }
        }

        oReportXI.Seccion.Body.Add(oTable);


        oReportXI.PrintOut(GridViewName + '.pdf');
    }
    catch (Error) {
        if (Error instanceof SIMA.Exception.ErrorComponente) {
            $.confirm({
                title: 'Error de componente!',
                content: Error.message + "<br>Corrija la asingación o referencia al objeto",
                type: 'blue',
                draggable: true,
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Aceptar',
                        btnClass: 'btn-blue',
                        action: function () {
                        }
                    },
                    close: {
                        text: 'cancelar',
                        btnClass: 'btn-red',
                        action: function () {
                        }
                    }
                }
            });
        }
        else {
            alert(Error);
        }

    }
}
/*--------------------------------------------------------------------------------------------------------------------*/
SIMA.GridView.Extended.OnEventMouseInOutChangeColor = function (ItemRow, rowInOut) {
    var oGridCtrl = ItemRow.parentNode.parentNode;
    var ColorMoveMouseGrilla = oGridCtrl.getAttribute("ItemColorMouseMove");

    if (oGridCtrl.getAttribute("RowClickSelect") != ItemRow.rowIndex) {
        if (rowInOut == true) {
            oGridCtrl.setAttribute("lastColorUsed", ItemRow.style.backgroundColor);
            ItemRow.style.backgroundColor = ColorMoveMouseGrilla;
            ItemRow.style.cursor = 'hand';
        }
        else {
            ItemRow.style.backgroundColor = oGridCtrl.getAttribute("lastColorUsed");
        }
    }
    return true;
}

SIMA.GridView.Extended.OnEventClickChangeColor = function (ItemRow) {
    var oGridCtrl = ItemRow.parentNode.parentNode;
    var ColorSeleccionClick = oGridCtrl.getAttribute("ItemColorSeleccionado");

    var _ObjetoSelect_Ant = oGridCtrl.getAttribute("ObjetoSelect_Ant");

    if (_ObjetoSelect_Ant == null) {
        oGridCtrl.setAttribute("ObjetoSelect_Ant", ItemRow.rowIndex);
        oGridCtrl.setAttribute("lastColorUsed", ItemRow.style.backgroundColor);
    }

    if (_ObjetoSelect_Ant != null) { oGridCtrl.rows[_ObjetoSelect_Ant].style.backgroundColor = oGridCtrl.getAttribute("lastColorUsed"); }

    oGridCtrl.setAttribute("ObjetoSelect_Ant", ItemRow.rowIndex);
    oGridCtrl.setAttribute("lastColorUsed", ItemRow.style.backgroundColor);

    ItemRow.style.backgroundColor = ColorSeleccionClick;
    //Control de fila seleccionda
    oGridCtrl.setAttribute("RowClickSelect", ItemRow.rowIndex);
}

SIMA.GridView.Extended.OnEventClickColIni = function (ItemCol, EventHandler) {
    var oGridCtrl = ItemCol.parentNode.parentNode.parentNode;
    var oRowActive = ItemCol.parentNode;

    if (EventHandler != undefined) {
        EventHandler(oGridCtrl, oRowActive, ItemCol);
    }
}

SIMA.GridView.Extended.Paginacion = new Object();
SIMA.GridView.Extended.Paginacion.Apply = function (oGridView, TipoStyilo) {
   var oGrid;
    oGrid = ((typeof oGridView === "string") ? document.getElementById(oGridView) : oGridView);
    var cellFooter = oGrid.rows[oGrid.rows.length - 1].cells[0];
    cellFooter.height = "10";
    var tblPag = cellFooter.children[0];

    var dvPag = document.createElement("div");
    dvPag.setAttribute("class", "pagination p4");
    var UlPag = document.createElement("ul");

    try {
            for (var c = 0; c <= tblPag.rows[0].cells.length - 1; c++) {
                var aPag = tblPag.rows[0].cells[c].children[0];//Obtiene el elemento de la celda 
                var liPag = document.createElement("li"); // crea nuevo elemento de tipo li 
                liPag.innerText = aPag.innerText;
                aPag.innerText = '';

                if (aPag.tagName != "A") {
                    var aPagSelect = document.createElement("a");
                    aPagSelect.setAttribute("href", "#");
                    aPagSelect.setAttribute("class", "is-active  rounded-pill");

                    aPag = aPagSelect;
                }
                aPag.appendChild(liPag)
                UlPag.appendChild(aPag);
            }
            //Remover la tabla que contenia la paginacion
            tblPag.parentNode.removeChild(tblPag);
            //Agregar el div con la nueva paginacion
            dvPag.appendChild(UlPag);
                cellFooter.appendChild(dvPag);
    }
    catch (Error) {
        //No existe paginacion
    }
  
}
