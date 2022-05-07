package montador;


import java.util.*;


 class Macro {

    private String[] parametrosFormais; 
    private String[] parametrosReais; 
    private ArrayList<String> instrucoes;
    private final String registers = "DX,AX,DS";
    private int ninho;
    private int nivel;
    String oldParametrosReais = ""; 
    String oldParametrosFormais = "";

    
    public Macro(){
        this.instrucoes = new ArrayList<>();
    }

    public void addInstrucao(String linha){
        this.instrucoes.add(linha);
    }
    
    public void setParametrosFormais(String line){ 
        String[] words = line.replaceAll(","," ").split("\\s+");
        this.parametrosFormais = Arrays.copyOfRange(words, 2, words.length);
    }

    public String getParametrosFormais(){
        String parametrosFormais = "";
        for(int i = 0; i < this.parametrosFormais.length; i++){
            parametrosFormais = parametrosFormais + this.parametrosFormais[i] + ";";
        }
        return parametrosFormais;
    }

    public void setParametrosReais(String line){ 
        String[] words = line.replaceAll(","," ").split("\\s+");
        this.parametrosReais = Arrays.copyOfRange(words, 1, words.length);
    }

    public String getParametrosReais(){
        String parametrosReais = "";
        for(int i = 0; i < this.parametrosReais.length; i++){
            parametrosReais = parametrosReais + this.parametrosReais[i] + ";";
        }
        return parametrosReais;
    }
    
    public ArrayList<String> getInstrucoes(String callInstruction, Map<String, Macro> newMap){ // Substitui parâmetros formais pelos reais
        String[] words = callInstruction.replaceAll(","," ").split("\\s+");
        String[] parametrosReais = Arrays.copyOfRange(words, 1, words.length);
        ArrayList<String> ins = new ArrayList<>(this.instrucoes);
        
        for(int i=0; i<this.instrucoes.size(); i++){ // Percorre cada instrução da macro

            
            String[] instNoComma = ins.get(i).replaceAll(","," ").split("\\s+");
            String vars[] = Arrays.copyOfRange(instNoComma, 1, instNoComma.length);

            for(int j=0; j<vars.length; j++){ // Percorre cada variavel da instrução

                if(registers.contains(vars[j])){} //Se a variável é um registrador, pula.
                
                else{
                    boolean flagParametrosReal = false;
                    for(int k=0; k<parametrosFormais.length; k++){ // Percorre cada parametro formal
                        if(vars[j].equals(this.parametrosFormais[k])){
                            
                            ins.set(i, ins.get(i).replaceAll("(?<=[\\s,]|^)"+this.parametrosFormais[k]+"(?=[\\s,]|$)", parametrosReais[k]));
                            flagParametrosReal = true;
                        }
                    }
                    if(!flagParametrosReal && nivel != 0){ // Caso o parametro formal seja de outra Macro de nivel superior

                        setOldParametros(newMap, vars[j]); 
                        if(!oldParametrosFormais.equals("")){
                            String[] wordsFormais = oldParametrosFormais.replaceAll(";"," ").split("\\s+");
                            String[] wordsReais = oldParametrosReais.replaceAll(";"," ").split("\\s+");

                            for(int l = wordsFormais.length - 1; l >= 0; l--){
                                if(vars[j].equals(wordsFormais[l])){
                                    ins.set(i, ins.get(i).replaceAll("(?<=[\\s,]|^)"+vars[j]+"(?=[\\s,]|$)", wordsReais[l]));
                                }
                            }
                        } 
                    }
                }   
            }
            
        }

        return ins;
    }
    
    public int setOldParametros(Map<String, Macro> newMap, String var){ // Percorre macros de nivel superior em busca do parametro formal e seu correspondente valor real

        int i = nivel-1;
        while(i >= 0){    // Percorre cada nível acima, um por um até encontrar o parametro formal
            for (Map.Entry<String, Macro> entry : newMap.entrySet()) { // Procura por Macros da mesma ninhada
                //String key = entry.getKey();
                Macro value = entry.getValue();
                if(value.ninho == this.ninho){
                    if(value.nivel == i){
                        String parametroFormal = "";
                        for(int j = 0; j < value.parametrosFormais.length; j++){
                            parametroFormal = value.parametrosFormais[j];
                            if(var.equals(parametroFormal)){
                                this.oldParametrosFormais = value.getParametrosFormais();
                                this.oldParametrosReais = value.getParametrosReais();
                                return 1;
                            }
                        }
                            
                    }
                }   
            }  
            i--; 
        }
        return 0;
    }

    public void setNinho(int i){
        ninho = i;
    }

    public int getNinho(){
        return ninho;
    }

    public void setNivel(int i){
        nivel = i;
    }

    public int getNivel(){
        return ninho;
    }
}