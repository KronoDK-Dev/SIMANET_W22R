using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.Exceptiones
{
    [Serializable]
    public class SIMAExceptionSeguridadAccesoForms : Exception
    {
        public SIMAExceptionSeguridadAccesoForms()
        {
        }

        public SIMAExceptionSeguridadAccesoForms(string message)
            : base(message)
        {
        }

        public SIMAExceptionSeguridadAccesoForms(string message, HttpException inner)
            : base(message, inner)
        {
        }
    }
}