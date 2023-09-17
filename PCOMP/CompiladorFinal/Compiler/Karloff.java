/* Generated By:JavaCC: Do not edit this line. Karloff.java */
import java.io.*;
import java.util.ArrayList;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.Scanner;

class KarloffMain{
    ArrayList<VariableDeclaration> variableDeclaration;
    CommandSequence commandSequence;

    KarloffMain(ArrayList<VariableDeclaration> variableDeclaration, CommandSequence commandSequence){
        this.variableDeclaration = variableDeclaration;
        this.commandSequence = commandSequence;
    }

    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("public static void main(String[] args) {\u005cn");
        for (VariableDeclaration decVar : this.variableDeclaration) {
            stringBuilder.append(decVar).append("\u005cn");
        }
        return stringBuilder.append(this.commandSequence).append("}\u005cn").toString();
    }
}

class KarloffTree{
    KarloffMain main;
    FunctionList lf;
    String inputFileName;

    KarloffTree(KarloffMain main, String inputFileName){
        this.main = main;
        this.inputFileName = inputFileName;
    }

    KarloffTree(KarloffMain main, FunctionList lf, String inputFileName){
        this.main = main;
        this.lf = lf;
        this.inputFileName = inputFileName;
    }

    @Override
    public String toString() {
        String baseName = this.inputFileName.substring(0, this.inputFileName.lastIndexOf('.'));
        String outputFileName = baseName + "_output_generator";
        return "import java.util.Scanner;\u005cnpublic class " + outputFileName + "{\u005cn\u005cn"
        + this.main + (this.lf == null ? "" : "\u005cn" + this.lf) + "\u005cn}\u005cn";
    }
}

class VariableDeclaration{
    TokenId tokenId;
    TipoDeVar tipoDeVar;

    VariableDeclaration(TipoDeVar tipoDeVar, TokenId tokenId){
        this.tipoDeVar = tipoDeVar;
        this.tokenId = tokenId;
    }

    @Override
    public String toString() {
        if (this.tipoDeVar != null && this.tokenId != null)
            return this.tipoDeVar + " " + this.tokenId + ";";
        else
            return "";
    }
}

class TipoDeVar{
    String tipo;

    TipoDeVar(String tipo){
        this.tipo = tipo;
    }

    @Override
    public String toString() {
        switch (this.tipo){
            case "integer":
                return "int";
            case "bool":
                return "boolean";
            default:
                return "";
        }
    }
}

class CommandSequence{
    ArrayList<Com> comandos;

    CommandSequence(ArrayList<Com> comandos){
        this.comandos = comandos;
    }

    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        for (Com com : this.comandos) {
            stringBuilder.append(com).append("\u005cn");
        }
        return stringBuilder.toString();
    }
}

class Com{}
class Assignment extends Com{
    Expression exp;
    TokenId tokenId;

    Assignment(Expression exp, TokenId tokenId){
        this.exp = exp;
        this.tokenId = tokenId;
    }

    @Override
    public String toString() {
        return this.tokenId + " = " + this.exp + ";";
    }
}
class ChamadaFuncCom extends Com{
    TokenId tokenId;
    ExpressionList expList;

    ChamadaFuncCom(TokenId tokenId, ExpressionList expList){
        this.tokenId = tokenId;
        this.expList = expList;
    }

    @Override
    public String toString() {
        if (this.expList == null) return this.tokenId + "()" + ";";
        return this.tokenId + "(" + this.expList + ")" + ";";
    }
}
class ConditionalStatement extends Com{
    Expression exp;
    CommandSequence commandSequence;

    ConditionalStatement(Expression exp, CommandSequence commandSequence){
        this.exp = exp;
        this.commandSequence = commandSequence;
    }

    @Override
    public String toString() {
        return "if (" + this.exp + ") {\u005cn" + this.commandSequence + "}";
    }
}
class WhileLoop extends Com{
    Expression exp;
    CommandSequence commandSequence;

    WhileLoop(Expression exp, CommandSequence commandSequence){
        this.exp = exp;
        this.commandSequence = commandSequence;
    }

