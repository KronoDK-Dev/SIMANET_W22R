<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarDetalleAccion.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.ITIL.AdministrarDetalleAccion" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
 <!--rEFERENCIA:  https://getbootstrap.com/docs/4.5/components/navs/#tabs-->



    
	<style>
		.card {
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 0 solid transparent;
    border-radius: 0;
}
.card {
    margin-bottom: 30px;
}
.card-body {
    flex: 1 1 auto;
    padding: 1.57rem;
}

 .note-has-grid .nav-link {
     padding: .5rem
 }

 .note-has-grid .single-note-item .card {
     border-radius: 10px
 }

 .note-has-grid .single-note-item .favourite-note {
     cursor: pointer
 }

 .note-has-grid .single-note-item .side-stick {
     position: absolute;
     width: 3px;
     height: 35px;
     left: 0;
     background-color: rgba(82, 95, 127, .5)
 }

 .note-has-grid .single-note-item .category-dropdown.dropdown-toggle:after {
     display: none
 }

 .note-has-grid .single-note-item .category [class*=category-] {
     height: 15px;
     width: 15px;
     display: none
 }

 .note-has-grid .single-note-item .category [class*=category-]::after {
     content: "\f0d7";
     font: normal normal normal 14px/1 FontAwesome;
     font-size: 12px;
     color: #fff;
     position: absolute
 }

 .note-has-grid .single-note-item .category .category-business {
     background-color: rgba(44, 208, 126, .5);
     border: 2px solid #2cd07e
 }

 .note-has-grid .single-note-item .category .category-social {
     background-color: rgba(44, 171, 227, .5);
     border: 2px solid #2cabe3
 }

 .note-has-grid .single-note-item .category .category-important {
     background-color: rgba(255, 80, 80, .5);
     border: 2px solid #ff5050
 }

 .note-has-grid .single-note-item.all-category .point {
     color: rgba(82, 95, 127, .5)
 }

 .note-has-grid .single-note-item.note-business .point {
     color: rgba(44, 208, 126, .5)
 }

 .note-has-grid .single-note-item.note-business .side-stick {
     background-color: rgba(44, 208, 126, .5)
 }

 .note-has-grid .single-note-item.note-business .category .category-business {
     display: inline-block
 }

 .note-has-grid .single-note-item.note-favourite .favourite-note {
     color: #ffc107
 }

 .note-has-grid .single-note-item.note-social .point {
     color: rgba(44, 171, 227, .5)
 }

 .note-has-grid .single-note-item.note-social .side-stick {
     background-color: rgba(44, 171, 227, .5)
 }

 .note-has-grid .single-note-item.note-social .category .category-social {
     display: inline-block
 }

 .note-has-grid .single-note-item.note-important .point {
     color: rgba(255, 80, 80, .5)
 }

 .note-has-grid .single-note-item.note-important .side-stick {
     background-color: rgba(255, 80, 80, .5)
 }

 .note-has-grid .single-note-item.note-important .category .category-important {
     display: inline-block
 }

 .note-has-grid .single-note-item.all-category .more-options,
 .note-has-grid .single-note-item.all-category.note-favourite .more-options {
     display: block
 }

 .note-has-grid .single-note-item.all-category.note-business .more-options,
 .note-has-grid .single-note-item.all-category.note-favourite.note-business .more-options,
 .note-has-grid .single-note-item.all-category.note-favourite.note-important .more-options,
 .note-has-grid .single-note-item.all-category.note-favourite.note-social .more-options,
 .note-has-grid .single-note-item.all-category.note-important .more-options,
 .note-has-grid .single-note-item.all-category.note-social .more-options {
     display: none
 }

 @media (max-width:767.98px) {
     .note-has-grid .single-note-item {
         max-width: 100%
     }
 }

 @media (max-width:991.98px) {
     .note-has-grid .single-note-item {
         max-width: 216px
     }
 }
	</style>

    <!--referencia: https://bbbootstrap.com/snippets/notes-board-89289866-->

