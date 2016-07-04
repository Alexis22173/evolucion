using Datos.Seguridad;
using Datos.Comunes;
using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Datos.Logistica
{
    public class datMoneda
    {
        private static readonly datMoneda _instancia = new datMoneda();
        public static datMoneda Instancia
        {
            get { return datMoneda._instancia; }
        }

        public List<entMoneda> ListarMoneda(ref VerificarError verificar, Int32 id_moneda)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entMoneda> Lista = new List<entMoneda>();
            try
            {
                cmd = MetodoDatos.CrearComando("Logistica.spListar_Moneda");
                cmd.Parameters.AddWithValue("@id_moneda", id_moneda);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entMoneda m = new entMoneda()
                    {
                        id_moneda = dr["id_moneda"].ToString(),
                        descripcion = dr["descripcion"].ToString(),                      
                        estado = Convert.ToInt16(dr["estado"])
                    };
                    Lista.Add(m);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos de las monedas."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public int GuardarMoneda(ref VerificarError verificar, entMoneda m)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Logistica.spGuardar_Moneda");
                cmd.Parameters.AddWithValue("@id_moneda", m.id_moneda);
                cmd.Parameters.AddWithValue("@descripcion", m.descripcion);                
                cmd.Parameters.AddWithValue("@estado", m.estado);

                SqlParameter returnParameter = cmd.Parameters.Add("@VALOR", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                valor = (int)returnParameter.Value;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar moneda."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
    }
}