    @Override
    public String toString() {
        return "while (" + this.exp + ") {\u005cn" + this.commandSequence + "}";
    }
}
class RepeatLoop extends Com{
    Expression exp;
    CommandSequence commandSequence;

    RepeatLoop(Expression exp, CommandSequence commandSequence){
        this.exp = exp;
        this.commandSequence = commandSequence;
    }

    @Override
    public String toString() {
        return "do {\u005cn" + this.commandSequence + "} while (" + this.exp + ");";
    }
}
class ReturnStatement extends Com{
    Expression exp;

    ReturnStatement(Expression exp){
        this.exp = exp;
    }

    @Override
    public String toString() {
        return "return " + this.exp + ";";
    }
}
class Saida extends Com{
    Expression exp;

    Saida(Expression exp){
        this.exp = exp;
    }

    @Override
    public String toString() {
        return "System.out.println(" + this.exp + ");";
    }
}
class Scan extends Com{
    TokenId tokenId;
    private static int counter = 0;

    Scan(TokenId tokenId){
        this.tokenId = tokenId;
    }

    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        if (counter == 0) stringBuilder.append("Scanner scan = new Scanner(System.in);\u005cn");
        stringBuilder.append(this.tokenId).append(" = scan.nextInt();\u005cnscan.nextLine();\u005cn");
        counter++;
        return stringBuilder.toString();
    }
}

class Expression{}
class ExpressionRecursion extends Expression{
    Expression exp1, exp2;
    Operation op;

    ExpressionRecursion(Expression exp1, Expression exp2, Operation op){
        this.exp1 = exp1;
        this.exp2 = exp2;
        this.op = op;
    }

    @Override
    public String toString() {
        return "(" + this.exp1 + " " + this.op + " " + this.exp2 + ")";
    }
}
class Fator extends Expression{}
class TokenId extends Fator {
    String var;

    TokenId(String var){
        this.var = var;
    }

    @Override
    public String toString() {
        return this.var;
    }
}
class TokenNum extends Fator {
    Integer num;

    TokenNum(Integer num){
        this.num = num;
    }

    @Override
    public String toString() {
        return this.num.toString();
    }
}
class FunctionCallFactor extends Fator{
    TokenId tokenId;
    ExpressionList expList;

    FunctionCallFactor(TokenId tokenId, ExpressionList expList){
        this.tokenId = tokenId;
        this.expList = expList;
    }

    @Override
    public String toString() {
        if (this.expList == null) return this.tokenId + "()";
        return this.tokenId + "(" + this.expList + ")";
    }
}
class VF extends Fator{
    String vf;

    VF(String vf){
        this.vf = vf;
    }

    @Override
    public String toString() {
        return this.vf;
    }
}

class Operation{
     String op;

     Operation(String op){
         this.op = op;
     }

     @Override
     public String toString() {
         return this.op;
     }
}

class ExpressionList{
    ArrayList<Expression> expressoes;

    ExpressionList(ArrayList<Expression> expressoes){
        this.expressoes = expressoes;
    }

    @Override
     public String toString() {
        if (this.expressoes.size() == 1) return expressoes.get(0).toString();
        StringBuilder stringBuilder = new StringBuilder();
        for (Expression exp : this.expressoes) {
            stringBuilder.append(exp).append(", ");
        }
        return stringBuilder.toString();
    }
}

class FunctionDefinition{
    TokenId tokenId;
    TipoDeVar tipoDeVar;
    ListaArgumentos listaArgumentos;
    ArrayList<VariableDeclaration> variableDeclaration;
    CommandSequence commandSequence;

    FunctionDefinition(TokenId tokenId, TipoDeVar tipoDeVar, ListaArgumentos listaArgumentos, ArrayList<VariableDeclaration> variableDeclaration, CommandSequence commandSequence){
            this.tokenId = tokenId;
            this.tipoDeVar = tipoDeVar;
            this.listaArgumentos = listaArgumentos;
            this.variableDeclaration = variableDeclaration;
            this.commandSequence = commandSequence;
    }

