var tablaVenta;
var objCliente;
var textoCombo;

$(function () {
    SetearMenu();
    ListarVentas(0);
    ListarPedidos();
    ListarPedidosProduccion();
    ListarTipoDocumento();
    ListarTipoPago();
    ListarTipoCliente();
    ListarClientes(1);

    $("#btnGuardar").on("click", function () {
        GuardarVenta();
    });

    $("#txtDniRuc").keypress(function (e) {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if (keycode === 13) { MostrarCliente(); }
    });
        
    $("#btnModalCliente").on("click", function () {
        LimpiarCampos("modalCliente");
    });

    $("#cmbTipoCliente_Nuevo").on("change", function () {
        textoCombo = $("#cmbTipoCliente_Nuevo option:selected").html();
        CambiarDocumento(textoCombo);
    });

    $("#btnGuardarCliente").on("click", function () {
        GuardarCliente();
    });

    $("#txtDniRuc, #txtDniRuc_Nuevo").keypress(function (e) {
        return ValidarNumeros(e);
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos("frmVenta");
    });

    $(".textStyle").css({ "left": "-10px", "width": "110%" });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-venta").addClass("active toggled");
    $("#mv-caja a").attr("class", "active");
}

function LimpiarCampos(form) {
    $("#" + form + " :text").each(function () {
        $(this).val("").blur();
    });

    if (form == "frmVenta") {
        $("#btnGuardar").removeAttr("data-cliente");
        $("#btnGuardar").removeAttr("data-pedido");
        $("#tblDetalle tbody").empty();
        $("#lblSubtotal").html("S/. 0.00");
        $("#lblIgv").html("S/. 0.00");
        $("#lblTotal").html("S/. 0.00");
    }
    $('.selectpicker').selectpicker('deselectAll');
}

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

function ListarVentas(edito) {
    var success = function (rpta) {
        if (tablaVenta != undefined) tablaVenta.bootgrid("destroy");
        $("#tblVenta tbody").empty();
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.ventas);
        var tam = obj.length;
        if (tam == 0) { notify('No hay ventas registradas durante el día.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + obj[i].fecha + '</td>' +
                         '<td>' + obj[i].numero_documento.tipo_documento.descripcion + '</td>' +
                         '<td>' + obj[i].serie + ' - ' + obj[i].numero + '</td>' +
                         '<td>' + obj[i].cliente.dni_ruc + '</td>' +
                         '<td>' + obj[i].cliente.nombres + '</td>' +
                         '<td>' + obj[i].tipo_pago.descripcion + '</td>' +
                         '<td>' + obj[i].total.toFixed(2) + '</td>' +
                         '<td style="display:none">' + obj[i].id_venta + '</td>' +
                      '</tr>';
        }
        $("#tblVenta tbody").html(tabla);
        tablaVenta = $("#tblVenta").bootgrid({
            formatters: {
                "commands": function (column, row) {
                    return "<button type=\"button\" class=\"btn bgm-lightgreen btn-icon\" onclick='SeleccionarProducto(\"" + row.id + "\")' style='width: 32px;height: 32px;margin-top: -13px;margin-bottom: -10px;'><span class=\"md md-check\"></span></button>";
                }
            }
        });

        var temp = $(".actionBar .actions").children("div:nth-child(2)").children("ul").children("ul li:last-child").prev();
        //temp.children().children().children(":first-child").click();
        temp.remove();
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarVenta.aspx/Listar_Ventas", JSON.stringify({ edito: edito }), success, error);
}

function MostrarCliente() {
    $(".alert").remove();

    var dniruc = $("#txtDniRuc").val();
    if (dniruc.length != 8 && dniruc.length != 11) { notify('Ingrese la cantidad de digitos adecuados.', 'warning', 'center'); $("#txtDniRuc").focus(); return; }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.cliente);
        var tam = obj.length;
        if (tam == 0) {
            $("#modalListadoCliente").modal("show");
            fn_message("i", "El número de documento no se encuentra registrado, busque y seleccione uno; en caso contrario registre uno nuevo.", 'MLCliente');
            $("#txtNombre").val(""); $("#btnGuardar").removeAttr("data-cliente"); return;
        }

        $("#txtNombre").val(obj[0].nombres).focus();
        $("#btnGuardar").attr("data-cliente", obj[0].id_cliente);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarPedido.aspx/Mostrar_Cliente", JSON.stringify({ dniruc: dniruc }), success, error);
}

function GuardarVenta() {
    $(".alert").remove();

    if ($('#txtDniRuc').val() == "" || $("#btnGuardar").attr("data-cliente") == undefined) {
        notify("Ingrese el número de documento y pulse o buscar.", 'warning', 'center'); $("#txtDniRuc").focus(); return;
    } else if ($("#cmbTipoDocumento").val() == null || $("#cmbTipoDocumento").val() == "") {
        notify("Seleccione el tipo de documento.", 'warning', 'center'); return;
    } else if ($("#cmbTipoPago").val() == null || $("#cmbTipoPago").val() == "") {
        notify("Seleccione el tipo de pago.", 'warning', 'center'); return;
    } else if ($("#tblDetalle tbody tr").length == 0) {
        notify("Seleccione el pedido.", 'warning', 'center'); return;
    } else if ($("#cmbTipoDocumento option:selected").html() == "BOLETA" && $('#txtDniRuc').val().length != 8) {
        notify("Seleccione el tipo de documento de acuerdo al tipo de cliente.", 'warning', 'center'); return;
    } else if ($("#cmbTipoDocumento option:selected").html() == "FACTURA" && $('#txtDniRuc').val().length != 11) {
        notify("Seleccione el tipo de documento de acuerdo al tipo de cliente.", 'warning', 'center'); return;
    }
    else {
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
                var v = {
                    id_venta: $("#btnGuardar").attr("data-id") || "0",                    
                    cliente: { id_cliente: $("#btnGuardar").attr("data-cliente") },
                    tipo_pago: { id_tipo_pago: $("#cmbTipoPago").val().toString() },
                    pedido: { id_pedido: $("#btnGuardar").attr("data-pedido") },
                    total: $("#lblTotal").text().substring(4),
                }
                var td = $("#cmbTipoDocumento").val().toString();

                var success = function (rpta) {
                    if (rpta.d.Resultado == 'NoOk') { swal("Error!", rpta.d.Mensaje, "error"); return; }
                    swal("¡Registrado!", rpta.d.Mensaje, "success");

                    $("#diarios").hasClass("active") == true ? ListarPedidos() : ListarPedidosProduccion();
                    LimpiarCampos("frmVenta");
                    //tablaVenta.bootgrid("destroy");
                    ListarVentas(1);
                    
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarVenta.aspx/Guardar_Venta", JSON.stringify({ v: v, td: td }), success, error);
            }
        });
    }
}

