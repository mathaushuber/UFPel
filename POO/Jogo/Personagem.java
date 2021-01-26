import java.util.Random;

public abstract class Personagem  {
    protected int pontos_vida;
    protected String nome;
    
    public Personagem (String nome) {
        this.nome = nome;
        this.pontos_vida = 100;
    }

    public void perdeVida (int pontos) {
        this.pontos_vida -= pontos;
    }    
    
    public void ganhaVida (int pontos) {
        this.pontos_vida += pontos;
    }

    public abstract int getPrimeiroAtributo();
    public abstract int getSegundoAtributo();
    public abstract int getTerceiroAtributo();

    public int compareTo(Object o) {
        Personagem orc = (Personagem) o;

        Random random = new Random();
        int numeroAleatorio = random.nextInt(3);

        if (numeroAleatorio == 0) return this.getPrimeiroAtributo() - orc.getPrimeiroAtributo();
        if (numeroAleatorio == 1) return this.getSegundoAtributo() - orc.getSegundoAtributo();
        
        return this.getTerceiroAtributo() - orc.getTerceiroAtributo();
    };

    public String toString() { 
        return this.nome + "  Vida: " + this.pontos_vida;
    } 
}