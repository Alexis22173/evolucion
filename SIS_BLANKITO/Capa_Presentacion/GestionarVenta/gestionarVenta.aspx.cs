using Datos.Comunes;
using Entidad.Ventas;
using Negocio.Ventas;
using SIS_BLANKITO;
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
    public partial class gestionarVenta : System.Web.UI.Page
    {
        private static VerificarError verificarLoad;
        private static List<entComprobanteVenta> lstventa;

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
            String fecha = DateTime.Now.ToShortDateString();
            lstventa = negVenta.Instancia.ListarVentas(ref verificarLoad, 0, Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal), 0, 0, fecha.Split(' ')[0], fecha.Split(' ')[0]);
        }

        public static void RecargarDatos()
        {
            verificarLoad = new VerificarError();
            String fecha = DateTime.Now.ToShortDateString();
            lstventa = new List<entComprobanteVenta>();
            lstventa = negVenta.Instancia.ListarVentas(ref verificarLoad, 0, Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal), 0, 0, fecha.Split(' ')[0], fecha.Split(' ')[0]);
        }

        [WebMethod]
        public static object Listar_Ventas(int edito)
        {
            try
            {
                if (edito == 1) { RecargarDatos(); }
                if (verificarLoad.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificarLoad.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entComprobanteVenta item in lstventa)
                {
                    item.id_venta = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_venta));
                }

                return new { Resultado = "Ok", ventas = sr.Serialize(lstventa) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Venta(entComprobanteVenta v, String td)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                v.id_venta = v.id_venta == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(v.id_venta).Replace(" ", "+"));
                v.pedido.id_pedido = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(v.pedido.id_pedido).Replace(" ", "+"));
                v.cliente.id_cliente = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(v.cliente.id_cliente).Replace(" ", "+"));
                v.numero_documento.tipo_documento.id_tipo_documento = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(td).Replace(" ", "+"));
                v.tipo_pago.id_tipo_pago = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(v.tipo_pago.id_tipo_pago).Replace(" ", "+"));
                v.usuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;
                v.sucursal.id_sucursal = clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal;


                bool resultado = negVenta.Instancia.GuardarVenta(ref verificar, v);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "La venta se guardó satisfactoriamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}