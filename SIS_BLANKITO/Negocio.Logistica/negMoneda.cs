using Datos.Comunes;
using Datos.Logistica;
using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Logistica
{
    public class negMoneda
    {
        private static readonly negMoneda _instancia = new negMoneda();
        public static negMoneda Instancia
        {
            get { return negMoneda._instancia; }
        }


        public List<entMoneda> ListarMoneda(ref VerificarError verificar, Int32 id_moneda) {
            return datMoneda.Instancia.ListarMoneda(ref verificar,id_moneda);
        }

        public int GuardarMoneda(ref VerificarError verificar, entMoneda m) {
            return datMoneda.Instancia.GuardarMoneda(ref verificar, m);
        }
    }
}
