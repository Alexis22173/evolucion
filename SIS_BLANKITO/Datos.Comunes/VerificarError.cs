using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Comunes
{
    [Serializable]
    public class VerificarError
    {
        public List<ListaError> Error { get; set; }
        public VerificarError()
        {
            this.Error = new List<ListaError>();
        }

        [Serializable]
        public class ListaError
        {
            public Exception Error { get; set; }
            public String MensajeCliente { get; set; }

            public ListaError(Exception error, String mensaje)
            {
                this.Error = error;
                this.MensajeCliente = mensaje;
            }

        }
    }
}
