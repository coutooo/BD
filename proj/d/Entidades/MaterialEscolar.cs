using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proj_bd.Entidades
{
    class MaterialEscolar : Produto
    {
        private String _Descricao;
        private String _Categoria;
        private String _Marca;
        public String Descricao
        {
            get { return _Descricao; }
            set
            {
                _Descricao = value;
            }
        }
        public String Categoria
        {
            get { return _Categoria; }
            set
            {
                _Categoria = value;
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
