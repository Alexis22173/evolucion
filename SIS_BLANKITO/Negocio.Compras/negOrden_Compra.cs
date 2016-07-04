using Datos.Compras;
using Datos.Comunes;
using Entidad.Compras;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Compras
{
    public class negOrden_Compra
    {
        private static readonly negOrden_Compra _instancia = new negOrden_Compra();
        public static negOrden_Compra Instancia
        {
            get { return negOrden_Compra._instancia; }
        }

        public List<entOrden_Compra> ListarOrdenesCompra(ref VerificarError verificar, Int32 id_sucursal, String fecha_inicio, String fecha_fin)
        {
            return datOrden_Compra.Instancia.ListarOrdenesCompra(ref verificar, id_sucursal, fecha_inicio, fecha_fin);
        }

        public bool GuardarOrden(ref VerificarError verificar, entOrden_Compra o, LstDetalleCompra lst)
        {
            return datOrden_Compra.Instancia.GuardarOrden(ref verificar, o, lst);
        }

        public List<entDetalle_OrdenCompra> ListarDetalleOrdeCompra(ref VerificarError verificar, Int32 id_orden_compra, String tipo)
        {
            return datOrden_Compra.Instancia.ListarDetalleOrdeCompra(ref verificar, id_orden_compra, tipo);
        }

        public List<entDetalle_OrdenCompra> ListarOrdenCompraSeleccionado(ref VerificarError verificar, Int32 id_orden_compra)
        {
            return datOrden_Compra.Instancia.ListarOrdenCompraSeleccionado(ref verificar, id_orden_compra);
        }
    }
}
