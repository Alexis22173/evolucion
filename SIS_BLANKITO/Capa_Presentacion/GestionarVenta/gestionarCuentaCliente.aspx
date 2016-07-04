<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="gestionarCuentaCliente.aspx.cs" Inherits="Capa_Presentacion.GestionarVenta.gestionarCuentaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-4">
            <div class="card">
                <div class="card-header bgm-bluegray">
                    <h2 style="font-size: 14px">DEUDAS DE LOS CLIENTES <small>Seleccione un cliente para mostrar la venta que se realizó.</small></h2>
                </div>
                <div class="card-body card-padding">
                    <div class="row">
                        <div class="list-group" id="lstCuentaCliente"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-8 col-md-8 col-sm-8">
            <div class="card">
                <div class="card-header bgm-green">
                    <h2 style="font-size: 14px">VENTA REALIZADA <small>Seleccione una venta para mostrar su detalle.</small></h2>
                </div>
                <div class="table-responsive">
                    <table id="tblCuentaCliente" class="table table-bordered table-hover table-striped">
                        <thead>
                            <tr>
                                <th>FECHA</th>
                                <th>DOCUMENTO</th>
                                <th>SERIE-NRO</th>
                                <th>MONTO</th>
                                <th>ACUENTA</th>
                                <th>SALDO</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>

            <div class="bgm-bluegray c-white m-b-20" style="padding: 10px; border-radius: 2px; display: inline-block; width: 100%;">
                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12" style="padding-top: 10px"><span>Usted puede ingresar el monto para cobrar la(s) deuda(s).</span> <span id="divDeuda" style="font-size: 14px;"></span></div>
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-5" style="padding-top: 3px">
                    <div class="fg-line">
                        <input type="text" id="txtMonto" class="form-control text-center" maxlength="10"/>
                    </div>
                </div>
                <div class="col-lg-1 col-md-1 col-sm-1 col-xs-3" style="padding-top: 5px">
                    <button type="button" class="btn btn-success" id="btnCobrar"><i class="md md-attach-money"></i></button>
                </div>
            </div>

            <div class="card">
                <div class="card-header bgm-green">
                    <h2 style="font-size: 14px">DETALLE VENTA</h2>
                </div>
                <div class="table-responsive">
                    <table id="tblDetalleCuenta" class="table table-bordered table-hover table-striped">
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
    </div>
    <script type="text/javascript" src="<%=ResolveUrl("src/js/gestionarCuentaCliente.js") %>"></script>
</asp:Content>
