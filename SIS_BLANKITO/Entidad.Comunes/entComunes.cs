using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidad.Comunes
{

    [Serializable]
    public class srBase
    {
        public String Id { get; set; }
        public String Estado { get; set; }
    }

    //[Serializable]
    public class srEliminar
    {
        public String tabla { get; set; }
        public Int32 id_tabla { get; set; }
        public Int16 estado { get; set; }
    }

    //[Serializable]
    public class LstEliminar : List<srEliminar>, IEnumerable<SqlDataRecord>
    {
        IEnumerator<SqlDataRecord> IEnumerable<SqlDataRecord>.GetEnumerator()
        {
            SqlDataRecord ret = new SqlDataRecord(
                new SqlMetaData("tabla", SqlDbType.VarChar, 50),
                new SqlMetaData("id_tabla", SqlDbType.Int),
                new SqlMetaData("estado", SqlDbType.SmallInt)
                );
            foreach (srEliminar data in this)
            {
                ret.SetString(0, data.tabla);
                ret.SetInt32(1, data.id_tabla);
                ret.SetInt16(2, data.estado);
                yield return ret;
            }
        }
    }

    //******************************** DETALLE PEDIDO **********************************************
    [Serializable]
    public class srDetallePedido
    {
        public String id_pedido { get; set; }
        public String id_producto { get; set; }
        public Decimal cantidad { get; set; }
        public String descripcion { get; set; }
        public Decimal precio { get; set; }
        public Decimal importe { get; set; }
    }
      
    public class srDetalleP
    {
        public Int32 id_pedido { get; set; }
        public Int32 id_producto { get; set; }
        public Decimal cantidad { get; set; }
        public String descripcion { get; set; }
        public Decimal precio { get; set; }
        public Decimal importe { get; set; }
        public Int32 id_venta { get; set; }
    }

    public class LstDetallePedido : List<srDetalleP>, IEnumerable<SqlDataRecord>
    {
        IEnumerator<SqlDataRecord> IEnumerable<SqlDataRecord>.GetEnumerator()
        {
            SqlDataRecord ret = new SqlDataRecord(
                new SqlMetaData("id_pedido", SqlDbType.Int),
                new SqlMetaData("id_producto", SqlDbType.Int),                
                new SqlMetaData("descripcion", SqlDbType.VarChar,100),
                new SqlMetaData("cantidad", SqlDbType.Decimal, 18, 2),
                new SqlMetaData("precio", SqlDbType.Decimal, 18, 2),
                new SqlMetaData("importe", SqlDbType.Decimal, 18, 2),
                new SqlMetaData("id_venta", SqlDbType.Int)
                );

            foreach (srDetalleP data in this)
            {
                ret.SetInt32(0, data.id_pedido);
                ret.SetInt32(1, data.id_producto);
                ret.SetString(2, data.descripcion);
                ret.SetDecimal(3, data.cantidad);
                ret.SetDecimal(4, data.precio);
                ret.SetDecimal(5, data.importe);
                ret.SetInt32(6, data.id_venta);
                yield return ret;
            }
        }
    }

    //******************************** DETALLE ORDEN **********************************************
    [Serializable]
    public class srDetalleCompra
    {
        public String id_compra { get; set; }
        public String id_nota_ingreso { get; set; }
        public String id_producto { get; set; }
        public Decimal cantidad { get; set; }
        public String descripcion { get; set; }
        public Decimal precio { get; set; }
        public Decimal importe { get; set; }
    }

    [Serializable]
    public class srDetalleC
    {
        public Int32 id_compra { get; set; }
        public Int32 id_nota_ingreso { get; set; }
        public Int32 id_producto { get; set; }
        public Decimal cantidad { get; set; }
        public String descripcion { get; set; }
        public Decimal precio { get; set; }
        public Decimal importe { get; set; }
    }

    public class LstDetalleCompra : List<srDetalleC>, IEnumerable<SqlDataRecord>
    {
        IEnumerator<SqlDataRecord> IEnumerable<SqlDataRecord>.GetEnumerator()
        {
            SqlDataRecord ret = new SqlDataRecord(
                new SqlMetaData("id_compra", SqlDbType.Int),
                new SqlMetaData("id_nota_ingreso", SqlDbType.Int),
                new SqlMetaData("id_producto", SqlDbType.Int),
                new SqlMetaData("cantidad", SqlDbType.Decimal, 18, 2),
                new SqlMetaData("descripcion", SqlDbType.VarChar, 100),                
                new SqlMetaData("precio", SqlDbType.Decimal, 18, 2),
                new SqlMetaData("importe", SqlDbType.Decimal, 18, 2)
                );

            foreach (srDetalleC data in this)
            {
                ret.SetInt32(0, data.id_compra);
                ret.SetInt32(1, data.id_nota_ingreso);
                ret.SetInt32(2, data.id_producto);
                ret.SetDecimal(3, data.cantidad);
                ret.SetString(4, data.descripcion);                
                ret.SetDecimal(5, data.precio);
                ret.SetDecimal(6, data.importe);
                yield return ret;
            }
        }
    }

    //******************************** DETALLE NOTA **********************************************
    [Serializable]
    public class srDetalleNota
    {
        public String id_nota { get; set; }
        public String id_producto { get; set; }
        public Decimal cantidad { get; set; }
        public String descripcion { get; set; }
    }

    [Serializable]
    public class srDetalleN
    {
        public Int32 id_nota { get; set; }
        public Int32 id_producto { get; set; }
        public Decimal cantidad { get; set; }
        public String descripcion { get; set; }
    }

    public class LstDetalleNota : List<srDetalleN>, IEnumerable<SqlDataRecord>
    {
        IEnumerator<SqlDataRecord> IEnumerable<SqlDataRecord>.GetEnumerator()
        {
            SqlDataRecord ret = new SqlDataRecord(
                new SqlMetaData("id_nota", SqlDbType.Int),
                new SqlMetaData("id_producto", SqlDbType.Int),
                new SqlMetaData("cantidad", SqlDbType.Decimal, 18, 2),
                new SqlMetaData("descripcion", SqlDbType.VarChar, 100)
                );

            foreach (srDetalleN data in this)
            {
                ret.SetInt32(0, data.id_nota);
                ret.SetInt32(1, data.id_producto);
                ret.SetDecimal(2, data.cantidad);
                ret.SetString(3, data.descripcion);
                yield return ret;
            }
        }
    }

    //******************************** DETALLE HORAS TRABAJADAS **********************************************
    [Serializable]
    public class srDetalleHorasTrabajadas
    {
        public String id_orden_produccion { get; set; }
        public String id_personal { get; set; }
        public String fecha_hora_inicio { get; set; }
        public String fecha_hora_fin { get; set; }
        public Decimal costo { get; set; }
    }

    [Serializable]
    public class srDetalleHT
    {
        public Int32 id_orden_produccion { get; set; }
        public Int32 id_personal { get; set; }
        public DateTime fecha_hora_inicio { get; set; }
        public DateTime fecha_hora_fin { get; set; }
        public Decimal costo { get; set; }
    }

    public class LstDetalleHorasTrabajadas : List<srDetalleHT>, IEnumerable<SqlDataRecord>
    {
        IEnumerator<SqlDataRecord> IEnumerable<SqlDataRecord>.GetEnumerator()
        {
            SqlDataRecord ret = new SqlDataRecord(
                new SqlMetaData("id_orden_produccion", SqlDbType.Int),
                new SqlMetaData("id_personal", SqlDbType.Int),
                new SqlMetaData("fecha_hora_inicio", SqlDbType.DateTime),
                new SqlMetaData("fecha_hora_fin", SqlDbType.DateTime),
                new SqlMetaData("costo", SqlDbType.Decimal, 18, 2)
                );

            foreach (srDetalleHT data in this)
            {
                ret.SetInt32(0, data.id_orden_produccion);
                ret.SetInt32(1, data.id_personal);
                ret.SetDateTime(2, data.fecha_hora_inicio);
                ret.SetDateTime(3, data.fecha_hora_fin);
                ret.SetDecimal(4, data.costo);                
                yield return ret;
            }
        }
    }
}
