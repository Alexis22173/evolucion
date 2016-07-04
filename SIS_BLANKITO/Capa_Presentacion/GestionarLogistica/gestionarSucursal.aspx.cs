using Datos.Comunes;
using Datos.Logistica;
using Entidad.Logistica;
using Entidad.Comunes;
using Negocio.Comunes;
using Negocio.Logistica;
using SIS_BLANKITO.control;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Capa_Presentacion.GestionarLogistica
{
    public partial class gestionarSucursal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static object Listar_Sucursal()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entSucursal> lstS = negSucursal.Instancia.ListarSucursal(ref verificar, 0);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entSucursal item in lstS)
                {
                    item.id_sucursal = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_sucursal));
                }

                return new { Resultado = "Ok", s = sr.Serialize(lstS) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Sucursal(entSucursal s)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                s.id_sucursal = s.id_sucursal == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(s.id_sucursal).Replace(" ", "+"));

                int resultado = negSucursal.Instancia.GuardarSucursal(ref verificar, s);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "La sucursal se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "La sucursal ya se encuentra registrado." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };

            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }


        [WebMethod]
        public static object Eliminar_Sucursal(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "Logistica.Sucursal", "2", "id_sucursal", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "La sucursal se eliminó satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}