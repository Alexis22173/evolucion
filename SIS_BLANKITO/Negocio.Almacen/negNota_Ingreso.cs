using Datos.Almacen;
using Datos.Comunes;
using Entidad.Almacen;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Almacen
{
    public class negNota_Ingreso
    {
        private static readonly negNota_Ingreso _instancia = new negNota_Ingreso();
        public static negNota_Ingreso Instancia
        {
            get { return negNota_Ingreso._instancia; }
        }

        public bool GuardarNotaIngreso(ref VerificarError verificar, entNota_Ingreso ni, LstDetalleNota lst)
        {
            return datNota_Ingreso.Instancia.GuardarNotaIngreso(ref verificar, ni, lst);
        }

        public DataTable ListarOrdenes(ref VerificarError verificar, String tipo)
        {
            return datNota_Ingreso.Instancia.ListarOrdenes(ref verificar, tipo);
        }

        public List<entDetalle_Nota_Ingreso> ListarDetalleNotaIngreso(ref VerificarError verificar, Int32 id_nota, String tipo)
        {
            return datNota_Ingreso.Instancia.ListarDetalleNotaIngreso(ref verificar, id_nota, tipo);
        }
    }
}
