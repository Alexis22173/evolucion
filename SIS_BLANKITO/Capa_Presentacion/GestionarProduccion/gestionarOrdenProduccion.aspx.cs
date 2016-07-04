using Datos.Comunes;
using Entidad.Almacen;
using Entidad.Comunes;
using Entidad.Produccion;
using Negocio.Almacen;
using Negocio.Comunes;
using Negocio.Produccion;
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

namespace Capa_Presentacion.GestionarProduccion
{
    public partial class gestionarOrdenProduccion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {}

        [WebMethod]
        public static object Listar_Motivo()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entMotivo> lstTemp = negMotivo.Instancia.ListarMotivo(ref verificar, 0, "OP");
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                List<entMotivo> lstM = new List<entMotivo>();
                foreach (entMotivo item in lstTemp)
                {
                    if (item.tipo != "T") {
                        lstM.Add(new entMotivo { 
                            id_motivo =  HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_motivo)),
                            descripcion = item.descripcion
                        });                       
                    }
                }

                return new { Resultado = "Ok", m = sr.Serialize(lstM) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Listar_Productos(String codprod)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entStock_Producto> lstSP = new List<entStock_Producto>();
                lstSP = negProducto.Instancia.ListarStockProducto(ref verificar, Convert.ToInt32(codprod), Convert.ToInt32(clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal));
                if (verificar.Error.Count > 1) return new { Resultado = "NoOk", Mensaje = verificar.Error[1].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entStock_Producto item in lstSP)
                {
                    item.producto.id_producto = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.producto.id_producto));
                    item.producto.precio_min = 0;
                    item.producto.precio_max = 0;
                }

                return new { Resultado = "Ok", sp = sr.Serialize(lstSP) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_OrdenProduccion(entOrden_Produccion op, String jsondata)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                op.id_orden_produccion = op.id_orden_produccion == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(op.id_orden_produccion).Replace(" ", "+"));
                op.motivo.id_motivo = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(op.motivo.id_motivo).Replace(" ", "+"));
                op.id_pedido = op.id_pedido == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(op.id_pedido).Replace(" ", "+"));
                op.producto.id_producto = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(op.producto.id_producto).Replace(" ", "+"));
                op.usuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;
                op.sucursal.id_sucursal = clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal;

                List<srDetalleHorasTrabajadas> lstDet = sr.Deserialize<List<srDetalleHorasTrabajadas>>(jsondata);
                LstDetalleHorasTrabajadas lstDetalle = new LstDetalleHorasTrabajadas();
                foreach (srDetalleHorasTrabajadas item in lstDet)
                {
                    lstDetalle.Add(new srDetalleHT
                    {
                        id_orden_produccion = Convert.ToInt32(op.id_orden_produccion),
                        id_personal = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.id_personal.ToString()).Replace(" ", "+"))),
                        fecha_hora_inicio = Convert.ToDateTime(item.fecha_hora_inicio),
                        fecha_hora_fin = Convert.ToDateTime(item.fecha_hora_fin),
                        costo = item.costo
                    });
                }

                bool resultado = negOrden_Produccion.Instancia.GuardarOrdenProduccion(ref verificar, op, lstDetalle);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "La orden de producción se guardó satisfactoriamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}