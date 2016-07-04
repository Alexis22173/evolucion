using Datos.Comunes;
using Datos.Seguridad;
using Entidad.Comunes;
using Entidad.Logistica;
using Entidad.Ventas;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos.Ventas
{
    public class datCuentaCliente
    {
        private static readonly datCuentaCliente _instancia = new datCuentaCliente();
        public static datCuentaCliente Instancia
        {
            get { return datCuentaCliente._instancia; }
        }

        public List<entCuenta_Cliente> ListarCuentas(ref VerificarError verificar)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entCuenta_Cliente> Lista = new List<entCuenta_Cliente>();
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spListar_Cuentas");
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entCliente c = new entCliente()
                    {
                        id_cliente = dr["id_cliente"].ToString(),
                        nombres = dr["nombres"].ToString(),
                    };

                    entSucursal s = new entSucursal() { descripcion = dr["sucural"].ToString() };

                    entCuenta_Cliente cc = new entCuenta_Cliente()
                    {                        
                        cliente = c,
                        sucursal = s,
                        valor = Convert.ToInt16(dr["num"]),
                    };
                    Lista.Add(cc);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar los clientes con deuda."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public List<entCuenta_Cliente> ListarCuentasCliente(ref VerificarError verificar, Int32 id_cliente)
        {
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<entCuenta_Cliente> Lista = new List<entCuenta_Cliente>();
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spListar_CuentasCliente");
                cmd.Parameters.AddWithValue("@id_cliente", id_cliente);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    entTipo_Documento td = new entTipo_Documento() { descripcion = dr["tipo_documento"].ToString() };
                    entNumero_Documento nd = new entNumero_Documento() { tipo_documento = td };

                    entCliente c = new entCliente()
                    {
                        id_cliente = dr["id_cliente"].ToString(),
                        nombres = dr["nombres"].ToString(),
                    };
                    
                    entPedido p = new entPedido(){ id_pedido =  dr["id_pedido"].ToString() };

                    entComprobanteVenta v = new entComprobanteVenta()
                    {
                        id_venta = dr["id_venta"].ToString(),
                        numero_documento = nd,
                        serie = dr["serie"].ToString(),
                        numero = dr["numero"].ToString(),
                        pedido = p
                    };
                    entCuenta_Cliente cc = new entCuenta_Cliente()
                    {
                        id_cuenta_cliente = dr["id_cuenta_cliente"].ToString(),
                        fecha = dr["fecha"].ToString(),
                        monto = Convert.ToDecimal(dr["monto"]),
                        saldo = Convert.ToDecimal(dr["saldo"]),
                        acuenta = Convert.ToDecimal(dr["acuenta"]),
                        cliente = c,
                        venta = v,
                    };
                    Lista.Add(cc);
                }
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al cargar las deudas del cliente."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return Lista;
        }

        public bool GuardarPagoDeuda(ref VerificarError verificar, Int32 id_cliente, Decimal pago)
        {
            SqlCommand cmd = null;
            bool valor = false; 
            try
            {
                cmd = MetodoDatos.CrearComando("Ventas.spActualizar_CuentaCliente");
                cmd.Parameters.AddWithValue("@id_cliente", id_cliente);
                cmd.Parameters.AddWithValue("@pago", pago);
                cmd.ExecuteNonQuery();
                valor = true; 
            }
            catch (Exception ex)
            {
                verificar.Error.Add(new VerificarError.ListaError(ex, "Error inesperado al guardar el pago de la deuda."));
            }
            finally
            {
                cmd.Connection.Close();
            }
            return valor;
        }
    }
}
