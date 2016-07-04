using Entidad.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Compras
{
    public class entProveedor
    {
        public String id_proveedor { get; set; }
        public String razon_social { get; set; }
        public String dni_ruc { get; set; }
        public String direccion { get; set; }
        public String correo { get; set; }
        public String telefono { get; set; }
        public String celular { get; set; }
        public Int16 estado { get; set; }
        public Decimal total { get; set; }// puesto sólo para mostrar su último precio de venta
        public entUsuario objUsuario { get; set; }

        public entProveedor()
        {
            objUsuario = new entUsuario();
        }
    }
}
