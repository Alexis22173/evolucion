using Datos.Comunes;
using Entidad.Ventas;
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
    public partial class gestionarCuentaCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static object Listar_Cuentas()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entCuenta_Cliente> lstCuenta = negCuentaCliente.Instancia.ListarCuentas(ref verificar);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entCuenta_Cliente item in lstCuenta)
                {
                    item.cliente.id_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.cliente.id_cliente));
                }

                return new { Resultado = "Ok", cc = sr.Serialize(lstCuenta) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Listar_CuentasCliente(String id_cliente)
        {
            try
            {               
                Int32 nuevoId_cliente = id_cliente == "0" ? 0 : Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id_cliente).Replace(" ", "+")));

                VerificarError verificar = new VerificarError();
                List<entCuenta_Cliente> lstCC = negCuentaCliente.Instancia.ListarCuentasCliente(ref verificar, nuevoId_cliente);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entCuenta_Cliente item in lstCC)
                {
                    item.id_cuenta_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_cuenta_cliente));
                    item.cliente.id_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.cliente.id_cliente));
                    item.venta.id_venta = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.venta.id_venta));
                    item.venta.pedido.id_pedido = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.venta.pedido.id_pedido));
                }

                return new { Resultado = "Ok", cc = sr.Serialize(lstCC) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Pago(String id_cliente, String monto)
        {
            try
            {
                Int32 nuevoId_cliente = id_cliente == "0" ? 0 : Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id_cliente).Replace(" ", "+")));

                VerificarError verificar = new VerificarError();
                bool resultado = negCuentaCliente.Instancia.GuardarPagoDeuda(ref verificar, nuevoId_cliente, Convert.ToDecimal(monto));
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "El pago se realizó correctamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}