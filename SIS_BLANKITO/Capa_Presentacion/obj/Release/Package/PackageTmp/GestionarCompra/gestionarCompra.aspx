<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="gestionarCompra.aspx.cs" Inherits="Capa_Presentacion.GestionarCompra.gestionarCompra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card">

        <div class="card-header bgm-indigo">
            <h2 style="font-size: 14px">REGISTRAR  COMPRA</h2>
            <ul class="actions actions-alt">
                <li><a href="javascript:;" id="btnCancelar" data-trigger="hover" data-toggle="popover" data-placement="bottom" data-content="Al hacer click, se limpiaran los campos." title="" data-original-title="Información"><i class="md md-refresh"></i></a></li>
            </ul>
        </div>
        <%--        <div class="card-header bgm-indigo" style="padding-bottom: 12px;">
            <div class="row" style="margin-top: -10px;">
                <div class="col-lg-2 col-md-4">
                    <h2 style="font-size: 14px; padding-top: 10px;">REGISTRAR COMPRA</h2>
                </div>
                <div class="col-lg-2 col-md-4">
                    <input type="text" id="txtNumero" style="border: 0; cursor:pointer; height: 35px; padding: 0 10px 0 40px; font-size: 18px; border-radius: 2px; color: white; background-color: rgba(255, 255, 255, 0.26); background-image: url('../src/img/icons/search.png'); background-repeat: no-repeat; background-position: 10px center;" maxlength="10"/>
                </div>
            </div>
            <ul class="actions actions-alt">
                <li><a href="javascript:;" id="btnCancelar" data-trigger="hover" data-toggle="popover" data-placement="bottom" data-content="Al hacer click, se limpiaran los campos." title="" data-original-title="Información"><i class="md md-refresh"></i></a></li>
            </ul>
        </div>--%>
        <div class="card-body card-padding">
            <div class="row" id="frmCompra">

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-10 m-b-10">
                        <div class="form-group fg-float">
                            <div class="input-group">
                                <div class="fg-line textStyle">
                                    <input type="text" class="form-control fg-input" maxlength="11" id="txtDniRucProveedor" />
                                </div>
                                <label class="fg-label">DNI / RUC</label>
                                <span class="input-group-addon last" style="cursor: pointer" onclick="MostrarProveedor()"><i class="md md-search"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-8 col-sm-8 m-t-10 m-b-10">
                        <div class="form-group fg-float">
                            <div class="fg-line">
                                <input type="text" class="form-control fg-input" id="txtRazonSocial" />
                            </div>
                            <label class="fg-label">RAZÓN SOCIAL</label>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-10 m-b-10">
                        <div class="form-group">
                            <button class="btn bgm-blue btn-block" type="button" id="btnModalProveedor" href="#modalProveedor" data-toggle="modal"><i class="md md-person"></i>REGISTRAR PROVEEDOR</button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-10 m-b-10">
                        <div class="form-group fg-float">
                            <div class="input-group">
                                <div class="fg-line textStyle">
                                    <input type="text" class="form-control fg-input" maxlength="8" id="txtDniContacto" />
                                </div>
                                <label class="fg-label">DNI</label>
                                <span class="input-group-addon last" style="cursor: pointer" onclick="MostrarContacto()"><i class="md md-search"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-8 col-sm-8 m-t-10 m-b-10">
                        <div class="form-group fg-float">
                            <div class="fg-line">
                                <input type="text" class="form-control fg-input" id="txtNombreContacto" />
                            </div>
                            <label class="fg-label">NOMBRE DEL CONTACTO</label>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-10 m-b-10">
                        <div class="form-group">
                            <button class="btn bgm-blue btn-block" type="button" id="btnModalContactoProveedor" href="#modalContactoProveedor" data-toggle="modal"><i class="md md-person"></i>REGISTRAR CONTACTO</button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-5 m-b-10">
                        <div class="form-group">
                            <select id="cmbTipoDocumento" class="selectpicker" data-live-search="true">
                                <option value="0">..:: SELECCIONE UN TIPO DOCUMENTO ::..</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-5 m-b-10">
                        <div class="form-group">
                            <select id="cmbTipoPago" class="selectpicker" data-live-search="true">
                                <option value="0">..:: SELECCIONE UN TIPO PAGO ::..</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-5 m-b-10">
                        <div class="form-group">
                            <select id="cmbMoneda" class="selectpicker" data-live-search="true">
                                <option value="0">..:: SELECCIONE UNA MONEDA ::..</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-5 m-b-10">
                        <div class="form-group">
                            <select id="cmbNumero" class="selectpicker">
                                <option value="0">..:: SELECCIONE UN NÚMERO ::..</option>
                            </select>
                        </div>
                    </div>
                </div>

