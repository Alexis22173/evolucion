using Datos.Comunes;
using Entidad.Comunes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Comunes
{
    public class negTipo_Documento
    {
        private static readonly negTipo_Documento _instancia = new negTipo_Documento();
        public static negTipo_Documento Instancia
        {
            get { return negTipo_Documento._instancia; }
        }

        public List<entTipo_Documento> ListarTipoDocumento(ref VerificarError verificar, Int32 id_tipo_documento)
        {
            return datTipo_Documento.Instancia.ListarTipoDocumento(ref verificar, id_tipo_documento);
        }

        public int GuardarTipoDocumento(ref VerificarError verificar, entTipo_Documento td)
        {
            return datTipo_Documento.Instancia.GuardarTipoDocumento(ref verificar, td);
        }
    }
}
