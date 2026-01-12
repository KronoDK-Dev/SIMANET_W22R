<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarStakeHolders.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Sistemas.AdministrarStakeHolders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <style>
     
            .card {
                margin-bottom: 24px;
                box-shadow: 0 2px 3px #e4e8f0;
            }
            .card {
                position: relative;
                display: flex;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 1px solid #eff0f2;
                border-radius: 1rem;
            }
            .avatar-md {
                height: 4rem;
                width: 4rem;
            }
            .rounded-circle {
                border-radius: 50%!important;
            }
            .img-thumbnail {
                padding: 0.25rem;
                background-color: #f1f3f7;
                border: 1px solid #eff0f2;
                border-radius: 0.75rem;
            }
            .avatar-title {
                align-items: center;
                background-color: #3b76e1;
                color: #fff;
                display: flex;
                font-weight: 500;
                height: 100%;
                justify-content: center;
                width: 100%;
            }
            .bg-soft-primary {
                background-color: rgba(59,118,225,.25)!important;
            }
            a {
                text-decoration: none!important;
            }
            .badge-soft-danger {
                color: #f56e6e !important;
                background-color: rgba(245,110,110,.1);
            }
            .badge-soft-success {
                color: #63ad6f !important;
                background-color: rgba(99,173,111,.1);
            }
            .mb-0 {
                margin-bottom: 0!important;
            }
            .badge {
                display: inline-block;
                padding: 0.25em 0.6em;
                font-size: 75%;
                font-weight: 500;
                line-height: 1;
                color: #fff;
                text-align: center;
                white-space: nowrap;
                vertical-align: baseline;
                border-radius: 0.75rem;
            }
   </style>


    


 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css" integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous" />



    <style>
        .float-end {
            float: right !important;
        }

        .dropdown, .dropend, .dropstart, .dropup {
            position: relative;
        }
        *, ::after, ::before {
            box-sizing: border-box;
        }
        .dropdown-menu.show {
            display: block;
        }
        .dropdown-menu-end {
            --bs-position: end;
        }

        *, ::after, ::before {
            box-sizing: border-box;
        }

    </style>

    
  <!--  referencia: https://www.bootdey.com/snippets/view/Contacts-Grid-Cards#css
        -->
