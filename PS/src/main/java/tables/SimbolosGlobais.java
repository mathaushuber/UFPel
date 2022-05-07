/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tables;


public class SimbolosGlobais {
    
    private String value;
    private boolean relocable; // Para constante false (valor absoluto) para outros simbolos true (relocável)

    public SimbolosGlobais(){
        
    }
    public SimbolosGlobais(String value, boolean relocable){
        
        this.value = value;
        this.relocable = relocable;
    }

    public void setRelocabilidade(boolean relocable) {
        this.relocable = relocable;
    }

    public void setValue(String value) {
        
            this.value = value;
       
    }

    public boolean getRelocabilidade() {
        return relocable;
    }

    public String getValue() {
        return value;
    }   
}
