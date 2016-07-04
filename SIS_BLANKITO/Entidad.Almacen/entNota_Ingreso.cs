using Entidad.Comunes;
using Entidad.Seguridad;
using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Almacen
{
    public class entNota_Ingreso
    {
        public String id_nota_ingreso { get; set; }
        public String fecha { get; set; }
        public entMotivo motivo { get; set; }
        public String id_orden_compra { get; set; }
        public String id_orden_produccion { get; set; }
        public entUsuario usuario { get; set; }
        public entSucursal sucursal { get; set; }
        public String observacion { get; set; }

        public entNota_Ingreso()
        {
            motivo = new entMotivo();
            usuario = new entUsuario();
            sucursal = new entSucursal();
        }
    }
}
