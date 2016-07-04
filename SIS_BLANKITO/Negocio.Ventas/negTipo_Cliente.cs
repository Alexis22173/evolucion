using Datos.Comunes;
using Datos.Ventas;
using Entidad.Ventas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Ventas
{
    public class negTipo_Cliente
    {
        private static readonly negTipo_Cliente _instancia = new negTipo_Cliente();
        public static negTipo_Cliente Instancia
        {
            get { return negTipo_Cliente._instancia; }
        }

        public List<entTipo_Cliente> ListarTipoCliente(ref VerificarError verificar, Int32 id_tipo_cliente)
        {
            return datTipo_Cliente.Instancia.ListarTipoCliente(ref verificar, id_tipo_cliente);
        }

        public int GuardarTipoCliente(ref VerificarError verificar, entTipo_Cliente tc)
        {
            return datTipo_Cliente.Instancia.GuardarTipoCliente(ref verificar, tc);
        }
    }
}
