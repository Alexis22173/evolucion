using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Almacen;
using Entidad.Compras;
using Entidad.Comunes;
using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Compras
{
    public class datOrden_Compra
    {
        private static readonly datOrden_Compra _instancia = new datOrden_Compra();
        public static datOrden_Compra Instancia
        {
            get { return datOrden_Compra._instancia; }
        }

        public List<entOrden_Compra> ListarOrdenesCompra(ref VerificarError verificar, Int32 id_sucursal, String fecha_inicio, String fecha_fin)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entOrden_Compra> Lista = new List<entOrden_Compra>();
            try
            {
                cmd = MetodoDatos.CrearComando("Compras.spListar_OrdenesCompra");
                cmd.Parameters.AddWithValue("@id_sucursal", id_sucursal);
                cmd.Parameters.AddWithValue("@fecha_inicio", fecha_inicio);
                cmd.Parameters.AddWithValue("@fecha_fin", fecha_fin);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entProveedor p = new entProveedor ()
                    {
                        id_proveedor = dr["id_proveedor"].ToString(),
                        razon_social = dr["razon_social"].ToString()
                    };

                    entContacto_Proveedor cp = new entContacto_Proveedor()
                    {
                        id_contacto_proveedor = dr["id_contacto_proveedor"].ToString(),
                        nombres = dr["nombres"].ToString()
                    };

                    entMoneda m = new entMoneda()
                    {
                        id_moneda = dr["id_moneda"].ToString(),
                        descripcion = dr["moneda"].ToString()
                    };

                    entSucursal s = new entSucursal() { descripcion = dr["sucursal"].ToString() };

                    entOrden_Compra o = new entOrden_Compra()
                    {
                        id_orden_compra = dr["id_orden_compra"].ToString(),                        
                        fecha = dr["fecha"].ToString(),
                        fecha_vencimiento = dr["fecha_vencimiento"].ToString(),
                        proveedor = p,
                        contacto_proveedor = cp,
                        moneda = m,
                        sucursal = s,
                        total = Convert.ToDecimal(dr["total"]),
                        estado = dr["estado"].ToString(),

                    };
                    Lista.Add(o);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar las ordenes de compra."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public bool GuardarOrden(ref VerificarError verificar, entOrden_Compra o, LstDetalleCompra lst)
        {
            SqlCommand cmd = null;
            bool valor = false;
            try
            {
                cmd = MetodoDatos.CrearComando("Compras.spGuardar_OrdenCompra");
                cmd.Parameters.AddWithValue("@id_orden_compra", o.id_orden_compra);
                cmd.Parameters.AddWithValue("@fecha_vencimiento", o.fecha_vencimiento);
                cmd.Parameters.AddWithValue("@sub_total", o.sub_total);
                cmd.Parameters.AddWithValue("@igv", o.igv);
                cmd.Parameters.AddWithValue("@total", o.total);
                cmd.Parameters.AddWithValue("@id_proveedor", o.proveedor.id_proveedor);
                cmd.Parameters.AddWithValue("@id_contacto_proveedor", o.contacto_proveedor.id_contacto_proveedor);
                cmd.Parameters.AddWithValue("@id_moneda", o.moneda.id_moneda);
                cmd.Parameters.AddWithValue("@id_sucursal", o.sucursal.id_sucursal);
                cmd.Parameters.AddWithValue("@id_usuario", o.usuario.id_usuario);
                cmd.Parameters.Add(new SqlParameter { ParameterName = "@TYPE_DETALLEORDENCOMPRA", Value = lst, SqlDbType = SqlDbType.Structured, TypeName = "dbo.DetalleCompra" });
                cmd.ExecuteNonQuery();
                valor = true;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar la orden de compra."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }

        public List<entDetalle_OrdenCompra> ListarDetalleOrdeCompra(ref VerificarError verificar, Int32 id_orden_compra, String tipo)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entDetalle_OrdenCompra> Lista = new List<entDetalle_OrdenCompra>();
            try
            {
                cmd = MetodoDatos.CrearComando("Compras.spListar_DetalleOrdenCompra");
                cmd.Parameters.AddWithValue("@id_orden_compra", id_orden_compra);
                cmd.Parameters.AddWithValue("@tipo", tipo);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entProducto p = new entProducto()
                    {
                        id_producto = dr["id_producto"].ToString()
                    };
                    entDetalle_OrdenCompra doc = new entDetalle_OrdenCompra()
                    {
                        cantidad = Convert.ToDecimal(dr["cantidad"]),
                        descripcion = dr["descripcion"].ToString(),
                        precio = Convert.ToDecimal(dr["precio"]),
                        importe = Convert.ToDecimal(dr["importe"]),
                        producto = p
                    };
                    Lista.Add(doc);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar el detalle del pedido."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public List<entDetalle_OrdenCompra> ListarOrdenCompraSeleccionado(ref VerificarError verificar, Int32 id_orden_compra)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entDetalle_OrdenCompra> Lista = new List<entDetalle_OrdenCompra>();
            try
            {
                cmd = MetodoDatos.CrearComando("Compras.spListar_OrdenCompraDetalle");
                cmd.Parameters.AddWithValue("@id_orden_compra", id_orden_compra);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entProveedor p = new entProveedor()
                    {
                        id_proveedor = dr["id_proveedor"].ToString(),
                        razon_social = dr["razon_social"].ToString(),
                        dni_ruc = dr["dni_ruc"].ToString(),
                    };

                    entContacto_Proveedor cp = new entContacto_Proveedor()
                    {
                        id_contacto_proveedor = dr["id_contacto_proveedor"].ToString(),
                        nombres = dr["contacto"].ToString(),
                        dni = dr["dni"].ToString()
                    };

                    entMoneda m = new entMoneda()
                    {
                        id_moneda = dr["id_moneda"].ToString(),
                        descripcion = dr["moneda"].ToString()
                    };

                    entOrden_Compra o = new entOrden_Compra()
                    {
                        id_orden_compra = dr["id_orden_compra"].ToString(),
                        sub_total = Convert.ToDecimal(dr["sub_total"]),
                        igv = Convert.ToDecimal(dr["igv"]),
                        total = Convert.ToDecimal(dr["total"]),
                        fecha_vencimiento = dr["fecha_vencimiento"].ToString(),
                        proveedor = p,
                        contacto_proveedor = cp,
                        moneda = m,
                    };

                    entProducto pr = new entProducto()
                    {
                        id_producto = dr["id_producto"].ToString()
                    };

                    entDetalle_OrdenCompra doc = new entDetalle_OrdenCompra()
                    {
                        orden_compra = o,
                        producto = pr,
                        cantidad = Convert.ToDecimal(dr["cantidad"]),
                        descripcion = dr["descripcion"].ToString(),
                        precio = Convert.ToDecimal(dr["precio"]),
                        importe = Convert.ToDecimal(dr["importe"])
                    };

                    Lista.Add(doc);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar la orden de compra seleccionado."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }
    }
}
