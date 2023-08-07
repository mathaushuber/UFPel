import java.io.*;

// Enumeração para definir os tipos de tokens possíveis
enum TokenType {
  NUM,    // Número
  SOMA,   // Operador de adição
  MULT,   // Operador de multiplicação
  SUB,    // Operador de subtração
  DIV,    // Operador de divisão
  APar,   // Parêntese de abertura
  FPar,   // Parêntese de fechamento
  EOF,    // Fim de arquivo
}

// Classe que representa um token com seu lexema (conteúdo) e tipo
class Token {
  String lexema;
  TokenType token;

  // Construtor para inicializar um token com uma string
  Token(String l, TokenType t) {
    lexema = l;
    token = t;
  }

  // Construtor para inicializar um token com um caractere
  Token(char l, TokenType t) {
    lexema = Character.toString(l);
    token = t;
  }
}

// Classe para realizar a análise léxica
class AnaliseLexica {
  BufferedReader arquivo;

  // Construtor para inicializar a análise léxica com um arquivo de entrada
  AnaliseLexica(String a) throws Exception {
    this.arquivo = new BufferedReader(new FileReader(a));
  }

  // Função para obter o próximo token do arquivo
  Token getNextToken() throws Exception {
    Token token;
    int eof = -1;         // Valor para fim de arquivo
    char currchar;        // Variável para o caractere atual
    int currchar1;
    String numberMoreDigits = ""; // Variável para guardar um número com mais de um dígito

    // Loop para ignorar espaços em branco e caracteres de controle
    do {
      currchar1 = arquivo.read();  // Lê o próximo caractere como valor numérico
      currchar = (char) currchar1; // Converte o valor numérico para caractere
    } while (
      currchar == '\n' ||  // Ignora quebras de linha
      currchar == ' ' ||   // Ignora espaços
      currchar == '\t' ||  // Ignora tabulações
      currchar == '\r'     // Ignora retornos de carro
    );

    // Verifica se não chegou ao fim do arquivo ou quebra de linha
    if (currchar1 != eof && currchar1 != 10) {
      if (currchar >= '0' && currchar <= '9') {
        // Encontrou um dígito, inicia a leitura de um possível número com vários dígitos
        String getMoreNumbers = Character.toString(currchar);
        char ultimoCharacter = currchar;

        // Loop para ler os dígitos subsequentes
        while (ultimoCharacter >= '0' && ultimoCharacter <= '9' ) {
          numberMoreDigits = numberMoreDigits.concat(getMoreNumbers);
          arquivo.mark(0);  // Salva a posição atual da leitura no arquivo
          ultimoCharacter = (char) arquivo.read(); // Lê o próximo caractere
          getMoreNumbers = Character.toString(ultimoCharacter);
        }
        arquivo.reset(); // Retorna à posição anterior no arquivo

        return (new Token(numberMoreDigits, TokenType.NUM));  // Retorna um token numérico
      } else switch (currchar) {
        case '(':
          return (new Token(currchar, TokenType.APar));  // Retorna um token de parêntese de abertura
        case ')':
          return (new Token(currchar, TokenType.FPar));  // Retorna um token de parêntese de fechamento
        case '+':
          return (new Token(currchar, TokenType.SOMA));  // Retorna um token de operador de adição
        case '*':
          return (new Token(currchar, TokenType.MULT));  // Retorna um token de operador de multiplicação
        case '-':
          return (new Token(currchar, TokenType.SUB));   // Retorna um token de operador de subtração
        case '/':
          return (new Token(currchar, TokenType.DIV));   // Retorna um token de operador de divisão
        default:
          throw (new Exception("Caractere inválido: " + ((int) currchar)));  // Lança exceção para caractere inválido
      }
    }

    arquivo.close();  // Fecha o arquivo

    return (new Token(currchar, TokenType.EOF));  // Retorna um token de fim de arquivo
  }
}
