using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvProyectos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProduccion
{
    /// <summary>
    /// Descripción breve de Proyectos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Proyectos : System.Web.Services.WebService
    {
        [WebMethod]
        public DataTable BProyectoxNombre(string NOMBREPROY, string UserName)
        {
            DataTable dt = new DataTable();
            dt.TableName = "Table";
            try
            {
                dt = (new ProyectosSoapClient()).BuscarPryectoPor(1, NOMBREPROY, UserName);
            }
            catch (Exception ex)
            {
                return EasyControlWeb.EasyUtilitario.Helper.Data.Error("Proyectos.asmx", ex.Message);

            }
            return dt;
        }




        [WebMethod(Description = "buscar proyecto por codigo")]
        public DataTable BProyectoxCodigo(string CODIGOPROY, string UserName)
        {
            return (new ProyectosSoapClient()).BuscarPryectoPor(2, CODIGOPROY, UserName);
        }
        [WebMethod(Description = "buscar proyecto por CLIENTE")]
        public DataTable BProyectoxCliente(string CLIENTEPROY, string UserName)
        {
            return (new ProyectosSoapClient()).BuscarPryectoPor(3, CLIENTEPROY, UserName);
        }



        [WebMethod(Description = "Inserta proyecto por CLIENTE")]
        public int ProyectoInsAct(int IdProyecto, string Codigo, string Nombre, string Descripcion, int IdCliente, int IdLN, int IdEstado, int IdUsuario, string UserName)
        {
            try
            {

                ProyectoBE oProyectoBE = new ProyectoBE();
                oProyectoBE.IdProyecto = IdProyecto;
                oProyectoBE.CodigoProy = Codigo;
                oProyectoBE.Nombre = Nombre;
                oProyectoBE.Descripcion = Descripcion;
                oProyectoBE.IdCliente = IdCliente;
                oProyectoBE.IdLN = IdLN;
                oProyectoBE.IdUsuario = IdUsuario;
                oProyectoBE.IdEstado = IdEstado;
                return (new ProyectosSoapClient()).InsertaModificaProyecto(oProyectoBE);
            }
            catch (Exception ex)
            {
                return -1;

            }
        }

        [WebMethod(Description = "Lista Colaboradores")]
        public DataTable ListaColaboradores(string v_descripcion, string UserName)
        {
            return (new GeneralSoapClient()).ListaUserUnisysxNom(v_descripcion, UserName);
        }
    }
}
