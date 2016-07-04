using Datos.Comunes;
using Entidad.Ventas;
using Negocio.Comunes;
using Negocio.Ventas;
using SIS_BLANKITO.control;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capa_Presentacion.GestionarVenta
{
    public partial class gestionarTipoCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static object Listar_TipoCliente()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entTipo_Cliente> lstTC = negTipo_Cliente.Instancia.ListarTipoCliente(ref verificar, 0);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entTipo_Cliente item in lstTC)
                {
                    item.id_tipo_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_tipo_cliente));
                }

                return new { Resultado = "Ok", tc = sr.Serialize(lstTC) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_TipoCliente(entTipo_Cliente tc)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                tc.id_tipo_cliente = tc.id_tipo_cliente == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(tc.id_tipo_cliente).Replace(" ", "+"));

                int resultado = negTipo_Cliente.Instancia.GuardarTipoCliente(ref verificar, tc);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "El tipo de cliente se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "El tipo de cliente ya se encuentra registrado." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };

            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Eliminar_TipoCliente(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "Ventas.Tipo_Cliente", "2", "id_tipo_cliente", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "El tipo de documento se cliente satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}