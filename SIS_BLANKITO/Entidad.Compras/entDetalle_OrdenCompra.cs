using Entidad.Almacen;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Compras
{
    public class entDetalle_OrdenCompra
    {
        public entOrden_Compra orden_compra { get; set; }
        public entProducto producto { get; set; }
        public Decimal cantidad { get; set; }
        public String descripcion { get; set; }
        public Decimal precio { get; set; }
        public Decimal importe { get; set; }

        public entDetalle_OrdenCompra()
        {
            orden_compra = new entOrden_Compra();
            producto = new entProducto();
        }
    }
}
