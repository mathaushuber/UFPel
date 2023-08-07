// Classe que gera código a partir de uma árvore sintática
class CodeGen {
    
    // Função principal para gerar código a partir da árvore
    String geraCodigo(ArvoreSintatica arv) {
        return (geraCodigo2(arv) + "PRINT"); // Adiciona "PRINT" ao final do código gerado
    }
    
    // Função auxiliar para gerar código a partir da árvore
    String geraCodigo2(ArvoreSintatica arv) {
        // Verifica se o nó é uma instância de "Mult"
        if (arv instanceof Mult)
            return (geraCodigo2(((Mult) arv).arg1) +
                    geraCodigo2(((Mult) arv).arg2) +
                    "MULT\n"); // Adiciona operação "MULT" ao código gerado
        
        // Verifica se o nó é uma instância de "Soma"
        if (arv instanceof Soma)
            return (geraCodigo2(((Soma) arv).arg1) +
                    geraCodigo2(((Soma) arv).arg2) +
                    "SUM\n"); // Adiciona operação "SUM" ao código gerado
        
        // Verifica se o nó é uma instância de "Sub"
        if (arv instanceof Sub)
            return (geraCodigo2(((Sub) arv).arg1) +
                    geraCodigo2(((Sub) arv).arg2) +
                    "SUB\n"); // Adiciona operação "SUB" ao código gerado
        
        // Verifica se o nó é uma instância de "Div"
        if (arv instanceof Div)
            return (geraCodigo2(((Div) arv).arg1) +
                    geraCodigo2(((Div) arv).arg2) +
                    "DIV\n"); // Adiciona operação "DIV" ao código gerado
        
        // Verifica se o nó é uma instância de "Num"
        if (arv instanceof Num)
            return ("PUSH "  + ((Num) arv).num + "\n"); // Adiciona operação "PUSH" seguida do número ao código gerado
        
        return ""; // Retorna string vazia se não for uma instância conhecida
    }
}
