using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proj_bd
{
    [Serializable()]
    class Pessoa
    {
        private int _NIF;
        private String _Nome;
        private String _Telefone;
        private String _Morada;
        private int _Idade;

        public int NIF
        {
            get { return _NIF; }
            set
            {
                _NIF = value;
            }
        }

        public String Nome
        {
            get { return _Nome; }
            set
            {
                _Nome = value;
            }
        }

        public String Telefone
        {
            get { return _Telefone; }
            set
            {
                _Telefone = value;
            }
        }

        public String Morada
        {
            get { return _Morada; }
            set
            {
                _Morada = value;
            }
        }

        public int Idade
        {
            get { return _Idade; }
            set
            {
                _Idade = value;
            }
        }

        public override String ToString()
        {
            return _Nome + " - "+ _NIF;
        }
    }
}
