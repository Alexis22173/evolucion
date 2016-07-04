using Entidad.Comunes;
using Entidad.Logistica;
using Entidad.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Ventas
{
    public class entComprobanteVenta
    {
        public String id_venta { get; set; }
        public String serie { get; set; }
        public String numero { get; set; }
        public String fecha { get; set; }
        public Int16 estado { get; set; }
        public entCliente cliente { get; set; }
        public entNumero_Documento numero_documento { get; set; }
        public entUsuario usuario { get; set; }
        public entSucursal sucursal { get; set; }
        public entTipo_Pago tipo_pago { get; set; }
        public entPedido pedido { get; set; }
        public Decimal total { get; set; }
        public String observacion { get; set; }
        
        public entComprobanteVenta()
        {
            cliente = new entCliente();
            numero_documento = new entNumero_Documento();
            usuario = new entUsuario();
            sucursal = new entSucursal();
            tipo_pago = new entTipo_Pago();
            pedido = new entPedido();
        }

    }
}
