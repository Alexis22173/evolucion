using Datos.Seguridad;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Comunes
{
    public class datTipo_Pago
    {
        private static readonly datTipo_Pago _instancia = new datTipo_Pago();
        public static datTipo_Pago Instancia
        {
            get { return datTipo_Pago._instancia; }
        }

        public List<entTipo_Pago> ListarTipoPago(ref VerificarError verificar, Int32 id_tipo_pago)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entTipo_Pago> Lista = new List<entTipo_Pago>();
            try
            {
                cmd = MetodoDatos.CrearComando("Comunes.spListar_TipoPago");
                cmd.Parameters.AddWithValue("@id_tipo_pago", id_tipo_pago);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entTipo_Pago tp = new entTipo_Pago()
                    {
                        id_tipo_pago = dr["id_tipo_pago"].ToString(),
                        descripcion = dr["descripcion"].ToString(),
                        estado = Convert.ToInt16(dr["estado"])
                    };
                    Lista.Add(tp);
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

        public int GuardarTipoPago(ref VerificarError verificar, entTipo_Pago tp)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Comunes.spGuardar_TipoPago");
                cmd.Parameters.AddWithValue("@id_tipo_pago", tp.id_tipo_pago);
                cmd.Parameters.AddWithValue("@descripcion", tp.descripcion);
                cmd.Parameters.AddWithValue("@estado", tp.estado);

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
