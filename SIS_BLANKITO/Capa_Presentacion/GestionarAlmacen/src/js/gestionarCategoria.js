var tablaCategoria;
var objTemp;

$(function () {
    SetearMenu();
    ListarCategoria();

    $("#btnGuardar").on("click", function () {
        GuardarCategoria();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos();
    });

    $("#tblCategoria").on("click", ".edita", function () {
        MostrarCategoria($(this).parent().parent().attr("data-id"));
    });

    $("#tblCategoria").on("click", ".elimina", function () {
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
    $("#menu-almacen").addClass("active toggled");
    $("#ma-categoria a").attr("class", "active");
}

function ListarCategoria() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objTemp = $.parseJSON(rpta.d.c);
        var tam = objTemp.length;
        if (tam == 0) { notify('No hay datos de tipo pago disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            var estado = objTemp[i].estado == '1' ? '<span class="badge bgm-lightgreen">ACTIVO</span>' : '<span class="badge bgm-red">INACTIVO</span>';
            tabla += '<tr data-id="' + objTemp[i].id_categoria + '">' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objTemp[i].descripcion + '</td>' +
                         '<td>' + estado + '</td>' +
                         '<td>' +
                                "<a title='Modificar' class='btn bgm-green btn-sm edita' href='javascript:;' ><i class='md md-edit'></i> </a> " +
                                "<a title='Eliminar' class='btn bgm-red btn-sm elimina' href='javascript:;'><i class='md md-close'></i> </a> " +
                         '</td>' +
                      '</tr>';
        }
        tablaCategoria = $("#tblCategoria tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarCategoria.aspx/Listar_Categoria", "", success, error);
}

function EliminarDatos(id) {
    $(".alert").remove();

    swal({
        title: "¿Está seguro?",
        text: "La Categoria se Eliminará",
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
                ListarCategoria();
            };
            var error = function (xhr, ajaxOptions, thrownError) {
                notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
            };
            fn_callmethod("gestionarCategoria.aspx/Eliminar_Categoria", JSON.stringify({ id: id }), success, error);
            }    
    });   
}

function MostrarCategoria(id) {
    var len = objTemp.length;
    for (var i = 0; i < len; i++) {
        if (objTemp[i].id_categoria == id) {
            $("#txtDescripcion").val(objTemp[i].descripcion).focus();
            $("#btnGuardar").attr("data-id", objTemp[i].id_categoria);

            if (objTemp[i].estado == 1) {
                $("#lblEstado").removeClass("bgm-red").addClass("bgm-lightgreen").html("ACTIVO");
            } else {
                $("#lblEstado").removeClass("bgm-lightgreen").addClass("bgm-red").html("INACTIVO");
            }
            break;
        }
    }
}

function GuardarCategoria() {
    $(".alert").remove();

    if ($("#txtDescripcion").val() == "") {
        notify("Ingrese una descripción.", 'warning', 'center'); $("#txtDescripcion").focus(); return;
    }

    data = {
        c: {
            id_categoria: $("#btnGuardar").attr("data-id") || "0",
            descripcion: $("#txtDescripcion").val(),
            estado: $("#lblEstado").text() == "ACTIVO" ? 1 : 0
        }
    }
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }
        else if (rpta.d.Resultado == 'Check') { notify(rpta.d.Mensaje, 'warning', 'center'); return; }
        notify(rpta.d.Mensaje, 'success', 'center');
        tablaCategoria.bootgrid("destroy");
        ListarCategoria();
        LimpiarCampos();
    }

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarCategoria.aspx/Guardar_Categoria", JSON.stringify(data), success, error);
}

function LimpiarCampos() {
    $("#txtDescripcion").val("").blur();;
    $("#lblEstado").removeClass("bgm-red").addClass("bgm-lightgreen").html("ACTIVO");
    $("#btnGuardar").removeAttr("data-id");
}