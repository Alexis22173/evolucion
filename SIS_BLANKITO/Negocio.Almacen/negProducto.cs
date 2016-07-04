using Datos.Almacen;
using Datos.Comunes;
using Entidad.Almacen;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Almacen
{
    public class negProducto
    {
        private static readonly negProducto _instancia = new negProducto();
        public static negProducto Instancia
        {
            get { return negProducto._instancia; }
        }

        public List<entProducto> ListarProducto(ref VerificarError verificar, Int32 id_producto)
        {
            return datProducto.Instancia.ListarProducto(ref verificar, id_producto);
        }

        public int GuardarProducto(ref VerificarError verificar, entProducto p)
        {
            return datProducto.Instancia.GuardarProducto(ref verificar, p);
        }

        public List<entStock_Producto> ListarStockProducto(ref VerificarError verificar, Int32 id_producto, Int32 id_sucursal)
        {
            return datProducto.Instancia.ListarStockProducto(ref verificar, id_producto, id_sucursal);
        }
    }
}
