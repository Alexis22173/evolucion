using Datos.Comunes;
using Datos.RRHH;
using Entidad.Comunes;
using Entidad.RRHH;
using Negocio.RRHH;
using Negocio.Comunes;
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
    public partial class gestionarTipoPersonal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static object Listar_TipoPersonal()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entTipo_Personal> lstTP = negTipo_Personal.Instancia.ListarTipoPersonal(ref verificar, 0);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entTipo_Personal item in lstTP)
                {
                    item.id_tipo_personal = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_tipo_personal));
                }

                return new { Resultado = "Ok", tp = sr.Serialize(lstTP) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_TipoPersonal(entTipo_Personal tp)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                tp.id_tipo_personal = tp.id_tipo_personal == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(tp.id_tipo_personal).Replace(" ", "+"));

                int resultado = negTipo_Personal.Instancia.GuardarTipoPersonal(ref verificar, tp);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "El tipo de personal se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "El tipo de personal ya se encuentra registrado." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };

            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Eliminar_TipoPersonal(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "RRHH.Tipo_Personal", "2", "id_tipo_personal", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "El tipo de personal se eliminó satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}