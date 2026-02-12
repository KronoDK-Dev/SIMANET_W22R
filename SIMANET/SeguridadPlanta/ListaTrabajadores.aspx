<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaTrabajadores.aspx.cs" Inherits="SIMANET_W22R.SIMANET.SeguridadPlanta.ListaTrabajadores" %>


<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc3" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc1" %>
<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>



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
          <td>
              <cc1:EasyGridView ID="grvTrabajadores" runat="server" AutoGenerateColumns="False" ShowFooter="True" TituloHeader="TRABAJADORES CONTRATISTAS"   Width="100%" fncExecBeforeServer="" ToolBarButtonClick="OnEasyGridButton_Click" OnRowDataBound="grvTrabajadores_RowDataBound" >

                      <EasyStyleBtn ClassName="btn btn-primary" FontSize="1em" TextColor="white" />
                          <DataInterconect MetodoConexion="WebServiceExterno">
                              <UrlWebService></UrlWebService>
                              <Metodo>
RespnsablePorArea_Lst</Metodo>
                              <UrlWebServicieParams>
                                  <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="CodEmp" Paramvalue="001"  />
                                  <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="CodCeo" Paramvalue="001"  />
                                  <cc2:EasyFiltroParamURLws ObtenerValor="FunctionScript" ParamName="CodArea" Paramvalue="ObtenerCodArea()"/>
                                  <cc2:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="UserName" Paramvalue="UserName" TipodeDato="String"/>
                              </UrlWebServicieParams>
                          </DataInterconect>

                      <EasyExtended ItemColorMouseMove="#CDE6F7" ItemColorSeleccionado="#ffcc66" RowItemClick="ListaTrabajadores.OnNull " RowCellItemClick="ListaTrabajadores.OnNull "  idgestorfiltro=""></EasyExtended>

                      <EasyRowGroup GroupedDepth="0" ColIniRowMerge="0"></EasyRowGroup>

                      <AlternatingRowStyle CssClass="AlternateItemGrilla" />

                      <Columns>
                          <asp:BoundField HeaderText="NRO DNI" DataField="NroDNI" >
                          <ItemStyle HorizontalAlign="Left" Width="10%" />
                          </asp:BoundField>
                          <asp:BoundField HeaderText="APELLIDOS Y NOMBRES" DataField="Nombres" >
                          <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                          </asp:BoundField>
                          <asp:TemplateField HeaderText="SCTR">
                              <ItemStyle Width="15%" />
                          </asp:TemplateField>
                          <asp:TemplateField HeaderText="EXAMEN">
                              <ItemStyle Width="15%" />
                          </asp:TemplateField>
                          <asp:BoundField DataField="tFechaInicio" HeaderText="F.INICIO" />
                          <asp:BoundField DataField="tFechaTermino" HeaderText="F.TERMINO" />
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

      <script>
          ListaTrabajadores.OnNull = function () {
      } 
          ListaTrabajadores.Eliminar = function (e) {

          var ConfigMsgb = {
              Titulo: 'TRABAJADOR'
              , Descripcion: "Desea eliminar el registro de trabajador ahora?"
              , Icono: 'fa fa-question-circle'
              , EventHandle: function (btn) {
                  if (btn == 'OK') {

                      try {
                          alert();
                          var DataRowBE = grvTrabajadores.GetDataRow();
                          /*AdministrarResponsablePorArea.EliminarResponsable(DataRowBE.IDTBL, DataRowBE.IDITEM);
                          AdministrarResponsablePorArea.ListarResponsables();*/
                      }
                      catch (SIMADataException) {
                          var msgConfig = { Titulo: "Error al Eliminar Responsable", Descripcion: SIMADataException.Message };
                          var oMsg = new SIMA.MessageBox(msgConfig);
                          oMsg.Alert();
                      }

                  }
              }
          };
          var oMsg = new SIMA.MessageBox(ConfigMsgb);
          oMsg.confirm();
      }
      </script>

</body>
</html>
