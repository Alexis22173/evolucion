using Entidad.Seguridad;
using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Compras
{
    public class entOrden_Compra
    {
        public String id_orden_compra { get; set; }
        public String numero { get; set; }
        public String fecha { get; set; }
        public String fecha_vencimiento { get; set; }
        public Decimal sub_total { get; set; }
        public Decimal igv { get; set; }
        public Decimal total { get; set; }
        public String estado { get; set; }
        public entProveedor proveedor { get; set; }
        public entContacto_Proveedor contacto_proveedor { get; set; }
        public entMoneda moneda { get; set; }
        public entUsuario usuario { get; set; }
        public entSucursal sucursal { get; set; }
        public String observacion { get; set; }

        public entOrden_Compra()
        {
            proveedor = new entProveedor();
            contacto_proveedor = new entContacto_Proveedor();
            moneda = new entMoneda();
            usuario = new entUsuario();
            sucursal = new entSucursal();
        }
    }
}
