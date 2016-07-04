<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="gestionarNotaIngreso.aspx.cs" Inherits="Capa_Presentacion.GestionarAlmacen.gestionarNotaIngreso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-lg-9 col-md-12 col-sm-12">
            <div class="card">
                <div class="card-header bgm-indigo" style="padding-bottom: 22px;">
                    <div class="row" style="margin-top: -10px;">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <h2 style="font-size: 14px; padding-top: 10px;">REGISTRAR NOTA DE INGRESO</h2>
                        </div>
                        <div class="col-lg-2 col-md-3 col-xs-6 p-t-10">
                            <span id="textoOrden"></span>
                        </div>
                    </div>
                    <ul class="actions actions-alt">
                        <li><a href="javascript:;" id="btnCancelar"><i class="md md-refresh"></i></a></li>
                    </ul>
                </div>
                <div class="card-body card-padding">
                    <div class="row" id="frmNotaIngreso">

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="col-lg-3 col-md-3 col-sm-4 m-t-10 m-b-10">
                                <div class="form-group">
                                    <select id="cmbMotivo" class="selectpicker" data-live-search="true">
                                        <option value="0">..:: SELECCIONE UN MOTIVO ::..</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-8 col-sm-8 m-t-10 m-b-10">
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
                            <div class="col-lg-1 col-md-2 col-sm-2 m-t-10 m-b-10">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" class="form-control fg-input" id="txtCantidad" maxlength="10" />
                                    </div>
                                    <label class="fg-label">CANTIDAD</label>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-2 m-t-10 m-b-10">
                                <div class="form-group">
                                    <button class="btn btn-primary btn-block" type="button" id="btnAgregar"><i class="md md-add"></i>Agregar</button>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="col-lg-8 col-md-12 col-sm-12">
                                <div class="card">
                                    <div class="card-header bgm-gray">
                                        <h2 style="font-size: 14px">DETALLE DE LA NOTA</h2>
                                    </div>

                                    <div class="table-responsive">
                                        <table class="table table-hover" id="tblDetalle">
                                            <thead>
                                                <tr>
                                                    <th class="hidden"></th>
                                                    <th class="text-center">CANTIDAD</th>
                                                    <th class="text-center">DESCRIPCIÓN</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-12 col-sm-12">
                                <div class="row">
                                    <div class="col-lg-12 col-md-4 col-sm-4 col-xs-12 m-b-5">
                                        <div class="form-group fg-float">
                                            <div class="fg-line">
                                                <textarea class="form-control" id="txtObservacion" rows="3"></textarea>
                                            </div>
                                            <label class="fg-label">OBSERVACIÓN</label>
                                        </div>
                                    </div>

                                    <div class="col-lg-12 col-md-4 col-sm-4 col-xs-12 m-b-5">
                                        <div class="form-group">
                                            <button class="btn bgm-indigo btn-block" id="btnGuardar">Guardar Nota</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 col-sm-9">
            <div class="card">
                <div class="card-header bgm-bluegray">
                    <h2 style="font-size: 14px">ORDENES DEL MOTIVO SELECCIONADO</h2>
                </div>

                <div class="table-responsive">
                    <table id="tblOrdenes" class="table table-bordered table-hover table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>NÚMERO</th>
                                <th>FECHA</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

    <div class="card">
        <div class="card-header bgm-green">
            <h2 style="font-size: 14px">LISTADO DE NOTAS DE INGRESO <small>Puede mostrar las notas de ingreso de acuerdo al rango de fechas.</small> </h2>
        </div>

        <div class="card-body card-padding">
            <div class="row">
                <div class="col-lg-12 p-t-10">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 m-b-5">
                        <div class="form-group fg-float">
                            <div class="fg-line">
                                <input type='text' class="form-control text-center fg-input date-picker" data-toggle="dropdown" id="txtFechaInicio" />
                            </div>
                            <label class="fg-label">FECHA INICIO</label>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 m-b-5">
                        <div class="form-group fg-float">
                            <div class="fg-line">
                                <input type='text' class="form-control text-center fg-input date-picker" data-toggle="dropdown" id="txtFechaFin" />
                            </div>
                            <label class="fg-label">FECHA FIN</label>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 m-b-5">
                        <button type="button" class="btn bgm-lightgreen btn-block" id="btnBuscar"><i class="md md-search"></i>Buscar</button>
                    </div>
                </div>

                <div class="col-lg-12 col-xs-12">
                    <div class="table-responsive">
                        <table class="table table-hover table-vmiddle" id="tblOrdenCompra">
                            <thead>
                                <tr>
                                    <th data-column-id="indice" data-type="numeric" data-identifier="true">#</th>
                                    <th data-column-id="fecha">FECHA</th>
                                    <th data-column-id="numero">NÚMERO ORDEN</th>
                                    <th data-column-id="motivo">MOTIVO</th>
                                    <th data-column-id="observacion">OBSERVACIÓN</th>
                                    <th data-column-id="accion" data-formatter="commands" data-sortable="false">OPCIÓN</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- VENTANA LISTADO PRODUCTO --%>
    <div class="modal fade" id="modalProducto" tabindex="-1" role="dialog">
        <div class="modal-dialog" style="width: 70%">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">LISTADO DE PRODUCTOS</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="table-responsive">
                            <table class="table table-hover table-vmiddle" id="tblProducto">
                                <thead>
                                    <tr>
                                        <th data-column-id="indice" data-type="numeric" data-identifier="true">#</th>
                                        <th data-column-id="categoria">CATEGORÍA</th>
                                        <th data-column-id="marca">MARCA</th>
                                        <th data-column-id="producto">PRODUCTO</th>
                                        <th data-column-id="stock">STOCK</th>
                                        <th data-column-id="id" data-type="string" data-visible="false"></th>
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
    <script type="text/javascript" src="<%=ResolveUrl("src/js/gestionarNotaIngreso.js") %>"></script>
</asp:Content>
