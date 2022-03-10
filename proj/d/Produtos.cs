using Proj_bd.Entidades;
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
    public partial class Produtos : Form
    {
        private int currentFunc;
        private bool adding;
        private String selected_prod = "Livros";
        public Produtos()
        {
            InitializeComponent();
            checkedListBox1.SetItemCheckState(0, CheckState.Checked);
            loadBox1();
        }

        private void checkedListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = checkedListBox1.SelectedIndex;
            int count = checkedListBox1.Items.Count;
            for (int x=0; x <count; x++)
            {
                if(index != x)
                {
                    checkedListBox1.SetItemChecked(x, false);
                }
            }
            listBox1.Items.Clear();
            foreach(String s in checkedListBox1.CheckedItems)
            {
                selected_prod = s;
                loadBox1();
            }
        }

        private void loadBox1()
        {
            if (!ConcBD.verifySGBDConnection() | selected_prod == "")
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM "+ selected_prod, ConcBD.cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBox1.Items.Clear();

            while (reader.Read())
            {
                if (selected_prod == "Revistas")
                {
                    Revista p = new Revista();
                    p.Codigo = Int32.Parse(reader["Codigo"].ToString());
                    p.Preço = reader["Preço"].ToString();
                    p.Nome = reader["Nome"].ToString();
                    p.Iva = Int32.Parse(reader["Iva"].ToString());
                    p.No_unidades = Int32.Parse(reader["No_unidades"].ToString());
                    p.Data_Revista = (DateTime)reader["Data_Revista"];
                    p.Marca = reader["Marca"].ToString();
                    listBox1.Items.Add(p);
                }
                else if (selected_prod == "Livros")
                {
                    Livro p = new Livro();
                    p.Codigo = Int32.Parse(reader["Codigo"].ToString());
                    p.Preço = reader["Preço"].ToString();
                    p.Nome = reader["Nome"].ToString();
                    p.Iva = Int32.Parse(reader["Iva"].ToString());
                    p.No_unidades = Int32.Parse(reader["No_unidades"].ToString());
                    p.Ano = Int32.Parse(reader["Ano"].ToString());
                    p.Editora = reader["Editora"].ToString();
                    p.Autor = reader["Autor"].ToString();
                    p.Descricao = reader["Descricao"].ToString();
                    listBox1.Items.Add(p);
                }
                else if (selected_prod == "MaterialEscolar")
                {
                    MaterialEscolar p = new MaterialEscolar();
                    p.Codigo = Int32.Parse(reader["Codigo"].ToString());
                    p.Preço = reader["Preço"].ToString();
                    p.Nome = reader["Nome"].ToString();
                    p.Iva = Int32.Parse(reader["Iva"].ToString());
                    p.No_unidades = Int32.Parse(reader["No_unidades"].ToString());
                    p.Descricao = reader["Descricao"].ToString();
                    p.Categoria = reader["Categoria"].ToString();
                    p.Marca = reader["Marca"].ToString();
                    listBox1.Items.Add(p);
                }
                else if (selected_prod == "Informatica")
                {
                    Informatica p = new Informatica();
                    p.Codigo = Int32.Parse(reader["Codigo"].ToString());
                    p.Preço = reader["Preço"].ToString();
                    p.Nome = reader["Nome"].ToString();
                    p.Iva = Int32.Parse(reader["Iva"].ToString());
                    p.No_unidades = Int32.Parse(reader["No_unidades"].ToString());
                    p.Descricao = reader["Descricao"].ToString();
                    p.Categoria = reader["Categoria"].ToString();
                    p.Marca = reader["Marca"].ToString();
                    listBox1.Items.Add(p);
                }
            }

            ConcBD.cn.Close();
            currentFunc = 0;
            ShowFunc();
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBox1.SelectedIndex >= 0)
            {
                currentFunc = listBox1.SelectedIndex;
                ShowFunc();
            }
        }

        public void ShowFunc()
        {
            if (listBox1.Items.Count == 0 | currentFunc < 0)
                return;
            if (selected_prod == "Revistas")
            {
                Revista contact = new Revista();
                contact = (Revista)listBox1.Items[currentFunc];
                textBox1.Text = contact.Codigo.ToString();
                textBox2.Text = contact.Preço.ToString();
                textBox3.Text = contact.Nome.ToString();
                textBox4.Text = contact.Iva.ToString();
                textBox5.Text = contact.No_unidades.ToString();
                dateTimePicker1.Show();
                dateTimePicker1.Value = contact.Data_Revista;
                textBox6.Hide();
                textBox7.Show();
                textBox7.Text = contact.Marca.ToString();
                textBox8.Hide();
                textBox9.Hide();
                label6.Show();
                label7.Show();
                label8.Hide();
                label8.Hide();
                label9.Hide();
                label10.Hide();
                label11.Hide();
                label12.Hide();
            }
            else if (selected_prod == "Livros")
            {
                Livro contact = new Livro();
                contact = (Livro)listBox1.Items[currentFunc];
                textBox1.Text = contact.Codigo.ToString();
                textBox2.Text = contact.Preço.ToString();
                textBox3.Text = contact.Nome.ToString();
                textBox4.Text = contact.Iva.ToString();
                textBox5.Text = contact.No_unidades.ToString();
                dateTimePicker1.Hide();
                textBox6.Show();
                textBox6.Text = contact.Ano.ToString();
                textBox7.Show();
                textBox7.Text = contact.Editora.ToString();
                textBox8.Show();
                textBox8.Text = contact.Autor.ToString();
                textBox9.Show();
                textBox9.Text = contact.Descricao.ToString();
                label6.Hide();
                label7.Hide();
                label8.Show();
                label9.Show();
                label10.Show();
                label11.Show();
                label12.Hide();
            }
            else if (selected_prod == "MaterialEscolar")
            {
                MaterialEscolar contact = new MaterialEscolar();
                contact = (MaterialEscolar)listBox1.Items[currentFunc];
                textBox1.Text = contact.Codigo.ToString();
                textBox2.Text = contact.Preço.ToString();
                textBox3.Text = contact.Nome.ToString();
                textBox4.Text = contact.Iva.ToString();
                textBox5.Text = contact.No_unidades.ToString();
                dateTimePicker1.Hide();
                textBox6.Show();
                textBox6.Text = contact.Categoria.ToString();
                textBox7.Show();
                textBox7.Text = contact.Marca.ToString();
                textBox8.Hide();
                textBox9.Show();
                textBox9.Text = contact.Descricao.ToString();
                label6.Hide();
                label7.Hide();
                label8.Show();
                label9.Show();
                label10.Show();
                label11.Show();
                label12.Show();
            }
            else if (selected_prod == "Informatica")
            {
                Informatica contact = new Informatica();
                contact = (Informatica)listBox1.Items[currentFunc];
            }
        }
    }
}
