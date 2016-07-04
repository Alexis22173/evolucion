<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Capa_Presentacion.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>BLANKITO</title>

    <!-- Vendor CSS -->
    <link href="src/vendors/animate-css/animate.min.css" rel="stylesheet" />
    <link href="src/vendors/sweet-alert/sweet-alert.min.css" rel="stylesheet" />
    <link href="src/vendors/material-icons/material-design-iconic-font.min.css" rel="stylesheet" />
    <link href="src/vendors/socicon/socicon.min.css" rel="stylesheet" />

    <!-- CSS -->
    <link href="src/css/app.min.1.css" rel="stylesheet" />
    <link href="src/css/app.min.2.css" rel="stylesheet" />
</head>

<body class="login-content">
    <!-- Login -->
    <div class="lc-block toggled" id="l-login">
        <div class="input-group m-b-20">
            <span class="input-group-addon"><i class="md md-person"></i></span>
            <div class="fg-line">
                <input type="text" class="form-control" placeholder="Usuario" id="txtUsuario"/>
            </div>
        </div>

        <div class="input-group m-b-20">
            <span class="input-group-addon"><i class="md md-lock"></i></span>
            <div class="fg-line">
                <input type="password" class="form-control" placeholder="Contraseña" id="txtPassword"/>
            </div>
        </div>

        <div class="clearfix"></div>

        <button type="button" class="btn btn-login btn-danger btn-float" onclick="Login()"><i class="md md-arrow-forward"></i></button>
        <%--<a href="Inicio.aspx" class="btn btn-login btn-danger btn-float"><i class="md md-arrow-forward"></i></a>--%>

        <%--<ul class="login-navigation">
            <li data-block="#l-register" class="bgm-red">Registrar</li>
            <li data-block="#l-forget-password" class="bgm-orange">¿Olvidaste tu contraseña?</li>
        </ul>--%>
        <div id="message_row"></div>
    </div>

    <!-- Register -->
    <div class="lc-block" id="l-register">
        <div class="input-group m-b-20">
            <span class="input-group-addon"><i class="md md-person"></i></span>
            <div class="fg-line">
                <input type="text" class="form-control" placeholder="Username" />
            </div>
        </div>

        <div class="input-group m-b-20">
            <span class="input-group-addon"><i class="md md-mail"></i></span>
            <div class="fg-line">
                <input type="text" class="form-control" placeholder="Email Address" />
            </div>
        </div>

        <div class="input-group m-b-20">
            <span class="input-group-addon"><i class="md md-accessibility"></i></span>
            <div class="fg-line">
                <input type="password" class="form-control" placeholder="Password" />
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="checkbox">
            <label>
                <input type="checkbox" value="" />
                <i class="input-helper"></i>
                Accept the license agreement
               
            </label>
        </div>

        <a href="#" class="btn btn-login btn-danger btn-float"><i class="md md-arrow-forward"></i></a>

        <ul class="login-navigation">
            <li data-block="#l-login" class="bgm-green">Login</li>
            <li data-block="#l-forget-password" class="bgm-orange">Forgot Password?</li>
        </ul>
    </div>

    <!-- Forgot Password -->
    <div class="lc-block" id="l-forget-password">
        <p class="text-left">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu risus. Curabitur commodo lorem fringilla enim feugiat commodo sed ac lacus.</p>

        <div class="input-group m-b-20">
            <span class="input-group-addon"><i class="md md-email"></i></span>
            <div class="fg-line">
                <input type="text" class="form-control" placeholder="Email Address" />
            </div>
        </div>

        <a href="#" class="btn btn-login btn-danger btn-float"><i class="md md-arrow-forward"></i></a>

        <ul class="login-navigation">
            <li data-block="#l-login" class="bgm-green">Login</li>
            <li data-block="#l-register" class="bgm-red">Register</li>
        </ul>
    </div>

    <script src="<%=ResolveUrl("~/src/js/jquery-2.1.1.min.js") %>"></script>
    <script src="<%=ResolveUrl("~/src/js/bootstrap.min.js") %>"></script>
    <script src="<%=ResolveUrl("~/src/vendors/waves/waves.min.js") %>"></script>
    <script src="<%=ResolveUrl("~/src/vendors/bootstrap-growl/bootstrap-growl.min.js")%>"></script>
    <script src="<%=ResolveUrl("~/src/js/functions.js") %>"></script>
    <script src="<%=ResolveUrl("~/src/js/Base.js") %>"></script>

    <script>
        function Login() {
            if ($("#txtUsuario").val() == "") { notify('Ingrese su usuario', 'info', 'center'); return; }
            else if ($("#txtPassword").val() == "") { notify('Ingrese su contraseña', 'info', 'center'); return; }
            else {
                var data = {
                    usuario: $("input[id$=txtUsuario]").val(),
                    password: $("input[id$=txtPassword]").val()
                }

                var success = function (rpta) {
                    if (rpta.d.Resultado == 'NoOk') {
                        notify(rpta.d.Mensaje, 'warning', 'center'); return;
                    }
                    window.location = "Inicio.aspx";
                };
                var error = function (xhr, ajaxOptions, thrownError) {
                    notify('Error inesperado. Por favor, vuelta a intentarlo.', 'danger', 'center');
                };
                fn_callmethod("Login.aspx/Login_Usuario", JSON.stringify(data), success, error);
            }
        }
    </script>
</body>
</html>