//********************** METODOS PARA LISTAR Y CARGAR EL PEDIDO SELECCIOANADO ********************************************************************
function ListarPedidos() {
    var success = function (rpta) {
        $("#tblPedidos tbody").empty

        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.pedidos);
        var tam = obj.length;
        
        var tabla = "";
        for (var i = 0; i < tam; i++) {            
            tabla += "<tr style='cursor:pointer' onclick='MostrarPedido(\"" + obj[i].id_pedido + "\")'>" +
                         "<td>" + obj[i].numero + "</td>" +
                         "<td> S/. " + obj[i].total.toFixed(2) + "</td>" +
                         "<td>" + obj[i].cliente.nombres + "</td>" +
                    "</tr>";
        }
        $("#tblPedidos tbody").html(tabla)
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarPedido.aspx/Listar_Pedidos", JSON.stringify({ edito: 1 }), success, error);
}

function ListarPedidosProduccion() {
    var success = function (rpta) {
        $("#tblProduccion tbody").empty();

        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.pp);
        var tam = obj.length;

        var tabla = "";
        for (var i = 0; i < tam; i++) {            
            tabla += "<tr style='cursor:pointer' onclick='MostrarPedido(\"" + obj[i].id_pedido + "\")'>" +
                         "<td>" + obj[i].numero + "</td>" +
                         "<td> S/. " + obj[i].total.toFixed(2) + "</td>" +
                         "<td>" + obj[i].cliente.nombres + "</td>" +
                    "</tr>";
        }
        $("#tblProduccion tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarPedido.aspx/Listar_PedidosProduccion", "", success, error);
}

