using SIS_BLANKITO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capa_Presentacion
{
    public partial class Principal : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblUsuario.InnerText = clsSesionBase.SesionUsuario.personal.nombres + " " + clsSesionBase.SesionUsuario.personal.apellido_paterno + " - " + clsSesionBase.SesionUsuario.personal.sucursal.descripcion;
            }
        }
    }
}