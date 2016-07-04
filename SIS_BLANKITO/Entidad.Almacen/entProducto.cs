using Entidad.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Almacen
{
    public class entProducto
    {
        public String id_producto { get; set; }
        public String descripcion { get; set; }
        public String unidad_med { get; set; }
        public Decimal precio_min { get; set; }
        public Decimal precio_max { get; set; }
        public entMarca marca { get; set; }
        public entCategoria categoria { get; set; }
        public Int16 estado { get; set; }
        public entUsuario usuario { get; set; }

        public entProducto()
        {
            marca = new entMarca();
            categoria = new entCategoria();
            usuario = new entUsuario();
        }
    }
}
