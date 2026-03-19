/*

Este JS es un micro‑bootstrap de dependencias en el front. Su objetivo es:
- Esperar (polling) a que existan ciertas dependencias globales (p. ej. SIMA.Param, SIMA.ParamCollections, SIMA.Data.DataTable, window.$/jQuery, etc.).
- Ejecutar un callback (onReady) cuando todas esas dependencias estén disponibles.
- Cortar con timeout si no aparecen (y opcionalmente ejecutar un onTimeout).
- Dejar un API súper simple y reutilizable para todos tus módulos.

*/


/*!
 * util-deps.js
 * Micro-bootstrap para esperar dependencias globales antes de inicializar módulos.
 * - waitFor(predicates[], onReady, { interval, timeout, onTimeout })
 * - Expone: window.waitFor y SIMA.__waitForDeps
 */



/*!
 * sima-bootstrap (colócalo antes que EasyDataInterConect.js / Objects.js / AccesoDatosBase.js)
 * - Crea SIMA/SIMA.Data si no existen.
 * - Shims de SIMA.Param y SIMA.ParamCollections para evitar crashes tempranos.
 * - Cuando carguen las clases reales (EasyDataInterConect.js), reencadena prototipos sin tocar otros archivos.
 */

(function (w) {
    "use strict";

    // Bootstrap del namespace
    w.SIMA = w.SIMA || {};
    var SIMA = w.SIMA;
    SIMA.Data = SIMA.Data || {};

    // Shims mínimos solo si faltan (para no romper en "new SIMA.Param")
    var SHIM = {};

    if (typeof SIMA.Param !== "function") {
        SHIM.Param = function (name, value, tipo) {
            this.Nombre = name || "";
            this.Valor = value;
            this.Tipo = (tipo || "String");
        };
        SIMA.Param = SHIM.Param;
    }

    if (!(SIMA.ParamCollections)) {
        SHIM.ParamCollections = function () {
            var col = [];
            this.Add = function (p) { col.push(p); };
            this.getCollection = function () { return col; };
            this.Clear = function () { col.length = 0; };
            this.toString = function () {
                var s = "";
                col.forEach(function (p, i) {
                    var key = (p.Nombre || p.Text || p.name || "");
                    var val = (p.Valor || p.value || "");
                    s += (i ? "&" : "") + key + "=" + val;
                });
                return s;
            };
        };
        SIMA.ParamCollections = SHIM.ParamCollections;
    }

    // (Opcional) DataTable no-op si hiciera falta
    SIMA.Data.DataTable = SIMA.Data.DataTable || function () {
        this.Columns = { Add: function () { }, forEach: function () { } };
        this.Rows = { Add: function () { }, Count: function () { return 0; } };
        this.newRow = function () { return {}; };
    };

    // Upgrade: cuando la base real entre (EasyDataInterConect.js), re‑encadena prototipos
    function rewireIfReady() {
        var realParam = (typeof SIMA.Param === "function" && SIMA.Param !== SHIM.Param) ? SIMA.Param : null;
        var realColl = (SIMA.ParamCollections && SIMA.ParamCollections !== SHIM.ParamCollections) ? SIMA.ParamCollections : null;

        if (realParam && SIMA.Data && SIMA.Data.OleDB && SIMA.Data.OleDB.Param) {
            Object.setPrototypeOf(SIMA.Data.OleDB.Param.prototype, realParam.prototype);
            SIMA.Data.OleDB.Param.prototype.constructor = SIMA.Data.OleDB.Param;
        }

        if (realColl && SIMA.Data && SIMA.Data.OleDB && SIMA.Data.OleDB.ParamCollections) {
            Object.setPrototypeOf(SIMA.Data.OleDB.ParamCollections.prototype, realColl.prototype);
            SIMA.Data.OleDB.ParamCollections.prototype.constructor = SIMA.Data.OleDB.ParamCollections;
            SIMA.ParamCollections = SIMA.ParamCollections || realColl; // alias canónico
        }

        return !!(realParam && realColl);
    }

    // Poll 20s
    var t0 = Date.now();
    var timer = setInterval(function () {
        try {
            if (rewireIfReady()) { clearInterval(timer); return; }
            if (Date.now() - t0 > 20000) { clearInterval(timer); }
        } catch (e) { clearInterval(timer); }
    }, 100);

    // Evita fallos si alguien consulta Page en login
    w.Page = w.Page || { Request: { ApplicationPath: "", Params: {} } };
})(window);



(function (global) {
    "use strict";

    function waitForDeps(predicates, onReady, opts) {
        var opt = opts || {};
        var interval = Number(opt.interval || 100);   // ms entre reintentos
        var timeout = Number(opt.timeout || 10000); // ms tope
        var start = Date.now();

        // Normaliza a funciones booleanas
        var checks = (Array.isArray(predicates) ? predicates : [predicates]).map(function (p) {
            if (typeof p === "function") return p;
            // Si viene un valor no-función, envuélvelo
            return function () { return !!p; };
        });

        (function check() {
            var ok = true;
            // Ejecutar cada predicado de forma segura
            for (var i = 0; i < checks.length; i++) {
                try {
                    if (!checksi) { ok = false; break; }
                } catch (e) {
                    ok = false; break;
                }
            }

            if (ok) {
                try { return onReady && onReady(); }
                catch (e) {
                    console.error("[waitForDeps] onReady lanzó una excepción:", e);
                }
                return;
            }

            if (Date.now() - start > timeout) {
                // Diagnóstico: marca qué predicados no pasaron
                var failed = [];
                for (var j = 0; j < checks.length; j++) {
                    var passed = false;
                    try { passed = !!checksj; } catch (e) { passed = false; }
                    if (!passed) failed.push("#" + j);
                }
                console.error(
                    "[waitForDeps] Timeout esperando dependencias:",
                    (predicates && predicates.toString ? predicates.toString() : predicates),
                    "\nPredicados que NO pasaron:", failed.join(", "),
                    "\nTip: verifica el ORDEN de <script> y que no haya entidades HTML (&lt; &gt; &amp;) en tu JS."
                );
                if (typeof opt.onTimeout === "function") {
                    try { opt.onTimeout(); } catch (e) { console.error("[waitForDeps] onTimeout lanzó una excepción:", e); }
                }
                return;
            }

            setTimeout(check, interval);
        })();
    }

    // Exponer API
    global.waitFor = waitForDeps;                 // Opción A: global plano
    global.SIMA = global.SIMA || {};
    global.SIMA.__waitForDeps = waitForDeps;      // Opción B: en SIMA
})(window);