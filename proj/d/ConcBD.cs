using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proj_bd
{
    class ConcBD
    {
        public static SqlConnection cn;
        public static SqlConnection getSGBDConnection()
        {
            return new SqlConnection("Data Source=eduardo-nb;Initial Catalog=Proj_bd;Integrated Security=True");
        }

        public static bool verifySGBDConnection()
        {
            if (cn == null)
                cn = getSGBDConnection();

            if (cn.State != ConnectionState.Open)
                cn.Open();

            return cn.State == ConnectionState.Open;
        }
    }
}
