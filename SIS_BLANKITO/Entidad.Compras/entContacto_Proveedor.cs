using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidad.Seguridad;

namespace Entidad.Compras
{
    public class entContacto_Proveedor
    {
        public String id_contacto_proveedor { get; set; }
        public String nombres { get; set; }
        public String apellidos { get; set; }
        public String dni { get; set; }
        public String correo { get; set; }
        public String telefono { get; set; }
        public String celular { get; set; }
        public Int16 estado { get; set; }
        public entUsuario usuario { get; set; }
        public entProveedor proveedor { get; set; }
        public entContacto_Proveedor()
        {
            proveedor = new entProveedor();
            usuario = new entUsuario();
        }
       
    }
}
