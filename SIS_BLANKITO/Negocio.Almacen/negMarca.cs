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
    public class negMarca
    {
        private static readonly negMarca _instancia = new negMarca();
        public static negMarca Instancia
        {
            get { return negMarca._instancia; }
        }

        public List<entMarca> ListarMarca(ref VerificarError verificar, Int32 id_marca)
        {
            return datMarca.Instancia.ListarMarca(ref verificar, id_marca);
        }

        public int GuardarMarca(ref VerificarError verificar, entMarca m)
        {
            return datMarca.Instancia.GuardarMarca(ref verificar, m);
        }
    }
}
