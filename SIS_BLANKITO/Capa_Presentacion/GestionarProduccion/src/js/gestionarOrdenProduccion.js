var objProducto;
var objPersonal;
var fechaActual = new Date();

$(function () {
    SetearMenu();
    SetearFechas();
    ListarMotivo();
    ListarPedidosProduccion();
    ListarProductos(0);    
    ListarPersonal(0, 0);

    $("#btnGuardar").on("click", function () {
        GuardarOrdenProduccion();
    });

    $("#btnAgregar").on("click", function () {
        AgregarPersonal();
    });

    $("#btnCancelar").on("click", function () {
        LimpiarCampos("frmOrden");
    });

    $("#cmbMotivo").on("change", function () {
        MostrarCombo($("#cmbMotivo option:selected").html());
    });

    $("#txtDniPersonal").keypress(function (e) {
        return ValidarNumeros(e);
    });

    $("#txtCantidad").keypress(function (e) {
        return ValidarDecimal(e, this);
    });

    $('#txtFechaEntrega').datetimepicker({ format: 'DD/MM/YYYY HH:mm', minDate: fechaActual });
    $(".textStyle").css({ "left": "-10px", "width": "110%" });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-produccion").addClass("active toggled");
    $("#mp-orden a").attr("class", "active");
}

function SetearFechas() {
    $('#detalleFechaIni').datetimepicker({ format: 'DD/MM/YYYY HH:mm', minDate: fechaActual });
    $('#detalleFechaFin').datetimepicker({ format: 'DD/MM/YYYY HH:mm', minDate: fechaActual });

    $("#detalleFechaIni").on("dp.change", function (e) {
        $('#detalleFechaFin').data("DateTimePicker").minDate(e.date);
    });

    $("#detalleFechaFin").on("dp.change", function (e) {
        $('#detalleFechaIni').data("DateTimePicker").maxDate(e.date);
    });
}

//function SetearFechas(indice) {
//    $('#detalleFechaIni' + indice).datetimepicker({ format: 'DD/MM/YYYY HH:mm', minDate: fechaActual });
//    $('#detalleFechaFin' + indice).datetimepicker({ format: 'DD/MM/YYYY HH:mm', minDate: fechaActual });
//    var tiempoIniTemp = "";
//    var tiempoFinTemp = "";

//    $("#detalleFechaIni" + indice).on("dp.change", function (e) {
//        $('#detalleFechaFin' + indice).data("DateTimePicker").minDate(e.date);
//        tiempoIniTemp = e.date._d;
//        //tiempoIniTemp = e.date._d.getDate() + "/" + (e.date._d.getMonth() + 1) + "/" + e.date._d.getFullYear() + " " + e.date._d.getHours() + ":" + e.date._d.getMinutes();
//    });
//    $("#detalleFechaFin" + indice).on("dp.change", function (e) {
//        $('#detalleFechaIni' + indice).data("DateTimePicker").maxDate(e.date);
//        tiempoFinTemp = e.date._d
//        //tiempoFinTemp = e.date._d.getDate() + "/" + (e.date._d.getMonth() + 1) + "/" + e.date._d.getFullYear() + " " + e.date._d.getHours() + ":" + e.date._d.getMinutes();
//    });
//    alert(tiempoIniTemp - tiempoFinTemp);
//}

function ListarMotivo() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.m);
        var tam = obj.length;
        if (tam == 0) { notify('No hay datos de motivos disponible.', 'inverse', 'center'); return; }

        for (var i = 0; i < tam; i++) {
            $("#cmbMotivo").append('<option value="' + obj[i].id_motivo + '">' + obj[i].descripcion + '</option>');
        }
        //$('.selectpicker').selectpicker('refresh');
        $('#cmbMotivo').selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarOrdenProduccion.aspx/Listar_Motivo", "", success, error);
}

function ListarPedidosProduccion() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.pp);
        var tam = obj.length;

        for (var i = 0; i < tam; i++) {
            $("#cmbTipo").append('<option value="' + obj[i].id_pedido + '">' + obj[i].numero + " - " +obj[i].cliente.nombres + '</option>');
        }
        $("#cmbTipo").selectpicker('refresh');
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("../GestionarVenta/gestionarPedido.aspx/Listar_PedidosProduccion", "", success, error);
}

function MostrarCombo(tipo) {
    if (tipo.indexOf("PEDIDO") != -1) {
        $("#cmbTipo").removeAttr("disabled");
        $('.selectpicker').selectpicker('refresh');
    } else {
        $("#cmbTipo").attr("disabled", "disabled");
        $('.selectpicker').selectpicker('refresh');
    }
}

