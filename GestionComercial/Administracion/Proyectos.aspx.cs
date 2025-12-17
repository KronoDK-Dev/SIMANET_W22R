using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionComercial;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionComercial.Administracion
{
    public partial class Proyectos : BaseComercial, IPaginaBase
    {
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Cargar datos solo en la primera carga
            {
                DatosIniciales();
                LlenarGrilla("");
                //    RegistrarScriptCheckEnter(); // Llama al método que registra el script  

            }
        }

        #region Metodos_basico

        protected void DatosIniciales()
        {
            try
            {
                if (eDDLCentros.Items.Count == 0)
                {
                    eDDLCentros.LoadData();
                    //------- COLOCAMOS DATOS POR DEFECTO SEGUN USUARIO ---
                    if (this.DatosUsuario.NroCentroOperativo.ToString() == null)
                    {
                        eDDLCentros.SelectedIndex = 1; // cargamos el primer registro para la busqueda del control asociado
                    }
                    else
                    {
                        if (this.DatosUsuario.NroCentroOperativo.ToString() != "9")
                        { eDDLCentros.SelectedValue = this.DatosUsuario.NroCentroOperativo.ToString(); } // cargamos para lo que tienen un solo centro
                        else
                        { eDDLCentros.SelectedIndex = 1; } // linea para los que tienen acceso a varios centros operativos
                    }


                    if (eDDLCentros.Items.Count > 1)
                    {

                        if (eDDLUnidadO.Items.Count == 0)
                        {
                            eDDLUnidadO.LoadData();
                            if (eDDLCentros.SelectedValue == "3")
                            {
                                eDDLUnidadO.Visible = true;
                                lblUO.Visible = true;
                            }
                            else
                            {
                                eDDLUnidadO.Visible = false;
                                lblUO.Visible = false;
                            }
                        }
                        // SI existe registro de centros, Cargo Lineas
                        eDDLLineas.LoadData();
                        if (eDDLLineas.Items.Count > 0)
                        {
                            dt = (new SolicitudSoapClient()).Lista_lineas_Usuario(this.DatosUsuario.Login, this.DatosUsuario.Login);
                            if (dt != null)
                            {
                                if (dt.Rows.Count == 1)
                                {
                                    eDDLLineas.SelectedValue = dt.Rows[0][0].ToString(); // linea
                                    // clase
                                    if (dt.Rows[0][1] != DBNull.Value && !string.IsNullOrEmpty(dt.Rows[0][1].ToString()))
                                    {
                                        // Personalizacion de búsqueda ---
                                        etbCriterio.Text = "CLASE> " + dt.Rows[0][1].ToString();
                                        Session["Clase"] = dt.Rows[0][1].ToString();
                                    }
                                }

                            }

                            // si existe lineas visualizo las sublineas
                            if (eDDLLineas.SelectedIndex > 0)
                            {
                                eDDLSLineas.LoadData();
                                if (eDDLSLineas.Items.Count > 0)
                                {
                                    eDDLSLineas.SelectedIndex = 1;
                                }
                            }
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
        protected void fnRefrescaUD(object sender, EventArgs e)
        {
            try
            {
                if (eDDLCentros.SelectedValue == "3")
                {
                    eDDLUnidadO.Visible = true;
                    lblUO.Visible = true;

                    eDDLUnidadO.ClearSelection();
                    eDDLUnidadO.LoadData();
                    eDDLLineas.ClearSelection();
                    eDDLLineas.LoadData();
                    /*
                    if (eDDLUnidadO.Items.Count <= 1)
                    { eDDLUnidadO.LoadData(); } */
                }
                else
                {
                    eDDLUnidadO.ClearSelection();
                    eDDLUnidadO.LoadData(); ;
                    eDDLLineas.ClearSelection();
                    eDDLLineas.LoadData();
                    eDDLUnidadO.Visible = false;
                    lblUO.Visible = false;
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
        protected void fnRefrescaLN(object sender, EventArgs e)
        {

            try
            {
                if (eDDLUnidadO.SelectedValue != "-1")
                {
                    eDDLLineas.LoadData();
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
        protected void FnRefrescaSLN(object sender, EventArgs e)
        {
            try
            {
                if (eDDLLineas.SelectedValue != "-1")
                {
                    eDDLSLineas.LoadData();
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
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                this.LlenarGrilla("");
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
        protected void EGV_EasyGridDetalle_Click(Dictionary<string, string> Recodset)
        {
            var codPry = Recodset["COD_PRY"].ToString();
            Session["codPry"] = codPry;
            EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
            oEasyNavigatorBE.Texto = "Detalle de proyecto";
            oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de proyecto";
            oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/GenerarProyecto.aspx";

            this.IrA(oEasyNavigatorBE, EGVproyectos);

        }
        protected void EGV_EasyGridButton_Click(EasyGridButton oEasyGridButton, Dictionary<string, string> Recodset)
        {
            try
            {
                switch (oEasyGridButton.Id)
                {
                    case "btnAgregar":
                        // usamos un control de navegación colocando el titulo de la siguiente página y su ruta de la página a abrir
                        EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE = new EasyControlWeb.Form.Controls.EasyNavigatorBE();
                        oEasyNavigatorBE.Texto = "Generar Proyecto";
                        oEasyNavigatorBE.Descripcion = "Registro y mantenimiento de Proyecto";
                        oEasyNavigatorBE.Pagina = "/GestionComercial/Administracion/GenerarProyecto.aspx";

                        // configuramos los parámetros del control de navagacion, colocando el id del registro actual, el modo de edición que tendrá
                        //verDetalledeInspeccion(EasyUtilitario.Enumerados.ModoPagina.N,"", "");
                        // oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), Modo.ToString()));
                        //oEasyNavigatorBE.Params.Add(new EasyNavigatorParam(EasyUtilitario.Constantes.Pagina.KeyParams.Modo.ToString(), EasyUtilitario.Enumerados.ModoPagina.N.ToString()));  // N= NUEVO

                        Session["codPry"] = string.Empty;
                        this.IrA(oEasyNavigatorBE, EGVproyectos); //EasyGestorFiltro1*/
                        break;
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
        protected void EGV_PageIndexChanged(object sender, EventArgs e)
        {
            this.LlenarGrilla("");
        }
        public void LlenarGrilla(string strFilter)
        {
            try
            {
                EGVproyectos.LoadData("");
                // /GestionComercial/Proceso.asmx/ListarProyectos  .PKG_GERENCIAL.PR_GET_PROYECTOS
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
        #endregion 

        #region "METODO_DEFULT"
        public void LlenarCombos()
        {
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
            throw new NotImplementedException();
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            throw new NotImplementedException();
        }

        public void RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }

        public bool ValidarDatos()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}