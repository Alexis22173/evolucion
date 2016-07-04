using Datos.Comunes;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Comunes
{
    public class negTipo_Pago
    {
        private static readonly negTipo_Pago _instancia = new negTipo_Pago();
        public static negTipo_Pago Instancia
        {
            get { return negTipo_Pago._instancia; }
        }

        public List<entTipo_Pago> ListarTipoPago(ref VerificarError verificar, Int32 id_tipo_pago)
        {
            return datTipo_Pago.Instancia.ListarTipoPago(ref verificar, id_tipo_pago);
        }

        public int GuardarTipoPago(ref VerificarError verificar, entTipo_Pago tp)
        {
            return datTipo_Pago.Instancia.GuardarTipoPago(ref verificar, tp);
        }

    }
}
