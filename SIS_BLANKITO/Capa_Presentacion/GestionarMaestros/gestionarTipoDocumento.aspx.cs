using Datos.Comunes;
using Entidad.Comunes;
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

namespace Capa_Presentacion.GestionarMaestros
{
    public partial class gestionarTipoDocumento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }


        [WebMethod]
        public static object Listar_TipoDocumento()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entTipo_Documento> lstTD = negTipo_Documento.Instancia.ListarTipoDocumento(ref verificar, 0);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entTipo_Documento item in lstTD)
                {
                    item.id_tipo_documento = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_tipo_documento));
                }

                return new { Resultado = "Ok", td = sr.Serialize(lstTD) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_TipoDocumento(entTipo_Documento td)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                td.id_tipo_documento = td.id_tipo_documento == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(td.id_tipo_documento).Replace(" ", "+"));
                
                int resultado = negTipo_Documento.Instancia.GuardarTipoDocumento(ref verificar, td);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "El tipo de documento se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "El tipo de documento ya se encuentra registrado." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
                
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Eliminar_TipoDocumento(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "Comunes.Tipo_Documento", "2", "id_tipo_documento", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "El tipo de documento se eliminó satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}