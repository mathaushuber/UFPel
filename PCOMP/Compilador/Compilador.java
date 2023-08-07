// Classe que serve como ponto de entrada do compilador
class Compilador {

    public static void main(String[] args) {
        ArvoreSintatica arv = null;  // Inicializa uma árvore sintática como nulo

        try {
            // Realiza a análise léxica do arquivo de entrada fornecido como argumento
            AnaliseLexica al = new AnaliseLexica(args[0]);
            
            // Inicializa o parser com a análise léxica
            Parser as = new Parser(al);
            
            // Realiza o parsing do programa e obtém a árvore sintática resultante
            arv = as.parseProg();

            // Compila a árvore sintática utilizando o gerador de código
            CodeGen backend = new CodeGen();
            String codigo = backend.geraCodigo(arv);
            
            // Imprime o código gerado
            System.out.println(codigo);

        } catch (Exception e) {
            // Captura exceções durante a compilação e imprime uma mensagem de erro
            System.out.println("Erro de compilação:\n" + e);
        }
    }
}
