using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionProyecto;
using SIMANET_W22R.srvProyectos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.GestionProyecto
{
    /// <summary>
    /// Descripción breve de Proyecto
    /// </summary>
    [WebService(Namespace = "http://sima.com.pe/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Proyecto : System.Web.Services.WebService
    {
        // instanciamos el servicio web que es con seguridad https 
        srvGestionProyecto.ProyectoSoapClient oProyectos = new srvGestionProyecto.ProyectoSoapClient();
        DataTable dtResultados = new DataTable();

        [WebMethod(Description = "Lista Colaboradores")]
        public DataTable ListaColaboradores(string v_descripcion, string UserName)
        {
            // faaltaria capturar el centro opertivo del usuario logeado
            dtResultados = oProyectos.Buscar_Colaborador_xCod("1", v_descripcion);
            return dtResultados;
        }

        [WebMethod(Description = "Lista Presupuesto del Proyecto")]
        public DataTable Get_ProyectoPresupuesto(string s_Sucursal, string s_proyecto,string UserName)
        {
            // faaltaria capturar el centro opertivo del usuario logeado
            dtResultados = oProyectos.Get_ProyectoPresupuesto(s_proyecto,s_Sucursal, UserName);
            return dtResultados;
        }
        

    }
}
