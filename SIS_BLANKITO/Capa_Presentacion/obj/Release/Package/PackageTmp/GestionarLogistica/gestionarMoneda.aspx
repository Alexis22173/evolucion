<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="gestionarMoneda.aspx.cs" Inherits="Capa_Presentacion.GestionarLogistica.gestionarMoneda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6">
            <form class="form-horizontal" role="form">
                <div class="card">
                    <div class="card-header bgm-blue">
                        <h2 style="font-size: 14px">GUARDAR TIPO MONEDA</h2>
                    </div>
                    <div class="card-body card-padding">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group fg-float">
                                    <label class="col-sm-3 control-label">DESCRIPCIÓN</label>
                                    <div class="col-sm-8">
                                        <div class="fg-line">
                                            <input type="text" class="form-control input-sm" id="txtDescripcion"/>
                                        </div>
                                    </div>
                                </div>                              
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">ESTADO</label>
                                    <div class="col-sm-8">
                                        <div class="fg-line">
                                            <div data-toggle="buttons">
                                                <label class="btn bgm-lightgreen active" id="lblEstado">ACTIVO</label>                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-lg-3 col-md-4 col-sm-6 col-lg-offset-3 col-md-offset-2 m-b-5">
                                        <button class="btn bgm-green btn-block" type="button" id="btnGuardar">Guardar </button>
                                    </div>
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <button class="btn bgm-red btn-block" type="button" id="btnCancelar">Cancelar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="col-lg-6 col-md-6 col-sm-6">
            <div class="card">
                <div class="card-header">
                    <h2 style="font-size: 14px">LISTADO DE MONEDAS</h2>
                </div>
                <div class="table-responsive">
                    <table id="tblMoneda" class="table table-bordered table-hover table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>DESCRIPCIÓN</th>                             
                                <th>ESTADO</th>
                                <th>ACCIÓN</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="<%=ResolveUrl("src/js/gestionarMoneda.js") %>"></script>
</asp:Content>
