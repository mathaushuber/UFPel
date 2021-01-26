public class Orc extends Personagem {
    protected int forca;
    protected int habilidade;
    protected int agilidade;

    public Orc (String name, int forca, int habilidade, int agilidade) {
        super(name);
        this.forca = forca;
        this.habilidade = habilidade;
        this.agilidade = agilidade;
    }

    public int getPrimeiroAtributo() {
        return this.forca;
    }
    
    public int getSegundoAtributo() {
        return this.habilidade;
    }

    public int getTerceiroAtributo() {
        return this.agilidade;
    }
}