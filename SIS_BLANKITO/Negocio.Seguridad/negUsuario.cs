using Datos.Seguridad;
using Entidad.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Seguridad
{
    public class negUsuario
    {
        private static readonly negUsuario _instancia = new negUsuario();
        public static negUsuario Instancia
        {
            get { return negUsuario._instancia; }
        }

        //public List<entUsuario> ListarUsuario(Int32 id_usuario, String usuario, String password)
        //{
        //     return datUsuario.Instancia.ListarUsuario(id_usuario, usuario, password);
        //}

        public entUsuario LoginUsuario(String usuario, String password)
        {
            return datUsuario.Instancia.LoginUsuario(usuario, password);
        }

    }
}
