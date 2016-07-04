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
    public class negContacto_Proveedor
    {
        private static readonly negContacto_Proveedor _instancia = new negContacto_Proveedor();
        public static negContacto_Proveedor Instancia
        {
            get { return negContacto_Proveedor._instancia; }
        }

        public List<entContacto_Proveedor> ListarContactoProveedor(ref VerificarError verificar, Int32 id_contacto_proveedor, String dni, Int32 id_proveedor)
        {
            return datContacto_Proveedor.Instancia.ListarContactoProveedor(ref verificar, id_contacto_proveedor, dni, id_proveedor);
        }
        public int GuardarContactoProveedor(ref VerificarError verificar, entContacto_Proveedor cp)
        {
            return datContacto_Proveedor.Instancia.GuardarContactoProveedor(ref verificar, cp); 
        }
    }
}