    @Override
     public String toString() {
        StringBuilder stringBuilder = new StringBuilder("public static " + this.tipoDeVar + " " + this.tokenId + "(" + this.listaArgumentos + ") {\u005cn");
        for (VariableDeclaration decVar : this.variableDeclaration) {
            stringBuilder.append(decVar).append("\u005cn");
        }
        stringBuilder.append(commandSequence).append("}\u005cn");
        return stringBuilder.toString();
    }
}
class FunctionList{
    ArrayList<FunctionDefinition> funcoes;

    FunctionList(ArrayList<FunctionDefinition> funcoes){
        this.funcoes = funcoes;
    }

    @Override
     public String toString() {
        if (this.funcoes.size() == 1) return this.funcoes.get(0).toString();
        StringBuilder stringBuilder = new StringBuilder();
        for (FunctionDefinition func : this.funcoes) {
            stringBuilder.append(func.toString()).append("\u005cn");
        }
        return stringBuilder.toString();
    }
}

class Argument{
    TokenId tokenId;
    TipoDeVar tipoDeVar;

    Argument(TokenId tokenId, TipoDeVar tipoDeVar){
        this.tokenId = tokenId;
        this.tipoDeVar = tipoDeVar;
    }

    @Override
     public String toString() {
        return this.tipoDeVar + " " + this.tokenId;
    }
}
class ListaArgumentos{
    ArrayList<Argument> argumentos;

    ListaArgumentos(ArrayList<Argument> argumentos){
        this.argumentos = argumentos;
    }

    @Override
     public String toString() {
        if (this.argumentos.size() == 1) return this.argumentos.get(0).toString();
        StringBuilder stringBuilder = new StringBuilder();
        for (Argument arg : this.argumentos) {
            stringBuilder.append(arg).append(", ");
        }
        return stringBuilder.toString();
    }
}

public class Karloff implements KarloffConstants {
  public static void main(String[] args) throws ParseException, IOException {
      Karloff parser = new Karloff(new FileInputStream(args[0]));
      String inputFileName = new File(args[0]).getName();
      KarloffTree tree = parser.Karloff(inputFileName);

      // Verifica e cria o diretório se não existir
      File directory = new File("../GeneratedOutputs/");
      if (!directory.exists()){
          directory.mkdirs();
      }

      String baseName = inputFileName.substring(0, inputFileName.lastIndexOf('.'));
      String outputFileName = baseName + "_output_generator.java";
      File outputFile = new File(directory.getPath() + "/" + outputFileName);

      // Verificar se o arquivo já existe
      if (outputFile.exists()) {
          Scanner scanner = new Scanner(System.in);
          System.out.println("J\u00e1 existe um arquivo com esse nome na pasta. Deseja sobrescrev\u00ea-lo? (Sim/Nao)");

          while (true) { // Um loop para continuar perguntando até receber uma resposta válida
              String userResponse = scanner.nextLine();

              if ("Sim".equalsIgnoreCase(userResponse)) {
                  break;
              } else if ("Nao".equalsIgnoreCase(userResponse)) {
                  System.out.println("Opera\u00e7\u00e3o cancelada pelo usu\u00e1rio.");
                  scanner.close();
                  return;
              } else {
                  System.out.println("Resposta inv\u00e1lida. Por favor, responda com 'Sim' ou 'Nao'.");
              }
          }
          scanner.close();
      }

      FileWriter file = new FileWriter(outputFile);
      PrintWriter print = new PrintWriter(file);
      print.printf(tree.toString());
      print.close();
      file.close();
      System.out.println(tree);
  }

// KARLOFF → MAIN FUNC?
  static final public KarloffTree Karloff(String inputFileName) throws ParseException {
 KarloffMain main = null; FunctionList lf = null;
    main = Main();
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case FUNC:
      lf = Func();
      break;
    default:
      jj_la1[0] = jj_gen;
      ;
    }
    jj_consume_token(0);
     {if (true) return lf == null ? new KarloffTree(main, inputFileName) : new KarloffTree(main, lf, inputFileName);}
    throw new Error("Missing return statement in function");
  }

