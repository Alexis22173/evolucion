using Datos.Comunes;
using Datos.Ventas;
using Entidad.Comunes;
using Entidad.Ventas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Ventas
{
    public class negPedido
    {
        private static readonly negPedido _instancia = new negPedido();
        public static negPedido Instancia
        {
            get { return negPedido._instancia; }
        }

        public List<entPedido> ListarPedidosDiarios(ref VerificarError verificar, Int32 id_sucursal)
        {
            return datPedido.Instancia.ListarPedidosDiarios(ref verificar, id_sucursal);
        }

        public List<entDetalle_Pedido> ListarDetallePedido(ref VerificarError verificar, Int32 id_pedido)
        {
            return datPedido.Instancia.ListarDetallePedido(ref verificar, id_pedido);
        }

        public List<entDetalle_Pedido> ListarPedidoSeleccionado(ref VerificarError verificar, Int32 id_pedido)
        {
            return datPedido.Instancia.ListarPedidoSeleccionado(ref verificar, id_pedido);
        }

        public bool GuardarPedido(ref VerificarError verificar, entPedido p, LstDetallePedido lst)
        {
            return datPedido.Instancia.GuardarPedido(ref verificar, p, lst);
        }

        public List<entPedido> ListarPedidosProduccion(ref VerificarError verificar, Int32 id_sucursal)
        {
            return datPedido.Instancia.ListarPedidosProduccion(ref verificar, id_sucursal);
        }
    }
}
