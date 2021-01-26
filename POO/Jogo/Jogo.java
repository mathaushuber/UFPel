import java.util.ArrayList;
import java.util.Random;
import java.lang.Math; 

public class Jogo {    

    public static void main(String[] args) {
        ArrayList<Personagem> humanos = iniciaVetorHumanos();
        ArrayList<Personagem> orcs = iniciaVetorOrcs();

        combateGeral(humanos, orcs);
        
        exibeCombate(orcs, humanos);
    }

    private static ArrayList<Personagem> iniciaVetorHumanos () {
        ArrayList<Personagem> humanos = new ArrayList<Personagem>();

        for (int i = 0; i < 100; i++) {
            humanos.add(criaHumano());
        }

        return humanos;
    }

    private static ArrayList<Personagem> iniciaVetorOrcs () {
        ArrayList<Personagem> orcs = new ArrayList<Personagem>();

        for (int i = 0; i < 100; i++) {
            orcs.add(criaOrc());
        }

        return orcs;
    }

    private static void exibeCombate (ArrayList<Personagem> Orcs, ArrayList<Personagem> Humanos) {
        int total_vida_orcs = 0, total_vida_humanos = 0, result_combate_human = 0, result_combate_orc = 0;

        for (int i = 0; i < 100; i++) {
            System.out.println( "Combate " + (i + 1) + ":");

            System.out.println("Orc: " + Orcs.get(i).toString());
            System.out.println("Humano: " + Humanos.get(i).toString());
            
            if (Humanos.get(i).pontos_vida > Orcs.get(i).pontos_vida) { 
            	result_combate_human+= 1; 
            	System.out.println("Humano venceu!\n");
            	}
            if (Orcs.get(i).pontos_vida > Humanos.get(i).pontos_vida) {
            	result_combate_orc += 1;
            	System.out.println("Orc venceu!\n");
            	}
            if (Humanos.get(i).pontos_vida == Orcs.get(i).pontos_vida) System.out.println("Empate!\n");
        
            total_vida_orcs += Orcs.get(i).pontos_vida;
            total_vida_humanos += Humanos.get(i).pontos_vida;
        }

        System.out.println("Resultado final:");
        System.out.println(
            "Total de vida Humanos: " + total_vida_humanos + "\n" +
            "Total de vida Orcs: " + total_vida_orcs + "\n" +
            "Batalhas vencidas pelos humanos: " + result_combate_human + "\n" +
            "Batalhas vencidas pelos orcs: " + result_combate_orc
            );

        if (result_combate_human > result_combate_orc) System.out.println("Humanos venceram!\n");
        if (result_combate_human < result_combate_orc) System.out.println("Orcs venceram!\n");
        if (result_combate_human == result_combate_orc) System.out.println("Empate!\n");
    }    
    
    private static Personagem criaHumano () {
        int numeroAleatorio = geraNumeroAleatorio();

        if (numeroAleatorio == 0) return new Arqueiro();
        if (numeroAleatorio == 1) return new Soldado();
        
        return new Robo();
    }    

    private static Personagem criaOrc () {
        int numeroAleatorio = geraNumeroAleatorio();

        if (numeroAleatorio == 0) return new Ogro();
        if (numeroAleatorio == 1) return new Mago();
        
        return new Demonio();
    }
 
    private static int geraNumeroAleatorio () {
        Random random = new Random();

        return random.nextInt(3);
    }

    private static void combateGeral(ArrayList<Personagem> humanos, ArrayList<Personagem> orcs) {
        int diferenca_vida;
        
        for (int i = 0; i < 100; i++) {
            diferenca_vida = humanos.get(i).compareTo(orcs.get(i));

            if (diferenca_vida > 0) {
                humanos.get(i).ganhaVida(diferenca_vida);
                orcs.get(i).perdeVida(diferenca_vida);
            }

            if (diferenca_vida < 0) {
                humanos.get(i).perdeVida(Math.abs(diferenca_vida));
                orcs.get(i).ganhaVida(Math.abs(diferenca_vida));
            }
        }
    }
}