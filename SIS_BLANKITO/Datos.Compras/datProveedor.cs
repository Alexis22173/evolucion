using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Compras;
using Entidad.Comunes;
using Entidad.Seguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Datos.Compras
{
    public class datProveedor
    {
        private static readonly datProveedor _instancia = new datProveedor();
        public static datProveedor Instancia
        {
            get { return datProveedor._instancia; }
        }

        public List<entProveedor> ListarProveedor(ref VerificarError verificar, Int32 id_proveedor, String dni_ruc)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entProveedor> Lista = new List<entProveedor>();
            try
            {
                cmd = MetodoDatos.CrearComando("Compras.spListar_Proveedor");
                cmd.Parameters.AddWithValue("@id_proveedor", id_proveedor);
                cmd.Parameters.AddWithValue("@dni_ruc", dni_ruc);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entProveedor p = new entProveedor()
                    {
                        id_proveedor = dr["id_proveedor"].ToString(),
                        razon_social = dr["razon_social"].ToString(),
                        dni_ruc = dr["dni_ruc"].ToString(),
                        direccion = dr["direccion"].ToString(),
                        correo = dr["correo"].ToString(),
                        telefono = dr["telefono"].ToString(),
                        celular = dr["celular"].ToString(),
                        estado = Convert.ToInt16(dr["estado"]),
                        total = Convert.ToDecimal(dr["total"]),
                    };
                    Lista.Add(p);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos del proveedor."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public int GuardarProveedor(ref VerificarError verificar, entProveedor p)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Compras.spGuardar_Proveedor");
                cmd.Parameters.AddWithValue("@id_proveedor", p.id_proveedor);
                cmd.Parameters.AddWithValue("@razon_social", p.razon_social);                
                cmd.Parameters.AddWithValue("@dni_ruc", p.dni_ruc);                
                cmd.Parameters.AddWithValue("@direccion", p.direccion);
                cmd.Parameters.AddWithValue("@correo", p.correo);
                cmd.Parameters.AddWithValue("@telefono", p.telefono);
                cmd.Parameters.AddWithValue("@celular", p.celular);
                cmd.Parameters.AddWithValue("@estado", p.estado);                
                cmd.Parameters.AddWithValue("@usuario_registro", p.objUsuario.id_usuario);
            
                SqlParameter returnParameter = cmd.Parameters.Add("@VALOR", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                valor = (int)returnParameter.Value;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar los datos del proveedor."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
    }
}
