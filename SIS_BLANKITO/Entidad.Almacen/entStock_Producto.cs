using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Almacen
{
    public class entStock_Producto
    {
        public entSucursal sucursal { get; set; }
        public entProducto producto { get; set; }
        public Decimal stock { get; set; }
        public Decimal cpm { get; set; }
        public Int16 estado { get; set; }
    }
}