<%--                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-5 m-b-10">
                        <div class="form-group">
                            <select id="cmbMotivo" class="selectpicker" data-live-search="true">
                                <option value="0">..:: SELECCIONE UN MOTIVO ::..</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-lg-3 col-md-3 col-sm-4 m-t-5 m-b-10">
                        <div class="form-group">
                            <button class="btn btn-primary btn-block" type="button" id="btnAgregar"><i class="md md-add"></i>AGREGAR SELECCIONADO</button>
                        </div>
                    </div>
                </div>--%>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-9 col-md-12 col-sm-12">
                        <div class="card">
                            <div class="card-header bgm-gray">
                                <h2 style="font-size: 14px">DETALLE DE LA COMPRA</h2>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover" id="tblDetalle">
                                    <thead>
                                        <tr>
                                            <th class="hidden"></th>
                                            <th class="text-center">CANTIDAD</th>
                                            <th>DESCRIPCIÓN</th>
                                            <th>PRECIO</th>
                                            <th>IMPORTE</th>
                                            <th>NÚMERO</th>
                                            <th class="hidden"></th>
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
                            <div class="col-lg-12 col-md-4 col-sm-4 col-xs-12 m-b-5">
                                <div class="bgm-bluegray brd-2 p-10">
                                    <div class="c-white m-b-5">SUB TOTAL:</div>
                                    <h2 class="m-0 c-white f-300" id="lblSubtotal">S/. 0.00</h2>
                                </div>
                            </div>

                            <div class="col-lg-12 col-md-4 col-sm-4 col-xs-12 m-b-5">
                                <div class="bgm-bluegray brd-2 p-10">
                                    <div class="c-white m-b-5">IGV:</div>
                                    <h2 class="m-0 c-white f-300" id="lblIgv">S/. 0.00</h2>
                                </div>
                            </div>

                            <div class="col-lg-12 col-md-4 col-sm-4 col-xs-12" style="cursor: pointer" id="btnGuardar">
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

        <%-- VENTANA GUARDAR PROVEEDOR --%>
        <div class="modal fade" id="modalProveedor" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">REGISTRAR PROVEEDOR</h4>
                    </div>
                    <div class="modal-body">
                        <div id="MFProveedor"></div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-person"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtRazonSocial_Nuevo" class="form-control Upper" placeholder="RAZON SOCIAL" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-credit-card"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtDniRuc_Nuevo" class="form-control" placeholder="DNI / RUC" maxlength="11" />
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
                                        <span class="input-group-addon"><i class="md md-email"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtCorreo_Nuevo" class="form-control" placeholder="CORREO" maxlength="50" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-local-phone"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtTelefono_Nuevo" class="form-control" placeholder="TELÉFONO" maxlength="12" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-phone-android"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtCelular_Nuevo" class="form-control" placeholder="CELULAR" maxlength="12" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="btnGuardarProveedor">Guardar</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" id="btnCerrarProveedor">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- VENTANA LISTADO PROVEEDOR --%>
        <div class="modal fade" id="modalListadoProveedor" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">LISTADO DE PROVEEDORES</h4>
                    </div>
                    <div class="modal-body">
                        <div id="MLProveedor"></div>
                        <div class="row">
                            <div class="table-responsive">
                                <table class="table table-hover table-vmiddle" id="tblProveedor">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th class="text-center">RAZON SOCIAL</th>
                                            <th class="text-center">DNI / RUC</th>
                                            <th class="text-center">TELÉFONO</th>
                                            <th class="text-center">CELULAR</th>
                                            <th class="text-center">SELECCIONAR</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>

        <%-- VENTANA GUARDAR CONTACTO PROVEEDOR --%>
        <div class="modal fade" id="modalContactoProveedor" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">REGISTRAR CONTACTO PROVEEDOR</h4>
                    </div>
                    <div class="modal-body">
                        <div id="MFContactoProveedor"></div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-person"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtNombres_Contacto" class="form-control" placeholder="NOMBRES" maxlength="150" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-credit-card"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtDni_Contacto" class="form-control" placeholder="DNI" maxlength="8" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-email"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtCorreo_Contacto" class="form-control" placeholder="CORREO" maxlength="50" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-local-phone"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtTelefono_Contacto" class="form-control Upper" placeholder="TELÉFONO" maxlength="12" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-phone-android"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtCelular_Contacto" class="form-control" placeholder="CELULAR" maxlength="12" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-perm-identity"></i></span>
                                        <div class="fg-line">
                                            <select id="cmbProveedor" class="selectpicker" data-live-search="true">
                                                <option value="0">..:: SELECCIONE UN PROVEEDOR ::..</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="btnGuardarContactoProveedor">Guardar</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" id="btnCerrarContactoProveedor">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- VENTANA LISTADO CONTACTO PROVEEDOR --%>
        <div class="modal fade" id="modalListadoContactoProveedor" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">LISTADO DE CONTACTOS POR PROVEEDOR</h4>
                    </div>
                    <div class="modal-body">
                        <div id="MLContactoProveedor"></div>
                        <div class="row">
                            <div class="table-responsive">
                                <table class="table table-hover" id="tblContactoProveedor">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th class="text-center">RAZON SOCIAL</th>
                                            <th class="text-center">NOMBRES</th>
                                            <th class="text-center">DNI</th>
                                            <th class="text-center">TELÉFONO</th>
                                            <th class="text-center">CELULAR</th>
                                            <th class="text-center">SELECCIONAR</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>

    </div>
    <script type="text/javascript" src="<%=ResolveUrl("src/js/gestionarCompra.js") %>"></script>
</asp:Content>
