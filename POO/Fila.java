public class Fila extends Lista{
 
	private int contador;
    
    public Fila(int tamanho) {
        super(tamanho);
    }

    public int enqueue(Nodo n) { 
        insert(contador, n);
        contador++;
        return 1;
    }
    public int dequeue() {   
        delete (0);
        contador--;
        setTamanho(contador);
        return 1;
    }
}
