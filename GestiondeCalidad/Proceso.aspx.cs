using EasyControlWeb;
using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvProyectos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIMANET_W22R.GestionReportes;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class Proceso1 : PaginaCalidadBase
    {
        const int KEYPRC_LST_INSPECTOR = 1;
        const int KEYPRC_LST_AREAREPONSABLE = 2;
        const int KEYPRC_ADM_PERSONALFIRMANTE = 3;
        const int KEYPRC_FND_PROYECTO = 4;
        const int KEYPRC_INSACT_INSPECCION_CAMBIA_EST = 5;
        const int KEYPRC_INSMOD_INSPECCTOR = 6;
        const int KEYPRC_FIND_PROY_NOM = 7;
        /*cONSTANTES PARA REPORTE DE INDICADORES*/
        const int KEYPRC_RPT_NO_CONFORMIDAD = 8;
        const int KEYPRC_RPT_NO_CONFORMIDAD_PROY = 9;
        const int KEYPRC_RPT_NO_CONFORMIDAD_IP_SIMA = 10;
        const int KEYPRC_RPT_NO_CONFORMIDAD_TIPO_INSPEC = 11;

        const int KEYPRC_ADM_ACTIVIDAD = 12;
        const int KEYPRC_FIND_PROY_CLIENTE = 13;

        const int KEYPRC_FIND_TALLER_CONTRAT = 14;

        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> InfoRptBE;
            DataSet ds;
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            try
            {
                switch (this.IdProceso)
                {
                    case KEYPRC_LST_INSPECTOR:
                        this.DataTableToXML((new ControlInspeccionesSoapClient()).Inspeccion_ListarInspectores(this.IdInspeccion, this.UsuarioLogin));
                        break;
                    case KEYPRC_LST_AREAREPONSABLE:
                        this.DataTableToXML((new ControlInspeccionesSoapClient()).ListarResponsablesPorArea(this.IdInspeccion, this.UsuarioLogin));
                        break;
                    /* case KEYPRC_ADM_PERSONALFIRMANTE:

                         UsuarioFirmanteBE oUsuarioFirmanteBE = new UsuarioFirmanteBE();
                         oUsuarioFirmanteBE.IdInspeccion = this.IdInspeccion;
                         oUsuarioFirmanteBE.IdPersonaFirmante = this.IdPersonaFirmante;
                         oUsuarioFirmanteBE.IdTipoFirmante = this.IdTipoFirmante;
                         oUsuarioFirmanteBE.Descripcion = this.Descripcion;
                         oUsuarioFirmanteBE.Firma = this.ImagenFirma;
                         oUsuarioFirmanteBE.IdUsuario = this.UsuarioId;
                         oUsuarioFirmanteBE.UserName = this.UsuarioLogin;
                         oUsuarioFirmanteBE.IdEstado = this.IdEstado;

                         oCalidad.ModificaInsertaUsuariosFirmantes(oUsuarioFirmanteBE);
                         break;*/
                    case KEYPRC_FND_PROYECTO:
                        oCalidad = new ControlInspeccionesSoapClient();
                        this.DataTableToXML((new ControlInspeccionesSoapClient()).BuscarProyectodeInspeccion(this.NombreProyecto, this.UsuarioLogin));
                        break;
                    case KEYPRC_INSACT_INSPECCION_CAMBIA_EST:
                        (new ControlInspeccionesSoapClient()).InspeccionCambiarEstado(this.IdInspeccion, this.IdEstado, this.UsuarioId, this.UsuarioLogin);
                        break;
                    case KEYPRC_INSMOD_INSPECCTOR:

                        InspectorBE oInspectorBE = new InspectorBE();
                        oInspectorBE.IdInspector = this.IdInspector;
                        oInspectorBE.IdInspeccion = this.IdInspeccion;
                        oInspectorBE.IdPersonal = this.IdPersonal;
                        oInspectorBE.Principal = this.InspectorPrincipal;
                        oInspectorBE.IdUsuario = this.UsuarioId;
                        oInspectorBE.UserName = this.UsuarioLogin;
                        oInspectorBE.IdEstado = this.IdEstado;

                        (new ControlInspeccionesSoapClient()).Inspeccion_ModificarInsertarInspector(oInspectorBE);

                        break;
                    case KEYPRC_FIND_PROY_NOM:
                        DataTable dtProy = (new ProyectosSoapClient()).ListarProyectosSIMA("0", this.UsuarioLogin);
                        DataView dv = dtProy.DefaultView;
                        string Criterios = "NombreProyecto like '%" + this.NombreProyecto + "%'";
                        dv.RowFilter = Criterios;
                        if (dv.Count > 0)
                        {
                            this.DataTableToXML(EasyUtilitario.Helper.Data.ViewToDataTable(dv));

                        }
                        break;
                    case KEYPRC_FIND_PROY_CLIENTE:
                        this.DataTableToXML((new GeneralSoapClient()).BuscarCliente(this.RazonSocialCliente, this.UsuarioLogin));
                        break;
                    case KEYPRC_RPT_NO_CONFORMIDAD:
                        ds = (new Proceso()).DataReporteNoConforme(Convert.ToInt32(this.Año), Convert.ToInt32(this.IdMes), this.UsuarioLogin);
                        InfoRptBE = (new GenerarPdf()).CrearArchivo(13, this.UsuarioLogin, ds);
                        this.DiccionaryToEntityJS(EasyUtilitario.Helper.Data.SeriaizedDiccionario(InfoRptBE));
                        break;
                    case KEYPRC_RPT_NO_CONFORMIDAD_PROY:
                        ds = (new Proceso()).DataReportResumenNoConformePorProyecto_Mensual(Convert.ToInt32(this.Año), Convert.ToInt32(this.IdMes), this.UsuarioLogin);
                        InfoRptBE = (new GenerarPdf()).CrearArchivo(19, this.UsuarioLogin, ds);
                        this.DiccionaryToEntityJS(EasyUtilitario.Helper.Data.SeriaizedDiccionario(InfoRptBE));
                        break;
                    case KEYPRC_RPT_NO_CONFORMIDAD_IP_SIMA:
                        ds = (new Proceso()).DataReportResumenNoConformePorIP_SIMA_Mensual(Convert.ToInt32(this.Año), Convert.ToInt32(this.IdMes), this.UsuarioLogin);
                        InfoRptBE = (new GenerarPdf()).CrearArchivo(24, this.UsuarioLogin, ds);
                        this.DiccionaryToEntityJS(EasyUtilitario.Helper.Data.SeriaizedDiccionario(InfoRptBE));
                        break;
                    case KEYPRC_RPT_NO_CONFORMIDAD_TIPO_INSPEC:
                        ds = (new Proceso()).DataReportNoConformePorTipodeInspeccion(Convert.ToInt32(this.Año), Convert.ToInt32(this.IdMes), this.UsuarioLogin);
                        InfoRptBE = (new GenerarPdf()).CrearArchivo(29, this.UsuarioLogin, ds);
                        this.DiccionaryToEntityJS(EasyUtilitario.Helper.Data.SeriaizedDiccionario(InfoRptBE));
                        break;
                    case KEYPRC_FIND_TALLER_CONTRAT:
                        this.DataTableToXML((new ControlInspeccionesSoapClient()).BuscarAreaEntidad_Inspeccion(this.TalleroContratista, this.UsuarioLogin));
                        break;
                    case KEYPRC_ADM_ACTIVIDAD:
                        ProyectoActividadBE oProyectoActividadBE = new ProyectoActividadBE();
                        oProyectoActividadBE.IdPryecto = Convert.ToInt32(this.IdProyecto);
                        oProyectoActividadBE.NombreActividad = this.NombreActividad;
                        oProyectoActividadBE.IdEstado = this.IdEstado;
                        oProyectoActividadBE.IdUsuario = this.UsuarioId;
                        oProyectoActividadBE.UserName = this.UsuarioLogin;

                        (new ControlInspeccionesSoapClient()).ModficarInsertarProyectoActividadSIMA(oProyectoActividadBE);
                        break;
                    default:
                        /* ObjetoReporteCompartidoBE oObjetoReporteCompartidoBE = new ObjetoReporteCompartidoBE();
                         oObjetoReporteCompartidoBE = (new AdministrarReportesSoapClient()).DetalleReporteCompartido(3, 86, "erosales");
                         this.EntityToXML(oObjetoReporteCompartidoBE);*/

                        DataTable dt = new DataTable();
                        dt.TableName = "Table";
                        //DataColumn dc = new DataColumn("Nombre", Type.GetType("System.String"));
                        dt.Columns.Add(new DataColumn("Nombre", typeof(string)));
                        dt.Columns.Add(new DataColumn("Centro", typeof(string)));
                        dt.Columns.Add(new DataColumn("Edad", typeof(int)));
                        dt.Columns.Add(new DataColumn("Email", typeof(string)));

                        dt.Rows.Add("Rosales Azabache Eddy", "CALLAO", 20, "EROSALES1@HOTMAIL.COM");
                        dt.Rows.Add("Rosales Azabache jORGE", "CALLAO", 30, "ME1@HOTMAIL.COM");

                        dt.Rows.Add("Rosales Azabache MANUEL", "LIMA", 22, "GOOGLE@HOTMAIL.COM");
                        dt.Rows.Add("Rosales Azabache MANUEL", "CALLAO", 25, "ZZZZ@HOTMAIL.COM");
                        dt.Rows.Add("Rosales Azabache Eddy", "LIMA", 30, "EROSALES1@HOTMAIL.COM");
                        dt.Rows.Add("AMASIFUEN JUENITO", "CALLAO", 20, "EROSALES1@HOTMAIL.COM");
                        dt.Rows.Add("ROBERT GONZALES", "CALLAO", 20, "EROSALES1@HOTMAIL.COM");
                        dt.Rows.Add("ASMAT ASMAT JOSE FRANCISCO", "CHIMBOTE", 15, "ME@HOTMAIL.COM");

                        dt.Rows.Add("Nacarino Cubas jorge", "trujillo", 20, "jnacarino@HOTMAIL.COM");

                        this.DataTableToXML(dt);


                        break;
                }

            }
            catch (Exception ex)
            {
                this.ErrorToXML("0002", "Proceso.aspx", ex);
            }

        }
    }
}