<script>
    EasyControl.ViewNotes = function (_Id) {
        var NameContentNotas = "note-full-container_";
        var Me = this;
        this.ItemplateNoteGrid = function () {
            //Toobar de ViewNote
            var BtnToolBarView = "";
            Me.ToolBar.forEach(function (Ibtn, b) {
                var htmlBtnBE = "".toString().BaseSerialized(Ibtn).toString().Replace(SIMA.Utilitario.Constantes.Caracter.Comilla, SIMA.Utilitario.Constantes.Caracter.ComillaSimle);
                BtnToolBarView += '                <li class="nav-item ml-auto">'
                                + '                     <a href = "javascript:void(0);" IdPadre="' + _Id + '"  Data="' + htmlBtnBE + '"  class="nav-link btn-primary rounded-pill d-flex align-items-center px-3 ' + _Id + '" id = "' + _Id + '_btn_' + Ibtn.Id + '">'
                                + '                         <i class="icon-note m-1"></i><span class="d-none d-md-block font-14">' + Ibtn.Texto + '</span>'
                                + '                     </a>'
                                + '                </li>';
            });
            //Buttons de Cada Nota
            var HtmlCollectionNote = "";
            Me.CollectionsNote.forEach(function (oNote,n) {
                HtmlCollectionNote += Me.ItemplateNote(oNote);
            });
            return ('<div id="EasyViewNote_' + _Id + '" class="page-content container note-has-grid" style="background-color:#EDF1F5">'
                + '     <ul class="nav nav-pills p-3  mb-3 rounded-pill align-items-center"  style="background-color: transparent;">'
                + BtnToolBarView
                + '     </ul>'
                + '     <div class="tab-content bg-transparent">'
                + '         <div id = "' + NameContentNotas + _Id +'" class="note-has-grid row">'
                + HtmlCollectionNote
                + '         </div>'
                + '     </div>'
                + '</div>').toString().HtmlToDOMobj();
        }
        this.ItemplateNote = function (oNote) {
            var HtmlNoteBE = "".toString().BaseSerialized(oNote).toString().Replace(SIMA.Utilitario.Constantes.Caracter.Comilla, SIMA.Utilitario.Constantes.Caracter.ComillaSimle); 
            var HtmlToolNote = "";
            Me.ButtonsNote.forEach(function (ItemBtnNote, n) {
                            var HtmlItemBtnNoteBE = "".toString().BaseSerialized(ItemBtnNote).toString().Replace(SIMA.Utilitario.Constantes.Caracter.Comilla, SIMA.Utilitario.Constantes.Caracter.ComillaSimle); 
                HtmlToolNote += '              <span style=" margin-left: ' + ((n == 0) ? "0" : "5") + 'px;cursor:pointer;"  class="mr-1 ' + _Id + '" IdPadre="' + _Id + '"  DataNota="' + HtmlNoteBE + '"  Data="' + HtmlItemBtnNoteBE  + '" ><i id="' + _Id + '_btn_' + ItemBtnNote.Id + '" class="' + ItemBtnNote.Icono + '"></i></span>';
                        });

            return '<div id="' + _Id + '_' + oNote.Id + '" class="col-md-4 single-note-item all-category ' + oNote.ClassTipo + '" >'
                + '      <div class="card card-body">'
                + '          <span class="side-stick"></span>'
                + '          <h5 class="note-title text-truncate w-75 mb-0" data-noteheading="' + oNote.Titulo + '">' + oNote.Titulo + '<i class= "point fa fa-circle ml-1 font-10"></i></h5>'
                + '          <p class="note-date font-12 text-muted">' + oNote.Fecha + '</p>'
                + '          <div class="note-content">'
                + '              <p class="note-inner-content text-muted" data-notecontent="."> ' + oNote.Descripcion + '</p>'
                + '          </div>'
                + '          <div class="d-flex align-items-center">'
                +               HtmlToolNote 
                + '          </div>'
                + '      </div>'
                + ' </div>';
        }
        /*Colleccion de Notas*/
        this.CollectionsNote = new Array();
        /*ToolBar */
        this.ToolBar = new Array();

        this.Buttons = function (_ID, _ICONO, _TEXTO) {
            this.Id = _ID;
            this.Icono = _ICONO;
            this.Texto = _TEXTO;
        }        
        this.ButtonsNote = new Array();

        /*Item Note*/
        this.Nota = function (_ID, _TITULO, _DESCRIPCION, _FECHA, _CLASSTIPO) {
            this.Id = _ID;
            this.Titulo = _TITULO;
            this.Descripcion = _DESCRIPCION;
            this.Fecha = _FECHA;
            this.ClassTipo = _CLASSTIPO;
        }
        /*Eventos*/
        this.fncToolBarButonClick = null;
        this.fncNotaButonClick = null;
        /*Metodos*/
        this.NewNota = function (oNote) {
            Me.CollectionsNote.Add(oNote);
            //Pintar la Nota en el View Panel
            var _ContenedorNotas = jNet.get(NameContentNotas + _Id);
            var ohtmlNote = jNet.get(Me.ItemplateNote(oNote).toString().HtmlToDOMobj());
            _ContenedorNotas.insert(ohtmlNote);
            EventListener();
        }
        this.UpdateNota = function (oNote) {
            Me.DeleteNota(oNote.Id);
            Me.NewNota(oNote);

        }
        this.DeleteNota = function (oNota) {
            var idx = 0;
            var oNotaDel = null;
            var IdFind = null;
            if (typeof oNota === 'string') {
                IdFind = oNota;
            }
            else {
                IdFind = oNota.Id;
            }

            Me.CollectionsNote.forEach(function (oNotaAct, n) {
                if (oNotaAct.Id == IdFind) {//En caso oNota sea el ID
                    oNotaDel = oNotaAct;
                    idx = n;
                }
            });
            var ohtmlNote = jNet.get(_Id + '_' + oNotaDel.Id);
            var _ContenedorNotas = jNet.get(NameContentNotas + _Id);
            _ContenedorNotas.remove(ohtmlNote);
            //Elimina de la collecion
            Me.CollectionsNote.Remove(idx);
        }

        this.Render = function (Content) {
            var oWrite = jNet.get(Content);
            var oView = Me.ItemplateNoteGrid();
            //alert(oView);
            oWrite.insert(oView);
            //Para los botones del toolbar del ViewNote
            [].slice.call(document.getElementsByClassName('nav-link btn-primary rounded-pill d-flex align-items-center px-3 ' + _Id)).forEach(function (ctrlBtn, i){
                var oCtrl = jNet.get(ctrlBtn);
                    if (oCtrl.attr("IdPadre")==_Id) {
                        oCtrl.addEvent("click", function () {
                            var Yo = jNet.get(this);
                            if (Me.fncToolBarButonClick != null) {
                                  Me.fncToolBarButonClick(Yo.attr("Data").toString().SerializedToObject());
                            }
                        });
                    }
            });
            //Asignacion de eventos a los controles
            EventListener();
            
        }
        function EventListener() {
            //Para los botones de la Nota
            [].slice.call(document.getElementsByClassName('mr-1 ' + _Id)).forEach(function (ctrlBtn, i) {
                var oCtrl = jNet.get(ctrlBtn);
                if (oCtrl.attr("IdPadre") == _Id) {
                    oCtrl.addEvent("click", function () {
                        var Yo = jNet.get(this);
                        if (Me.fncNotaButonClick != null) {
                            Me.fncNotaButonClick(Yo.attr("DataNota").toString().SerializedToObject(), Yo.attr("Data").toString().SerializedToObject());
                        }
                    });
                }
            });
        }
    }
   
