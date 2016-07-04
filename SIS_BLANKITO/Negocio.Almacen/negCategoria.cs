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
    public class negCategoria
    {
        private static readonly negCategoria _instancia = new negCategoria();
        public static negCategoria Instancia
        {
            get { return negCategoria._instancia; }
        }

        public List<entCategoria> ListarCategoria(ref VerificarError verificar, Int32 id_categoria)
        {
            return datCategoria.Instancia.ListarCategoria(ref verificar, id_categoria);
        }

        public int GuardarCategoria(ref VerificarError verificar, entCategoria c)
        {
            return datCategoria.Instancia.GuardarCategoria(ref verificar, c);
        }

    }
}
