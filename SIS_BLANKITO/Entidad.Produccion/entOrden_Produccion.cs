using Entidad.Almacen;
using Entidad.Comunes;
using Entidad.Logistica;
using Entidad.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Produccion
{
    public class entOrden_Produccion
    {
        public String id_orden_produccion { get; set; }
        public String numero { get; set; }
        public String descripcion { get; set; }
        public String fecha { get; set; }
        public String fecha_entrega { get; set; }
        public entMotivo motivo { get; set; }
        public String id_pedido { get; set; }
        public entProducto producto { get; set; }
        public String descripcion_producto { get; set; }
        public Decimal cantidad { get; set; }
        public entUsuario usuario { get; set; }
        public entSucursal sucursal { get; set; }

        public entOrden_Produccion()
        {
            motivo = new entMotivo();
            producto = new entProducto();
            usuario = new entUsuario();
            sucursal = new entSucursal();
        }
    }
}