<script>
    EasyControl.EasyCardInfoAdicional = function (ICONO, DESCRIPCION) {
        this.Icono = ICONO;
        this.Descripcion = DESCRIPCION;
    }

    EasyControl.EasyCard = function (ID, CLASSTIPO, FOTO, NOMBRES, TIPO) {
        this.Id = ID;       
        this.ClassTipo = CLASSTIPO;
        this.Foto = FOTO;
        this.Nombres = NOMBRES;
        this.Tipo= TIPO;
        this.ColleccionInfo = new Array();
    }
    EasyControl.EasyCardMenuItem = function (ID, ICONO, DESCRIPCION,COLOR) {
        this.Id = ID;
        this.Icono = ICONO;
        this.Descripcion = DESCRIPCION;
        this.Color = COLOR;
    }


    EasyControl.EasyCardView = function (_Id, Content) {
        var Me = this;
        this.Id = _Id;
        this.Titulo = '';
        this.ToolBar = new Array();
        this.ToolBar.Buttom = function (ID, ICONO, DESCRICION) {
            this.Id = ID;
            this.Icono = ICONO;
            this.Descripcion = DESCRICION;
        }
        this.ToolBar.onclick = null;
        /*Btns Card*/
        this.BtnPrimario;
        this.BtnSecundario;
        //Eventos
        this.onBtnClick = null;

        /*Menu Card */
        this.MenuItems = new Array();
        this.onMenuItemClick = null;

        /*Region Colleciones */
        this.Cards = new Array();

        this.ItemplateItemCard = function (oItemCard) {
            var htmlCards = "";
            var htmlInfo = "";
                oItemCard.ColleccionInfo.forEach(function (oInfo, i) {
                    var sclass = ((i == 0) ? "" : " mt-2");
                    htmlInfo += ' <p class="text-muted' + sclass + '"><i class="' + oInfo.Icono + ' font-size-15 align-middle pe-2 text-primary"></i> ' + oInfo.Descripcion + '</p>';
                });

            var htmlItemMenu="";
            this.MenuItems.forEach(function (oItemMenu, m) {
                var SerializeItemMenu = "".toString().BaseSerialized(oItemMenu).toString().Replace(SIMA.Utilitario.Constantes.Caracter.Comilla, SIMA.Utilitario.Constantes.Caracter.ComillaSimle);
                htmlItemMenu += '                         <a class="dropdown-item" href="#"  IdCard="' + oItemCard.Id + '" Data="' + SerializeItemMenu + '"  ><i class="' + oItemMenu.Icono + ' font-size-15 align-middle pe-2 text-primary"></i> ' + oItemMenu.Descripcion + '</a>';
            });

            var ddlMenuActivo = ' <span id="btnPopup_' + oItemCard.Id + '" IdCard="'+  oItemCard.Id + '" Status="Close"  Name="btnCardPopup_'+ _Id +'" class="text-muted dropdown-toggle font-size-16" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="cursor: pointer;">'
                                    + '                         <i class="bx bx-dots-horizontal-rounded"></i>'
                                    + '                       ...</span>';

                var btnsCard = "";
            if (this.BtnPrimario.Visible == true) {
                       btnsCard += '              <button type="button"  IdCard="' +  oItemCard.Id + '" Tipo="Primario" class="btn btn-soft-primary btn-sm w-50"><i class="' + this.BtnPrimario.Icono + ' me-1" style="color:gray;width:25px" ></i> ' + this.BtnPrimario.Text + '</button>'
                }
                if (this.BtnSecundario.Visible == true) {
                    btnsCard += '                 <button type="button"  IdCard="' +  oItemCard.Id + '" Tipo="Secundario"  class="btn btn-primary btn-sm w-50"><i class="' + this.BtnSecundario.Icono + ' me-1"></i> ' + this.BtnSecundario.Text + '</button>'
                }

            var NomMenuPopup = _Id + '_mnuP_' + oItemCard.Id;
                htmlCards += ' <div class="card" id="' + _Id + '_' + oItemCard.Id + '">'
                            + '             <div class="card-body">'
                            + '                 <div class="dropdown float-end">'
                            + ddlMenuActivo 
                            + '                     <div  id= "' + NomMenuPopup + '" IdCard="' +  oItemCard.Id + '" name="MnuOP_'+ _Id +'"    class="dropdown-menu dropdown-menu-end" >'
                            + htmlItemMenu
                            + '                     </div>'             
                            + '                 </div>'
                            + '                 <div class="d-flex align-items-center">'
                            + '                     <div>'
                            + '                         <img src = "' + oItemCard.Foto + '" alt = "" class="avatar-md rounded-circle img-thumbnail" />'
                            + '                     </div> '
                            + '                     <div class="flex-1 ms-3">'
                            + '                         <h5 class="font-size-16 mb-1"><a href="#" class="text-dark">' + oItemCard.Nombres + '</a></h5>'
                            + '                         <span class="badge ' + ((oItemCard.ClassTipo == null) ? 'badge-soft-success' : oItemCard.ClassTipo) +' mb-0" style="text-transform: capitalize;">' + oItemCard.Tipo + '</span>'
                            + '                     </div>'
                            + '                 </div>'
                            + '                 <div class="mt-3 pt-1">'
                            + htmlInfo
                            + '                 </div>'
                            + '                 <div name="EasyToolbtnCard_' + _Id +'" class="d-flex gap-2 pt-4">'
                            + btnsCard
                            + '                 </div>'
                            + '         </div>'
                            + '</div>';
            
            var htmlCardResult = '<div class="col-xl-3 col-sm-6">'
                            + htmlCards
                            + '</div>';

            return htmlCardResult;
        }

        /*Ini Elementos Header*/
        this.ITemplaTitulo = function (NroItems) {
            var htmlTitle = '<div class="col-md-6">'
                            +'     <div class="mb-3">'
                            + '         <h5 class="card-title">' + Me.Titulo + '<span class="text-muted fw-normal ms-2">(' + NroItems + ')</span></h5>'
                            +'      </div>'
                            + '</div>'
            return htmlTitle;
        }
        this.ITemplateTooBar = function () {
            var htmlButton = "";
            this.ToolBar.forEach(function (oButtons, b) {
                var btnSerialized = "".toString().BaseSerialized(oButtons).toString().Replace(SIMA.Utilitario.Constantes.Caracter.Comilla, SIMA.Utilitario.Constantes.Caracter.ComillaSimle);
                htmlButton += '          <a href="#" id="' + _Id + '_' + oButtons.Id + '"  data-bs-toggle="modal" data-bs-target=".add-new" class="btn btn-primary"  Data="' + btnSerialized + '"><i class="' + oButtons.Icono + ' me-1"></i> ' + oButtons.Descripcion  + '</a>';
            });

            var htmlToolBar = '<div class="col-md-6">'
                            +'   <div id="EasyToolBar_' + _Id + '" class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">'
                            +'       <div>'
                            //+'          <a href="#" data-bs-toggle="modal" data-bs-target=".add-new" class="btn btn-primary"><i class="fa fa-plus me-1"></i> Add New</a>'
                            + htmlButton
                            +'       </div>'
                            +'   </div>'
                            + '</div>';
            return htmlToolBar;
         }
        /*Fin Elementos Header*/

        this.Header = function () {
            var htmlHeader = ' <div class="row align-items-center">'
                            + this.ITemplaTitulo(Me.Cards.length)
                            + this.ITemplateTooBar()
                            + ' </div>';
            return htmlHeader;
        }
        this.Body = function () {
            var htmlCards = "";
            this.Cards.forEach(function (oCard, c) {
                htmlCards += Me.ItemplateItemCard(oCard);
            });

            var htmlBody = '<div id="Body_'+ _Id +'" class="row">'
                            + htmlCards
                         + '</div>';
            return htmlBody;
        }

        this.Remove = function (IdCard) {
            var CardsView = jNet.get("Body_" + _Id);
            var oCard = jNet.get(_Id + "_" + IdCard);
            CardsView.remove(oCard);
        }

        this.Render = function () {
            var htmlCardManager = ' <div id="'+ _Id +'" class="container">'
                                    + Me.Header()
                                    + Me.Body()
                                    + ' </div>';

            var oEasyViewCard = htmlCardManager.toString().HtmlToDOMobj();
            //Limpia el caesView
            var ContentCardView = jNet.get(Content);
            ContentCardView.clear();
            ContentCardView.insert(oEasyViewCard);
            //Asociar eventos
            [].slice.call(document.getElementsByName("btnCardPopup_" + _Id)).forEach(function (btnPopupMenu, r) {
                var obtnPopupCard = jNet.get(btnPopupMenu);
                obtnPopupCard.addEvent("click", function () {
                    var Yo = jNet.get(this);
                    var IdCard = Yo.attr('IdCard');       
                    var MnuId = _Id +"_mnuP_" + IdCard;

                    //Buscar Todas la opciones de menu para inactivar
                    [].slice.call(document.getElementsByName("MnuOP_" + _Id)).forEach(function (MnuPopup, m) {
                        var oMenuPopupClose = jNet.get(MnuPopup);
                        oMenuPopupClose.attr("class", "dropdown-menu dropdown-menu-end");
                    });

                    var oMenuPopup = jNet.get(MnuId);
                    if (Yo.attr("Status") == "Close") {
                        Yo.attr("Status", "Open");
                        oMenuPopup.attr("class", "dropdown-menu dropdown-menu-end show")
                                    .attr("data-popper-placement", "bottom-end")
                                    .css("position", "absolute")
                                    .css("inset", "0px 0px auto auto")
                                    .css("margin", "0px")
                                    .css("transform", "translate(0px, 24px)");
                        
                    }
                    else {
                        Yo.attr("Status", "Close");
                        oMenuPopup.attr("class", "dropdown-menu dropdown-menu-end");
                    }

                });
            });
            //Asociar a los items de menu el evento click
            [].slice.call(document.getElementsByName("MnuOP_" + _Id)).forEach(function (PopupMenu, m) {
                     var oPopupMenu = jNet.get(PopupMenu);
                     [].slice.call(oPopupMenu.children).forEach(function (ItemMenu, i) {
                         var oMnuItem = jNet.get(ItemMenu);
                         oMnuItem.attr("IdCard", oPopupMenu.attr("IdCard"));
                         var oMenuPopup = jNet.get(oMnuItem.parentNode)
                         oMnuItem.addEvent("click", function () {
                             oMenuPopup.attr("class", "dropdown-menu dropdown-menu-end");
                             var oitem = jNet.get(this);
                             var DataBE = oitem.attr("Data");
                             var oItemMenu = DataBE.toString().SerializedToObject();
                             Me.onMenuItemClick(oitem.attr("IdCard"),oItemMenu);//Llama al evento asociado en la instacia de la clase CardsView
                         });
                     });
             });
            //Evento btn Cards
            [].slice.call(document.getElementsByName("EasyToolbtnCard_"+_Id)).forEach(function (ToolBtnCards, m) {
                var oToolBtnCards = jNet.get(ToolBtnCards);
                [].slice.call(oToolBtnCards.children).forEach(function (btnCard, i) {
                    var obtnCard = jNet.get(btnCard);
                    obtnCard.addEvent("click", function () {
                        var obtn = jNet.get(this);
                        Me.onBtnClick({ IdCard: obtn.attr("IdCard"), Tipo: obtn.attr("Tipo") });//Llama al evento asociado en la instacia de la clase CardsView
                    });
                });
            });

            //Evento toolbar CardView
            [].slice.call(document.getElementById("EasyToolBar_" + _Id).children[0].children).forEach(function (btn, b) {
                var obtn = jNet.get(btn);
                obtn.addEvent("click", function () {
                    var ObjectBtn = this.attr('Data').toString().SerializedToObject();
                    Me.ToolBar.onclick(ObjectBtn);
                });
                
            });

            

        }
    }
