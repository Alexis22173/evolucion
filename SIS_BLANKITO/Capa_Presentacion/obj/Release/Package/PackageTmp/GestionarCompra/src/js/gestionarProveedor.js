var tablaProveedor;
var objTemp;

$(function () {
    SetearMenu();
    ListarProveedor(0);

    $("#btnGuardar").on("click", function () {
        GuardarProveedor();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos();
    });

    $("#btnNuevo").on("click", function () {
        LimpiarCampos();
    });

    $("#btnEliminar").on("click", function () {
        EliminarDatos();
    });

    $("#txtDniRuc").keypress(function (e) {
        return ValidarNumeros(e);
    });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-compra").addClass("active toggled");
    $("#mc-proveedor a").attr("class", "active");
}

function ListarProveedor(edito) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objTemp = $.parseJSON(rpta.d.proveedor);
        var tam = objTemp.length;
        if (tam == 0) { notify('No hay datos de proveedores disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objTemp[i].razon_social + '</td>' +
                         '<td>' + objTemp[i].dni_ruc + '</td>' +
                         '<td>' + objTemp[i].direccion + '</td>' +
                         '<td>' + objTemp[i].correo + '</td>' +
                         '<td>' + objTemp[i].telefono + '</td>' +
                         '<td>' + objTemp[i].celular + '</td>' +                         
                         '<td style="display:none">' + objTemp[i].id_proveedor + '</td>' +
                      '</tr>';
        }
        $("#tblProveedor tbody").html(tabla);

        tablaProveedor = $("#tblProveedor").bootgrid({
            selection: true, multiSelect: true, rowSelect: true, keepSelection: true,
            formatters: {
                "commands": function (column, row) {
                    return "<button type=\"button\" class=\"btn btn-icon command-edit\" data-id=\"" + row.id + "\" onclick='MostrarProveedor(\"" + row.id + "\")' style='width: 32px;height: 32px;margin-top: -13px;margin-bottom: -10px;'><span class=\"md md-edit\"></span></button>";
                }
            }
        });

        ListaTemporal();
        var temp = $(".actionBar .actions").children("div:nth-child(2)").children("ul").children("ul li:last-child").prev();
        //temp.children().children().children(":first-child").click();
        temp.remove();
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarProveedor.aspx/Listar_Proveedor", JSON.stringify({ edito: edito }), success, error);
}

function GuardarProveedor() {
    $(".alert").remove();

    if ($("#txtRazonSocial").val() == "") {
        notify("Ingrese razón social.", 'warning', 'center'); $("#txtRazonSocial").focus(); return;
    }
    if ($("#txtDniRuc").val() == "") {
        notify("Ingrese el número de documento.", 'warning', 'center'); $("#txtDniRuc").focus(); return;
    } else if (!regexNumero.test($('#txtDniRuc').val())) {
        notify("Sólo números.", 'warning', 'center'); $("#txtDniRuc").focus(); return;
    } else if ($("#txtDniRuc").val().length != "8" && $("#txtDniRuc").val().length != "11") {
        notify("Tiene que ingresar la cantidad de dígitos adecuados.", 'warning', 'center'); $("#txtDniRuc").focus(); return;
    }

    if ($('#txtCorreo').val() != "") {
        if (!regexCorreo.test($('#txtCorreo').val())) {
            notify("Correo electrónico inválido.", 'warning', 'center'); $("#txtCorreo").focus(); return;
        }
    }
    if ($('#txtTelefono').val() != "") {
        if (!regexTelefono.test($('#txtTelefono').val())) {
            notify("Número de teléfono inválido.", 'warning', 'center'); $("#txtTelefono").focus(); return;
        }
    }
    if ($('#txtCelular').val() != "") {
        if (!regexTelefono.test($('#txtCelular').val())) {
            notify("Número de celular inválido.", 'warning', 'center'); $("#txtCelular").focus(); return;
        }
    }

    var data = {
        proveedor: {
            id_proveedor: $("#btnGuardar").attr("data-id") || "0",
            razon_social: $("#txtRazonSocial").val(),
            dni_ruc: $("#txtDniRuc").val(),
            direccion: $("#txtDireccion").val(),
            correo: $("#txtCorreo").val(),
            telefono: $("#txtTelefono").val(),
            celular: $("#txtCelular").val(),
        }
    }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
        else if (rpta.d.Resultado == 'Check') { notify(rpta.d.Mensaje, 'warning', 'center'); return; }
        notify(rpta.d.Mensaje, 'success', 'center');
        tablaProveedor.bootgrid("destroy");
        ListarProveedor(1);
        $("#btnCancelar").click();
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarProveedor.aspx/Guardar_Proveedor", JSON.stringify(data), success, error);
}

function LimpiarCampos() {
    $(":text").each(function () {
        $(this).val("");
    });
    $('.selectpicker').selectpicker('val', '0');
    $("#btnGuardar").removeAttr("data-id");
}

function MostrarProveedor(id) {
    var len = objTemp.length;
    for (var i = 0; i < len; i++) {
        if (objTemp[i].id_proveedor == id) {
            if ($("#btnNuevo").attr("aria-expanded") == "false") {
                $("#btnNuevo").click();
            }

            $("#txtRazonSocial").val(objTemp[i].razon_social);
            $("#txtDniRuc").val(objTemp[i].dni_ruc);
            $("#txtDireccion").val(objTemp[i].direccion);
            $("#txtCorreo").val(objTemp[i].correo);
            $("#txtTelefono").val(objTemp[i].telefono);
            $("#txtCelular").val(objTemp[i].celular);
           
            $("#btnGuardar").attr("data-id", objTemp[i].id_proveedor);
            break;
        }
    }
}

function EliminarDatos() {
    var tam = tablaProveedor.bootgrid("getSelectedRows").length;
    if (tam > 0) {
        swal({
            title: "¿Está seguro?",
            text: (tam > 1 ? "¡Los proveedores se eliminarán " : "¡El proveedor se eliminará ") + " permanentemente!",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            cancelButtonText: "Cancelar",
            confirmButtonText: "Eliminar",
            closeOnConfirm: false
        }
        , function (confirma) {
            if (confirma) {
                var json = JSON.stringify(lista);
                var datos = '{ jsondata:"' + reemplazarjson(json) + '" }';

                var success = function (rpta) {
                    if (rpta.d.Resultado == 'NoOk') { swal("Error!", rpta.d.Mensaje, "error"); return; }
                    swal("¡Eliminado!", rpta.d.Mensaje, "success");
                    tablaProveedor.bootgrid("destroy");
                    ListarProveedor(1);
                    lista = [];
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarProveedor.aspx/Eliminar_Datos", datos, success, error);
            }
        });
    }
    else { $(".alert").remove(); notify("Por favor seleccione al menos una fila para eliminar.", 'warning', 'center'); }
}

var lista = [];
function ListaTemporal() {
    tablaProveedor.on("selected.rs.jquery.bootgrid", function (e, selectedRows) {
        var row;
        for (var i = 0; i < selectedRows.length; i++) {
            row = selectedRows[i];
            if (!lista.contains(function (item) { return item.id === row.id; })) {
                lista.push({ id: row.id });
            }
        }
    }).on("deselected.rs.jquery.bootgrid", function (e, deselectedRows) {
        var row;
        for (var i = 0; i < deselectedRows.length; i++) {
            row = deselectedRows[i];
            for (var j = 0; j < lista.length; j++) {
                if (lista[j].id === row.id) {
                    lista.splice(j, 1);
                    return;
                }
            }
        }
    });
}