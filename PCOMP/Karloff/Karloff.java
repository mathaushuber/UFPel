/* Generated By:JavaCC: Do not edit this line. Karloff.java */
import java.io.*;

public class Karloff implements KarloffConstants {

  public static void main(String args[]) throws ParseException, IOException {
    Karloff analisador = new Karloff(new FileInputStream(args[0]));
    analisador.Karloff();
  }

  static final public void Karloff() throws ParseException {
    Main();
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case FUNC:
      Func();
      break;
    default:
      jj_la1[0] = jj_gen;
      ;
    }
    jj_consume_token(0);
  }

  static final public void Main() throws ParseException {
    jj_consume_token(VOID);
    jj_consume_token(MAIN);
    jj_consume_token(APARENTESES);
    jj_consume_token(FPARENTESES);
    jj_consume_token(ACHAVES);
    VarDecl();
    SeqComandos();
    jj_consume_token(FCHAVES);
  }

  static final public void VarDecl() throws ParseException {
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
      Tipo();
      jj_consume_token(ID);
      jj_consume_token(SEMICOLON);
    }
  }

  static final public void Tipo() throws ParseException {
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case INTEGER:
      jj_consume_token(INTEGER);
      break;
    case BOOLEAN:
      jj_consume_token(BOOLEAN);
      break;
    default:
      jj_la1[2] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
  }

  static final public void SeqComandos() throws ParseException {
    label_2:
    while (true) {
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case CIF:
      case CWHILE:
      case CREPEAT:
      case CRETURN:
      case CSOUT:
      case ID:
        ;
        break;
      default:
        jj_la1[3] = jj_gen;
        break label_2;
      }
      Comando();
    }
  }

  static final public void Comando() throws ParseException {
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case ID:
      VarAtrib();
      jj_consume_token(SEMICOLON);
      break;
      FuncChamada();
      jj_consume_token(SEMICOLON);
      break;
    case CIF:
      jj_consume_token(CIF);
      jj_consume_token(APARENTESES);
      Exp();
      jj_consume_token(FPARENTESES);
      jj_consume_token(CTHEN);
      jj_consume_token(ACHAVES);
      SeqComandos();
      jj_consume_token(FCHAVES);
      jj_consume_token(SEMICOLON);
      break;
    case CWHILE:
      jj_consume_token(CWHILE);
      jj_consume_token(APARENTESES);
      Exp();
      jj_consume_token(FPARENTESES);
      jj_consume_token(ACHAVES);
      SeqComandos();
      jj_consume_token(FCHAVES);
      jj_consume_token(SEMICOLON);
      break;
    case CREPEAT:
      jj_consume_token(CREPEAT);
      jj_consume_token(ACHAVES);
      SeqComandos();
      jj_consume_token(FCHAVES);
      jj_consume_token(CUNTIL);
      jj_consume_token(APARENTESES);
      Exp();
      jj_consume_token(FPARENTESES);
      jj_consume_token(SEMICOLON);
      break;
    case CRETURN:
      jj_consume_token(CRETURN);
      Exp();
      jj_consume_token(SEMICOLON);
      break;
    case CSOUT:
      jj_consume_token(CSOUT);
      jj_consume_token(APARENTESES);
      Exp();
      jj_consume_token(FPARENTESES);
      jj_consume_token(SEMICOLON);
      break;
      VarAtribSintetico();
      jj_consume_token(SEMICOLON);
      break;
    default:
      jj_la1[4] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
  }

  static final public void VarAtrib() throws ParseException {
    jj_consume_token(ID);
    jj_consume_token(CATRIB);
    Exp();
    if (jj_2_1(2)) {
      jj_consume_token(ID);
      jj_consume_token(CATRIB);
      Exp();
    } else {
      ;
    }
  }

  static final public void FuncChamada() throws ParseException {
    jj_consume_token(ID);
    jj_consume_token(APARENTESES);
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case APARENTESES:
    case OPNOT:
    case TRUE:
    case FALSE:
    case STRING:
    case NUM:
    case ID:
      ListaExp();
      break;
    default:
      jj_la1[5] = jj_gen;
      ;
    }
    jj_consume_token(FPARENTESES);
  }

  static final public void VarAtribSintetico() throws ParseException {
    jj_consume_token(ID);
    jj_consume_token(CATRIB);
    jj_consume_token(CSRINT);
    jj_consume_token(APARENTESES);
    jj_consume_token(FPARENTESES);
  }

  static final public void Exp() throws ParseException {
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case APARENTESES:
      jj_consume_token(APARENTESES);
      Exp();
      Op();
      Exp();
      jj_consume_token(FPARENTESES);
      break;
    case OPNOT:
    case TRUE:
    case FALSE:
    case STRING:
    case NUM:
    case ID:
      Fator();
      break;
    default:
      jj_la1[6] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
  }

  static final public void Fator() throws ParseException {
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case ID:
      jj_consume_token(ID);
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case APARENTESES:
        jj_consume_token(APARENTESES);
        switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
        case APARENTESES:
        case OPNOT:
        case TRUE:
        case FALSE:
        case STRING:
        case NUM:
        case ID:
          ListaExp();
          break;
        default:
          jj_la1[7] = jj_gen;
          ;
        }
        jj_consume_token(FPARENTESES);
        break;
      default:
        jj_la1[8] = jj_gen;
        ;
      }
      break;
    case NUM:
      jj_consume_token(NUM);
      break;
    case TRUE:
      jj_consume_token(TRUE);
      break;
    case FALSE:
      jj_consume_token(FALSE);
      break;
    case STRING:
      jj_consume_token(STRING);
      break;
    case OPNOT:
      jj_consume_token(OPNOT);
      Fator();
      break;
    default:
      jj_la1[9] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
  }

  static final public void Op() throws ParseException {
    switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
    case OPADD:
      jj_consume_token(OPADD);
      break;
    case OPSUB:
      jj_consume_token(OPSUB);
      break;
    case OPMULT:
      jj_consume_token(OPMULT);
      break;
    case OPDIV:
      jj_consume_token(OPDIV);
      break;
    case OPAND:
      jj_consume_token(OPAND);
      break;
    case OPOR:
      jj_consume_token(OPOR);
      break;
    case OPLESSTHAN:
      jj_consume_token(OPLESSTHAN);
      break;
    case OPGREATERTHAN:
      jj_consume_token(OPGREATERTHAN);
      break;
    case OPEQUAL:
      jj_consume_token(OPEQUAL);
      break;
    default:
      jj_la1[10] = jj_gen;
      jj_consume_token(-1);
      throw new ParseException();
    }
  }

  static final public void ListaExp() throws ParseException {
    Exp();
    label_3:
    while (true) {
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case SEMICOLON:
        ;
        break;
      default:
        jj_la1[11] = jj_gen;
        break label_3;
      }
      jj_consume_token(SEMICOLON);
      Exp();
    }
  }

  static final public void Func() throws ParseException {
    label_4:
    while (true) {
      jj_consume_token(FUNC);
      Tipo();
      jj_consume_token(ID);
      jj_consume_token(APARENTESES);
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case INTEGER:
      case BOOLEAN:
        ListaArg();
        break;
      default:
        jj_la1[12] = jj_gen;
        ;
      }
      jj_consume_token(FPARENTESES);
      jj_consume_token(ACHAVES);
      VarDecl();
      SeqComandos();
      jj_consume_token(FCHAVES);
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case FUNC:
        ;
        break;
      default:
        jj_la1[13] = jj_gen;
        break label_4;
      }
    }
  }

  static final public void ListaArg() throws ParseException {
    Tipo();
    jj_consume_token(ID);
    label_5:
    while (true) {
      switch ((jj_ntk==-1)?jj_ntk():jj_ntk) {
      case SEMICOLON:
        ;
        break;
      default:
        jj_la1[14] = jj_gen;
        break label_5;
      }
      jj_consume_token(SEMICOLON);
      Tipo();
      jj_consume_token(ID);
    }
  }

  static private boolean jj_2_1(int xla) {
    jj_la = xla; jj_lastpos = jj_scanpos = token;
    try { return !jj_3_1(); }
    catch(LookaheadSuccess ls) { return true; }
    finally { jj_save(0, xla); }
  }

  static private boolean jj_3_1() {
    if (jj_scan_token(ID)) return true;
    if (jj_scan_token(CATRIB)) return true;
    return false;
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
  static private Token jj_scanpos, jj_lastpos;
  static private int jj_la;
  static private int jj_gen;
  static final private int[] jj_la1 = new int[15];
  static private int[] jj_la1_0;
  static private int[] jj_la1_1;
  static {
      jj_la1_init_0();
      jj_la1_init_1();
   }
   private static void jj_la1_init_0() {
      jj_la1_0 = new int[] {0x100,0x80,0x600,0x2b40000,0x2b40000,0x2000,0x2000,0x2000,0x2000,0x0,0xf8000000,0x20000,0x600,0x100,0x20000,};
   }
   private static void jj_la1_init_1() {
      jj_la1_1 = new int[] {0x0,0x0,0x0,0x200,0x200,0x3f0,0x3f0,0x3f0,0x0,0x3f0,0xf,0x0,0x0,0x0,0x0,};
   }
  static final private JJCalls[] jj_2_rtns = new JJCalls[1];
  static private boolean jj_rescan = false;
  static private int jj_gc = 0;

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
    for (int i = 0; i < 15; i++) jj_la1[i] = -1;
    for (int i = 0; i < jj_2_rtns.length; i++) jj_2_rtns[i] = new JJCalls();
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
    for (int i = 0; i < 15; i++) jj_la1[i] = -1;
    for (int i = 0; i < jj_2_rtns.length; i++) jj_2_rtns[i] = new JJCalls();
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
    for (int i = 0; i < 15; i++) jj_la1[i] = -1;
    for (int i = 0; i < jj_2_rtns.length; i++) jj_2_rtns[i] = new JJCalls();
  }

  /** Reinitialise. */
  static public void ReInit(java.io.Reader stream) {
    jj_input_stream.ReInit(stream, 1, 1);
    token_source.ReInit(jj_input_stream);
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 15; i++) jj_la1[i] = -1;
    for (int i = 0; i < jj_2_rtns.length; i++) jj_2_rtns[i] = new JJCalls();
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
    for (int i = 0; i < 15; i++) jj_la1[i] = -1;
    for (int i = 0; i < jj_2_rtns.length; i++) jj_2_rtns[i] = new JJCalls();
  }

  /** Reinitialise. */
  public void ReInit(KarloffTokenManager tm) {
    token_source = tm;
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 15; i++) jj_la1[i] = -1;
    for (int i = 0; i < jj_2_rtns.length; i++) jj_2_rtns[i] = new JJCalls();
  }

  static private Token jj_consume_token(int kind) throws ParseException {
    Token oldToken;
    if ((oldToken = token).next != null) token = token.next;
    else token = token.next = token_source.getNextToken();
    jj_ntk = -1;
    if (token.kind == kind) {
      jj_gen++;
      if (++jj_gc > 100) {
        jj_gc = 0;
        for (int i = 0; i < jj_2_rtns.length; i++) {
          JJCalls c = jj_2_rtns[i];
          while (c != null) {
            if (c.gen < jj_gen) c.first = null;
            c = c.next;
          }
        }
      }
      return token;
    }
    token = oldToken;
    jj_kind = kind;
    throw generateParseException();
  }

  static private final class LookaheadSuccess extends java.lang.Error { }
  static final private LookaheadSuccess jj_ls = new LookaheadSuccess();
  static private boolean jj_scan_token(int kind) {
    if (jj_scanpos == jj_lastpos) {
      jj_la--;
      if (jj_scanpos.next == null) {
        jj_lastpos = jj_scanpos = jj_scanpos.next = token_source.getNextToken();
      } else {
        jj_lastpos = jj_scanpos = jj_scanpos.next;
      }
    } else {
      jj_scanpos = jj_scanpos.next;
    }
    if (jj_rescan) {
      int i = 0; Token tok = token;
      while (tok != null && tok != jj_scanpos) { i++; tok = tok.next; }
      if (tok != null) jj_add_error_token(kind, i);
    }
    if (jj_scanpos.kind != kind) return true;
    if (jj_la == 0 && jj_scanpos == jj_lastpos) throw jj_ls;
    return false;
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
  static private int[] jj_lasttokens = new int[100];
  static private int jj_endpos;

  static private void jj_add_error_token(int kind, int pos) {
    if (pos >= 100) return;
    if (pos == jj_endpos + 1) {
      jj_lasttokens[jj_endpos++] = kind;
    } else if (jj_endpos != 0) {
      jj_expentry = new int[jj_endpos];
      for (int i = 0; i < jj_endpos; i++) {
        jj_expentry[i] = jj_lasttokens[i];
      }
      boolean exists = false;
      for (java.util.Iterator<?> it = jj_expentries.iterator(); it.hasNext();) {
        exists = true;
        int[] oldentry = (int[])(it.next());
        if (oldentry.length == jj_expentry.length) {
          for (int i = 0; i < jj_expentry.length; i++) {
            if (oldentry[i] != jj_expentry[i]) {
              exists = false;
              break;
            }
          }
          if (exists) break;
        }
      }
      if (!exists) jj_expentries.add(jj_expentry);
      if (pos != 0) jj_lasttokens[(jj_endpos = pos) - 1] = kind;
    }
  }

  /** Generate ParseException. */
  static public ParseException generateParseException() {
    jj_expentries.clear();
    boolean[] la1tokens = new boolean[42];
    if (jj_kind >= 0) {
      la1tokens[jj_kind] = true;
      jj_kind = -1;
    }
    for (int i = 0; i < 15; i++) {
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
    for (int i = 0; i < 42; i++) {
      if (la1tokens[i]) {
        jj_expentry = new int[1];
        jj_expentry[0] = i;
        jj_expentries.add(jj_expentry);
      }
    }
    jj_endpos = 0;
    jj_rescan_token();
    jj_add_error_token(0, 0);
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

  static private void jj_rescan_token() {
    jj_rescan = true;
    for (int i = 0; i < 1; i++) {
    try {
      JJCalls p = jj_2_rtns[i];
      do {
        if (p.gen > jj_gen) {
          jj_la = p.arg; jj_lastpos = jj_scanpos = p.first;
          switch (i) {
            case 0: jj_3_1(); break;
          }
        }
        p = p.next;
      } while (p != null);
      } catch(LookaheadSuccess ls) { }
    }
    jj_rescan = false;
  }

  static private void jj_save(int index, int xla) {
    JJCalls p = jj_2_rtns[index];
    while (p.gen > jj_gen) {
      if (p.next == null) { p = p.next = new JJCalls(); break; }
      p = p.next;
    }
    p.gen = jj_gen + xla - jj_la; p.first = token; p.arg = xla;
  }

  static final class JJCalls {
    int gen;
    Token first;
    int arg;
    JJCalls next;
  }

}
