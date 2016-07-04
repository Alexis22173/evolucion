using Datos.Comunes;
using Entidad.Almacen;
using Entidad.Compras;
using Entidad.Comunes;
using Negocio.Almacen;
using Negocio.Compras;
using Negocio.Comunes;
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

namespace Capa_Presentacion.GestionarCompra
{
    public partial class gestionarOrdenCompra : System.Web.UI.Page
    {
        //private static VerificarError verificarLoad;
        //private static List<entStock_Producto> lstSP;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDatos();
            }
        }

        public void CargarDatos()
        {
            //verificarLoad = new VerificarError();
            //lstSP = negProducto.Instancia.ListarStockProducto(ref verificarLoad, 0, Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal));
        }

        [WebMethod]
        public static object Listar_OrdenesCompra(String fecha_inicio, String fecha_fin)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entOrden_Compra> lstOrdenes = new List<entOrden_Compra>();
                lstOrdenes = negOrden_Compra.Instancia.ListarOrdenesCompra(ref verificar, Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal), fecha_inicio, fecha_fin);
                
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entOrden_Compra item in lstOrdenes)
                {
                    item.id_orden_compra = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_orden_compra));
                    item.proveedor.id_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.proveedor.id_proveedor));
                    item.contacto_proveedor.id_contacto_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.contacto_proveedor.id_contacto_proveedor));
                    item.moneda.id_moneda = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.moneda.id_moneda));
                }

                return new { Resultado = "Ok", oc = sr.Serialize(lstOrdenes) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Mostrar_Proveedor(String dniruc)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entProveedor> objProveedor = negProveedor.Instancia.ListarProveedor(ref verificar, 0, dniruc);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                if (objProveedor.Count > 0)
                {
                    objProveedor[0].id_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(objProveedor[0].id_proveedor));
                }

                return new { Resultado = "Ok", proveedor = sr.Serialize(objProveedor) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Mostrar_ContactoProveedor(String dni, String id_proveedor)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                Int32 nuevoId_proveedor = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id_proveedor).Replace(" ", "+")));
                List<entContacto_Proveedor> objCP = negContacto_Proveedor.Instancia.ListarContactoProveedor(ref verificar, 0, dni, nuevoId_proveedor);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                if (objCP.Count > 0)
                {
                    objCP[0].id_contacto_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(objCP[0].id_contacto_proveedor));
                    objCP[0].proveedor.id_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(objCP[0].proveedor.id_proveedor));
                }

                return new { Resultado = "Ok", cp = sr.Serialize(objCP) };
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
                VerificarError verificar = new VerificarError();
                List<entStock_Producto> lstSP = new List<entStock_Producto>();
                lstSP = negProducto.Instancia.ListarStockProducto(ref verificar, 0, Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal));
                if (verificar.Error.Count > 1) return new { Resultado = "NoOk", Mensaje = verificar.Error[1].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entStock_Producto item in lstSP)
                {
                    item.producto.id_producto = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.producto.id_producto));
                    item.producto.precio_min = 0;
                    item.producto.precio_max = 0;
                    item.stock = 0;
                }

                return new { Resultado = "Ok", sp = sr.Serialize(lstSP) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_OrdenCompra(entOrden_Compra o, String jsondata)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                o.id_orden_compra = o.id_orden_compra == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(o.id_orden_compra).Replace(" ", "+"));
                o.proveedor.id_proveedor = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(o.proveedor.id_proveedor).Replace(" ", "+"));
                o.contacto_proveedor.id_contacto_proveedor = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(o.contacto_proveedor.id_contacto_proveedor).Replace(" ", "+"));
                o.moneda.id_moneda = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(o.moneda.id_moneda).Replace(" ", "+"));
                o.sucursal.id_sucursal = clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal;
                o.usuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;

                List<srDetalleCompra> lstDet = sr.Deserialize<List<srDetalleCompra>>(jsondata);
                LstDetalleCompra lstDetalle = new LstDetalleCompra();
                foreach (srDetalleCompra item in lstDet)
                {
                    lstDetalle.Add(new srDetalleC
                    {
                        id_compra = Convert.ToInt32(o.id_orden_compra),
                        id_producto = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.id_producto.ToString()).Replace(" ", "+"))),
                        cantidad = item.cantidad,
                        descripcion = item.descripcion,
                        precio = item.precio,
                        importe = item.importe,
                    });
                }

                bool resultado = negOrden_Compra.Instancia.GuardarOrden(ref verificar, o, lstDetalle);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "La orden de compra se guardó satisfactoriamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Mostrar_DetalleOrdenCompra(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                List<entDetalle_OrdenCompra> doc = negOrden_Compra.Instancia.ListarDetalleOrdeCompra(ref verificar, nuevoId, "orden");

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                foreach (entDetalle_OrdenCompra item in doc)
                {
                    item.producto.id_producto = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.producto.id_producto));
                }
                return new { Resultado = "Ok", doc = sr.Serialize(doc) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Mostrar_OrdenCompra(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                List<entDetalle_OrdenCompra> doc = negOrden_Compra.Instancia.ListarOrdenCompraSeleccionado(ref verificar, nuevoId);

                foreach (entDetalle_OrdenCompra item in doc)
                {
                    item.orden_compra.id_orden_compra = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.orden_compra.id_orden_compra));
                    item.orden_compra.proveedor.id_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.orden_compra.proveedor.id_proveedor));
                    item.orden_compra.contacto_proveedor.id_contacto_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.orden_compra.contacto_proveedor.id_contacto_proveedor));
                    item.orden_compra.moneda.id_moneda = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.orden_compra.moneda.id_moneda));
                    item.producto.id_producto = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.producto.id_producto));
                }

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", doc = sr.Serialize(doc) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Anular_OrdenCompra(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "Compras.Orden_Compra", "'Anulado'", "id_orden_compra", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "Orden de compra anulado satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

    }
}