var tablaTipoCliente;
var objTemp;

$(function () {
    SetearMenu();
    ListarTipoCliente();

    $("#btnGuardar").on("click", function () {
        GuardarTipoCliente();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos();
    });

    $("#tblTipoCliente").on("click", ".edita", function () {
        MostrarTipoCliente($(this).parent().parent().attr("data-id"));
    });

    $("#tblTipoCliente").on("click", ".elimina", function () {
        EliminarDatos($(this).parent().parent().attr("data-id"));
    });

    $("#lblEstado").on("click", function () {
        if ($("#lblEstado").hasClass("bgm-lightgreen")) {
            $("#lblEstado").removeClass("bgm-lightgreen").addClass("bgm-red").html("INACTIVO");
        }
        else {
            $("#lblEstado").removeClass("bgm-red").addClass("bgm-lightgreen").html("ACTIVO");
        }
    });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-maestro").addClass("active toggled");
    $("#mm-tcliente a").attr("class", "active");
}

function ListarTipoCliente() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objTemp = $.parseJSON(rpta.d.tc);
        var tam = objTemp.length;
        if (tam == 0) { notify('No hay datos de tipo documento disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            var estado = objTemp[i].estado == '1' ? '<span class="badge bgm-lightgreen">ACTIVO</span>' : '<span class="badge bgm-red">INACTIVO</span>';
            tabla += '<tr data-id="' + objTemp[i].id_tipo_cliente + '">' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objTemp[i].descripcion + '</td>' +
                         '<td>' + estado + '</td>' +
                         '<td>' +
                                "<a title='Modificar' class='btn bgm-green btn-sm edita' href='javascript:;' ><i class='md md-edit'></i> </a> " +
                                "<a title='Eliminar' class='btn bgm-red btn-sm elimina' href='javascript:;'><i class='md md-close'></i> </a> " +
                         '</td>' +
                      '</tr>';
        }
        tablaTipoCliente = $("#tblTipoCliente tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarTipoCliente.aspx/Listar_TipoCliente", "", success, error);
}

function EliminarDatos(id) {
    $(".alert").remove();

    swal({
        title: "¿Está seguro?",
        text: "El Tipo de Cliente se Eliminará",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        cancelButtonText: "Cancelar",
        confirmButtonText: "Eliminar",
        closeOnConfirm: false
    },function(confirma){
        if(confirma){
            var success = function (rpta) {
                if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
                swal("¡ELIMINADO!",rpta.d.Mensaje, 'success');
                ListarTipoCliente();
            };
            var error = function (xhr, ajaxOptions, thrownError) {
                notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
            };
            fn_callmethod("gestionarTipoCliente.aspx/Eliminar_TipoCliente", JSON.stringify({ id: id }), success, error);
            }    
    });   
}

function MostrarTipoCliente(id) {
    var len = objTemp.length;
    for (var i = 0; i < len; i++) {
        if (objTemp[i].id_tipo_cliente == id) {
            $("#txtDescripcion").val(objTemp[i].descripcion).focus();
            $("#btnGuardar").attr("data-id", id);

            if (objTemp[i].estado == 1) {
                $("#lblEstado").removeClass("bgm-red").addClass("bgm-lightgreen").html("ACTIVO");
            } else {
                $("#lblEstado").removeClass("bgm-lightgreen").addClass("bgm-red").html("INACTIVO");
            }
            break;
        }
    }
}

function GuardarTipoCliente() {
    $(".alert").remove();

    if ($("#txtDescripcion").val() == "") {
        notify("Ingrese una descripción.", 'warning', 'center'); $("#txtDescripcion").focus(); return;
    }

    data = {
        tc: {
            id_tipo_cliente: $("#btnGuardar").attr("data-id") || "0",
            descripcion: $("#txtDescripcion").val(),
            estado: $("#lblEstado").text() == "ACTIVO" ? 1 : 0
        }
    }
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
        else if (rpta.d.Resultado == 'Check') { notify(rpta.d.Mensaje, 'warning', 'center'); return; }
        notify(rpta.d.Mensaje, 'success', 'center');
        tablaTipoCliente.bootgrid("destroy");
        ListarTipoCliente();
        LimpiarCampos();
    }

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarTipoCliente.aspx/Guardar_TipoCliente", JSON.stringify(data), success, error);
}

function LimpiarCampos() {
    $("#txtDescripcion").val("").blur();
    $("#lblEstado").removeClass("bgm-red").addClass("bgm-lightgreen").html("ACTIVO");
    $("#btnGuardar").removeAttr("data-id");
}