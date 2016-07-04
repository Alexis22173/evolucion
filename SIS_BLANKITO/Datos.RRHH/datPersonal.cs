using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Logistica;
using Entidad.RRHH;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.RRHH
{
    public class datPersonal
    {
        private static readonly datPersonal _instancia = new datPersonal();
        public static datPersonal Instancia
        {
            get { return datPersonal._instancia; }
        }

        public List<entPersonal> ListarPersonal(ref VerificarError verificar, Int32 id_personal, Int32 dni)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entPersonal> Lista = new List<entPersonal>();
            try
            {
                cmd = MetodoDatos.CrearComando("RRHH.spListar_Personal");
                cmd.Parameters.AddWithValue("@id_personal", id_personal);
                cmd.Parameters.AddWithValue("@dni", dni);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entSucursal s = new entSucursal()
                    {
                        id_sucursal = dr["id_sucursal"].ToString(),
                        descripcion = dr["sucursal"].ToString(),
                    };
                    entTipo_Personal tp = new entTipo_Personal()
                    {
                        id_tipo_personal = dr["id_tipo_personal"].ToString(),
                        descripcion = dr["tipo_personal"].ToString(),
                    };
                    entPersonal p = new entPersonal()
                    {
                        id_personal = dr["id_personal"].ToString(),
                        nombres = dr["nombres"].ToString(),
                        apellido_paterno = dr["apellido_paterno"].ToString(),
                        apellido_materno = dr["apellido_materno"].ToString(),
                        dni = Convert.ToInt32(dr["dni"]),
                        fecha_nac = dr["fecha_nac"].ToString(),
                        sexo = dr["sexo"].ToString(),
                        direccion = dr["direccion"].ToString(),
                        correo = dr["correo"].ToString(),
                        telefono = dr["telefono"].ToString(),
                        celular = dr["celular"].ToString(),
                        estado = Convert.ToInt16(dr["estado"]),
                        sucursal = s,
                        tipo_personal = tp,
                        sueldo_total = Convert.ToDecimal(dr["sueldo_total"]),
                        sueldo_hora = Convert.ToDecimal(dr["sueldo_hora"]),
                        imagen = dr["imagen"].ToString()
                    };
                    Lista.Add(p);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos del personal."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }
    }
}
