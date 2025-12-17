using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.PublicClass
{
    public sealed class sglGlobalData
    {
        public static DataTable getDTContactos
        {
            get { return dt; }
        }
        static DataTable dt;


        //El valor de esta variable se incrementará en 1 cada vez que se cree el objeto de la clase
        private static int Counter = 0;
        //Esta variable va a almacenar la instancia Singleton
        private static sglGlobalData Instance = null;
        //El siguiente método estático devolverá la instancia Singleton
        public static sglGlobalData GetInstance()
        {
            //Si la instancia de la variable es nula, cree la instancia Singleton 
            //else devuelve la instancia singleton ya creada
            //Su versión no es segura para hilos
            if (Instance == null)
            {
                Instance = new sglGlobalData();
                UpdateADUsuarios();
            }
            //Devolver la instancia de Singleton
            return Instance;
        }
        //El constructor es privado significa que, desde fuera de la clase, no podemos crear una instancia de esta clase
        private sglGlobalData()
        {
            //Cada vez que se llama al constructor, incremente el valor del contador en 1
            Counter++;
            Console.WriteLine("Counter Value " + Counter.ToString());
        }

        public static void UpdateADUsuarios()
        {
            dt = new DataTable();
            dt.TableName = "Table";
            // dt = (new HelpDesk.Procesar()).ActiveDItectoryGetAllUsuarios();
        }
        public void Disponse()
        {
            ((System.Web.UI.Page)HttpContext.Current.Handler).Session["UserBE"] = null;
            ((System.Web.UI.Page)HttpContext.Current.Handler).Session["IdUsuario"] = null;
        }
    }
}