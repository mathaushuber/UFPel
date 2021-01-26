import java.util.Vector;

public class Lista {
	
    private int tamanho;               
    private int contador = 0;         


    public Lista(int tamanho) {
        this.tamanho = tamanho;
    }

    public int getTamanho(){
        return tamanho;
    }

    public void setTamanho(int tamanho) {
        this.tamanho = tamanho;
    }

    public Vector<Nodo> getElementos() {
        return elementos;
    }

    public void setElementos(Vector<Nodo> elementos) {
        this.elementos = elementos;
    }

    private Vector<Nodo> elementos = new Vector<Nodo>(getTamanho());

    public int insert (int posicao, Nodo n) {   
        if (posicao <= this.tamanho){
            elementos.add(n);
            contador++;
            return 1;
        }else{
            return 0;
        }
    }

    public int get (int posicao) {             
        return elementos.get(posicao).getIdade();
    }

    public int delete (int posicao) {
       if(posicao <= this.tamanho) {
           elementos.remove(posicao);
           return 1;
       }
       return 0;
    }

     public int length () {
        return contador;
     }

    public void printLista (){
        for (int i = 0; i < getTamanho(); i++){
            System.out.println(elementos.get(i).getIdade());
        }
    }
}