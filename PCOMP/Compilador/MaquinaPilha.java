import java.io.*;
import java.util.Stack;

// Classe que implementa uma máquina de pilha
class MaquinaPilha {
    static Stack<Integer> pilha = new Stack(); // A pilha de inteiros usada na máquina

    public static void main(String[] args) {
        try {
            BufferedReader buffRead = new BufferedReader(new FileReader(args[0]));
            String isRow = "";

            // Loop para ler cada linha do arquivo de entrada
            while (true) {
                isRow = buffRead.readLine(); // Lê uma linha do arquivo

                if (isRow == null) { // Verifica se chegou ao fim do arquivo
                    break;
                }

                determineAction(isRow); // Determina a ação a ser tomada com a linha lida
            }

            buffRead.close(); // Fecha o leitor após terminar de ler
        } catch (Exception e) {
            System.out.println("Erro:\n" + e);
        }
    }

    // Função para determinar a ação com base na linha lida
    private static void determineAction(String isRow) {
        if (isRow.startsWith("PUSH")) {
            String number = isRow.split(" ")[1];
            pilha.push(new Integer(number)); // Coloca o número na pilha
        } else if (isRow.startsWith("PRINT")) {
            Integer resultado = pilha.pop();
            System.out.println(resultado); // Imprime o resultado
        } else { // Entra aqui nos casos das operações
            evaluateOperation(isRow);
        }
    }

    // Função para avaliar operações
    private static void evaluateOperation(String operacao) {
        Integer operador1 = pilha.pop(); // Operador 1 é o retirado do topo da pilha
        Integer operador2 = pilha.pop(); // Operador 2 é o mais antigo

        switch (operacao) { // A operação é sempre um texto de uma palavra
            case "SUB":
                pilha.push(operador2 - operador1);
                break;
            case "DIV":
                pilha.push(operador2 / operador1);
                break;
            case "MULT":
                pilha.push(operador2 * operador1);
                break;
            case "SUM":
                pilha.push(operador2 + operador1);
                break;
        }
    }
}
