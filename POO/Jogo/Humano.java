public class Humano extends Personagem {
    protected int inteligencia;
    protected int velocidade;
    protected int equipamentos;

    public Humano (String name, int inteligencia, int velocidade, int equipamentos) {
        super(name);
        this.inteligencia = inteligencia;
        this.velocidade = velocidade;
        this.equipamentos = equipamentos;
    }
    public int getPrimeiroAtributo() {
        return this.inteligencia;
    }
    
    public int getSegundoAtributo() {
        return this.velocidade;
    }

    public int getTerceiroAtributo() {
        return this.equipamentos;
    }
}