using Entidad.Seguridad;
using Negocio.Seguridad;
using SIS_BLANKITO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capa_Presentacion
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static object Login_Usuario(String usuario, String password)
        {
            try
            {
                entUsuario userSesion = negUsuario.Instancia.LoginUsuario(usuario, password);
                if (userSesion.id_usuario != null)
                {
                    if (userSesion.estado == 1)
                    {
                        clsSesionBase.SesionUsuario = userSesion;
                        if (!String.IsNullOrEmpty(HttpContext.Current.Request.QueryString["back_url"]))
                        {
                            HttpContext.Current.Response.Redirect(HttpContext.Current.Request.QueryString["back_url"].ToString());
                            return new { Resultado = "NoOk", Mensaje = "Sesión terminada." };
                        }
                        else
                        {
                            return new { Resultado = "Ok", Mensaje = "Datos correctos." };
                        }

                    }
                    else return new { Resultado = "NoOk", Mensaje = "El usuario se encuentra inactivo." };
                }
                else return new { Resultado = "NoOk", Mensaje = "Verifique sus datos de acceso." };
            }

            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = ex.ToString() };
            }
        }
    }
}