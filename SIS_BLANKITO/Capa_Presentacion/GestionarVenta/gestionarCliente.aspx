<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="gestionarCliente.aspx.cs" Inherits="Capa_Presentacion.GestionarVenta.gestionarCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .Upper {
            text-transform: uppercase;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row m-b-25">
        <div class="col-lg-2 col-md-4 col-sm-6 m-b-5">
            <button class="btn btn-primary btn-block" type="button" data-toggle="collapse" data-target="#collapseCliente" aria-expanded="false" aria-controls="collapseCliente" id="btnNuevo">
                Nuevo Cliente                             
            </button>
        </div>
        <div class="col-lg-2 col-md-4 col-sm-6">
            <button class="btn btn-primary btn-block" type="button" id="btnEliminar">Eliminar Cliente</button>
        </div>
    </div>

    <div class="collapse" id="collapseCliente">
        <div class="card">
            <div class="card-header bgm-blue">
                <h2 style="font-size: 14px">GUARDAR CLIENTE</h2>
            </div>
            <div class="card-body card-padding">
                <div class="row">
                    <div class="col-lg-8 col-md-8 col-sm-12 col-lg-offset-2 col-md-offset-2">

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-perm-identity"></i></span>
                                        <div class="fg-line">
                                            <select id="cmbTipoCliente" class="selectpicker" data-live-search="true">
                                                <option value="0">..:: SELECCIONE UN TIPO CLIENTE ::..</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-credit-card"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtDniRuc" class="form-control Upper" placeholder="DNI / RUC" maxlength="11" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-person"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtNombres" class="form-control Upper" placeholder="NOMBRES" maxlength="150" />
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
                                            <input type="text" id="txtCorreo" class="form-control Upper" placeholder="CORREO" maxlength="50" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="md md-location-on"></i></span>
                                        <div class="fg-line">
                                            <input type="text" id="txtDireccion" class="form-control Upper" placeholder="DIRECCIÓN" maxlength="100" />
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
                                            <input type="text" id="txtCelular" class="form-control Upper" placeholder="CELULAR" maxlength="12" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group">
                                <div class="col-lg-3 col-md-4 col-sm-6 col-lg-offset-2 col-md-offset-2 m-b-5">
                                    <button class="btn bgm-green btn-block" type="button" id="btnGuardar">Guardar </button>
                                </div>
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <button class="btn bgm-red btn-block" type="button" data-toggle="collapse" data-target="#collapseCliente" aria-expanded="false" id="btnCancelar">Cancelar</button>
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
            <h2 style="font-size: 14px">LISTADO DE CLIENTES</h2>
        </div>

        <div class="table-responsive">
            <table id="tblCliente" class="table table-hover table-vmiddle">
                <thead>
                    <tr>
                        <th data-column-id="indice" data-type="numeric" data-identifier="true">#</th>
                        <th data-column-id="nombres">NOMBRES</th>
                        <th data-column-id="tipo_cliente">TIPO CLIENTE</th>
                        <th data-column-id="dniruc">DNI / RUC</th>
                        <th data-column-id="correo">CORREO</th>
                        <th data-column-id="telefono">TELÉFONO</th>
                        <th data-column-id="telefono">CELULAR</th>
                        <th data-column-id="direccion">DIRECCIÓN</th>
                        <th data-column-id="id" data-visible="false"></th>
                        <th data-column-id="accion" data-formatter="commands" data-sortable="false">ACCIÓN</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <script type="text/javascript" src="<%=ResolveUrl("src/js/gestionarCliente.js") %>"></script>
</asp:Content>
