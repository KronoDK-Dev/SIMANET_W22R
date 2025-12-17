var ScriptManager = {};

ScriptManager.Find = function (opt) {
    var ObjScriptRerturn = null;
    var head = document.getElementsByTagName('head').item(0).children;
    var arrScript = Array.prototype.slice.call(head, 0);
    arrScript.forEach(function (scriptLib, i) {
        if (((scriptLib.tagName.toUpperCase() == "SCRIPT") || (scriptLib.tagName.toUpperCase() == "STYLE")) && (scriptLib.id.indexOf(opt.Prefijo) != -1)) {
            var DataScript = scriptLib.id.split('-');
            if ((DataScript[0] == opt.Prefijo) && (DataScript[1] == opt.Id)) {
                ObjScriptRerturn= scriptLib;
            }
        }
    });
    return ObjScriptRerturn;
}

ScriptManager.RemoveAll = function (opt) {
    var head = document.getElementsByTagName('head').item(0).children;
    var arrScript = Array.prototype.slice.call(head, 0);
    arrScript.forEach(function (scriptLib, i) {
        if (((scriptLib.tagName.toUpperCase() == "SCRIPT") || (scriptLib.tagName.toUpperCase() == "STYLE")) && (scriptLib.id.indexOf(opt.Prefijo) != -1)) {
            var DataScript = scriptLib.id.split('-');
            if (DataScript[0] == opt.Prefijo) {
                scriptLib.remove();
            }
        }
    });
    return null;
}


ScriptManager.NotUsing = function (opt) {
    var objScript = ScriptManager.Find(op);
    objScript.remove();
}
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

    ext = (
        (opt.type != "") ?
            opt.type :
            file.substring(file.lastIndexOf(Caracter.Punto) + 1)
    );

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