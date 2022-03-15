using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Motoshop
{
    class DatabaseHandler
    {
        private SqlConnection cn;

        public DatabaseHandler()
        {

        }

        public SqlConnection getSGBDConnection()
        {
            return cn;
        }

        public void initSGBDConnection()
        {
            cn = new SqlConnection("data source= ////falta/////////////");
            // ALTERAR AQUI PARA CADA PC.
            //cn = new SqlConnection("data source= FÁBIO-TP\\SQLEXPRESS;integrated security=true;initial catalog=MOTOSHOP");
            //cn = new SqlConnection("data source=DESKTOP-BCIC2SB\\SQLEXPRESS;integrated security=true;initial catalog=MOTOSHOP");
        }

        public bool verifySGBDConnection()
        {
            if (cn == null)
                cn = getSGBDConnection();

            if (cn.State != ConnectionState.Open)
                cn.Open();

            return cn.State == ConnectionState.Open;
        }


    }
}
