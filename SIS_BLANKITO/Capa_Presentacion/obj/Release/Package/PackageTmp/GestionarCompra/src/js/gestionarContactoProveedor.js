var tablaContactoProveedor;
var objTemp;

$(function () {
    SetearMenu();
    ListarContactoProveedor(0);

    $("#txtDniRucProveedor").keypress(function (e) {        
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if (keycode === 13) { MostrarProveedor(); }
    });

    $("#txtDni, #txtDniRucProveedor, #txtDniRuc_Nuevo").keypress(function (e) {
        return ValidarNumeros(e);
    });

    $("#btnModalProveedor").on("click", function () {
        LimpiarCampos("modalProveedor");
    });

    $("#btnGuardarProveedor").on("click", function () {
        GuardarProveedor();
    });

    $("#btnGuardar").on("click", function () {
        GuardarContactoProveedor();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos("collapseContacto");
    });

    $("#btnNuevo").on("click", function () {
        LimpiarCampos("collapseContacto");
    });

    $("#btnEliminar").on("click", function () {
        EliminarDatos();
    });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-compra").addClass("active toggled");
    $("#mc-contacto a").attr("class", "active");
}

function ListarContactoProveedor(edito) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objTemp = $.parseJSON(rpta.d.cp);
        var tam = objTemp.length;
        if (tam == 0) { notify('No hay datos de contactos por proveedores disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objTemp[i].nombres + '</td>' +
                         '<td>' + objTemp[i].dni + '</td>' +
                         '<td>' + objTemp[i].correo + '</td>' +
                         '<td>' + objTemp[i].telefono + '</td>' +
                         '<td>' + objTemp[i].celular + '</td>' +
                         '<td>' + objTemp[i].proveedor.razon_social + '</td>' +
                         '<td style="display:none">' + objTemp[i].id_contacto_proveedor + '</td>' +
                      '</tr>';
        }
        $("#tblContacto tbody").html(tabla);

        tablaContactoProveedor = $("#tblContacto").bootgrid({
            selection: true, multiSelect: true, rowSelect: true, keepSelection: true,
            formatters: {
                "commands": function (column, row) {
                    return "<button type=\"button\" class=\"btn btn-icon command-edit\" onclick='MostrarContactoProveedor(\"" + row.id + "\")' style='width: 32px;height: 32px;margin-top: -13px;margin-bottom: -10px;'><span class=\"md md-edit\"></span></button>";
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

    fn_callmethod("gestionarContactoProveedor.aspx/Listar_ContactosProveedor", JSON.stringify({ edito: edito, id_proveedor : 0 }), success, error);
}

function GuardarContactoProveedor() {
    $(".alert").remove();

    if ($("#txtNombres").val() == "") {
        notify("Ingrese los nombres.", 'warning', 'center'); $("#txtNombres").focus(); return;
    }
    if ($("#txtDni").val() == "") {
        notify("Ingrese el número de documento.", 'warning', 'center'); $("#txtDni").focus(); return;
    } else if (!regexNumero.test($('#txtDni').val())) {
        notify("Sólo números.", 'warning', 'center'); $("#txtDni").focus(); return;
    } else if ($("#txtDni").val().length != "8") {
        notify("Tiene que ingresar la cantidad de dígitos adecuados.", 'warning', 'center'); $("#txtDni").focus(); return;
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
    if ($('#txtDniRucProveedor').val() == "" || $("#btnGuardar").attr("data-proveedor") == undefined) {
        notify("Ingrese el número de RUC y pulse enter o click en la lupa.", 'warning', 'center'); $("#txtDniRucProveedor").focus(); return;
    }

    var data = {
        cp: {
            id_contacto_proveedor: $("#btnGuardar").attr("data-id") || "0",
            nombres: $("#txtNombres").val(),
            dni: $("#txtDni").val(),
            correo: $("#txtCorreo").val(),
            telefono: $("#txtTelefono").val(),
            celular: $("#txtCelular").val(),
            proveedor: {id_proveedor: $("#btnGuardar").attr("data-proveedor")}
        }
    }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
        else if (rpta.d.Resultado == 'Check') { notify(rpta.d.Mensaje, 'warning', 'center'); return; }
        notify(rpta.d.Mensaje, 'success', 'center');
        tablaContactoProveedor.bootgrid("destroy");
        ListarContactoProveedor(1, 0);
        $("#btnCancelar").click();
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarContactoProveedor.aspx/Guardar_ContactoProveedor", JSON.stringify(data), success, error);
}

function MostrarContactoProveedor(id) {
    var len = objTemp.length;
    for (var i = 0; i < len; i++) {
        if (objTemp[i].id_contacto_proveedor == id) {
            if ($("#btnNuevo").attr("aria-expanded") == "false") {
                $("#btnNuevo").click();
            }            
            $("#txtNombres").val(objTemp[i].nombres);
            $("#txtDni").val(objTemp[i].dni);
            $("#txtCorreo").val(objTemp[i].correo);
            $("#txtTelefono").val(objTemp[i].telefono);
            $("#txtCelular").val(objTemp[i].celular);            
            $("#txtDniRucProveedor").val(objTemp[i].proveedor.dni_ruc);
            $("#txtRazonSocial").val(objTemp[i].proveedor.razon_social);

            $("#btnGuardar").attr("data-id", objTemp[i].id_contacto_proveedor);
            $("#btnGuardar").attr("data-proveedor", objTemp[i].proveedor.id_proveedor);
            break;
        }
    }
}

function EliminarDatos() {
    var tam = tablaContactoProveedor.bootgrid("getSelectedRows").length;
    if (tam > 0) {
        swal({
            title: "¿Está seguro?",
            text: (tam > 1 ? "¡Los contactos se eliminarán " : "¡El contacto se eliminará ") + " permanentemente!",
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
                    tablaContactoProveedor.bootgrid("destroy");
                    ListarContactoProveedor(1,0);
                    lista = [];
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarContactoProveedor.aspx/Eliminar_Datos", datos, success, error);
            }
        });
    }
    else { $(".alert").remove(); notify("Por favor seleccione al menos una fila para eliminar.", 'warning', 'center'); }
}

var lista = [];
function ListaTemporal() {
    tablaContactoProveedor.on("selected.rs.jquery.bootgrid", function (e, selectedRows) {
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

function LimpiarCampos(form) {
    $("#" + form + " :text").each(function () {
        $(this).val("").blur();
    });
    $("#btnGuardar").removeAttr("data-id");
    $("#btnGuardar").removeAttr("data-proveedor");
}

//******************************************************** MÉTODOS PARA EL PROVEEDOR *********************************************************
function MostrarProveedor() {
    $(".alert").remove();

    var dniruc = $("#txtDniRucProveedor").val();
    if (dniruc.length != 8 && dniruc.length != 11) { notify('Ingrese la cantidad de digitos adecuados.', 'warning', 'center'); $("#txtDniRucProveedor").focus(); return; }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.proveedor);
        var tam = obj.length;
        if (tam == 0) {
            ListarProveedores(1);
            $("#modalListadoProveedor").modal("show");
            fn_message("i", "El número de documento no se encuentra registrado, busque y seleccione uno; en caso contrario registre uno nuevo.", 'MLProveedor');
            $("#txtRazonSocial").val(""); $("#btnGuardar").removeAttr("data-proveedor"); return;
        }

        $("#txtRazonSocial").val(obj[0].razon_social).focus();
        $("#btnGuardar").attr("data-proveedor", obj[0].id_proveedor);

    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarOrdenCompra.aspx/Mostrar_Proveedor", JSON.stringify({ dniruc: dniruc }), success, error);
}

function GuardarProveedor() {
    $(".alert").remove();

    if ($("#txtRazonSocial_Nuevo").val() == "") {
        fn_message("w", 'Ingrese la razón social.', 'MFProveedor'); $("#txtRazonSocial_Nuevo").focus(); return;
    }

    if ($("#txtDniRuc_Nuevo").val() == "") {
        fn_message("w", 'Ingrese el número de documento.', 'MFProveedor'); $("#txtDniRuc_Nuevo").focus(); return;

    } else if (!regexNumero.test($('#txtDniRuc_Nuevo').val())) {
        fn_message("w", 'Sólo números.', 'MFProveedor'); $("#txtDniRuc_Nuevo").focus(); return;
    } else if ($("#txtDniRuc_Nuevo").val().length != "8" && $("#txtDniRuc_Nuevo").val().length != "11") {
        fn_message("w", 'Tiene que ingresar la cantidad de dígitos adecuados.', 'MFProveedor'); $("#txtDniRuc_Nuevo").focus(); return;
    }

    if ($('#txtCorreo_Nuevo').val() != "") {
        if (!regexCorreo.test($('#txtCorreo_Nuevo').val())) {
            fn_message("w", 'Correo electrónico inválido.', 'MFProveedor'); $("#txtCorreo_Nuevo").focus(); return;
        }
    }
    if ($('#txtTelefono_Nuevo').val() != "") {
        if (!regexTelefono.test($('#txtTelefono_Nuevo').val())) {
            fn_message("w", 'Número de teléfono inválido.', 'MFProveedor'); $("#txtTelefono_Nuevo").focus(); return;
        }
    }
    if ($('#txtCelular_Nuevo').val() != "") {
        if (!regexTelefono.test($('#txtCelular_Nuevo').val())) {
            fn_message("w", 'Número de celular inválido.', 'MFProveedor'); $("#txtCelular_Nuevo").focus(); return;
        }
    }

    var data = {
        proveedor: {
            id_proveedor: "0",
            razon_social: $("#txtRazonSocial_Nuevo").val(),
            dni_ruc: $("#txtDniRuc_Nuevo").val(),
            direccion: $("#txtDireccion_Nuevo").val(),
            correo: $("#txtCorreo_Nuevo").val(),
            telefono: $("#txtTelefono_Nuevo").val(),
            celular: $("#txtCelular_Nuevo").val(),
        }
    }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { fn_message("e", rpta.d.Mensaje, 'MFProveedor'); return; }
        else if (rpta.d.Resultado == 'Check') { fn_message("w", rpta.d.Mensaje, 'MFProveedor'); return; }
        $("#btnCerrarProveedor").click();
        notify(rpta.d.Mensaje, 'success', 'center');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        fn_message("e", 'Error inesperado. Por favor, vuelta a intentarlo.', 'MFProveedor');
    };

    fn_callmethod("gestionarProveedor.aspx/Guardar_Proveedor", JSON.stringify(data), success, error);
}

function ListarProveedores(edito) {
    var success = function (rpta) {
        $("#tblProveedor tbody").empty();
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objProveedor = $.parseJSON(rpta.d.proveedor);
        var tam = objProveedor.length;
        if (tam == 0) { notify('No hay datos de proveedores disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objProveedor[i].razon_social + '</td>' +
                         '<td class="text-center">' + objProveedor[i].dni_ruc + '</td>' +
                         '<td class="text-center">' + objProveedor[i].telefono + '</td>' +
                         '<td class="text-center">' + objProveedor[i].celular + '</td>' +
                         '<td class="text-center"><button type="button" class="btn bgm-lightgreen btn-icon" onclick="SeleccionarProveedor(\'' + objProveedor[i].id_proveedor + '\')" style="width: 32px;height: 32px;margin-top: -13px;margin-bottom: -10px;"><span class="md md-check"></span></button></td>' +
                      '</tr>';
        }
        $("#tblProveedor tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarProveedor.aspx/Listar_Proveedor", JSON.stringify({ edito: edito }), success, error);
}

function SeleccionarProveedor(id) {
    var len = objProveedor.length;
    for (var i = 0; i < len; i++) {
        if (objProveedor[i].id_proveedor == id) {
            $("#txtRazonSocial").val(objProveedor[i].razon_social).focus();
            $("#txtDniRucProveedor").val(objProveedor[i].dni_ruc);
            $("#btnGuardar").attr("data-proveedor", objProveedor[i].id_proveedor);
            $("#modalListadoProveedor").modal("hide");
            break;
        }
    }
}
