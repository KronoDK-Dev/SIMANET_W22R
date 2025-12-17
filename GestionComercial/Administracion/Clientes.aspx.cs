using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.Exceptiones;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionComercial.Administracion
{
    public partial class Clientes : PaginaBase
    {
        string valorColumna;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack) // Cargar datos solo en la primera carga
                {
                    LlenarGrilla("");
                    // -- lineas para permitir el dobleclick --
                    string eventTarget = Request.Params["__EVENTTARGET"];
                    string eventArgument = Request.Params["__EVENTARGUMENT"];

                    if (!string.IsNullOrEmpty(eventTarget) && eventTarget == GrillaClientes.UniqueID)
                    {
                        if (!string.IsNullOrEmpty(eventArgument) && eventArgument.StartsWith("DoubleClick$"))
                        {
                            string idCliente = eventArgument.Replace("DoubleClick$", "");

                            // Crear diccionario para simular Recodset
                            Dictionary<string, string> recordset = new Dictionary<string, string>
                            {
                                { "V_CLIENTE_ID", idCliente }
                            };

                            // Llamar al método que maneja la navegación
                            GrillaClientes_EasyGridDetalle_Click(recordset);
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                this.LanzarException(methodName, ex); // error para el log
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }

        private void LlenarGrilla(string strFilter)
        {
            try
            {
                //var pr = new Proceso();

                //DataTable dt = pr.ListarSolicitudTrabajo("T", "", "1", "", "01/01/2023", "01/01/2025", "mnunez"); // Reemplaza con el método correcto

                //// Asignar el DataTable al GridView
                //EasyGridView1.DataSource = dt;
                GrillaClientes.LoadData("");
            }
            catch (Exception ex)
            {

                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                this.LanzarException(methodName, ex); // error para el log
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }
        }

        protected void EasyGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            //this.LlenarGrilla(EasyGestorFiltro1.getFilterString());
            this.LlenarGrilla("");
        }

        protected void EasyGestorFiltro1_ProcessCompleted(string FiltroResultante, List<EasyFiltroItem> lstEasyFiltroItem)
        {
            this.LlenarGrilla(FiltroResultante);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            this.LlenarGrilla("");
        }
        //....
        protected void GrillaClientes_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            oEasyNavigatorBE.Texto = "Detalle de cliente";
            oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de cliente";
            oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/GenerarCliente.aspx";

            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("V_CLIENTE_ID", Recodset["V_CLIENTE_ID"])); // Para su uso: Request.QueryString["V_CLIENTE_ID"];
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("COD_UNISYS", Recodset["cod_unisys"])); // Estos campos son en casos aun no este generado el cmapo standarizado V_CLIENTE_ID
            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam("COD_COMERCIAL", Recodset["cod_comercialh"])); // Estos campos son en casos aun no este generado el cmapo standarizado V_CLIENTE_ID

            oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.M.ToString()));


            List<EasyNavigatorBE> oEasyNavigatorBElst = new List<EasyNavigatorBE>();
            try
            {
                string s = "";
                oEasyNavigatorBElst = (List<EasyNavigatorBE>)Session[EasyUtilitario.Constantes.Sessiones.Historial];
                foreach (EasyNavigatorBE onbe in oEasyNavigatorBElst)
                {
                    s += onbe.LstCtrlValue;
                }
                SIMAExceptionSeguridadAccesoForms ex = new SIMAExceptionSeguridadAccesoForms(s);
                ErrorDisplay(ex);
            }
            catch (Exception ex)
            {
                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                this.LanzarException(methodName, ex); // error para el log
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);
            }

            this.IrA(oEasyNavigatorBE, GrillaClientes);
        }
        protected void GrillaClientes_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
            // usamos un control de navegación colocando el titulo de la siguiente página y su ruta de la página a abrir
            // Instancia de navegación
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();

            switch (oEasyGridButton.Id)
            {
                case "btnAgregar":
                    oEasyNavigatorBE.Texto = "Generar Cliente";
                    oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de Clientes";
                    oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/GenerarCliente.aspx";

                    // configuramos los parámetros del control de navagacion, colocando el id del registro actual, el modo de edición que tendrá
                    // (EasyUtilitario.Enumerados.ModoPagina.N,"", "");
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.C.ToString()));  // C= CONSULTA
                    oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(IDCLIENTE, valorColumna));  // VALOR DE REGISTRO
                    this.IrA(oEasyNavigatorBE, GrillaClientes); //EasyGestorFiltro1*/

                    break;
                case "btnEmbarcaciones":
                    oEasyNavigatorBE.Texto = "Lista Embarcaciones";
                    oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de Embarcaciones";
                    oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/Embarcaciones.aspx";
                    this.IrA(oEasyNavigatorBE, GrillaClientes); //EasyGestorFiltro1*/

                    break;
                case "btnInfoRel":
                    break;
                case "btnEliminar":
                    break;
                case "btnImprimir":

                    break;
            }
        }

        protected void GrillaClientes_CambiaRegistro(object sender, EventArgs e)
        {
            // Obtener el índice de la fila seleccionada
            int rowIndex = GrillaClientes.SelectedIndex;

            // Obtener el valor de una columna específica (por índice)
            valorColumna = GrillaClientes.SelectedRow.Cells[8].Text;  // Cambia el índice según la columna deseada

        }

        protected void GrillaClientes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // para permitir capturar el valor seleccionado de cualquier columna

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Capturar el índice de la fila seleccionada
                string jsClick = Page.ClientScript.GetPostBackClientHyperlink(GrillaClientes, "Select$" + e.Row.RowIndex);

                // Obtener el ID del registro
                string idRegistro = DataBinder.Eval(e.Row.DataItem, "V_CLIENTE_ID")?.ToString() ?? "";

                // Script para diferenciar un solo clic de un doble clic
                string jsScript = $@"
            var clickTimer;
            e = event || window.event;
            if (e.detail === 1) {{
                clickTimer = setTimeout(function() {{
                    {jsClick}
                }}, 300);
            }} else if (e.detail === 2) {{
                clearTimeout(clickTimer);
                __doPostBack('{GrillaClientes.UniqueID}', 'DoubleClick$' + {idRegistro});
            }}";

                // Aplicar el evento onclick
                /*
                e.Row.Attributes["onclick"] = jsScript;
                e.Row.ToolTip = "Haz 1 clic para seleccionar esta fila y 2 clics para abrir su contenido";
                e.Row.Style["cursor"] = "pointer";
                */
            }

        }
    }
}