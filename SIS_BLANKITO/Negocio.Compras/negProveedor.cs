using Datos.Compras;
using Datos.Comunes;
using Entidad.Compras;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Compras
{
    public class negProveedor
    {
        private static readonly negProveedor _instancia = new negProveedor();
        public static negProveedor Instancia
        {
            get { return negProveedor._instancia; }
        }

        public List<entProveedor> ListarProveedor(ref VerificarError verificar, Int32 id_proveedor, String dni_ruc)
        {
            return datProveedor.Instancia.ListarProveedor(ref verificar, id_proveedor, dni_ruc);
        }

        public int GuardarProveedor(ref VerificarError verificar, entProveedor p)
        {
            return datProveedor.Instancia.GuardarProveedor(ref verificar, p);
        }
    }
}