function GuardarOrdenProduccion() {
    $(".alert").remove();
    if ($('#cmbMotivo').val() == null || $('#cmbMotivo').val() == "" || $('#cmbMotivo').val() == "0") {
        notify("Seleccione un motivo.", 'warning', 'center'); return;
    } else if ($('#txtObservacion').val() == "") {
        notify("Ingrese la observación.", 'warning', 'center'); $("#txtObservacion").focus(); return;
    } else if ($('#txtFechaEntrega').val() == "") {
        notify("Ingrese la fecha de entrega.", 'warning', 'center'); $("#txtFechaEntrega").focus(); return;
    } else if ($('#txtCodigoProducto').val() == "" || $("#btnGuardar").attr("data-producto") == undefined) {
        notify("Ingrese el código del producto y pulse enter o click en la lupa.", 'warning', 'center'); $("#txtCodigoProducto").focus(); return;
    }  else if ($('#txtCantidad').val() == "") {
        notify("Ingrese la cantidad del producto.", 'warning', 'center'); $("#txtCantidad").focus(); return;
    } else if ($('#txtDescripcionProducto').val() == "") {
        notify("Ingrese la descripción del producto.", 'warning', 'center'); $("#txtDescripcionProducto").focus(); return;
    } else if ($("#tblDetallePersonal tbody tr").length == 0) {
        notify("Debe ingresar como mínimo un personal.", 'warning', 'center'); return;
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
                    id_orden_produccion: $("#btnGuardar").attr("data-id") || "0",
                    descripcion: $("#txtObservacion").val(),
                    fecha_entrega: $("#txtFechaEntrega").val(),
                    motivo: { id_motivo: $("#cmbMotivo").val() },
                    id_pedido: $("#cmbTipo").val(),
                    producto: { id_producto: $("#btnGuardar").attr("data-producto") },
                    descripcion_producto: $("#txtDescripcionProducto").val(),
                    cantidad: $("#txtCantidad").val()
                }


                $("#tblDetallePersonal tbody tr").each(function (index) {
                    objDetalle = { id_personal: "", fecha_hora_inicio: "", fecha_hora_fin: "", costo: "" };
                    objDetalle.id_personal = $(this).children("td:eq(0)").text();
                    objDetalle.fecha_hora_inicio = $(this).children("td:eq(3)").text();
                    objDetalle.fecha_hora_fin = $(this).children("td:eq(4)").text();
                    objDetalle.costo = $(this).children("td:eq(5)").text().substring(4);
                    lista[index] = objDetalle;
                });
                var detalle = JSON.stringify(lista);

                var success = function (rpta) {
                    if (rpta.d.Resultado == 'NoOk') { swal("Error!", rpta.d.Mensaje, "error"); return; }
                    swal("¡Registrado!", rpta.d.Mensaje, "success");
                    LimpiarCampos("frmOrdenProduccion");
                    //if (orden.id_orden_produccion != "0") ListarOrdenesCompra();
                };

                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };

                fn_callmethod("gestionarOrdenProduccion.aspx/Guardar_OrdenProduccion", JSON.stringify({ op: orden, jsondata: detalle }), success, error);
            }
        });
    }
}

function LimpiarCampos(form) {
    $("#" + form + " :text").each(function () {
        $(this).val("").blur();
    });

    if (form == "frmOrdenProduccion") {
        $("#btnGuardar").removeAttr("data-producto");
        $("#tblDetallePersonal tbody").empty();
        $("#txtObservacion").val("").blur();
    }
    $('.selectpicker').selectpicker('val', '0');
}


//******************************************************** MÉTODOS PARA EL PRODUCTO *********************************************************
function ListarProductos(codprod) {
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

    fn_callmethod("gestionarOrdenProduccion.aspx/Listar_Productos", JSON.stringify({ codprod: codprod }), success, error);
}

function SeleccionarProducto(id) {
    var len = objProducto.length;
    for (var i = 0; i < len; i++) {
        if (objProducto[i].producto.id_producto == id) {
            $("#txtDescripcionProducto").val(objProducto[i].producto.descripcion).focus();;
            $("#modalListadoProducto").modal("hide");
            $("#txtCantidad").focus();
            $("#btnGuardar").attr("data-producto", objProducto[i].producto.id_producto);
            break;
        }
    }
}

function MostrarProducto() {
    $(".alert").remove();

    var codprod = $("#txtCodigoProducto").val();
    if (codprod == "") { notify('Ingrese el código del producto.', 'warning', 'center'); $("#txtCodigoProducto").focus(); return; }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.sp);
        var tam = obj.length;

        if (tam == 0) {
            $("#modalListadoProducto").modal("show");
            fn_message("i", "El código del producto no se encuentra registrado, busque y seleccione uno.", 'MLProducto');
            $("#txtDescripcionProducto").val(""); $("#btnGuardar").removeAttr("data-producto"); return;
        }

        $("#txtDescripcionProducto").val(obj[0].producto.descripcion).focus();
        $("#btnGuardar").attr("data-producto", obj[0].producto.id_producto);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("gestionarOrdenProduccion.aspx/Listar_Productos", JSON.stringify({ codprod: codprod }), success, error);
}

