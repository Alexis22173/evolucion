<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="gestionarOrdenProduccion.aspx.cs" Inherits="Capa_Presentacion.GestionarProduccion.gestionarOrdenProduccion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card">
        <div class="card-header bgm-indigo">
            <h2 style="font-size: 14px">REGISTRAR ORDEN DE PRODUCCIÓN</h2>
            <ul class="actions actions-alt">
                <li><a href="javascript:;" id="btnCancelar" data-trigger="hover" data-toggle="popover" data-placement="bottom" data-content="Al hacer click, se limpiaran los campos." title="" data-original-title="Información"><i class="md md-refresh"></i></a></li>
            </ul>
        </div>
        <div class="card-body card-padding">
            <div class="row" id="frmOrdenProduccion">

                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="col-lg-12 col-md-12 col-sm-12 m-b-20">
                        <p class="c-black f-500 m-b-5">DATOS DE LA ORDEN</p>
                        <small>Se debe ingresar el motivo de la producción con la fecha de entrega del producto.</small>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="form-group">
                                    <select id="cmbMotivo" class="selectpicker" data-live-search="true">
                                        <option value="0">..:: SELECCIONE UN MOTIVO ::..</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="form-group">
                                    <select id="cmbTipo" class="selectpicker" data-live-search="true" disabled>
                                        <option value="0">..:: SELECCIONE ::..</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <textarea class="form-control" id="txtObservacion" rows="2"></textarea>
                                    </div>
                                    <label class="fg-label">OBSERVACIÓN</label>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type='text' class="form-control text-center fg-input date-time-picker" data-toggle="dropdown" id="txtFechaEntrega" />
                                    </div>
                                    <label class="fg-label">FECHA DE ENTREGA</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="col-lg-12 col-md-12 col-sm-12 m-b-20">
                        <p class="c-black f-500 m-b-5">PRODUCTO A PRODUCIR</p>
                        <small>Se debe ingresar el producto y la cantidad que se debe producir en esta orden.</small>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="form-group fg-float">
                                    <div class="input-group">
                                        <div class="fg-line textStyle">
                                            <input type="text" class="form-control fg-input" maxlength="11" id="txtCodigoProducto" />
                                        </div>
                                        <label class="fg-label">CÓDIGO</label>
                                        <span class="input-group-addon last" style="cursor: pointer" onclick="MostrarProducto()"><i class="md md-search"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" class="form-control text-center fg-input" id="txtCantidad" maxlength="10" />
                                    </div>
                                    <label class="fg-label">CANTIDAD</label>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" class="form-control fg-input" id="txtDescripcionProducto" />
                                    </div>
                                    <label class="fg-label">DESCRIPCIÓN DEL PRODUCTO</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-12 col-md-12 col-sm-12 m-b-20">
                        <p class="c-black f-500 m-b-5">DETALLE DEL PERSONAL</p>
                        <small>Se debe ingresar al personal encargado de la producción, junto con la fecha y hora de inicio a fin.</small>
                    </div>

                    <div class="col-lg-3 col-md-12 col-sm-12">
                        <div class="row">
                            <div class="col-lg-8 col-md-2 col-sm-3">
                                <div class="form-group fg-float">
                                    <div class="input-group">
                                        <div class="fg-line textStyle">
                                            <input type="text" class="form-control fg-input" maxlength="8" id="txtDniPersonal" />
                                        </div>
                                        <label class="fg-label">NÚMERO DE DNI</label>
                                        <span class="input-group-addon last" style="cursor: pointer" onclick="MostrarPersonal()"><i class="md md-search"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-1 col-sm-1">
                                <div class="form-group">
                                    <button class="btn btn-primary btn-block" type="button" id="btnAgregar"><i class="md md-add"></i></button>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-6 col-sm-5">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" class="form-control fg-input" id="txtNombrePersonal" />
                                    </div>
                                    <label class="fg-label">NOMBRE DEL PERSONAL</label>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-3 col-sm-3">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" class="form-control text-center fg-input date-time-picker" data-toggle="dropdown" id="detalleFechaIni" />
                                    </div>
                                    <label class="fg-label">FECHA INICIO</label>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-3 col-sm-3">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" class="form-control text-center fg-input date-time-picker" data-toggle="dropdown" id="detalleFechaFin" />
                                    </div>
                                    <label class="fg-label">FECHA FIN</label>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-3 col-sm-3">
                                <div class="form-group">
                                    <button class="btn bgm-indigo btn-block" id="btnGuardar">GUARDAR ORDEN</button>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="col-lg-9 col-md-12 col-sm-12">
                        <div class="card">
                            <div class="card-header bgm-gray">
                                <h2 style="font-size: 14px">HORAS TRABAJADAS</h2>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover" id="tblDetallePersonal">
                                    <thead>
                                        <tr>
                                            <th class="hidden"></th>
                                            <th class="text-center">#</th>
                                            <th>NOMBRE PERSONAL</th>
                                            <th>FECHA HORA INICIO</th>
                                            <th>FECHA HORA FIN</th>
                                            <th>COSTO</th>
                                            <th>OPCIÓN</th>
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

        <%-- VENTANA LISTADO PRODUCTO --%>
        <div class="modal fade" id="modalListadoProducto" tabindex="-1" role="dialog">
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

        <%-- VENTANA LISTADO PERSONAL --%>
        <div class="modal fade" id="modalListadoPersonal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">LISTADO DEL PERSONAL</h4>
                    </div>
                    <div class="modal-body">
                        <div id="MLPersonal"></div>
                        <div class="row">
                            <div class="table-responsive">
                                <table class="table table-hover" id="tblPersonal">
                                    <thead>
                                        <tr>
                                            <th class="hidden"></th>
                                            <th>#</th>
                                            <th class="text-center">NOMBRES Y APELLIDOS</th>
                                            <th class="text-center">DNI</th>
                                            <th class="text-center">CORREO</th>
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
    <script type="text/javascript" src="<%=ResolveUrl("src/js/gestionarOrdenProduccion.js") %>"></script>
</asp:Content>
