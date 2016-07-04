var tablaSucursal;
var objTemp;

$(function () {
    SetearMenu();
    ListarSucursal();

    $("#btnGuardar").on("click", function () {
        GuardarSucursal();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos();
    });

    $("#tblSucursal").on("click", ".edita", function () {
        MostrarSucursal($(this).parent().parent().attr("data-id"));
    });

    $("#tblSucursal").on("click", ".elimina", function () {
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
    $("#menu-logistica").addClass("active toggled");
    $("#ml-sucursal a").attr("class", "active");
}

function ListarSucursal() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objTemp = $.parseJSON(rpta.d.s);
        var tam = objTemp.length;
        if (tam == 0) { notify('No hay datos de sucursal disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            var estado = objTemp[i].estado == '1' ? '<span class="badge bgm-lightgreen">ACTIVO</span>' : '<span class="badge bgm-red">INACTIVO</span>';
            tabla += '<tr data-id="' + objTemp[i].id_sucursal + '">' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objTemp[i].descripcion + '</td>' +
                         '<td>' + objTemp[i].direccion + '</td>' +
                         '<td>' + objTemp[i].telefono + '</td>' +
                         '<td>' + estado + '</td>' +
                         '<td>' +
                                "<a title='Modificar' class='btn bgm-green btn-sm edita' href='javascript:;' ><i class='md md-edit'></i> </a> " +
                                "<a title='Eliminar' class='btn bgm-red btn-sm elimina' href='javascript:;'><i class='md md-close'></i> </a> " +
                         '</td>' +
                      '</tr>';
        }
        tablaSucursal = $("#tblSucursal tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarSucursal.aspx/Listar_Sucursal", "", success, error);
}

function EliminarDatos(id) {
    $(".alert").remove();

    swal({
        title: "¿Está seguro?",
        text: "La Sucursal se Eliminará",
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
                ListarSucursal();
            };
            var error = function (xhr, ajaxOptions, thrownError) {
                notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
            };
            fn_callmethod("gestionarSucursal.aspx/Eliminar_Sucursal", JSON.stringify({ id: id }), success, error);
        }   
    });    
}

function MostrarSucursal(id) {
    var len = objTemp.length;
    for (var i = 0; i < len; i++) {
        if (objTemp[i].id_sucursal == id) {
            $("#txtDescripcion").val(objTemp[i].descripcion).focus();
            $("#txtDireccion").val(objTemp[i].direccion).focus();
            $("#txtTelefono").val(objTemp[i].telefono).focus();
            $("#btnGuardar").attr("data-id", objTemp[i].id_sucursal);

            if (objTemp[i].estado == 1) {
                $("#lblEstado").removeClass("bgm-red").addClass("bgm-lightgreen").html("ACTIVO");
            } else {
                $("#lblEstado").removeClass("bgm-lightgreen").addClass("bgm-red").html("INACTIVO");
            }
            break;
        }
    }
}

function GuardarSucursal() {
    $(".alert").remove();

    if ($("#txtDescripcion").val() == "") {
        notify("Ingrese una descripción.", 'warning', 'center'); $("#txtDescripcion").focus(); return;
    }
    if ($("#txtDireccion").val() == "") {
        notify("Ingrese una dirección.", 'warning', 'center'); $("#txtDireccion").focus(); return;
    }
    if ($("#txtTelefono").val() == "") {
        notify("Ingrese un numero de teléfono.", 'warning', 'center'); $("#txtTelefono").focus(); return;
    }

    data = {
        s: {
            id_sucursal: $("#btnGuardar").attr("data-id") || "0",
            descripcion: $("#txtDescripcion").val(),
            direccion: $("#txtDireccion").val(),
            telefono: $("#txtTelefono").val(),
            estado: $("#lblEstado").text() == "ACTIVO" ? 1 : 0
        }
    }
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
        else if (rpta.d.Resultado == 'Check') { notify(rpta.d.Mensaje, 'warning', 'center'); return; }
        notify(rpta.d.Mensaje, 'success', 'center');
        tablaSucursal.bootgrid("destroy");
        ListarSucursal();
        LimpiarCampos();
    }

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarSucursal.aspx/Guardar_Sucursal", JSON.stringify(data), success, error);
}

function LimpiarCampos() {
    $("#txtDescripcion").val("").blur();
    $("#txtDireccion").val("").blur();
    $("#txtTelefono").val("").blur();
    $("#lblEstado").removeClass("bgm-red").addClass("bgm-lightgreen").html("ACTIVO");
    $("#btnGuardar").removeAttr("data-id");
}