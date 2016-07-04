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
    public class negCliente
    {
        private static readonly negCliente _instancia = new negCliente();
        public static negCliente Instancia
        {
            get { return negCliente._instancia; }
        }

        public List<entCliente> ListarCliente(ref VerificarError verificar, Int32 id_cliente, String dni_ruc)
        {
            return datCliente.Instancia.ListarCliente(ref verificar, id_cliente, dni_ruc);
        }

        public int GuardarCliente(ref VerificarError verificar, entCliente c)
        {
            return datCliente.Instancia.GuardarCliente(ref verificar, c);
        }

    }
}