// MAIN → "void" "main" "(" ")" "{" VARDECL SEQCOMANDOS "}"
  static final public KarloffMain Main() throws ParseException {
 ArrayList<VariableDeclaration> varDec = null; CommandSequence seqCom = null;
    jj_consume_token(VOID);
    jj_consume_token(MAIN);
    jj_consume_token(APARENTESES);
    jj_consume_token(FPARENTESES);
    jj_consume_token(ACHAVES);
    varDec = Vardecl();
    seqCom = SeqComandos();
    jj_consume_token(FCHAVES);
     {if (true) return new KarloffMain(varDec, seqCom);}
    throw new Error("Missing return statement in function");
  }

// VARDECL → VARDECL "newVar" TIPO TOKEN_id ";" | vazio
  static final public ArrayList<VariableDeclaration> Vardecl() throws ParseException {
 Token t = null; TipoDeVar tipoDeVar = null; ArrayList<VariableDeclaration> ldv = new ArrayList();
    label_1:
    while (true) {
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case NEWVAR:
        ;
        break;
      default:
        jj_la1[1] = jj_gen;
        break label_1;
      }
      jj_consume_token(NEWVAR);
      tipoDeVar = Tipo();
      t = jj_consume_token(ID);
      jj_consume_token(PONTOVIRGULA);
                                                      ldv.add(new VariableDeclaration(tipoDeVar, new TokenId(t.image)));
    }
     {if (true) return ldv;}
    throw new Error("Missing return statement in function");
  }

// TIPO → "integer" | "bool"
  static final public TipoDeVar Tipo() throws ParseException {
 TipoDeVar tipoDeVar = null;
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case INTEIRO:
      jj_consume_token(INTEIRO);
                   tipoDeVar = new TipoDeVar("integer");
      break;
    case BOOLEANO:
      jj_consume_token(BOOLEANO);
                      tipoDeVar = new TipoDeVar("bool");
      break;
    default:
      jj_la1[2] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
     {if (true) return tipoDeVar;}
    throw new Error("Missing return statement in function");
  }

// SEQCOMANDOS → SEQCOMANDOS COMANDO | vazio
  static final public CommandSequence SeqComandos() throws ParseException {
 Com c = null; ArrayList<Com> comandos = new ArrayList();
    label_2:
    while (true) {
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case IF:
      case WHILE:
      case REPEAT:
      case RETURN:
      case SOUT:
      case ID:
        ;
        break;
      default:
        jj_la1[3] = jj_gen;
        break label_2;
      }
      c = Comando();
                  comandos.add(c);
    }
     {if (true) return new CommandSequence(comandos);}
    throw new Error("Missing return statement in function");
  }

// COMANDO → TOKEN_id COMANDO’
// | "if" "(" EXP ")" "then" "{" SEQCOMANDOS "}"  ";"
// | "while" "(" EXP ")" "{" SEQCOMANDOS "}"  ";"
// | "repeat" "{" SEQCOMANDOS "}" "until" "(" EXP ")"  ";"
// | "return" EXP  ";"
// | "System.output" "(" EXP ")"  ";"
  static final public Com Comando() throws ParseException {
 Token t = null; TokenId tokenId = null; CommandSequence seqCom = null;
Expression e = null; Com result = null; Com comL = null;
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case ID:
      t = jj_consume_token(ID);
      comL = Comando_(new TokenId(t.image));
                                                    result = comL;
      break;
    case IF:
      jj_consume_token(IF);
      jj_consume_token(APARENTESES);
      e = Exp();
      jj_consume_token(FPARENTESES);
      jj_consume_token(THEN);
      jj_consume_token(ACHAVES);
      seqCom = SeqComandos();
      jj_consume_token(FCHAVES);
      jj_consume_token(PONTOVIRGULA);
                                                                                                                   result = new ConditionalStatement(e, seqCom);
      break;
    case WHILE:
      jj_consume_token(WHILE);
      jj_consume_token(APARENTESES);
      e = Exp();
      jj_consume_token(FPARENTESES);
      jj_consume_token(ACHAVES);
      seqCom = SeqComandos();
      jj_consume_token(FCHAVES);
      jj_consume_token(PONTOVIRGULA);
                                                                                                               result = new WhileLoop(e, seqCom);
      break;
    case REPEAT:
      jj_consume_token(REPEAT);
      jj_consume_token(ACHAVES);
      seqCom = SeqComandos();
      jj_consume_token(FCHAVES);
      jj_consume_token(UNTIL);
      jj_consume_token(APARENTESES);
      e = Exp();
      jj_consume_token(FPARENTESES);
      jj_consume_token(PONTOVIRGULA);
                                                                                                                        result = new RepeatLoop(e, seqCom);
      break;
    case RETURN:
      jj_consume_token(RETURN);
      e = Exp();
      jj_consume_token(PONTOVIRGULA);
                                           result = new ReturnStatement(e);
      break;
    case SOUT:
      jj_consume_token(SOUT);
      jj_consume_token(APARENTESES);
      e = Exp();
      jj_consume_token(FPARENTESES);
      jj_consume_token(PONTOVIRGULA);
                                                                     result = new Saida(e);
      break;
    default:
      jj_la1[4] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
     {if (true) return result;}
    throw new Error("Missing return statement in function");
  }

