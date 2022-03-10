using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proj_bd.Entidades
{
    class Livro : Produto
    {
        private int _Ano;
        private String _Editora;
        private String _Autor;
        private String _Descricao;
        public int Ano
        {
            get { return _Ano; }
            set
            {
                _Ano = value;
            }
        }
        public String Editora
        {
            get { return _Editora; }
            set
            {
                _Editora = value;
            }
        }
        public String Autor
        {
            get { return _Autor; }
            set
            {
                _Autor = value;
            }
        }
        public String Descricao
        {
            get { return _Descricao; }
            set
            {
                _Descricao = value;
            }
        }
    }
}
