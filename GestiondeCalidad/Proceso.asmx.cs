using EasyControlWeb;
using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionReportes;
using SIMANET_W22R.srvProyectos;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using SIMANET_W22R.Controles;
using SIMANET_W22R.GestionReportes;
using SIMANET_W22R.srvGestionCalidad;

namespace SIMANET_W22R.GestiondeCalidad
{
    /// <summary>
    /// Descripción breve de Proceso
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Proceso : System.Web.Services.WebService
    {
        DataTable dt;
        DataTable dtClon;
        [System.Web.Services.WebMethod(EnableSession = true)]
        public DataTable TreeListarInspeciones(string IdInspeccion, int IdUsuario, string UserName)
        {
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            dt = oCalidad.Inspeccion_Listar(IdInspeccion, IdUsuario, UserName);

            return EasyUtilitario.Helper.Data.TreeData(dt, "IdInspeccionPadre", "IdInspeccion");
        }
        void TreeInspeccion(string IdInspeccion, string IdNodo, int Nivel)
        {
            int i = 1;
            foreach (DataRow dr in dt.Select("IdInspeccionPadre='" + IdInspeccion + "'"))
            {
                DataRow newRow = dtClon.NewRow();
                newRow.ItemArray = dr.ItemArray;

                newRow["IdNodo"] = ((Nivel == 1) ? i.ToString() : IdNodo + "." + i.ToString());
                newRow["Nivel"] = Nivel;
                dtClon.Rows.Add(newRow);

                if (Convert.ToInt32(dr["NroHijos"]) > 0)
                {
                    TreeInspeccion(newRow["IdInspeccion"].ToString(), newRow["IdNodo"].ToString(), (Nivel + 1));

                }
                i++;
            }
        }

        [System.Web.Services.WebMethod]
        public DataTable BAreaoEmpresa(string NombreAreaoEmpresa, int IdUsuario, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                dt = oCalidad.BuscarAreaEntidad(NombreAreaoEmpresa, IdUsuario, UserName);
                dt.TableName = "Table";
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return dt;
        }

        [System.Web.Services.WebMethod]
        public DataTable BuscarAprobadores(string ApellidosyNombres, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                dt = oCalidad.BuscarAprobador(ApellidosyNombres, UserName);
                dt.TableName = "Table";
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return dt;
        }


        [System.Web.Services.WebMethod]
        public string ActEstadoResponsableArea(string IdInspeccion, int IdTipoPersonal, string IdPersonal, int IdEstado, int IdUsuario, string UserName)
        {
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();

            ResponsableAreaBE oResponsableAreaBE = new ResponsableAreaBE();
            oResponsableAreaBE.IdInspeccion = IdInspeccion;
            oResponsableAreaBE.IdPersonal = IdPersonal;
            oResponsableAreaBE.IdTipoPersonal = IdTipoPersonal;
            oResponsableAreaBE.IdUsuario = IdUsuario;
            oResponsableAreaBE.UserName = UserName;
            oResponsableAreaBE.IdEstado = IdEstado;

            string id = oCalidad.Inspeccion_ModficarInsertarResponsable(oResponsableAreaBE);
            return id;
        }

        [System.Web.Services.WebMethod]
        public DataTable DetalleResponsableXAreaModyInsert(string IdDetalleResponsableArea, string IdInspeccion, string IdPersonal, string Observacion, string IdEstado, string IdUsuario, string UserName)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                ResponsableAreaDetalleBE oResponsableAreaDetalleBE = new ResponsableAreaDetalleBE();
                oResponsableAreaDetalleBE.IdDetalleResponsableArea = IdDetalleResponsableArea;
                oResponsableAreaDetalleBE.IdInspeccion = IdInspeccion;
                oResponsableAreaDetalleBE.IdPersonal = Convert.ToInt32(IdPersonal);
                oResponsableAreaDetalleBE.Observacion = Observacion;
                oResponsableAreaDetalleBE.IdUsuario = Convert.ToInt32(IdUsuario);
                oResponsableAreaDetalleBE.IdEstado = Convert.ToInt32(IdEstado);
                oResponsableAreaDetalleBE.UserName = UserName;
                oCalidad.ResponsabledeAreaDetalle_InsertaModifica(oResponsableAreaDetalleBE);
            }
            catch (Exception ex)
            {
                return EasyControlWeb.EasyUtilitario.Helper.Data.Error("Proceso.asmx", ex.Message);

            }
            return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }

        [System.Web.Services.WebMethod]
        public int ActualizaEstadoDetalleResponsable(string IdDetalleResponsableArea, string IdEstado, string UserName)
        {
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            ResponsableAreaDetalleBE oResponsableAreaDetalleBE = new ResponsableAreaDetalleBE();
            oResponsableAreaDetalleBE.IdDetalleResponsableArea = IdDetalleResponsableArea;
            oResponsableAreaDetalleBE.IdEstado = Convert.ToInt32(IdEstado);
            oResponsableAreaDetalleBE.UserName = UserName;
            return oCalidad.DetallePorReponsabledeAreaCambiarEstado(oResponsableAreaDetalleBE);
        }



        [System.Web.Services.WebMethod]
        public DataTable BuscarProyInspec(string NombreProyecto, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                dt = oCalidad.BuscarProyectodeInspeccion(NombreProyecto, UserName);
                dt.TableName = "Table";
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return dt;
        }


        [System.Web.Services.WebMethod]
        public DataTable Listar(string NombreProyecto, int IdUsuario, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                dt = oCalidad.Inspeccion_Listar("0", IdUsuario, UserName);
                dt.TableName = "Table";
                // EasyControlWeb.EasyUtilitario.Helper.Pagina.WriteDataTableToXML(dt);
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return dt;
        }

        [System.Web.Services.WebMethod]
        public DataTable ModificarInsertarInspector(string IdInspector, string IdInspeccion, string Idpersonal, string Principal, string IdUsuario, string UserName, string IdEstado)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();

                InspectorBE oInspectorBE = new InspectorBE();
                oInspectorBE.IdInspector = IdInspector;
                oInspectorBE.IdInspeccion = IdInspeccion;
                oInspectorBE.IdPersonal = Convert.ToInt32(Idpersonal);
                oInspectorBE.Principal = Convert.ToInt32(Principal);
                oInspectorBE.IdUsuario = Convert.ToInt32(IdUsuario);
                oInspectorBE.UserName = UserName;
                oInspectorBE.IdEstado = Convert.ToInt32(IdEstado);

                oCalidad.Inspeccion_ModificarInsertarInspector(oInspectorBE);
            }
            catch (Exception ex)
            {
                return EasyControlWeb.EasyUtilitario.Helper.Data.Error("Proceso.asmx", ex.Message);

            }
            return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }


        [System.Web.Services.WebMethod]
        public DataTable ModificarInsertarRespnsableArea(string IdInspeccion, string Idpersonal, int IdTipoPesonal, string IdUsuario, string UserName, string IdEstado)
        {
            try
            {

                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();

                ResponsableAreaBE oResponsableAreaBE = new ResponsableAreaBE();
                oResponsableAreaBE.IdInspeccion = IdInspeccion;
                oResponsableAreaBE.IdPersonal = Idpersonal;
                oResponsableAreaBE.IdTipoPersonal = IdTipoPesonal;
                oResponsableAreaBE.IdUsuario = Convert.ToInt32(IdUsuario);
                oResponsableAreaBE.UserName = UserName;
                oResponsableAreaBE.IdEstado = Convert.ToInt32(IdEstado);

                oCalidad.Inspeccion_ModficarInsertarResponsable(oResponsableAreaBE);
            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");

            }
            return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }
        [System.Web.Services.WebMethod]
        public DataTable ModificarInsertarDetalledeInspecciones(string IdDetalleInspeccion, string IdInspector, string Fecha, string Descripcion, string Recomendaciones, int IdClausula, int IdEstado, int IdUsuario, string UserName)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();

                InspectorDetalleBE oInspectorDetalleBE = new InspectorDetalleBE();
                oInspectorDetalleBE.IdDetalleInspeccion = IdDetalleInspeccion;
                oInspectorDetalleBE.IdInspector = IdInspector;
                oInspectorDetalleBE.Fecha = Convert.ToDateTime(Fecha);
                oInspectorDetalleBE.Descripcion = Descripcion;
                oInspectorDetalleBE.Recomendaciones = Recomendaciones;
                oInspectorDetalleBE.IdClausula = IdClausula;
                oInspectorDetalleBE.IdEstado = IdEstado;
                oInspectorDetalleBE.IdUsuario = IdUsuario;
                oInspectorDetalleBE.UserName = UserName;

                oCalidad.InsertaModificaDetalledeInspeccion(oInspectorDetalleBE);
            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");

            }
            return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }

        [System.Web.Services.WebMethod]
        public DataTable BuscarActividad(string NombreActividad, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                dt = oCalidad.BuscarActividad(NombreActividad, UserName);
                dt.TableName = "Table";
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return dt;
        }


        [System.Web.Services.WebMethod]
        public DataTable ModificarInsertarActividadProyecto(string IdProyecto, string NombreActividad, string IdEstado, string IdUsuario, string UserName)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                ProyectoActividadBE oProyectoActividadBE = new ProyectoActividadBE();
                oProyectoActividadBE.IdPryecto = Convert.ToInt32(IdProyecto);
                oProyectoActividadBE.NombreActividad = NombreActividad;
                oProyectoActividadBE.IdUsuario = Convert.ToInt32(IdUsuario);
                oProyectoActividadBE.IdEstado = Convert.ToInt32(IdEstado);
                oProyectoActividadBE.UserName = UserName;

                oCalidad.ModficarInsertarProyectoActividadSIMA(oProyectoActividadBE);

            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");

            }
            return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }



        [System.Web.Services.WebMethod]
        public DataTable Listar2(string NombreProyecto, string UserName)
        {
            return null;
        }


        /*PAra Buscar por proyecto*/
        [System.Web.Services.WebMethod]
        public DataTable BuscarProyectoXNombre(string NombreProyecto, string UserName)
        {
            string Criterio = "NombreProyecto like '%" + NombreProyecto + "%'";
            return BuscarDatosProyecto(Criterio, UserName);
        }


        [System.Web.Services.WebMethod]
        public DataTable BuscarAreaEntidad_Inspeccion(string TalleoContratista, string UserName)
        {
            DataTable dt = (new ControlInspeccionesSoapClient()).BuscarAreaEntidad_Inspeccion(TalleoContratista, UserName);
            dt.TableName = "Table";
            return dt;
        }

        [System.Web.Services.WebMethod]
        public DataTable BuscarProyectoXCliente(string RazonSocialCliente, string UserName)
        {
            DataTable dtResult = new DataTable();
            try
            {
                GeneralSoapClient oGeneral = new GeneralSoapClient();
                dtResult = oGeneral.BuscarCliente(RazonSocialCliente, UserName);
                dtResult.TableName = "Table";
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return dtResult;
        }


        private DataTable BuscarDatosProyecto(string Criterio, string UserName)
        {
            DataTable dtResult = new DataTable();
            try
            {
                DataTable dt = (new ProyectosSoapClient()).ListarProyectosSIMA("0", UserName);
                DataView dv = dt.DefaultView;

                dv.RowFilter = Criterio;
                if (dv.Count > 0)
                {
                    dtResult = EasyUtilitario.Helper.Data.ViewToDataTable(dv);
                }

                return dtResult;
            }
            catch (Exception ex)
            {
                dtResult = EasyControlWeb.EasyUtilitario.Helper.Data.Error("Proceso.asmx", ex.Message);

            }
            return dtResult;

        }


        #region para los reportes
        [System.Web.Services.WebMethod]
        public DataSet ReporteFichaTecnica(string IdInspeccion, int IdObjeto, int IdUsuario, string UserName)
        {
            //https://learn.microsoft.com/es-es/troubleshoot/developer/visualstudio/csharp/language-compilers/copy-image-database-picturebox
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            try
            {
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();

                DataTable dtimg = new DataTable();
                DataTable dtAnexo = new DataTable();
                int NroImagenes = 1;
                dtimg = oCalidad.ListarInspeccionAnexos(IdInspeccion, UserName);
                if (dtimg != null)
                {
                    dtAnexo = dtimg.Clone();
                    dtAnexo.TableName = "CALuspNTADListarAnexosdeInspeccion;1";
                    string PathFileAnexo = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "CalidadPathFiles");

                    if (dtimg.Rows.Count > 2)
                    {
                        int PointReg = 0;

                        DataRow drnew = dtAnexo.NewRow();
                        int nroReg = 1;
                        foreach (DataRow dr in dtimg.Rows)
                        {
                            PointReg++;
                            string NombreF = PathFileAnexo + dr["Archivo"].ToString();
                            if (File.Exists(NombreF))
                            {
                                switch (NroImagenes)
                                {
                                    case 1:
                                    case 2:
                                        // case 3:
                                        drnew["imagen" + NroImagenes.ToString()] = EasyUtilitario.Helper.Archivo.ImgTobytBLOBData(NombreF);
                                        break;
                                }

                                if ((NroImagenes == 2) || (PointReg == dtimg.Rows.Count))
                                {
                                    drnew["IdAnexo"] = nroReg;
                                    drnew["IdInspeccion"] = dr["IdInspeccion"];

                                    dtAnexo.Rows.Add(drnew);
                                    dtAnexo.AcceptChanges();

                                    drnew = dtAnexo.NewRow();
                                    NroImagenes = 0;
                                    nroReg++;
                                }

                                NroImagenes++;
                            }

                        }
                    }
                    else
                    {
                        foreach (DataRow dr in dtimg.Rows)
                        {
                            DataRow drnew = dtAnexo.NewRow();
                            drnew["IdAnexo"] = dr["IdAnexo"];
                            drnew["IdInspeccion"] = dr["IdInspeccion"];
                            string NombreF = PathFileAnexo + dr["Archivo"].ToString();
                            drnew["Imagen"] = EasyUtilitario.Helper.Archivo.ImgTobytBLOBData(NombreF);
                            dtAnexo.Rows.Add(drnew);
                            dtAnexo.AcceptChanges();
                        }
                    }

                }



                dt = new DataTable();
                dt = ogReports.ListarCabeceradeReporte(IdObjeto, UserName);
                dt.TableName = "RPT_uspNTADDetalleReporte;1";
                dt.AcceptChanges();
                ds.Tables.Add(dt);


                dt = new DataTable();
                dt = oCalidad.Inspeccion_Listar(IdInspeccion, IdUsuario, UserName);
                dt.Rows[0]["NroImagenes"] = dtimg.Rows.Count.ToString();
                dt.TableName = "CALuspNTADAdministrarInspeccion;1";
                ds.Tables.Add(dt);

                //Lista de INspectores participantes
                dt = new DataTable();
                dt = oCalidad.Inspeccion_ListarInspectores(IdInspeccion, UserName);
                dt.TableName = "CALuspNTADListarInspectores;1";
                ds.Tables.Add(dt);

                dt = new DataTable();
                dt = oCalidad.ListarResponsablesPorArea(IdInspeccion, UserName);
                dt.TableName = "CALuspNTADListarResponsablesxArea;1";
                ds.Tables.Add(dt);

                /*dt = new DataTable();
                 dt = oCalidad.ListarResponsablesPorArea(IdInspeccion, UserName);
                 dt.TableName = "CALuspNTADListarResponsablesxArea;2";
                 ds.Tables.Add(dt);*/

                ds.Tables.Add(dtAnexo);

                //Firmas
                dt = new DataTable();
                dt = oCalidad.ListarUsuariosFirmantesRefCruz(IdInspeccion, UserName);
                dt.TableName = "CALuspNTADListarUsuariosFirmantesRefCruz;1";
                if (dt.Rows.Count > 0)
                {
                    string PathImgFirma = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "CalidadPathFirma");
                    if (File.Exists(PathImgFirma + dt.Rows[0]["Firma1"].ToString()))
                    {
                        dt.Rows[0]["ImgFirma1"] = EasyUtilitario.Helper.Archivo.ImgTobytBLOBData(PathImgFirma + dt.Rows[0]["Firma1"].ToString());
                    }
                    if (File.Exists(PathImgFirma + dt.Rows[0]["Firma2"].ToString()))
                    {
                        dt.Rows[0]["ImgFirma2"] = EasyUtilitario.Helper.Archivo.ImgTobytBLOBData(PathImgFirma + dt.Rows[0]["Firma2"].ToString());
                    }
                    if (File.Exists(PathImgFirma + dt.Rows[0]["Firma3"].ToString()))
                    {
                        dt.Rows[0]["ImgFirma3"] = EasyUtilitario.Helper.Archivo.ImgTobytBLOBData(PathImgFirma + dt.Rows[0]["Firma3"].ToString());
                    }
                    dt.AcceptChanges();
                }
                ds.Tables.Add(dt);
                return ds;
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return null;
        }

        [WebMethod(Description = "Resumen por Periodo de Inspoecciones y estados")]
        public DataTable ResumenInspeccionesPorEstado(int Año, int IdUsuario, string UserName)
        {
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            return oCalidad.ResumenInspeccionesPorEstado(Año, IdUsuario, UserName);
        }

        //Implementado en aspx

        [System.Web.Services.WebMethod]
        public int ModificarInsertarPeronaFirmantexTipo(string IdInspeccion, int IdPersonalFirmante, int IdTipoFirmante, string Descripcion, int IdUsuario, string UserName, int IdEstado)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                UsuarioFirmanteBE oUsuarioFirmanteBE = new UsuarioFirmanteBE();
                oUsuarioFirmanteBE.IdInspeccion = IdInspeccion;
                oUsuarioFirmanteBE.IdPersonaFirmante = IdPersonalFirmante;
                oUsuarioFirmanteBE.IdTipoFirmante = IdTipoFirmante;
                oUsuarioFirmanteBE.Descripcion = Descripcion;
                oUsuarioFirmanteBE.IdUsuario = IdUsuario;
                oUsuarioFirmanteBE.UserName = UserName;
                oUsuarioFirmanteBE.IdEstado = IdEstado;

                oCalidad.InsModPersonalFirmantePorTipo(oUsuarioFirmanteBE);

            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return -1;//EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");

            }
            return 1;//EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }

        [System.Web.Services.WebMethod]
        public int ModificarInsertarPeronaFirmante(string IdInspeccion, int IdPersonalFirmante, int IdTipoFirmante, string Descripcion, string ImagenFirma, int IdUsuario, string UserName, int IdEstado)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                UsuarioFirmanteBE oUsuarioFirmanteBE = new UsuarioFirmanteBE();
                oUsuarioFirmanteBE.IdInspeccion = IdInspeccion;
                oUsuarioFirmanteBE.IdPersonaFirmante = IdPersonalFirmante;
                oUsuarioFirmanteBE.IdTipoFirmante = IdTipoFirmante;
                oUsuarioFirmanteBE.Descripcion = Descripcion;
                oUsuarioFirmanteBE.Firma = ImagenFirma;
                oUsuarioFirmanteBE.IdUsuario = IdUsuario;
                oUsuarioFirmanteBE.UserName = UserName;
                oUsuarioFirmanteBE.IdEstado = IdEstado;

                oCalidad.ModificaInsertaUsuariosFirmantes(oUsuarioFirmanteBE);

            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return -1;//EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");

            }
            return 1;//EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }

        [System.Web.Services.WebMethod]
        public int ModificarInsertarFirmante(int IdPersonalFirmante, string ImagenFirma, int IdEstado, int IdUsuario, string UserName)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                UsuarioFirmanteBE oUsuarioFirmanteBE = new UsuarioFirmanteBE();
                oUsuarioFirmanteBE.IdPersonaFirmante = IdPersonalFirmante;
                oUsuarioFirmanteBE.Firma = ImagenFirma;
                oUsuarioFirmanteBE.IdUsuario = IdUsuario;
                oUsuarioFirmanteBE.UserName = UserName;
                oUsuarioFirmanteBE.IdEstado = IdEstado;

                oCalidad.ModificaInsertaFirmas(oUsuarioFirmanteBE);

            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return -1;//EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");

            }
            return 1;//EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }
        #endregion






        /*
        [System.Web.Services.WebMethod]
        public DataTable InspeccionCambiarEstado(string IdInspeccion, int IdEstado, int IdUsuario, string UserName)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                oCalidad.InspeccionCambiarEstado(IdInspeccion, IdEstado, IdUsuario, UserName);

            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");

            }
            return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }
        */

        //Implementados

        [System.Web.Services.WebMethod]
        public DataTable ListarReponsableArea(string IdInspeccion, string UserName)
        {
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            return oCalidad.ListarResponsablesPorArea(IdInspeccion, UserName);
        }


        /*https://www.c-sharpcorner.com/blogs/web-services-using-c-sharp-chpater-3-creating-web-services2*/
        //Implementado en aspx

        [System.Web.Services.WebMethod]
        public DataTable ListarInspectores(string IdInspeccion, string UserName)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                return oCalidad.Inspeccion_ListarInspectores(IdInspeccion, UserName);
            }
            catch (Exception ex)
            {
                return EasyUtilitario.Helper.Data.Error("Proceso.asmx", ex.Message);
            }
        }


        #region Reporte de indicadores 
        [System.Web.Services.WebMethod]
        public DataSet DataReporteNoConforme(int Año, int MesHasta, string UserName)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            try
            {

                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                dt = new DataTable();
                dt = ogReports.ListarCabeceradeReporte(13, UserName);
                dt.TableName = "RPT_uspNTADDetalleReporte;1";
                ds.Tables.Add(dt);

                dt = new DataTable();
                dt = oCalidad.ResumenNoConformeIP_SIMA(Año, MesHasta, 0, UserName);
                dt.TableName = "CALuspNTADReporteResumenProyInspeccion;1";

                ds.Tables.Add(dt);

                dt = new DataTable();
                dt = oCalidad.ResumenNoConformeIP(Año, MesHasta, UserName);
                dt.TableName = "CALuspNTADReporteResumenProyInspeccionIP;1";
                ds.Tables.Add(dt);

                dt = new DataTable();
                dt = oCalidad.ResumenNoConformeSIMA(Año, MesHasta, UserName);
                dt.TableName = "CALuspNTADReporteResumenProyInspeccionSIMA;1";
                ds.Tables.Add(dt);
            }
            catch (Exception ex)
            {
                string e = ex.Message;
                return null;
            }


            return ds;
        }

        //Invocado desde javascript
        [System.Web.Services.WebMethod]
        public string GenerarReporteNoConformidad(string Anio, string MesHasta, string UserName)
        {
            DataSet ds = DataReporteNoConforme(Convert.ToInt32(Anio), Convert.ToInt32(MesHasta), UserName);
            Dictionary<string, string> InfoRptBE = (new GenerarPdf()).CrearArchivo(13, UserName, ds);
            return EasyUtilitario.Helper.Data.SeriaizedDiccionario(InfoRptBE);
        }
        #endregion

        #region Reporte de indicadores por proyecto

        [System.Web.Services.WebMethod]
        public DataSet DataReportResumenNoConformePorProyecto_Mensual(int Año, int MesHasta, string UserName)
        {
            //https://learn.microsoft.com/es-es/troubleshoot/developer/visualstudio/csharp/language-compilers/copy-image-database-picturebox
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            try
            {
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                dt = new DataTable();
                dt = ogReports.ListarCabeceradeReporte(13, UserName);
                dt.TableName = "RPT_uspNTADDetalleReporte;1";
                ds.Tables.Add(dt);

                dt = new DataTable();
                dt = oCalidad.ResumenNoConformePorProyecto_Mensual(Año, MesHasta, UserName);
                dt.TableName = "CALuspNTADReporteResumenPorProyecto;1";


                ds.Tables.Add(dt);
                return ds;
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return null;
        }

        //Invocado desde javascript
        [System.Web.Services.WebMethod]
        public string GenerarReporteNoConformidadResumenProyecto(string Anio, string MesHasta, string UserName)
        {
            DataSet ds = DataReportResumenNoConformePorProyecto_Mensual(Convert.ToInt32(Anio), Convert.ToInt32(MesHasta), UserName);
            Dictionary<string, string> InfoRptBE = (new GenerarPdf()).CrearArchivo(19, UserName, ds);
            return EasyUtilitario.Helper.Data.SeriaizedDiccionario(InfoRptBE);
        }



        #endregion

        #region Reporte de indicadores por IP-SIMA

        [System.Web.Services.WebMethod]
        public DataSet DataReportResumenNoConformePorIP_SIMA_Mensual(int Año, int MesHasta, string UserName)
        {
            //https://learn.microsoft.com/es-es/troubleshoot/developer/visualstudio/csharp/language-compilers/copy-image-database-picturebox
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            try
            {
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                dt = new DataTable();
                dt = ogReports.ListarCabeceradeReporte(24, UserName);
                dt.TableName = "RPT_uspNTADDetalleReporte;1";
                ds.Tables.Add(dt);


                dt = new DataTable();
                dt = oCalidad.ResumenNoConformePorIP_SIMA_Mensual(Año, MesHasta, 0, UserName);
                dt.TableName = "CALuspNTADReporteResumenPorTALLERES_CONTRATISTA;1";
                ds.Tables.Add(dt);

                dt = new DataTable();
                dt = oCalidad.ResumenNoConformePorIP_SIMA_Mensual(Año, MesHasta, 0, UserName);
                dt.TableName = "CALuspNTADReporteResumenPorTALLERES_CONTRATISTA;2";
                ds.Tables.Add(dt);

                return ds;
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return null;
        }

        //Invocado desde javascript
        [System.Web.Services.WebMethod]
        public string GenerarReporteNoConformidadResumenIP_SIMA(string Anio, string MesHasta, string UserName)
        {
            DataSet ds = DataReportResumenNoConformePorIP_SIMA_Mensual(Convert.ToInt32(Anio), Convert.ToInt32(MesHasta), UserName);
            Dictionary<string, string> InfoRptBE = (new GenerarPdf()).CrearArchivo(24, UserName, ds);
            return EasyUtilitario.Helper.Data.SeriaizedDiccionario(InfoRptBE);
        }



        #endregion


        #region Reporte de indicadores por Tipo de Inspeccion

        [System.Web.Services.WebMethod]
        public DataSet DataReportNoConformePorTipodeInspeccion(int Año, int MesHasta, string UserName)
        {
            //https://learn.microsoft.com/es-es/troubleshoot/developer/visualstudio/csharp/language-compilers/copy-image-database-picturebox
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            try
            {
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                dt = new DataTable();
                dt = ogReports.ListarCabeceradeReporte(29, UserName);
                dt.TableName = "RPT_uspNTADDetalleReporte;1";
                ds.Tables.Add(dt);


                dt = new DataTable();
                dt = oCalidad.ResumenNoConformePorTipodeInspeccion(Año, MesHasta, UserName);
                dt.TableName = "CALuspNTADReporteResumenPorTipoInspeccion;1";
                ds.Tables.Add(dt);

                dt = new DataTable();
                dt = oCalidad.ResumenNoConformePorTipodeInspeccion(Año, MesHasta, UserName);
                dt.TableName = "CALuspNTADReporteResumenPorTipoInspeccion;2";
                ds.Tables.Add(dt);

                return ds;
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return null;
        }

        //Invocado desde javascript
        [System.Web.Services.WebMethod]

        public string GenerarReporteNoConformePorTipodeInspeccion(string Anio, string MesHasta, string UserName)
        {
            DataSet ds = DataReportNoConformePorTipodeInspeccion(Convert.ToInt32(Anio), Convert.ToInt32(MesHasta), UserName);
            Dictionary<string, string> InfoRptBE = (new GenerarPdf()).CrearArchivo(29, UserName, ds);
            return EasyUtilitario.Helper.Data.SeriaizedDiccionario(InfoRptBE);
        }



        #endregion

        string btnAprobado = "data:image/gif;base64,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";
        string btnDesaprobado = "data:image/gif;base64,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";


        [System.Web.Services.WebMethod]
        public int AprobarSolicitudFI(string IdInspeccion, int IdPersonalFirmante, string _TokenID, int IdEstado, string UserName)
        {
            //Actualizar 
            UsuarioFirmanteBE UsuarioFirmanteBE = new UsuarioFirmanteBE();
            UsuarioFirmanteBE.IdInspeccion = IdInspeccion;
            UsuarioFirmanteBE.IdPersonaFirmante = IdPersonalFirmante;
            UsuarioFirmanteBE.Token = _TokenID;
            UsuarioFirmanteBE.IdTipoPlazo = 0;
            UsuarioFirmanteBE.TiempoPlazo = 0;
            UsuarioFirmanteBE.UpDateEmail = 2;//Accionado desde la plataforma
            UsuarioFirmanteBE.IdEstado = IdEstado;//Aprobado/desaprobado
            UsuarioFirmanteBE.UserName = UserName;
            int PrcEst = (new ControlInspeccionesSoapClient()).FirmaAprobarFromEMail(UsuarioFirmanteBE);
            return PrcEst;
        }

        [System.Web.Services.WebMethod]
        public int EMailToInspector(string IdInspeccion, int IdPersonalFirmante, string EMailDestino, string Mensaje, string UserName)
        {
            //Actualiza nro de correos enviados recibidos
            UsuarioFirmanteBE oUsuarioFirmanteBE = new UsuarioFirmanteBE();
            oUsuarioFirmanteBE.IdInspeccion = IdInspeccion;
            oUsuarioFirmanteBE.IdPersonaFirmante = IdPersonalFirmante;

            int NroMsg = (new ControlInspeccionesSoapClient()).ActualizaNroMsgRecibidos(oUsuarioFirmanteBE);

            Mail oMail = new Mail(UserName + "@sima.com.pe", EMailDestino, Mensaje, "Urgente");
            MailResult oMailResult = oMail.enviaMail();
            return NroMsg;
        }

        [System.Web.Services.WebMethod]
        public int EnviaEmailSolAprobar(string IdInspeccion, int IdPersonalFirmante, int IdTipoPlazo, int TiempoPlazo, int IdUsuario, string UserName, string PathApp, string PagPrc)
        {
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
            ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
            InspeccionBE oInspeccionBE = oCalidad.Inspeccion_Detalle(IdInspeccion, IdUsuario, UserName);

            DataRow[] drs = oCalidad.ListarUsuariosFirmantes(IdInspeccion, IdUsuario.ToString(), UserName).Select("IdPersonaFirmante='" + IdPersonalFirmante.ToString() + "'");
            DataRow dr = drs[0];
            string PathFileMod = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "CalidadLocalFiles") + "Plantillas\\FrmSolocitaAprobacion.aspx";
            string BodyEmail = EasyUtilitario.Helper.Archivo.Leer(PathFileMod);

            string UrlFoto = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFotos");
            Guid myuuid = Guid.NewGuid();//Identificador unico que servira para relacionar la fila de la grilla con sus data en script
            string _TokenID = myuuid.ToString();
            string PageParams = PathApp + PagPrc + "?ID=" + IdInspeccion + EasyUtilitario.Constantes.Caracteres.SignoAmperson + "Token=" + _TokenID
                        + EasyUtilitario.Constantes.Caracteres.SignoAmperson + "idPer=" + IdPersonalFirmante.ToString()
                        + EasyUtilitario.Constantes.Caracteres.SignoAmperson + "IDPrc=1";
            //Actualizar 
            UsuarioFirmanteBE UsuarioFirmanteBE = new UsuarioFirmanteBE();
            UsuarioFirmanteBE.IdInspeccion = IdInspeccion;
            UsuarioFirmanteBE.IdPersonaFirmante = IdPersonalFirmante;
            UsuarioFirmanteBE.Token = _TokenID;
            UsuarioFirmanteBE.IdTipoPlazo = IdTipoPlazo;
            UsuarioFirmanteBE.TiempoPlazo = TiempoPlazo;
            UsuarioFirmanteBE.UpDateEmail = 0;
            UsuarioFirmanteBE.IdEstado = 2;//Solicta aprobacion


            //Referencia: https://stackoverflow.com/questions/1585985/how-to-use-the-webclient-downloaddataasync-method-in-this-context
            string ImgFoto = EasyUtilitario.Helper.Archivo.UrlImagen.DownloadToUrlData(new Uri(UrlFoto + dr["NroDocDNI"].ToString() + ".jpg"));

            int PrcEst = (new ControlInspeccionesSoapClient()).FirmaAprobarFromEMail(UsuarioFirmanteBE);
            if (PrcEst == 1)
            {
                string HTML_APROBADO = "<a href=" + cmll + PageParams + "&IdEst=3" + cmll + "> <img src=" + cmll + btnAprobado + cmll + " width=" + cmll + "62px" + cmll + "height =" + cmll + "91px" + cmll + "></a>";
                string HTML_DESAAPROBADO = "<a href=" + cmll + PageParams + "&IdEst=4" + cmll + "> <img src=" + cmll + btnDesaprobado + cmll + " width=" + cmll + "74px" + cmll + "height =" + cmll + "91px" + cmll + "></a>";

                string Modalidad = "";
                if (IdTipoPlazo != 4)
                {
                    switch (IdTipoPlazo)
                    {
                        case 1:
                            Modalidad = "Minuto(s)";
                            break;
                        case 2:
                            Modalidad = "Hora(s)";
                            break;
                        case 3:
                            Modalidad = "Dias(s)";
                            break;
                    }

                }

                BodyEmail = BodyEmail.Replace("[IMG]", ImgFoto)
                                    .Replace("[QUIENENVIA]", dr["ApellidosyNombres"].ToString())
                                    .Replace("[PROYECTO]", oInspeccionBE.NombreProyecto)
                                    .Replace("[NRO]", oInspeccionBE.NroReporte)
                                    .Replace("[FECHA]", oInspeccionBE.FechaInspeccion.ToShortDateString())
                                    .Replace("[ESTADO]", oInspeccionBE.NombreEstado)
                                    .Replace("[PROCESO]", oInspeccionBE.NombreTipoProceso.ToString())
                                    .Replace("[CLIENTE]", oInspeccionBE.ClienteRazonSocial.ToString())
                                    .Replace("[DESCRIPCION]", oInspeccionBE.Descripcion.ToString())
                                    .Replace("[APROB]", HTML_APROBADO)
                                    .Replace("[DESAPROB]", HTML_DESAAPROBADO)
                                    .Replace("[MSG]", ((IdTipoPlazo != 4) ? "De no ser aprobado en su momento y por ser de suma urgencia se procederá su aprobación de manera automática en: (" + TiempoPlazo.ToString() + ") " + Modalidad : ""))
                                    .Replace("[PATHAPP]", PathApp);



                Dictionary<string, string> InfoRptBE = (new EnviarPorCorreo()).GenerarRI(IdInspeccion, 8, oInspeccionBE.NroReporte, oInspeccionBE.NombreProyecto, IdUsuario, UserName);

                List<string> lstArchivos = new List<string>();
                string NombreArchivo = InfoRptBE["PathLocal"].ToString() + "\\" + InfoRptBE["NombreNuevo"].ToString();
                lstArchivos.Add(NombreArchivo);

                Mail oMail = new Mail(UserName.ToLower() + "@sima.com.pe", dr["EMail"].ToString(), BodyEmail, InfoRptBE["NombreNuevo"].ToString(), lstArchivos);
                //Mail oMail = new Mail(UserName + "@sima.com.pe", "erosales@sima.com.pe", BodyEmail, InfoRptBE["NombreNuevo"].ToString(), lstArchivos);               
                MailResult oMailResult = oMail.enviaMail();

                //Eliminar reporte
                //File.Delete(NombreArchivo);

                return 1;
            }
            else
            {
                return -1;
            }
        }
    }
}
