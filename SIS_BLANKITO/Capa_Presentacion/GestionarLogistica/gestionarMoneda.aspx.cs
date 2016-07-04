using Datos.Comunes;
using Datos.Logistica;
using Entidad.Logistica;
using Entidad.Comunes;
using Negocio.Comunes;
using Negocio.Logistica;
using SIS_BLANKITO.control;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capa_Presentacion.GestionarLogistica
{
    public partial class gestionarMoneda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static object Listar_Moneda()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entMoneda> lstM = negMoneda.Instancia.ListarMoneda(ref verificar, 0);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entMoneda item in lstM)
                {
                    item.id_moneda = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_moneda));
                }

                return new { Resultado = "Ok", m = sr.Serialize(lstM) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Moneda(entMoneda m)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                m.id_moneda = m.id_moneda == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(m.id_moneda).Replace(" ", "+"));

                int resultado = negMoneda.Instancia.GuardarMoneda(ref verificar, m);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "El tipo de moneda se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "El tipo de moneda ya se encuentra registrado." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };

            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Eliminar_Moneda(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "Logistica.Moneda", "2", "id_moneda", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "El tipo de moneda se eliminó satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}