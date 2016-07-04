using Datos.Comunes;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Comunes
{
    public class negEliminar
    {
        private static readonly negEliminar _instancia = new negEliminar();
        public static negEliminar Instancia
        {
            get { return negEliminar._instancia; }
        }

        public bool EliminarDatosTT(ref VerificarError verificar, String tabla, LstEliminar lst)
        {
            return datEliminar.Instancia.EliminarDatosTT(ref verificar, tabla, lst);
            //return datEliminar.Instancia.EliminarDatosTT(ref verificar, tabla, estado, campo, lst);            
        }

        public bool EliminarDatos(ref VerificarError verificar, String tabla, String estado, String campo, Int32 id_tabla)
        {
            return datEliminar.Instancia.EliminarDatos(ref verificar, tabla, estado, campo, id_tabla);
        }
    }
}
