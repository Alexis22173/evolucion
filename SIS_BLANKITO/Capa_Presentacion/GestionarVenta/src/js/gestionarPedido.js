var objProducto;
var objCliente;
var textoCombo;

$(function () {
    SetearMenu();    
    ListarPedidos(0);
    ListarTipoDocumento();
    ListarTipoCliente();
    ListarProductos();
    ListarClientes(1);

    $("#btnGuardar").on("click", function () {
        GuardarPedido();
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

    $("#txtDniRuc").keypress(function (e) {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if (keycode === 13) { MostrarCliente();}
    });

    $("#btnAgregar").on("click", function () {
        AgregarProducto();
    });

    $("#txtDniRuc, #txtDniRuc_Nuevo").keypress(function (e) {
        return ValidarNumeros(e);
    });    

    $("#txtPrecio, #txtCantidad").keypress(function (e) {
        return ValidarDecimal(e, this);
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos("frmPedido");
    });

    $(".textStyle").css({ "left": "-10px", "width": "110%" });
    $(".textStyleDesc").css({ "left": "-10px", "width": "105%" });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-venta").addClass("active toggled");
    $("#mv-pedido a").attr("class", "active");
}

function LimpiarCampos(form) {
    $("#" + form + " :text").each(function () {
        $(this).val("").blur();
    });

    if (form == "frmPedido") {        
        $("#tblDetalle tbody").empty();
        $("#lblSubtotal").html("S/. 0.00");
        $("#lblIgv").html("S/. 0.00");
        $("#lblTotal").html("S/. 0.00");
        $("#btnGuardar").removeAttr("data-cliente");
        $("#btnGuardar").removeAttr("data-id");
        $("#chkProducir").prop("checked", false);
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

function MostrarCliente() {
    $(".alert").remove();

    var dniruc = $("#txtDniRuc").val();
    if (dniruc.length != 8 && dniruc.length != 11) { notify('Ingrese la cantidad de digitos adecuados.', 'warning', 'center'); $("#txtDniRuc").focus(); return; }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.cliente);
        var tam = obj.length;
        if (tam == 0) {
            //notify('El número de documento no se encuentra registrado.', 'inverse', 'center');
            $("#modalListadoCliente").modal("show");
            fn_message("i", "El número de documento no se encuentra registrado, busque y seleccione uno; en caso contrario registre uno nuevo.", 'MLCliente');
            $("#txtNombre").val(""); $("#btnGuardar").removeAttr("data-cliente"); return;
        }

        $("#txtNombre").val(obj[0].nombres).focus();
        $("#btnGuardar").attr("data-cliente",obj[0].id_cliente);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarPedido.aspx/Mostrar_Cliente", JSON.stringify({ dniruc: dniruc }), success, error);
}

function ListarProductos() {
    var success = function (rpta) {
        $("#tblProducto tbody").empty();
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objProducto = $.parseJSON(rpta.d.sp);
        var tam = objProducto.length;
        if (tam == 0) { notify('No hay stock de productos disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objProducto[i].producto.categoria.descripcion + '</td>' +
                         '<td>' + objProducto[i].producto.marca.descripcion + '</td>' +
                         '<td>' + objProducto[i].producto.descripcion + '</td>' +
                         '<td>S/. ' + objProducto[i].producto.precio_min.toFixed(2) + '</td>' +
                         '<td>S/. ' + objProducto[i].producto.precio_max.toFixed(2) + '</td>' +
                         '<td>' + objProducto[i].stock + '</td>' +
                         '<td style="display:none">' + objProducto[i].producto.id_producto + '</td>' +
                      '</tr>';
        }
        $("#tblProducto tbody").html(tabla);
        $("#tblProducto").bootgrid({
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

    fn_callmethod("gestionarPedido.aspx/Listar_Productos", "", success, error);
}

function SeleccionarProducto(id) {
    var len = objProducto.length;
    for (var i = 0; i < len; i++) {
        if (objProducto[i].producto.id_producto == id) {
            if (objProducto[i].stock > "0") {
                $("#txtDescripcion").val(objProducto[i].producto.descripcion);
                $("#txtPrecio").val(objProducto[i].producto.precio_max.toFixed(2));
                $("#btnAgregar").attr("data-pmin", objProducto[i].producto.precio_min.toFixed(2));
                $("#btnAgregar").attr("data-stock", objProducto[i].stock);
                $("#btnAgregar").attr("data-id", id);

                $("#modalProducto").modal("hide");
                $("#txtDescripcion").focus();
                $("#txtPrecio").focus();
                $("#txtCantidad").focus();
            } else {
                fn_message("i", "No se cuenta con stock del producto seleccionado.", 'MLProducto');
            }            
            break;
        }
    }
}

function AgregarProducto() {
    $(".alert").remove();

    if ($("#btnAgregar").attr("data-id") == "" || $("#btnAgregar").attr("data-id") == undefined || $('#txtDescripcion').val() == "") {
        notify("Seleccione un producto.", 'warning', 'center'); return;
    } else if (parseFloat($("#txtPrecio").val()) < parseFloat($("#btnAgregar").attr("data-pmin"))) {
        notify("El precio no debe ser menor al precio mínimo: " + $("#btnAgregar").attr("data-pmin"), 'warning', 'center'); $("#txtPrecio").focus(); return;
    } else if ($('#txtCantidad').val() == "" || $('#txtCantidad').val() <= "0") {
        notify("La cantidad debe ser mayor que 0", 'warning', 'center'); $("#txtCantidad").focus(); return;
    } else if (parseInt($("#btnAgregar").attr("data-stock")) < parseInt($('#txtCantidad').val())) {
        notify("La cantidad debe ser menor o igual al stock: " + $("#btnAgregar").attr("data-stock"), 'warning', 'center'); $("#txtCantidad").focus(); return;
    } else {

        var valida = 0;
        $("#tblDetalle tbody tr").each(function (index) {
            if ($(this).children("td:eq(0)").text() == $("#btnAgregar").attr("data-id")) { valida = 1;}            
        });
        if (valida == 1) { notify("El producto ya se agregó en la lista.", 'warning', 'center'); return; }

        var precio_real = parseFloat($("#txtPrecio").val());
        var importe = precio_real * parseFloat($("#txtCantidad").val());
        var tabla = "";
        tabla = '<tr>' +
                     '<td class="hidden">' + $("#btnAgregar").attr("data-id") + '</td>' +
                     '<td class="text-center">' + $("#txtCantidad").val() + '</td>' +
                     '<td>' + $("#txtDescripcion").val() + '</td>' +
                     '<td>S/. ' + precio_real.toFixed(2) + '</td>' +
                     '<td>S/. ' + importe.toFixed(2) + '</td>' +
                     '<td><button class="btn bgm-deeporange btn-xs" onclick="QuitarFila(this)"><i class="md md-close"></i></button></td>' +
                '</tr>';
        $("#tblDetalle").append(tabla);
        Calcular();

        $("#txtDescripcion").val("").focus();
        $("#txtPrecio").val("").focus();
        $("#txtCantidad").val("").focus();
        $("#btnAgregar").removeAttr("data-pmin");
        $("#btnAgregar").removeAttr("data-stock");
        $("#btnAgregar").removeAttr("data-id").focus();
    }
}

function Calcular() {
    var totalVenta = 0, temporal = 0;
    $("#tblDetalle tbody tr").each(function (index) {
        temporal = $(this).children("td:eq(4)").text();
        totalVenta = totalVenta + parseFloat(temporal.substring(4));
    });

    subtotal = (totalVenta / 1.18);  
    igv = (totalVenta - subtotal);
    $("#lblSubtotal").html("S/. " + subtotal.toFixed(2));
    $("#lblIgv").html("S/. " + igv.toFixed(2));
    $("#lblTotal").html("S/. " + totalVenta.toFixed(2));
}

function QuitarFila(fila) {
    $(fila).parent().parent().remove()
    Calcular();
}

function GuardarPedido() {
    $(".alert").remove();

    if ($('#txtDniRuc').val() == "" || $("#btnGuardar").attr("data-cliente") == undefined) {
        notify("Ingrese el número de documento y pulse enter o click en la imagen.", 'warning', 'center'); $("#txtDniRuc").focus(); return;
    } else if ($("#cmbTipoDocumento").val() == null || $("#cmbTipoDocumento").val() == "") {
        notify("Seleccione el tipo de documento.", 'warning', 'center'); return;
    } else if ($("#tblDetalle tbody tr").length == 0) {
        notify("Debe ingresar como mínimo un producto.", 'warning', 'center'); return;
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
                var p, objDetalle;
                var lista = [];

                p = {
                    id_pedido: $("#btnGuardar").attr("data-id") || "0",
                    sub_total: $("#lblSubtotal").text().substring(4),
                    igv: $("#lblIgv").text().substring(4),
                    total: $("#lblTotal").text().substring(4),
                    cliente: { id_cliente: $("#btnGuardar").attr("data-cliente") },
                    tipo_documento: { id_tipo_documento: $("#cmbTipoDocumento").val().toString() },
                    produccion: $("#chkProducir").is(":checked") ? 1 : 0
                }


                $("#tblDetalle tbody tr").each(function (index) {
                    objDetalle = { id_producto: "", cantidad: "", descripcion: "", precio: "", importe: "" };
                    objDetalle.id_producto = $(this).children("td:eq(0)").text();
                    objDetalle.cantidad = $(this).children("td:eq(1)").text();
                    objDetalle.descripcion = $(this).children("td:eq(2)").text();
                    objDetalle.precio = $(this).children("td:eq(3)").text().substring(4);
                    objDetalle.importe = $(this).children("td:eq(4)").text().substring(4);
                    lista[index] = objDetalle;
                });
                var detalle = JSON.stringify(lista);

                var success = function (rpta) {
                    if (rpta.d.Resultado == 'NoOk') { swal("Error!", rpta.d.Mensaje, "error"); return; }
                    swal("¡Registrado!", rpta.d.Mensaje, "success");
                    ListarPedidos(1);
                    LimpiarCampos("frmPedido");
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarPedido.aspx/Guardar_Pedido", JSON.stringify({ p: p, jsondata: detalle }), success, error);
            }
        });
    }
}

//********************** METODOS PARA PEDIDOS YA REGISTRADOS ***************************************************************************************
function ListarPedidos(edito) {
    var success = function (rpta) {
        $("#tblPedidos tbody").empty();

        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.pedidos);
        var tam = obj.length;
        if (tam == 0) { notify('No hay Pedidos pendientes.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + obj[i].fecha + '</td>' +
                         '<td>' + obj[i].tipo_documento.descripcion + '</td>' +
                         '<td>' + obj[i].numero + '</td>' +
                         '<td>' + obj[i].cliente.dni_ruc + '</td>' +
                         '<td>' + obj[i].cliente.nombres + '</td>' +
                         '<td>' + obj[i].total.toFixed(2) + '</td>' +
                         '<td><span class="badge bgm-indigo">' + obj[i].estado + '</span></td>' +
                         '<td>' +
                                "<button type='button' class='btn btn-info btn-sm' data-toogle='modal' data-target='#modalPedido' onclick='MostrarDetallePedido(\"" + obj[i].id_pedido + "\")' title='Detalle'><i class='md md-menu'></i></button> " +
                                "<a title='Modificar' class='btn btn-warning btn-sm' onclick='MostrarPedido(\"" + obj[i].id_pedido + "\")' href='javascript:;' ><i class='md md-edit'></i> </a> " +
                                "<a title='Anular' class='btn btn-danger btn-sm' onclick='AnularPedido(\"" + obj[i].id_pedido + "\")'><i class='md md-close'></i> </a> " +
                         '</td>' +
                      '</tr>';
        }
        $("#tblPedidos tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarPedido.aspx/Listar_Pedidos", JSON.stringify({ edito: edito }), success, error);
}

function MostrarDetallePedido(id) {
    $(".alert").remove();

    var success = function (rpta) {
        $("#tblMostrarDetalle tbody").html("");
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.dp);
        var tam = obj.length;
        if (tam == 0) { notify('El pedido seleccionado no existe o no tiene detalle.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                            '<td>' + (i + 1) + "</td>" +
                            '<td>' + obj[i].cantidad + '</td>' +
                            '<td>' + obj[i].descripcion + '</td>' +
                            '<td>' + obj[i].precio.toFixed(2) + '</td>' +
                            '<td>' + obj[i].importe.toFixed(2) + '</td>' +
                        '</tr>';
        }
        $("#tblMostrarDetalle tbody").html(tabla);
        $('#modalPedido').modal('show');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarPedido.aspx/Mostrar_DetallePedido", JSON.stringify({ id: id }), success, error);
}

function AnularPedido(id) {
    $(".alert").remove();

    swal({
        title: "¿Está seguro?",
        text: "El pedido se anulara permanentemente.",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        cancelButtonText: "Cancelar",
        confirmButtonText: "Anular",
        closeOnConfirm: false
    }, function (confirma) {
        if (confirma) {
            var success = function (rpta) {
                if (rpta.d.Resultado == 'NoOk') { swal("Error!", rpta.d.Mensaje, "error"); return; }
                swal("¡Anulado!", rpta.d.Mensaje, "success");
                ListarPedidos(1);
            };

            var error = function (xhr, ajaxOptions, thrownError) {
                notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
            };

            fn_callmethod("gestionarPedido.aspx/Anular_Pedido", JSON.stringify({ id: id }), success, error);
        }
    });   
}

function MostrarPedido(id) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.ps);
        var tam = obj.length;
        if (tam == 0) { notify('No existe el pedido seleccionado.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            $("#btnGuardar").attr("data-id", obj[i].pedido.id_pedido);
            $("#btnGuardar").attr("data-cliente", obj[i].pedido.cliente.id_cliente)
            $("#txtDniRuc").val(obj[i].pedido.cliente.dni_ruc);
            $("#txtNombre").val(obj[i].pedido.cliente.nombres);
            $("#cmbTipoDocumento").selectpicker('val', obj[i].pedido.tipo_documento.id_tipo_documento);

            obj[i].pedido.produccion == "1" ? $("#chkProducir").prop("checked", true) : $("#chkProducir").prop("checked", false);

            $("#lblTotal").html("S/. " + obj[i].pedido.total.toFixed(2));
            $("#lblSubtotal").html("S/. " + obj[i].pedido.sub_total.toFixed(2));
            $("#lblIgv").html("S/. " + obj[i].pedido.igv.toFixed(2));

            tabla += '<tr>' +
                     '<td class="hidden">' + obj[i].producto.id_producto + '</td>' +
                     '<td class="text-center">' + obj[i].cantidad + '</td>' +
                     '<td>' + obj[i].descripcion + '</td>' +
                     '<td>S/. ' + obj[i].precio.toFixed(2) + '</td>' +
                     '<td>S/. ' + obj[i].importe.toFixed(2) + '</td>' +
                     '<td><button class="btn bgm-deeporange btn-xs" onclick="QuitarFila(this)"><i class="md md-close"></i></button></td>' +
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

//***************************************************************************************************************************************************

//********************** METODOS NECESARIOS PARA GUARDAR AL CLIENTE MEDIANTE EL COMBO ***************************************************************
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