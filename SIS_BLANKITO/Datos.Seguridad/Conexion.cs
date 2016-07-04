using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Seguridad
{
    public class Conexion
    {
        private static readonly Conexion _instancia = new Conexion();
        public static Conexion Instancia
        {
            get { return Conexion._instancia; }
        }

               //string cadenaConexion = "Data Source=localhost;Initial Catalog=BD_BLANKITO; User ID=sa;Password=Alexis22041992$";
        string cadenaConexion = "Data Source=localhost;Initial Catalog=BD_BLANKITO; User ID=sa;Password=123456";
        

        SqlConnection con = new SqlConnection();

        public SqlConnection obtenerConexion()
        {
            con.ConnectionString = cadenaConexion;
            return con;
        }
    }    
}
