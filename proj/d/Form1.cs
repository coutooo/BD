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
    public partial class Form1 : Form
    {
        private int currentFunc;
        private bool adding;

        public Form1()
        {
            InitializeComponent();
            loadBox1();
            ShowButtons();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            ConcBD.verifySGBDConnection();
        }

        private void loadBox1()
        {
            if (!ConcBD.verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM Func", ConcBD.cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBox1.Items.Clear();

            while (reader.Read())
            {
                Funcionario p = new Funcionario();
                p.NIF = Int32.Parse(reader["NIF"].ToString());
                p.Nome = reader["Nome"].ToString();
                p.Telefone = reader["Telefone"].ToString();
                p.Morada = reader["Morada"].ToString();
                p.Idade = Int32.Parse(reader["Idade"].ToString());
                p.Numero = Int32.Parse(reader["Numero"].ToString());
                p.Salario = Int32.Parse(reader["Salario"].ToString());
                listBox1.Items.Add(p);
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
            Funcionario contact = new Funcionario();
            contact = (Funcionario)listBox1.Items[currentFunc];
            textBox1.Text = contact.NIF.ToString();
            textBox2.Text = contact.Nome;
            textBox3.Text = contact.Telefone.ToString();
            textBox4.Text = contact.Morada;
            textBox5.Text = contact.Idade.ToString();
            textBox6.Text = contact.Numero.ToString();
            textBox7.Text = contact.Salario.ToString();

        }

        public void LockControls()
        {
            textBox1.ReadOnly = true;
            textBox2.ReadOnly = true;
            textBox3.ReadOnly = true;
            textBox4.ReadOnly = true;
            textBox5.ReadOnly = true;
            textBox6.ReadOnly = true;
            textBox7.ReadOnly = true;
        }

        public void UnlockControls()
        {
            if(adding) textBox1.ReadOnly = false;
            else textBox1.ReadOnly = true;
            textBox2.ReadOnly = false;
            textBox3.ReadOnly = false;
            textBox4.ReadOnly = false;
            textBox5.ReadOnly = false;
            textBox6.ReadOnly = true;
            textBox7.ReadOnly = false;
        }

        public void ClearFields()
        {
            Funcionario ult = (Funcionario)listBox1.Items[listBox1.Items.Count - 1];
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";
            textBox5.Text = "";
            textBox6.Text = "" + (ult.Numero + 1);
            textBox7.Text = "";
        }

        public void ShowButtons()
        {
            LockControls();
            Adicionar.Visible = true;
            Editar.Visible = true;
            Cancelar.Visible = false;
            Salvar.Visible =false;
        }

        public void HideButtons()
        {
            UnlockControls();
            Adicionar.Visible = false;
            Editar.Visible = false;
            Cancelar.Visible = true;
            Salvar.Visible = true;
        }

        private void Adicionar_Click(object sender, EventArgs e)
        { 
            adding = true;
            ClearFields();
            HideButtons();
        }

        private void Editar_Click(object sender, EventArgs e)
        {
            adding = false;
            HideButtons();
        }

        private void Salvar_Click(object sender, EventArgs e)
        {
            ShowButtons();
            SalvarFuncionario();
        }

        private void Cancelar_Click(object sender, EventArgs e)
        {
            ShowButtons();
            ShowFunc();
        }

        private bool SalvarFuncionario()
        {
            Funcionario contact = new Funcionario();
            try
            {
                contact.NIF = Int32.Parse(textBox1.Text);
                contact.Nome = textBox2.Text;
                contact.Telefone = textBox3.Text;
                contact.Morada = textBox4.Text;
                contact.Idade = Int32.Parse(textBox5.Text);
                contact.Numero = Int32.Parse(textBox6.Text);
                contact.Salario = Int32.Parse(textBox7.Text);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return false;
            }
            if (adding)
            {
                ConcBD.verifySGBDConnection();
                SqlCommand cmd = new SqlCommand("EXEC AddFunc @NIF, @Nome, @Telefone, @Morada, @Idade, @Numero, @Salario", ConcBD.cn);
                cmd.Parameters.AddWithValue("@Numero", contact.Numero);
                cmd.Parameters.AddWithValue("@NIF", contact.NIF);
                cmd.Parameters.AddWithValue("@Salario", contact.Salario);
                cmd.Parameters.AddWithValue("@Nome", contact.Nome);
                cmd.Parameters.AddWithValue("@Telefone", contact.Telefone);
                cmd.Parameters.AddWithValue("@Morada", contact.Morada);
                cmd.Parameters.AddWithValue("@Idade", contact.Idade);
                cmd.ExecuteNonQuery();
                listBox1.Items.Add(contact);
            }
            else
            {
                ConcBD.verifySGBDConnection();
                SqlCommand cmd = new SqlCommand("EXEC UpdateFunc @NIF, @Nome, @Telefone, @Morada, @Idade, @Numero, @Salario", ConcBD.cn);
                cmd.Parameters.AddWithValue("@Numero", contact.Numero);
                cmd.Parameters.AddWithValue("@NIF", contact.NIF);
                cmd.Parameters.AddWithValue("@Salario", contact.Salario);
                cmd.Parameters.AddWithValue("@Nome", contact.Nome);
                cmd.Parameters.AddWithValue("@Telefone", contact.Telefone);
                cmd.Parameters.AddWithValue("@Morada", contact.Morada);
                cmd.Parameters.AddWithValue("@Idade", contact.Idade);
                cmd.ExecuteNonQuery();
                listBox1.Items[currentFunc] = contact;
            }
            return true;
        }
    }
}
