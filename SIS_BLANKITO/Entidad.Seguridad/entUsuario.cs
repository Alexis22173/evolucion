using Entidad.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Seguridad
{
    public class entUsuario
    {
        public String id_usuario { get; set; }
        public String usuario { get; set; }
        public String password { get; set; }
        public Int16 estado { get; set; }
        public entPersonal personal { get; set; }
    }
}
