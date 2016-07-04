using Datos.Comunes;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Comunes
{
    public class negMotivo
    {
        private static readonly negMotivo _instancia = new negMotivo();
        public static negMotivo Instancia
        {
            get { return negMotivo._instancia; }
        }

        public List<entMotivo> ListarMotivo(ref VerificarError verificar, Int32 id_motivo, String tipo)
        {
            return datMotivo.Instancia.ListarMotivo(ref verificar, id_motivo, tipo);
        }
    }
}
