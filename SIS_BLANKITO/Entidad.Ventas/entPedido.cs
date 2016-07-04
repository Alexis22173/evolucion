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
    public class entPedido
    {
        public String id_pedido { get; set; }
        public String fecha { get; set; }
        public String numero { get; set; }
        public Decimal sub_total { get; set; }
        public Decimal igv { get; set; }
        public Decimal total { get; set; }
        public String estado { get; set; }
        public entCliente cliente { get; set; }
        public entTipo_Documento tipo_documento { get; set; }
        public entUsuario usuario { get; set; }
        public entSucursal sucursal { get; set; }
        public String observacion { get; set; }
        public Int16 produccion { get; set; }

        public entPedido()
        {
            cliente = new entCliente();
            tipo_documento = new entTipo_Documento();
            usuario = new entUsuario();
            sucursal = new entSucursal();
        }
    }

}