// COMANDO’ → "=" COMANDO’’ | "(" LISTAEXP? ")"  ";"
  static final public Com Comando_(TokenId t) throws ParseException {
 Com result = null; Com comLL = null; ExpressionList l = null;
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case ATRIB:
      jj_consume_token(ATRIB);
      comLL = Comando__(t);
                                    result = comLL;
      break;
    case APARENTESES:
      jj_consume_token(APARENTESES);
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case APARENTESES:
      case TRUE:
      case FALSE:
      case NUM:
      case ID:
        l = ListaExp();
        break;
      default:
        jj_la1[5] = jj_gen;
        ;
      }
      jj_consume_token(FPARENTESES);
      jj_consume_token(PONTOVIRGULA);
                                                                      result = new ChamadaFuncCom(t, l);
      break;
    default:
      jj_la1[6] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
     {if (true) return result;}
    throw new Error("Missing return statement in function");
  }

// COMANDO’’ → EXP ";" | "System.readint" "(" ")" ";"
  static final public Com Comando__(TokenId t) throws ParseException {
 Com result = null; Expression e = null;
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case APARENTESES:
    case TRUE:
    case FALSE:
    case NUM:
    case ID:
      e = Exp();
      jj_consume_token(PONTOVIRGULA);
                                result = new Assignment(e, t);
      break;
    case SREADINT:
      jj_consume_token(SREADINT);
      jj_consume_token(APARENTESES);
      jj_consume_token(FPARENTESES);
      jj_consume_token(PONTOVIRGULA);
                                                                 result = new Scan(t);
      break;
    default:
      jj_la1[7] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
     {if (true) return result;}
    throw new Error("Missing return statement in function");
  }

//EXP →  "(" EXP OP EXP ")" | FATOR
  static final public Expression Exp() throws ParseException {
 Expression e1 = null; Expression e2 = null; Operation op = null; Expression result = null; Fator f = null;
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case APARENTESES:
      jj_consume_token(APARENTESES);
      e1 = Exp();
      op = Op();
      e2 = Exp();
      jj_consume_token(FPARENTESES);
                                                               result = new ExpressionRecursion(e1, e2, op);
      break;
    case TRUE:
    case FALSE:
    case NUM:
    case ID:
      f = Fator();
                     result = f;
      break;
    default:
      jj_la1[8] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
     {if (true) return result;}
    throw new Error("Missing return statement in function");
  }

