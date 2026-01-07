using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using MailKit.Search;
using Microsoft.ReportingServices.ReportProcessing.ReportObjectModel;
using NPOI.POIFS.FileSystem;
using NPOI.SS.Formula.Functions;
using SIMANET_W22R.srvHelpDesk;
using System;
using System.Collections.Generic;
using System.Data;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.InterConeccion.EasyDataInterConect;

namespace SIMANET_W22R.HelpDesk
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

        //https://morgantechspace.com/2013/05/ldap-search-filter-examples.html
        //https://philipm.at/2018/searching_users_in_active_directory.html


        
        [WebMethod]
        public int VerificaListernerChatBot(string PathChat)
        {

            string hostname = "10.10.17.53";
            int portno = 4649;
            IPAddress ipa = (IPAddress)Dns.GetHostAddresses(hostname)[0];
            try
            {
                System.Net.Sockets.Socket sock =
                        new System.Net.Sockets.Socket(System.Net.Sockets.AddressFamily.InterNetwork,
                                                      System.Net.Sockets.SocketType.Stream,
                                                      System.Net.Sockets.ProtocolType.Tcp);
                sock.Connect(ipa, portno);
                if (sock.Connected == true) // Port is in use and connection is successful
                    //MessageBox.Show("Port is Closed");
                sock.Close();
                return 1;
            }
            catch (System.Net.Sockets.SocketException ex)
            {
                if (ex.ErrorCode == 10061) // Port is unused and could not establish connection 
                                           // MessageBox.Show("Port is Open!");
                    return 0;
                else
                            //MessageBox.Show(ex.Message);
                            return 0;
            }


        }



        [WebMethod]
        public string GuardarRequerimiento(string Descripcion, string IdServicioArea, string CodigoPersonal,int IdUsuario,string UserName) {

            RequerimientoBE oRequerimientoBE = new RequerimientoBE();
            oRequerimientoBE.IdRequerimiento = "0";
            oRequerimientoBE.IdRequerientoPadre = "0";
            oRequerimientoBE.IdServicioArea = IdServicioArea;
            oRequerimientoBE.NroTicket = "";
            oRequerimientoBE.IdPrioridadSolicitada = 1;
            oRequerimientoBE.IdPersonal = CodigoPersonal;
            oRequerimientoBE.Descripcion = Descripcion;
            oRequerimientoBE.IdUsuario = IdUsuario;
            oRequerimientoBE.UserName = UserName;


            AdministrarHDSoapClient oHelpDesk = new AdministrarHDSoapClient();
           
            return oHelpDesk.Requerimientos_ins(oRequerimientoBE);
        }

        [WebMethod]
        public int GuardarArchivo(string IdRequerimiento,string IdFile,string Nombre,int Temporal,int IdEstado,int Existe,int Enviado, int IdUsuario, string UserName) {

            EasyFileInfo oEasyFileInfo = new EasyFileInfo();
            oEasyFileInfo.IdFile = IdFile;
            oEasyFileInfo.Nombre = Nombre;
            oEasyFileInfo.Temporal=((Temporal==1)?true:false);
            oEasyFileInfo.IdEstado = IdEstado;
            oEasyFileInfo.Existe=((Existe==1)?true:false);
            oEasyFileInfo.Enviado= ((Enviado == 1) ? true : false);

            {
                ArchivoAdjuntoBE oArchivoAdjuntoBE = new ArchivoAdjuntoBE();
                oArchivoAdjuntoBE.IdFile = oEasyFileInfo.IdFile;
                oArchivoAdjuntoBE.Nombre = oEasyFileInfo.Nombre;
                oArchivoAdjuntoBE.Descripcion = "";
                oArchivoAdjuntoBE.IdRequerimiento = IdRequerimiento;
                oArchivoAdjuntoBE.UserName = UserName;
                oArchivoAdjuntoBE.IdUsuario = IdUsuario;
                int p = 0;
                if ((oEasyFileInfo.Temporal == true) && (oEasyFileInfo.IdEstado != 0))
                {
                    //Grabar solo los que dearon
                    oArchivoAdjuntoBE.IdEstado = 1;

                }
                else if ((oEasyFileInfo.Temporal == false) && (oEasyFileInfo.IdEstado == 0))
                {
                    //Eliminar los existentes
                    oArchivoAdjuntoBE.IdEstado = 0;
                }
                if ((oEasyFileInfo.Existe == false) && (oEasyFileInfo.Enviado == true))
                {
                    AdministrarHDSoapClient oHelpDesk = new AdministrarHDSoapClient();
                    //Pasar del area Temporal al fnal
                    oHelpDesk.RequerimientosArhivo_ins(oArchivoAdjuntoBE);
                }
                //Pasa los archivos de la Carpeta temporal la Carpeta final
               // this.EasyUpLoadMultiple1.TemporalToFinal(oEasyFileInfo);

            }
            return 1;
        }




        EasyDataInterConect DetalleRQR(string IdRequerimiento, int IdUsuario, string UserName)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.ConfigPathSrvRemoto = "PathBaseWSCore";
            odi.MetodoConexion = MetododeConexion.WebServiceExterno;
            odi.UrlWebService = "HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "Requerimientos_Det";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = IdUsuario.ToString();
            oParam.TipodeDato = TiposdeDatos.Int;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            oParam.Paramvalue = IdUsuario.ToString();
            oParam.TipodeDato = TiposdeDatos.Int;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = IdRequerimiento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);
            return odi;
        }

        #region Active directory
        [WebMethod]
        public DataTable ActiveDItectoryGetAllUsuarios()
        {
            string[] LstFields = { "samaccountname", "title", "mail", "usergroup", "company", "department", "telephoneNumber", "mobile", "displayname" , "memberOf", "cn", "distinguishedName", "objectguid" };
            DataTable dt = new DataTable();
            dt.TableName = "Table";
            string DomainPath = "LDAP://simaperu.com.pe";
            System.DirectoryServices.DirectoryEntry adSearchRoot = new System.DirectoryServices.DirectoryEntry(DomainPath);
            DirectorySearcher adSearcher = new DirectorySearcher(adSearchRoot);

            adSearcher.Filter = "(&(objectClass=user)(objectCategory=person))";

            for (int i = 0; i < LstFields.Length; i++)
            {
                dt.Columns.Add(new DataColumn(LstFields[i], typeof(string)));
                adSearcher.PropertiesToLoad.Add(LstFields[i]);
            }

            SearchResult result;
            SearchResultCollection iResult = adSearcher.FindAll();
            if (iResult != null)
            {
                for (int counter = 0; counter < iResult.Count; counter++)
                {
                    result = iResult[counter];
                    if (result.Properties.Contains(LstFields[0]))//UserName
                    {
                        DataRow dr = dt.NewRow();
                        foreach (DataColumn dc in dt.Columns)
                        {
                            string NombreField = dc.ColumnName;
                            if (result.Properties.Contains(NombreField))
                            {
                                dr[NombreField] = (String)result.Properties[NombreField][0];
                            }
                        }
                        dt.Rows.Add(dr);
                    }
                }
            }

            adSearcher.Dispose();
            adSearchRoot.Dispose();

            return dt;
        }

        [WebMethod]
        public DataTable ListarGrupos() {
            DataTable dt = new DataTable();
            dt.TableName = "Table";
            dt.Columns.Add(new DataColumn("member", typeof(string)));

            System.DirectoryServices.DirectoryEntry ldapConnection = new System.DirectoryServices.DirectoryEntry("LDAP://simaperu.com.pe");
            ldapConnection.Username = "erosales";
            ldapConnection.Password = "ejraPelucadeLoco2021a";
            ldapConnection.AuthenticationType = AuthenticationTypes.Secure;


            DirectorySearcher searcher = new DirectorySearcher(ldapConnection);
            searcher.Filter = "(objectClass=group)";
            searcher.SearchScope = SearchScope.Subtree;
            searcher.PropertiesToLoad.Add("member");

            SearchResult group = searcher.FindOne();
            if (group != null)
            {
                foreach (string memberDN in group.Properties["member"])
                {
                    DataRow dr = dt.NewRow();
                    dr["member"] = memberDN;
                    dt.Rows.Add(dr);
                }
                dt.AcceptChanges();
            }
            return dt;

        }
       
        [WebMethod]
        public  List<Computer> GetADComputers()
        {

            /* var domain = "simaperu";
             var container = "DC=ad,DC=com";

             using (var context = new PrincipalContext(ContextType.Domain, domain, container))
             {
                 var principal = new UserPrincipal(context)
                 {
                     SamAccountName = "*"
                 };
                 using (var searcher = new PrincipalSearcher(principal))
                 {
                     PrincipalSearchResult<Principal> result1 = searcher.FindAll();
                     //result1.Dump();
                 }
             }
             */


            List<Computer> rst = new List<Computer>();

            string DomainPath = "LDAP://simaperu.com.pe";
            System.DirectoryServices.DirectoryEntry adSearchRoot = new System.DirectoryServices.DirectoryEntry(DomainPath);
            DirectorySearcher adSearcher = new DirectorySearcher(adSearchRoot);

            adSearcher.Filter = ("(objectClass=computer)");
            adSearcher.PropertiesToLoad.Add("description");
            adSearcher.SizeLimit = int.MaxValue;
            adSearcher.PageSize = int.MaxValue;

            SearchResult result;
            SearchResultCollection iResult = adSearcher.FindAll();

            Computer item;

            for (int counter = 0; counter < iResult.Count; counter++)
            {
                result = iResult[counter];

                string ComputerName = result.GetDirectoryEntry().Name;
                if (ComputerName.StartsWith("CN=")) ComputerName = ComputerName.Remove(0, "CN=".Length);
                item = new Computer();
                item.ComputerName = ComputerName;

                if (result.Properties.Contains("description"))
                {
                    item.Description = (String)result.Properties["description"][0];

                }
                rst.Add(item);
            }

            adSearcher.Dispose();
            adSearchRoot.Dispose();

            return rst;
        }

        public class Computer
        {
            public string ComputerName { get; set; }

            public string Description { get; set; }
        }
        #endregion






    }
}
