using EasyControlWeb;
using SIMANET_W22R.srvSeguridad;
using SIMANET_W22R.srvGestionSeguridadPlanta;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Runtime.CompilerServices;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class AdministrarProgVisitaDetalle : PaginaBase  // para usar funcionalidad PathFotosPersonal debe heredarse de PaginaBase
    {


        // PROPIEDADES - PARAMETROS RECIBIDOS DESDE REQUEST
        // =====================================================

        protected string ReqIdArea  => Request.Params[AdministrarProgVisita.KEYQIDAREA];
        protected string ReqArea => Request.Params[AdministrarProgVisita.KEYQAREA];
        protected string ReqIdCentroOperativo => Request.Params[AdministrarProgVisita.KEYQCENTROOPERATIVO];
        protected string ReqPeriodo => Request.Params[AdministrarProgVisita.KEYQPERIODO];
        //protected string ReqTipoPrograma => Request.Params[AdministrarProgVisita.KEYQTIPOPROGRAMA];
        //protected string ReqTipoVisita => Request.Params[AdministrarProgVisita.KEYQTIPOVISITA];
        //protected string ReqUsuario => Request.Params[AdministrarProgVisita.KEYQUSUARIO];

        protected static string ReqTipoPrograma => HttpContext.Current?.Request.Params[AdministrarProgVisita.KEYQTIPOPROGRAMA];
        protected static string ReqTipoVisita => HttpContext.Current?.Request.Params[AdministrarProgVisita.KEYQTIPOVISITA];
        protected static string ReqUsuario => HttpContext.Current?.Request.Params[AdministrarProgVisita.KEYQUSUARIO];


        protected void Page_Load(object sender, EventArgs e)
        {
            DatosIniciales();
             
        }

        protected void DatosIniciales() {
          try
          {

            eDDLTipoVisita.LoadData(); 
            eDDLTipoVisita.SetValue(ReqTipoVisita);
            acAreaTrab.GetData();
          //  acAreaTrab.SetValue("OFICINA TECNOLOGIAS INFORMACION Y COMUNICACIONES", "2123");
                acAreaTrab.SetValue("2123","OFICINA TECNOLOGIAS INFORMACION Y COMUNICACIONES" );
            
            hfUsuario.Value = ReqUsuario;
            hfTipoProgra.Value = ReqTipoPrograma;

                /*
                 * para que funciones PathFotosPersonal debe heredarse de PaginaBase
                string Foto = this.PathFotosPersonal + drSol["NRODOCDNI"].ToString() + ".jpg";
                HtmlImage oImg = EasyUtilitario.Helper.HtmlControlsDesign.CrearImagen(Foto, "ms-n2 rounded-circle img-fluid");
                
                */
                dpcFechaIni.Text = DateTime.Now.ToString("dd/MM/yyyy");
                dpcFechaFin.Text = DateTime.Now.ToString("dd/MM/yyyy");
                dtHora.Value = DateTime.Now.ToString("HH:mm");
            }
            catch (Exception ex)
            {
                var result = "" + ex.Message;  // datos del mensaje, le quitamos los apostrofes ya que se empleará en sweet alert
                result = result.Replace("'", "");
                string pageName = System.IO.Path.GetFileNameWithoutExtension(Request.Path);
                string methodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                Console.WriteLine(pageName + ' ' + methodName + ' ' + result); // error para verlo en el inspector de página
                string scriptSuccess = $"Swal.fire('Error', 'Página: {pageName} -  {methodName}: {result}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", scriptSuccess, true);

            }

        }

        
        [WebMethod]
        public static ResultadoBE GuardarProgramacion(DetalleProgramacionCabeceraDTO data)
        {
            // Aquí ya tienes tipos fuertes
            int iIdEntidad =0 , iIdCiaSeguros= 99 , iIdUsuarioAprobador=0;
            string sRpta = "";
            try
            {

                // ============================
                // VALIDACIONES OBLIGATORIAS
                // ============================
                #region Validaciones

                
                if (data.Tipovisita <= 0)
                    return new ResultadoBE { Ok = false, Mensaje = "Debe seleccionar el Tipo de Visita." };

                if (data.AreaDestino <= 0)
                    return new ResultadoBE { Ok = false, Mensaje = "Debe seleccionar el Área Destino." };

                if (data.ConocimientoA =="")
                    return new ResultadoBE { Ok = false, Mensaje = "Debe seleccionar el Personal de Conocimiento." };

                if (string.IsNullOrWhiteSpace(data.FechaInicio))
                    return new ResultadoBE { Ok = false, Mensaje = "Debe seleccionar la Fecha de Inicio." };

                if (string.IsNullOrWhiteSpace(data.HoraIngreso))
                    return new ResultadoBE { Ok = false, Mensaje = "Debe seleccionar la Hora de Ingreso." };

                if (data.Asunto == "")
                    return new ResultadoBE { Ok = false, Mensaje = "Debe Ingresar el Asunto de la visita." };
                #endregion

                // ============================
                // CONVERSIONES SEGURAS
                // ============================
                #region Conversiones
                if (!DateTime.TryParse(data.FechaInicio, out DateTime fechaInicio))
                    return new ResultadoBE { Ok = false, Mensaje = "Formato inválido de Fecha de Inicio." };

                DateTime? fechaTermino = null;
                if (!string.IsNullOrWhiteSpace(data.FechaTermino))
                {
                    if (!DateTime.TryParse(data.FechaTermino, out DateTime ft))
                        return new ResultadoBE { Ok = false, Mensaje = "Formato inválido de Fecha de Término." };
                    fechaTermino = ft;
                }

                if (!TimeSpan.TryParse(data.HoraIngreso, out TimeSpan horaIngreso))
                    return new ResultadoBE { Ok = false, Mensaje = "Formato inválido de Hora de Ingreso." };

                #endregion 

                var be = new DetalleProgramacionCabeceraBE
                {
                    // obligatorios
                    Tipovisita = data.Tipovisita,
                    TipoProgra = data.TipoProgra,  
                    AreaDestino = data.AreaDestino,
                    ConocimientoA = data.ConocimientoA,
                    FechaInicio = DateTime.Parse(data.FechaInicio),
                    HoraIngreso = TimeSpan.Parse(data.HoraIngreso),
                    // opcionales
                    FechaTermino = DateTime.Parse(data.FechaTermino),
                    IdUsuario = data.IdUsuario,   
                    Poliza = data.Poliza,
                    Asunto = data.Asunto,
                   
                    FechaRegistro = DateTime.Now
                };

                switch (data.TipoProgra.ToString())
                {
                    case "1":

                        switch (ReqTipoVisita)
                        {
                            case "5":
                               // "PROGRAMACIÓN VISITAS GENERALES";
                                break;

                            case "2":
                                // Ajusta el texto si tu negocio lo llama distinto
                                // "PROGRAMACIÓN VISITAS CONTRATISTAS";
                                break;

                            default:
                                // fallback si llega otro valor o vacío
                                // "PROGRAMACIÓN VISITAS (PERSONAL)";
                                iIdEntidad = 0;
                                iIdCiaSeguros = 99;
                                iIdUsuarioAprobador = 0;
                                break;
                        }

                        break;
                    case "4":
                        //"PROGRAMACIÓN VISITAS PROVEEDORES - ADMINISTRATIVOS";
                        break;
                    case "5":
                        // "PROGRAMACIÓN VISITAS CLIENTES";
                        break;
                    case "7":
                        // "PROGRAMACIÓN VISITAS PROVEEDORES - TÉCNICOS";
                        break;
                    case "8":
                        // "PROGRAMACIÓN VISITAS ARMADORES";
                        break;
                }


                // llamada al servicio
                VisitasSoapClient oVisitas = new VisitasSoapClient();
                sRpta = oVisitas.ProgramacionVisita_Ins(be.Tipovisita.ToString() , iIdEntidad.ToString(), be.AreaDestino.ToString(), be.FechaInicio.ToString(), be.FechaTermino.ToString(),
                                                       be.HoraIngreso.ToString(), null, iIdCiaSeguros.ToString(), be.Poliza , be.Asunto,
                                                       be.IdUsuario.ToString(), be.TipoProgra.ToString(), iIdUsuarioAprobador.ToString(), "1", be.IdUsuario.ToString());    //Servicio.Guardar(be);

                
                return new ResultadoBE
                {
                    Ok = true,
                    Mensaje = "Guardado correcto",
                    IdGenerado = sRpta //rpta
                };
            }
            catch (Exception ex)
            {
                return new ResultadoBE
                {
                    Ok = false,
                    Mensaje = ex.Message
                };
            }
        }



    }

}