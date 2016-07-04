using Datos.Comunes;
using Entidad.RRHH;
using Negocio.RRHH;
using SIS_BLANKITO.control;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capa_Presentacion.GestionarRRHH
{
    public partial class gestionarPersonal : System.Web.UI.Page
    {
        private static List<entPersonal> lstPersonal;
        private static VerificarError verificarLoad;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDatos();
            }
        }

        public void CargarDatos()
        {
            verificarLoad = new VerificarError();
            lstPersonal = negPersonal.Instancia.ListarPersonal(ref verificarLoad, 0, 0);
        }

        public static void RecargarDatos(String id_personal, String dni)
        {
            verificarLoad = new VerificarError();
            lstPersonal = new List<entPersonal>();
            lstPersonal = negPersonal.Instancia.ListarPersonal(ref verificarLoad, Convert.ToInt32(id_personal), Convert.ToInt32(dni));
        }

        [WebMethod]
        public static object Listar_Personal(int edito, String id_personal, String dni)
        {
            try
            {
                if (edito == 1) { RecargarDatos(id_personal, dni); }
                if (verificarLoad.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificarLoad.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entPersonal item in lstPersonal)
                {
                    item.id_personal = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_personal));
                    item.tipo_personal.id_tipo_personal = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.tipo_personal.id_tipo_personal));
                    item.sucursal.id_sucursal = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.sucursal.id_sucursal));
                }

                return new { Resultado = "Ok", personal = sr.Serialize(lstPersonal) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}