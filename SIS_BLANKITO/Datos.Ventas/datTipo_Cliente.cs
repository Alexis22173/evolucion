using Datos.Comunes;
using Datos.Seguridad;
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
    public class datTipo_Cliente
    {
        private static readonly datTipo_Cliente _instancia = new datTipo_Cliente();
        public static datTipo_Cliente Instancia
        {
            get { return datTipo_Cliente._instancia; }
        }

        public List<entTipo_Cliente> ListarTipoCliente(ref VerificarError verificar, Int32 id_tipo_cliente)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entTipo_Cliente> Lista = new List<entTipo_Cliente>();
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spListar_TipoCliente");
                cmd.Parameters.AddWithValue("@id_tipo_cliente", id_tipo_cliente);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entTipo_Cliente tc = new entTipo_Cliente()
                    {
                        id_tipo_cliente = dr["id_tipo_cliente"].ToString(),
                        descripcion = dr["descripcion"].ToString(),
                        estado = Convert.ToInt16(dr["estado"])
                    };
                    Lista.Add(tc);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos del tipo de cliente."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public int GuardarTipoCliente(ref VerificarError verificar, entTipo_Cliente tc)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spGuardar_TipoCliente");
                cmd.Parameters.AddWithValue("@id_tipo_cliente", tc.id_tipo_cliente);
                cmd.Parameters.AddWithValue("@descripcion", tc.descripcion);
                cmd.Parameters.AddWithValue("@estado", tc.estado);

                SqlParameter returnParameter = cmd.Parameters.Add("@VALOR", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                valor = (int)returnParameter.Value;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar el tipo de cliente."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
    }
}
