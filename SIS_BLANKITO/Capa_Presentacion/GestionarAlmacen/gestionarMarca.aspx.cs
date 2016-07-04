using Datos.Comunes;
using Entidad.Almacen;
using Negocio.Almacen;
using Negocio.Comunes;
using SIS_BLANKITO.control;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capa_Presentacion.GestionarAlmacen
{
    public partial class gestionarMarca : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static object Listar_Marca()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entMarca> lstM = negMarca.Instancia.ListarMarca(ref verificar, 0);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entMarca item in lstM)
                {
                    item.id_marca = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_marca));
                }

                return new { Resultado = "Ok", m = sr.Serialize(lstM) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Marca(entMarca m)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                m.id_marca = m.id_marca == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(m.id_marca).Replace(" ", "+"));

                int resultado = negMarca.Instancia.GuardarMarca(ref verificar, m);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "La Marca se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "La Marca ya se encuentra registrado." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };

            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Eliminar_Marca(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "Almacen.Marca", "2", "id_marca", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "La Marca se eliminó satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}