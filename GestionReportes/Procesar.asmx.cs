using EasyControlWeb;
using SIMANET_W22R.Controles;
using SIMANET_W22R.srvGestionReportes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionReportes
{
    /// <summary>
    /// Descripción breve de Procesar
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Procesar : System.Web.Services.WebService
    {

        string sAmbiente = ConfigurationManager.AppSettings["Ambiente"];
        DataTable dtData = new DataTable();
        [System.Web.Services.WebMethod]
        public DataTable BuscarMetodoWebService(string Metodo, string PathBase, string PathWS, string UserName)
        {
            DataTable dt = new DataTable();
            dt.TableName = "Table";
            dt.Columns.Add(new DataColumn("Id", typeof(string)));
            dt.Columns.Add(new DataColumn("Metodo", typeof(string)));
            dt.Columns.Add(new DataColumn("LstParametros", typeof(string)));
            if (string.IsNullOrWhiteSpace(Metodo) || string.IsNullOrWhiteSpace(PathBase) || string.IsNullOrWhiteSpace(PathWS))
                throw new ArgumentException("Uno o más parámetros requeridos están vacíos.");

            /* EasyUtilitario.Helper.Pagina.DEBUG(PathBase);
             EasyUtilitario.Helper.Pagina.DEBUG(PathWS);
             EasyUtilitario.Helper.Pagina.DEBUG(Metodo);*/

            string PathDLLBase = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "RutaFileDll");
            if (string.IsNullOrWhiteSpace(PathDLLBase))
                throw new Exception("No se encontró la ruta base de la DLL en la configuración.");

            string RutaWS = PathWS.Replace(".asmx", "");
            string NameSpace = (PathBase + RutaWS).Replace("/", ".");
            Assembly assembly = EasyUtilitario.Helper.Reflexion.ObtenerEnsamblado(PathDLLBase);

            if (assembly == null) // para evitar error
                throw new Exception("No se pudo cargar el ensamblado en la ruta: " + PathDLLBase);
            MethodInfo[] methodsInfo = EasyUtilitario.Helper.Reflexion.ListadoMetodos(NameSpace, assembly);
            foreach (MethodInfo mtd in methodsInfo)
            {
                DataRow myDataRow = dt.NewRow();
                myDataRow["Id"] = mtd.Name;
                myDataRow["Metodo"] = mtd.Name;
                dt.Rows.Add(myDataRow);
            }
            /*-----------------------------------------------------------------------------------------------------------*/
            DataView dv = dt.DefaultView;
            dv.RowFilter = "[Metodo] LIKE '%" + Metodo + "%'";

            DataTable dtSelect = dv.ToTable();
            //Al resultado filtrado se buscan y asigna sus parametros
            foreach (DataRow dr in dtSelect.Rows)
            {
                string NameMetodo = dr["Metodo"].ToString();
                EasyUtilitario.Helper.Pagina.DEBUG(NameMetodo);
                //Listar los Parametros del método
                DataTable dtp = ListarParametrosdeMetodo(NameMetodo, PathBase, PathWS, UserName);
                string strP = "";
                int IdxP = 0;
                foreach (DataRow drp in dtp.Rows)
                {
                    strP += ((IdxP == 0) ? "" : ",") + drp["Tipo"].ToString() + " " + drp["Parametro"].ToString();
                    IdxP++;
                }
                dr["LstParametros"] = strP;
            }
            dtSelect.AcceptChanges();

            return dtSelect;

        }

        [System.Web.Services.WebMethod]
        public DataTable ListarParametrosdeMetodo(string Metodo, string PathBase, string PathWS, string UserName)
        {

            DataTable dt = new DataTable();
            dt.TableName = "Table";
            dt.Columns.Add(new DataColumn("Parametro", typeof(string)));
            dt.Columns.Add(new DataColumn("Tipo", typeof(string)));
            dt.Columns.Add(new DataColumn("Posicion", typeof(string)));

            string PathDLLBase = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "RutaFileDll");
            string RutaWS = PathWS.Replace(".asmx", "");
            string NameSpace = (PathBase + RutaWS).Replace("/", ".");

            Assembly assembly = EasyUtilitario.Helper.Reflexion.ObtenerEnsamblado(PathDLLBase);
            Type type = assembly.GetType(NameSpace);
            MethodInfo methodInfo = type.GetMethod(Metodo);
            ParameterInfo[] parameters = methodInfo.GetParameters();

            foreach (ParameterInfo PInf in parameters)
            {
                DataRow myDataRow = dt.NewRow();
                myDataRow["Parametro"] = PInf.Name;
                myDataRow["Tipo"] = PInf.ParameterType.ToString().Replace("System.", "").Replace("32", "").Replace("16", "");
                myDataRow["Posicion"] = PInf.Position.ToString();
                dt.Rows.Add(myDataRow);
            }
            return dt;
        }



        [System.Web.Services.WebMethod]
        public DataTable ListarArchivosDeDirectorio(string Nombre, string RutaBase, string Ext, string UserName)
        {
            RutaBase = RutaBase.Replace(".", EasyUtilitario.Constantes.Caracteres.BackSlash.ToString());
            string PathNoFind = (RutaBase + "Obj").ToString().ToUpper();

            /*REF: https://www.techiedelight.com/es/list-all-files-directory-csharp/  */
            //string RutaBase = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFileRpts");
            DataTable dt = new DataTable();
            dt.TableName = "Table";
            dt.Columns.Add(new DataColumn("Nombre", typeof(string)));
            dt.Columns.Add(new DataColumn("Ruta", typeof(string)));
            dt.Columns.Add(new DataColumn("FCreacion", typeof(string)));
            dt.Columns.Add(new DataColumn("FAcceso", typeof(string)));
            dt.Columns.Add(new DataColumn("RutaBase", typeof(string)));



            FileSystemInfo[] FileInfoBE = new DirectoryInfo(RutaBase).GetFileSystemInfos("*" + Nombre + "*" + Ext, SearchOption.AllDirectories);

            foreach (FileSystemInfo FileBE in FileInfoBE)
            {
                string _FullName = FileBE.FullName;
                string RutaEncontrada = _FullName.Substring(0, PathNoFind.Length);
                if (!RutaEncontrada.ToString().ToUpper().Equals(PathNoFind))
                {

                    DataRow myDataRow = dt.NewRow();
                    myDataRow["Nombre"] = FileBE.Name;
                    string _Ruta = _FullName.Replace(FileBE.Name, "").Replace(EasyUtilitario.Constantes.Caracteres.BackSlash.ToString(), ".");
                    myDataRow["Ruta"] = _Ruta;
                    myDataRow["FCreacion"] = FileBE.CreationTime.ToLongDateString();
                    myDataRow["FAcceso"] = FileBE.LastAccessTime.ToLongDateString();
                    myDataRow["RutaBase"] = RutaBase.Replace("\\", ".");

                    dt.Rows.Add(myDataRow);
                }
            }
            return dt;
        }

        [System.Web.Services.WebMethod]
        public DataTable ListarTipoObjeto(string UserName)
        {
            DataTable dt = new DataTable();
            dt.TableName = "Table";
            dt.Columns.Add(new DataColumn("Codigo", typeof(string)));
            dt.Columns.Add(new DataColumn("Nombre", typeof(string)));


            DataRow myDataRow = dt.NewRow();
            myDataRow["Codigo"] = "0";
            myDataRow["Nombre"] = "Carpeta";
            dt.Rows.Add(myDataRow);

            myDataRow = dt.NewRow();
            myDataRow["Codigo"] = "1";
            myDataRow["Nombre"] = "Reporte";
            dt.Rows.Add(myDataRow);

            return dt;
        }

        [System.Web.Services.WebMethod]
        public DataTable Listar(string IdPadre, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                dt = ogReports.ListarObjetos(IdPadre, UserName);
                dt.TableName = "Table";
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["Ref1"].ToString().Length > 0)
                    {
                        dr["Ref1"] = dr["Ref1"].ToString().Replace(EasyUtilitario.Constantes.Caracteres.BackSlash.ToString(), "@");
                    }
                }
                dt.AcceptChanges();
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return dt;
        }


        [System.Web.Services.WebMethod]
        public DataTable EliminarFilePdfPorUser(string UserName, string NombreFile)
        {
            string fileName = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRpt");
            return EliminarFilePdfPorUser(fileName, UserName, NombreFile);
        }
        public DataTable EliminarFilePdfPorUser(string PathBase, string UserName, string NombreFile)
        {
            string fileName = PathBase + UserName + @"\" + NombreFile;
            if (File.Exists(fileName))
            {
                try
                {
                    File.Delete(fileName);
                }
                catch (Exception e)
                {
                    return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");
                }
            }
            else
            {
                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");
            }

            return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }

        public DataTable CopiaFilePdfPorUser(string UserNameOrg, string UserNameDest, string NombreFile)
        {
            string PathBase = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRpt");
            return CopiaFilePdfPorUser(PathBase, UserNameOrg, UserNameDest, NombreFile);
        }
        public DataTable CopiaFilePdfPorUser(string PathBase, string UserNameOrg, string UserNameDest, string NombreFile)
        {
            string fileNameSource = PathBase + UserNameOrg + @"\" + NombreFile;
            string fileNameDestino = PathBase + UserNameDest + @"\" + NombreFile;

            if (File.Exists(fileNameSource))
            {
                try
                {
                    File.Copy(fileNameSource, fileNameDestino);
                }
                catch (Exception e)
                {
                    return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");
                }
            }
            else
            {
                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");
            }

            return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("1");
        }


        [System.Web.Services.WebMethod]
        public DataTable ListarFilePdfPorUser(string IdObjeto, string UserName, string NomReport)
        {
            string PathLocal = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRpt") + @"\" + UserName;
            string PathHTTP = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRptHttp") + "/" + UserName;

            if (Directory.Exists(PathLocal))
            {
                DataTable dt = new DataTable();
                dt.Columns.Add(new DataColumn("IdGenerado", typeof(string)));
                dt.Columns.Add(new DataColumn("Nombre", typeof(string)));
                dt.Columns.Add(new DataColumn("PathFile", typeof(string)));
                dt.Columns.Add(new DataColumn("FechaHora", typeof(string)));
                dt.Columns.Add(new DataColumn("UserName", typeof(string)));
                dt.Columns.Add(new DataColumn("Grupo", typeof(string)));
                dt.Columns.Add(new DataColumn("IdTipo", typeof(string)));

                dt.TableName = "Table";



                List<string> FileList = new List<string>();
                DirectoryInfo dir_info = new DirectoryInfo(PathLocal);

                IEnumerable<FileInfo> fileList = dir_info.GetFiles("*.*");

                IEnumerable<FileInfo> fileQuery = from file in fileList
                                                  where (file.Name.Substring(0, (IdObjeto.Length + 1)) == IdObjeto + "_")
                                                  orderby file.LastWriteTime
                                                  select file;


                try
                {
                    string NomGrupo = "";
                    int NroArchivos = fileQuery.Count<FileInfo>();
                    foreach (System.IO.FileInfo file_info in fileQuery)
                    {
                        DataRow dr = dt.NewRow();
                        dr["IdGenerado"] = file_info.Name;
                        dr["Nombre"] = NomReport;
                        dr["PathFile"] = PathHTTP + "/" + file_info.Name;
                        dr["FechaHora"] = file_info.LastWriteTime.ToLongDateString();
                        dr["UserName"] = UserName;
                        dr["IdTipo"] = "9999";
                        string AñoMes = file_info.LastWriteTime.Year.ToString() + file_info.LastWriteTime.Month.ToString();
                        if (NomGrupo != AñoMes)
                        {
                            NomGrupo = AñoMes;
                        }
                        dr["Grupo"] = NomGrupo;

                        dt.Rows.Add(dr);
                    }
                    dt.AcceptChanges();
                }
                catch (UnauthorizedAccessException)
                {

                }
                return dt;
            }
            return null;
        }


        [System.Web.Services.WebMethod]
        public DataTable ListarReportePorUsuario(string IdUsuario, string IdPadre, string UserName)
        {
            DataTable dt = new DataTable();
            try
            {
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                dt = ogReports.ListarReportePorUsuario(IdUsuario, UserName);

                if (dt != null)
                {
                    DataView dv = dt.DefaultView;
                    dv.RowFilter = "IdPadre=" + IdPadre;
                    dt = new DataTable();
                    dt = EasyUtilitario.Helper.Data.ViewToDataTable(dv);
                    dt.TableName = "Table";
                }
            }
            catch (Exception ex)
            {
                string e = ex.Message;
            }
            return dt;
        }



        [System.Web.Services.WebMethod]
        public DataTable ListarCentros()
        {
            DataTable dt = new DataTable();
            dt.TableName = "Table";
            dt.Columns.Add(new DataColumn("Codigo", typeof(string)));
            dt.Columns.Add(new DataColumn("Nombre", typeof(string)));

            DataRow myDataRow = dt.NewRow();
            myDataRow["Codigo"] = "10";
            myDataRow["Nombre"] = "Callao";
            dt.Rows.Add(myDataRow);

            myDataRow = dt.NewRow();
            myDataRow["Codigo"] = "20";
            myDataRow["Nombre"] = "Chimbote";
            dt.Rows.Add(myDataRow);

            myDataRow = dt.NewRow();
            myDataRow["Codigo"] = "30";
            myDataRow["Nombre"] = "Iquitos";
            dt.Rows.Add(myDataRow);
            return dt;
        }


        [System.Web.Services.WebMethod]
        public DataTable ListarCentrosCostos(string IdCentroOperativo)
        {
            DataTable dt = new DataTable();
            dt.TableName = "Table";
            dt.Columns.Add(new DataColumn("Codigo", typeof(string)));
            dt.Columns.Add(new DataColumn("Nombre", typeof(string)));

            DataRow myDataRow = dt.NewRow();
            myDataRow["Codigo"] = "10";
            myDataRow["Nombre"] = "Divison de desarrollo";
            dt.Rows.Add(myDataRow);

            myDataRow = dt.NewRow();
            myDataRow["Codigo"] = "20";
            myDataRow["Nombre"] = "Division de soporte";
            dt.Rows.Add(myDataRow);

            myDataRow = dt.NewRow();
            myDataRow["Codigo"] = "30";
            myDataRow["Nombre"] = "division de infraestructura";
            dt.Rows.Add(myDataRow);
            return dt;
        }

        [System.Web.Services.WebMethod]
        public DataSet DemoResultado(string param1, string param2, string param3)
        {
            //esn el servicio local  para los reportes que contienen susb reportes se llamaran a los sp que cmponen cada sub reporte
            //y se ontendra cada data table se establecera su nombre y se agregara al dataset

            /*ManodeObraSoapClient mob = new ManodeObraSoapClient();
            DataTable dt = mob.TestOracle("1", "ere");
            dt.TableName = "SP_LISTA_OTS_SE";

            DataSet ds = new DataSet();
            ds.Tables.Add(dt);
            return ds;*/
            return (new GestiondeCalidad.Proceso()).ReporteFichaTecnica("2023-21", 86, 3, "erosales");

        }


        #region Metodos validos


        [System.Web.Services.WebMethod]
        public DataTable BuscarUsuarios(string ApellidosyNombres, string UserName)
        {

            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            DataTable dt = ogReports.BuscarUsuariosxNombre(ApellidosyNombres, UserName);
            dt.TableName = "Table";
            return dt;
        }



        [System.Web.Services.WebMethod]
        public DataTable ListarUsuariorFileCompartidos(string NombreArchivo, string UserName)
        {
            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();

            DataTable dtFileCOmpart = ogReports.ListarUsuariosCompartidoFile(NombreArchivo, UserName);
            dtFileCOmpart.TableName = "Table";

            return dtFileCOmpart;
        }

        [System.Web.Services.WebMethod]
        public DataTable CompartirArchivo(string NombreArchivo, int IdObjeto, int IdUsuarioComp, string NombreUsuarioComp, int IdUsuarioRegistro, string UserName, int IdEstado)
        {
            try
            {
                ArchivoCompartidoBE oArchivoCompartidoBE = new ArchivoCompartidoBE();
                oArchivoCompartidoBE.IdCompartido = NombreArchivo;
                oArchivoCompartidoBE.IdObjeto = IdObjeto;
                oArchivoCompartidoBE.IdUsuarioComp = IdUsuarioComp;
                oArchivoCompartidoBE.IdUsuario = IdUsuarioRegistro;
                oArchivoCompartidoBE.UserName = UserName;
                oArchivoCompartidoBE.IdEstado = IdEstado;

                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();

                string Resultado = ogReports.ModificaInsertaArchivo(oArchivoCompartidoBE);
                /*Ubicarse en la carpeta del usuario y  localizar el archivo para elimiarlo si el estado es 0*/
                if (oArchivoCompartidoBE.IdEstado == 0)
                {
                    //Eliminar
                    DataTable dt = EliminarFilePdfPorUser(NombreUsuarioComp, NombreArchivo);
                }
                else
                {
                    //Copiar
                    string PathHomeUser = (new GenerarPdf()).CrearHome(NombreUsuarioComp);
                    CopiaFilePdfPorUser(UserName, NombreUsuarioComp, NombreArchivo);
                }


                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD(Resultado);
            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");

            }
        }


        [System.Web.Services.WebMethod]
        public DataTable CompartirObjeto(int IdObjeto, int IdUsuarioComp, string EmailComp, string Descripcion, int Owner, int IdUsuario, string UserName, int IdEstado)
        {
            try
            {

                ObjetoPrivilegioBE oObjetoPrivilegioBE = new ObjetoPrivilegioBE();
                oObjetoPrivilegioBE.IdObjeto = IdObjeto;
                oObjetoPrivilegioBE.IdUsuarioCompartido = IdUsuarioComp;
                oObjetoPrivilegioBE.Descripcion = Descripcion;
                oObjetoPrivilegioBE.owner = Owner;
                oObjetoPrivilegioBE.IdUsuario = IdUsuario;
                oObjetoPrivilegioBE.UserName = UserName;
                oObjetoPrivilegioBE.IdEstado = IdEstado;

                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();

                string Resultado = ogReports.ModificaInsertaObjetoPrivilegio(oObjetoPrivilegioBE);

                string msg = ((IdEstado == 1) ? "Se ha compartido el siguiente reporte: " : "Se ha dejado de compartido el siguiente reporte: ") + Descripcion;
                if (Resultado == "1")
                {
                    //enviar por correo
                    string UserSend = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "UserSend");
                    Mail oMail = new Mail(UserSend, EmailComp, msg, "Compartir Reporte");
                    MailResult oMailResult = oMail.enviaMail();
                }

                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD(Resultado);
            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return EasyControlWeb.EasyUtilitario.Helper.Data.TransaccionalAD("0");

            }
        }




        [System.Web.Services.WebMethod]
        public ObjetoReporteCompartidoBE DetalleUsuarioReporteCompartido(int IdObjeto, int IdUsuarioComp, string UserName)
        {
            try
            {
                ObjetoReporteCompartidoBE oObjetoReporteCompartidoBE = new ObjetoReporteCompartidoBE();
                oObjetoReporteCompartidoBE = (new AdministrarReportesSoapClient()).DetalleReporteCompartido(IdObjeto, IdUsuarioComp, UserName);
                return oObjetoReporteCompartidoBE;
            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return null;

            }
        }
        [System.Web.Services.WebMethod]
        public DataTable ListarUsuarioReporteCompartido(int IdObjeto, string UserName)
        {
            try
            {
                DataTable dt = new DataTable();
                dt.TableName = "Table";
                dt = (new AdministrarReportesSoapClient()).ListarUsuariosxReporteCompartido(IdObjeto, UserName);
                return dt;
            }
            catch (Exception ex)
            {
                return EasyUtilitario.Helper.Data.Error("Procesar.asmx", ex.Message);
            }

        }

        #endregion

        [System.Web.Services.WebMethod]
        public int InsertaModificaObjeto(int IdObjeto, int IdPadre, string Nombre, int IdTipo, int IdTipoControl, string Descripcion, string Ref1, string Ref2, string Ref3, string Ref4, int OrdenXNivel, int IdUsuarioAnalista, int IdUsuarioSolicitante, int IdEstado, int IdUsuario, string UserName)
        {
            try
            {
                ObjetoBE oObjetoBE = new ObjetoBE();
                oObjetoBE.IdObjeto = IdObjeto;
                oObjetoBE.IdPadre = IdPadre;
                oObjetoBE.Nombre = Nombre;
                oObjetoBE.IdTipo = IdTipo;
                oObjetoBE.IdTipoControl = IdTipoControl;
                oObjetoBE.Descripcion = Descripcion;
                oObjetoBE.Ref1 = Ref1;
                oObjetoBE.Ref2 = Ref2;
                oObjetoBE.Ref3 = Ref3;
                oObjetoBE.Ref4 = Ref4;
                oObjetoBE.IdUsuarioAnalista = IdUsuarioAnalista;
                oObjetoBE.IdUsuarioSolicitante = IdUsuarioSolicitante;
                oObjetoBE.IdUsuario = IdUsuario;
                oObjetoBE.UserName = UserName;
                oObjetoBE.IdEstado = IdEstado;
                oObjetoBE.OrdenXNivel = OrdenXNivel;
                int id = (new AdministrarReportesSoapClient()).InsertarObjeto(oObjetoBE);

                return id;
            }
            catch (Exception ex)
            {
                return -1;
            }

        }


        [System.Web.Services.WebMethod]
        public int ModificarInsertarObjetoConfigAttr(int IdAtributoValor, int IdObjeto, int IdAtributo, string Valor, int IdGrp, int OrdenParam, int IdUsuario, string UserName)
        {
            try
            {
                ObjetoConfigAttrBE oObjetoConfigAttrBE = new ObjetoConfigAttrBE();
                oObjetoConfigAttrBE.IdAtributoValor = IdAtributoValor;
                oObjetoConfigAttrBE.IdObjeto = IdObjeto;
                oObjetoConfigAttrBE.IdAtributo = IdAtributo;
                oObjetoConfigAttrBE.Valor = Valor;
                oObjetoConfigAttrBE.IdGrp = IdGrp;
                oObjetoConfigAttrBE.Orden = OrdenParam;
                oObjetoConfigAttrBE.IdUsuario = IdUsuario;
                oObjetoConfigAttrBE.UserName = UserName;

                int id = (new AdministrarReportesSoapClient()).InsModObjetoConfigAtrributosValor(oObjetoConfigAttrBE);

                return id;
            }
            catch (Exception ex)
            {
                return -1;
            }

        }


        [WebMethod(Description = "Usado en l apagina de DetalleReporte para efectos de comparcion en Javascript")]
        public DataTable ListaObjectoChildrens(int IdObjetoPadre)
        {
            DataTable dt = (new DetalleReporte()).CargarTree(IdObjetoPadre);
            dt.TableName = "Table";
            return dt;
        }

        [WebMethod(Description = "Realiza un  BK de los parametros dek metodo que vicula al reporte .rpt para la carga de sus datos")]
        public int BackupParam(string Guid, string IdObjeto, string UserName)
        {
            return ((new AdministrarReportesSoapClient())).BackupParam(Guid, IdObjeto, UserName);
        }


        [WebMethod(Description = "Actualiza Mapeo Estructura - Campos ")]
        public int MapearDatosInsertaModifica(int IdObjeto, int IdDataField, int IdDataFieldPadre, string Nombre, string Alias, string Descripcion, int Tipo, string FieldCompute, int Exportar, int Orden, int Prioridad, int IdUsuario, int IdEstado, string UserName)
        {
            ObjetoMapeoExportBE oObjetoMapeoExportBE = new ObjetoMapeoExportBE();
            oObjetoMapeoExportBE.IdObjeto = IdObjeto;
            oObjetoMapeoExportBE.IdDataField = IdDataField;
            oObjetoMapeoExportBE.IdDataFieldPadre = IdDataFieldPadre;
            oObjetoMapeoExportBE.Nombre = Nombre;
            oObjetoMapeoExportBE.Alias = Alias;
            oObjetoMapeoExportBE.Descripcion = Descripcion;
            oObjetoMapeoExportBE.Tipo = Tipo;
            oObjetoMapeoExportBE.FieldCompute = FieldCompute;
            oObjetoMapeoExportBE.Exportar = Exportar;
            oObjetoMapeoExportBE.Orden = Orden;
            oObjetoMapeoExportBE.Prioridad = Prioridad;
            oObjetoMapeoExportBE.IdUsuario = IdUsuario;
            oObjetoMapeoExportBE.IdEstado = IdEstado;
            oObjetoMapeoExportBE.UserName = UserName;

            int id = (new AdministrarReportesSoapClient()).MapearDatosInsertaModifica(oObjetoMapeoExportBE);
            return id;
        }


        [WebMethod(Description = "Accesos por Usuario")]
        public DataTable ListaAccesos_RptxUsuario(string v_usuario, string v_ambiente, string UserName)
        {
            dtData = (new AdministrarReportesSoapClient()).ListaAccesos_RptxUsuario(v_usuario, sAmbiente, UserName);
            dtData.TableName = "SP_ListaAccesos_RptxUsuario";
            return dtData;
        }
        [WebMethod(Description = "Accesos por Usuario v2")]
        public DataTable ListaAccesos_RptxUsuario_v2(string v_usuario, string UserName)
        {
            dtData = (new AdministrarReportesSoapClient()).ListaAccesos_RptxUsuario_v2(v_usuario, UserName);
            dtData.TableName = "SP_ListaAccesos_RptxUsuario_v2";
            return dtData;
        }
    }
}