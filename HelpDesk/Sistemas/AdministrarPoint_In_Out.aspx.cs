using EasyControlWeb.Filtro;
using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EasyControlWeb.Form.Base;
using EasyControlWeb.Form.Controls.Cards;

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class AdministrarPoint_In_Out : HelpDeskBase,IPaginaBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            this.LlenarDatos();
            //LlenarDatos2();
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void LlenarCombos()
        {
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
            EasyViewLog1.ID = "ViewLog_" + this.IdTipoElemento;
            DataTable dtBase = ObtenerDatos();

            DataTable dtGroupPath = EasyUtilitario.Helper.Data.SelectDistinct(dtBase, "PathSource");
            foreach (DataRow drGroupPath in dtGroupPath.Rows) {
                    EasyViewLogGroup oEasyViewLogGroup = new EasyViewLogGroup();
                    String PathGrp = drGroupPath["PathSource"].ToString();
                    if (PathGrp.Length > 0)
                    {
                        oEasyViewLogGroup.ID = drGroupPath["PathSource"].ToString();
                        //Asocia el path History al grupo de Logs
                        EasyPathHistory oEasyPathHistory = new EasyPathHistory();
                        string[] PathItem = drGroupPath["PathSource"].ToString().Split('|');
                        List<string> list = PathItem.ToList();
                        list.Reverse();
                        foreach (string str in list)
                        {
                            EasyPathItem oEasyPathItem = new EasyPathItem();
                            oEasyPathItem.Id = str.Replace(" ", "");
                            oEasyPathItem.ClassName = "fa fa-venus-mars";
                            oEasyPathItem.Descripcion = "";
                            oEasyPathItem.Titulo = str;

                            oEasyPathHistory.PathCollections.Add(oEasyPathItem);
                        }
                        oEasyPathHistory.PathHome = true;
                        oEasyPathHistory.TipoPath = PathStyle.Basico;
                        oEasyViewLogGroup.PathHistory = oEasyPathHistory;
                    }
                    foreach (DataRow drElement in dtBase.Select("PathSource='" + PathGrp + "'")){
                        EasyItemLog oEasyItemLog = new EasyItemLog();
                                    oEasyItemLog.Id = drElement["ID_ACT_ELEM"].ToString();
                                    oEasyItemLog.Titulo = drElement["NOMBRE"].ToString();
                                    oEasyItemLog.Descripcion = drElement["DESCRIPCION"].ToString();
                                    oEasyItemLog.Tipo = ((this.IdTipoElemento == "4") ? TipoItemLog.danger : TipoItemLog.success);
                        oEasyViewLogGroup.LogItems.Add(oEasyItemLog);
                    }

                this.EasyViewLog1.LogGroupCollections.Add(oEasyViewLogGroup);
            }

            EasyViewLogButtom oEasyViewLogButtom = new EasyViewLogButtom();
            oEasyViewLogButtom.Id = "btnDel";
            oEasyViewLogButtom.Icono = "fa fa-trash";
            this.EasyViewLog1.ButtonCollections.Add(oEasyViewLogButtom);

            oEasyViewLogButtom = new EasyViewLogButtom();
            oEasyViewLogButtom.Id = "btnAdjunto";
            oEasyViewLogButtom.Icono = "fa fa-paperclip";
            this.EasyViewLog1.ButtonCollections.Add(oEasyViewLogButtom);

            oEasyViewLogButtom = new EasyViewLogButtom();
            oEasyViewLogButtom.Id = "btnCalendar";
            oEasyViewLogButtom.Icono = "fa fa-calendar";
            this.EasyViewLog1.ButtonCollections.Add(oEasyViewLogButtom);

      
            this.EasyViewLog1.fncItembtnOnClick = "ViewLog_ItemLog_ToolBar";
            this.EasyViewLog1.Titulo = this.NombreElemento;
            this.EasyViewLog1.fcToolBarOnClick = "EasyViewLog1_onToolBarClick  ";
        }
        public void LlenarDatos2()
        {
            //<cc2:EasyViewCard ID="EasyViewCard1" runat="server"></cc2:EasyViewCard>
            DataTable dtBase = ObtenerDatos();
            int IdGrp = 0;
            DataTable dtGroupPath = EasyUtilitario.Helper.Data.SelectDistinct(dtBase, "PathSource");
            foreach (DataRow drGroupPath in dtGroupPath.Rows)
            {
                EasyViewCardGroup oEasyViewCardGroup = new EasyViewCardGroup();
                oEasyViewCardGroup.ID = "grp_" + IdGrp.ToString();

                String PathGrp = drGroupPath["PathSource"].ToString();
                if (PathGrp.Length > 0)
                {
                    //Asocia el path History al grupo de Logs
                    EasyPathHistory oEasyPathHistory = new EasyPathHistory();
                    string[] PathItem = drGroupPath["PathSource"].ToString().Split('|');
                    List<string> list = PathItem.ToList();
                    list.Reverse();
                    foreach (string str in list)
                    {
                        EasyPathItem oEasyPathItem = new EasyPathItem();
                        oEasyPathItem.Id = str.Replace(" ", "");
                        oEasyPathItem.ClassName = "fa fa-venus-mars";
                        oEasyPathItem.Descripcion = "";
                        oEasyPathItem.Titulo = str;

                        oEasyPathHistory.PathCollections.Add(oEasyPathItem);
                    }
                    oEasyPathHistory.PathHome = true;
                    oEasyViewCardGroup.PathHistory = oEasyPathHistory;
                }
                
                foreach (DataRow drElement in dtBase.Select("PathSource='" + PathGrp + "'"))
                {
                    EasyCard oEasyCard = new EasyCard();
                    oEasyCard.fcOnEventCard = "EventCards";
                    oEasyCard.JsonData = "{Id:'" + drElement["ID_ACT_ELEM"].ToString() + "',Descripcion:'" + drElement["DESCRIPCION"].ToString() + "'}";
                    oEasyCard.ID = oEasyViewCardGroup.ID + "_" + drElement["ID_ACT_ELEM"].ToString();//.Replace("-","_");
                    oEasyCard.Titulo = drElement["NOMBRE"].ToString();
                    //Descripcion de entrada
                    EasyCardBaseContenido oEasyCardBaseContenido = new EasyCardBaseContenido();
                        oEasyCardBaseContenido.Icono = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAfCAMAAACxiD++AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAA/UExURQAAANDg6jCU0KbN5H+63SePztzc3FtbWTo6OPHx8fn5+fr6+h6LzfDw8PPz8/b29kSd0+Xl5Xl5d3p6eAAAAF+Gn94AAAAVdFJOU///////////////////////////ACvZfeoAAAAJcEhZcwAADsMAAA7DAcdvqGQAAACLSURBVDhPldLLDoQgDIXhEbwUsHjr+z/rTCM4jZLY/hvSnG/hwg+9JEDXOed9Oa4sgKjvh8H7cZwmKFlBJSHEmH4pwXzPOcScDQBl7W8oI9cEAHwsy322gRhDQFxXOdtAJXK2AiY5y9kOnukBl9K2/X+Umg5wADzv+3nJ9KA9W0B71oPjON9nL4DoC5BCNqUazEZGAAAAAElFTkSuQmCC";//"https://img.icons8.com/color/26/000000/christmas-star.png";
                    oEasyCardBaseContenido.Comentario = drElement["DESCORG"].ToString();
                    oEasyCardBaseContenido.IconoStatus = "fa fa-users text-muted"; //"vl mr-2 ml-0";
                        oEasyCardBaseContenido.FechaHoraStatus = DateTime.Now.ToShortTimeString();
                    oEasyCard.Contenido.Add(oEasyCardBaseContenido);
                    //Descripcion de Salida
                    oEasyCardBaseContenido = new EasyCardBaseContenido();
                        oEasyCardBaseContenido.Icono = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAfCAMAAACxiD++AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAzUExURQAAALHW6zGV0dnp863U6yiQz4S/4vr6+jo6OLXY7B6LzeXl5VxcWltbWXx8en19ewAAAGP16eQAAAARdFJOU/////////////////////8AJa2ZYgAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAIJJREFUOE+9kkEOgCAMBBVBUED4/2sV20RqTVwvzgW2OwcgDPWFUxhHY6bpzApEsNa5efaeBkEgBIIb5hCWpa8lmGDMquAeFOQRJZhwv2YPKsRobXtqnnagQkqcFagQAmfFn0LD+xhzpv0FJtBPbPW2UerBhef6i/Bc40IptGpehFp34bMpY++z24QAAAAASUVORK5CYII="; 
                    oEasyCardBaseContenido.Comentario = drElement["DESCRIPCION"].ToString();
                    oEasyCardBaseContenido.IconoStatus = "fa fa-users text-muted";
                        oEasyCardBaseContenido.FechaHoraStatus = DateTime.Now.ToShortTimeString();
                    oEasyCard.Contenido.Add(oEasyCardBaseContenido);

                    #region PanelUsers
                    EasyPanelUsers oEasyPanelUsers = new EasyPanelUsers();
                            oEasyPanelUsers.ID = "PanellstUser";
                            EasyUserButton oEasyUserButton = new EasyUserButton();
                            oEasyUserButton.Id = "btn5732";
                            oEasyUserButton.ApellidosyNombres = "Rosales Azabache Eddy";
                            oEasyUserButton.PathImagen = this.PathFotosPersonal + "18018828.jpg";
                            oEasyPanelUsers.ButtonCollections.Add(oEasyUserButton);
                            oEasyPanelUsers.fncItemOnClick = "demo";
                     oEasyCard.Panel = oEasyPanelUsers;
                    #endregion
                    #region ToolBarCard
                        EasyCardToolBar oToolBar = new EasyCardToolBar();
                        oToolBar.fncToolBaOnClick = "ToolBarCarOnClick";
                        oToolBar.ID = oEasyCard.ID + "_ToolBar";
                        EasyCardButton oEasyCardButton = new EasyCardButton();
                            oEasyCardButton.Id = "btnSrttng";
                            oEasyCardButton.Titulo = "SETTINGS";
                            oEasyCardButton.Icono = "https://img.icons8.com/ios/50/000000/settings.png";
                            oEasyCardButton.TipoBoton = EasyControlWeb.Form.Base.EasyButtonType.button;
                        oToolBar.ButtonCollections.Add(oEasyCardButton);

                        oEasyCardButton = new EasyCardButton();
                        oEasyCardButton.Id = "btnLink";
                        oEasyCardButton.Titulo = "PROGRAM LINK";
                        oEasyCardButton.Icono = "https://img.icons8.com/metro/26/000000/link.png";
                        oEasyCardButton.TipoBoton = EasyControlWeb.Form.Base.EasyButtonType.button;
                        oToolBar.ButtonCollections.Add(oEasyCardButton);

                        oEasyCardButton = new EasyCardButton();
                        oEasyCardButton.Id = "btnMas";
                        oEasyCardButton.Titulo = "MORE";
                        oEasyCardButton.Icono = "https://img.icons8.com/metro/26/000000/more.png";
                        oEasyCardButton.TipoBoton = EasyControlWeb.Form.Base.EasyButtonType.button;
                        oToolBar.ButtonCollections.Add(oEasyCardButton);

                        oEasyCardButton = new EasyCardButton();
                        oEasyCardButton.TipoBoton = EasyControlWeb.Form.Base.EasyButtonType.Separador;
                        oToolBar.ButtonCollections.Add(oEasyCardButton);

                    oEasyCard.ToolBar = oToolBar;
                    #endregion
                    
                    oEasyViewCardGroup.CardItems.Add(oEasyCard);
                }
                IdGrp++;

              //  this.EasyViewCard1.Titulo= this.NombreElemento;
              //  this.EasyViewCard1.CardGroupCollections.Add(oEasyViewCardGroup);
            }




        }

        DataTable ObtenerDatos() {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
            odi.Metodo = "ActividadElementos_Listar";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdActividad";
            oParam.Paramvalue = this.IdActividad;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTipoElemento";
            oParam.Paramvalue = this.IdTipoElemento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetDataTable();
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            throw new NotImplementedException();
        }

        public void RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        public bool ValidarDatos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }

       
    }
}