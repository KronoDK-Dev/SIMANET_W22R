var ScriptManager = {};
ScriptManager.InfoBE = function (_Name, _Src, _Ext, _Clase, _OBJECT) {
    this.Clase = _Clase;
    this.Name = _Name;
    this.Src = _Src;
    this.Ext = _Ext;
    this.Params = new Array();
    this.Params.GetParamValue = function (Name) {
        var Valor = null;
        this.forEach(function (p, i) {
            if (p.Name == Name) {
                Valor = p.Value;
            }
        });
        return Valor;
    }
    //this.Existe = false;
    this.OBJECT = _OBJECT;
    this.opt = undefined;
}

ScriptManager.Params = function (_Name, _Value) {
    this.Name = _Name;
    this.Value = _Value;
}

ScriptManager.GetInfo = function (ScriptSRC) {
    var oInfoBE = new ScriptManager.InfoBE();
    var arrInfo = ScriptSRC.split('?');
    oInfoBE.Src = arrInfo[0];
    //Obtenner Nombre
    var srrN = oInfoBE.Src.split('/');
    oInfoBE.Name = (srrN[srrN.length-1].toString().split('.'))[0];
    //oInfoBE.Ext = oInfoBE.Src.substring(oInfoBE.Src.lastIndexOf('.') + 1);
    oInfoBE.Ext = (srrN[srrN.length - 1].toString().split('.'))[1];
    //Obtiene los parametros
    if (arrInfo.length > 1) {
        var _Params = arrInfo[1].split('&');
        _Params.forEach(function (item) {
            var arrP = item.split('=');
            var oParams = new ScriptManager.Params();
            oParams.Name = arrP[0];
            oParams.Value = arrP[1];
            oInfoBE.Params.Add(oParams);
        });
    }
    
    return oInfoBE;
}


//ScriptManager.Find = function (opt) {
ScriptManager.Find = function (ScriptNombre) {
    var _InfoBE = null;
    var head = document.getElementsByTagName('head').item(0).children;
    var arrScript = Array.prototype.slice.call(head, 0);
    arrScript.forEach(function (scriptLib, i) {
        if ((
            (scriptLib.tagName.toUpperCase() == "SCRIPT")
            ||
            (scriptLib.tagName.toUpperCase() == "STYLE")
            )
          ){
            if (scriptLib.id == ScriptNombre) {
                _InfoBE = new ScriptManager.InfoBE();
                _InfoBE = ScriptManager.GetInfo(scriptLib.src);
                _InfoBE.OBJECT = scriptLib;
            }
        }
    });
    return _InfoBE;
}

//ScriptManager.RemoveAll = function (opt) {
ScriptManager.FindRemoveAll = function (oFind) {
    var head = document.getElementsByTagName('head').item(0).children;
    var arrScript = Array.prototype.slice.call(head, 0);
    arrScript.forEach(function (scriptLib, i) {
        var oscriptLib = jNet.get(scriptLib);
        var sTag = oscriptLib.tagName.toUpperCase();
        if (((sTag == "SCRIPT") || (sTag == "STYLE")) && (oscriptLib.attr(oFind.Name) == oFind.Value)) {
            
            try {
                scriptLib.parentNode.removeChild(scriptLib);
                head.removeChild(scriptLib);
            }
            catch (ex) {
                alert('otra forma');
                scriptLib.remove();
            }
        }
    });
}

/*
ScriptManager.NotUsing = function (opt) {
    var objScript = ScriptManager.Find(opt);
    objScript.remove();
}
*/
ScriptManager.NotUsing = function (ScriptNombre) {
    var mInfoBE = ScriptManager.Find(ScriptNombre);
    mInfoBE.OBJECT.remove();
}




