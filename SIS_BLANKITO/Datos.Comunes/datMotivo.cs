using Datos.Seguridad;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Comunes
{
    public class datMotivo
    {
        private static readonly datMotivo _instancia = new datMotivo();
        public static datMotivo Instancia
        {
            get { return datMotivo._instancia; }
        }

        public List<entMotivo> ListarMotivo(ref VerificarError verificar, Int32 id_motivo, String tipo)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entMotivo> Lista = new List<entMotivo>();
            try
            {
                cmd = MetodoDatos.CrearComando("Comunes.spListar_Motivo");
                cmd.Parameters.AddWithValue("@id_motivo", id_motivo);
                cmd.Parameters.AddWithValue("@tipo", tipo);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entMotivo m = new entMotivo()
                    {
                        id_motivo = dr["id_motivo"].ToString(),
                        descripcion = dr["descripcion"].ToString(),
                        tipo = dr["tipo"].ToString(),
                        estado = Convert.ToInt16(dr["estado"].ToString())
                    };
                    Lista.Add(m);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos de los motivos."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }
    }
}
