using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Comunes
{
    public class entNumero_Documento
    {
        public String id_numeros { get; set; }
        public String serie_inicio { get; set; }
        public String numero_inicio { get; set; }
        public String serie_fin { get; set; }
        public String numero_fin { get; set; }
        public entTipo_Documento tipo_documento { get; set; }
        public entSucursal sucursal { get; set; }

        public entNumero_Documento()
        {
            tipo_documento = new entTipo_Documento();
            sucursal = new entSucursal();
        }
    }
}
