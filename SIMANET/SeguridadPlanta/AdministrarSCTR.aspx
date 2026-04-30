<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarSCTR.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.AdministrarSCTR" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    

    <script>
        

        function OnEasyGridButtonSCTR_Click(btnItem, DetalleBE) {
            switch (btnItem.Id) {
                case "btnAgregar":

                   

                   /* var SCTRBE = jNet.get('txtPension').attr("data").toString().SerializedToObject();
                    //alert(SCTRBE.pFIni);

                    EasyGRSCTR.ItemsforEach(function (oRow) {
                        var oDataRow = oRow.GetData();
                        alert(oDataRow["IdSCTR"]);      
                    });
                    */
                   

                    break;
            }
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:100%;">
                <tr>
                    <td>
                        <cc1:EasyGridView ID="EasyGRSCTR"   AutoGenerateColumns="False" ShowFooter="True" ToolBarButtonClick="OnEasyGridButtonSCTR_Click" TituloHeader="SCTR" Width="100%" AllowPaging="True" runat="server" fncExecBeforeServer="" OnRowDataBound="EasyGRSCTR_RowDataBound" >

                                <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                                <DataInterconect MetodoConexion="WebServiceInterno"></DataInterconect>
                     
                                <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" idgestorfiltro="" RowItemClick="AdministrarSCTR.GridCellOnClick" ></EasyExtended>

                                <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>
                                <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                                <Columns>
                                    <asp:BoundField DataField="TipoSCTR" HeaderText="TIPO." />
                                    <asp:BoundField DataField="NroPoliza" HeaderText="NRO POLIZA" >
                                        <ItemStyle HorizontalAlign="Left" Width="8%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FechaInicio" HeaderText="FECHA INICIO">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FechaVencimiento" HeaderText="FECHA VENCE" >
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:TemplateField></asp:TemplateField>
                                </Columns>
                            <HeaderStyle CssClass="HeaderGrilla" />
                            <PagerStyle HorizontalAlign="Center" />
                            <RowStyle CssClass="ItemGrilla" Height="25px" />
                            </cc1:EasyGridView>
                    </td>
                </tr>

            </table>
    </form>
</body>
  <script>
      AdministrarSCTR.GridCellOnClick = function (oCell, oDataBE) {
          switch (oCell.cellIndex) {
              case 0:
                  // AdministrarSCTR.Detalle(SIMA.Utilitario.Enumerados.ModoPagina.M, oDataBE.IdSCTR);
                  break;
              default:

                  break;
          }
      }
      AdministrarSCTR.Eliminar = function (e) {
          var ConfigMsgb = {
              Titulo: 'ITEM SCTR SALUD/PENSION'
              , Descripcion: "Desea eliminar el registro seleccionado ahora?"
              , Icono: 'fa fa-question-circle'
              , EventHandle: function (btn) {
                  if (btn == 'OK') {

                      try {
                          var DataRowBE = EasyGRSCTR.GetDataRow();
                          DetalleProgramacion.LoadCSTR();
                      }
                      catch (SIMADataException) {
                          var msgConfig = { Titulo: "Error al Eliminar SCTR", Descripcion: SIMADataException.Message };
                          var oMsg = new SIMA.MessageBox(msgConfig);
                          oMsg.Alert();
                      }

                  }
              }
          };
          var oMsg = new SIMA.MessageBox(ConfigMsgb);
          oMsg.confirm();
      }

      /*
      AdministrarSCTR.Detalle = function (oModo, IdSCTR) {
          var Url = Page.Request.ApplicationPath + "/SIMANET/SeguridadPlanta/DetalleSCTR.aspx";
          var oColletionParams = new SIMA.ParamCollections();
          var oParam = new SIMA.Param(AdministrarSCTR.KEYQIDENTIDAD, AdministrarSCTR.Params[AdministrarSCTR.KEYQIDENTIDAD]);
          oColletionParams.Add(oParam);

          oParam = new SIMA.Param(AdministrarSCTR.KEYQNROSALUD, AdministrarSCTR.Params[AdministrarSCTR.KEYQNROSALUD]);
          oColletionParams.Add(oParam);

          oParam = new SIMA.Param(AdministrarSCTR.KEYQPENSION, AdministrarSCTR.Params[AdministrarSCTR.KEYQPENSION]);
          oColletionParams.Add(oParam);

          oParam = new SIMA.Param(AdministrarSCTR.KEYQIDSCTR, IdSCTR);
          oColletionParams.Add(oParam);

          oParam = new SIMA.Param(AdministrarSCTR.KEYMODOPAGINA, oModo);
          oColletionParams.Add(oParam);

          EasyPopupDetalleSCTR.Load(Url, oColletionParams, false);
      }
      */
  </script>   
</html>
