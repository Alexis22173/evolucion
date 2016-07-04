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
    public class datSucursal
    {
        private static readonly datSucursal _instancia = new datSucursal();
        public static datSucursal Instancia
        {
            get { return datSucursal._instancia; }
        }

        public List<entSucursal> ListarSucursal(ref VerificarError verificar, Int32 id_sucursal)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entSucursal> Lista = new List<entSucursal>();
            try
            {
                cmd = MetodoDatos.CrearComando("Logistica.spListar_Sucursal");
                cmd.Parameters.AddWithValue("@id_sucursal", id_sucursal);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entSucursal s = new entSucursal()
                    {
                        id_sucursal = dr["id_sucursal"].ToString(),
                        descripcion = dr["descripcion"].ToString(),
                        direccion=dr["direccion"].ToString(),
                        telefono=dr["telefono"].ToString(),                        
                        estado = Convert.ToInt16(dr["estado"])
                    };
                    Lista.Add(s);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos de las sucursales."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public int GuardarSucursal(ref VerificarError verificar, entSucursal s)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Logistica.spGuardar_Sucursal");
                cmd.Parameters.AddWithValue("@id_sucursal", s.id_sucursal);
                cmd.Parameters.AddWithValue("@descripcion", s.descripcion);
                cmd.Parameters.AddWithValue("@direccion", s.direccion);
                cmd.Parameters.AddWithValue("@telefono", s.telefono);
                cmd.Parameters.AddWithValue("@estado", s.estado);

                SqlParameter returnParameter = cmd.Parameters.Add("@VALOR", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                valor = (int)returnParameter.Value;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar sucursal."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
    }
}
