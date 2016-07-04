using Datos.Comunes;
using Datos.Ventas;
using Entidad.Ventas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Ventas
{
    public class negVenta
    {
        private static readonly negVenta _instancia = new negVenta();
        public static negVenta Instancia
        {
            get { return negVenta._instancia; }
        }

        public bool GuardarVenta(ref VerificarError verificar, entComprobanteVenta v)
        {
            return datVenta.Instancia.GuardarVenta(ref verificar, v);
        }

        public List<entComprobanteVenta> ListarVentas(ref VerificarError verificar, Int32 id_venta, Int32 id_sucursal, Int32 id_tipo_documento, Int32 id_tipo_pago, String fecha_ini, String fecha_fin)
        {
            return datVenta.Instancia.ListarVentas(ref verificar, id_venta, id_sucursal, id_tipo_documento, id_tipo_pago, fecha_ini, fecha_fin);
        }
    }
}
