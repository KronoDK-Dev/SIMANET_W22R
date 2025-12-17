using EasyControlWeb;
using Microsoft.ReportingServices.ReportProcessing.ReportObjectModel;
using Org.BouncyCastle.Asn1.Cmp;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionProduccion;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SIMANET_W22R.GestionProduccion.OT
{
    public partial class Descripcion_OT : PaginaBase, IPaginaBase
    {
        // variables globales 
        string sUser = "";
        GeneralSoapClient oGEN = new GeneralSoapClient();  // REFERENCIA AL SERVICIO
        ProduccionSoapClient oPROD = new ProduccionSoapClient();
        string s_Ambiente = EasyUtilitario.Helper.Configuracion.Leer("Seguridad", "Ambiente");
        DataTable dt;
        string msg = "", sCodATV = "";
        string rpta;
        string sLinea;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.LlenarJScript();
                prCargaCombos();

                if (this.UsuarioLogin != null && string.IsNullOrWhiteSpace(sUser))
                {
                    sUser = this.UsuarioLogin;
                }
                if (sUser != null && Session["sUser"] == null)
                {
                    Session["sUser"] = sUser;
                }

                Session["Filtro"] = "";

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


        void IPaginaBase.CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        void IPaginaBase.CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        void IPaginaBase.ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        void IPaginaBase.Exportar()
        {
            throw new NotImplementedException();
        }

        void IPaginaBase.Imprimir()
        {
            throw new NotImplementedException();
        }

        void IPaginaBase.LlenarCombos()
        {
            throw new NotImplementedException();
        }

        void IPaginaBase.LlenarDatos()
        {
            throw new NotImplementedException();
        }

        void IPaginaBase.LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        void IPaginaBase.LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }


        void IPaginaBase.RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        bool IPaginaBase.ValidarDatos()
        {
            throw new NotImplementedException();
        }

        bool IPaginaBase.ValidarFiltros()
        {
            throw new NotImplementedException();
        }

        #endregion

        #region Eventos
        protected void btnActualizar_Click(object sender, EventArgs e)
        {

            MsgBox msgBox = new MsgBox();
            try
            {
                int control = 0;
                sLinea = this.EDDL_LineaNegocio.SelectedValue.ToString().Trim() ;
                if (string.IsNullOrWhiteSpace(enbOTs.Text))
                {
                    msg = "Se Requiere el Nro de OT";
                    control = 1; // control con error
                    SetFocus(enbOTs);
                }

                if (string.IsNullOrWhiteSpace(sLinea))
                {
                    msg = "Seleccione Línea de Negocio";
                    control = 2; // control con error
                    SetFocus(EDDL_LineaNegocio);
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

                if (control > 0)
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

                if (string.IsNullOrWhiteSpace(sUser))
                {
                    sUser = Session["sUser"].ToString();
                }

                // TRANSACCIÓN

                ProduccionSoapClient oPD = new ProduccionSoapClient();

                rpta = oPD.Modifica_OT_Desc(int.Parse(enbOTs.Text), sLinea,
                       ETdescripcion.Text.ToUpper(), EAC_usuarios.GetValue().ToString(), sUser);

                if (int.Parse(rpta) >= 0)
                {

                    lblmensaje.Text = "";

                    // actualizamos nuevamente
                    DescripcionOT();

                    msgBox.ID = "Msg";
                    msgBox.Titulo = "Mensaje";

                    msgBox.Contenido = "Registro actualizado satisfactoriamente...";
                    msgBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                    msgBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern; // modern (borde celete / cara feliz), supervan (borde amarillo), material (borde amarillo / icono pregunta), bootstrap


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
                lblmensaje.Text =  ex.Message + "<br/>"+ NombreMetodo ;
            }
        }

        protected void btnCarga_Click(object sender, ImageClickEventArgs e)
        {
            // buscar registro
                try
                {
                    DescripcionOT();

                }
                catch (Exception ex)
                {
                    StackTrace stack = new StackTrace();
                    string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                    lblmensaje.Text =  ex.Message + "<br/>"+ NombreMetodo ;
                }

        }

        // cambio en la seleccion de registro de la linea de negocio
        protected void EDDL_LineaNegocio_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                 DescripcionOT();
            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                lblmensaje.Text =   ex.Message + "<br/>" + NombreMetodo;
            }
        }



        #endregion

        #region Procedimientos
        public void DescripcionOT()
        {
            int control = 0;
            string s_Ambiente = EasyUtilitario.Helper.Configuracion.Leer("Seguridad", "Ambiente");
        
            MsgBox msgBox = new MsgBox();
            try
            {

                control = -1;
                sLinea = this.EDDL_LineaNegocio.SelectedValue.ToString ();

                if (this.enbOTs.Text.Trim() == null)   // string.IsNullOrWhiteSpace
                {
                    msg = "Se Requiere el Nro de OT";
                    control = 1; // control con error
                    SetFocus(enbOTs);
                }

                if (string.IsNullOrWhiteSpace(sLinea))
                {
                    msg = "Seleccione Línea de Negocio";
                    control = 2; // control con error
                    SetFocus(EDDL_LineaNegocio);
                }
                //--------------mensaje------------------
                if (control > 0)
                {
                    control = -2;
                    msgBox.ID = "Msg";
                    msgBox.Titulo = "Validación";

                    msgBox.Contenido = msg;
                    msgBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                    msgBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.bootstrap; // modern (borde celete / cara feliz), supervan (borde amarillo), material (borde amarillo / icono pregunta), bootstrap
                    lblDescripción.Text = msg;

                    pnlMessage.Controls.Add(msgBox);
                    SetFocus(enbOTs);

                    return;
                }
                //--------------------------------
                control = -3;
                if (string.IsNullOrWhiteSpace(sUser))
                {
                    sUser = Session["sUser"].ToString();
                }
              
                control = -4;
                dt = oPROD.Listar2_actividad_ot("1", sLinea, this.enbOTs.Text, sUser);
                control = -5;
                //   dt.TableName = "SP_Actividad_OT";
                int rowIndex = 0; //   fila (índice base 0)
                //int columnIndex = 46; // Segunda columna (des ot)
                control = -6;
                if (dt != null)
                {
                    control = -7;
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Rows[rowIndex]["DES_OT"] != null)
                        {
                            lblDescripción.Text = (string)dt.Rows[rowIndex]["DES_OT"];
                            lblmensaje.Text = "";
                        }
                    }
                    else
                    {
                        lblmensaje.Text = "No se encontró la OT. " + s_Ambiente + " "  + sUser + " " + sLinea + this.enbOTs.Text;
                        lblDescripción.Text = "";
                    }



                }
                else
                {
                    lblmensaje.Text = "No se encontró la OT" + s_Ambiente + " " + sUser + " " + sLinea + this.enbOTs.Text;
                    lblDescripción.Text = "";
                }
            }

            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                lblmensaje.Text =  ex.Message + " " + control + " " + ex.Data + "<br>" + NombreMetodo ;
            }


        }

        protected void prCargaCombos()
        {
            try
            {

                DataTable dt = oGEN.ListaLineas(sUser);
                if ((dt != null) && (EDDL_LineaNegocio.Items.Count == 0))
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
        #endregion 

    }
}