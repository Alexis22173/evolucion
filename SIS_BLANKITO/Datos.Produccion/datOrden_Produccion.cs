using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Comunes;
using Entidad.Produccion;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Produccion
{
    public class datOrden_Produccion
    {
        private static readonly datOrden_Produccion _instancia = new datOrden_Produccion();
        public static datOrden_Produccion Instancia
        {
            get { return datOrden_Produccion._instancia; }
        }

        public bool GuardarOrdenProduccion(ref VerificarError verificar, entOrden_Produccion op, LstDetalleHorasTrabajadas lst)
        {
            SqlCommand cmd = null;
            bool valor = false;
            try
            {
                cmd = MetodoDatos.CrearComando("Produccion.spGuardar_OrdenProduccion");
                cmd.Parameters.AddWithValue("@id_orden_produccion", op.id_orden_produccion);
                cmd.Parameters.AddWithValue("@descripcion", op.descripcion);
                cmd.Parameters.AddWithValue("@fecha_entrega", op.fecha_entrega);
                cmd.Parameters.AddWithValue("@id_motivo", op.motivo.id_motivo);
                cmd.Parameters.AddWithValue("@id_pedido", op.id_pedido);
                cmd.Parameters.AddWithValue("@id_producto", op.producto.id_producto);
                cmd.Parameters.AddWithValue("@descripcion_producto", op.descripcion_producto);
                cmd.Parameters.AddWithValue("@cantidad", op.cantidad);
                cmd.Parameters.AddWithValue("@id_usuario", op.usuario.id_usuario);
                cmd.Parameters.AddWithValue("@id_sucursal", op.sucursal.id_sucursal);
                cmd.Parameters.Add(new SqlParameter { ParameterName = "@TYPE_DETALLEHORASTRABAJADAS", Value = lst, SqlDbType = SqlDbType.Structured, TypeName = "dbo.DetalleHorasTrabajadas" });
                cmd.ExecuteNonQuery();
                valor = true;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar la orden de producción."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
    }
}
