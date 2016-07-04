function fn_callmethod(url, data, success, error) {
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: success,
        error: error
    });
}

function notify(message, type, position) {
    $.growl({
        message: message
    }, {
        type: type,
        allow_dismiss: false,
        label: 'Cancel',
        className: 'btn-xs btn-inverse',
        placement: {
            from: 'top',
            align: position
        },
        delay: 5000,
        animate: {
            enter: 'animated bounceIn',
            exit: 'animated bounceOut'
        },
        offset: {
            x: 20,
            y: 101
        }
    });
};

function fn_message(type, message, div) {
    var html = '';
    switch (type) {
        case "s":
            html = "<div class='alert alert-success alert-dismissable'>" + message + "</div>";
            break;
        case "e":
            html = "<div class='alert alert-danger alert-dismissable'>" + message + "</div>";
            break;
        case "w":
            html = "<div class='alert alert-warning alert-dismissable'>" + message + "</div>";
            break;
        case "i":
            html = "<div class='alert alert-info alert-dismissable'>" +  message + "</div>";
            break;
        default:
            html = "<div class='alert alert-warning alert-dismissable'>"  + message + "</div>";
            break;
    }

    fn_setmessage(html, div);
}

function fn_setmessage(html, div) {
    var wrap = $('div[id$=' + div + ']');
    wrap.empty();
    wrap.append(html);
    wrap.slideDown();
    $('html, body').animate({ scrollTop: 1 }, 'slow');
    setTimeout(function () {
        wrap.slideUp();
    }, 5000);
}

function reemplazarjson(data) {
    var temp = "";
    for (var i = 0; i < data.length; i++) {
        if (data[i] == '"')
            temp = temp + "'";
        else
            temp = temp + data[i];
    }
    return temp;
}

//************ VALIDAR CAJAS DE TEXTO
var regexTexto = /^[a-zA-Z\ \']*$/;
var regexNumero = /^[0-9\ ]*$/;
var regexCorreo = /^$|^((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/;
var regexTelefono = /^$|^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/;
var regexCaracteres = /^[0-9a-zA-Z']+$/;
var regexPrecio = /^(^\d*\.?\d*[0-9]+\d*$)|(^[0-9]+\d*\.\d*$)/;

function ValidarNumeros(e) {
    var key = window.Event ? e.which : e.keyCode
    return ((key >= 48 && key <= 57) || (key == 8))
}

function ValidarDecimal(e, obj) {
    tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;

    Punto = obj.value.split('.');
    if (Punto.length >= 2) {
        patron = /[0-9]/;
    } else
        patron = /[0-9.]/;
    te = String.fromCharCode(tecla);

    return patron.test(te);
}

function stopRKey(evt) {
    var evt = (evt) ? evt : ((event) ? event : null);
    var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
    if ((evt.keyCode == 13) && (node.type == "text")) { return false; }
}
document.onkeypress = stopRKey;