//FATOR →  TOKEN_id FATOR’| TOKEN_numliteral | "true" | "false"
  static final public Fator Fator() throws ParseException {
 Fator result = null; Fator fatorL = null; Token t = null; TokenId tokenId = null; TokenNum TokenNum = null;
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case ID:
      t = jj_consume_token(ID);
      fatorL = Fator_(new TokenId(t.image));
                                                    result = fatorL;
      break;
    case NUM:
      t = jj_consume_token(NUM);
                   result = new TokenNum(Integer.parseInt(t.image));
      break;
    case TRUE:
      jj_consume_token(TRUE);
                  result = new VF("true");
      break;
    case FALSE:
      jj_consume_token(FALSE);
                   result = new VF("false");
      break;
    default:
      jj_la1[9] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
     {if (true) return result;}
    throw new Error("Missing return statement in function");
  }

//FATOR’ →  "(" LISTAEXP? ")" | vazio
  static final public Fator Fator_(TokenId tokenId) throws ParseException {
 ExpressionList le = null; Token t = null;
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case APARENTESES:
      t = jj_consume_token(APARENTESES);
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case APARENTESES:
      case TRUE:
      case FALSE:
      case NUM:
      case ID:
        le = ListaExp();
        break;
      default:
        jj_la1[10] = jj_gen;
        ;
      }
      jj_consume_token(FPARENTESES);
      break;
    default:
      jj_la1[11] = jj_gen;
      ;
    }
                                                       {if (true) return t == null ? tokenId : new FunctionCallFactor(tokenId, le);}
    throw new Error("Missing return statement in function");
  }

//OP →  "+" | "-" | "*" | "/" | "&" | "|" | "<" | ">" | "=="
  static final public Operation Op() throws ParseException {
 Operation result = null;
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case SOMA:
      jj_consume_token(SOMA);
                result = new Operation("+");
      break;
    case SUB:
      jj_consume_token(SUB);
                 result = new Operation("-");
      break;
    case MULT:
      jj_consume_token(MULT);
                  result = new Operation("*");
      break;
    case DIV:
      jj_consume_token(DIV);
                 result = new Operation("/");
      break;
    case AND:
      jj_consume_token(AND);
                 result = new Operation("&");
      break;
    case OR:
      jj_consume_token(OR);
                result = new Operation("|");
      break;
    case MENOR:
      jj_consume_token(MENOR);
                   result = new Operation("<");
      break;
    case MENORIGUAL:
      jj_consume_token(MENORIGUAL);
                        result = new Operation("<=");
      break;
    case MAIORIGUAL:
      jj_consume_token(MAIORIGUAL);
                        result = new Operation(">=");
      break;
    case MAIOR:
      jj_consume_token(MAIOR);
                   result = new Operation(">");
      break;
    case IGUAL:
      jj_consume_token(IGUAL);
                   result = new Operation("==");
      break;
    default:
      jj_la1[12] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
     {if (true) return result;}
    throw new Error("Missing return statement in function");
  }

//LISTAEXP → EXP | LISTAEXP "," EXP
  static final public ExpressionList ListaExp() throws ParseException {
 Expression e = null; ArrayList<Expression> lista = new ArrayList();
    e = Exp();
             lista.add(e);
    label_3:
    while (true) {
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case VIRGULA:
        ;
        break;
      default:
        jj_la1[13] = jj_gen;
        break label_3;
      }
      jj_consume_token(VIRGULA);
      e = Exp();
                                                lista.add(e);
    }
     {if (true) return new ExpressionList(lista);}
    throw new Error("Missing return statement in function");
  }

//FUNC → FUNC "func" TIPO TOKEN_id "(" LISTAARG? ")" "{" VARDECL SEQCOMANDOS "}"
//        | "func" TIPO TOKEN_id "(" LISTAARG? ")" "{" VARDECL SEQCOMANDOS "}"
  static final public FunctionList Func() throws ParseException {
 TipoDeVar tipoDeVar = null; ListaArgumentos la = null; ArrayList<FunctionDefinition> funcoes = new ArrayList();
ArrayList<VariableDeclaration> variableDeclaration = null; CommandSequence commandSequence = null;
Token t = null; TokenId tokenId = null;
    label_4:
    while (true) {
      jj_consume_token(FUNC);
      tipoDeVar = Tipo();
      t = jj_consume_token(ID);
      jj_consume_token(APARENTESES);
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case INTEIRO:
      case BOOLEANO:
        la = ListaArg();
        break;
      default:
        jj_la1[14] = jj_gen;
        ;
      }
      jj_consume_token(FPARENTESES);
      jj_consume_token(ACHAVES);
      variableDeclaration = Vardecl();
      commandSequence = SeqComandos();
      jj_consume_token(FCHAVES);
                                                                                                                                                                  funcoes.add(new FunctionDefinition(new TokenId(t.image), tipoDeVar, la, variableDeclaration, commandSequence));
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case FUNC:
        ;
        break;
      default:
        jj_la1[15] = jj_gen;
        break label_4;
      }
    }
     {if (true) return new FunctionList(funcoes);}
    throw new Error("Missing return statement in function");
  }

