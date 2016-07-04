<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="gestionarContactoProveedor.aspx.cs" Inherits="Capa_Presentacion.GestionarCompra.gestionarContactoProveedor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row m-b-25">
        <div class="col-lg-2 col-md-4 col-sm-6 m-b-5">
            <button class="btn btn-primary btn-block" type="button" data-toggle="collapse" data-target="#collapseContacto" aria-expanded="false" aria-controls="collapseContacto" id="btnNuevo">
                Nuevo Contacto                             
            </button>
        </div>
        <div class="col-lg-2 col-md-4 col-sm-6">
            <button class="btn btn-primary btn-block" type="button" id="btnEliminar">Eliminar Contacto</button>
        </div>
    </div>

    <div class="collapse" id="collapseContacto">
        <div class="card">
            <div class="card-header bgm-blue">
                <h2 style="font-size: 14px">GUARDAR CONTACTO </h2>
            </div>
            <div class="card-body card-padding">
                <div class="row">
                    <div class="col-lg-8 col-md-8 col-sm-12 col-lg-offset-2 col-md-offset-2">

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-person"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtNombres" class="form-control" placeholder="NOMBRES" maxlength="150" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-credit-card"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtDni" class="form-control" placeholder="DNI" maxlength="8" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-email"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtCorreo" class="form-control" placeholder="CORREO" maxlength="50" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-local-phone"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtTelefono" class="form-control Upper" placeholder="TELÉFONO" maxlength="12" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-phone-android"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtCelular" class="form-control" placeholder="CELULAR" maxlength="12" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-3 col-md-3 col-sm-4">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-credit-card"></i></span>
                                        <div class="fg-line">
                                            <input type="text" class="form-control" maxlength="11" id="txtDniRucProveedor" placeholder="DNI / RUC" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-8 col-sm-8">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon last" style="cursor: pointer" onclick="MostrarProveedor()"><i class="md md-search"></i></span>
                                        <div class="fg-line">
                                            <input type="text" class="form-control" id="txtRazonSocial" placeholder="RAZÓN SOCIAL" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-4">
                                <div class="form-group">
                                    <button class="btn bgm-blue btn-block" type="button" id="btnModalProveedor" href="#modalProveedor" data-toggle="modal"><i class="md md-person"></i>REGISTRAR PROVEEDOR</button>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group">
                                <div class="col-lg-3 col-md-4 col-sm-6 col-lg-offset-2 col-md-offset-2 m-b-5">
                                    <button class="btn bgm-green btn-block" type="button" id="btnGuardar">Guardar </button>
                                </div>
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <button class="btn bgm-red btn-block" type="button" data-toggle="collapse" data-target="#collapseContacto" aria-expanded="false" id="btnCancelar">Cancelar</button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="card">
        <div class="card-header">
            <h2 style="font-size: 14px">LISTADO CONTACTO PROVEEDOR</h2>
        </div>

        <div class="table-responsive">
            <table id="tblContacto" class="table table-hover table-vmiddle">
                <thead>
                    <tr>
                        <th data-column-id="indice" data-type="numeric" data-identifier="true">#</th>
                        <th data-column-id="nombres">NOMBRES</th>
                        <th data-column-id="dni">DNI </th>
                        <th data-column-id="correo">CORREO</th>
                        <th data-column-id="telefono">TELÉFONO</th>
                        <th data-column-id="celular">CELULAR</th>
                        <th data-column-id="proveedor">PROVEEDOR</th>
                        <th data-column-id="id" data-visible="false"></th>
                        <th data-column-id="accion" data-formatter="commands" data-sortable="false">ACCIÓN</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
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
                                        <input type="text" id="txtRazonSocial_Nuevo" class="form-control" placeholder="RAZON SOCIAL" />
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
                                        <input type="text" id="txtDireccion_Nuevo" class="form-control" placeholder="DIRECCIÓN" maxlength="100" />
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
            </div>
        </div>
    </div>
    <script type="text/javascript" src="<%=ResolveUrl("src/js/gestionarContactoProveedor.js") %>"></script>
</asp:Content>