function MostrarPedido(id) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.ps);
        var tam = obj.length;
        if (tam == 0) { notify('No existe el pedido seleccionado.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            $("#btnGuardar").attr("data-pedido", obj[i].pedido.id_pedido);
            $("#btnGuardar").attr("data-cliente", obj[i].pedido.cliente.id_cliente)
            $("#txtDniRuc").val(obj[i].pedido.cliente.dni_ruc);
            $("#txtNombre").val(obj[i].pedido.cliente.nombres);
            $("#cmbTipoDocumento").selectpicker('val', obj[i].pedido.tipo_documento.id_tipo_documento);
            $("#lblTotal").html("S/. " + obj[i].pedido.total.toFixed(2));
            $("#lblSubtotal").html("S/. " + obj[i].pedido.sub_total.toFixed(2));
            $("#lblIgv").html("S/. " + obj[i].pedido.igv.toFixed(2));

            tabla += '<tr>' +
                         '<td>'+ (i + 1) +'</td>' +
                         '<td class="text-center">' + obj[i].cantidad + '</td>' +
                         '<td>' + obj[i].descripcion + '</td>' +
                         '<td>S/. ' + obj[i].precio + '</td>' +
                         '<td>S/. ' + obj[i].importe + '</td>' +
                    '</tr>';

        }
        $("#tblDetalle tbody").html(tabla);
        $("#txtDniRuc").focus();
        $("#txtNombre").focus();
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarPedido.aspx/Mostrar_Pedido", JSON.stringify({ id: id }), success, error);
}

//********************** METODOS NECESARIOS PARA GUARDAR AL CLIENTE MEDIANTE EL POPUP ***************************************************************
function ListarTipoCliente() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.tc);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de tipo cliente disponible.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            $("#cmbTipoCliente_Nuevo").append('<option value="' + obj[i].id_tipo_cliente + '">' + obj[i].descripcion.toUpperCase() + '</option>');
        }
        $('.selectpicker').selectpicker('refresh');
        $(".bs-searchbox input").attr("style", "position:initial");
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarCliente.aspx/Listar_TipoCliente", "", success, error);
}

function GuardarCliente() {
    $(".alert").remove();

    if ($("#cmbTipoCliente_Nuevo").val() == "0" || $("#cmbTipoCliente_Nuevo").val() == undefined) {
        fn_message("w", 'Seleccione el tipo de cliente.', 'MFCliente'); return;
    }

    if ($("#txtDniRuc_Nuevo").val() == "") {
        fn_message("w", "Ingrese el número de documento.", 'MFCliente'); $("#txtDniRuc_Nuevo").focus(); return;
    } else if (!regexNumero.test($('#txtDniRuc_Nuevo').val())) {
        fn_message("w", "Sólo números.", 'MFCliente'); $("#txtDniRuc_Nuevo").focus(); return;
    } else if (textoCombo == "JURÍDICO") {
        if ($("#txtDniRuc_Nuevo").val().length != "11") {
            fn_message("w", "Tiene que ingresar 11 dígitos.", 'MFCliente'); $("#txtDniRuc_Nuevo").focus(); return;
        }
    } else if (textoCombo == "NATURAL") {
        if ($("#txtDniRuc_Nuevo").val().length != "8") {
            fn_message("w", "Tiene que ingresar 8 dígitos.", 'MFCliente'); $("#txtDniRuc_Nuevo").focus(); return;
        }
    }

    if ($("#txtNombres_Nuevo").val() == "") {
        fn_message("w", "Ingrese los nombres.", 'MFCliente'); $("#txtNombres_Nuevo").focus(); return;
    }

    if ($('#txtCorreo_Nuevo').val() != "") {
        if (!regexCorreo.test($('#txtCorreo_Nuevo').val())) {
            fn_message("w", "Correo electrónico inválido.", 'MFCliente'); $("#txtCorreo_Nuevo").focus(); return;
        }
    }
    if ($('#txtTelefono_Nuevo').val() != "") {
        if (!regexTelefono.test($('#txtTelefono_Nuevo').val())) {
            fn_message("w", "Número de teléfono inválido.", 'MFCliente'); $("#txtTelefono_Nuevo").focus(); return;
        }
    }
    if ($('#txtCelular_Nuevo').val() != "") {
        if (!regexTelefono.test($('#txtCelular_Nuevo').val())) {
            fn_message("w", "Número de celular inválido.", 'MFCliente'); $("#txtCelular_Nuevo").focus(); return;
        }
    }

    var data = {
        cliente: {
            id_cliente: "0",
            nombres: $("#txtNombres_Nuevo").val(),
            dni_ruc: $("#txtDniRuc_Nuevo").val(),
            direccion: $("#txtDireccion_Nuevo").val(),
            correo: $("#txtCorreo_Nuevo").val(),
            telefono: $("#txtTelefono_Nuevo").val(),
            celular: $("#txtCelular_Nuevo").val(),
            tipo_cliente: {
                id_tipo_cliente: $("#cmbTipoCliente_Nuevo").val(),
            }
        }
    }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { fn_message("e", rpta.d.Mensaje, 'MFCliente'); return; }
        else if (rpta.d.Resultado == 'Check') { fn_message("w", rpta.d.Mensaje, 'MFCliente'); return; }
        $("#btnCerrarCliente").click();
        notify(rpta.d.Mensaje, 'success', 'center');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        fn_message("e", "Error inesperado. Por favor, vuelta a intentarlo.", 'MFCliente');
    };

    fn_callmethod("gestionarCliente.aspx/Guardar_Cliente", JSON.stringify(data), success, error);
}

