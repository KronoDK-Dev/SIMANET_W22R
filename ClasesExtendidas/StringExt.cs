using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.ClasesExtendidas
{
    public static class StringExt
    {
        public static int NroLetras(this string str)
        {
            return str.Split(new char[] { ' ', '.', '?' }, StringSplitOptions.RemoveEmptyEntries).Length;
        }
    }
}