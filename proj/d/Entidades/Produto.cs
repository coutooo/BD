using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proj_bd.Entidades
{
    class Produto
    {
        private int _Codigo;
        private String _Preço;
        private String _Nome;
        private int _Iva;
        private int _No_unidades;

        public int Codigo
        {
            get { return _Codigo; }
            set
            {
                _Codigo = value;
            }
        }
        public String Preço
        {
            get { return _Preço; }
            set
            {
                _Preço = value;
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
        public int Iva
        {
            get { return _Iva; }
            set
            {
                _Iva = value;
            }
        }
        public int No_unidades
        {
            get { return _No_unidades; }
            set
            {
                _No_unidades = value;
            }
        }
        public override String ToString()
        {
            return _Codigo + " - " + _Nome;
        }
    }
}
