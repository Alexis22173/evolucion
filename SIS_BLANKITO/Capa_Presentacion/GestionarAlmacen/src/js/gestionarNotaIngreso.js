var objProducto;

$(function () {
    SetearMenu();
    SetearFechas();
    ListarMotivo();
    ListarProductos();

    $("#btnAgregar").on("click", function () {
        AgregarProducto();
    });

    $("#btnGuardar").on("click", function () {
        GuardarNotaIngreso();
    });

    $("#btnEliminar").on("click", function () {
        EliminarDatos();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos();
    });

    $("#txtCantidad").keypress(function (e) {
        return ValidarDecimal(e, this);
    });

    $("#cmbMotivo").on("change", function () {
        ListarOrdenes($("#cmbMotivo option:selected").html());
    });

    $(".textStyleDesc").css({ "left": "-10px", "width": "105%" });
    $(".textStyleNumero").css({ "left": "-10px", "width": "115%" });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-almacen").addClass("active toggled");
    $("#ma-notaingreso a").attr("class", "active");
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

function ListarMotivo() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.m);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de motivos disponible.', 'inverse', 'center'); return; }

        for (var i = 0; i < tam; i++) {
            $("#cmbMotivo").append('<option value="' + obj[i].id_motivo + '">' + obj[i].descripcion + '</option>');
        }
        $('.selectpicker').selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarNotaIngreso.aspx/Listar_Motivo", "", success, error);
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

    fn_callmethod("gestionarNotaIngreso.aspx/Listar_Productos", "", success, error);
}

function SeleccionarProducto(id) {
    var len = objProducto.length;
    for (var i = 0; i < len; i++) {
        if (objProducto[i].producto.id_producto == id) {
            $("#txtDescripcion").val(objProducto[i].producto.descripcion);
            $("#btnAgregar").attr("data-id", id);

            $("#modalProducto").modal("hide");
            $("#txtDescripcion").focus();
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

        var tabla = "";
        tabla = '<tr>' +
                     '<td class="hidden">' + $("#btnAgregar").attr("data-id") + '</td>' +
                     '<td class="text-center">' + $("#txtCantidad").val() + '</td>' +
                     '<td>' + $("#txtDescripcion").val() + '</td>' +
                     '<td><button class="btn bgm-deeporange btn-xs" onclick="QuitarFila(this)"><i class="md md-close"></i></button></td>' +
                '</tr>';
        $("#tblDetalle").append(tabla);

        $("#txtDescripcion").val("").focus();
        $("#txtCantidad").val("").focus();
        $("#btnAgregar").removeAttr("data-id").focus();
    }
}

function QuitarFila(fila) {
    $(fila).parent().parent().remove();
}

function ListarOrdenes(tipo) {
    $(".alert").remove();
    var success = function (rpta) {
        $("#textoOrden").html("");
        $("#textoOrden").removeAttr("style");
        $("#tblOrdenes tbody").html("");
        $("#tblDetalle tbody").html("");
        $("#btnGuardar").removeAttr("data-motivo");

        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.o);
        var tam = obj.length;
        if (tam == 0) { notify('No hay ordenes disponible.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr style="cursor:pointer" class="numeroOrden" onclick="MostrarDetalleOrden(\'' + obj[i].id_orden_compra + '\', this)">' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + obj[i].numero + '</td>' +
                         '<td>' + obj[i].fecha + '</td>' +
                     '</tr>';
        }
        $("#tblOrdenes tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarNotaIngreso.aspx/Listar_Ordenes", JSON.stringify({ tipo: tipo }), success, error);
}

function MostrarDetalleOrden(id, fila) {
    $(".alert").remove();
    $("#textoOrden").removeAttr("style");
    var success = function (rpta) {
        $("#tblDetalle tbody").html("");
        $("#btnGuardar").removeAttr("data-motivo");

        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.doc);
        var tam = obj.length;
        if (tam == 0) { notify('La orden de compra seleccionado no existe o no tiene detalle.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                            '<td class="hidden">' + obj[i].producto.id_producto + '</td>' +
                            '<td class="text-center">' + obj[i].cantidad + '</td>' +
                            '<td>' + obj[i].descripcion + '</td>' +
                            '<td><button class="btn bgm-deeporange btn-xs" onclick="QuitarFila(this)"><i class="md md-close"></i></button></td>' +
                        '</tr>';
        }
        $("#tblDetalle tbody").html(tabla);
        $("#textoOrden").html($(fila).children("td:nth-child(2)").html());
        $("#textoOrden").css({ "padding": "5px 20px", "font-size": "18px", "color": "white", "background-color": "rgba(255, 255, 255, 0.26)" });
        var idTemporal = $("#cmbMotivo option:selected").html() +"|"+id;
        $("#btnGuardar").attr("data-motivo", idTemporal);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("../GestionarCompra/gestionarOrdenCompra.aspx/Mostrar_DetalleOrdenCompra", JSON.stringify({ id: id }), success, error);
}

function GuardarNotaIngreso() {
    $(".alert").remove();

    if ($("#cmbMotivo").val() == null || $("#cmbMotivo").val() == "0") {
        notify("Seleccione un motivo de ingreso.", 'warning', 'center'); return;
    } else if ($("#btnGuardar").attr("data-motivo") == undefined) {
        notify("Selecciona una orden del listado.", 'warning', 'center'); return;
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
                var nota, objDetalle;
                var lista = [];

                ni = {
                    id_nota_ingreso: $("#btnGuardar").attr("data-id") || "0",
                    motivo: { id_motivo: $("#cmbMotivo").val() },
                    observacion: $("#txtObservacion").val()
                }

                $("#tblDetalle tbody tr").each(function (index) {
                    objDetalle = { id_producto: "", cantidad: "", descripcion: "" };
                    objDetalle.id_producto = $(this).children("td:eq(0)").text();
                    objDetalle.cantidad = $(this).children("td:eq(1)").text();
                    objDetalle.descripcion = $(this).children("td:eq(2)").text();
                    lista[index] = objDetalle;
                });
                var detalle = JSON.stringify(lista);

                var success = function (rpta) {
                    if (rpta.d.Resultado == 'NoOk') { swal("Error!", rpta.d.Mensaje, "error"); return; }
                    swal("¡Registrado!", rpta.d.Mensaje, "success");
                    LimpiarCampos();
                    //if (ni.id_nota_ingreso != "0") ListarOrdenesCompra();
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarNotaIngreso.aspx/Guardar_NotaIngreso", JSON.stringify({ ni: ni, jsondata: detalle, tipo: $("#btnGuardar").attr("data-motivo") }), success, error);
            }
        });
    }
}

function LimpiarCampos() {
    $('#txtDescripcion').val("").blur();
    $('#txtCantidad').val("").blur();
    $('#txtObservacion').val("").blur();
    $("#btnGuardar").removeAttr("data-motivo");
    $("#tblDetalle tbody").empty();
    $("#tblOrdenes tbody").empty();
    $('.selectpicker').selectpicker('val', '0');
    $("#textoOrden").html("");
    $("#textoOrden").removeAttr("style");
}