using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proj_bd
{
    class Funcionario : Pessoa
    {
        private int _Numero;
        private int _Salario;

        public int Numero
        {
            get { return _Numero; }
            set
            {
                _Numero = value;
            }
        }

        public int Salario
        {
            get { return _Salario; }
            set
            {
                _Salario = value;
            }
        }

        public override String ToString()
        {
            return _Numero + " - " +  this.Nome;
        }
    }
}