function CambiarDocumento(valor) {
    if (valor == "JURÍDICO") {
        $("#txtDniRuc_Nuevo").attr("maxlength", "11");
        $("#txtDniRuc_Nuevo").attr("placeholder", "RUC");
    } else if (valor == "NATURAL") {
        $("#txtDniRuc_Nuevo").attr("maxlength", "8");
        $("#txtDniRuc_Nuevo").attr("placeholder", "DNI");
    } else {
        $("#txtDniRuc_Nuevo").attr("maxlength", "11");
        $("#txtDniRuc_Nuevo").attr("placeholder", "DNI / RUC");
    }
    $("#txtDniRuc_Nuevo").val("");
}

function ListarClientes(edito) {
    var success = function (rpta) {
        $("#tblCliente tbody").empty();
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objCliente = $.parseJSON(rpta.d.clientes);
        var tam = objCliente.length;
        if (tam == 0) { notify('No hay datos de clientes disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objCliente[i].nombres + '</td>' +
                         '<td>' + objCliente[i].tipo_cliente.descripcion + '</td>' +
                         '<td>' + objCliente[i].dni_ruc + '</td>' +
                         '<td style="display:none">' + objCliente[i].id_cliente + '</td>' +
                      '</tr>';
        }
        $("#tblCliente tbody").html(tabla);
        $("#tblCliente").bootgrid({
            formatters: {
                "commands": function (column, row) {
                    return "<button type=\"button\" class=\"btn bgm-lightgreen btn-icon\" onclick='SeleccionarCliente(\"" + row.id + "\")' style='width: 32px;height: 32px;margin-top: -13px;margin-bottom: -10px;'><span class=\"md md-check\"></span></button>";
                }
            }
        });

        var temp = $(".actionBar .actions").children("div:nth-child(2)").children("ul").children("ul li:last-child").prev();
        //temp.children().children().children(":first-child").click();
        temp.remove();
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarCliente.aspx/Listar_Clientes", JSON.stringify({ edito: edito }), success, error);
}

function SeleccionarCliente(id) {
    var len = objCliente.length;
    for (var i = 0; i < len; i++) {
        if (objCliente[i].id_cliente == id) {
            $("#txtNombre").val(objCliente[i].nombres).focus();
            $("#txtDniRuc").val(objCliente[i].dni_ruc);
            $("#btnGuardar").attr("data-cliente", objCliente[i].id_cliente);
            $("#modalListadoCliente").modal("hide");
            break;
        }
    }
}