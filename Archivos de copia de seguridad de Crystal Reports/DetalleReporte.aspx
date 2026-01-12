<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleReporte.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.DetalleReporte" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form" TagPrefix="cc4" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style>

.HeaderGrilla {
    height: 23px;
    font-size: 10px;
    color: black;
    font-family: Arial;
    background-color: white;
    text-align: center;
    vertical-align: middle;
    text-transform: uppercase;
    border-bottom-style: solid;
    border-bottom-color: dimgray;
    border-style: none;
    vertical-align: middle;
    font-weight:bold;
}

.AlternateItemGrilla {
    font-size: 10px;
    font-family: Arial;
    color: #000080;
    background-color: white;
    height: 10px;
    text-align: center;
    vertical-align: middle;
    border-bottom-width: 1px;
    border-bottom-style: solid;
    border-bottom-color: dimgray;
}

.ItemGrilla {
    font-size: 10px;
    color: #000080;
    font-family: Arial;
    background-color: white;
    height: 10px;
    text-align: center;
    vertical-align: middle;
    border-bottom-width: 1px;
    border-bottom-style: solid;
    border-bottom-color: dimgray;
}
    </style>
    
 <style>
   
     .ItemOP{
         background: #fefefe;
         color: #15428b;
         font: 12px tahoma,arial,sans-serif;
         height: 35px;
         margin-right:2px;
         border: 1px dotted #5394C8;
         display: inline-block;
         
      }


     .ItemOP td {
         padding-left:5px;
         padding-right:5px;
         height:35px;
     }

     .ItemOP tr:hover {
        background-color: #E1EFFA;
     }

     .ItemSelected{
         background: #2794DD;
         color: white;
         font: 12px tahoma,arial,sans-serif;
         height: 30px;
         margin-right:2px;
         border: 1px dotted #5394C8;
      }


     .ItemSelected td {
         padding:8px;
         height:100%;
     }
    /*Para el Boton anclar*/
    .imgEfect {
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 5px;
    }

    .imgEfect:hover {
      box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
    }

     .auto-style1 {
         width: 100%;
         height: 26px;
     }

 </style>

<script>
    function OnEasyGridDetalleProp_Click(oDetalleBE) {
        var urlPag = Page.Request.ApplicationPath + "/GestionReportes/AdministrarPropiedades.aspx";
        var oColletionParams = new SIMA.ParamCollections();
        var oParam = new SIMA.Param(DetalleReporte.KEYQIDOBJETO, oDetalleBE.IdObjeto);
        oColletionParams.Add(oParam);

        oParam = new SIMA.Param(DetalleReporte.KEYQIDTIPOCONTROL, oDetalleBE.IdTipoControl);
        oColletionParams.Add(oParam);

        SIMA.Utilitario.Helper.LoadPageIn("treePropiedades", urlPag, oColletionParams);
    }

   


</script>


</head>
<body>
    <form id="form1" runat="server">
       <table border="0px"  style="width:100%;">
                                                    <tr>
                                                        <td class="Etiqueta" colspan="4">ARCHIVO DE REPORTE</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="Etiqueta">
                                                            Nombre
                                                        </td>
                                                        <td style="width:30%" >
                                                            <cc3:EasyTextBox ID="EasyFindFile" style="width:100%"  runat="server" ReadOnly="True"></cc3:EasyTextBox>
                                                         </td>
                                                        <td class="Etiqueta">
                                                            Ruta:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRuta" runat="server" style="width:100%" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="Etiqueta" colspan="4">DATA INTERCONECT</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="Etiqueta" colspan="4">
                                                            Servicio
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        
                                                        <td  colspan="4" style="width:100%">
                                                            <cc3:EasyTextBox ID="EasyListaServicios" style="width:100%"  runat="server" ReadOnly="True"></cc3:EasyTextBox>
                                                        </td>
                                                      
                                                    </tr>
                                                    <tr>
                                                        <td class="Etiqueta" colspan ="4">metodo</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan ="4" >
                                                            <cc3:EasyTextBox ID="EasyListarMetodos" style="width:100%"  runat="server" ReadOnly="True"></cc3:EasyTextBox>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td class="Etiqueta">
                                                            Parámetros</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4" id="LstParam" style="width:100%" >Parámetros</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                             <cc1:EasyGridView ID="EasyGridViewParam" runat="server" AutoGenerateColumns="False" TituloHeader="PARÁMETROS CONFIGURADOS" Width="100%" ShowRowNumber="False" OnRowDataBound="EasyGridViewParam_RowDataBound" >
                                                                <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                                                <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="OnEasyGridDetalleProp_Click"></EasyExtended>
                                                            <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                                                                <AlternatingRowStyle CssClass="AlternateItemGrilla" />
                                                                <Columns>
                                                                    <asp:BoundField DataField="Nombre" HeaderText="ETIQUETA/DESCRIPCION">
                                                                    <ItemStyle HorizontalAlign="Left" Width="50%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Ref1" HeaderText="NOMBRE">
                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Ref2" HeaderText="TIPO"></asp:BoundField>
                                                                    <asp:BoundField DataField="ValorDefault" HeaderText="VAL DEFAULT"></asp:BoundField>
                                                                    <asp:TemplateField HeaderText="CTRL ASOCIADO">
                                                                <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                            </asp:TemplateField>
                                                                </Columns>
                                                                <HeaderStyle CssClass="HeaderGrilla" Height="25px" />
                                                                <RowStyle CssClass="ItemGrilla" Height="35px" />
                                                            </cc1:EasyGridView>
                                                        </td>
                                                 
                                                    </tr>
                                                </table>  


    </form>

   
</body>
</html>