</script>
    


</head>
<body>
    <form id="form1" runat="server">
       
   </form>


    <script>

        AdministrarStakeHolders.Data = {};
        AdministrarStakeHolders.Data.ListarStakeHolders = function (IdTipoSH) {
            var oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
            oEasyDataInterConect.Metodo = "ActividadElementos_StakeHolder";

            var oParamCollections = new SIMA.ParamCollections();
            var oParam = new SIMA.Param("IdActElemento", AdministrarStakeHolders.Params[AdministrarStakeHolders.KEYIDACTIVIDAD]);
            oParamCollections.Add(oParam);

            oParam = new SIMA.Param("IdTipoStakeHolder", IdTipoSH, TipodeDato.Int);
            oParamCollections.Add(oParam);
            
            oParam = new SIMA.Param("UserName", UsuarioBE.UserName);
            oParamCollections.Add(oParam);
            oEasyDataInterConect.ParamsCollection = oParamCollections;

            var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
            return oEasyDataResult.getDataTable();
        }

        var IdTipoSH = AdministrarStakeHolders.Params[AdministrarStakeHolders.KEYIDTIPOSTAKEHOLDER];
        var oEasyCardView = new EasyControl.EasyCardView('ViewCard1_' + IdTipoSH, 'ViewUser_' + IdTipoSH);
        oEasyCardView.Titulo = AdministrarStakeHolders.Params[AdministrarStakeHolders.KEYIDNOMBRESTAKEHOLDER];
        oEasyCardView.Cards.Clear();


        var oCard = null;
        AdministrarStakeHolders.Data.ListarStakeHolders(IdTipoSH).Rows.forEach(function (oRow,r) {
            oCard = new EasyControl.EasyCard();
            oCard.Id = oRow.ID_STAKEHOLDER;
            oCard.Foto = GlobalEntorno.PathFotosPersonal + oRow.NRODOCDNI  + ".jpg";
            oCard.Nombres = oRow.APELLIDOSYNOMBRES;
            oCard.Tipo = oRow.NOMBRE.replace(/(^\w{1})|(\s+\w{1})/g, letra => letra.toUpperCase());
            switch (oRow.IDTIPOSH) {
                case "1":
                    oCard.ClassTipo = "badge-soft-success";
                    break;
                case "2":
                    oCard.ClassTipo = "badge-soft-danger";
                    break;
                case "3":
                    oCard.ClassTipo = "badge-soft-warning";
                    break;
            }

            var oCardInfo = new EasyControl.EasyCardInfoAdicional();
                oCardInfo.Icono = "fa fa-phone";
                oCardInfo.Descripcion = oRow.PTRNUMTEL;
            oCard.ColleccionInfo.Add(oCardInfo);

                oCardInfo = new EasyControl.EasyCardInfoAdicional();
                oCardInfo.Icono = "fa fa-envelope";
                oCardInfo.Descripcion = oRow.PTREMAIL;
            oCard.ColleccionInfo.Add(oCardInfo);

                oCardInfo = new EasyControl.EasyCardInfoAdicional();
                oCardInfo.Icono = "fa fa-map-marker";
                oCardInfo.Descripcion = oRow.DIRECCION;
            oCard.ColleccionInfo.Add(oCardInfo);

                oCardInfo = new EasyControl.EasyCardInfoAdicional();
                oCardInfo.Icono = "fa fa-user";
                oCardInfo.Descripcion = oRow.PUESTO;
            oCard.ColleccionInfo.Add(oCardInfo);

            oEasyCardView.Cards.Add(oCard);

        });

       
        AdministrarStakeHolders.ShowDetalle = function (oModo, IdStakeHolder) {
            var TabDataBE = EasyTabControlV1.TabActivo.attr("Data").toString().SerializedToObject();

            var urlPag = Page.Request.ApplicationPath + "/HelpDesk/Sistemas/DetalleStakeHolder.aspx";
            var oColletionParams = new SIMA.ParamCollections();

            var oParam = new SIMA.Param(AdministrarStakeHolders.KEYMODOPAGINA, oModo);
             oColletionParams.Add(oParam);

             oParam = new SIMA.Param(AdministrarStakeHolders.KEYIDTAKEHOLDER, IdStakeHolder);
             oColletionParams.Add(oParam);

            oParam = new SIMA.Param(AdministrarStakeHolders.KEYIDTIPOSTAKEHOLDER, EasyTabControlV1.TabActivo.Params[AdministrarStakeHolders.KEYIDTIPOSTAKEHOLDER]);
            oColletionParams.Add(oParam);

             oParam = new SIMA.Param(AdministrarStakeHolders.KEYIDTIPOELEMENTO, TabDataBE.CODIGO);
             oColletionParams.Add(oParam);

             oParam = new SIMA.Param(AdministrarStakeHolders.KEYNOMBREELEMENTO, TabDataBE.NOMBRE);
             oColletionParams.Add(oParam);

             oParam = new SIMA.Param(AdministrarStakeHolders.KEYIDACTIVIDAD, AdministrarStakeHolders.Params[AdministrarStakeHolders.KEYIDACTIVIDAD]);
             oColletionParams.Add(oParam);
           
             EasyPopupDetalleElementos.Titulo = TabDataBE.NOMBRE;
             EasyPopupDetalleElementos.Load(urlPag, oColletionParams, false);
         }
         
        AdministrarStakeHolders.Eliminar = function (oIdCard) {
            var TabDataBE = EasyTabControlV1.TabActivo.attr("Data").toString().SerializedToObject();
             var ConfigMsgb = {
                 Titulo: 'ELIMINAR ' + TabDataBE.NOMBRE
                 , Descripcion: 'Desea eliminar el registro seleccionado ahora?'
                 , Icono: 'fa fa-close'
                 , EventHandle: function (btn) {
                     if (btn == 'OK') {
                         try {
                             //var GridViewActivo = jNet.get('Grid' + TabDataBE.CODIGO);
                             //var oDataRow = GridViewActivo.GetDataRow();
                             var oParamCollections = new SIMA.ParamCollections();
                             var oParam = new SIMA.Param("IdStakeHolder", oIdCard);
                             oParamCollections.Add(oParam);
                             oParam = new SIMA.Param('IdUsuario', UsuarioBE.IdUsuario, TipodeDato.Int);
                             oParamCollections.Add(oParam);
                             oParam = new SIMA.Param('UserName', UsuarioBE.UserName);
                             oParamCollections.Add(oParam);

                             var oEasyDataInterConect = new EasyDataInterConect();
                             oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceExterno;
                             oEasyDataInterConect.UrlWebService = ConnectService.PathNetCore + '/HelpDesk/Sistemas/GestionSistemas.asmx';
                             oEasyDataInterConect.Metodo = 'ActividadElementos_StakeHolder_Del';
                             oEasyDataInterConect.ParamsCollection = oParamCollections;

                             var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                             var obj = oEasyDataResult.sendData();

                             EasyTabControl1.RefreshTabSelect();
                         }
                         catch (SIMADataException) {
                             var msgConfig = { Titulo: "Error al intentar Eliminar este registro", Descripcion: SIMADataException.Message };
                             var oMsg = new SIMA.MessageBox(msgConfig);
                             oMsg.Alert();
                         }


                     }
                 }
             };
             var oMsg = new SIMA.MessageBox(ConfigMsgb);
             oMsg.confirm();
         }
       

        var oMenuItem = new EasyControl.EasyCardMenuItem();
            oMenuItem.Id = "MnuItem1";
            oMenuItem.Descripcion = "Edit";
        oEasyCardView.MenuItems.Add(oMenuItem);

            oMenuItem = new EasyControl.EasyCardMenuItem();
            oMenuItem.Id = "MnuItem2";
            oMenuItem.Descripcion = "Eliminar";
        oEasyCardView.MenuItems.Add(oMenuItem);

        oEasyCardView.onMenuItemClick = function (IdCard, oMnuItem) {
            switch (oMnuItem.Id) {
                case "MnuItem1":
                    AdministrarStakeHolders.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.M, IdCard);
                    break;
                case "MnuItem2":
                    //oEasyCardView.Remove(IdCard);
                    AdministrarStakeHolders.Eliminar(IdCard);
                    break;
            }
        }

        oEasyCardView.BtnPrimario = { Text: "Profile(s)", Icono: "fa fa-user", Visible: true };
        oEasyCardView.BtnSecundario = { Text: "Contact", Icono: "fa fa-comments", Visible: true};

        oEasyCardView.onBtnClick = function (btn) {
            alert(btn.IdCard + ' - '  + btn.Tipo);
        }

        var oButtom = new oEasyCardView.ToolBar.Buttom("btnNew", "fa fa-plus", "Nuevo");
        oEasyCardView.ToolBar.Add(oButtom);
        oEasyCardView.ToolBar.onclick = function (obtn) {
            AdministrarStakeHolders.ShowDetalle(SIMA.Utilitario.Enumerados.ModoPagina.N, "0");
        }


        oEasyCardView.Render();

    </script>
</body>
    

</html>
