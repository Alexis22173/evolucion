using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Almacen;
using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Almacen
{
    public class datProducto
    {
        private static readonly datProducto _instancia = new datProducto();
        public static datProducto Instancia
        {
            get { return datProducto._instancia; }
        }

        public List<entProducto> ListarProducto(ref VerificarError verificar, Int32 id_producto)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entProducto> Lista = new List<entProducto>();
            try
            {
                cmd = MetodoDatos.CrearComando("Almacen.spListar_Producto");
                cmd.Parameters.AddWithValue("@id_producto", id_producto);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entCategoria cat = new entCategoria()
                    {
                        id_categoria = dr["id_categoria"].ToString(),
                        descripcion = dr["categoria"].ToString()
                    };

                    entMarca mar = new entMarca()
                    {
                        id_marca = dr["id_marca"].ToString(),
                        descripcion = dr["marca"].ToString()
                    };

                    entProducto p = new entProducto()
                    {
                        id_producto = dr["id_producto"].ToString(),
                        descripcion = dr["descripcion"].ToString(),
                        unidad_med = dr["unidad_med"].ToString(),
                        precio_min = Convert.ToDecimal(dr["precio_min"]),
                        precio_max = Convert.ToDecimal(dr["precio_max"]),
                        categoria = cat,
                        marca = mar,
                        estado = Convert.ToInt16(dr["estado"]),
                    };

                    Lista.Add(p);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los productos."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public int GuardarProducto(ref VerificarError verificar, entProducto p)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Almacen.spGuardar_Producto");
                cmd.Parameters.AddWithValue("@id_producto", p.id_producto);
                cmd.Parameters.AddWithValue("@descripcion", p.descripcion);
                cmd.Parameters.AddWithValue("@unidad_med", p.unidad_med);
                cmd.Parameters.AddWithValue("@precio_min", p.precio_min);
                cmd.Parameters.AddWithValue("@precio_max", p.precio_max);
                cmd.Parameters.AddWithValue("@id_marca", p.marca.id_marca);
                cmd.Parameters.AddWithValue("@id_categoria", p.categoria.id_categoria);
                cmd.Parameters.AddWithValue("@estado", p.estado);
                cmd.Parameters.AddWithValue("@usuario_registro", p.usuario.id_usuario);

                SqlParameter returnParameter = cmd.Parameters.Add("@VALOR", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                valor = (int)returnParameter.Value;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar los datos del producto."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }

        public List<entStock_Producto> ListarStockProducto(ref VerificarError verificar, Int32 id_producto, Int32 id_sucursal)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entStock_Producto> Lista = new List<entStock_Producto>();
            try
            {
                cmd = MetodoDatos.CrearComando("Almacen.spListar_StockProducto");
                cmd.Parameters.AddWithValue("@id_producto", id_producto);
                cmd.Parameters.AddWithValue("@id_sucursal", id_sucursal);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entCategoria cat = new entCategoria()
                    {
                        descripcion = dr["categoria"].ToString()
                    };

                    entMarca mar = new entMarca()
                    {
                        descripcion = dr["marca"].ToString()
                    };

                    entSucursal suc = new entSucursal()
                    {
                        descripcion = dr["sucursal"].ToString()
                    };

                    entProducto prod = new entProducto()
                    {
                        id_producto = dr["id_producto"].ToString(),
                        descripcion = dr["producto"].ToString(),
                        precio_min = Convert.ToDecimal(dr["precio_min"]),
                        precio_max = Convert.ToDecimal(dr["precio_max"]),
                        categoria = cat,
                        marca = mar,
                        estado = Convert.ToInt16(dr["estado"]),
                    };

                    entStock_Producto sp = new entStock_Producto()
                    {
                        sucursal = suc,
                        producto = prod,
                        stock = Convert.ToDecimal(dr["stock"]),
                        cpm = Convert.ToDecimal(dr["cpm"]),
                    };
                    Lista.Add(sp);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los productos."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }


    }
}
