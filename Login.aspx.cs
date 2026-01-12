using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIMANET_W22R.PublicClass;

namespace SIMANET_W22R
{
    public partial class Login : System.Web.UI.Page
    {
        EasyNavigatorHistorial oEasyNavigatorHistorial;
        EasyMessageBox oeasyMessageBox = new EasyMessageBox();

        protected void Page_Load(object sender, EventArgs e)
        {
            sglGlobalData oGD = sglGlobalData.GetInstance();
            oGD.Disponse();

            EasyLoginCard1.AutenticacionWindows = Convert.ToBoolean(EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.Seguridad, EasyUtilitario.Enumerados.Configuracion.SeccionKey.valor.AutenticacionAD));
        }

        protected void EasyLoginCard1_Validacion(EasyUsuario oEasyUsuario, EasyLoginCard.LoginAccion Accion)
        {
            SeguridadSoapClient oSeguridad = new SeguridadSoapClient();
            if (Accion == EasyLoginCard.LoginAccion.Validacion)
            {
                try
                {
                    oEasyUsuario.IdUsuario = oSeguridad.ValidateUser(oEasyUsuario.Login, oEasyUsuario.Login);
                }
                catch (Exception ex)
                {
                    oeasyMessageBox = new EasyMessageBox();
                    oeasyMessageBox.ID = "msgb";
                    oeasyMessageBox.Titulo = "COMUNICACION";
                    oeasyMessageBox.Contenido = ex.Message;
                    oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                    oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.supervan;
                    Page.Controls.Add(oeasyMessageBox);
                    return;
                }

                if (oEasyUsuario.IdUsuario > 0)
                {
                    //Verifica la caduccidad
                    bool Caducado = oSeguridad.VerificaCaducidadUser(oEasyUsuario.IdUsuario);
                    if (Caducado)
                    {
                        oeasyMessageBox = new EasyMessageBox();
                        oeasyMessageBox.ID = "msgb";
                        oeasyMessageBox.Titulo = "Seguridad Integrada(Caducidad)";
                        oeasyMessageBox.Contenido = "ha expirado el tiempo autorizado para el usos de este aplicativo!!, por favor comuniquese con el area de OTIC, para la renovación de los permisos respectivos";
                        oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                        oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                        Page.Controls.Add(oeasyMessageBox);

                    }
                    else
                    {
                        UsuarioBE oUsuarioBE = oSeguridad.GetDatosUsuario(oEasyUsuario.IdUsuario);
                        Session["UserBE"] = oUsuarioBE;
                        Session["IdUsuario"] = oEasyUsuario.IdUsuario;
                        Session["IdCentro"] = oUsuarioBE.IdCentroOperativo;
                        //Aqui realizar la validacion en la base de datos y obtener los siguientes datos
                        oEasyUsuario.NroDocumento = oUsuarioBE.NroDocumento;
                        string IdSys = EasyUtilitario.Helper.Configuracion.Leer("Seguridad", "IdSistema");
                        DataTable dtOpcion = oSeguridad.GetOptionsByProfile(Convert.ToInt32(IdSys), oEasyUsuario.IdUsuario, "VACIO");
                        oEasyUsuario.SaveOpcions(dtOpcion);


                        EasyUtilitario.Helper.Sessiones.Usuario.set(oEasyUsuario);
                        oEasyNavigatorHistorial = new EasyNavigatorHistorial();
                        EasyNavigatorBE oEasyNavigatorBE = new EasyNavigatorBE();
                        oEasyNavigatorBE.Texto = "DEFAULT";
                        oEasyNavigatorBE.Descripcion = "Pagina por defecto";
                        oEasyNavigatorBE.Pagina = "/Default.aspx";


                        // CAMBIO DE PAGINA DE INICIO
                        if (oUsuarioBE != null)
                        {
                            if (oUsuarioBE.IdEstado == 1 && oUsuarioBE.Observacion.ToString() != null)
                             {oEasyNavigatorBE.Pagina = oUsuarioBE.Observacion.ToString(); }
                            else
                             {oEasyNavigatorBE.Pagina = "/Default.aspx"; }

                        }
                        else
                        {
                            if (oEasyUsuario.Login == "EDD_GGH")
                            {oEasyNavigatorBE.Pagina = "/GestionPersonal/EvaluacionDesempenio/Evaluacion.aspx";}
                            else
                            {oEasyNavigatorBE.Pagina = "/Default.aspx"; }

                        }
                        // -----------
                         oEasyNavigatorHistorial.IrA(oEasyNavigatorBE);

                    }
                }
                else
                {
                    //Verificar su caducidad.
                    oeasyMessageBox = new EasyMessageBox();
                    oeasyMessageBox.ID = "msgb2";
                    oeasyMessageBox.Titulo = "Seguridad Integrada(Caducidad)";
                    oeasyMessageBox.Contenido = "Nombre de usuario [" + oEasyUsuario.Login + "]!! incorrecto o no existe, por favor comuniquese con el area de OTIC (" + EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.Seguridad, "NonAreaRepon") + "), para la renovación o creación de los permisos respectivos";
                    oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                    oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                    Page.Controls.Add(oeasyMessageBox);

                }
            }
        }
    }
}