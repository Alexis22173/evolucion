using Datos.Comunes;
using Entidad.Compras;
using Entidad.Comunes;
using Negocio.Compras;
using SIS_BLANKITO;
using SIS_BLANKITO.control;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capa_Presentacion.GestionarCompra
{
    public partial class gestionarCompra : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static object Listar_NotasIngreso()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                DataTable dt = negComprobante_Compra.Instancia.ListarNotasIngreso(ref verificar, "notaingreso");
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                List<object> lst = new List<object>();
                foreach (DataRow item in dt.Rows)
                {
                    lst.Add(new
                    {
                        id_nota_ingreso = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item["id_nota_ingreso"].ToString())),
                        numero = item["numero"].ToString(),
                        fecha = item["fecha"].ToString()
                    });
                }

                return new { Resultado = "Ok", o = sr.Serialize(lst) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Compra(entComprobante_Compra c, String jsondata)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                c.id_compra = c.id_compra == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(c.id_compra).Replace(" ", "+"));
                c.proveedor.id_proveedor = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(c.proveedor.id_proveedor).Replace(" ", "+"));
                c.contacto_proveedor.id_contacto_proveedor = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(c.contacto_proveedor.id_contacto_proveedor).Replace(" ", "+"));
                c.tipo_documento.id_tipo_documento = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(c.tipo_documento.id_tipo_documento).Replace(" ", "+"));
                c.tipo_pago.id_tipo_pago = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(c.tipo_pago.id_tipo_pago).Replace(" ", "+"));
                c.moneda.id_moneda = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(c.moneda.id_moneda).Replace(" ", "+"));
                c.sucursal.id_sucursal = clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal;
                c.usuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;

                List<srDetalleCompra> lstDet = sr.Deserialize<List<srDetalleCompra>>(jsondata);
                LstDetalleCompra lstDetalle = new LstDetalleCompra();
                foreach (srDetalleCompra item in lstDet)
                {
                    lstDetalle.Add(new srDetalleC
                    {
                        id_compra = Convert.ToInt32(c.id_compra),
                        id_nota_ingreso = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.id_nota_ingreso.ToString()).Replace(" ", "+"))),
                        id_producto = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.id_producto.ToString()).Replace(" ", "+"))),
                        cantidad = item.cantidad,
                        descripcion = item.descripcion,
                        precio = item.precio,
                        importe = item.importe,
                    });
                }

                bool resultado = negComprobante_Compra.Instancia.GuardarCompra(ref verificar, c, lstDetalle);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "El comprobante de compra se guardó satisfactoriamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}