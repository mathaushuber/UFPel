/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tables;

/**
 *
 * @author Gerson Menezes
 */
public class SimbolosUsados {
    String name;
    private int signal; // 0 para + e 1 para -
    private int ocorrencia;
    
    public SimbolosUsados(String name, int ocorrencia){
        this.ocorrencia = ocorrencia;
        this.name = name;
    }
   
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public int getSignal(){
        return signal;
    }
    public int getOcorrencia(){
        return ocorrencia;
    }
}
