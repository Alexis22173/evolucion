using Datos.Comunes;
using Entidad.Almacen;
using Entidad.Comunes;
using Entidad.Ventas;
using Negocio.Almacen;
using Negocio.Comunes;
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
    public partial class gestionarPedido : System.Web.UI.Page
    {
        private static VerificarError verificarLoad;
        private static List<entPedido> lstPedido;
        private static List<entStock_Producto> lstSP;

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
            lstPedido = negPedido.Instancia.ListarPedidosDiarios(ref verificarLoad, Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal));
            lstSP = negProducto.Instancia.ListarStockProducto(ref verificarLoad, 0, Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal));
        }

        [WebMethod]
        public static object Mostrar_Cliente(String dniruc)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entCliente> objCliente = negCliente.Instancia.ListarCliente(ref verificar, 0, dniruc);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                if (objCliente.Count > 0)
                {
                    objCliente[0].id_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(objCliente[0].id_cliente));

                    // Para NO mostrar los datos correctos
                    objCliente[0].objUsuario.id_usuario = "-99";
                    objCliente[0].tipo_cliente.id_tipo_cliente = "-99";
                    objCliente[0].usuario = "";
                    objCliente[0].password = "";
                }
                
                return new { Resultado = "Ok", cliente = sr.Serialize(objCliente) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        public static void RecargarDatos()
        {
            verificarLoad = new VerificarError();
            lstPedido = new List<entPedido>();
            lstPedido = negPedido.Instancia.ListarPedidosDiarios(ref verificarLoad, Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal));
        }

        [WebMethod]
        public static object Listar_Pedidos(int edito)
        {
            try
            {
                if (edito == 1) { RecargarDatos(); }
                if (verificarLoad.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificarLoad.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entPedido item in lstPedido)
                {
                    item.id_pedido = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_pedido));
                    item.cliente.id_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.cliente.id_cliente));
                    item.tipo_documento.id_tipo_documento = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.tipo_documento.id_tipo_documento));                    
                }

                return new { Resultado = "Ok", pedidos = sr.Serialize(lstPedido) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Listar_Productos()
        {
            try
            {
                if (verificarLoad.Error.Count > 1) return new { Resultado = "NoOk", Mensaje = verificarLoad.Error[1].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entStock_Producto item in lstSP)
                {
                    item.producto.id_producto = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.producto.id_producto));
                    item.cpm = 0;
                }

                return new { Resultado = "Ok", sp = sr.Serialize(lstSP) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Mostrar_DetallePedido(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                List<entDetalle_Pedido> dp = negPedido.Instancia.ListarDetallePedido(ref verificar, nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", dp = sr.Serialize(dp) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Anular_Pedido(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "Ventas.Pedido", "'Anulado'", "id_pedido", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "Pedido anulado satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Pedido(entPedido p, String jsondata)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                p.id_pedido = p.id_pedido == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(p.id_pedido).Replace(" ", "+"));
                p.cliente.id_cliente = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(p.cliente.id_cliente).Replace(" ", "+"));
                p.tipo_documento.id_tipo_documento = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(p.tipo_documento.id_tipo_documento).Replace(" ", "+"));
                p.usuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;
                p.sucursal.id_sucursal = clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal;

                List<srDetallePedido> lstDet = sr.Deserialize<List<srDetallePedido>>(jsondata);
                LstDetallePedido lstDetalle = new LstDetallePedido();
                foreach (srDetallePedido item in lstDet)
                {
                    lstDetalle.Add(new srDetalleP
                    {
                        id_pedido = Convert.ToInt32(p.id_pedido),
                        id_producto = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.id_producto.ToString()).Replace(" ", "+"))),
                        cantidad = item.cantidad,
                        descripcion = item.descripcion,
                        precio = item.precio,
                        importe = item.importe,
                        id_venta = 0
                    });
                }

                bool resultado = negPedido.Instancia.GuardarPedido(ref verificar, p, lstDetalle);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "El pedido se guardó satisfactoriamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Mostrar_Pedido(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                List<entDetalle_Pedido> ps = negPedido.Instancia.ListarPedidoSeleccionado(ref verificar, nuevoId);

                foreach (entDetalle_Pedido item in ps)
                {
                    item.pedido.id_pedido = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.pedido.id_pedido));
                    item.pedido.cliente.id_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.pedido.cliente.id_cliente));
                    item.pedido.tipo_documento.id_tipo_documento = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.pedido.tipo_documento.id_tipo_documento));
                    item.producto.id_producto = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.producto.id_producto));
                }

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", ps = sr.Serialize(ps) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Listar_PedidosProduccion()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entPedido> lstPP = new List<entPedido>();
                lstPP = negPedido.Instancia.ListarPedidosProduccion(ref verificarLoad, Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal));
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entPedido item in lstPP)
                {
                    item.id_pedido = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_pedido));
                }

                return new { Resultado = "Ok", pp = sr.Serialize(lstPP) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
        
    }
}