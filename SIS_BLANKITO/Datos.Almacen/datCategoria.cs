using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Almacen;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Almacen
{
    public class datCategoria
    {
        private static readonly datCategoria _instancia = new datCategoria();
        public static datCategoria Instancia
        {
            get { return datCategoria._instancia; }
        }

        public List<entCategoria> ListarCategoria(ref VerificarError verificar, Int32 id_categoria)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entCategoria> Lista = new List<entCategoria>();
            try
            {
                cmd = MetodoDatos.CrearComando("Almacen.spListar_Categoria");
                cmd.Parameters.AddWithValue("@id_categoria", id_categoria);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entCategoria c = new entCategoria()
                    {
                        id_categoria = dr["id_categoria"].ToString(),
                        descripcion = dr["descripcion"].ToString(),
                        estado = Convert.ToInt16(dr["estado"])
                    };
                    Lista.Add(c);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los datos del tipo de cliente."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public int GuardarCategoria(ref VerificarError verificar, entCategoria c)
        {
            SqlCommand cmd = null;
            int valor = 0;
            try
            {
                cmd = MetodoDatos.CrearComando("Almacen.spGuardar_Categoria");
                cmd.Parameters.AddWithValue("@id_categoria", c.id_categoria);
                cmd.Parameters.AddWithValue("@descripcion", c.descripcion);
                cmd.Parameters.AddWithValue("@estado", c.estado);

                SqlParameter returnParameter = cmd.Parameters.Add("@VALOR", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                cmd.ExecuteNonQuery();
                valor = (int)returnParameter.Value;
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar la categoria."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }

    }
}
