 var objProveedor;
var objContactoProveedor;

$(function () {
    SetearMenu();
    ListarTipoDocumento();
    ListarTipoPago();
    ListarMoneda();
    ListarComboProveedor(1);
    ListarNotasIngreso();

    $("#btnModalProveedor").on("click", function () {
        LimpiarCampos("modalProveedor");
    });

    $("#btnModalContactoProveedor").on("click", function () {
        LimpiarCampos("modalContactoProveedor");
    });

    $("#btnGuardarProveedor").on("click", function () {
        GuardarProveedor();
    });

    $("#btnGuardarContactoProveedor").on("click", function () {
        GuardarContactoProveedor();
    });

    $("#txtDniRucProveedor").keypress(function (e) {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if (keycode === 13) { MostrarProveedor(); }
    });

    $("#txtDniContacto").keypress(function (e) {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if (keycode === 13) { MostrarContacto(); }
    });

    $("#txtDniRucProveedor, #txtDniContacto, #txtDni_Contacto").keypress(function (e) {
        return ValidarNumeros(e);
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos("frmCompra");
    });

    $("#cmbNumero").on("change", function () {
        MostrarDetalleNotaIngreso($(this).val(), $("#cmbNumero option:selected").html());
    });

    $("#btnGuardar").on("click", function () {
        GuardarCompra();
    });

    $(".textStyle").css({ "left": "-10px", "width": "110%" });
    $(".textStyleDesc").css({ "left": "-10px", "width": "105%" });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-compra").addClass("active toggled");
    $("#mc-compra a").attr("class", "active");
}

function LimpiarCampos(form) {
    $("#" + form + " :text").each(function () {
        $(this).val("").blur();
    });

    if (form == "frmCompra") {
        $("#btnGuardar").removeAttr("data-proveedor");
        $("#btnGuardar").removeAttr("data-cp");
        $("#tblDetalle tbody").empty();
        $("#lblSubtotal").html("S/. 0.00");
        $("#lblIgv").html("S/. 0.00");
        $("#lblTotal").html("S/. 0.00");
    }
    $('.selectpicker').selectpicker('val', '0');
}

//******************************************************** LISTAR COMBOS *********************************************************
function ListarTipoDocumento() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.td);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de tipo documento disponibles.', 'inverse', 'center'); return; }

        for (var i = 0; i < tam; i++) {
            $("#cmbTipoDocumento").append('<option value="' + obj[i].id_tipo_documento + '">' + obj[i].descripcion + '</option>');
        }
        $('.selectpicker').selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("../GestionarMaestros/gestionarTipoDocumento.aspx/Listar_TipoDocumento", "", success, error);
}

function ListarTipoPago() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.tp);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de tipo pago disponibles.', 'inverse', 'center'); return; }

        for (var i = 0; i < tam; i++) {
            $("#cmbTipoPago").append('<option value="' + obj[i].id_tipo_pago + '">' + obj[i].descripcion + '</option>');
        }
        $('.selectpicker').selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("../GestionarMaestros/gestionarTipoPago.aspx/Listar_TipoPago", "", success, error);
}

function ListarMoneda() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.m);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de tipo moneda disponible.', 'inverse', 'center'); return; }

        for (var i = 0; i < tam; i++) {
            $("#cmbMoneda").append('<option value="' + obj[i].id_moneda + '">' + obj[i].descripcion + '</option>');
        }
        $('.selectpicker').selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("../GestionarLogistica/gestionarMoneda.aspx/Listar_Moneda", "", success, error);
}

function ListarNotasIngreso() {
    $("#cmbNumero").html('<option value="0">..:: SELECCIONE UN NÚMERO ::..</option>');
    $('#cmbNumero').selectpicker('refresh');
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.o);
        var tam = obj.length;
        if (tam == 0) { notify('No hay ordenes disponible.', 'inverse', 'center'); return; }

        var tabla = "";
        var temp = "";
        for (var i = 0; i < tam; i++) {
            if (i == 0) {
                $("#cmbNumero").append('<optgroup label="' + obj[i].fecha + '">' +
                                            '<option value="' + obj[i].id_nota_ingreso + '">' + obj[i].numero + '</option>' +
                                        '</optgroup>');
            } else {
                if (temp == obj[i].fecha) {
                    $("#cmbNumero optgroup").last().append('<option value="' + obj[i].id_nota_ingreso + '">' + obj[i].numero + '</option>');
                } else {
                    $("#cmbNumero").append('<optgroup label="' + obj[i].fecha + '">' +
                                                '<option value="' + obj[i].id_nota_ingreso + '">' + obj[i].numero + '</option>' +
                                            '</optgroup>');
                }
            }

            temp = obj[i].fecha;
            tabla = "";
        }

        $('#cmbNumero').selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarCompra.aspx/Listar_NotasIngreso", "", success, error);
}

