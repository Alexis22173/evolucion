using Datos.Comunes;
using Datos.Compras;
using Entidad.Comunes;
using Entidad.Ventas;
using Entidad.Compras;
using Negocio.Comunes;
using Negocio.Compras;
using Negocio.Ventas;
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
    public partial class gestionarProveedor : System.Web.UI.Page
    {
        private static List<entProveedor> lstProveedor;
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
            lstProveedor = negProveedor.Instancia.ListarProveedor(ref verificarLoad, 0, "");
        }

        public static void RecargarDatos()
        {
            verificarLoad = new VerificarError();
            lstProveedor = new List<entProveedor>();
            lstProveedor = negProveedor.Instancia.ListarProveedor(ref verificarLoad, 0, "");
        }

        [WebMethod]
        public static object Listar_Proveedor(int edito)
        {
            try
            {
                if (edito == 1) { RecargarDatos(); }
                if (verificarLoad.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificarLoad.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entProveedor item in lstProveedor)
                {
                    item.id_proveedor = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_proveedor));                    
                }

                return new { Resultado = "Ok", proveedor = sr.Serialize(lstProveedor) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Proveedor(entProveedor proveedor)
        {
            try
            {
                VerificarError verificar = new VerificarError();

                proveedor.id_proveedor = proveedor.id_proveedor == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(proveedor.id_proveedor).Replace(" ", "+"));
                proveedor.objUsuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;
                proveedor.estado = 1;               

                //Int32 id_sucursal = clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal;
                int resultado = negProveedor.Instancia.GuardarProveedor(ref verificar, proveedor);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "El proveedor se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "El número de documento ya se encuentra registrado." };
                else if (resultado == -3) return new { Resultado = "Check", Mensaje = "La razon social ya se encuentra registrada." };
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
                        tabla = "Proveedor",
                        id_tabla = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.Id).Replace(" ", "+"))),
                        estado = 2
                    });
                }

                //bool resultado = negEliminar.Instancia.EliminarDatosTT(ref verificar, "Ventas.Cliente", "2", "id_cliente", lstEliminar);
                bool resultado = negEliminar.Instancia.EliminarDatosTT(ref verificar, "Proveedor", lstEliminar);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "Los datos se eliminaron correctamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado al eliminar " + (lstEliminar.Count == 1 ? "al proveedor." : "a los proveedores.") };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }        
    }
}