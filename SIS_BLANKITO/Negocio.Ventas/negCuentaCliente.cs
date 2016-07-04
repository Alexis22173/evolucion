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
    public class negCuentaCliente
    {
        private static readonly negCuentaCliente _instancia = new negCuentaCliente();
        public static negCuentaCliente Instancia
        {
            get { return negCuentaCliente._instancia; }
        }

        public List<entCuenta_Cliente> ListarCuentas(ref VerificarError verificar)
        {
            return datCuentaCliente.Instancia.ListarCuentas(ref verificar);
        }

        public List<entCuenta_Cliente> ListarCuentasCliente(ref VerificarError verificar, Int32 id_cliente)
        {
            return datCuentaCliente.Instancia.ListarCuentasCliente(ref verificar, id_cliente);
        }

        public bool GuardarPagoDeuda(ref VerificarError verificar, Int32 id_cliente, Decimal pago)
        {
            return datCuentaCliente.Instancia.GuardarPagoDeuda(ref verificar, id_cliente, pago);
        }
    }
}
