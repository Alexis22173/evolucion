using Datos.Comunes;
using Entidad.Almacen;
using Entidad.Comunes;
using Negocio.Almacen;
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

namespace Capa_Presentacion.GestionarAlmacen
{
    public partial class gestionarProducto : System.Web.UI.Page
    {
        private static List<entProducto> lstProducto;
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
            lstProducto = negProducto.Instancia.ListarProducto(ref verificarLoad, 0);
        }

        public static void RecargarDatos()
        {
            verificarLoad = new VerificarError();
            lstProducto = new List<entProducto>();
            lstProducto = negProducto.Instancia.ListarProducto(ref verificarLoad, 0);
        }

        [WebMethod]
        public static object Listar_Productos(int edito)
        {
            try
            {
                if (edito == 1) { RecargarDatos(); }
                if (verificarLoad.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificarLoad.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entProducto item in lstProducto)
                {
                    item.id_producto = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_producto));
                    item.categoria.id_categoria = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.categoria.id_categoria));
                    item.marca.id_marca = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.marca.id_marca));
                }

                return new { Resultado = "Ok", productos = sr.Serialize(lstProducto) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Producto(entProducto producto)
        {
            try
            {
                VerificarError verificar = new VerificarError();

                producto.id_producto = producto.id_producto == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(producto.id_producto).Replace(" ", "+"));
                producto.categoria.id_categoria = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(producto.categoria.id_categoria).Replace(" ", "+"));
                producto.marca.id_marca = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(producto.marca.id_marca).Replace(" ", "+"));
                producto.usuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;
                
                int resultado = negProducto.Instancia.GuardarProducto(ref verificar, producto);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "El producto se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "El nombre del producto ya se encuentra registrado." };
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
                        tabla = "Producto",
                        id_tabla = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.Id).Replace(" ", "+"))),
                        estado = 2
                    });
                }

                //bool resultado = negEliminar.Instancia.EliminarDatosTT(ref verificar, "Almacen.Producto", "2", "id_producto", lstEliminar);
                bool resultado = negEliminar.Instancia.EliminarDatosTT(ref verificar, "Producto", lstEliminar);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == true) return new { Resultado = "Ok", Mensaje = "Los datos se eliminaron correctamente." };
                else return new { Resultado = "NoOk", Mensaje = "Error inesperado al eliminar " + (lstEliminar.Count == 1 ? "al cliente." : "a los clientes.") };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }
    }
}