using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{


    // ============================
    // DTO – Transporte UI → Server
    // ============================
    public class DetalleProgramacionCabeceraDTO
    {
        public int Tipovisita { get; set; }
        public int TipoProgra { get; set; }
        public int AreaDestino { get; set; }
        public string ConocimientoA { get; set; }
        public int Anio { get; set; }
        public string FechaInicio { get; set; }
        public string FechaTermino { get; set; }
        public string HoraIngreso { get; set; }
        
        public string Poliza { get; set; }
        public string Asunto { get; set; }
        public int IdUsuario { get; set; }

        public string Modo { get; set; }
    }

    
    // ============================
    // Resultado estándar
    // ============================
    public class ResultadoBE
    {
        public bool Ok { get; set; }
        public string Mensaje { get; set; }
        public string IdGenerado { get; set; }
    }

}