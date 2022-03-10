using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proj_bd.Entidades
{
    class Fornecedor:Pessoa
    {
        private int _Numero;
        private String _Empresa;

        public int Numero
        {
            get { return _Numero; }
            set
            {
                _Numero = value;
            }
        }

        public String Empresa
        {
            get { return _Empresa; }
            set
            {
                _Empresa = value;
            }
        }

        public override String ToString()
        {
            return this.Nome + " - " + this.Empresa;
        }
    }
}
