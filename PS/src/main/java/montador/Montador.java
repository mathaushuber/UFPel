/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package montador;

import tables.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList; 
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Set;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.NoSuchElementException;



public class Montador {
    
    public  LinkedHashMap<String, SimbolosGlobais> tabelaDeSimbolosGlobais = new LinkedHashMap<String, SimbolosGlobais>();    //Linked NÃO perde a ordem que foi acrescentado    
    public  LinkedHashMap<String, SimbolosLocais> tabelaDeSimbolosLocais = new LinkedHashMap<String, SimbolosLocais>();
    public  List<SimbolosUsados> tabelaDeSimbolosUsados = new ArrayList<SimbolosUsados>();
    public List<String> instrucoes = new ArrayList<String>();
    public List<Integer> data = new ArrayList<Integer>();
    private int programCounter = 0; // Marca a posição da instrução corrente
    private int dataCounter = 0; // Marca tamanho do segmento de dados, cada variavel e const 2 bytes
    private int sizeHeader = 4;
    private final int CS = 1000;
    private final int DS = 3000;
    
    public Montador(){
        
    }
    
    public  void primeira_passagem() throws IOException {
        
        instrucoes = Arrays.asList(Tela2.ArquivoCarregado.split("\n"));
        loadInstructionToFirstPass();
        //simbolos.put("valor", new Simbolo("valor","type", true));
    }

    public  void segunda_passagem() throws IOException {
        
        instrucoes = Arrays.asList(Tela2.ArquivoCarregado.split("\n"));
        loadInstructionToSecondPass();
        //simbolos.put("nome", new Simbolo("valor","type", true));
    }
    
    public  String getSymbolValue(String opd) { 
        
        String value;
        value = tabelaDeSimbolosLocais.get(opd).getValue();
            
        return value;
    }
    
    public  void loadInstructionToFirstPass() throws IOException{  // Primeira passada (Falta resolver código dos simbolos)
        
        String codigoIntermediario = new String();
        int controlSymbolTable = 0;
        
        for (int i = 0; i< instrucoes.size(); i++){
            
            String instrucao = instrucoes.get(i);
            if(instrucao.contains(":")){
                String label = instrucao.split(":")[0];
                instrucao = instrucao.split(":")[1];
                instrucao = instrucao.trim();
                tabelaDeSimbolosLocais.put(label, new SimbolosLocais(Integer.toString(programCounter), true, true, "l"));
            }
            
            if(instrucao.matches("add AX,.*AX")){
               
                codigoIntermediario += "0x03C0" + "\n";
                programCounter += 2; 
            }
            
            else if(instrucao.matches("add AX,.*DX")){
                codigoIntermediario += "0x03C2" + "\n";
                programCounter += 2; 
                //updateMemoria(0x03C2, controle_mem++);
   
            }else if(instrucao.matches("add AX,.*")){
                codigoIntermediario += "0x05";
                String opd = instrucao.split("AX,")[1];
                opd = opd.trim();
               System.out.println("Testando const 1. Nome: " + opd);
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));    
                }
                
