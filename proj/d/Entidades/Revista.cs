using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proj_bd.Entidades
{
    class Revista : Produto
    {
        private DateTime _Data_Revista;
        private String _Marca;
        public DateTime Data_Revista
        {
            get { return _Data_Revista; }
            set
            {
                _Data_Revista = value;
            }
        }
        public String Marca
        {
            get { return _Marca; }
            set
            {
                _Marca = value;
            }
        }
    }
}
