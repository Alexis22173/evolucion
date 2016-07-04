using Datos.Comunes;
using Entidad.Compras;
using Entidad.Comunes;
using Negocio.Compras;
using Negocio.Comunes;
using SIS_BLANKITO;
using SIS_BLANKITO.control;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capa_Presentacion.GestionarCompra
{
    public partial class gestionarContactoProveedor : System.Web.UI.Page
    {
        private static List<entContacto_Proveedor> lstCP;
        private static VerificarError verificarLoad;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDatos();
            }
        }
        public void CargarDatos()
        {
            verificarLoad = new VerificarError();
            lstCP = negContacto_Proveedor.Instancia.ListarContactoProveedor(ref verificarLoad, 0, "", 0);
        }

        public static void RecargarDatos(String id_proveedor)
        {
            verificarLoad = new VerificarError();
            lstCP = new List<entContacto_Proveedor>();

            id_proveedor = id_proveedor == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(id_proveedor).Replace(" ", "+"));
            lstCP = negContacto_Proveedor.Instancia.ListarContactoProveedor(ref verificarLoad, 0, "", Convert.ToInt32(id_proveedor));
        }

        [WebMethod]
        public static object Listar_ContactosProveedor(int edito, String id_proveedor)
        {
            try
            {
                if (edito == 1) { RecargarDatos(id_proveedor); }
                if (verificarLoad.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificarLoad.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entContacto_Proveedor item in lstCP)
                {
                    item.id_contacto_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_contacto_proveedor));
                    item.proveedor.id_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.proveedor.id_proveedor));
                }

                return new { Resultado = "Ok", cp = sr.Serialize(lstCP) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_ContactoProveedor(entContacto_Proveedor cp)
        {
            try
            {
                VerificarError verificar = new VerificarError();

                cp.id_contacto_proveedor = cp.id_contacto_proveedor == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(cp.id_contacto_proveedor).Replace(" ", "+"));
                cp.proveedor.id_proveedor = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(cp.proveedor.id_proveedor).Replace(" ", "+"));
                cp.usuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;
                cp.estado = 1;

                //Int32 id_sucursal = clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal;
                int resultado = negContacto_Proveedor.Instancia.GuardarContactoProveedor(ref verificar, cp);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "El contacto se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "El número de documento ya se encuentra registrado." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Eliminar_Datos(String jsondata)
        {
            try
            {
                VerificarError verificar = new VerificarError();
                JavaScriptSerializer sr = new JavaScriptSerializer();

                List<srBase> lstDes = sr.Deserialize<List<srBase>>(jsondata);
                LstEliminar lstEliminar = new LstEliminar();
                foreach (srBase item in lstDes)
                {
                    lstEliminar.Add(new srEliminar
                    {
                        tabla = "ContactoProveedor",
                        id_tabla = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.Id).Replace(" ", "+"))),
                        estado = 2
                    });
                }

                //bool resultado = negEliminar.Instancia.EliminarDatosTT(ref verificar, "Ventas.Cliente", "2", "id_cliente", lstEliminar);
                bool resultado = negEliminar.Instancia.EliminarDatosTT(ref verificar, "ContactoProveedor", lstEliminar);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "Los datos se eliminaron correctamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado al eliminar " + (lstEliminar.Count == 1 ? "al contacto." : "a los contactos.") };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}