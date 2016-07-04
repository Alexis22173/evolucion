using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.RRHH
{
    public class entPersonal
    {
        public String id_personal { get; set; }
        public String nombres { get; set; }
        public String apellido_paterno { get; set; }
        public String apellido_materno { get; set; }
        public Int32 dni { get; set; }
        public String fecha_nac { get; set; }
        public String sexo { get; set; }
        public String direccion { get; set; }
        public String correo { get; set; }
        public String telefono { get; set; }
        public String celular { get; set; }
        public Int16 estado { get; set; }
        public entSucursal sucursal { get; set; }
        public entTipo_Personal tipo_personal { get; set; }
        public Decimal sueldo_total { get; set; }
        public Decimal sueldo_hora { get; set; }
        public String imagen { get; set; }
    }
}
