using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Almacen
{
    public class entDetalle_Nota_Ingreso
    {
        public entNota_Ingreso nota_ingreso { get; set; }
        public entProducto producto { get; set; }
        public Decimal cantidad { get; set; }
        public String descripcion { get; set; }

        public entDetalle_Nota_Ingreso()
        {
            nota_ingreso = new entNota_Ingreso();
            producto = new entProducto();
        }
    }
}
