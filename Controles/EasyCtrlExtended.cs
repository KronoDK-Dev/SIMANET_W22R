using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.srvGestionReportes;
using EasyControlWeb.Form.Estilo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using EasyControlWeb;
using EasyControlWeb.Form.Base;
using System.Runtime.CompilerServices;
using System.Security.Cryptography.X509Certificates;
using SIMANET_W22R.General;
using SIMANET_W22R.GestionReportes;
using static EasyControlWeb.EasyUtilitario.Enumerados.Configuracion.SeccionKey;
using System.Web.UI;
using static EasyControlWeb.InterConeccion.EasyDataInterConect;

namespace SIMANET_W22R.Controles
{
     public static class EasyCtrlExtended
    {
        public static EasyAutocompletar  SetAttrValue(this EasyAutocompletar oEasyAutocompletar, string IdObjeto, int IdTipoControl)
        {

            SetAttr(oEasyAutocompletar, IdObjeto,IdTipoControl);
            
            return oEasyAutocompletar;
        }
        public static EasyListAutocompletar SetAttrValue(this EasyListAutocompletar oEasyListAutocompletar, string IdObjeto, int IdTipoControl)
        {
            SetAttr(oEasyListAutocompletar, IdObjeto, IdTipoControl);
            return oEasyListAutocompletar;
        }
        

        public static EasyDropdownList SetAttrValue(this EasyDropdownList oEasyDropdownList, string IdObjeto,int IdTipoControl)
        {

            SetAttr(oEasyDropdownList, IdObjeto, IdTipoControl);

            return oEasyDropdownList;
        }

        public static EasyNumericBox SetAttrValue(this EasyNumericBox oEasyNumericBox, string IdObjeto, int IdTipoControl)
        {

            SetAttr(oEasyNumericBox, IdObjeto, IdTipoControl);

            return oEasyNumericBox;
        }

