using Datos.Seguridad;
using Datos.Comunes;
using Entidad.RRHH;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.RRHH
{
    public class datTipo_Personal
    {
        private static readonly datTipo_Personal _instancia = new datTipo_Personal();
        public static datTipo_Personal Instancia
        {
            get { return datTipo_Personal._instancia; }
        }

        public List<entTipo_Personal> ListarTipoPersonal(ref VerificarError verificar, Int32 id_tipo_personal)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entTipo_Personal> Lista = new List<entTipo_Personal>();
            try
            {
                cmd = MetodoDatos.CrearComando("RRHH.spListar_TipoPersonal");
                cmd.Parameters.AddWithValue("@id_tipo_personal", id_tipo_personal);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entTipo_Personal tp = new entTipo_Personal()
                    {
                        id_tipo_personal = dr["id_tipo_personal"].ToString(),
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

        public int GuardarTipoPersonal(ref VerificarError verificar, entTipo_Personal tp)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("RRHH.spGuardar_TipoPersonal");
                cmd.Parameters.AddWithValue("@id_tipo_personal", tp.id_tipo_personal);
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
