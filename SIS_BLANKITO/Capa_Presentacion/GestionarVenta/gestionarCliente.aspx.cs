using Datos.Comunes;
using Entidad.Comunes;
using Entidad.Ventas;
using Negocio.Comunes;
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

namespace Capa_Presentacion.GestionarVenta
{
    public partial class gestionarCliente : System.Web.UI.Page
    {
        private static List<entCliente> lstCliente;        
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
            lstCliente = negCliente.Instancia.ListarCliente(ref verificarLoad, 0, "");            
        }

        public static void RecargarDatos()
        {
            verificarLoad = new VerificarError();
            lstCliente = new List<entCliente>();
            lstCliente = negCliente.Instancia.ListarCliente(ref verificarLoad, 0, "");
        }

        [WebMethod]
        public static object Listar_Clientes(int edito)
        {
            try
            {                
                if (edito == 1) { RecargarDatos(); }
                if (verificarLoad.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificarLoad.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entCliente item in lstCliente)
                {
                    item.id_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_cliente));
                    item.tipo_cliente.id_tipo_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.tipo_cliente.id_tipo_cliente));
                }

                return new { Resultado = "Ok", clientes = sr.Serialize(lstCliente) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }            
        }

        [WebMethod]
        public static object Listar_TipoCliente()
        {
            try
            {                
                VerificarError verificar = new VerificarError();
                List<entTipo_Cliente> lstTC = negTipo_Cliente.Instancia.ListarTipoCliente(ref verificar, 0);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                JavaScriptSerializer sr = new JavaScriptSerializer();
                foreach (entTipo_Cliente item in lstTC)
                {
                    item.id_tipo_cliente = HttpUtility.UrlEncode(clsEncriptacion.Encriptar(item.id_tipo_cliente));
                }

                return new { Resultado = "Ok", tc = sr.Serialize(lstTC) };
            }
            catch (Exception ex)
            {
                return new { Resultado = "NoOk", Mensaje = "Error inesperado. Por favor, vuelta a intentarlo." };
            }
        }

        [WebMethod]
        public static object Guardar_Cliente(entCliente cliente)
        {
            try
            {
                VerificarError verificar = new VerificarError();

                cliente.id_cliente = cliente.id_cliente == "0" ? "0" : clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(cliente.id_cliente).Replace(" ", "+"));
                cliente.objUsuario.id_usuario = clsSesionBase.SesionUsuario.id_usuario;
                cliente.tipo_cliente.id_tipo_cliente = clsEncriptacion.Desencriptar(HttpUtility.UrlDecode(cliente.tipo_cliente.id_tipo_cliente).Replace(" ", "+"));
                cliente.apellidos = string.Empty;
                cliente.sexo = string.Empty;
                cliente.estado = 1;
                cliente.registro_online = 1;
                cliente.usuario = string.Empty;
                cliente.password = string.Empty;

                //Int32 id_sucursal = clsSesionBase.SesionUsuario.personal.sucursal.id_sucursal;
                int resultado = negCliente.Instancia.GuardarCliente(ref verificar, cliente);
                if (verificar.Error.Count > 0) return new { Resultado = "NoOk", Mensaje = verificar.Error[0].MensajeCliente };

                if (resultado == 1) return new { Resultado = "Ok", Mensaje = "El cliente se guardó correctamente." };
                else if (resultado == -2) return new { Resultado = "Check", Mensaje = "El número de documento ya se encuentra registrado." };
                else if (resultado == -3) return new { Resultado = "Check", Mensaje = "El nombre ya se encuentra registrado." };
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
                foreach (srBase item in lstDes) { 
                    lstEliminar.Add(new srEliminar { 
                        tabla = "Cliente",
                        id_tabla = Convert.ToInt32(clsEncriptacion.Desencriptar(HttpContext.Current.Server.UrlDecode(item.Id).Replace(" ", "+"))), 
                        estado = 2 });
                }

                //bool resultado = negEliminar.Instancia.EliminarDatosTT(ref verificar, "Ventas.Cliente", "2", "id_cliente", lstEliminar);
                bool resultado = negEliminar.Instancia.EliminarDatosTT(ref verificar, "Cliente", lstEliminar);
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