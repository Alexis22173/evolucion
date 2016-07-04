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
    public class datEliminar
    {
        private static readonly datEliminar _instancia = new datEliminar();
        public static datEliminar Instancia
        {
            get { return datEliminar._instancia; }
        }

        //public bool EliminarDatosTT(ref VerificarError verificar, String tabla, String estado, String campo, LstEliminar lst)
        public bool EliminarDatosTT(ref VerificarError verificar, String tabla, LstEliminar lst)
        {
            bool valor = false;
            SqlCommand cmd = null;
            try
            {
                cmd = MetodoDatos.CrearComando("Comunes.spEliminar_DatosTT");
                cmd.Parameters.AddWithValue("@tabla", tabla);
                //cmd.Parameters.AddWithValue("@estado", estado);
                //cmd.Parameters.AddWithValue("@campo", campo);
                cmd.Parameters.Add(new SqlParameter { ParameterName = "@TYPE_BASEID", Value = lst, SqlDbType = SqlDbType.Structured, TypeName = "dbo.Elimina_Datos" });
                cmd.ExecuteNonQuery();
                valor = true;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al eliminar los datos."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }

        public bool EliminarDatos(ref VerificarError verificar, String tabla, String estado, String campo, Int32 id_tabla)
        {
            SqlCommand cmd = null;
            bool valor = false;
            try
            {
                cmd = MetodoDatos.CrearComando("Comunes.spEliminar_Datos");
                cmd.Parameters.AddWithValue("@tabla", tabla);
                cmd.Parameters.AddWithValue("@estado", estado);
                cmd.Parameters.AddWithValue("@campo", campo);
                cmd.Parameters.AddWithValue("@id_tabla", id_tabla);
                cmd.ExecuteNonQuery();
                valor = true;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al eliminar los datos."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
    }
}
