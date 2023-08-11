class Interpretador {

    // Método para interpretar uma árvore sintática e avaliar uma expressão matemática
    Integer interpretaCodigo(ArvoreSintatica arv) {

        // Verifica se o nó da árvore é uma multiplicação
        if (arv instanceof Mult) {
            // Avalia as subárvores arg1 e arg2, multiplicando os resultados
            return (interpretaCodigo(((Mult) arv).arg1) * interpretaCodigo(((Mult) arv).arg2));
        }

        // Verifica se o nó da árvore é uma soma
        if (arv instanceof Soma) {
            // Avalia as subárvores arg1 e arg2, somando os resultados
            return (interpretaCodigo(((Soma) arv).arg1) + interpretaCodigo(((Soma) arv).arg2));
        }

        // Verifica se o nó da árvore é uma subtração
        if (arv instanceof Sub) {
            // Avalia as subárvores arg1 e arg2, subtraindo o resultado de arg2 de arg1
            return (interpretaCodigo(((Sub) arv).arg1) - interpretaCodigo(((Sub) arv).arg2));
        }

        // Verifica se o nó da árvore é uma divisão
        if (arv instanceof Div) {
            // Avalia as subárvores arg1 e arg2, dividindo o resultado de arg1 por arg2
            return (interpretaCodigo(((Div) arv).arg1) / interpretaCodigo(((Div) arv).arg2));
        }

        // Verifica se o nó da árvore é um número
        if (arv instanceof Num) {
            // Retorna o valor numérico associado a esse nó
            return (((Num) arv).num);
        }

        // Retorna null caso o nó não corresponda a nenhum dos tipos anteriores
        return null;
    }
}