//LISTAARG → TIPO TOKEN_id | LISTAARG "," TIPO TOKEN_id
  static final public ListaArgumentos ListaArg() throws ParseException {
 Token t = null; TipoDeVar tipoDeVar = null; TokenId tokenId = null;
ListaArgumentos la = null; Argument arg = null; ArrayList<Argument> args = new ArrayList();
    tipoDeVar = Tipo();
    t = jj_consume_token(ID);
                             args.add(new Argument(new TokenId(t.image), tipoDeVar));
    label_5:
    while (true) {
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case VIRGULA:
        ;
        break;
      default:
        jj_la1[16] = jj_gen;
        break label_5;
      }
      jj_consume_token(VIRGULA);
      tipoDeVar = Tipo();
      t = jj_consume_token(ID);
                                                                                                                           args.add(new Argument(new TokenId(t.image), tipoDeVar));
    }
     {if (true) return new ListaArgumentos(args);}
    throw new Error("Missing return statement in function");
  }

  static private boolean jj_initialized_once = false;
  /** Generated Token Manager. */
  static public KarloffTokenManager token_source;
  static SimpleCharStream jj_input_stream;
  /** Current token. */
  static public Token token;
  /** Next token. */
  static public Token jj_nt;
  static private int jj_ntk;
  static private int jj_gen;
  static final private int[] jj_la1 = new int[17];
  static private int[] jj_la1_0;
  static private int[] jj_la1_1;
  static {
      jj_la1_init_0();
      jj_la1_init_1();
   }
   private static void jj_la1_init_0() {
      jj_la1_0 = new int[] {0x0,0x800,0x6000,0x6d0000,0x6d0000,0x3000200,0x8200,0x3800200,0x3000200,0x3000000,0x3000200,0x200,0xfc000000,0x0,0x6000,0x0,0x0,};
   }
   private static void jj_la1_init_1() {
      jj_la1_1 = new int[] {0x40,0x0,0x0,0x100,0x100,0x180,0x0,0x180,0x180,0x180,0x180,0x0,0x1f,0x20,0x0,0x40,0x20,};
   }

  /** Constructor with InputStream. */
  public Karloff(java.io.InputStream stream) {
     this(stream, null);
  }
  /** Constructor with InputStream and supplied encoding */
  public Karloff(java.io.InputStream stream, String encoding) {
    if (jj_initialized_once) {
      System.out.println("ERROR: Second call to constructor of static parser.  ");
      System.out.println("       You must either use ReInit() or set the JavaCC option STATIC to false");
      System.out.println("       during parser generation.");
      throw new Error();
    }
    jj_initialized_once = true;
    try { jj_input_stream = new SimpleCharStream(stream, encoding, 1, 1); } catch(java.io.UnsupportedEncodingException e) { throw new RuntimeException(e); }
    token_source = new KarloffTokenManager(jj_input_stream);
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 17; i++) jj_la1[i] = -1;
  }

  /** Reinitialise. */
  static public void ReInit(java.io.InputStream stream) {
     ReInit(stream, null);
  }
  /** Reinitialise. */
  static public void ReInit(java.io.InputStream stream, String encoding) {
    try { jj_input_stream.ReInit(stream, encoding, 1, 1); } catch(java.io.UnsupportedEncodingException e) { throw new RuntimeException(e); }
    token_source.ReInit(jj_input_stream);
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 17; i++) jj_la1[i] = -1;
  }

  /** Constructor. */
  public Karloff(java.io.Reader stream) {
    if (jj_initialized_once) {
      System.out.println("ERROR: Second call to constructor of static parser. ");
      System.out.println("       You must either use ReInit() or set the JavaCC option STATIC to false");
      System.out.println("       during parser generation.");
      throw new Error();
    }
    jj_initialized_once = true;
    jj_input_stream = new SimpleCharStream(stream, 1, 1);
    token_source = new KarloffTokenManager(jj_input_stream);
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 17; i++) jj_la1[i] = -1;
  }

  /** Reinitialise. */
  static public void ReInit(java.io.Reader stream) {
    jj_input_stream.ReInit(stream, 1, 1);
    token_source.ReInit(jj_input_stream);
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 17; i++) jj_la1[i] = -1;
  }

  /** Constructor with generated Token Manager. */
  public Karloff(KarloffTokenManager tm) {
    if (jj_initialized_once) {
      System.out.println("ERROR: Second call to constructor of static parser. ");
      System.out.println("       You must either use ReInit() or set the JavaCC option STATIC to false");
      System.out.println("       during parser generation.");
      throw new Error();
    }
    jj_initialized_once = true;
    token_source = tm;
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 17; i++) jj_la1[i] = -1;
  }

  /** Reinitialise. */
  public void ReInit(KarloffTokenManager tm) {
    token_source = tm;
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 17; i++) jj_la1[i] = -1;
  }

  static private Token jj_consume_token(int kind) throws ParseException {
    Token oldToken;
    if ((oldToken = token).next != null) token = token.next;
    else token = token.next = token_source.getNextToken();
    jj_ntk = -1;
    if (token.kind == kind) {
      jj_gen++;
      return token;
    }
    token = oldToken;
    jj_kind = kind;
    throw generateParseException();
  }


