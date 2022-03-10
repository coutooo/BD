using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proj_bd.Entidades
{
    class Cliente:Pessoa
    {
        private int _Numero;

        public int Numero
        {
            get { return _Numero; }
            set
            {
                _Numero = value;
            }
        }

        public override String ToString()
        {
            return _Numero + " - " + this.Nome;
        }
    }
}
