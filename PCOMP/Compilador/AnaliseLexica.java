import java.io.*;

enum TokenType {
  NUM,
  SOMA,
  MULT,
  SUB,//adicionado
  DIV,//adicionado
  APar,
  FPar,
  EOF,
}

class Token {

  String lexema;
  TokenType token;

  Token(String l, TokenType t) {
    lexema = l;
    token = t;
  }

  Token(char l, TokenType t) {
    lexema = Character.toString(l);
    token = t;
  }
}

class AnaliseLexica {

  BufferedReader arquivo;

  AnaliseLexica(String a) throws Exception {
    this.arquivo = new BufferedReader(new FileReader(a));
  }

  Token getNextToken() throws Exception {
    Token token;
    int eof = -1;
    char currchar;
    int currchar1;
    String numeroMaisDigitos = ""; //variável pra guardar um número com mais de um digito

    do {
      currchar1 = arquivo.read();
      currchar = (char) currchar1;
    } while (
      currchar == '\n' ||
      currchar == ' ' ||
      currchar == '\t' ||
      currchar == '\r'
    );

    if (currchar1 != eof && currchar1 != 10) {
      if (currchar >= '0' && currchar <= '9') {
        //Neste ponto do código, encontrei um número, agora tenho que verificar se existem números depois deste
        String pegaMaisNumeros = Character.toString(currchar);
        char ultimoCharacter = currchar;
        while (ultimoCharacter >= '0' && ultimoCharacter <= '9' ) {
          numeroMaisDigitos = numeroMaisDigitos.concat(pegaMaisNumeros);
          arquivo.mark(0);//salva a posição de leitura da "fita"
          ultimoCharacter = (char) arquivo.read();
          pegaMaisNumeros = Character.toString(ultimoCharacter);
		  // System.out.println("Texto: " + numeroMaisDigitos+" ultimo: "+ultimoCharacter+" pega: "+ pegaMaisNumeros);//debug
        }
        arquivo.reset();//caso eu saia do laço, volta o leitor da "fita" pra última posição e ai eu não perco o sinal

        return (new Token(numeroMaisDigitos, TokenType.NUM));
      } else switch (currchar) {
        case '(':
          return (new Token(currchar, TokenType.APar));
        case ')':
          return (new Token(currchar, TokenType.FPar));
        case '+':
          return (new Token(currchar, TokenType.SOMA));
        case '*':
          return (new Token(currchar, TokenType.MULT));
        case '-':
          return (new Token(currchar, TokenType.SUB));
        case '/':
          return (new Token(currchar, TokenType.DIV));
        default:
          throw (new Exception("Caractere inválido: " + ((int) currchar)));
      }
    }

    arquivo.close();

    return (new Token(currchar, TokenType.EOF));
  }
}