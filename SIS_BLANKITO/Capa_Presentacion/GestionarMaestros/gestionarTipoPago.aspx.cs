using Datos.Comunes;
using Entidad.Comunes;
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

namespace Capa_Presentacion.GestionarMaestros
{
    public partial class gestionarTipoPago : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {}

        [WebMethod]
        public static object Listar_TipoPago()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entTipo_Pago> lstTP = negTipo_Pago.Instancia.ListarTipoPago(ref verificar, 0);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entTipo_Pago item in lstTP)
                {
                    item.id_tipo_pago = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_tipo_pago));
                }

                return new { Resultado = "Ok", tp = sr.Serialize(lstTP) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_TipoPago(entTipo_Pago tp)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                tp.id_tipo_pago = tp.id_tipo_pago == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(tp.id_tipo_pago).Replace(" ", "+"));

                int resultado = negTipo_Pago.Instancia.GuardarTipoPago(ref verificar, tp);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "El tipo de pago se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "El tipo de pago ya se encuentra registrado." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };

            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Eliminar_TipoPago(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "Comunes.Tipo_Pago", "2", "id_tipo_pago", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "El tipo de pago se eliminó satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}