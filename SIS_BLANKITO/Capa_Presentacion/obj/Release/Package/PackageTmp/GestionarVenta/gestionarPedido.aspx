<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="gestionarPedido.aspx.cs" Inherits="Capa_Presentacion.GestionarVenta.gestionarPedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card">
        <div class="card-header bgm-indigo">
            <h2 style="font-size: 14px">REGISTRAR PEDIDO</h2>
            <ul class="actions actions-alt">
                <li><a href="javascript:;" id="btnCancelar" data-trigger="hover" data-toggle="popover" data-placement="bottom" data-content="Al hacer click, se limpiaran los campos." title="" data-original-title="Información"><i class="md md-refresh"></i></a></li>
            </ul>
        </div>
        <div class="card-body card-padding">
            <div class="row" id="frmPedido">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-10 m-b-10">
                        <div class="form-group fg-float">
                            <div class="input-group">
                                <div class="fg-line textStyle">
                                    <input type="text" class="form-control fg-input" maxlength="11" id="txtDniRuc" />
                                </div>
                                <label class="fg-label">DNI / RUC</label>
                                <span class="input-group-addon last" style="cursor: pointer" onclick="MostrarCliente()"><i class="md md-search"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-8 col-sm-8 m-t-10 m-b-10">
                        <div class="form-group fg-float">
                            <div class="fg-line">
                                <input type="text" class="form-control fg-input" id="txtNombre" />
                            </div>
                            <label class="fg-label">NOMBRE DEL CLIENTE</label>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-10 m-b-10">
                        <div class="form-group">
                            <button class="btn bgm-blue btn-block" type="button" id="btnModalCliente" href="#modalCliente" data-toggle="modal"><i class="md md-person"></i>REGISTRAR CLIENTE</button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-5 m-b-10">
                        <div class="form-group">
                            <select id="cmbTipoDocumento" class="selectpicker" multiple data-max-options="1" title='... SELECCIONE UN TIPO DOCUMENTO ...'></select>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-8 col-sm-8 m-b-10">
                        <div class="form-group fg-float">
                            <div class="input-group">
                                <div class="fg-line textStyleDesc">
                                    <input type="text" class="form-control fg-input" id="txtDescripcion" />
                                </div>
                                <label class="fg-label">DESCRIPCIÓN DEL PRODUCTO</label>
                                <span class="input-group-addon last" style="cursor: pointer" href="#modalProducto" data-toggle="modal" id="lblBuscarProducto"><i class="md md-search"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-2 col-sm-2 m-b-10">
                        <div class="form-group fg-float">
                            <div class="fg-line">
                                <input type="text" class="form-control fg-input" id="txtPrecio" maxlength="10" />
                            </div>
                            <label class="fg-label">PRECIO</label>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-2 col-sm-2 m-b-10">
                        <div class="form-group fg-float">
                            <div class="fg-line">
                                <input type="text" class="form-control fg-input" id="txtCantidad" maxlength="10" />
                            </div>
                            <label class="fg-label">CANTIDAD</label>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 m-b-10">
                        <div class="form-group">
                            <button class="btn btn-primary btn-block" type="button" id="btnAgregar"><i class="md md-add"></i></button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-9 col-md-12 col-sm-12">
                        <div class="card">
                            <div class="card-header bgm-gray">
                                <h2 style="font-size: 14px">DETALLE DEL PEDIDO</h2>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover" id="tblDetalle">
                                    <thead>
                                        <tr>
                                            <th class="text-center">CANTIDAD</th>
                                            <th>DESCRIPCIÓN</th>
                                            <th>PRECIO</th>
                                            <th>IMPORTE</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-12 col-sm-12">
                        <div class="row">
                            <div class="col-lg-12 col-md-3 col-sm-3 col-xs-12 m-b-5">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" value="" id="chkProducir"/>
                                        <i class="input-helper"></i>
                                        Marcar para mandar a producción
                                    </label>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-3 col-sm-3 col-xs-12 m-b-5">
                                <div class="bgm-bluegray brd-2 p-10">
                                    <div class="c-white m-b-5">SUB TOTAL:</div>
                                    <h2 class="m-0 c-white f-300" id="lblSubtotal">S/. 0.00</h2>
                                </div>
                            </div>

                            <div class="col-lg-12 col-md-3 col-sm-3 col-xs-12 m-b-5">
                                <div class="bgm-bluegray brd-2 p-10">
                                    <div class="c-white m-b-5">IGV:</div>
                                    <h2 class="m-0 c-white f-300" id="lblIgv">S/. 0.00</h2>
                                </div>
                            </div>

                            <div class="col-lg-12 col-md-3 col-sm-3 col-xs-12" style="cursor: pointer" id="btnGuardar">
                                <div class="bgm-indigo brd-2 p-10">
                                    <div class="c-white m-b-5">TOTAL:</div>
                                    <h2 class="m-0 c-white f-300" id="lblTotal">S/. 0.00</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="modal fade" id="modalCliente" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">REGISTRAR CLIENTE</h4>
                    </div>
                    <div class="modal-body">
                        <div id="MFCliente"></div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">

                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-perm-identity"></i></span>
                                        <div class="fg-line">
                                            <select id="cmbTipoCliente_Nuevo" class="selectpicker" data-live-search="true">
                                                <option value="0">..:: SELECCIONE UN TIPO CLIENTE ::..</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-credit-card"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtDniRuc_Nuevo" class="form-control Upper" placeholder="DNI / RUC" maxlength="11" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-person"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtNombres_Nuevo" class="form-control Upper" placeholder="NOMBRES" maxlength="150" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-email"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtCorreo_Nuevo" class="form-control Upper" placeholder="CORREO" maxlength="50" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-location-on"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtDireccion_Nuevo" class="form-control Upper" placeholder="DIRECCIÓN" maxlength="100" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-local-phone"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtTelefono_Nuevo" class="form-control Upper" placeholder="TELÉFONO" maxlength="12" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-phone-android"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtCelular_Nuevo" class="form-control Upper" placeholder="CELULAR" maxlength="12" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="btnGuardarCliente">Guardar</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" id="btnCerrarCliente">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header bgm-green">
            <h2 style="font-size: 14px">PEDIDOS DEL DÍA <small>Usted puede ver el detalle del pedido, modificarlo y/o eliminarlo</small> </h2>
        </div>

        <div class="table-responsive">
            <table class="table table-hover" id="tblPedidos">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>FECHA</th>
                        <th>DOCUMENTO</th>
                        <th>NÚMERO</th>
                        <th>DNI / RUC</th>
                        <th>CLIENTE</th>
                        <th>TOTAL</th>
                        <th>ESTADO</th>
                        <th>OPCIÓN</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>


        <div class="modal fade" id="modalPedido" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">DETALLE DEL PEDIDO</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <table class="table table-hover" id="tblMostrarDetalle">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>CANTIDAD</th>
                                            <th>DESCRIPCIÓN</th>
                                            <th>PRECIO</th>
                                            <th>IMPORTE</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalProducto" tabindex="-1" role="dialog">
            <div class="modal-dialog" style="width: 80%">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">LISTADO DE PRODUCTOS</h4>
                    </div>
                    <div class="modal-body">
                        <div id="MLProducto"></div>
                        <div class="row">
                            <div class="table-responsive">
                                <table class="table table-hover table-vmiddle" id="tblProducto">
                                    <thead>
                                        <tr>
                                            <th data-column-id="indice" data-type="numeric" data-identifier="true">#</th>
                                            <th data-column-id="categoria">CATEGORÍA</th>
                                            <th data-column-id="marca">MARCA</th>
                                            <th data-column-id="producto">PRODUCTO</th>
                                            <th data-column-id="preciomin">PRECIO MIN</th>
                                            <th data-column-id="preciomax">PRECIO MAX</th>
                                            <th data-column-id="stock">STOCK</th>
                                            <th data-column-id="id" data-visible="false"></th>
                                            <th data-column-id="accion" data-formatter="commands" data-sortable="false">SELECCIONAR</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalListadoCliente" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">LISTADO DE CLIENTES</h4>
                    </div>
                    <div class="modal-body">
                        <div id="MLCliente"></div>
                        <div class="row">
                            <div class="table-responsive">
                                <table class="table table-hover table-vmiddle" id="tblCliente">
                                    <thead>
                                        <tr>
                                            <th data-column-id="indice" data-type="numeric" data-identifier="true">#</th>
                                            <th data-column-id="nombres">NOMBRES</th>
                                            <th data-column-id="tipo">TIPO CLIENTE</th>
                                            <th data-column-id="dni_ruc">DNI / RUC</th>
                                            <th data-column-id="id" data-visible="false"></th>
                                            <th data-column-id="accion" data-formatter="commands" data-sortable="false">SELECCIONAR</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script type="text/javascript" src="<%=ResolveUrl("src/js/gestionarPedido.js") %>"></script>
</asp:Content>
