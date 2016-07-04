using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Comunes;
using Entidad.Logistica;
using Entidad.Seguridad;
using Entidad.Ventas;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Ventas
{
    public class datVenta
    {
        private static readonly datVenta _instancia = new datVenta();
        public static datVenta Instancia
        {
            get { return datVenta._instancia; }
        }

        public List<entComprobanteVenta> ListarVentas(ref VerificarError verificar, Int32 id_venta, Int32 id_sucursal, Int32 id_tipo_documento, Int32 id_tipo_pago, String fecha_ini, String fecha_fin)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entComprobanteVenta> Lista = new List<entComprobanteVenta>();
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spListar_ComprobanteVenta");
                cmd.Parameters.AddWithValue("@id_venta", id_venta);
                cmd.Parameters.AddWithValue("@id_sucursal", id_sucursal);
                cmd.Parameters.AddWithValue("@id_tipo_documento", id_tipo_documento);
                cmd.Parameters.AddWithValue("@id_tipo_pago", id_tipo_pago);
                cmd.Parameters.AddWithValue("@fecha_ini", fecha_ini);
                cmd.Parameters.AddWithValue("@fecha_fin", fecha_fin);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entTipo_Pago tp = new entTipo_Pago() { descripcion = dr["tipopago"].ToString() };
                    entTipo_Documento td = new entTipo_Documento() { descripcion = dr["tipodocumento"].ToString() };
                    entNumero_Documento nd = new entNumero_Documento() { tipo_documento = td };
                    entCliente c = new entCliente() { 
                        nombres = dr["nombres"].ToString(),
                        dni_ruc = dr["dni_ruc"].ToString(), 
                    };
                    entUsuario u = new entUsuario() { usuario = dr["usuario"].ToString() };
                    entSucursal s = new entSucursal() { descripcion = dr["sucursal"].ToString() };

                    entComprobanteVenta v = new entComprobanteVenta()
                    {
                        id_venta = dr["id_venta"].ToString(),
                        fecha = dr["fecha"].ToString(),
                        tipo_pago = tp,
                        numero_documento = nd,
                        serie = dr["serie"].ToString(),
                        numero = dr["numero"].ToString(),
                        cliente = c,
                        total = Convert.ToDecimal(dr["total"]),
                        usuario = u,
                        sucursal = s
                    };

                    Lista.Add(v);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar las ventas."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public bool GuardarVenta(ref VerificarError verificar, entComprobanteVenta v)
        {
            SqlCommand cmd = null;
            bool valor = false;
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spGuardar_ComprobanteVenta");
                cmd.Parameters.AddWithValue("@id_venta", v.id_venta);
                cmd.Parameters.AddWithValue("@id_cliente", v.cliente.id_cliente);
                cmd.Parameters.AddWithValue("@id_numeros", v.numero_documento.tipo_documento.id_tipo_documento);
                cmd.Parameters.AddWithValue("@id_usuario", v.usuario.id_usuario);
                cmd.Parameters.AddWithValue("@id_sucursal", v.sucursal.id_sucursal);
                cmd.Parameters.AddWithValue("@id_pedido", v.pedido.id_pedido);
                cmd.Parameters.AddWithValue("@id_tipo_pago", v.tipo_pago.id_tipo_pago);
                cmd.Parameters.AddWithValue("@total", v.total);
                cmd.ExecuteNonQuery();
                valor = true;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar la venta."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }

    }
}
