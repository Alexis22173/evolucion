using Datos.Comunes;
using Datos.Produccion;
using Entidad.Comunes;
using Entidad.Produccion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Produccion
{
    public class negOrden_Produccion
    {
        private static readonly negOrden_Produccion _instancia = new negOrden_Produccion();
        public static negOrden_Produccion Instancia
        {
            get { return negOrden_Produccion._instancia; }
        }

        public bool GuardarOrdenProduccion(ref VerificarError verificar, entOrden_Produccion op, LstDetalleHorasTrabajadas lst)
        {
            return datOrden_Produccion.Instancia.GuardarOrdenProduccion(ref verificar, op, lst);
        }
    }
}