ScriptManager.Using = function (_InfoBE,fncLoad) {
    if (_InfoBE.src == "") return;

    //idfile = opt.Prefijo + '-' + opt.Id;

    if (document.getElementById(_InfoBE.Name)) {
        return;
    };

    if (typeof _InfoBE.opt == "undefined") _InfoBE.opt = {};
    if (typeof _InfoBE.opt.dom == "undefined") _InfoBE.opt.dom = true;
    if (typeof _InfoBE.opt.type == "undefined") _InfoBE.opt.type = "";
  

    ext = (
            (_InfoBE.opt.type != "") ? _InfoBE.opt.type : _InfoBE.Ext
          );

   
        var random = new Date().getTime().toString();

        if (_InfoBE.Src.indexOf(Caracter.Interogacion) != -1) {
            _InfoBE.Src = _InfoBE.Src + Caracter.Amperson +"rnd=" + random;
        }
        else {
            _InfoBE.Src = _InfoBE.Src + Caracter.Interogacion + "rnd=" +random;
        }
        //Incorpora parametros adicionales
        if (((_InfoBE.Params != null) || (_InfoBE.Params != undefined)) && (_InfoBE.Params.length > 0)) {
            _InfoBE.Params.forEach(function (p, i) {
                _InfoBE.Src += "&" + p.Name + "=" + p.Value;
            })
        }

   
    var head = document.getElementsByTagName('head').item(0);


    switch (ext) {
        case Extension.Estilo:
            if (!_InfoBE.opt.dom) {
                //document.write('<link rel="stylesheet" href="' + _InfoBE.Src + '" id="' + _InfoBE.Name + '"  Clase="' + _InfoBE.Clase  + '"  type="text/css"><\/link>');
                var scr = '<link rel="stylesheet" href="' + _InfoBE.Src + '" id="' + _InfoBE.Name + '"  Clase="' + _InfoBE.Clase + '"  type="text/css"></link>';
                head.insertAdjacentHTML = scr;
            }
            else {
                css = document.createElement('link');
                css.rel = 'stylesheet';
                css.href = _InfoBE.Src;
                css.type = 'text/css';
                css.id = _InfoBE.Name;
                css.Clase = _InfoBE.Clase;
                head.appendChild(css);
            }
            break;

        case Extension.JavaScript:
            if (!_InfoBE.opt.dom) {
                //document.write('<script type="text/javascript" id="' + _InfoBE.Name + '"  Clase="' + _InfoBE.Clase + '"  src="' + _InfoBE.Src + '"><\/script>');
                var script = '<script type="text/javascript" id="' + _InfoBE.Name + '"  Clase="' + _InfoBE.Clase + '"  src="' + _InfoBE.Src + '"></script>';
                head.insertAdjacentHTML = script;
            }
            else {

                script = document.createElement('script');
                script.src = _InfoBE.Src;
                script.type = 'text/javascript';
                script.id = _InfoBE.Name;
                script.Clase = _InfoBE.Clase;
                head.appendChild(script);
            }

            break;
    }

    var obInfo = ScriptManager.Find(_InfoBE.Name);
    if (fncLoad != undefined) {
        obInfo.OBJECT.onload = fncLoad;
        obInfo.OBJECT.onerror = function () {
                                    var msgConfig = { Titulo: "Include Lib", Descripcion: "Hubo un error al tratar de registrar " + _InfoBE.Name + "Corrija la libreria y vuelva a intentarlo"};
                                    var oMsg = new SIMA.MessageBox(msgConfig);
                                    oMsg.Alert();
                                }
    }
    
    return obInfo;
}



ScriptManager.Log = {};

ScriptManager.Log.LogEntityBE = function (_ID, _VALOR) {
    this.Id = _ID;
    this.Valor = _VALOR;
}

ScriptManager.Log.Set = function (oLogEntityBE) {
    var strBE = ''.toString().BaseSerialized(oLogEntityBE);
    localStorage.setItem(oLogEntityBE.Id, strBE);
}

ScriptManager.Log.Get = function (Id) {
    var strBE = localStorage.getItem(Id);
    var oLogEntityBE = null;
    if (strBE != null) {
        oLogEntityBE = strBE.toString().SerializedToObject();
    }
    return oLogEntityBE;
}





/*
ScriptManager.Using = function (file, opt) {
    if (file == "") return;
    
    idfile = opt.Prefijo + '-' + opt.Id;

    if (document.getElementById(idfile)) {
        return;
    };

    if (typeof opt == "undefined") opt = {};
    if (typeof opt.cache == "undefined") opt.cache = true;
    if (typeof opt.dom == "undefined") opt.dom = false;
    if (typeof opt.type == "undefined") opt.type = "";
    //
    var _ext = file.substring(file.lastIndexOf(Caracter.Punto) + 1);
    if (file.indexOf('?')) {
        var oarr = file.split('?');
        _ext = oarr[0].substring(oarr[0].lastIndexOf(Caracter.Punto) + 1);
    }

    ext = (
        (opt.type != "") ?
            opt.type :_ext
    );
    
    //ext = (
    //    (opt.type != "") ?
    //        opt.type :
    //        file.substring(file.lastIndexOf(Caracter.Punto) + 1)
    //);


    if (!opt.cache) {
        var random = new Date().getTime().toString();
        if (file.indexOf(Caracter.Interogacion) != -1) file = file + Caracter.Amperson + random;
        else file = file + Caracter.Interogacion + random;
    }

    if (opt.dom) {
        var head = document.getElementsByTagName('head').item(0)
    }

    switch (ext) {
        case Extension.Estilo:
            if (!opt.dom)
                document.write('<link rel="stylesheet" href="' + file + '" id="' + idfile + '" type="text/css"><\/link>');
            else {
                css = document.createElement('link');
                css.rel = 'stylesheet';
                css.href = file;
                css.type = 'text/css';
                css.id = idfile;
                head.appendChild(css);
            }
            break;

        case Extension.JavaScript:
            if (!opt.dom) {
                document.write('<script type="text/javascript" id="' + idfile + '" src="' + file + '"><\/script>');
            }
            else {

                script = document.createElement('script');
                script.src = file;
                script.type = 'text/javascript';
                script.id = idfile;
                head.appendChild(script);

                if (typeof opt.oncomplete != "undefined") {
                    //Para IE
                    script.onreadystatechange = function () { if (script.readyState == 'complete') { if (typeof opt.oncomplete == "function") { eval(opt.oncomplete()); } } }
                    //Para Firefox
                    script.onload = function () { if (typeof opt.oncomplete == "function") { opt.oncomplete(); } }
                }
            }

            break;
    }
}
*/