<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="gestionarProducto.aspx.cs" Inherits="Capa_Presentacion.GestionarAlmacen.gestionarProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row m-b-25">
        <div class="col-lg-2 col-md-4 col-sm-6 m-b-5">
            <button class="btn btn-primary btn-block" type="button" data-toggle="collapse" data-target="#collapseProducto" aria-expanded="false" aria-controls="collapseProducto" id="btnNuevo">
                Nuevo Producto                             
            </button>
        </div>
        <div class="col-lg-2 col-md-4 col-sm-6">
            <button class="btn btn-primary btn-block" type="button" id="btnEliminar">Eliminar Producto</button>
        </div>
    </div>

    <div class="collapse" id="collapseProducto">
        <div class="card">
            <div class="card-header bgm-blue">
                <h2 style="font-size: 14px">GUARDAR PRODUCTO</h2>
            </div>
            <div class="card-body card-padding">
                <div class="row">
                    <div class="col-lg-8 col-md-8 col-sm-12 col-lg-offset-2 col-md-offset-2">

                        <div class="row">
                            <div class="col-sm-6 m-t-5">
                                <div class="form-group">
                                    <select id="cmbCategoria" class="selectpicker" data-live-search="true">
                                        <option value="0">..:: SELECCIONE UNA CATEGORIA ::..</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6 m-t-5">
                                <div class="form-group">
                                    <select id="cmbMarca" class="selectpicker" data-live-search="true">
                                        <option value="0">..:: SELECCIONE UNA MARCA ::..</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="col-sm-6 m-t-5">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" id="txtCodigo" class="form-control" maxlength="20" />
                                    </div>
                                    <label class="fg-label">CÓDIGO</label>
                                </div>
                            </div>
                            <div class="col-sm-6 m-t-10">
                                <div class="form-group">
                                    <select id="cmbSucursal" class="selectpicker" multiple data-selected-text-format="count"  title='... SELECCIONE UNA SUCURSAL...'></select>
                                </div>
                            </div>
                        </div>--%>

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" class="form-control" id="txtDescripcion" maxlength="255" />
                                    </div>
                                    <label class="fg-label">DESCRIPCIÓN</label>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" id="txtUnidadMedida" class="form-control" maxlength="3" />
                                    </div>
                                    <label class="fg-label">UNID. MED.</label>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group fg-float">
                                    <div class="fg-line">
                                        <input type="text" id="txtPrecioMin" class="form-control" maxlength="10" />
                                    </div>
                                    <label class="fg-label">PRECIO MÍNIMO</label>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group fg-float">                                    
                                    <div class="fg-line">
                                        <input type="text" id="txtPrecioMax" class="form-control" maxlength="10" />
                                    </div>
                                    <label class="fg-label">PRECIO MÁXIMO</label>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group">
                                <div class="col-lg-3 col-md-4 col-sm-6 col-lg-offset-2 col-md-offset-2 m-b-5">
                                    <button class="btn bgm-green btn-block" type="button" id="btnGuardar">Guardar </button>
                                </div>
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <button class="btn bgm-red btn-block" type="button" data-toggle="collapse" data-target="#collapseProducto" aria-expanded="false" id="btnCancelar">Cancelar</button>
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
            <h2 style="font-size: 14px">LISTADO DE PRODUCTOS</h2>
        </div>

        <div class="table-responsive">
            <table id="tblProducto" class="table table-hover table-vmiddle">
                <thead>
                    <tr>
                        <th data-column-id="indice" data-type="numeric" data-identifier="true">#</th>
                        <th data-column-id="categoria">CATEGORÍA</th>
                        <th data-column-id="marca">MARCA</th>
                        <th data-column-id="producto">PRODUCTO</th>
                        <th data-column-id="unidadmed">UNIDAD MED</th>
                        <th data-column-id="preciomin">PRECIO MIN</th>
                        <th data-column-id="preciomax">PRECIO MAX</th>
                        <th data-column-id="id" data-type="string" data-visible="false"></th>
                        <th data-column-id="accion" data-formatter="commands" data-sortable="false">ACCIÓN</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <script type="text/javascript" src="<%=ResolveUrl("src/js/gestionarProducto.js") %>"></script>
</asp:Content>
