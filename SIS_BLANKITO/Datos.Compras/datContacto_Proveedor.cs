using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Compras;
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
    public class datContacto_Proveedor
    {
        private static readonly datContacto_Proveedor _instancia = new datContacto_Proveedor();
        public static datContacto_Proveedor Instancia
        {
            get { return datContacto_Proveedor._instancia; }
        }

        public List<entContacto_Proveedor> ListarContactoProveedor(ref VerificarError verificar, Int32 id_contacto_proveedor, String dni, Int32 id_proveedor)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entContacto_Proveedor> Lista = new List<entContacto_Proveedor>();
            try
            {
                cmd = MetodoDatos.CrearComando("Compras.spListar_ContactoProveedor");
                cmd.Parameters.AddWithValue("@id_contacto_proveedor", id_contacto_proveedor);
                cmd.Parameters.AddWithValue("@dni", dni);
                cmd.Parameters.AddWithValue("@id_proveedor", id_proveedor);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entProveedor p = new entProveedor()
                    {
                        id_proveedor = dr["id_proveedor"].ToString(),
                        razon_social = dr["razon_social"].ToString(),
                        dni_ruc = dr["dni_ruc"].ToString()
                    };

                    entContacto_Proveedor cp = new entContacto_Proveedor()
                    {
                        id_contacto_proveedor = dr["id_contacto_proveedor"].ToString(),
                        nombres = dr["nombres"].ToString(),
                        dni = dr["dni"].ToString(),
                        correo = dr["correo"].ToString(),
                        telefono = dr["telefono"].ToString(),
                        celular = dr["celular"].ToString(),
                        estado = Convert.ToInt16(dr["estado"]),
                        proveedor = p
                    };
                    Lista.Add(cp);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos de contacto proveedor."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public int GuardarContactoProveedor(ref VerificarError verificar, entContacto_Proveedor cp)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Compras.spGuardar_ContactoProveedor");
                cmd.Parameters.AddWithValue("@id_contacto_proveedor", cp.id_contacto_proveedor);
                cmd.Parameters.AddWithValue("@nombres", cp.nombres);
                //cmd.Parameters.AddWithValue("@apellidos", cp.apellidos);
                cmd.Parameters.AddWithValue("@dni", cp.dni);               
                cmd.Parameters.AddWithValue("@correo", cp.correo);
                cmd.Parameters.AddWithValue("@telefono", cp.telefono);
                cmd.Parameters.AddWithValue("@celular", cp.celular);
                cmd.Parameters.AddWithValue("@estado", cp.estado);
                cmd.Parameters.AddWithValue("@id_proveedor", cp.proveedor.id_proveedor);
                cmd.Parameters.AddWithValue("@usuario_registro", cp.usuario.id_usuario);
               
                //cmd.Parameters.AddWithValue("@id_sucursal", id_sucursal);
                SqlParameter returnParameter = cmd.Parameters.Add("@VALOR", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                valor = (int)returnParameter.Value;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar los datos del contacto proveedor."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
    }
}
