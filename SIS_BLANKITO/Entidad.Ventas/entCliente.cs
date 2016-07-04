using Entidad.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Ventas
{
    public class entCliente
    {
        public String id_cliente { get; set; }
        public String nombres { get; set; }
        public String apellidos { get; set; }
        public String dni_ruc { get; set; }
        public String sexo { get; set; }
        public String direccion { get; set; }
        public String correo { get; set; }
        public String telefono { get; set; }
        public String celular { get; set; }
        public Int16 estado { get; set; }
        public String usuario { get; set; }
        public String password { get; set; }
        public entTipo_Cliente tipo_cliente { get; set; }
        public Decimal total { get; set; }// puesto sólo para mostrar su último precio de venta
        public Int16 registro_online { get; set; }
        public entUsuario objUsuario { get; set; }

        public entCliente()
        {
            tipo_cliente = new entTipo_Cliente();
            objUsuario = new entUsuario();
        }
    }
}
