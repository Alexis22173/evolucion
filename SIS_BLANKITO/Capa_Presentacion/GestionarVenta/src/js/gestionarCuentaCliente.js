$(function () {
    SetearMenu();
    ListarCuentas();

    $("#btnCobrar").on("click", function () {
        GuardarPago();
    });

    $("#tblTipoCliente").on("click", ".edita", function () {
        MostrarTipoCliente($(this).parent().parent().attr("data-id"));
    });

    $("#txtMonto").keypress(function (e) {
        return ValidarDecimal(e, this);
    });
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-venta").addClass("active toggled");
    $("#mv-cuecli a").attr("class", "active");
}

function ListarCuentas() {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger'); return; }

        var obj = $.parseJSON(rpta.d.cc);
        var tam = obj.length;
        if (tam == 0) { notify('No hay clientes con deudas.'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<a href="javascript:;" onclick="MostrarCuentasCliente(\'' + obj[i].cliente.id_cliente + '\')" class="list-group-item"><span class="badge bgm-red">' + obj[i].valor + '</span> ' + obj[i].cliente.nombres + ' - ' + obj[i].sucursal.descripcion + '</a>';
        }
        $("#lstCuentaCliente").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger');
    };

    fn_callmethod("gestionarCuentaCliente.aspx/Listar_Cuentas", "", success, error);
}

var totalDeuda = 0;
function MostrarCuentasCliente(id_cliete) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger'); return; }

        $("#tblDetalleCuenta tbody").html("");
        totalDeuda = 0;

        var obj = $.parseJSON(rpta.d.cc);
        var tam = obj.length;
        if (tam == 0) { notify('No existe la deuda', 'inverse'); return; }

        var tabla = "";
        for (var i = 0; i < tam; i++) {
            tabla += '<tr style="cursor:pointer" onclick="MostrarDetallePedido(\'' + obj[i].venta.pedido.id_pedido + '\')">' +
                            '<td>' + obj[i].fecha + '</td>' +
                            '<td>' + obj[i].venta.numero_documento.tipo_documento.descripcion + '</td>' +
                            '<td>' + obj[i].venta.serie + " - " + obj[i].venta.numero + '</td>' +
                            '<td>' + obj[i].monto.toFixed(2) + '</td>' +
                            '<td>' + obj[i].acuenta.toFixed(2) + '</td>' +
                            '<td>' + obj[i].saldo.toFixed(2) + '</td>' +
                     '</tr>';
            totalDeuda = totalDeuda + obj[i].saldo;
        }
        $("#tblCuentaCliente tbody").html(tabla);
        $("#btnCobrar").attr("data-cliente", id_cliete);
        $("#divDeuda").html(" Deuda total: S/. " + totalDeuda);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger');
    };

    fn_callmethod("gestionarCuentaCliente.aspx/Listar_CuentasCliente", JSON.stringify({ id_cliente: id_cliete }), success, error);
}

function MostrarDetallePedido(id) {
    var success = function (rpta) {
        if (rpta.d.Resultado == 'NoOk') { notify(rpta.d.Mensaje, 'danger'); return; }

        var obj = $.parseJSON(rpta.d.dp);
        var tam = obj.length;
        if (tam == 0) { notify('El pedido seleccionado no existe.', 'inverse'); return; }

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
        $("#tblDetalleCuenta tbody").html(tabla);
    };

    var error = function (xhr, ajaxOptions, thrownError) {
        notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger');
    };

    fn_callmethod("gestionarPedido.aspx/Mostrar_DetallePedido", JSON.stringify({ id: id }), success, error);
}

function GuardarPago() {
    $(".alert").remove();

    var id_cliente = $("#btnCobrar").attr("data-cliente");
    var monto = $("#txtMonto").val();
    if (id_cliente == "" || id_cliente == null || id_cliente == undefined) { notify('Seleccione un cliente', 'warning'); return; }
    if (monto == "" || monto <= "0") { notify('El monto no puede estar vacio y debe ser mayor a 0', 'warning'); return; }
    if (monto > totalDeuda) { notify('El monto no debe ser mayor a la deuda total', 'warning'); return; }
    swal({
        title: "¿Está seguro?",
        text: "Se actualizará la deuda del cliente.",
        showCancelButton: true,
        confirmButtonColor: "#4CAF50",
        cancelButtonText: "Cancelar",
        confirmButtonText: "Confirmar",
        closeOnConfirm: false
    }, function (confirma) {
        if (confirma) {          
            var success = function (rpta) {
                if (rpta.d.Resultado == 'NoOk') { swal("Error!", rpta.d.Mensaje, "error"); return; }
                swal("¡Éxito!", rpta.d.Mensaje, "success");
                ListarCuentas();
                $("#tblDetalleCuenta tbody").html("");
                $("#tblCuentaCliente tbody").html("");
                $("#txtMonto").val("");
                totalDeuda = 0;
                $("#divDeuda").html("");
            };

            var error = function (xhr, ajaxOptions, thrownError) {
                notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger');
            };

            fn_callmethod("gestionarCuentaCliente.aspx/Guardar_Pago", JSON.stringify({ id_cliente: id_cliente, monto: monto }), success, error);
        }
    });
}