using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Proj_bd
{
    public partial class Menu : Form
    {
        public Menu()
        {
            InitializeComponent();
        }

        private void Funcionarios_Click(object sender, EventArgs e)
        {
            var form1 = new Form1();
            form1.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            var cliente = new Clientes();
            cliente.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            var fornecedor = new Fornecedores();
            fornecedor.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            var produto = new Produtos();
            produto.Show();
        }
    }
}