                programCounter = programCounter + 3;  
                
            }else if(instrucao.matches("div .*SI")){
                codigoIntermediario += "0xf7f6" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("div .*AX")){
                codigoIntermediario += "0xf7c0" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("sub AX,.*AX")){
                codigoIntermediario += "0x2bc0" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("sub AX,.*DX")){
                codigoIntermediario += "0x2bc2" + "\n";
                programCounter += 2; 
  
            }else if(instrucao.matches("sub AX,.*")){
                codigoIntermediario += "0x2d";
                String opd = instrucao.split("AX,")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter = programCounter + 3; 
            
            }else if(instrucao.matches("mul .*SI")){
                codigoIntermediario += "0xf6f7" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("mul .*AX")){
                codigoIntermediario += "0xf7f0" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("cmp AX,.*DX")){
                codigoIntermediario += "0x3BC2" + "\n";
                programCounter += 2; 
                
            
            }else if(instrucao.matches("cmp AX,.*")){
                codigoIntermediario += "0x3d";
                String opd = instrucao.split("AX,")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter = programCounter + 3;  

            }else if(instrucao.matches("and AX,.*DX")){
                codigoIntermediario += "0xf7C2" + "\n";
                programCounter += 2; 
  
            }else if(instrucao.matches("and AX,.*")){
                codigoIntermediario += "0x25";
                String opd = instrucao.split("AX,")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));    
                }
                programCounter = programCounter + 3; 
                
            }else if(instrucao.matches("not .*AX")){
                codigoIntermediario += "0xF8C0" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("xor AX,.*AX")){
                codigoIntermediario += "0x33C0" + "\n";
                programCounter += 2; 

            }else if(instrucao.matches("xor AX,.*DX")){
                codigoIntermediario += "0x33C2" + "\n";
                programCounter += 2; 
 
            }else if(instrucao.matches("xor AX,.*")){
                codigoIntermediario += "0x35";
                String opd = instrucao.split("AX,")[1];
                opd = opd.trim();
                
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter = programCounter + 3; 

            }else if(instrucao.matches("or AX,.*AX")){
                codigoIntermediario += "0x0BC0" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("or AX,.*DX")){
                codigoIntermediario += "0x0BC2" + "\n";
                programCounter += 2; 

            }else if(instrucao.matches("or AX,.*")){
                codigoIntermediario += "0x0DC2";
                String opd = instrucao.split("AX,")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter = programCounter + 3;  

            }else if(instrucao.matches("jmp.*")){
                codigoIntermediario += "0xEB";
                String opd = instrucao.split("jmp")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter += 3;    
            
            }else if(instrucao.matches("jz.*")){
                codigoIntermediario += "0x74";
                String opd = instrucao.split("jz")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));    
                }
                programCounter += 3; 
                
            }else if(instrucao.matches("jnz.*")){
                codigoIntermediario += "0x75";
                String opd = instrucao.split("jnz")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter += 3; 
            
            }else if(instrucao.matches("jp.*")){
                codigoIntermediario += "0x7A";
                String opd = instrucao.split("jp")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter += 3; 
            
            }else if(instrucao.matches("call.*")){
                codigoIntermediario += "0xE8";
                String opd = instrucao.split("call")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));    
                }
                programCounter += 3; 
            
            }else if(instrucao.matches("ret.*")){
                codigoIntermediario += "0xEF" + "\n";
                programCounter += 1; 
            
            }else if(instrucao.matches("hlt.*")){
                codigoIntermediario += "0xEE" + "\n";
                programCounter += 1; 
                
            }else if(instrucao.matches("pop .*AX")){
                codigoIntermediario += "0x58C0" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("pop .*DX")){
                codigoIntermediario += "0x58C2" + "\n";
                programCounter += 2; 
            
            }else if(instrucao.matches("popf")){
                codigoIntermediario += "0x9C" + "\n";
                programCounter += 1; 
                
            }else if(instrucao.matches("pop .*")){
                codigoIntermediario += "0x58";
                String opd = instrucao.split("pop")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter += 3; 
                
            }else if(instrucao.matches("push .*AX")){
                codigoIntermediario += "0x50C0" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("push .*DX")){
                codigoIntermediario += "0x50C2" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("pushf.*")){
                codigoIntermediario += "0x9C" + "\n";
                programCounter += 1; 
                
            }else if(instrucao.matches("store .*AX")){
                codigoIntermediario += "0x07C0" + "\n";
                programCounter += 2; 
                
            }else if(instrucao.matches("store .*DX")){
                codigoIntermediario += "0x07C2" + "\n";
                programCounter += 2; 
            
            }else if(instrucao.matches("read .*")){
                codigoIntermediario += "0x12";
                String opd = instrucao.split("read ")[1];
                opd = opd.trim();
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter += 3;     
            
            }else if(instrucao.matches("move AX,.*DX")){
                codigoIntermediario += "0x8BC2" + "\n";
                programCounter += 2; 
            
            }else if(instrucao.matches("move DX,.*AX")){
                codigoIntermediario += "0x8BD0" + "\n";
                programCounter += 2; 
            
            }else if(instrucao.matches("move AX,.*")){
                codigoIntermediario += "0xA1";
                String opd = instrucao.split("AX,")[1];
                opd = opd.trim();
                //System.out.println("Mov Ax instru = " + instrucao);

                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter += 3;     
            
            }else if(instrucao.matches("move .*,.*AX")){
                codigoIntermediario += "0xA3";
                String opd = instrucao.split(",")[0];
                opd = opd.split("move")[1];
                opd = opd.trim();
                //System.out.println("Mov Ax instru = " + instrucao);
                if(!(tabelaDeSimbolosLocais.get(opd).isRelocable())){  // Verifica se é uma constante
                    codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }else{
                    codigoIntermediario += "0000" + "\n";
                    
                    tabelaDeSimbolosUsados.add(new SimbolosUsados(opd, programCounter + 1));     
                }
                programCounter += 3; 
                
            }else if(instrucao.matches(".*DW.*")){ // Falta implementar, aceitar vetor, valor com 2 bytes
                String opd = instrucao.split("DW")[0];
                opd = opd.trim();
                try{
                    String value = instrucao.split("DW ")[1]; 
                    value = value.trim();
                    if(value.length() == 4){  // Caso Variavel tenha 2 bytes
                        String firstPart = value.substring(0, 2);
                        String secondPart = value.substring(2, 4);
                        value = secondPart + firstPart;
                        tabelaDeSimbolosLocais.put(opd, new SimbolosLocais(value, dataCounter, true, true, "v")); // Valor, posição, recolavel, definicao
                        data.add((Integer.parseInt(secondPart))); // preparar dw para receber qualquer base numerica
                        data.add((Integer.parseInt(firstPart)));
                    }
                    else if(value.length() == 2){  // Caso Variavel tenha 2 bytes
                        tabelaDeSimbolosLocais.put(opd, new SimbolosLocais(value, dataCounter, true, true, "v")); // Valor, posição, recolavel, definicao
                        data.add((0)); // preparar dw para receber qualquer base numerica
                    }else{
                        System.out.println("Size of bytes not accepted ");
                    }
                   
                }catch(ArrayIndexOutOfBoundsException e){
                    tabelaDeSimbolosLocais.put(opd, new SimbolosLocais(dataCounter, true, true, "v")); // Valor não inicializado
                    data.add((0));
                    data.add((0));
                }
                dataCounter += 2; 
            }
            else if(instrucao.matches(".*EQU.*")){  // Falta implementar,  pode receber expressões
                String opd = instrucao.split("EQU")[0];
                opd = opd.trim();
                String value = instrucao.split("EQU ")[1];
                opd = opd.trim();
                
                /*if((value.charAt(value.length() - 1) == 'H')){       // Verifica se está na base hexadecimal
                        String hex = value.split("h")[1];
                        codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                    }
                    else if((value.charAt(value.length() - 1) == 'H')){       // Verifica se está na base hexadecimal
                        String hex = value.split("h")[1];
                        codigoIntermediario += tabelaDeSimbolosLocais.get(opd).getValue() + "\n";
                }*/
                
                if(value.length() == 4){
                    String firstPart = instrucao.substring(0, 2);
                    String secondPart = instrucao.substring(2, 4);
                    value = secondPart + firstPart;
                }
                tabelaDeSimbolosLocais.put(opd, new SimbolosLocais(value, false, true, "c"));
                 
            }else if(instrucao.matches(".*PROC.*")){
                String label = instrucao.split("PROC")[0];
                label = label.trim();
                
                tabelaDeSimbolosLocais.put(label, new SimbolosLocais(label, true, true, "l"));
                
            }
            else if(instrucao.matches("")){
                
            }
            else{

                System.out.println("Instrucao nao reconhecida = " + instrucao);
            }      
        //updateRegistrador(instrucoes.size(),"DS");    CASO SETAR DINAMICAMENTE OS SEGMENTOS   PILHA-INSTRUCOES-DADOS
        }
        writeFirstPassInFile(codigoIntermediario);
        print_simbolosLocais(); // Printa na interface na tabela de símbolos
        System.out.println("Contadores values: PC = " + programCounter + " DC = "+ dataCounter);
        print_simbolosUsados();
        // print_data();
        
    }
    
    public  void loadInstructionToSecondPass() throws IOException{ // Segunda passada (Falta passar endereço das variaveis)
        
        String finalCode = new String();
        List<String> codeAux = new ArrayList<String>();
        // Pega instruções do primeiro passo de montagem e coloca num Array
        System.out.println("Instruções: " + instrucoes);
        for (int i = 0; i< instrucoes.size(); i++){
            String instrucao = instrucoes.get(i);
            instrucao = instrucao.split("0x")[1];
            
            int stringLength = instrucao.length();
            
            if(stringLength == 2){
                codeAux.add(instrucao.substring(0, 2));
            }
            else if(stringLength == 4){
                codeAux.add(instrucao.substring(0, 2));
                codeAux.add(instrucao.substring(2, 4));
            }
            else if(stringLength == 6){
                codeAux.add(instrucao.substring(0, 2));
                codeAux.add(instrucao.substring(4, 6));
                codeAux.add(instrucao.substring(2, 4));
            }
            /*else if(stringLength == 8){
                codeAux.add(instrucao.substring(0, 2));
                codeAux.add(instrucao.substring(2, 4));
                codeAux.add(instrucao.substring(4, 6));
                codeAux.add(instrucao.substring(6, 8));
            }*/else{
                System.out.println("Tamanho de instrucao não suportada: " + instrucao);
            }  
        }
        
        try{
            // Coloca endereços de simbolos usados no Array que irá para Código Fonte
            for(SimbolosUsados usados : tabelaDeSimbolosUsados){  
                int position = usados.getOcorrencia();
                String symbol = usados.getName();
                int adressOfSymbol;
                if((tabelaDeSimbolosLocais.get(symbol).getType()).equals("l")){ // Verifica se é uma label ou uma variavel
                  adressOfSymbol = tabelaDeSimbolosLocais.get(symbol).getPosition() + CS;  
                }else{
                  adressOfSymbol = tabelaDeSimbolosLocais.get(symbol).getPosition() + DS;  
                }
                
                if(adressOfSymbol<256){ // Para valor de hexa que ocupa 1 byte, ex: a e aa
                   codeAux.set(position, Integer.toHexString(adressOfSymbol)); 
                }else if(adressOfSymbol<4096){ // Para valor de hexa que ocupa 2 byte, ex: aaf ou aaff
                   String adress  = Integer.toHexString(adressOfSymbol);
                   String adressPart1 = adress.substring(0, 1);
                   String adressPart2 = adress.substring(1);
                   codeAux.set(position, adressPart1); 
                   codeAux.set(position + 1, adressPart2);
                }
                else if(adressOfSymbol<65536){ // Para valor de hexa que ocupa 2 byte, ex: aaf ou aaff
                   String adress  = Integer.toHexString(adressOfSymbol);
                   System.out.println("Adress String " + adress);

                   String adressPart1 = adress.substring(0, 2);
                   String adressPart2 = adress.substring(2);
                   codeAux.set(position, adressPart1); 
                   codeAux.set(position + 1, adressPart2);
                }
                else if(adressOfSymbol>65536){ // Para valor de hexa que ocupa 2 byte, ex: aaaa
                   System.out.println("Adress size not supported");
                }
            }

        }catch(NoSuchElementException e){
            System.out.println("Error: " + e.getMessage());
         }
        
        // Preparando String para ser colocado no Código Objeto
        int sizeArchive = programCounter + dataCounter + sizeHeader; // O cabeçalho tem tamanho 4
        finalCode += Integer.toHexString(sizeArchive) + "\n";
        finalCode += Integer.toHexString(sizeHeader) + "\n";
        finalCode += Integer.toHexString(dataCounter) + "\n";
        finalCode += Integer.toHexString(programCounter) + "\n";
        
        for(Integer datas: data){ // Carrega dados
            finalCode += Integer.toHexString(datas) + "\n";
             
        }
        
        for(String list: codeAux){ // Carrega intruções
            finalCode += list + "\n";
        }
        writeSecondPassInFile(finalCode);
    }

    public  void writeFirstPassInFile(String string) throws IOException{ // Escreve primeira passada em um arquivo .txt e exibe na interface

        FileWriter fw = new FileWriter(new File(new String(System.getProperty("user.dir")+"/src/main/java/arquivos_txt/firstPass.txt")));
        fw.write(string);
        fw.close();
    }
    
    public  void writeSecondPassInFile(String string) throws IOException{ // Escreve segunda passada em um arquivo .txt e exibe na interface

        FileWriter fw = new FileWriter(new File(new String(System.getProperty("user.dir")+"/src/main/java/arquivos_txt/codigo_objeto.txt")));
        fw.write(string);
        fw.close();
        
        String[] vetor = string.split("\n");
        for (int i = 0; i < vetor.length; i++){     // Para adiciona texto intermediario na interface
            Tela2.listMemoryModel.addElement(vetor[i]);
        }
    }
    
    public  void print_simbolosLocais() {  // Printa simbolos (variaveis e constantes) na tabela de simbolos com seus valores
     
        System.out.println("\nTabela de Simbolos locais\n");
        for (String keys : tabelaDeSimbolosLocais.keySet()){
 
            System.out.println(keys + " = " + tabelaDeSimbolosLocais.get(keys).getValue() + " | Position: " + tabelaDeSimbolosLocais.get(keys).getPosition());
            Tela2.symbolTableModel.addElement(keys + " | " + tabelaDeSimbolosLocais.get(keys).getValue() +  " | " +  tabelaDeSimbolosLocais.get(keys).isRelocable() +  " | "  + tabelaDeSimbolosLocais.get(keys).isDefinited());
        }               
    }
    
    public  void print_simbolosUsados() {  // Printa simbolos (variaveis e constantes) na tabela de simbolos com seus valores
     
        System.out.println("\nTabela de Simbolos usados: \n\n" + "Tamanho da Tabela: " + tabelaDeSimbolosUsados.size());
        for (SimbolosUsados simbolos : tabelaDeSimbolosUsados){
            System.out.println(simbolos.getName() + " | Adress of ocorrencia: " + simbolos.getOcorrencia());
        }               
    }       
}