//******************************************************** MÉTODOS PARA EL PERSONAL *********************************************************
function MostrarPersonal() {
    $(".alert").remove();

    var dni = $("#txtDniPersonal").val();
    if (dni == "") { notify('Ingrese el número de dni.', 'warning', 'center'); $("#txtDniPersonal").focus(); return; }

    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        var obj = $.parseJSON(rpta.d.personal);
        var tam = obj.length;

        if (tam == 0) {
            $("#modalListadoPersonal").modal("show");
            fn_message("i", "El número de dni no se encuentra registrado, busque y seleccione uno.", 'MLPersonal');
            $("#txtNombrePersonal").val(""); $("#btnAgregar").removeAttr("data-personal"); $("#btnAgregar").removeAttr("data-costo"); return;
        }

        $("#txtNombrePersonal").val(obj[0].nombres + ' ' + obj[0].apellido_paterno + ' ' + obj[0].apellido_materno).focus();
        $("#btnAgregar").attr("data-personal", obj[0].id_personal);
        $("#btnAgregar").attr("data-costo", obj[0].sueldo_hora);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("../gestionarRRHH/gestionarPersonal.aspx/Listar_Personal", JSON.stringify({ edito: 1, id_personal: 0, dni: dni }), success, error);
}

function ListarPersonal(id_personal, dni) {
    var data = { edito: 1, id_personal: id_personal, dni: dni }
    var success = function (rpta) {
        $("#tblPersonal tbody").empty();
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger', 'center'); return; }

        objPersonal = $.parseJSON(rpta.d.personal);
        var tam = objPersonal.length;
        if (tam == 0) { notify('No hay datos de personal disponibles.', 'inverse', 'center'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr>' +
                         '<td>' + (i + 1) + "</td>" +
                         '<td>' + objPersonal[i].nombres + ' ' + objPersonal[i].apellido_paterno + ' ' + objPersonal[i].apellido_materno + '</td>' +
                         '<td class="text-center">' + objPersonal[i].dni + '</td>' +
                         '<td>' + objPersonal[i].correo + '</td>' +
                         '<td class="text-center">' + objPersonal[i].telefono + '</td>' +
                         '<td class="text-center">' + objPersonal[i].celular + '</td>' +
                         '<td class="text-center"><button type="button" class="btn bgm-lightgreen btn-icon" onclick="SeleccionarPersonal(\'' + objPersonal[i].id_personal + '\')" style="width: 32px;height: 32px;margin-top: -13px;margin-bottom: -10px;"><span class="md md-check"></span></button></td>' +
                      '</tr>';
        }
        $("#tblPersonal tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
    };

    fn_callmethod("../gestionarRRHH/gestionarPersonal.aspx/Listar_Personal", JSON.stringify(data), success, error);
}

function SeleccionarPersonal(id) {
    var len = objPersonal.length;
    for (var i = 0; i < len; i++) {
        if (objPersonal[i].id_personal == id) {
            $("#txtNombrePersonal").val(objPersonal[i].nombres + ' ' + objPersonal[i].apellido_paterno + ' ' + objPersonal[i].apellido_materno).focus();
            $("#txtDniPersonal").val(objPersonal[i].dni).focus();
            $("#btnAgregar").attr("data-personal", objPersonal[i].id_personal);
            $("#btnAgregar").attr("data-costo", objPersonal[i].sueldo_hora);
            $("#modalListadoPersonal").modal("hide");
            break;
        }
    }
}

function AgregarPersonal() {
    $(".alert").remove();

    if ($("#btnAgregar").attr("data-personal") == "" || $("#btnAgregar").attr("data-personal") == undefined || $('#txtDniPersonal').val() == "") {
        notify("Seleccione un personal.", 'warning', 'center'); return;
    } else if ($('#txtNombrePersonal').val() == "") {
        notify("El nombre del personal no debe estar vacío", 'warning', 'center'); $("#txtNombrePersonal").focus(); return;
    } else if ($('#detalleFechaIni').val() == "") {
        notify("Ingrese la fecha y hora de incio", 'warning', 'center'); $("#detalleFechaIni").focus(); return;
    } else if ($('#detalleFechaFin').val() == "") {
        notify("Ingrese la fecha y hora de incio", 'warning', 'center'); $("#detalleFechaFin").focus(); return;
    } else {

        var intervalo = IntervaloFechas($('#detalleFechaIni').val(), $('#detalleFechaFin').val());
        //var dias = intervalo.split(" ")[0];
        var horas = intervalo.split(" ")[0];
        var minutos = intervalo.split(" ")[1];
        minutos = minutos / 60;

        var costo_hora = parseInt(horas) * parseFloat($("#btnAgregar").attr("data-costo"));
        var costo_minuto = parseFloat(minutos) * parseFloat($("#btnAgregar").attr("data-costo"));
        var costo = costo_hora + costo_minuto;

        var valida = 0, indice = 0;
        $("#tblDetallePersonal tbody tr").each(function (index) {
            if ($(this).children("td:eq(0)").text() == $("#btnAgregar").attr("data-personal")) { valida = 1; return false;}
            indice++;
        });
        if (valida == 1) { notify("El personal ya se agregó en la lista.", 'warning', 'center'); return; }

        var tabla = "";
        tabla = '<tr>' +
                     '<td class="hidden">' + $("#btnAgregar").attr("data-personal") + '</td>' +
                     '<td class="text-center">' + (indice + 1) + '</td>' +
                     '<td>' + $("#txtNombrePersonal").val() + '</td>' +
                     '<td>' + $("#detalleFechaIni").val() + '</td>' +
                     '<td>' + $("#detalleFechaFin").val() + '</td>' +
                     //'<td>' +
                     //   '<div class="form-group fg-float" style="margin-bottom: 0px;">' +
                     //       '<div class="fg-line">' +
                     //           '<input type="text" class="form-control text-center fg-input date-time-picker" data-toggle="dropdown" id="detalleFechaIni' + indice + '"/>' +
                     //       '</div>'+
                     //   '</div>'+
                     //'</td>' +
                     //'<td>' +
                     //   '<div class="form-group fg-float" style="margin-bottom: 0px;">' +
                     //       '<div class="fg-line">' +
                     //           '<input type="text" class="form-control text-center fg-input date-time-picker" data-toggle="dropdown" id="detalleFechaFin' + indice + '"/>' +
                     //       '</div>' +
                     //   '</div>' +
                     //'</td>' +
                     '<td>S/. ' + costo.toFixed(2) + '</td>' +
                     '<td><button class="btn bgm-deeporange btn-xs" onclick="QuitarFila(this)"><i class="md md-close"></i></button></td>' +
                '</tr>';
        $("#tblDetallePersonal").append(tabla);
        SetearFechas(indice);

        $("#txtDniPersonal").val("").focus();
        $("#txtNombrePersonal").val("").focus();
        //$("#detalleFechaIni").val("").focus();
        //$("#detalleFechaFin").val("").focus();
        $("#btnAgregar").removeAttr("data-personal");
        $("#btnAgregar").removeAttr("data-costo").focus();
        //$("#tblDetallePersonal").parent().css({ "overflow-x": "initial", "overflow-y": "" });
    }
}

function IntervaloFechas(fecha_ini, fecha_fin) {
    var msecPorMinuto = 1000 * 60;
    var msecPorHora = msecPorMinuto * 60;
    var msecPorDia = msecPorHora * 24;

    var temF_Ini = fecha_ini.split(' ')[0];
    var temH_Ini = fecha_ini.split(' ')[1];
    temF_Ini = temF_Ini.split('/')[1] + "-" + temF_Ini.split('/')[0] + "-" + temF_Ini.split('/')[2];    
    var fechaIni = new Date(temF_Ini + " " + temH_Ini);

    var temF_Fin = fecha_fin.split(' ')[0];
    var temH_Fin = fecha_fin.split(' ')[1];
    temF_Fin = temF_Fin.split('/')[1] + "-" + temF_Fin.split('/')[0] + "-" + temF_Fin.split('/')[2];
    var fechaFin = new Date(temF_Fin + " " + temH_Fin);

    var intervalo = fechaFin.getTime() - fechaIni.getTime();

    //var dias = Math.floor(intervalo / msecPorDia);
    //intervalo = intervalo - (dias * msecPorDia);

    var horas = Math.floor(intervalo / msecPorHora);
    intervalo = intervalo - (horas * msecPorHora);

    var minutos = Math.floor(intervalo / msecPorMinuto);
    intervalo = intervalo - (minutos * msecPorMinuto);
    //var segundos = Math.floor(intervalo / 1000);
    return horas + " " + minutos;
    //return dias + " " + horas + " " + minutos;
}

function QuitarFila(fila) {
    $(fila).parent().parent().remove();
    $("#tblDetallePersonal tbody tr").each(function (index) {
        $(this).children("td:eq(1)").html(index + 1);
    });
}