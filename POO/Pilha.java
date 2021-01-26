public class Pilha extends Lista{

	private int contador;
    
    public Pilha(int tamanho) {
        super(tamanho);
    }

     public int push (Nodo n){
        insert(contador, n);
        contador++;
        return 1;
    }
     public int pop () {
        delete (contador - 1);
        contador--;
        setTamanho(contador);
        return 1;
    }
}

