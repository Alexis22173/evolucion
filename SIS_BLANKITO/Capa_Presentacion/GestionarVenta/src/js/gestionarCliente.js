var tablaCliente;
var textoCombo = $("#cmbTipoCliente option:selected").html();
var objTemp;

$(function () {
    SetearMenu();
    ListarCliente(0);
    ListarTipoCliente();

    $("#btnGuardar").on("click", function () {
        GuardarCliente();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos();
    });

    $("#cmbTipoCliente").on("change", function () {
        textoCombo = $("#cmbTipoCliente option:selected").html();
        CambiarDocumento(textoCombo);
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
    $("#menu-venta").addClass("active toggled");
    $("#mv-cliente a").attr("class", "active");
}

function ListarCliente(edito) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objTemp = $.parseJSON(rpta.d.clientes);
        var tam = objTemp.length;
        if (tam == 0) { notify('No hay datos de clientes disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objTemp[i].nombres.toUpperCase() + '</td>' +
                         '<td>' + objTemp[i].tipo_cliente.descripcion.toUpperCase() + '</td>' +
                         '<td>' + objTemp[i].dni_ruc.toUpperCase() + '</td>' +
                         '<td>' + objTemp[i].correo.toUpperCase() + '</td>' +
                         '<td>' + objTemp[i].telefono + '</td>' +
                         '<td>' + objTemp[i].celular + '</td>' +
                         '<td>' + objTemp[i].direccion.toUpperCase() + '</td>' +
                         '<td style="display:none">' + objTemp[i].id_cliente + '</td>' +
                      '</tr>';
        }
        $("#tblCliente tbody").html(tabla);

        tablaCliente = $("#tblCliente").bootgrid({
            selection: true, multiSelect: true, rowSelect: true, keepSelection: true,
            formatters: {
                "commands": function (column, row) {
                    return "<button type=\"button\" class=\"btn btn-icon command-edit\" data-id=\"" + row.id + "\" onclick='MostrarCliente(\"" + row.id + "\")' style='width: 32px;height: 32px;margin-top: -13px;margin-bottom: -10px;'><span class=\"md md-edit\"></span></button>";
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

    fn_callmethod("gestionarCliente.aspx/Listar_Clientes", JSON.stringify({ edito: edito }), success, error);
}

function ListarTipoCliente() { 
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.tc);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de tipo cliente disponible.', 'inverse', 'center'); return; }
              
        for (var i = 0; i < tam; i++) {
            $("#cmbTipoCliente").append('<option value="' + obj[i].id_tipo_cliente + '">' + obj[i].descripcion.toUpperCase() + '</option>');
        }
        $('.selectpicker').selectpicker('refresh');
        $(".bs-searchbox input").attr("style", "position:initial"); //Para que aparesca el icono de busqueda en el combo
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarCliente.aspx/Listar_TipoCliente", "", success, error);
}

function GuardarCliente() {
    $(".alert").remove();

    if ($("#cmbTipoCliente").val() == "0" || $("#cmbTipoCliente").val() == undefined) {
        notify("Seleccione el tipo de cliente.", 'warning', 'center'); $("#cmbTipoCliente").focus(); return;
    }

    if ($("#txtDniRuc").val() == "") {
        notify("Ingrese el número de documento.", 'warning', 'center'); $("#txtDniRuc").focus(); return;
    } else if (!regexNumero.test($('#txtDniRuc').val())) {
        notify("Sólo números.", 'warning', 'center'); $("#txtDniRuc").focus(); return;
    } else if (textoCombo == "JURÍDICO") {
        if ($("#txtDniRuc").val().length != "11") {
            notify("Tiene que ingresar 11 dígitos.", 'warning', 'center'); $("#txtDniRuc").focus(); return;
        }
    } else if (textoCombo == "NATURAL") {
        if ($("#txtDniRuc").val().length != "8") {
            notify("Tiene que ingresar 8 dígitos.", 'warning', 'center'); $("#txtDniRuc").focus(); return;
        }
    }

    if ($("#txtNombres").val() == "") {
        notify("Ingrese los nombres.", 'warning', 'center'); $("#txtNombres").focus(); return;
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
        cliente: {
            id_cliente: $("#btnGuardar").attr("data-id") || "0",
            nombres: $("#txtNombres").val(),
            dni_ruc: $("#txtDniRuc").val(),
            direccion: $("#txtDireccion").val(),
            correo: $("#txtCorreo").val(),
            telefono: $("#txtTelefono").val(),
            celular: $("#txtCelular").val(),
            tipo_cliente: {
                id_tipo_cliente: $("#cmbTipoCliente").val(),
            }
        }
    }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
        else if (rpta.d.Resultado == 'Check') { notify(rpta.d.Mensaje, 'warning', 'center'); return; }
        notify(rpta.d.Mensaje, 'success', 'center');
        tablaCliente.bootgrid("destroy");
        ListarCliente(1);
        $("#btnCancelar").click();
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarCliente.aspx/Guardar_Cliente", JSON.stringify(data), success, error);
}

function LimpiarCampos() {
    $(":text").each(function () {
        $(this).val("");
    });
    $('.selectpicker').selectpicker('val', '0');
    //$("#cmbTipoCliente").trigger("chosen:updated");
    $("#btnGuardar").removeAttr("data-id");    
}

function CambiarDocumento(valor) {    
    if (valor == "JURÍDICO") {
        $("#txtDniRuc").attr("maxlength", "11");
        $("#txtDniRuc").attr("placeholder", "RUC");
    }else if (valor == "NATURAL") {
        $("#txtDniRuc").attr("maxlength", "8");
        $("#txtDniRuc").attr("placeholder", "DNI");
    } else {
        $("#txtDniRuc").attr("maxlength", "11");
        $("#txtDniRuc").attr("placeholder", "DNI / RUC");
    }
    $("#txtDniRuc").val("");
}

function MostrarCliente(id) {
    var len = objTemp.length;
    for (var i = 0; i < len; i++) {
        if (objTemp[i].id_cliente == id) {      
            if ($("#btnNuevo").attr("aria-expanded") == "false") {
                $("#btnNuevo").click();
            }

            $("#txtNombres").val(objTemp[i].nombres);
            $("#txtDniRuc").val(objTemp[i].dni_ruc);
            $("#txtDireccion").val(objTemp[i].direccion);
            $("#txtCorreo").val(objTemp[i].correo);
            $("#txtTelefono").val(objTemp[i].telefono);
            $("#txtCelular").val(objTemp[i].celular);
            $("#cmbTipoCliente").selectpicker('val', objTemp[i].tipo_cliente.id_tipo_cliente);
            //$("#cmbTipoCliente").trigger("chosen:updated");
            $("#btnGuardar").attr("data-id", objTemp[i].id_cliente);
            break;
        }
    }
}

function EliminarDatos() {    
    var tam = tablaCliente.bootgrid("getSelectedRows").length;
    if (tam > 0) {
        swal({
            title: "¿Está seguro?",
            text: (tam > 1 ? "¡Los clientes se eliminarán " : "¡El cliente se eliminará ") + " permanentemente!",
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
                    tablaCliente.bootgrid("destroy");
                    ListarCliente(1);
                    lista = [];
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarCliente.aspx/Eliminar_Datos", datos, success, error);
            }
        });
    }
    else { $(".alert").remove(); notify("Por favor seleccione al menos una fila para eliminar.", 'warning', 'center'); }
}

var lista = [];
function ListaTemporal() {
    tablaCliente.on("selected.rs.jquery.bootgrid", function (e, selectedRows)
    {
        var row;
        for (var i = 0; i < selectedRows.length; i++)
        {
            row = selectedRows[i];
            if (!lista.contains(function (item) { return item.id === row.id; }))
            {
                lista.push({ id: row.id });
            }
        }
    }).on("deselected.rs.jquery.bootgrid", function (e, deselectedRows)
    {
        var row;
        for (var i = 0; i < deselectedRows.length; i++)
        {
            row = deselectedRows[i];
            for (var j = 0; j < lista.length; j++)
            {
                if (lista[j].id === row.id)
                {
                    lista.splice(j, 1);
                    return;
                }
            }
        }
    });
}