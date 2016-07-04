using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Seguridad
{
    public class MetodoDatos
    {
        static SqlConnection cn = Conexion.Instancia.obtenerConexion();
        public static SqlCommand CrearComando(string procedure)
        {
            cn.Open();
            SqlCommand cmd = new SqlCommand(procedure, cn);
            cmd.CommandType = CommandType.StoredProcedure;
            return cmd;
        }

        public static void ejecutarComando(SqlCommand cmd)
        {
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                cn.Close();
            }
        }

        public static void abrirConexion()
        {
            cn.Open();
        }

        public static void cerrarConexion()
        {
            cn.Close();
        }
    }
}
