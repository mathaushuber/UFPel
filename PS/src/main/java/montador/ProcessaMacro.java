package montador;


import java.io.*;
import java.util.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;

class ProcessaMacro {


    private int contadorMacroNivel = 0;
    private int contadorNinho = 0;

    private Map<String,Macro> macros;
    private final String input;
    private BufferedReader bf;
    private FileWriter arqSaida;

    // Construtor
    public ProcessaMacro(String input, String output) throws FileNotFoundException, IOException{
        this.input = input;
        this.macros = new HashMap<String, Macro>();
        this.bf = new BufferedReader(new FileReader(new String(System.getProperty("user.dir")+"/src/main/java/arquivos_txt/" + input + ".txt")));
        this.arqSaida = new FileWriter(new String(System.getProperty("user.dir")+"/src/main/java/arquivos_txt/" + output+ ".txt"));
        // stringParametrosFormais[0] = "";
    }

    // Processa a macro
    public void processa() throws FileNotFoundException, IOException {  // Passa para um string linha por linha do buffer 
                                                                        // e pede para o método redLine analisar
        String line = this.readLine("", true) ;
        while (line != null){

            line = line.trim(); // Retira espaços vazios
            line = line.replaceAll(";;.*", "");
            line = this.readLine(line, true);
        }
        this.arqSaida.close(); //encerra escrita de output

    }
    
    public void defineMacro(String line, String[] words) throws FileNotFoundException, IOException{ 
        Macro macro = new Macro();
        this.macros.put(words[0], macro);

        macro.setNinho(this.contadorNinho);
        macro.setNivel(this.contadorMacroNivel);

        macro.setParametrosFormais(line);
        line = this.readLine("", false);
        line = line.trim();
        while(!line.contains("ENDM")){
            if(line.contains("MACRO")){ // Pausa definição de macro para começar outra
                contadorMacroNivel++;
                line = this.readLine(line, false);
                line = line.trim();
            }
            else{
                macro.addInstrucao(line);
                line = this.readLine(line, false);
                line = line.trim();
            } 
        }
        contadorNinho++;
        contadorMacroNivel = 0;
    }

    public void expandMacro(Macro macro, String line, String[] words)throws FileNotFoundException, IOException{
        
        Map<String, Macro> newMap =  macros;
        macro.setParametrosReais(line);
        ArrayList<String> instrucoes = macro.getInstrucoes(line, newMap); // Pega instruções da macro expandida com os parametros formais trocados pelos parametros reais
        for(int i = 0; i<instrucoes.size();i++){
            arqSaida.write(instrucoes.get(i) + "\n");
        }  
    }

    public boolean isMacroCall(String line, String[] palavras)throws FileNotFoundException, IOException{
        boolean chamada = false;
        Macro macro;
        Iterator iterator = this.macros.entrySet().iterator();
        while (iterator.hasNext()) {                        // Percorre hashMap procurando macro
            Map.Entry macrosIterator = (Map.Entry) iterator.next();
            if(line.contains(macrosIterator.getKey().toString())){
                chamada = true;
                macro = this.macros.get(macrosIterator.getKey());
                this.expandMacro(macro, line, palavras);
            }
        }
        return chamada;
    }

    public String readLine(String line, boolean write) throws FileNotFoundException, IOException{ // Analisa cada linha a procura de MACRO e CHAMADA
        String[] palavras = line.split("\\s+");
        if(line.contains("MACRO")){
            this.defineMacro(line, palavras);
        }else{
            if(!this.isMacroCall(line, palavras) && write){ // Se não houver chamada, escreve linha
                arqSaida.write(line + "\n");
            };
        }
        return this.bf.readLine();
    }
}
