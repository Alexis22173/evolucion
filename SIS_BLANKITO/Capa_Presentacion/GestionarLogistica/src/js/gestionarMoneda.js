var tablaMoneda;
var objTemp;

$(function () {
    SetearMenu();
    ListarMoneda();

    $("#btnGuardar").on("click", function () {
        GuardarMoneda();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos();
    });

    $("#tblMoneda").on("click", ".edita", function () {
        MostrarMoneda($(this).parent().parent().attr("data-id"));
    });

    $("#tblMoneda").on("click", ".elimina", function () {
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
    $("#mm-tmoneda a").attr("class", "active");
}

function ListarMoneda() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objTemp = $.parseJSON(rpta.d.m);
        var tam = objTemp.length;
        if (tam == 0) { notify('No hay datos de sucursal disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            var estado = objTemp[i].estado == '1' ? '<span class="badge bgm-lightgreen">ACTIVO</span>' : '<span class="badge bgm-red">INACTIVO</span>';
            tabla += '<tr data-id="' + objTemp[i].id_moneda + '">' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objTemp[i].descripcion + '</td>' +                         
                         '<td>' + estado + '</td>' +
                         '<td>' +
                                "<a title='Modificar' class='btn bgm-green btn-sm edita' href='javascript:;' ><i class='md md-edit'></i> </a> " +
                                "<a title='Eliminar' class='btn bgm-red btn-sm elimina' href='javascript:;'><i class='md md-close'></i> </a> " +
                         '</td>' +
                      '</tr>';
        }
        tablaMoneda = $("#tblMoneda tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarMoneda.aspx/Listar_Moneda", "", success, error);
}

function EliminarDatos(id) {
    $(".alert").remove();

    swal({
        title: "¿Está seguro?",
        text: "El tipo de Moneda se Eliminará",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        cancelButtonText: "Cancelar",
        confirmButtonText: "Eliminar",
        closeOnConfirm: false
    }, function (confirma) {
        if (confirma) {
            var success = function (rpta) {
                if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
                swal("¡ELIMINADO!", rpta.d.Mensaje, 'success');
                ListarMoneda();
            };
            var error = function (xhr, ajaxOptions, thrownError) {
                notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
            };
            fn_callmethod("gestionarMoneda.aspx/Eliminar_Moneda", JSON.stringify({ id: id }), success, error);
        }
    });
}

function MostrarMoneda(id) {
    var len = objTemp.length;
    for (var i = 0; i < len; i++) {
        if (objTemp[i].id_moneda == id) {
            $("#txtDescripcion").val(objTemp[i].descripcion).focus();           
            $("#btnGuardar").attr("data-id", objTemp[i].id_moneda);

            if (objTemp[i].estado == 1) {
                $("#lblEstado").removeClass("bgm-red").addClass("bgm-lightgreen").html("ACTIVO");
            } else {
                $("#lblEstado").removeClass("bgm-lightgreen").addClass("bgm-red").html("INACTIVO");
            }
            break;
        }
    }
}

function GuardarMoneda() {
    $(".alert").remove();

    if ($("#txtDescripcion").val() == "") {
        notify("Ingrese una descripción.", 'warning', 'center'); $("#txtDescripcion").focus(); return;
    }  

    data = {
        m: {
            id_moneda: $("#btnGuardar").attr("data-id") || "0",
            descripcion: $("#txtDescripcion").val(),           
            estado: $("#lblEstado").text() == "ACTIVO" ? 1 : 0
        }
    }
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
        else if (rpta.d.Resultado == 'Check') { notify(rpta.d.Mensaje, 'warning', 'center'); return; }
        notify(rpta.d.Mensaje, 'success', 'center');
        tablaMoneda.bootgrid("destroy");
        ListarMoneda();
        LimpiarCampos();
    }

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarMoneda.aspx/Guardar_Moneda", JSON.stringify(data), success, error);
}

function LimpiarCampos() {
    $("#txtDescripcion").val("").blur();   
    $("#lblEstado").removeClass("bgm-red").addClass("bgm-lightgreen").html("ACTIVO");
    $("#btnGuardar").removeAttr("data-id");
}