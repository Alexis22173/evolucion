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
    public partial class gestionarCategoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static object Listar_Categoria()
        {
            try
            {
                VerificarError verificar = new VerificarError();
                List<entCategoria> lstC = negCategoria.Instancia.ListarCategoria(ref verificar, 0);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entCategoria item in lstC)
                {
                    item.id_categoria = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_categoria));
                }

                return new { Resultado = "Ok", c = sr.Serialize(lstC) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Categoria(entCategoria c)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                c.id_categoria = c.id_categoria == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(c.id_categoria).Replace(" ", "+"));

                int resultado = negCategoria.Instancia.GuardarCategoria(ref verificar, c);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "La Categoria se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "La Categoria ya se encuentra registrado." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };

            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Eliminar_Categoria(String id)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                Int32 nuevoId = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id).Replace(" ", "+")));
                Boolean exito = negEliminar.Instancia.EliminarDatos(ref verificar, "Almacen.Categoria", "2", "id_categoria", nuevoId);

                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };
                return new { Resultado = "Ok", Mensaje = "La Categoria se eliminó satisfactoriamente." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}