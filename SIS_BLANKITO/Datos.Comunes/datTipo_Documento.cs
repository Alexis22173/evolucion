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
    public class datTipo_Documento
    {
        private static readonly datTipo_Documento _instancia = new datTipo_Documento();
        public static datTipo_Documento Instancia
        {
            get { return datTipo_Documento._instancia; }
        }

        public List<entTipo_Documento> ListarTipoDocumento(ref VerificarError verificar, Int32 id_tipo_documento)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entTipo_Documento> Lista = new List<entTipo_Documento>();
            try
            {
                cmd = MetodoDatos.CrearComando("Comunes.spListar_TipoDocumento");
                cmd.Parameters.AddWithValue("@id_tipo_documento", id_tipo_documento);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entTipo_Documento tc = new entTipo_Documento()
                    {
                        id_tipo_documento = dr["id_tipo_documento"].ToString(),
                        descripcion = dr["descripcion"].ToString(),
                        estado = Convert.ToInt16(dr["estado"].ToString())
                    };
                    Lista.Add(tc);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos del tipo de documentos."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public int GuardarTipoDocumento(ref VerificarError verificar, entTipo_Documento td) 
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Comunes.spGuardar_TipoDocumento");
                cmd.Parameters.AddWithValue("@id_tipo_documento", td.id_tipo_documento);
                cmd.Parameters.AddWithValue("@descripcion", td.descripcion);
                cmd.Parameters.AddWithValue("@estado", td.estado);
                
                SqlParameter returnParameter = cmd.Parameters.Add("@VALOR", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                valor = (int)returnParameter.Value;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar el tipo de documento."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
        
    }
}
