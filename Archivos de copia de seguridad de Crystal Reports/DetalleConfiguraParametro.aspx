<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleConfiguraParametro.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.DetalleConfiguraParametro" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Controls" tagprefix="cc1" %>
<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc3" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
  


</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="WIDTH: 100%">
                <tr>
                    <td style="WIDTH: 100%;font-size=18"  class="Etiqueta" align="center" >
                        <asp:Label ID="lblParametro" runat="server" Text="lblParametro"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td  style="WIDTH: 100%">
                        <table >
                            <tr>
                                <td  class="Etiqueta">NOMBRE DISPLAY:</td>
                                <td style="WIDTH: 100%">
                                    <cc1:EasyTextBox ID="txtNombreParam" runat="server"></cc1:EasyTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td  class="Etiqueta">DESCRIPCION:</td>
                                <td>
                                    <cc1:EasyTextBox ID="txtDescripcionParam" runat="server" TextMode="MultiLine" Width="100%"></cc1:EasyTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td  class="Etiqueta">SECCION</td>
                                <td style="WIDTH: 100%">
                                    <cc1:EasyDropdownList ID="ddlSeccion" runat="server"  DataTextField="Nombre" DataValueField="IdObjeto" CargaInmediata="true">
                                    <EasyStyle Ancho="Seis"></EasyStyle>
                                      <DataInterconect MetodoConexion="WebServiceInterno">
                                           <UrlWebService>/GestionReportes/Procesar.asmx</UrlWebService>
                                           <Metodo>Listar</Metodo>
                                           <UrlWebServicieParams>
                                               <cc3:EasyFiltroParamURLws  ParamName="IdObj" Paramvalue="IdObj" TipodeDato="String" ObtenerValor="DinamicoPorURL"/>
                                               <cc3:EasyFiltroParamURLws ParamName="UserName" Paramvalue="UserName" ObtenerValor="Session" />
                                           </UrlWebServicieParams>
                                     </DataInterconect>
                                    </cc1:EasyDropdownList>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td  class="Etiqueta">CONTROL ASOCIADO</td>
                                <td>
                                    <cc1:EasyDropdownList ID="ddlCtrlAsociado" runat="server"  DataTextField="VAR1" DataValueField="CODIGO" CargaInmediata="true" Requerido="True">
                                    <EasyStyle Ancho="Seis"></EasyStyle>
                                        <DataInterconect MetodoConexion="WebServiceInterno">
                                               <UrlWebService>/General/TablasGenerales.asmx</UrlWebService>
                                               <Metodo>ListarItems</Metodo>
                                               <UrlWebServicieParams>
                                                   <cc3:EasyFiltroParamURLws ObtenerValor="Fijo" ParamName="IdTabla" Paramvalue="672" TipodeDato="String" />
                                                   <cc3:EasyFiltroParamURLws ObtenerValor="Session" ParamName="UserName" Paramvalue="UserName" TipodeDato="String" />
                                               </UrlWebServicieParams>
                                       </DataInterconect>
                                    </cc1:EasyDropdownList>

                                     

                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    
    <script>
        DetalleConfiguraParametro.Validar = function () {
            return true;
        }
        DetalleConfiguraParametro.VerificarSecciones = function () {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
            oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
            oEasyDataInterConect.Metodo = "Listar";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdPadre", DetalleConfiguraParametro.Params[DetalleConfiguraParametro.KEYQIDOBJETO]);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", DetalleReporte.Params["UserName"]);
            oParamCollections.Add(oParam);

            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var oDataTable = new SIMA.Data.DataTable('tbl');
            oDataTable = oEasyDataResult.getDataTable();

            return ((oDataTable.Rows.Count()>0)?true:false);
        }

        DetalleConfiguraParametro.onAceptar = function () {

            AdministrarReporte.Config.DataSource(DetalleReporte.Params[DetalleReporte.KEYQIDOBJETO], "Externo");
            return;
            if (DetalleConfiguraParametro.VerificarSecciones()) {
                var strNombre = jNet.get('txtNombreParam').value;
                var strDescrip = jNet.get('txtDescripcionParam').value;
                var oObjetoBE = new ObjetoBE();

                if (DetalleConfiguraParametro.Validar()) {
                    //DetalleConfiguraParametro.Params[DetalleConfiguraParametro.KEYQIDOBJETO];//Id del objeto reporte que viene desde la administracion treeview
                    oObjetoBE.IdObjeto = 0;
                    oObjetoBE.IdPadre = ddlSeccion.GetValue()
                    oObjetoBE.Nombre = strNombre;
                    oObjetoBE.IdTipo = 9;//Tipo de Objeto param
                    oObjetoBE.IdTipoControl = ddlCtrlAsociado.GetValue();//Tipo de control se obtiene del ddlTipoControl
                    oObjetoBE.Descripcion = strDescrip;
                    oObjetoBE.Ref1 = DetalleConfiguraParametro.Params[DetalleConfiguraParametro.KEYQNOMBREPARAM];
                    oObjetoBE.Ref2 = DetalleConfiguraParametro.Params[DetalleConfiguraParametro.KEYQTIPOPARAM];
                    oObjetoBE.Ref3 = "";
                    oObjetoBE.Ref4 = "";
                    oObjetoBE.IdUsuarioAnalista = 0;
                    oObjetoBE.IdUsuarioSolicitante = 0;
                    oObjetoBE.IdEstado = 1;
                    /*Reutilza el metodo de mantenimiento de la pagina */

                    if (DetalleReporte.Modificar(oObjetoBE) == 1) {//Se Ubica en la pagina de AdministrarReporte
                        AdministrarReporte.Config.DataSource(DetalleReporte.Params[DetalleReporte.KEYQIDOBJETO],"Externo");
                        return true;
                    }
                    else {
                        alert('Probleas al intentar grabar la informacion');
                        return false;
                    }
                }
            }
            else {
                var msgConfig = { Titulo: "Error Registro de Parametros", Descripcion: "No es posible gurdar esta configuración para este parámetros  es necesario que exista por lo menos una sección de configuración" };
                var oMsg = new SIMA.MessageBox(msgConfig);
                oMsg.Alert();
            }
        }
    </script>
</body>
</html>
