using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Web.UI;
/*  Referenciarmos al servicio */
using SIMANET_W22R.srvGestionProduccion;
using SIMANET_W22R.srvGeneral; 
using System.Diagnostics;
using System.Data;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.Form.Estilo;
using SIMANET_W22R.srvProyectos;
using System.Web;
using System.Web.UI.WebControls;   



namespace SIMANET_W22R.GestionProduccion.OT
{
    public partial class Actividades_OT :  PaginaBase, IPaginaBase
    {
        // variables globales 
        string  sUser = "";
        GeneralSoapClient oGEN = new GeneralSoapClient();  // REFERENCIA AL SERVICIO
        ProduccionSoapClient oPROD = new ProduccionSoapClient();
        string s_Ambiente = EasyUtilitario.Helper.Configuracion.Leer("Seguridad", "Ambiente");
        string username = HttpContext.Current.User.Identity.Name;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.LlenarJScript();


                if (this.UsuarioLogin != null && string.IsNullOrWhiteSpace(sUser))
                {
                    sUser = this.UsuarioLogin;
                }
                if (sUser != null && Session["sUser"] == null)
                {
                    Session["sUser"] = sUser;
                }

                Session["Filtro"] = "";
                prCargaCombos();

                //  prIgualarNivelAprob();
                //  this.LlenarGrilla(EasyGestorFiltro1.getFilterString()); // funcion para filtro de la grilla
            }
            else
            {
                if (this.UsuarioLogin != null && string.IsNullOrWhiteSpace(sUser))
                {
                    sUser = this.UsuarioLogin;
                }
            }

        }


        #region procedimientos_referenciados
        public void LlenarJScript()
        {
           //   this.btnCarga.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "Espera();";
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

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

        #endregion

        #region Procedimientos
        public void prLlenarActividad()
        {
            string sCodLinea , NroOT;
            try
            {
                sCodLinea = EDDL_LineaNegocio.SelectedValue;//  efActividades2.GetValue("enbOTs").ToString(); 
                //NroOT = efActividades2.GetValue("enbOTs").ToString().Replace(".", "");
                NroOT = enbOTs.Text.ToString().Replace(".", "");

                // validacion para buscar actividades
                if (string.IsNullOrWhiteSpace(NroOT)) 
                { 

                }


                if ( !string.IsNullOrWhiteSpace(sCodLinea) && !string.IsNullOrWhiteSpace(NroOT))
                {

                  //  if (EDDL_Actividad.Items.Count == 0) // se quizo validar para no repetir la recarga pero puede cambiar de OT y seria nueva recarga
                  //  { 
                        DataTable dt = oPROD.Listar2_actividad_ot("1", sCodLinea, NroOT, sUser );
                        if (dt != null)
                      {
                          if (dt.Rows.Count > 0)
                          {

                              EDDL_Actividad.DataSource = dt;  // llenamos con el datatable
                                                               //      efActividades2.SetDataRow("EDDL_Actividad", ConvertDataTableToDictionary(dt)); // convertimos el datatable en un diccionario

                             EDDL_Actividad.DataTextField = "NOMBRE"; // NOM_AUS
                             EDDL_Actividad.DataValueField = "CODIGO";
                             EDDL_Actividad.DataBind();
                            
                            ListItem litem = new ListItem("[Seleccionar...]", "-1");
                            EDDL_Actividad.Items.Insert(0, litem);


                            lblmensaje.Text = "";
                          }
                          else
                          { 
                            lblmensaje.Text = "Sin registros";
                            lblDescripción.Text = "";
                            EDDL_Actividad.Items.Clear();  
                          }
                      }
                        else
                         { lblmensaje.Text = "Sin registros";
                          lblDescripción.Text = "";
                          EDDL_Actividad.Items.Clear();
                    }
                   // }
               
                }


            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                lblmensaje.Text = NombreMetodo + " " + ex.Message;
            }
        }

        protected void prCargaCombos()
        {
            try
            {

                DataTable dt = oGEN.ListaLineas(sUser/*, s_Ambiente*/);
                if (dt != null)
                {

                    EDDL_LineaNegocio.DataSource = dt;  // nombre_de_la_tabla  ["planilla"]
                    EDDL_LineaNegocio.DataTextField = "NOMBRE"; // NOM_AUS
                    EDDL_LineaNegocio.DataValueField = "CODIGO";
                    EDDL_LineaNegocio.DataBind();
                    
                }
                else
                {
                    lblmensaje.Text = "Sin registros";

                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("fallo:", "prCargaCombos " + ex.Message);
                this.lblmensaje.Text = "prCargaCombos() " + ex.Message + " ListarLineasNegocio";
            }
        }

        public static Dictionary<string, string> ConvertDataTableToDictionary(DataTable dataTable)
        {
            Dictionary<string, string> dictionary = new Dictionary<string, string>();

            foreach (DataRow row in dataTable.Rows)
            {
                string key = row[0].ToString();
                string value = row[1].ToString();

                dictionary[key] = value;
            }

            return dictionary;
        }
        #endregion

        #region Eventos

    
            // cambio en la seleccion de registro de la linea de negocio
            protected void EDDL_LineaNegocio_SelectedIndexChanged(object sender, EventArgs e)
                {
                
                        try
                        {
                        prLlenarActividad();
                        }
                        catch (Exception ex)
                        {
                            StackTrace stack = new StackTrace();
                            string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                            lblmensaje.Text = NombreMetodo + " " + ex.Message;
                        }
                }
          
        // buscar registro
            protected void btnCarga_Click(object sender, ImageClickEventArgs e)
            {
                    string sCodLinea;
                    try
                    {
                        prLlenarActividad();

                    }
                    catch (Exception ex)
                    {
                        StackTrace stack = new StackTrace();
                        string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                        //  this.LanzarException(NombreMetodo, ex);
                        lblmensaje.Text = NombreMetodo + " " + ex.Message;
                    }

            }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            string msg="" , sCodATV = "";
            string rpta;
            int iNroCrv = 0;
            MsgBox msgBox = new MsgBox();

            try {
                int control = 0;
                if (string.IsNullOrWhiteSpace(enbOTs.Text))
                {
                    msg = "Se Requiere el Nro de OT";
                    control = 1; // control con error
                    SetFocus(enbOTs);
                }

                if (string.IsNullOrWhiteSpace(this.EDDL_LineaNegocio.SelectedValue))
                {
                    msg = "Seleccione Línea de Negocio";
                    control = 2; // control con error
                    SetFocus(EDDL_LineaNegocio);
                }

                if (string.IsNullOrWhiteSpace(EDDL_Actividad.SelectedValue))
                {
                    msg = "Seleccione Actividad";
                    control = 3; // control con error
                    SetFocus(EDDL_Actividad);
                }
                else
                {
                    if (EDDL_Actividad.SelectedValue != "-1")
                    {
                        // extraemos del texto contatenado
                        sCodATV = EDDL_Actividad.SelectedValue.Substring(0, EDDL_Actividad.SelectedValue.IndexOf("-"));
                        iNroCrv = int.Parse(EDDL_Actividad.SelectedValue.Substring(EDDL_Actividad.SelectedValue.IndexOf("-") + 1));
                    }
                    else {
                        msg = "Seleccione Actividad";
                        control = 3; // control con error
                        SetFocus(EDDL_Actividad);
                    }
                    
                }

                if (string.IsNullOrWhiteSpace(EAC_usuarios.GetValue()))
                {
                    msg = "Ingrese código de usuario que solicita el cambio";
                    control = 4; // control con error
                    SetFocus(EAC_usuarios);
                }

                if (string.IsNullOrWhiteSpace(ETdescripcion.Text))
                {
                    msg = "Se Requiere el texto a Actualizar";
                    control = 5; // control con error
                    SetFocus(ETdescripcion);
                }

                if (control>0)
                { 
            
                        msgBox.ID = "Msg";
                        msgBox.Titulo = "Validación";
                    
                        msgBox.Contenido = msg;
                        msgBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                        msgBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.bootstrap; // modern (borde celete / cara feliz), supervan (borde amarillo), material (borde amarillo / icono pregunta), bootstrap

                    lblmensaje.Text = msg;
                    pnlMessage.Controls.Add(msgBox);
                          SetFocus(enbOTs);

                      return;
                }

                if (string.IsNullOrWhiteSpace(sUser) )
                {
                    sUser = Session["sUser"].ToString() ;
                }

                // TRANSACCIÓN

                 ProduccionSoapClient oPD = new ProduccionSoapClient();
                
                rpta = oPD.Modifica_Actividad_Desc(int.Parse(enbOTs.Text) , EDDL_LineaNegocio.SelectedValue.ToString().Trim() , sCodATV,
                    iNroCrv, EAC_usuarios.GetValue().ToString() ,
                    "", ETdescripcion.Text.ToUpper() , sUser);

                if (int.Parse(rpta) >= 0)
                {
                    lblmensaje.Text = "";

                    // actualizamos nuevamente
                    prLlenarActividad();

                    msgBox.ID = "Msg";
                    msgBox.Titulo = "Mensaje";

                    msgBox.Contenido = "Registro actualizado satisfactoriamente...";
                    msgBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                    msgBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern; // modern (borde celete / cara feliz), supervan (borde amarillo), material (borde amarillo / icono pregunta), bootstrap

                    ETdescripcion.Text = ""; // limpiar para realizar siguiente actualizacion y evitar confusión
                    pnlMessage.Controls.Add(msgBox);
                }
                else
                {
                    lblmensaje.Text = "No se realizo la transacción...";
                }
                
            }

            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                //  this.LanzarException(NombreMetodo, ex);
                lblmensaje.Text = NombreMetodo + " " + ex.Message;
            }
        }



        #endregion

        protected void EDDL_Actividades_Select(object sender, EventArgs e)
        {
            lblDescripción.Text  = EDDL_Actividad.SelectedItem.Text.Replace("\n", "<br />").Replace("\r\n", "<br />"); // copia con saltos de lineas la descripcion de la actividad para facilitar el cambio
        }
    }

    internal class MsgBox : EasyMessageBox
    {
    }
}