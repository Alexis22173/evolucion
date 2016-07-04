using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Compras;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Compras
{
    public class datComprobante_Compra
    {
        private static readonly datComprobante_Compra _instancia = new datComprobante_Compra();
        public static datComprobante_Compra Instancia
        {
            get { return datComprobante_Compra._instancia; }
        }

        public DataTable ListarNotasIngreso(ref VerificarError verificar, String tipo)
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

        public bool GuardarCompra(ref VerificarError verificar, entComprobante_Compra c, LstDetalleCompra lst)
        {
            SqlCommand cmd = null;
            bool valor = false;
            try
            {
                cmd = MetodoDatos.CrearComando("Compras.spGuardar_ComprobanteCompra");
                cmd.Parameters.AddWithValue("@id_compra", c.id_compra);
                cmd.Parameters.AddWithValue("@id_proveedor", c.proveedor.id_proveedor);
                cmd.Parameters.AddWithValue("@id_contacto_proveedor", c.contacto_proveedor.id_contacto_proveedor);
                cmd.Parameters.AddWithValue("@id_tipo_documento", c.tipo_documento.id_tipo_documento);
                cmd.Parameters.AddWithValue("@id_usuario", c.usuario.id_usuario);
                cmd.Parameters.AddWithValue("@id_sucursal", c.sucursal.id_sucursal);
                cmd.Parameters.AddWithValue("@id_tipo_pago", c.tipo_pago.id_tipo_pago);
                cmd.Parameters.AddWithValue("@id_moneda", c.moneda.id_moneda);
                cmd.Parameters.AddWithValue("@sub_total", c.sub_total);
                cmd.Parameters.AddWithValue("@igv", c.igv);
                cmd.Parameters.AddWithValue("@total", c.total);
                cmd.Parameters.Add(new SqlParameter { ParameterName = "@TYPE_DETALLECOMPRA", Value = lst, SqlDbType = SqlDbType.Structured, TypeName = "dbo.DetalleCompra" });
                cmd.ExecuteNonQuery();
                valor = true;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar el comprobante de compra."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
    }
}
