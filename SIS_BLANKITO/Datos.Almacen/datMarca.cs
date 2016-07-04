using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Almacen;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Almacen
{
    public class datMarca
    {
        private static readonly datMarca _instancia = new datMarca();
        public static datMarca Instancia
        {
            get { return datMarca._instancia; }
        }

        public List<entMarca> ListarMarca(ref VerificarError verificar, Int32 id_marca)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entMarca> Lista = new List<entMarca>();
            try
            {
                cmd = MetodoDatos.CrearComando("Almacen.spListar_Marca");
                cmd.Parameters.AddWithValue("@id_marca", id_marca);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entMarca m = new entMarca()
                    {
                        id_marca = dr["id_marca"].ToString(),
                        descripcion = dr["descripcion"].ToString(),
                        estado = Convert.ToInt16(dr["estado"])
                    };
                    Lista.Add(m);
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

        public int GuardarMarca(ref VerificarError verificar, entMarca m)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Almacen.spGuardar_Marca");
                cmd.Parameters.AddWithValue("@id_marca", m.id_marca);
                cmd.Parameters.AddWithValue("@descripcion", m.descripcion);
                cmd.Parameters.AddWithValue("@estado", m.estado);

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
