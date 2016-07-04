var objProducto;
var objProveedor;
var objContactoProveedor;
var tablaOrdenes;

$(function () {
    SetearMenu();
    SetearFechas();
    ListarMoneda();
    ListarProductos();
    ListarComboProveedor(1);

    $("#btnGuardar").on("click", function () {
        GuardarOrden();
    });

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

    $("#btnAgregar").on("click", function () {
        AgregarProducto();
    });

    $("#txtDniRucProveedor, #txtDniContacto, #txtDni_Contacto").keypress(function (e) {
        return ValidarNumeros(e);
    });

    $("#txtPrecio, #txtCantidad").keypress(function (e) {
        return ValidarDecimal(e, this);
    });

    $("#btnBuscar").on("click", function () {
        ListarOrdenesCompra();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos("frmOrden");
    });

    $(".textStyle").css({ "left": "-10px", "width": "110%" }); 
    $(".textStyleDesc").css({ "left": "-10px", "width": "105%" });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-compra").addClass("active toggled");
    $("#mc-orden a").attr("class", "active");
}

function SetearFechas() {
    var f = new Date();
    $('#txtFechaVencimiento').datetimepicker({ format: 'DD/MM/YYYY', minDate: f });

    $("#txtFechaInicio").on("dp.change", function (e) {
        $('#txtFechaFin').data("DateTimePicker").minDate(e.date);
    });
    $("#txtFechaFin").on("dp.change", function (e) {
        $('#txtFechaInicio').data("DateTimePicker").maxDate(e.date);
    });
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

function ListarProductos() {
    var success = function (rpta) {
        $("#tblProducto tbody").empty();
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objProducto = $.parseJSON(rpta.d.sp);
        var tam = objProducto.length;
        if (tam == 0) { notify('No hay productos disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objProducto[i].producto.categoria.descripcion + '</td>' +
                         '<td>' + objProducto[i].producto.marca.descripcion + '</td>' +
                         '<td>' + objProducto[i].producto.descripcion + '</td>' +
                         '<td>S/. ' + objProducto[i].cpm.toFixed(2) + '</td>' +
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

    fn_callmethod("gestionarOrdenCompra.aspx/Listar_Productos", "", success, error);
}

function SeleccionarProducto(id) {
    var len = objProducto.length;
    for (var i = 0; i < len; i++) {
        if (objProducto[i].producto.id_producto == id) {
            $("#txtDescripcion").val(objProducto[i].producto.descripcion);
            $("#txtPrecio").val(objProducto[i].cpm.toFixed(2));
            $("#btnAgregar").attr("data-id", id);

            $("#modalProducto").modal("hide");
            $("#txtDescripcion").focus();
            $("#txtPrecio").focus();
            $("#txtCantidad").focus();
            break;
        }
    }
}

function AgregarProducto() {
    $(".alert").remove();

    if ($("#btnAgregar").attr("data-id") == "" || $("#btnAgregar").attr("data-id") == undefined || $('#txtDescripcion').val() == "") {
        notify("Seleccione un producto.", 'warning', 'center'); return;
    } else if ($('#txtCantidad').val() == "" || $('#txtCantidad').val() <= "0") {
        notify("La cantidad debe ser mayor que 0", 'warning', 'center'); $("#txtCantidad").focus(); return;
    } else {

        var valida = 0;
        $("#tblDetalle tbody tr").each(function (index) {
            if ($(this).children("td:eq(0)").text() == $("#btnAgregar").attr("data-id")) { valida = 1; }
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

function GuardarOrden() {
    $(".alert").remove();

    if ($('#txtDniRucProveedor').val() == "" || $("#btnGuardar").attr("data-proveedor") == undefined) {
        notify("Ingrese el número de RUC y pulse enter o click en la lupa.", 'warning', 'center'); $("#txtDniRucProveedor").focus(); return;
    } else if ($('#txtDniContacto').val() == "" || $("#btnGuardar").attr("data-cp") == undefined) {
        notify("Ingrese el número de DNI y pulse enter o click en la lupa.", 'warning', 'center'); $("#txtDniContacto").focus(); return;
    } else if ($("#cmbMoneda").val() == null || $("#cmbMoneda").val() == "0") {
        notify("Seleccione una moneda.", 'warning', 'center'); return;
    } else if ($("#txtFechaVencimiento").val() == "") {
        notify("Ingrese la fecha de vencimiento", 'warning', 'center'); $("#txtFechaVencimiento").focus(); return;// falta validar
    } else if ($("#tblDetalle tbody tr").length == 0) {
        notify("Debe ingresar como mínimo un producto.", 'warning', 'center'); return;
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
                var orden, objDetalle;
                var lista = [];

                orden = {
                    id_orden_compra: $("#btnGuardar").attr("data-id") || "0",
                    fecha_vencimiento: $("#txtFechaVencimiento").val(),                    
                    proveedor: { id_proveedor: $("#btnGuardar").attr("data-proveedor") },
                    contacto_proveedor: { id_contacto_proveedor: $("#btnGuardar").attr("data-cp") },
                    moneda: { id_moneda: $("#cmbMoneda").val() },
                    sub_total: $("#lblSubtotal").text().substring(4),
                    igv: $("#lblIgv").text().substring(4),
                    total: $("#lblTotal").text().substring(4),
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
                    LimpiarCampos("frmOrden");
                    if (orden.id_orden_compra != "0") ListarOrdenesCompra();
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarOrdenCompra.aspx/Guardar_OrdenCompra", JSON.stringify({ o: orden, jsondata: detalle }), success, error);
            }
        });
    }
}

function LimpiarCampos(form) {
    $("#" + form + " :text").each(function () {
        $(this).val("").blur();
    });

    if (form == "frmOrden") {
        $("#btnGuardar").removeAttr("data-proveedor");
        $("#btnGuardar").removeAttr("data-cp");
        $("#tblDetalle tbody").empty();
        $("#lblSubtotal").html("S/. 0.00");
        $("#lblIgv").html("S/. 0.00");
        $("#lblTotal").html("S/. 0.00");
    }
    $('.selectpicker').selectpicker('val', '0');
}

//******************************************* METODOS PARA ORDENES DE COMPRAS YA REGISTRADOS ****************************************
function ListarOrdenesCompra() {
    $(".alert").remove();

    if ($("#txtFechaInicio").val() == "") {
        notify("Ingrese la fecha de inicio.", 'warning', 'center'); $("#txtFechaInicio").focus(); return;
    } else if ($("#txtFechaFin").val() == "") {
        notify("Ingrese la fecha de fin.", 'warning', 'center'); $("#txtFechaFin").focus(); return;
    }
    var data = { fecha_inicio: $("#txtFechaInicio").val(), fecha_fin: $("#txtFechaFin").val() }

    var success = function (rpta) {
        if (tablaOrdenes != undefined) tablaOrdenes.bootgrid("destroy");
        $("#tblOrdenCompra tbody").empty();

        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.oc);
        var tam = obj.length;
        if (tam == 0) { notify('No se registraron ordenes de compra en el rango de fechas asignado.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + obj[i].fecha + '</td>' +
                         '<td>' + obj[i].fecha_vencimiento + '</td>' +
                         '<td>' + obj[i].proveedor.razon_social + '</td>' +
                         '<td>' + obj[i].contacto_proveedor.nombres + '</td>' +
                         '<td>' + obj[i].moneda.descripcion + '</td>' +
                         '<td>' + obj[i].total.toFixed(2) + '</td>' +
                         '<td><span class="badge bgm-indigo">' + obj[i].estado + '</span></td>' +
                         '<td style="display:none">' + obj[i].id_orden_compra + '</td>'
                     '</tr>';
        }
        $("#tblOrdenCompra tbody").html(tabla);
        tablaOrdenes = $("#tblOrdenCompra").bootgrid({
            selection: true, multiSelect: true, rowSelect: true, keepSelection: true,
            formatters: {
                "commands": function (column, row) {
                    return "<button type='button' class='btn btn-info btn-sm' data-toogle='modal' data-target='#modalDetalleOrdenCompra' onclick='MostrarDetalleOrdenCompra(\"" + row.id + "\")' title='Detalle'><i class='md md-menu'></i></button> " +
                            "<a title='Modificar' class='btn btn-warning btn-sm' onclick='MostrarOrdenCompra(\"" + row.id + "\")' href='javascript:;' ><i class='md md-edit'></i> </a> " +
                            "<a title='Anular' class='btn btn-danger btn-sm' onclick='AnularOrdenCompra(\"" + row.id + "\")'><i class='md md-close'></i> </a> ";
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

    fn_callmethod("gestionarOrdenCompra.aspx/Listar_OrdenesCompra", JSON.stringify(data), success, error);
}

function MostrarDetalleOrdenCompra(id) {
    $(".alert").remove();

    var success = function (rpta) {
        $("#tblMostrarDetalle tbody").html("");
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.doc);
        var tam = obj.length;
        if (tam == 0) {  notify('La orden de compra seleccionado no existe o no tiene detalle.', 'inverse', 'center'); return; }        

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
        $('#modalDetalleOrdenCompra').modal('show');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarOrdenCompra.aspx/Mostrar_DetalleOrdenCompra", JSON.stringify({ id: id }), success, error);
}


function MostrarOrdenCompra(id) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.doc);
        var tam = obj.length;
        if (tam == 0) { notify('No existe la orden de compra seleccionada.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            $("#btnGuardar").attr("data-id", obj[i].orden_compra.id_orden_compra);
            $("#btnGuardar").attr("data-proveedor", obj[i].orden_compra.proveedor.id_proveedor);
            $("#btnGuardar").attr("data-cp", obj[i].orden_compra.contacto_proveedor.id_contacto_proveedor);
            $("#txtDniRucProveedor").val(obj[i].orden_compra.proveedor.dni_ruc);
            $("#txtRazonSocial").val(obj[i].orden_compra.proveedor.razon_social);
            $("#txtDniContacto").val(obj[i].orden_compra.contacto_proveedor.dni);
            $("#txtNombreContacto").val(obj[i].orden_compra.contacto_proveedor.nombres);
            $("#cmbMoneda").selectpicker('val', obj[i].orden_compra.moneda.id_moneda);
            $("#lblTotal").html("S/. " + obj[i].orden_compra.total.toFixed(2));
            $("#lblSubtotal").html("S/. " + obj[i].orden_compra.sub_total.toFixed(2));
            $("#lblIgv").html("S/. " + obj[i].orden_compra.igv.toFixed(2));
            $("#txtFechaVencimiento").val(obj[i].orden_compra.fecha_vencimiento);
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
        
        $("#txtDniRucProveedor").focus();
        $("#txtRazonSocial").focus();
        $("#txtDniContacto").focus();
        $("#txtNombreContacto").focus();
        $("#txtFechaVencimiento").focus();
        $("#btnAgregar").focus();
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarOrdenCompra.aspx/Mostrar_OrdenCompra", JSON.stringify({ id: id }), success, error);
}

function AnularOrdenCompra(id) {
    $(".alert").remove();

    swal({
        title: "¿Está seguro?",
        text: "La orden de compra se anulara permanentemente.",
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
                ListarOrdenesCompra();
            };

            var error = function (xhr, ajaxOptions, thrownError) {
                notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
            };

            fn_callmethod("gestionarOrdenCompra.aspx/Anular_OrdenCompra", JSON.stringify({ id: id }), success, error);
        }
    });
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
    var data = { edito: 1, id_proveedor: $("#btnGuardar").attr("data-proveedor")}
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
