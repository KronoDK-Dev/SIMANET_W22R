CardFileBE/*Control DatePick*/
var EasyDatepicker = {};

EasyDatepicker.Setting = function (Id, Formato) {
    var DTPK_Config = { todayHighlight: true, language: 'zh-CN', autoclose: true, clearBtn: false, format: Formato };
    var objFecha = $("#" + Id);
    objFecha.datepicker(DTPK_Config).on('changeDate',
        function (e) {
            try {
                this.Change(e);
            }
            catch (Error) {
                return null;
            }
        }
    );
}



function EasyUploadFileBE(_FileObj, CtrlBaseID) {
    var CardID = '';
    var ProgressBarID = '';
    var ProgressLabelID = '';
    var nArchivo = (_FileObj.name.split('.')[0]).toString().Replace(' ', '').Replace(',', '').Replace('_', '').Replace('-', '').Replace('(', '').Replace(')', '');

    var fileSize = 0;
    if (_FileObj.size > 1024 * 1024)
        fileSize = (Math.round(_FileObj.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
    else
        fileSize = (Math.round(_FileObj.size * 100 / 1024) / 100).toString() + 'KB';

    this.Nombre = _FileObj.name;
    this.Tipo = _FileObj.type;
    this.Size = fileSize;
    this.IdEstado = 1;
    this.Enviado = false;

    if (_FileObj instanceof File) {
        this.Binary = _FileObj;//Archivo en Binario
    }
    this.Existe = false;
    this.toString = function () {
        return this.Nombre + '|' + this.Tipo + '|' + this.Size;
    }
    this.Render = function (HtmlTextWriter) {
        CardID = CtrlBaseID + '_Card_' + nArchivo;
        ProgressBarID = CtrlBaseID + '_Progress_' + nArchivo;
        ProgressLabelID = CtrlBaseID + '_ProgressLbl_' + nArchivo;
        //Atributo principal para identificar el control y su instancia
        this.ClientID = CardID;

        var _Card = jNet.create('div');
        _Card.attr('class', 'card card-outline-info h-100');
        _Card.attr('id', this.ClientID);

        var _CardBlock = jNet.create('div');
        _CardBlock.attr('class', 'card-block').css('padding-left', '10px').css('padding-top', '10px').css('padding-right', '10px');

        var _h4 = jNet.create('div')
        _h4.attr('class', 'h4 m-0');
        _h4.innerHTML = fileSize;
        _CardBlock.insert(_h4);
        //Nombre de archivo
        var _File = jNet.create('div');
        _File.innerHTML = ((this.Nombre.length > 58) ? this.Nombre.substring(0, 58) + '...' : this.Nombre);
        _CardBlock.insert(_File);

        var _ProgressBar = jNet.create('div');
        _ProgressBar.attr('id', ProgressBarID);
        var _ProgressLabel = jNet.create('div');
        _ProgressLabel.css('position', 'absolute').css('left', '50%').css('top', '4px').css('font-weight', 'bold').css('text-shadow', '1px 1px 0 #fff');
        _ProgressLabel.attr('id', ProgressLabelID);
        _ProgressLabel.innerHTML = '0%';
        _ProgressBar.insert(_ProgressLabel);
        _CardBlock.insert(_ProgressBar);

        _Card.insert(_CardBlock);
        var _small = jNet.create('small');
        _small.attr('class', 'text-muted cat col-sm-6');
        var _i = jNet.create('i');
        _i.attr('class', 'far fa-clock text-info').innerHTML = 'Type:';
        _small.insert(_i);
        _small.innerHTML = this.Tipo;

        _Card.insert(_small);

        //agregado para la funcionalidad de eliminar

        var _i = jNet.create('img');
        _i.src = SIMA.Utilitario.Constantes.ImgDataURL.ImgClose;
        _i.attr('class', 'TopRightIcon');
        _i.addEvent("click", function () {
            var NomObjUpLoad = "o" + HtmlTextWriter.Replace("_body", "") + "_Exe";
            var objExe = window[NomObjUpLoad];
            var ConfigMsgb = {
                Titulo: 'Eliminar Archivo'
                , Descripcion: 'Desea eliminar el archivo seleccionado de la lista ahora..?'
                , Icono: 'fa fa-question-circle'
                , EventHandle: function (btn) {
                    if (btn == 'OK') {
                        var objFileBE = objExe.Find(CardID);
                        objExe.remove(objFileBE);
                    }
                }
            };
            var oMsg = new SIMA.MessageBox(ConfigMsgb);
            oMsg.confirm();
        });

        _Card.insert(_i);

        var Writer = jNet.get(HtmlTextWriter);
        Writer.attr("objFile", this.Nombre);

        Writer.insert(_Card);
        var Separador = jNet.create('br');
        Separador.attr('id', 'br' + CardID);
        Writer.insert(Separador);
        //Inicia el progresso
        EasyProgressBar(ProgressBarID, ProgressLabelID);
    }
}

