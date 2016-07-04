using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Ventas;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Datos.Ventas
{
    public class datCliente
    {
        private static readonly datCliente _instancia = new datCliente();
        public static datCliente Instancia
        {
            get { return datCliente._instancia; }
        }

        public List<entCliente> ListarCliente(ref VerificarError verificar, Int32 id_cliente, String dni_ruc)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entCliente> Lista = new List<entCliente>();
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spListar_Cliente");
                cmd.Parameters.AddWithValue("@id_cliente", id_cliente);
                cmd.Parameters.AddWithValue("@dni_ruc", dni_ruc);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entTipo_Cliente tc = new entTipo_Cliente()
                    {
                        id_tipo_cliente = dr["id_tipo_cliente"].ToString(),
                        descripcion = dr["tipo_cliente"].ToString()
                    };

                    entCliente c = new entCliente()
                    {
                        id_cliente = dr["id_cliente"].ToString(),
                        nombres = dr["nombres"].ToString(),
                        apellidos = dr["apellidos"].ToString(),
                        dni_ruc = dr["dni_ruc"].ToString(),
                        sexo = dr["sexo"].ToString(),
                        direccion = dr["direccion"].ToString(),
                        correo = dr["correo"].ToString(),
                        telefono = dr["telefono"].ToString(),
                        celular = dr["celular"].ToString(),
                        estado = Convert.ToInt16(dr["estado"]),
                        total = Convert.ToDecimal(dr["total"]),
                        registro_online = Convert.ToInt16(dr["registro_online"]),
                        tipo_cliente = tc
                    };
                    Lista.Add(c);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos del cliente."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public int GuardarCliente(ref VerificarError verificar, entCliente c)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spGuardar_Cliente");
                cmd.Parameters.AddWithValue("@id_cliente", c.id_cliente);
                cmd.Parameters.AddWithValue("@nombres", c.nombres);
                cmd.Parameters.AddWithValue("@apellidos", c.apellidos);
                cmd.Parameters.AddWithValue("@dni_ruc", c.dni_ruc);
                cmd.Parameters.AddWithValue("@sexo", c.sexo);
                cmd.Parameters.AddWithValue("@direccion", c.direccion);
                cmd.Parameters.AddWithValue("@correo", c.correo);
                cmd.Parameters.AddWithValue("@telefono", c.telefono);
                cmd.Parameters.AddWithValue("@celular", c.celular);
                cmd.Parameters.AddWithValue("@estado", c.estado);
                cmd.Parameters.AddWithValue("@id_tipo_cliente", c.tipo_cliente.id_tipo_cliente);
                cmd.Parameters.AddWithValue("@usuario_registro", c.objUsuario.id_usuario);
                cmd.Parameters.AddWithValue("@registro_online", c.registro_online);
                cmd.Parameters.AddWithValue("@usuario", c.usuario);
                cmd.Parameters.AddWithValue("@password", c.password);
                //cmd.Parameters.AddWithValue("@id_sucursal", id_sucursal);
                SqlParameter returnParameter = cmd.Parameters.Add("@VALOR", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                valor = (int)returnParameter.Value;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar los datos del cliente."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
        
    }
}
