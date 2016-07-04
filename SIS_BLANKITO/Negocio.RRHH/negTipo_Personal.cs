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
    public class negTipo_Personal
    {

        private static readonly negTipo_Personal _instancia = new negTipo_Personal();
        public static negTipo_Personal Instancia
        {
            get { return negTipo_Personal._instancia; }
        }

        public List<entTipo_Personal> ListarTipoPersonal(ref VerificarError verificar, Int32 id_tipo_personal){
            return datTipo_Personal.Instancia.ListarTipoPersonal(ref verificar, id_tipo_personal);
        }

         public int GuardarTipoPersonal(ref VerificarError verificar, entTipo_Personal tp){
             return datTipo_Personal.Instancia.GuardarTipoPersonal(ref verificar,tp);
         }
    }
}