/** Get the next Token. */
  static final public Token getNextToken() {
    if (token.next != null) token = token.next;
    else token = token.next = token_source.getNextToken();
    jj_ntk = -1;
    jj_gen++;
    return token;
  }

/** Get the specific Token. */
  static final public Token getToken(int index) {
    Token t = token;
    for (int i = 0; i < index; i++) {
      if (t.next != null) t = t.next;
      else t = t.next = token_source.getNextToken();
    }
    return t;
  }

  static private int jj_ntk() {
    if ((jj_nt=token.next) == null)
      return (jj_ntk = (token.next=token_source.getNextToken()).kind);
    else
      return (jj_ntk = jj_nt.kind);
  }

  static private java.util.List<int[]> jj_expentries = new java.util.ArrayList<int[]>();
  static private int[] jj_expentry;
  static private int jj_kind = -1;

  /** Generate ParseException. */
  static public ParseException generateParseException() {
    jj_expentries.clear();
    boolean[] la1tokens = new boolean[41];
    if (jj_kind >= 0) {
      la1tokens[jj_kind] = true;
      jj_kind = -1;
    }
    for (int i = 0; i < 17; i++) {
      if (jj_la1[i] == jj_gen) {
        for (int j = 0; j < 32; j++) {
          if ((jj_la1_0[i] & (1<<j)) != 0) {
            la1tokens[j] = true;
          }
          if ((jj_la1_1[i] & (1<<j)) != 0) {
            la1tokens[32+j] = true;
          }
        }
      }
    }
    for (int i = 0; i < 41; i++) {
      if (la1tokens[i]) {
        jj_expentry = new int[1];
        jj_expentry[0] = i;
        jj_expentries.add(jj_expentry);
      }
    }
    int[][] exptokseq = new int[jj_expentries.size()][];
    for (int i = 0; i < jj_expentries.size(); i++) {
      exptokseq[i] = jj_expentries.get(i);
    }
    return new ParseException(token, exptokseq, tokenImage);
  }

  /** Enable tracing. */
  static final public void enable_tracing() {
  }

  /** Disable tracing. */
  static final public void disable_tracing() {
  }

}
