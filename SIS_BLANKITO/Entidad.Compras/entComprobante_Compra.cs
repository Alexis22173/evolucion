using Entidad.Comunes;
using Entidad.Logistica;
using Entidad.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Compras
{
    public class entComprobante_Compra
    {
        public String id_compra { get; set; }
        public String serie { get; set; }
        public String numero { get; set; }
        public String fecha { get; set; }
        public Decimal sub_total { get; set; }
        public Decimal igv { get; set; }
        public Decimal total { get; set; }
        public String estado { get; set; }
        public entProveedor proveedor { get; set; }
        public entContacto_Proveedor contacto_proveedor { get; set; }
        public entTipo_Documento tipo_documento { get; set; }
        public entUsuario usuario { get; set; }
        public entSucursal sucursal { get; set; }
        public entTipo_Pago tipo_pago { get; set; } 
        public entMoneda moneda { get; set; }
        public String observacion { get; set; }

        public entComprobante_Compra()
        {
            proveedor = new entProveedor();
            contacto_proveedor = new entContacto_Proveedor();
            tipo_documento = new entTipo_Documento();            
            usuario = new entUsuario();
            sucursal = new entSucursal();
            tipo_pago = new entTipo_Pago();
            moneda = new entMoneda();
        }
    }
}
