using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Data.SqlClient;
using Entidad.Seguridad;

namespace SIS_BLANKITO
{
    public class clsSesionBase
    {
        public static entUsuario SesionUsuario
        {
            get { return GetSession<entUsuario>("usuarioBlankito") ?? RedireccionarUsuario<entUsuario>(); }
            set { HttpContext.Current.Session["usuarioBlankito"] = value; }
        }

        public static T GetSession<T>(string namesession)
        {
            T obj = default(T);
            try
            {
                if (HttpContext.Current != null)
                {
                    obj = (T)HttpContext.Current.Session[namesession];
                }
                return (T)obj;

            }
            catch { return default(T); }
        }

        private static T RedireccionarUsuario<T>()
        {
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Response.Redirect("~/Login.aspx");
            return default(T);
        }

    }
}
