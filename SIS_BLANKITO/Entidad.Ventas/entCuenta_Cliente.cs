using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Ventas
{
    public class entCuenta_Cliente
    {
        public String id_cuenta_cliente { get; set; }
        public Decimal monto { get; set; }
        public Decimal saldo { get; set; }
        public Decimal acuenta { get; set; }
        public String fecha { get; set; }
        public entCliente cliente { get; set; }
        public entComprobanteVenta venta { get; set; }
        public entSucursal sucursal { get; set; }
        public Boolean estado { get; set; }
        public Int16 valor { get; set; } //agregado para saber cuantas deudas tiene el cliente

        public entCuenta_Cliente()
        {
            cliente = new entCliente();
            venta = new entComprobanteVenta();
            sucursal = new entSucursal();
        }
    }
}
