using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Almacen;
using Entidad.Comunes;
using Entidad.Ventas;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Ventas
{
    public class datPedido
    {
        private static readonly datPedido _instancia = new datPedido();
        public static datPedido Instancia
        {
            get { return datPedido._instancia; }
        }

        public List<entPedido> ListarPedidosDiarios(ref VerificarError verificar, Int32 id_sucursal)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entPedido> Lista = new List<entPedido>();
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spListar_PedidosDiarios");
                cmd.Parameters.AddWithValue("@id_sucursal", id_sucursal);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entTipo_Documento tp = new entTipo_Documento()
                    {
                        id_tipo_documento = dr["id_tipo_documento"].ToString(),
                        descripcion = dr["TipoDocumento"].ToString(),
                    };

                    entCliente c = new entCliente
                    {
                        id_cliente = dr["id_cliente"].ToString(),
                        dni_ruc = dr["dni_ruc"].ToString(),
                        nombres = dr["Cliente"].ToString()
                    };

                    entPedido p = new entPedido()
                    {
                        id_pedido = dr["id_pedido"].ToString(),
                        sub_total = Convert.ToDecimal(dr["sub_total"]),
                        igv = Convert.ToDecimal(dr["igv"]),
                        total = Convert.ToDecimal(dr["total"]),
                        fecha = dr["fecha"].ToString(),
                        cliente = c,
                        estado = dr["estado"].ToString(),
                        tipo_documento = tp,
                        numero = dr["numero"].ToString(),
                        produccion = Convert.ToInt16(dr["produccion"]),
                    };
                    Lista.Add(p);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los pedidos del día."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public List<entDetalle_Pedido> ListarDetallePedido(ref VerificarError verificar, Int32 id_pedido)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entDetalle_Pedido> Lista = new List<entDetalle_Pedido>();
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spListar_DetallePedido");
                cmd.Parameters.AddWithValue("@id_pedido", id_pedido);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entDetalle_Pedido dp = new entDetalle_Pedido()
                    {
                        cantidad = Convert.ToDecimal(dr["cantidad"]),
                        descripcion = dr["descripcion"].ToString(),
                        precio = Convert.ToDecimal(dr["precio"]),
                        importe = Convert.ToDecimal(dr["importe"])
                    };
                    Lista.Add(dp);
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

        public List<entDetalle_Pedido> ListarPedidoSeleccionado(ref VerificarError verificar, Int32 id_pedido)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entDetalle_Pedido> Lista = new List<entDetalle_Pedido>();
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spListar_PedidoDetalle");
                cmd.Parameters.AddWithValue("@id_pedido", id_pedido);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entTipo_Documento tp = new entTipo_Documento()
                    {
                        id_tipo_documento = dr["id_tipo_documento"].ToString(),
                        descripcion = dr["TipoDocumento"].ToString(),
                    };

                    entCliente c = new entCliente
                    {
                        id_cliente = dr["id_cliente"].ToString(),
                        dni_ruc = dr["dni_ruc"].ToString(),
                        nombres = dr["Cliente"].ToString()
                    };

                    entPedido p = new entPedido()
                    {
                        id_pedido = dr["id_pedido"].ToString(),
                        sub_total = Convert.ToDecimal(dr["sub_total"]),
                        igv = Convert.ToDecimal(dr["igv"]),
                        total = Convert.ToDecimal(dr["total"]),
                        fecha = dr["fecha"].ToString(),
                        cliente = c,
                        tipo_documento = tp,
                        produccion = Convert.ToInt16(dr["produccion"])
                    };

                    entProducto pr = new entProducto()
                    {
                        id_producto = dr["id_producto"].ToString()
                    };

                    entDetalle_Pedido dp = new entDetalle_Pedido()
                    {
                        pedido = p,
                        producto = pr,
                        cantidad = Convert.ToDecimal(dr["cantidad"]),
                        descripcion = dr["descripcion"].ToString(),
                        precio = Convert.ToDecimal(dr["precio"]),
                        importe = Convert.ToDecimal(dr["importe"])
                    };

                    Lista.Add(dp);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar el pedido seleccionado."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public bool GuardarPedido(ref VerificarError verificar, entPedido p, LstDetallePedido lst)
        {
            SqlCommand cmd = null;
            bool valor = false;
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spGuardar_Pedido");
                cmd.Parameters.AddWithValue("@id_pedido", p.id_pedido);
                cmd.Parameters.AddWithValue("@sub_total", p.sub_total);
                cmd.Parameters.AddWithValue("@igv", p.igv);
                cmd.Parameters.AddWithValue("@total", p.total);
                cmd.Parameters.AddWithValue("@id_cliente", p.cliente.id_cliente);
                cmd.Parameters.AddWithValue("@id_tipo_documento", p.tipo_documento.id_tipo_documento);
                cmd.Parameters.AddWithValue("@id_usuario", p.usuario.id_usuario);
                cmd.Parameters.AddWithValue("@id_sucursal", p.sucursal.id_sucursal);
                cmd.Parameters.AddWithValue("@produccion", p.produccion);
                cmd.Parameters.Add(new SqlParameter { ParameterName = "@TYPE_DETALLEPEDIDO", Value = lst, SqlDbType = SqlDbType.Structured, TypeName = "dbo.DetallePedido" });
                cmd.ExecuteNonQuery();
                valor = true;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar el pedido."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }

        public List<entPedido> ListarPedidosProduccion(ref VerificarError verificar, Int32 id_sucursal)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entPedido> Lista = new List<entPedido>();
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spListar_PedidosProduccion");
                cmd.Parameters.AddWithValue("@id_sucursal", id_sucursal);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entCliente c = new entCliente
                    {
                        nombres = dr["nombres"].ToString()
                    };

                    entPedido p = new entPedido()
                    {
                        id_pedido = dr["id_pedido"].ToString(),
                        numero = dr["numero"].ToString(),
                        total = Convert.ToDecimal(dr["total"]),                        
                        cliente = c
                    };
                    Lista.Add(p);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los pedidos pendientes para producción."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }
    }
}
