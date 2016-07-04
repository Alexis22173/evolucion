using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Almacen;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Almacen
{
    public class datNota_Ingreso
    {
        private static readonly datNota_Ingreso _instancia = new datNota_Ingreso();
        public static datNota_Ingreso Instancia
        {
            get { return datNota_Ingreso._instancia; }
        }

        public bool GuardarNotaIngreso(ref VerificarError verificar, entNota_Ingreso ni, LstDetalleNota lst)
        {
            SqlCommand cmd = null;
            bool valor = false;
            try
            {
                cmd = MetodoDatos.CrearComando("Almacen.spGuardar_NotaIngreso");
                cmd.Parameters.AddWithValue("@id_nota_ingreso", ni.id_nota_ingreso);
                cmd.Parameters.AddWithValue("@id_motivo", ni.motivo.id_motivo);
                cmd.Parameters.AddWithValue("@id_orden_compra", ni.id_orden_compra);
                cmd.Parameters.AddWithValue("@id_orden_produccion", ni.id_orden_produccion);
                cmd.Parameters.AddWithValue("@id_usuario", ni.usuario.id_usuario);
                cmd.Parameters.AddWithValue("@id_sucursal", ni.sucursal.id_sucursal);
                cmd.Parameters.AddWithValue("@observacion", ni.observacion);
                cmd.Parameters.Add(new SqlParameter { ParameterName = "@TYPE_DETALLENOTA", Value = lst, SqlDbType = SqlDbType.Structured, TypeName = "dbo.DetalleNota" });
                cmd.ExecuteNonQuery();
                valor = true;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar la nota de ingreso."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }

        public DataTable ListarOrdenes(ref VerificarError verificar, String tipo)
        {
            SqlCommand cmd = null;
            DataTable dt = new DataTable();
            try
            {
                cmd = MetodoDatos.CrearComando("Comunes.spListar_Ordenes_Notas");
                cmd.Parameters.AddWithValue("@tipo", tipo);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar las ordenes."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return dt;
        }

        public List<entDetalle_Nota_Ingreso> ListarDetalleNotaIngreso(ref VerificarError verificar, Int32 id_nota, String tipo)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entDetalle_Nota_Ingreso> Lista = new List<entDetalle_Nota_Ingreso>();
            try
            {
                cmd = MetodoDatos.CrearComando("Almacen.spListar_DetalleNota");
                cmd.Parameters.AddWithValue("@id_nota", id_nota);
                cmd.Parameters.AddWithValue("@tipo", tipo);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entProducto p = new entProducto(){ id_producto = dr["id_producto"].ToString() };
                    entNota_Ingreso ni = new entNota_Ingreso() { id_nota_ingreso = dr["id_nota_ingreso"].ToString() };
                    entDetalle_Nota_Ingreso dni = new entDetalle_Nota_Ingreso()
                    {
                        cantidad = Convert.ToDecimal(dr["cantidad"]),
                        descripcion = dr["descripcion"].ToString(),
                        nota_ingreso = ni,
                        producto = p
                    };
                    Lista.Add(dni);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar el detalle de la nota de ingreso."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }
    }
}
