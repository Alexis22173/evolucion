using Datos.Compras;
using Datos.Comunes;
using Entidad.Compras;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Compras
{
    public class negComprobante_Compra
    {
        private static readonly negComprobante_Compra _instancia = new negComprobante_Compra();
        public static negComprobante_Compra Instancia
        {
            get { return negComprobante_Compra._instancia; }
        }

        public DataTable ListarNotasIngreso(ref VerificarError verificar, String tipo)
        {
            return datComprobante_Compra.Instancia.ListarNotasIngreso(ref verificar, tipo);
        }

        public bool GuardarCompra(ref VerificarError verificar, entComprobante_Compra c, LstDetalleCompra lst)
        {
            return datComprobante_Compra.Instancia.GuardarCompra(ref verificar, c, lst);
        }
    }
}
