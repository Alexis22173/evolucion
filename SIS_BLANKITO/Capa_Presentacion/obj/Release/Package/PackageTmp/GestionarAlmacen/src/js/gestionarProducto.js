var tablaProducto;
var objProducto;

$(function () {
    SetearMenu();
    ListarProducto(0);
    ListarMarca();
    ListarCategoria();
    ListarSucursal();

    $("#btnGuardar").on("click", function () {
        GuardarProducto();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos();
    });

    $("#btnEliminar").on("click", function () {
        EliminarDatos();
    });

    $("#txtPrecioMin, #txtPrecioMax").keypress(function (e) {
        return ValidarDecimal(e, this);
    });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-almacen").addClass("active toggled");
    $("#ma-producto a").attr("class", "active");
}

function ListarProducto(edito) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objProducto = $.parseJSON(rpta.d.productos);
        var tam = objProducto.length;
        if (tam == 0) { notify('No hay productos disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objProducto[i].categoria.descripcion + '</td>' +
                         '<td>' + objProducto[i].marca.descripcion + '</td>' +
                         '<td>' + objProducto[i].descripcion + '</td>' +
                         '<td>' + objProducto[i].unidad_med + '</td>' +
                         '<td>S/. ' + objProducto[i].precio_min.toFixed(2) + '</td>' +
                         '<td>S/. ' + objProducto[i].precio_max.toFixed(2) + '</td>' +
                         '<td style="display:none">' + objProducto[i].id_producto + '</td>' +
                      '</tr>';
        }
        $("#tblProducto tbody").html(tabla);
        tablaProducto = $("#tblProducto").bootgrid({
            selection: true, multiSelect: true, rowSelect: true, keepSelection: true,
            formatters: {
                "commands": function (column, row) {
                    return "<button type=\"button\" class=\"btn btn-icon command-edit\" onclick='MostrarProducto(\"" + row.id + "\")' style='width: 32px;height: 32px;margin-top: -13px;margin-bottom: -10px;'><span class=\"md md-edit\"></span></button>";
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

    fn_callmethod("gestionarProducto.aspx/Listar_Productos", JSON.stringify({ edito: edito }), success, error);
}

function ListarMarca() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.m);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de marcas disponibles.', 'inverse', 'center'); return; }

        for (var i = 0; i < tam; i++) {
            $("#cmbMarca").append('<option value="' + obj[i].id_marca + '">' + obj[i].descripcion + '</option>');
        }
        $("#cmbMarca").selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarMarca.aspx/Listar_Marca", "", success, error);
}

function ListarCategoria() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.c);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de categorias disponibles.', 'inverse', 'center'); return; }

        for (var i = 0; i < tam; i++) {
            $("#cmbCategoria").append('<option value="' + obj[i].id_categoria + '">' + obj[i].descripcion + '</option>');
        }
        $("#cmbCategoria").selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarCategoria.aspx/Listar_Categoria", "", success, error);
}

function ListarSucursal() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.s);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de sucursal disponibles.', 'inverse', 'center'); return; }

        for (var i = 0; i < tam; i++) {
            $("#cmbSucursal").append('<option value="' + obj[i].id_sucursal + '">' + obj[i].descripcion + '</option>');
        }
        $("#cmbSucursal").selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("../GestionarLogistica/gestionarSucursal.aspx/Listar_Sucursal", "", success, error);
}

function MostrarProducto(id) {
    var len = objProducto.length;
    for (var i = 0; i < len; i++) {
        if (objProducto[i].id_producto == id) {
            if ($("#btnNuevo").attr("aria-expanded") == "false") {
                $("#btnNuevo").click();
            }

            $("#txtDescripcion").val(objProducto[i].descripcion).focus();
            $("#txtUnidadMedida").val(objProducto[i].unidad_med).focus();
            $("#txtPrecioMin").val(objProducto[i].precio_min).focus();
            $("#txtPrecioMax").val(objProducto[i].precio_max).focus();
            $("#cmbCategoria").selectpicker('val', objProducto[i].categoria.id_categoria);
            $("#cmbMarca").selectpicker('val', objProducto[i].marca.id_marca);
            $("#btnGuardar").attr("data-id", id);
            break;
        }
    }
}

function GuardarProducto() {
    $(".alert").remove();

    if ($("#cmbCategoria").val() == "0" || $("#cmbCategoria").val() == undefined) {
        notify("Seleccione una categoría.", 'warning', 'center'); $("#cmbCategoria").click(); return;
    }

    if ($("#cmbMarca").val() == "0" || $("#cmbMarca").val() == undefined) {
        notify("Seleccione una marca.", 'warning', 'center'); $("#cmbMarca").click(); return;
    }

    if ($("#txtDescripcion").val() == "") {
        notify("Ingrese el nombre del producto.", 'warning', 'center'); $("#txtDescripcion").focus(); return;
    }

    //if ($("#txtUnidadMedida").val() == "") {
    //    notify("Ingrese la unidad de medida del producto.", 'warning', 'center'); $("#txtUnidadMedida").focus(); return;
    //}

    if ($('#txtPrecioMin').val() != "") {
        if (!regexPrecio.test($('#txtPrecioMin').val())) {
            notify("Ingrese un precio mínimo válido.", 'warning', 'center'); $("#txtPrecioMin").focus(); return;
        }
    }

    if ($('#txtPrecioMax').val() != "") {
        if (!regexPrecio.test($('#txtPrecioMax').val())) {
            notify("Ingrese un precio máximo válido.", 'warning', 'center'); $("#txtPrecioMax").focus(); return;
        }
    }

    var data = {
        producto: {
            id_producto: $("#btnGuardar").attr("data-id") || "0",
            descripcion: $("#txtDescripcion").val(),
            unidad_med: $("#txtUnidadMedida").val(),
            precio_min: $("#txtPrecioMin").val(),
            precio_max: $("#txtPrecioMax").val(),
            categoria: { id_categoria: $("#cmbCategoria").val() },
            marca: { id_marca: $("#cmbMarca").val() },
            estado: 1
        }
    }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
        else if (rpta.d.Resultado == 'Check') { notify(rpta.d.Mensaje, 'warning', 'center'); return; }
        notify(rpta.d.Mensaje, 'success', 'center');
        tablaProducto.bootgrid("destroy");
        ListarProducto(1);
        $("#btnCancelar").click();
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarProducto.aspx/Guardar_Producto", JSON.stringify(data), success, error);
}

function LimpiarCampos() {
    $(":text").each(function () {
        $(this).val("").blur();
    });
    $('.selectpicker').selectpicker('val', '0');
    $("#btnGuardar").removeAttr("data-id");
}

function EliminarDatos() {
    var tam = tablaProducto.bootgrid("getSelectedRows").length;
    if (tam > 0) {
        swal({
            title: "¿Está seguro?",
            text: (tam > 1 ? "¡Los productos se eliminarán " : "¡El producto se eliminará ") + " permanentemente!",
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
                    tablaProducto.bootgrid("destroy");
                    ListarProducto(1);
                    lista = [];
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarProducto.aspx/Eliminar_Datos", datos, success, error);
            }
        });
    }
    else { $(".alert").remove(); notify("Por favor seleccione al menos una fila para eliminar.", 'warning', 'center'); }
}

var lista = [];
function ListaTemporal() {
    tablaProducto.on("selected.rs.jquery.bootgrid", function (e, selectedRows) {
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