using Datos.Comunes;
using Datos.RRHH;
using Entidad.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.RRHH
{
    public class negPersonal
    {
        private static readonly negPersonal _instancia = new negPersonal();
        public static negPersonal Instancia
        {
            get { return negPersonal._instancia; }
        }

        public List<entPersonal> ListarPersonal(ref VerificarError verificar, Int32 id_personal, Int32 dni)
        {
            return datPersonal.Instancia.ListarPersonal(ref verificar, id_personal, dni);
        }
    }
}
