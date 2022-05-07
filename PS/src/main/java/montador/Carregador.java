/* Conteúdo do código objeto. Cada linha é um byte
// Cabeçalho: tamanho do arquivo, tamanho do cabeçalho, tamanho dos dados, tamanho das instruções
// Segmento de Dados
// Segmento de Intruções
*/
package montador;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Gerson Menezes
 */
public class Carregador {
    
    
    public List<String> CodigoObjeto = new ArrayList<String>();

    
    public Carregador(){
          
    }
    
    public void loadCodigo_Obj() {
                                                            
        try {
            String CaminhoDoArquivo = new String(System.getProperty("user.dir")+"/src/main/java/arquivos_txt/codigo_objeto.txt");
            CodigoObjeto = Files.readAllLines(Paths.get(CaminhoDoArquivo));
               
            //System.out.println("PRINTANDO" + CodigoObjeto.toString());
        } 
        catch (IOException ex) {
            Logger.getLogger(Carregador.class.getName()).log(Level.SEVERE, null, ex);
        }
       loadMemory();         
    }

     public void loadMemory(){
         
         int qtd_dados = Integer.parseInt(CodigoObjeto.get(2),16);
         int qtd_instrucoes = Integer.parseInt(CodigoObjeto.get(3),16);
         int posDados = 3000;
         int posInstrucoes = 1000;
         int posicao = 4;

          
         for (int i =0; i<qtd_dados; i++){
             int valor = Integer.parseInt(CodigoObjeto.get(posicao).trim(),16);
             Tela2.memory.setPalavra(valor, (posDados++));  
             posicao++;
         }
         
         for (int i =0; i<qtd_instrucoes; i++){
             int valor = Integer.parseInt(CodigoObjeto.get(posicao).trim(),16);
             Tela2.memory.setPalavra(valor, (posInstrucoes++));
             posicao++;
         }

     }
} 

