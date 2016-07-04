using Datos.Comunes;
using Entidad.Almacen;
using Entidad.Comunes;
using Negocio.Almacen;
using Negocio.Comunes;
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

namespace Capa_Presentacion.GestionarAlmacen
{
    public partial class gestionarNotaIngreso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static object Listar_Motivo()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entMotivo> lstM = negMotivo.Instancia.ListarMotivo(ref verificar, 0, "NI");
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entMotivo item in lstM)
                {
                    item.id_motivo = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_motivo));
                }

                return new { Resultado = "Ok", m = sr.Serialize(lstM) };
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
                }

                return new { Resultado = "Ok", sp = sr.Serialize(lstSP) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Listar_Ordenes(String tipo)
        {
            try
            {
                String newTipo = "";
                if (tipo.Contains("COMPRA")) newTipo = "compra";
                else if (tipo.Contains("PRODUCCI")) newTipo = "producci";
                else return new { Resultado = "NoOk", Mensaje = "No es válido el motivo seleccionado." };

                VerificarError verificar = new VerificarError();
                DataTable dt = negNota_Ingreso.Instancia.ListarOrdenes(ref verificar, newTipo);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                List<object> lst = new List<object>();
                foreach (DataRow item in dt.Rows)
                {
                    lst.Add(new {
                        id_orden_compra = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item["id_orden_compra"].ToString())),
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
        public static object Guardar_NotaIngreso(entNota_Ingreso ni, String jsondata, String tipo)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                ni.id_nota_ingreso = ni.id_nota_ingreso == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(ni.id_nota_ingreso).Replace(" ", "+"));
                ni.motivo.id_motivo = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(ni.motivo.id_motivo).Replace(" ", "+"));
                ni.usuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;
                ni.sucursal.id_sucursal = clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal;

                String newMotivo = tipo.Split('|')[0];
                ni.id_orden_compra = newMotivo.Contains("COMPRA") ? clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(tipo.Split('|')[1]).Replace(" ", "+")) : "0";
                ni.id_orden_produccion = newMotivo.Contains("PRODUCCI") ? clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(tipo.Split('|')[1]).Replace(" ", "+")) : "0";

                List<srDetalleNota> lstDet = sr.Deserialize<List<srDetalleNota>>(jsondata);
                LstDetalleNota lstDetalle = new LstDetalleNota();
                foreach (srDetalleNota item in lstDet)
                {
                    lstDetalle.Add(new srDetalleN
                    {
                        id_nota = Convert.ToInt32(ni.id_nota_ingreso),
                        id_producto = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.id_producto.ToString()).Replace(" ", "+"))),
                        cantidad = item.cantidad,
                        descripcion = item.descripcion
                    });
                }

                bool resultado = negNota_Ingreso.Instancia.GuardarNotaIngreso(ref verificar, ni, lstDetalle);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "La nota de ingreso se guardó satisfactoriamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Mostrar_DetalleNotaIngreso(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                List<entDetalle_Nota_Ingreso> lstDNI = negNota_Ingreso.Instancia.ListarDetalleNotaIngreso(ref verificar, nuevoId, "NotaIngreso");

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entDetalle_Nota_Ingreso item in lstDNI)
                {
                    item.nota_ingreso.id_nota_ingreso = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.nota_ingreso.id_nota_ingreso));
                    item.producto.id_producto = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.producto.id_producto));
                }

                return new { Resultado = "Ok", dni = sr.Serialize(lstDNI) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}