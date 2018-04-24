!function(e) {
    "use strict";
    function t(t) {
        var n = e("");
        try {
            n = e(t).clone()
        } catch(r) {
            n = e("<span />").html(t)
        }
        return n
    }
    function n(t, n, r) {
        var o = e.Deferred();
        try {
            var i = (t = t.contentWindow || t.contentDocument || t).document || t.contentDocument || t;
            r.doctype && i.write(r.doctype),
            i.write(n),
            i.close();
            var s = !1,
            c = function() {
                if (!s) {
                    t.focus();
                    try {
                        t.document.execCommand("print", !1, null) || a(t),
                        e("body").focus()
                    } catch(e) {
                        a(t)
                    }
                    t.close(),
                    s = !0,
                    o.resolve()
                }
            };
            e(t).on("load", c),
            setTimeout(c, r.timeout)
        } catch(e) {
            o.reject(e)
        }
        return o
    }
    function r(t, r) {
        var i = e(r.iframe + ""),
        a = i.length;
        return 0 === a && (i = e('<iframe height="0" width="0" border="0" wmode="Opaque"/>').prependTo("body").css({
            position: "absolute",
            top: -999,
            left: -999
        })),
        n(i.get(0), t, r).done(function() {
            setTimeout(function() {
                0 === a && i.remove()
            },
            1e3)
        }).fail(function(e) {
            console.error("Failed to print from iframe", e),
            o(t, r)
        }).always(function() {
            try {
                r.deferred.resolve()
            } catch(e) {
                console.warn("Error notifying deferred", e)
            }
        })
    }
    function o(e, t) {
        return n(window.open(), e, t).always(function() {
            try {
                t.deferred.resolve()
            } catch(e) {
                console.warn("Error notifying deferred", e)
            }
        })
    }
    function i(e) {
        return !! ("object" == typeof Node ? e instanceof Node: e && "object" == typeof e && "number" == typeof e.nodeType && "string" == typeof e.nodeName)
    }
    function a(e) {
        jsPrintSetup ? (jsPrintSetup.setOption("orientation", jsPrintSetup.kPortraitOrientation), jsPrintSetup.setOption("marginTop", 0), jsPrintSetup.setOption("marginBottom", 0), jsPrintSetup.setOption("marginLeft", 0), jsPrintSetup.setOption("marginRight", 0), jsPrintSetup.setOption("headerStrLeft", ""), jsPrintSetup.setOption("headerStrCenter", ""), jsPrintSetup.setOption("headerStrRight", ""), jsPrintSetup.setOption("footerStrLeft", ""), jsPrintSetup.setOption("footerStrCenter", ""), jsPrintSetup.setOption("footerStrRight", ""), jsPrintSetup.setSilentPrint(!0), jsPrintSetup.printWindow(e), setTimeout(function() {
            jsPrintSetup.setSilentPrint(!1)
        },
        500)) : alert("请安装插件！")
    }
    e.print = e.fn.print = function() {
        var n, a, s = this;
        s instanceof e && (s = s.get(0)),
        i(s) ? (a = e(s), arguments.length > 0 && (n = arguments[0])) : arguments.length > 0 ? i((a = e(arguments[0]))[0]) ? arguments.length > 1 && (n = arguments[1]) : (n = arguments[0], a = e("html")) : a = e("html");
        var c = {
            globalStyles: !0,
            mediaPrint: !1,
            stylesheet: null,
            noPrintSelector: ".no-print",
            iframe: !0,
            append: null,
            prepend: null,
            manuallyCopyFormValues: !0,
            deferred: e.Deferred(),
            timeout: 750,
            title: null,
            doctype: "<!doctype html>"
        };
        n = e.extend({},
        c, n || {});
        var l = e("");
        n.globalStyles ? l = e("style, link, meta, base, title") : n.mediaPrint && (l = e("link[media=print]")),
        n.stylesheet && (l = e.merge(l, e('<link rel="stylesheet" href="' + n.stylesheet + '">')));
        var p = a.clone();
        if ((p = e("<span/>").append(p)).find(n.noPrintSelector).remove(), p.append(l.clone()), n.title) {
            var d = e("title", p);
            0 === d.length && (d = e("<title />"), p.append(d)),
            d.text(n.title)
        }
        p.append(t(n.append)),
        p.prepend(t(n.prepend)),
        n.manuallyCopyFormValues && (p.find("input").each(function() {
            var t = e(this);
            t.is("[type='radio']") || t.is("[type='checkbox']") ? t.prop("checked") && t.attr("checked", "checked") : t.attr("value", t.val())
        }), p.find("select").each(function() {
            e(this).find(":selected").attr("selected", "selected")
        }), p.find("textarea").each(function() {
            var t = e(this);
            t.text(t.val())
        }));
        var u = p.html();
        try {
            n.deferred.notify("generated_markup", u, p)
        } catch(e) {
            console.warn("Error notifying deferred", e)
        }
        if (p.remove(), n.iframe) try {
            r(u, n)
        } catch(e) {
            console.error("Failed to print from iframe", e.stack, e.message),
            o(u, n)
        } else o(u, n);
        return this
    }
} (jQuery);