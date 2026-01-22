<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarMapeoCampos.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.AdministrarMapeoCampos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="content_wrap">
            <ul id="treeNavField" class="ztree"></ul>
        </div>
    </form>
</body>
<script>
    AdministrarMapeoCampos.Navigator = {};
    AdministrarMapeoCampos.Navigator.Init = function () {
        treeObjetField = $.fn.zTree.init($("#treeNavField"), setting, arrData);
    }
    AdministrarMapeoCampos.Navigator.DblClick = function (event, treeId, treeNode, clickFlag) {
        // treeObjetField.editName(treeNode);

    }

    AdministrarMapeoCampos.Navigator.SaveRecursivo = function (oNodoPadre) {
        oNodoPadre.children.forEach(function (oNode, i) {
            var NodoPadre = oNode.getParentNode();
            var DataPadreBE = NodoPadre.Data.toString().SerializedToObject();

            var DataBE = oNode.Data.toString().SerializedToObject();
            var oObjetoMapeoExportBE = new ObjetoMapeoExportBE();
            oObjetoMapeoExportBE.IdDataField = ((DataBE.IdDataField == "") ? 0 : DataBE.IdDataField);
            oObjetoMapeoExportBE.IdDataFieldPadre = ((DataBE.IdDataFieldPadre == "") ? DataPadreBE.IdDataField : DataBE.IdDataFieldPadre);
            oObjetoMapeoExportBE.Nombre = oNode.name;
            oObjetoMapeoExportBE.Alias = ((oObjetoMapeoExportBE.Nombre != oNode.name) ? oNode.name : oObjetoMapeoExportBE.Nombre);
            oObjetoMapeoExportBE.Descripcion = DataBE.Descripcion;
            oObjetoMapeoExportBE.Tipo = ((DataBE.Tipo == "") ? oNode.IdTipo : DataBE.Tipo);
            oObjetoMapeoExportBE.FieldCompute = DataBE.FieldCompute;
            oObjetoMapeoExportBE.Exportar = 1;
            oObjetoMapeoExportBE.Orden = ((DataBE.Orden == "") ? oNode.getIndex() : DataBE.Orden);
            oObjetoMapeoExportBE.Prioridad = ((DataBE.Prioridad == "") ? 1 : DataBE.Prioridad);
            oObjetoMapeoExportBE.IdEstado = ((oNode.checked == true) ? 1 : 0);
            var Id = 0;
            if ((oObjetoMapeoExportBE.IdDataField == "0") && (oNode.checked == true)) {
                Id = ReportParams.Data.Tree.Commit(oObjetoMapeoExportBE);
                DataBE.IdDataField = Id;
            }
            else if (oObjetoMapeoExportBE.IdDataField != "0") {
                Id = ReportParams.Data.Tree.Commit(oObjetoMapeoExportBE);
                DataBE.IdDataField = Id;
            }
            if (Id != 0) { oNode.id = Id; }

            if (oNode.children != undefined) {
                AdministrarMapeoCampos.Navigator.SaveRecursivo(oNode);
            }
        });
    }

    AdministrarMapeoCampos.Navigator.Modificar = function (oNodo) {
        if (oNodo.id != -1) {
            oNodo.children.foreach(function (oNodoChild, i) {


            });
        }
    }


    function getFont(treeId, node) {
        return node.font ? node.font : {};
    }


    var arrData = null;
    var treeObjetField = null;
    var IDMark_A = "_a";
    var setting = {

        edit: {
            enable: true,
            // editNameSelectAll: false, // Cuando la entrada del nombre de edición del nodo se muestre por primera vez, establezca si el contenido txt está todo seleccionado
            showRemoveBtn: false,
            showRenameBtn: false
        },
        view: {
            fontCss: getFont,
            nameIsHTML: true,
            dblClickExpand: false,
            txtSelectedEnable: true,
            showIcon: true,
            showLine: true,
            showTitle: true
            /* addDiyDom: addDiyDom*/
        },
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            /*onClick: AdministrarReporte.Navigator.Node.onClick,*/
            onDblClick: AdministrarMapeoCampos.Navigator.DblClick/*,
                onNodeCreated: zTreeOnNodeCreated,
                onExpand: AdministrarReporte.Navigator.Node.Expand,
                onCollapse: AdministrarReporte.Navigator.Node.Collapse,
                beforeDrag: AdministrarReporte.Navigator.Node.beforeDrag,
                beforeDrop: AdministrarReporte.Navigator.Node.beforeDrop,
                onDrop: AdministrarReporte.Navigator.Node.onDrop*/
        }
    };

</script>
</html>