function MostrarDetalleNotaIngreso(id, numero) {
    $(".alert").remove();

    if (id == "0") {return; }

    var valida = 0;
    $("#tblDetalle tbody tr").each(function (index) {
        if ($(this).children("td:eq(5)").text() == numero) { valida = 1; return false;}
    });
    if (valida == 1) { notify("El número: " + numero + ", ya se agregó en la lista.", 'warning', 'center'); return; }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.dni);
        var tam = obj.length;
        if (tam == 0) { notify('El número seleccionado no existe o no tiene detalle.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                            '<td class="hidden">' + obj[i].producto.id_producto + "</td>" +
                            '<td>' + obj[i].cantidad + '</td>' +
                            '<td>' + obj[i].descripcion + '</td>' +
                            '<td><div class="fg-line"><input type="text" class="form-control text-center input-sm txtPrecioDetalle" maxlength="10" style="width: 100%;" onkeypress="{CalcularImporte(event,this); return ValidarDecimal(event, this);}"></div></td>' +
                            '<td>0.00</td>' +
                            '<td>' + numero + '</td>' +
                            '<td class="hidden">' + obj[i].nota_ingreso.id_nota_ingreso + '</td>' +
                            '<td><button class="btn bgm-deeporange btn-xs" onclick="QuitarFila(this)"><i class="md md-close"></i></button></td>' +
                        '</tr>';
        }
        $("#tblDetalle tbody").append(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("../GestionarAlmacen/gestionarNotaIngreso.aspx/Mostrar_DetalleNotaIngreso", JSON.stringify({ id: id }), success, error);
}

function CalcularImporte(e, fila) {
    var keycode = (e.keyCode ? e.keyCode : e.which);
    if (keycode === 13) {
        $(".alert").remove();

        if (!isNaN(parseInt($(fila).val())) && parseInt($(fila).val()) != 0) {
            var importe = $(fila).parent().parent().parent().children("td:eq(1)").text() * $(fila).val();
            $(fila).parent().parent().parent().children("td:eq(4)").html(importe.toFixed(2));
            Calcular();
        } else {
            notify('El precio debe ser mayor que 0.', 'warning', 'center');
        }
    }
}

function Calcular() {
    var totalCompra = 0, temporal = 0;
    $("#tblDetalle tbody tr").each(function (index) {
        temporal = $(this).children("td:eq(4)").text();
        totalCompra = totalCompra + parseFloat(temporal);
    });

    subtotal = (totalCompra / 1.18);
    igv = (totalCompra - subtotal);
    $("#lblSubtotal").html("S/. " + subtotal.toFixed(2));
    $("#lblIgv").html("S/. " + igv.toFixed(2));
    $("#lblTotal").html("S/. " + totalCompra.toFixed(2));
}

function QuitarFila(fila) {
    $(fila).parent().parent().remove()
    Calcular();
}

function GuardarCompra() {
    $(".alert").remove();

    if ($('#txtDniRucProveedor').val() == "" || $("#btnGuardar").attr("data-proveedor") == undefined) {
        notify("Ingrese el número de RUC y pulse enter o click en la lupa.", 'warning', 'center'); $("#txtDniRucProveedor").focus(); return;
    } else if ($('#txtDniContacto').val() == "" || $("#btnGuardar").attr("data-cp") == undefined) {
        notify("Ingrese el número de DNI y pulse enter o click en la lupa.", 'warning', 'center'); $("#txtDniContacto").focus(); return;
    } else if ($("#cmbTipoDocumento").val() == null || $("#cmbTipoDocumento").val() == "0") {
        notify("Seleccione un tipo de documento.", 'warning', 'center'); return;
    } else if ($("#cmbTipoPago").val() == null || $("#cmbTipoPago").val() == "0") {
        notify("Seleccione un tipo de pago.", 'warning', 'center'); return;
    }else if ($("#cmbMoneda").val() == null || $("#cmbMoneda").val() == "0") {
        notify("Seleccione una moneda.", 'warning', 'center'); return;
    } else if ($("#tblDetalle tbody tr").length == 0) {
        notify("Debe seleccionar como mínimo un número.", 'warning', 'center'); return;
    }
    else {

        var valida = 0;
        $("#tblDetalle tbody tr").each(function (index) {
            var tempPrecio = $(this).children("td:eq(3)").children().children().val();
            if (tempPrecio == "") { valida = 1; return false; }

            var tempCantidad = $(this).children("td:eq(1)").text();
            var tempImporte = $(this).children("td:eq(4)").text();
            if ((tempPrecio * tempCantidad) != tempImporte) {
                valida = 2; return false;
            }
        });

        if (valida == 1) { notify("No debe dejar los campos vacios", 'warning', 'center'); return; }
        if (valida == 2) { notify("Uno de los importes no se calculó correctamente.", 'warning', 'center'); return; }

        swal({
            title: "¿Está seguro?",
            text: "La transacción se guardará permanentemente.",
            showCancelButton: true,
            confirmButtonColor: "#4CAF50",
            cancelButtonText: "Cancelar",
            confirmButtonText: "Confirmar",
            closeOnConfirm: false
        }, function (confirma) {
            if (confirma) {
                var orden, objDetalle;
                var lista = [];

                compra = {
                    id_compra: $("#btnGuardar").attr("data-id") || "0",
                    proveedor: { id_proveedor: $("#btnGuardar").attr("data-proveedor") },
                    contacto_proveedor: { id_contacto_proveedor: $("#btnGuardar").attr("data-cp") },
                    tipo_documento: { id_tipo_documento: $("#cmbTipoDocumento").val() },
                    tipo_pago: { id_tipo_pago: $("#cmbTipoPago").val() },
                    moneda: { id_moneda: $("#cmbMoneda").val() },
                    sub_total: $("#lblSubtotal").text().substring(4),
                    igv: $("#lblIgv").text().substring(4),
                    total: $("#lblTotal").text().substring(4),
                }

                $("#tblDetalle tbody tr").each(function (index) {
                    objDetalle = { id_producto: "", cantidad: "", descripcion: "", precio: "", importe: "", id_nota_ingreso: "" };
                    objDetalle.id_producto = $(this).children("td:eq(0)").text();
                    objDetalle.cantidad = $(this).children("td:eq(1)").text();
                    objDetalle.descripcion = $(this).children("td:eq(2)").text();
                    objDetalle.precio = $(this).children("td:eq(3)").children().children().val();
                    objDetalle.importe = $(this).children("td:eq(4)").text();
                    objDetalle.id_nota_ingreso = $(this).children("td:eq(6)").text();
                    lista[index] = objDetalle;
                });
                var detalle = JSON.stringify(lista);

                var success = function (rpta) {
                    if (rpta.d.Resultado == 'NoOk') { swal("Error!", rpta.d.Mensaje, "error"); return; }
                    swal("¡Registrado!", rpta.d.Mensaje, "success");
                    LimpiarCampos("frmCompra");
                    ListarNotasIngreso();
                    //if (orden.id_orden_compra != "0") ListarOrdenesCompra();
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarCompra.aspx/Guardar_Compra", JSON.stringify({ c: compra, jsondata: detalle }), success, error);
            }
        });
    }
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
        // limpiar compos del contacto
        $("#txtNombreContacto").val("").focus(); $("#txtDniContacto").val("").focus(); $("#btnGuardar").removeAttr("data-cp");

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

//******************************************************** MÉTODOS PARA EL CONTACTO PROVEEDOR *************************************************
function MostrarContacto() {
    $(".alert").remove();

    if ($('#txtDniRucProveedor').val() == "" || $("#btnGuardar").attr("data-proveedor") == undefined) {
        notify('Ingrese primero al proveedor.', 'warning', 'center'); $("#txtDniRucProveedor").focus(); return;
    }

    var dni = $("#txtDniContacto").val();
    if (dni.length != 8) { notify('Ingrese la cantidad de digitos adecuados.', 'warning', 'center'); $("#txtDniContacto").focus(); return; }


    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.cp);
        var tam = obj.length;
        if (tam == 0) {
            ListarContactosProveedor();
            $("#modalListadoContactoProveedor").modal("show");
            fn_message("i", "El número de documento no se encuentra registrado, busque y seleccione uno; en caso contrario registre uno nuevo.", 'MLContactoProveedor');
            $("#txtNombreContacto").val(""); $("#btnGuardar").removeAttr("data-cp"); return;
        }

        $("#txtNombreContacto").val(obj[0].nombres).focus();
        $("#btnGuardar").attr("data-cp", obj[0].id_contacto_proveedor);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarOrdenCompra.aspx/Mostrar_ContactoProveedor", JSON.stringify({ dni: dni, id_proveedor: $("#btnGuardar").attr("data-proveedor") }), success, error);
}

function ListarContactosProveedor() {
    var data = { edito: 1, id_proveedor: $("#btnGuardar").attr("data-proveedor") }
    var success = function (rpta) {
        $("#tblContactoProveedor tbody").empty();
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objContactoProveedor = $.parseJSON(rpta.d.cp);
        var tam = objContactoProveedor.length;
        if (tam == 0) { notify('No hay datos de contactos disponibles para el proveedor.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objContactoProveedor[i].proveedor.razon_social + '</td>' +
                         '<td>' + objContactoProveedor[i].nombres + '</td>' +
                         '<td class="text-center">' + objContactoProveedor[i].dni + '</td>' +
                         '<td class="text-center">' + objContactoProveedor[i].telefono + '</td>' +
                         '<td class="text-center">' + objContactoProveedor[i].celular + '</td>' +
                         '<td class="text-center"><button type="button" class="btn bgm-lightgreen btn-icon" onclick="SeleccionarContactoProveedor(\'' + objContactoProveedor[i].id_contacto_proveedor + '\')" style="width: 32px;height: 32px;margin-top: -13px;margin-bottom: -10px;"><span class="md md-check"></span></button></td>' +
                      '</tr>';
        }
        $("#tblContactoProveedor tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarContactoProveedor.aspx/Listar_ContactosProveedor", JSON.stringify(data), success, error);
}

function SeleccionarContactoProveedor(id) {
    var len = objContactoProveedor.length;
    for (var i = 0; i < len; i++) {
        if (objContactoProveedor[i].id_contacto_proveedor == id) {
            $("#txtNombreContacto").val(objContactoProveedor[i].nombres).focus();
            $("#txtDniContacto").val(objContactoProveedor[i].dni);
            $("#btnGuardar").attr("data-cp", objContactoProveedor[i].id_contacto_proveedor);
            $("#modalListadoContactoProveedor").modal("hide");
            break;
        }
    }
}

function ListarComboProveedor(edito) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.proveedor);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos datos de proveedores disponibles.', 'inverse', 'center'); return; }

        for (var i = 0; i < tam; i++) {
            $("#cmbProveedor").append('<option value="' + obj[i].id_proveedor + '">' + obj[i].razon_social + '</option>');
        }
        $('.selectpicker').selectpicker('refresh');
        $(".bs-searchbox input").attr("style", "position:initial");
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarProveedor.aspx/Listar_Proveedor", JSON.stringify({ edito: edito }), success, error);
}

function GuardarContactoProveedor() {

    if ($("#txtNombres_Contacto").val() == "") {
        fn_message("w", 'Ingrese los nombres.', 'MFContactoProveedor'); $("#txtNombres_Contacto").focus(); return;
    }
    if ($("#txtDni_Contacto").val() == "") {
        fn_message("w", 'Ingrese el número de documento.', 'MFContactoProveedor'); $("#txtDni_Contacto").focus(); return;
    } else if (!regexNumero.test($('#txtDni_Contacto').val())) {
        fn_message("w", 'Sólo números.', 'MFContactoProveedor'); $("#txtDni_Contacto").focus(); return;
    } else if ($("#txtDni_Contacto").val().length != "8") {
        fn_message("w", 'Tiene que ingresar la cantidad de dígitos adecuados.', 'MFContactoProveedor'); $("#txtDni_Contacto").focus(); return;
    }

    if ($('#txtCorreo_Contacto').val() != "") {
        if (!regexCorreo.test($('#txtCorreo_Nuevo').val())) {
            fn_message("w", 'Correo electrónico inválido.', 'MFContactoProveedor'); $("#txtCorreo_Contacto").focus(); return;
        }
    }
    if ($('#txtTelefono_Contacto').val() != "") {
        if (!regexTelefono.test($('#txtTelefono_Nuevo').val())) {
            fn_message("w", 'Número de teléfono inválido.', 'MFContactoProveedor'); $("#txtTelefono_Contacto").focus(); return;
        }
    }
    if ($('#txtCelular_Contacto').val() != "") {
        if (!regexTelefono.test($('#txtCelular_Nuevo').val())) {
            fn_message("w", 'Número de celular inválido.', 'MFContactoProveedor'); $("#txtCelular_Contacto").focus(); return;
        }
    }
    if ($('#cmbProveedor').val() == "0") {
        fn_message("w", 'Seleccione un proveedor.', 'MFContactoProveedor'); return;
    }

    var data = {
        cp: {
            id_contacto_proveedor: "0",
            nombres: $("#txtNombres_Contacto").val(),
            dni: $("#txtDni_Contacto").val(),
            correo: $("#txtCorreo_Contacto").val(),
            telefono: $("#txtTelefono_Contacto").val(),
            celular: $("#txtCelular_Contacto").val(),
            proveedor: { id_proveedor: $('#cmbProveedor').val() }
        }
    }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { fn_message("e", rpta.d.Mensaje, 'MFContactoProveedor'); return; }
        else if (rpta.d.Resultado == 'Check') { fn_message("w", rpta.d.Mensaje, 'MFContactoProveedor'); return; }
        $("#btnCerrarContactoProveedor").click();
        notify(rpta.d.Mensaje, 'success', 'center');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        fn_message("e", 'Error inesperado. Por favor, vuelta a intentarlo.', 'MFContactoProveedor');
    };

    fn_callmethod("gestionarContactoProveedor.aspx/Guardar_ContactoProveedor", JSON.stringify(data), success, error);
}