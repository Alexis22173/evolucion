using Datos.Comunes;
using Datos.Logistica;
using Entidad.Logistica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Logistica
{
    public class negSucursal
    {
        private static readonly negSucursal _instancia = new negSucursal();
        public static negSucursal Instancia
        {
            get { return negSucursal._instancia; }
        }

        public List<entSucursal> ListarSucursal(ref VerificarError verificar, Int32 id_sucursal){
            return datSucursal.Instancia.ListarSucursal(ref verificar, id_sucursal);
        }

        public int GuardarSucursal(ref VerificarError verificar, entSucursal s)
        {
            return datSucursal.Instancia.GuardarSucursal(ref verificar,s);
        }
    }
}
