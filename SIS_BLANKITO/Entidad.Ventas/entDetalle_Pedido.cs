using Entidad.Almacen;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Ventas
{
    public class entDetalle_Pedido
    {
        public entPedido pedido { get; set; }
        public entProducto producto { get; set; }
        public Decimal cantidad { get; set; }
        public String descripcion { get; set; }
        public Decimal precio { get; set; }
        public Decimal importe { get; set; }

        public entDetalle_Pedido()
        {
            pedido = new entPedido();
            producto = new entProducto();
        }
    }
}
