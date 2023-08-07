// Classe base para a árvore sintática
class ArvoreSintatica{}

// Classe que representa uma expressão na árvore sintática, herda de ArvoreSintatica
class Exp extends ArvoreSintatica{}

// Classe que representa um número na árvore sintática, herda de Exp
class Num extends Exp {
    int num;

    // Construtor que inicializa o número
    Num(int num) {
        this.num = num;
    }
}

// Classe que representa um operador genérico na árvore sintática, herda de Exp
class Operador extends Exp {
    Exp arg1;
    Exp arg2;

    // Construtor que recebe as duas expressões que o operador opera
    Operador(Exp a1, Exp a2) {
        arg1 = a1;
        arg2 = a2;
    }
}

// Classe que representa a operação de soma na árvore sintática, herda de Operador
class Soma extends Operador {

    // Construtor que inicializa a operação de soma com duas expressões
    Soma(Exp a1, Exp a2) {
        super(a1, a2);
    }
}

// Classe que representa a operação de multiplicação na árvore sintática, herda de Operador
class Mult extends Operador {
    // Construtor que inicializa a operação de multiplicação com duas expressões
    Mult(Exp a1, Exp a2) {
        super(a1, a2);
    }
}

// Classe que representa a operação de subtração na árvore sintática, herda de Operador
class Sub extends Operador {
    // Construtor que inicializa a operação de subtração com duas expressões
    Sub(Exp a1, Exp a2) {
        super(a1, a2);
    }
}

// Classe que representa a operação de divisão na árvore sintática, herda de Operador
class Div extends Operador {
    // Construtor que inicializa a operação de divisão com duas expressões
    Div(Exp a1, Exp a2) {
        super(a1, a2);
    }
}
