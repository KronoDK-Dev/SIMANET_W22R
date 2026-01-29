<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleCarpeta.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.DetalleCarpeta" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Controls" tagprefix="cc1" %>

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
                        <asp:Label ID="Label1" runat="server" Text="NOMBRE:"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <cc1:EasyTextBox ID="txtNombreCarpeta" runat="server" Width="100%"></cc1:EasyTextBox>
                    </td>
                    
                </tr>
                <tr>
                    <td class="Etiqueta">
                        <asp:Label ID="Label2" runat="server" Text="DESCRIPCION"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <cc1:EasyTextBox ID="txtDescripcionCarpeta" runat="server" Height="80px" TextMode="MultiLine" Width="100%"></cc1:EasyTextBox>
                    </td>
                    
                </tr>
            </table>
    </form>
</body>

    <script>
        EasyPopupCarpeta.Carpeta = {};

        EasyPopupCarpeta.Carpeta.OnValidate = function () {
            var _msgText = "";
            var msgConfig = null;
            var Validado = true;
            if (jNet.get("txtNombreCarpeta").value.toString().length == 0) {
                _msgText = "No se ha ingresado Nombre de carpeta..";
                Validado = false;
            }

            if (jNet.get("txtDescripcionCarpeta").value.toString().length == 0) {
                _msgText += ((Validado == false) ?"<br>tampoco de ha ingresado la Descripcion de la Carpeta": "No se ha ingresado descripcion..");
                Validado = false;
            }

            if (Validado == false) {
                var msgConfig = { Titulo: "Error al intentar guardar información", Descripcion: _msgText };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
            return Validado;      
        }
        EasyPopupCarpeta.Carpeta.Agregar = function () {
            var oObjetoBE = new ObjetoBE();
            oObjetoBE.IdObjeto = 0;
            oObjetoBE.IdPadre = DetalleCarpeta.Params[DetalleCarpeta.KEYQIDOBJETO];
            oObjetoBE.Nombre = jNet.get("txtNombreCarpeta").value;
            oObjetoBE.IdTipo = "1";
            oObjetoBE.IdTipoControl = "0";
            oObjetoBE.Descripcion = jNet.get("txtDescripcionCarpeta").value;
            oObjetoBE.Ref1 = null;
            oObjetoBE.Ref2 = null;
            oObjetoBE.Ref3 = null;
            oObjetoBE.Ref4 = null;
            oObjetoBE.IdUsuarioAnalista = 0;
            oObjetoBE.IdUsuarioSolicitante = 0;
            oObjetoBE.IdEstado = "1";
            oObjetoBE.OrdenXNivel = 0;
            oObjetoBE.IdUsuario = DetalleCarpeta.Params["IdUsuario"];
            oObjetoBE.UserName = DetalleCarpeta.Params["UserName"];
            var iResult = AdministrarReporte.Commit(oObjetoBE);//Metodo ue se encuenta en el formulario Principal
            oObjetoBE.IdObjeto = iResult;

            //AdministrarReporte.Navigator.Node.Select = { Data: oObjetoBE };
            return oObjetoBE.IdObjeto;
        }
        EasyPopupCarpeta.Carpeta.Modificar = function () {
            var oObjetNodoBE = AdministrarReporte.Navigator.Node.Select.Data;
            var oObjetoBE = new ObjetoBE();
            oObjetoBE.IdObjeto = DetalleCarpeta.Params[DetalleCarpeta.KEYQIDOBJETO];
            oObjetoBE.IdPadre = oObjetNodoBE.IdPadre;
            oObjetoBE.Nombre = jNet.get("txtNombreCarpeta").value;
            oObjetoBE.IdTipo = oObjetNodoBE.IdTipo;
            oObjetoBE.IdTipoControl = oObjetNodoBE.IdTipoControl;
            oObjetoBE.Descripcion = jNet.get("txtDescripcionCarpeta").value;
            oObjetoBE.Ref1 = null;
            oObjetoBE.Ref2 = null;
            oObjetoBE.Ref3 = null;
            oObjetoBE.Ref4 = null;
            oObjetoBE.OrdenXNivel = 0;
            oObjetoBE.IdUsuarioAnalista = 0;
            oObjetoBE.IdUsuarioSolicitante = 0;
            oObjetoBE.IdEstado = "1";
            oObjetoBE.IdUsuario = DetalleCarpeta.Params["IdUsuario"];
            oObjetoBE.UserName = DetalleCarpeta.Params["UserName"];
            var iResult = AdministrarReporte.Commit(oObjetoBE); //Metodo ue se encuenta en el formulario Principal
            oObjetoBE.IdObjeto = iResult;

            return oObjetoBE.IdObjeto;
        }

        EasyPopupCarpeta.Carpeta.Administrar = function () {
            switch (DetalleCarpeta.Params[DetalleCarpeta.KEYMODOPAGINA]) {
                case SIMA.Utilitario.Enumerados.ModoPagina.N:
                    return EasyPopupCarpeta.Carpeta.Agregar();
                    break;
                case SIMA.Utilitario.Enumerados.ModoPagina.M:
                    return EasyPopupCarpeta.Carpeta.Modificar();
                    break;
            }
        }

        EasyPopupCarpeta.Aceptar = function () {
           
            if (EasyPopupCarpeta.Carpeta.OnValidate()) {
                var Idobj = EasyPopupCarpeta.Carpeta.Administrar();
                try {
                    AdministrarReporte.Navigator.Node.SelectActivate();
                    SIMA.Utilitario.Helper.ClearContent("treePropiedades");
                }
                catch (ex) {
                }
            }
            return true;
        }
    </script>
</html>