        public static void SetAttr(this object obj, string IdObjeto, int IdTipoControl)
        {
            string Atributo = "";
            DataTable dtSubProp;
            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            DataTable dtProperty = ogReports.ListarCtrlAttrParametro(IdObjeto, "0", IdTipoControl, "erosales");

            if ((dtProperty != null) && (dtProperty.Rows.Count > 0))
            {
                foreach (DataRow rowAttrib in dtProperty.Rows)
                {
                    string ValoPropiedad = "";
                    string TipoPropiedad = "";
                    try
                    {
                        Atributo = rowAttrib["NombreAttr"].ToString();
                        ValoPropiedad = rowAttrib["Valor"].ToString().TrimEnd();

                        var property = obj.GetType().GetProperty(Atributo); //Crea el atributo de la clase
                        if ((Atributo == "EasyStyle") && (rowAttrib["SubAttr"].ToString() != "0"))//COn estilos
                        {
                            dtSubProp = ogReports.ListarCtrlAttrParametro(IdObjeto, rowAttrib["IdAtributo"].ToString(), IdTipoControl, "erosales");

                            if (dtSubProp != null)
                            {
                                EasyControlWeb.Form.Estilo.Bootstrap oEasyStyle = new EasyControlWeb.Form.Estilo.Bootstrap();
                                oEasyStyle.ClassLabel = "form-label";
                                oEasyStyle.ClassName = "form-control";

                                foreach (DataRow dr in dtSubProp.Rows)
                                {
                                    string NomAttr = dr["NombreAttr"].ToString();
                                    ConvertValueRefProperty(oEasyStyle, NomAttr, dr["Valor"].ToString());
                                }

                                ConvertValueRefProperty(obj, Atributo, oEasyStyle);
                            }
                        }
                        else if ((Atributo == "DataInterconect") && (rowAttrib["SubAttr"].ToString() != "0")) //COn interconexion de datos
                        {
                            EasyDataInterConect oEasyDataInterConect = new EasyDataInterConect();
                           // oEasyDataInterConect.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceInterno;// luego se tendra que estableces como propiedad dinamica
                            dtSubProp = ogReports.ListarCtrlAttrParametro(IdObjeto, rowAttrib["IdAtributo"].ToString(), IdTipoControl, "erosales");
                            foreach (DataRow dr in dtSubProp.Rows)
                            {
                                string NomAttr = dr["NombreAttr"].ToString();

                                //Los parametros
                                if (NomAttr == "UrlWebServicieParams")
                                {
                                    //Contextualiza la pagina de proceso
                                    string IdAttr = dr["IdAtributo"].ToString();
                                    DataTable dtParam = ogReports.ListarCtrlAttrParametro(IdObjeto, IdAttr, IdTipoControl, "erosales");//Obtiene todos los parametros con sus atributos

                                    DataTable dtGrpParam = EasyUtilitario.Helper.Data.SelectDistinct(dtParam, "IdGrp");
                                    foreach (DataRow drGrpParam in dtGrpParam.Rows)
                                    {
                                        if (drGrpParam["IdGrp"].ToString().Trim().Length > 0)
                                        {
                                            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();// otro bucle
                                            foreach (DataRow drParam in dtParam.Select("IdGrp=" + drGrpParam["IdGrp"].ToString()))
                                            {
                                                string NomParam = drParam["NombreAttr"].ToString();
                                                string ValParam = drParam["Valor"].ToString();
                                                switch (ValParam) {
                                                    case "@UserName":
                                                    case "@IdUsuario":
                                                    case "@IdObjeto":
                                                        ValParam = ValParam.Replace("@", "");
                                                        break;
                                                }
                                                ConvertValueRefProperty(oParam, NomParam, ValParam);
                                            }
                                            oEasyDataInterConect.UrlWebServicieParams.Add(oParam);
                                        }
                                    }
                                }
                                else
                                { //Valores normales
                                    ConvertValueRefProperty(oEasyDataInterConect, NomAttr, dr["Valor"].ToString());
                                }
                            }

                            ConvertValueRefProperty(obj, Atributo, oEasyDataInterConect);
                        }

                        else if ((Atributo == "EasyCtrlDepend") && (rowAttrib["SubAttr"].ToString() != "0")) {
                            dtSubProp = ogReports.ListarCtrlAttrParametro(IdObjeto, rowAttrib["IdAtributo"].ToString(), IdTipoControl, "erosales");
                            EasyControlBE oEasyControlBE = new EasyControlBE();

                            foreach (DataRow dr in dtSubProp.Rows)
                            {
                                string NomAttr = dr["NombreAttr"].ToString();
                                ConvertValueRefProperty(oEasyControlBE, NomAttr, dr["Valor"].ToString());
                            }
                           ConvertValueRefProperty(obj, Atributo, oEasyControlBE);

                        }
                        else if (rowAttrib["SubAttr"].ToString() == "0")
                        {
                            if (Atributo.Equals("VEntorno"))
                            {
                                ((EasyDropdownList)obj).SetText(ValoPropiedad);
                            }
                            else
                            {
                                TipoPropiedad = property.PropertyType.ToString();
                                if (ValoPropiedad.Length > 0)
                                {
                                    ConvertValueRefProperty(obj, Atributo, ValoPropiedad);
                                }
                            }
                        }
                        
                    }
                    catch (Exception oex)
                    {

                    }

                }
            }
        }


