<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleServicio_Proceso.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Servicios.DetalleServicio_Proceso" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Base" TagPrefix="cc1" %>
<%@ Register TagPrefix="cc5" Namespace="EasyControlWeb.Filtro" Assembly="EasyControlWeb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td style="width: 100%">
                    NOMBRE:
                </td>
            </tr>
            <tr>
                <td style="width: 100%">
                    <cc2:EasyTextBox runat="server" ID="EasyNombre" Width="100%"/>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="row col-md-12">
                        <div style="width: 50%;padding-right: 15px;">
                                TIPO:
                        </div>
                        <div style="width: 50%;padding-left: 15px;">
                                PRODUCTO
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="row col-md-12">
                        <div style="width: 50%;padding-right: 15px;" >
                            <cc2:EasyDropdownList runat="server" ID="ltTipos" CargaInmediata="True" DataValueField="CODIGO" DataTextField="NOMBRE" MensajeValida="Seleccionar Tipo">
                            </cc2:EasyDropdownList>
                        </div>
                        <div style="width: 50%; padding-left: 15px;">
                            <cc2:EasyCheckBox runat="server" ID="chkServicio"></cc2:EasyCheckBox>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 100%">
                    DESCRIPCION:
                </td>
            </tr>
            <tr>
                <td style="width: 100%">
                    <cc2:EasyTextBox runat="server" ID="txtDescripcion" Width="100%" TextMode="MultiLine"/>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
