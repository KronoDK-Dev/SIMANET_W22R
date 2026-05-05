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
            hfAnio.Value = string.IsNullOrEmpty(ReqPeriodo) ? this.Año : ReqPeriodo; ;
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
            int iIdEntidad = 0 , iIdCiaSeguros= 99 , iIdUsuarioAprobador=0;
            string sRpta = "", sListaCorreos;
            try
            {

                // ============================
                // VALIDACIONES OBLIGATORIAS
                // ============================
                #region Validaciones

                
                if (data.Tipovisita <= 0)
                    return new ResultadoBE { Ok = false, Mensaje = "Debe seleccionar el Tipo de Visita." };

                if (data.Tipovisita.ToString() !="5" && string.IsNullOrWhiteSpace(data.Poliza))
                    return new ResultadoBE { Ok = false, Mensaje = "Debe seleccionar ingresar una Compañia de Seguro" };

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


                sListaCorreos = data.ConocimientoA.ToString().Replace("|", "*");

                var ProgramaBE = new ProgramacionBE
                {


                    // OBLIGATORIOS
                    ID_TIPO_VISITA = data.Tipovisita,
                    TIPO_PROGRAMACION = data.TipoProgra,
                    ID_LUGAR_TRABAJO = data.AreaDestino,
                    TRABAJOS_A_REALIZAR = data.ConocimientoA,

                    FECHA_INICIO = DateTime.Parse(data.FechaInicio),
                    HORA_INICIO = data.HoraIngreso,   // viene como string HHmm o HH:mm
                    HORA_TERMINO = "18:00", // valor por defecto
                    // OPCIONALES
                    FECHA_TERMINO = DateTime.Parse(data.FechaTermino),
                    ID_USUARIO_REGISTRO = data.IdUsuario,
                    UserName = data.IdUsuario.ToString(),
                    NRO_POLIZA = data.Poliza,
                    OBSERVACIONES = data.Asunto,
                    PERIODO = data.Anio,
                    FECHA_REGISTRO = DateTime.Now

                };
                
                // datos por defecto
                ProgramaBE.ID_ENTIDAD = 0; // visita no empresa
                ProgramaBE.ID_USUARIO_APROBACION = 0; // en el primer registro es valor 0
                ProgramaBE.ID_ESTADO = 1; // COLOCAMOS DIRECTO EL VALOR DE 1 PARA PODER VISUALIZAR EN LA GRILLA, PERO ESTE VALOR DEBE COLOCARSE AL FINAL LA CARGA DEL DETALLE.
                switch (data.TipoProgra.ToString())
                {
                    case "1":

                        switch (data.Tipovisita.ToString())
                        {
                            case "5":
                                // "PROGRAMACIÓN VISITAS GENERALES";
                                // "PROGRAMACIÓN VISITAS (PERSONAL)";

                                ProgramaBE.ID_CIA_SEGUROS = 99;
                                ProgramaBE.NRO_POLIZA = "S/N";
                                iIdUsuarioAprobador = 0;
                                break;

                            case "2":
                                // Ajusta el texto si tu negocio lo llama distinto
                                // "PROGRAMACIÓN VISITAS CONTRATISTAS";
                                break;

                            default:
                                // fallback si llega otro valor o vacío
                                // "PROGRAMACIÓN VISITAS (PERSONAL)";
                                iIdEntidad = 0;
                                ProgramaBE.ID_CIA_SEGUROS = 99;
                                ProgramaBE.NRO_POLIZA = "S/N";
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


                // llamada al servicio, debe pasar una entidad y cadena de listados de personal a enviar correo , asi como listado de anexos
                VisitasSoapClient oVisitas = new VisitasSoapClient();
                sRpta = oVisitas.ProgramacionVisitas_Ins(ProgramaBE, sListaCorreos ,"");    //Servicio.Guardar(be); el separado de correos del control es | pero el metodo espera *

                
                return new ResultadoBE
                {
                    Ok = true,
                    Mensaje = "Programación "+ sRpta+ " generada correctamente...",
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