        public static void ConvertValueRefProperty(this object obj, string propertyName, object pValoPropiedad)
        {
            PropertyInfo oProperty = obj.GetType().GetProperty(propertyName);
            string PropType = oProperty.PropertyType.ToString();

            if (PropType == "System.DateTime")
            {
                oProperty.SetValue(obj, Convert.ToDateTime(pValoPropiedad), null);
            }
            else if (PropType == "System.Nullable`1[System.DateTime]")
            {
                var typedVal = NullableSafeChangeType(Convert.ToString(pValoPropiedad), oProperty.PropertyType);

                if (!string.IsNullOrEmpty(Convert.ToString(pValoPropiedad)))
                    oProperty.SetValue(obj, typedVal, null);
            }
            else if (PropType == "System.Decimal")
            {
                oProperty.SetValue(obj, Convert.ToDecimal(pValoPropiedad), null);
            }
            else if (PropType == "System.Nullable`1[System.Decimal]")
            {
                var typedVal = NullableSafeChangeType(Convert.ToString(pValoPropiedad), oProperty.PropertyType);

                if (!string.IsNullOrEmpty(Convert.ToString(pValoPropiedad)))
                    oProperty.SetValue(obj, typedVal, null);

            }
            else if (PropType == "System.String")
            {
                oProperty.SetValue(obj, pValoPropiedad.ToString(), null);
            }
            else if (PropType == "System.Int16")
            {
                oProperty.SetValue(obj, Convert.ToInt16(pValoPropiedad), null);

            }
            else if (PropType == "System.Int32")
            {
                oProperty.SetValue(obj, Convert.ToInt32(pValoPropiedad), null);

            }
            else if (PropType == "System.Boolean")
            {
                bool valBool = pValoPropiedad.ToString().ToUpper().Equals("TRUE");
                oProperty.SetValue(obj, valBool, null);

            }
            else if (PropType == "EasyControlWeb.Form.Estilo.Bootstrap")
            {
                oProperty.SetValue(obj, (EasyControlWeb.Form.Estilo.Bootstrap)(pValoPropiedad), null);

            }
            else if (PropType == "EasyControlWeb.InterConeccion.EasyDataInterConect")
            {
                oProperty.SetValue(obj, (EasyControlWeb.InterConeccion.EasyDataInterConect)(pValoPropiedad), null);
            }
            else if (PropType == "EasyControlWeb.InterConeccion.EasyDataInterConect+MetododeConexion")
            {
                MetododeConexion oMetodoConexion = (MetododeConexion)System.Enum.Parse(typeof(MetododeConexion), Convert.ToString(pValoPropiedad));
                oProperty.SetValue(obj, oMetodoConexion, null);
            }
            else if (PropType == "EasyControlWeb.Form.Estilo.Bootstrap+Tamaño")
            {
                EasyControlWeb.Form.Estilo.Bootstrap.Tamaño oAncho = (EasyControlWeb.Form.Estilo.Bootstrap.Tamaño)System.Enum.Parse(typeof(EasyControlWeb.Form.Estilo.Bootstrap.Tamaño), Convert.ToString(pValoPropiedad));
                oProperty.SetValue(obj, oAncho, null);
            }
            else if (PropType == "EasyControlWeb.Form.Estilo.Bootstrap+Talla")
            {
                EasyControlWeb.Form.Estilo.Bootstrap.Talla oTalla = (EasyControlWeb.Form.Estilo.Bootstrap.Talla)System.Enum.Parse(typeof(EasyControlWeb.Form.Estilo.Bootstrap.Talla), Convert.ToString(pValoPropiedad));
                oProperty.SetValue(obj, oTalla, null);
            }
            else if (PropType == "EasyControlWeb.EasyUtilitario+Enumerados+TiposdeDatos")
            {
                EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos oTDato= (EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos)System.Enum.Parse(typeof(EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos), Convert.ToString(pValoPropiedad));
                oProperty.SetValue(obj, oTDato, null);
            }
            else if (PropType == "EasyControlWeb.Filtro.EasyFiltroParamURLws+TipoObtenerValor")
            {
                EasyFiltroParamURLws.TipoObtenerValor oTValor = (EasyFiltroParamURLws.TipoObtenerValor)System.Enum.Parse(typeof(EasyFiltroParamURLws.TipoObtenerValor), Convert.ToString(pValoPropiedad));
                oProperty.SetValue(obj, oTValor, null);
            }
            else if (PropType == "System.Collections.Generic.List`1[EasyControlWeb.Form.Base.EasyControlBE]")
            {
                if (obj is EasyDropdownList)
                {
                    ((EasyDropdownList)obj).EasyCtrlDepend.Add((EasyControlBE)pValoPropiedad);
                }
                else {
                    ((EasyAutocompletar)obj).EasyCtrlDepend.Add((EasyControlBE)pValoPropiedad);
                }
            }
            

        }

        static object NullableSafeChangeType(string input, Type type)
        {
            Type underlyingType = Nullable.GetUnderlyingType(type);
            if (underlyingType == null) // Non-nullable; convert directly
            {
                return Convert.ChangeType(input, type);
            }
            else
            {
                return input == null || input == "" ? null
                    : Convert.ChangeType(input, underlyingType);
            }
        }

    }
}