</script>
  
</head>

<body>
    <form id="form1" runat="server">
        <!--inicio-->
        <table style="width:100%;">
            <tr>
                <td id="CNNOte" style="width:100%">

                </td>
            </tr>
        </table>
        <!--Fin-->
    </form>


    <script>

        AdministrarDetalleAccion.Data = {};
        AdministrarDetalleAccion.Data.ListarNotas = function (IdAccion) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/ITIL/GestiondeConfiguracion.asmx";
            oEasyDataInterConect.Metodo = "ProcedimientoNotaListarPorAccion";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdAccion", IdAccion);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("IdNota", "0");
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }

        AdministrarDetalleAccion.Data.Eliminar = function (IdNota) {
            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdNota", IdNota);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
            oParamCollections.Add(oParam);
            oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
            oParamCollections.Add(oParam);

            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + 'HelpDesk/ITIL/GestiondeConfiguracion.asmx';
            oEasyDataInterConect.Metodo = 'ProcedimientoNotaDel';
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            var obj = oEasyDataResult.sendData();
            return 1;
        }


        AdministrarDetalleAccion.Detalle = {};
        AdministrarDetalleAccion.Detalle.Show = function (Modo,IdNota) {
            var urlPag = Page.Request.ApplicationPath + "/HelpDesk/ITIL/DetalledeNota.aspx";
            var oColletionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(AdministrarActividadProcedimiento.KEYMODOPAGINA, Modo);
            oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarDetalleAccion.KEYIDACCCION, AdministrarDetalleAccion.Params[AdministrarDetalleAccion.KEYIDACCCION]);
            oColletionParams.Add(oParam);


            oParam = new SIMA.Param(AdministrarActividadProcedimiento.KEYIDNOTA, IdNota);
            oColletionParams.Add(oParam);

            EasyPopupProcedimientoDetalleNota.Titulo = "Detalle de Nota";
            EasyPopupProcedimientoDetalleNota.Load(urlPag, oColletionParams, false);
        }

        var oViewNotes = new EasyControl.ViewNotes("VN1");
        //Botones de la Barra de Herramientas
        var oBtn = new oViewNotes.Buttons("btnNew", "", "Nueva Nota");
        oViewNotes.ToolBar.Add(oBtn);
        //Botones de las Notas
        var oBtnNote = new oViewNotes.Buttons("btnDetalle", "fa fa-pencil");
        oViewNotes.ButtonsNote.Add(oBtnNote);
        oBtnNote = new oViewNotes.Buttons("btnDelete", "fa fa-trash remove-note");
        oViewNotes.ButtonsNote.Add(oBtnNote);

        AdministrarDetalleAccion.Data.ListarNotas(AdministrarDetalleAccion.Params[AdministrarDetalleAccion.KEYIDACCCION]).Rows.forEach(function (oDataRow,r) {
            var oNote = new oViewNotes.Nota(oDataRow["ID_NOTA"], oDataRow["TITULO"], oDataRow["DESCRIPCION"], oDataRow["FECHA_ADD"], oDataRow["NOMBRETIPONOTA"]);
            oViewNotes.CollectionsNote.Add(oNote);
        })

        oViewNotes.fncToolBarButonClick = function (oBtn) {
            AdministrarDetalleAccion.Detalle.Show(SIMA.Utilitario.Enumerados.ModoPagina.N, "0");
        }

        oViewNotes.fncNotaButonClick = function (oNota, oBtn) {
            switch (oBtn.Id) {
                case "btnDetalle":
                    AdministrarDetalleAccion.Detalle.Show(SIMA.Utilitario.Enumerados.ModoPagina.M, oNota.Id);
                    
                    break;
                case "btnDelete": 
                    var ConfigMsgb = {
                        Titulo: 'ELIMINAR NOTA'
                        , Descripcion: 'Desea Eliminar esta nota ahora?'
                        , Icono: 'fa fa-tag'
                        , EventHandle: function (btn) {
                            if (btn == 'OK') {
                                AdministrarDetalleAccion.Data.Eliminar(oNota.Id);
                                oViewNotes.DeleteNota(oNota);
                            }
                        }
                    };
                    var oMsg = new SIMA.MessageBox(ConfigMsgb);
                    oMsg.confirm();
                    break;
            }
        }

        oViewNotes.Render("CNNOte");







    </script>
</body>
</html>
