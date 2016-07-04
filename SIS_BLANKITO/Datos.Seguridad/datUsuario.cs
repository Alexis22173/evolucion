using Entidad.Logistica;
using Entidad.RRHH;
using Entidad.Seguridad;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Seguridad
{
    public class datUsuario
    {
        private static readonly datUsuario _instancia = new datUsuario();
        public static datUsuario Instancia
        {
            get { return datUsuario._instancia; }
        }

        public entUsuario LoginUsuario(String usuario, String password)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            entUsuario objUsuario = new entUsuario();
            try
            {
                cmd = MetodoDatos.CrearComando("Seguridad.spListar_Usuario");
                cmd.Parameters.AddWithValue("@id_usuario", 0);
                cmd.Parameters.AddWithValue("@usuario", usuario);
                cmd.Parameters.AddWithValue("@password", password);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entSucursal s = new entSucursal()
                    {
                        id_sucursal = dr["id_sucursal"].ToString(),
                        descripcion = dr["sucursal"].ToString()
                    };
                    entTipo_Personal tp = new entTipo_Personal()
                    {
                        id_tipo_personal = dr["id_tipo_personal"].ToString(),
                        descripcion = dr["tipo_personal"].ToString()
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
                        telefono = dr["phono"].ToString(),
                        celular = dr["cel"].ToString(),
                        estado = Convert.ToInt16(dr["estado_personal"]),
                        sueldo_total = Convert.ToDecimal(dr["sueldo_total"]),
                        sucursal = s,
                        tipo_personal = tp,
                        imagen = dr["imagen"].ToString()
                    };

                    entUsuario usu = new entUsuario()
                    {
                        id_usuario = dr["id_usuario"].ToString(),
                        usuario = dr["usuario"].ToString(),
                        password = dr["password"].ToString(),
                        personal = p,
                        estado = Convert.ToInt16(dr["estado_usuario"]),
                    };
                    objUsuario = usu;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                cmd.Connection.Close();
            }
            return objUsuario;
        }

        //public List<entUsuario> ListarUsuario(Int32 id_usuario, String usuario, String password)
        //{
        //    SqlCommand cmd = null;
        //    SqlDataReader dr = null;
        //    List<entUsuario> Lista = new List<entUsuario>();
        //    try
        //    {
        //        cmd = MetodoDatos.CrearComando("Seguridad.spListar_Usuario");
        //        cmd.Parameters.AddWithValue("@id_usuario", id_usuario);
        //        cmd.Parameters.AddWithValue("@usuario", usuario);
        //        cmd.Parameters.AddWithValue("@password", password);
        //        dr = cmd.ExecuteReader();
        //        while (dr.Read())
        //        {
        //            entSucursal s = new entSucursal()
        //            {
        //                id_sucursal = dr["id_sucursal"].ToString(),
        //                descripcion = dr["sucursal"].ToString()
        //            };
        //            entPersonal p = new entPersonal()
        //            {
        //                id_personal = dr["id_personal"].ToString(),
        //                nombres = dr["nombres"].ToString(),
        //                apellidos = dr["apellidos"].ToString(),
        //                dni = Convert.ToInt32(dr["dni"]),
        //                fecha_nac = dr["fecha_nac"].ToString(),
        //                sexo = dr["sexo"].ToString(),
        //                direccion = dr["direccion"].ToString(),
        //                correo = dr["correo"].ToString(),
        //                telefono = dr["phono"].ToString(),
        //                celular = dr["cel"].ToString(),
        //                estado = Convert.ToInt16(dr["estado"]),
        //                sueldo_total = Convert.ToDecimal(dr["sueldo_total"]),
        //                sueldo_hora = Convert.ToDecimal(dr["sueldo_hora"]),
        //                sucursal = s
        //            };

        //            entUsuario usu = new entUsuario()
        //            {
        //                id_usuario = dr["id_usuario"].ToString(),
        //                usuario = dr["usuario"].ToString(),
        //                password = dr["password"].ToString(),
        //                personal = p,
        //                estado = Convert.ToInt16(dr["estado"]),
        //            };
        //            Lista.Add(usu);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    finally
        //    {
        //        cmd.Connection.Close();
        //    }
        //    return Lista;
        //}

    }
}
