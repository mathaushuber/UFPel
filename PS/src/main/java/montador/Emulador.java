/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package montador;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class Emulador {
    
    public int AX = 0;
    public int DX = 0;
    public int SP = 0;
    public int SI = 0;
    public int IP = 0;
    public int SR = 0;
    public int DS = 3000;
    public int CS = 1000;
    public int SS = 0;
    
    public Emulador(){
        
    }
    
    public void print(String word){
        System.out.println(word);
    }

    public enum paramTypes {
        OPD,
        REG,
        NULL
    }

    public boolean finished = false;

    public ArrayList<Integer> inputStream = new ArrayList<Integer>();
    private int inputStreamIndex = 0;
    public String outputStream;
    public String error;
    
   
    
    public ArrayList<Integer> mapIPLineIndex = new ArrayList<Integer>();

    public void reset(){
        finished = false;
        IP = 0;
        SI = 0;
        AX = 0;
        DX = 0;
        SR = 0;
        Tela2.memory = new Memory();
        this.error = null;
        this.outputStream="";
    }
    
    public void run(){
        while(!this.finished){
            // String instruction = this.instructions[this.IP];
            // if(inputStreamIndex>=inputStream.size() && instruction.matches("read.*")) break;
            this.step();
        }
    }

    public paramTypes paramType(String param){
        if(param == null)
            return paramTypes.NULL;
        if(param.matches("AX|DX|SP|SI|IP|SR"))
            return paramTypes.REG;
        return paramTypes.OPD;
    }

    public boolean checkParams(String[] params, paramTypes type1, paramTypes type2){
        return paramType(params[0]) == type1 && paramType(params[1])==type2;
    }
    public boolean checkParams(String[] params, String type1, paramTypes type2){
        return params[0].matches(type1) && paramType(params[1])==type2;
    }
    public boolean checkParams(String[] params, String type1, String type2){
        return params[0].matches(type1) && params[1].matches(type2);
    }

    public void step(){
        if(finished) {
            this.outputStream="Finished";
            return;
        }

        int div;
        int mul;
        int opd = 0, opd2 = 0;
        String byte1, byte2, bytes;
        if(finished) return;
        int instructionSeconByte;
        
        int instruction = Tela2.memory.getPalavra(CS+IP++);
        switch((int)instruction){
            case 0x8B:// move registrador
                
                opd = Tela2.memory.getPalavra(CS+IP++);
                //int instructionThirdByte = Tela2.memory.getPalavra(CS+IP++);
                if(opd == 0xc2){
                    AX = DX;
                }else if(opd == 0xD0){
                    DX = AX ;
                }
            break;
            case 0xA1:// move ax, opd
                
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                AX =  Tela2.memory.getPalavra(Integer.decode(bytes));
            break;
            case 0xA3:// move opd, ax
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                Tela2.memory.setPalavra(AX, Integer.decode(bytes));
            break;
            case 0x03:// add ax, ax and add ax, dx
                opd = Tela2.memory.getPalavra(CS+IP++);
                
                if(opd == 0xc0){
                    AX += AX;
                }else{
                    AX += DX;
                }
            break;
            case 0x05: // add opd
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                AX = AX + Tela2.memory.getPalavra(Integer.decode(bytes));;
            break;
            case 0xf7 :// div si
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xf6){
                    div = AX / SI;
                    AX = (int)(div & 256);
                    DX = (int)(div >>> 8);
                }else if(instructionSeconByte == 0xc0){
                    div = AX / AX;
                    AX = (int)(div & 256);
                    DX = (int)(div >>> 8);
                }else if(instructionSeconByte == 0xf0){
                    mul = AX * AX;
                    AX = (int)(mul & 256);
                    DX = (int)(mul >>> 8);
                }else if(instructionSeconByte == 0xc2){
                    AX &=DX;
                }
                
            break;
            case 0x2bc0:// sub ax
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xc0){
                    AX -= AX;
                }else{
                    AX -= DX;
                }
                
            break;
            case 0x25:// and opd
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                AX &= Integer.decode(bytes);
            break;
            case 0xf6: // mul 
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xf7){
                    mul = AX * AX;
                    AX = (int)(mul & 256);
                    DX = (int)(mul >>> 8);
                }
            break;
            case 0x3b://cmp DX
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xc2){
                    setFlag("zf", AX == DX);
                }
                
            break;
            case 0x23:// and AX
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xc0){
                    setFlag("zf", AX == AX);
                }else{
                    AX &= AX;
                }
                
            break;
            case 0xf8:// not ax
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xc0){
                    AX = (int)~AX;
                }
                
            break;
            case 0x0bc0:// or ax
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xc0){
                    AX|=AX;
                }else{
                    AX|=AX;
                }
                
            break;
            case 0x0d:// or opd
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                AX |= Integer.decode(bytes);
            break;
            case 0x33c0:// xor ax
            instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xc0){
                    AX|=AX;
                }else{
                    AX|=DX;    
                }
                AX|=AX;
            break;
            case 0x35:// xor opd
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                AX^=Integer.decode(bytes);
            break;
            case 0xeb:// jmp
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                IP = Integer.decode(bytes);
            break;
            case 0x74:// jz
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                if(getFlag("zf")) IP = Integer.decode(bytes);
            break;
            case 0x75:// jnz
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;   
                if(!getFlag("zf")) IP = Integer.decode(bytes);
            break;
            case 0x7a:// jp
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2; 
                if(!getFlag("SF")) IP = Integer.decode(bytes);
            break;
            case 0xe8:// call
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2; 
                IP = Integer.decode(bytes);
            break;
            case 0xef:// ret
                IP = Tela2.memory.getPalavra(--SI);
            break;
            case 0x58:// pop ax
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xc0){
                    AX = Tela2.memory.getPalavra(--SI);
                }else{
                    DX = Tela2.memory.getPalavra(--SI);    
                }
                
            break;
            case 0x59:// pop opd
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                Tela2.memory.setPalavra(Tela2.memory.getPalavra(--SI), DS + Integer.decode(bytes));
            break;
            case 0x9d:// popf
                SR = Tela2.memory.getPalavra(--SI);
            break;
            case 0x50:// push ax
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++)<<8;
                if(instructionSeconByte == 0xc0){
                    Tela2.memory.setPalavra(AX, DS+opd+opd2);
                }else{
                    Tela2.memory.setPalavra(DX, DS+opd+opd2);
                }
                
            break;
            case 0x50c2:// push dx
                
            break;
            case 0x9c://pushf
                Tela2.memory.setPalavra(SR, SI++);
            break;
            case 0x07:// store ax
                instructionSeconByte = Tela2.memory.getPalavra(CS+IP++);
                if(instructionSeconByte == 0xc0){
                    opd = Tela2.memory.getPalavra(CS+IP++);
                    opd2 = Tela2.memory.getPalavra(CS+IP++);
                    byte1 = Integer.toHexString(opd);
                    byte2 = Integer.toHexString(opd2);
                    bytes = "0x" + byte1 + byte2;
                    Tela2.memory.setPalavra(AX, Integer.decode(bytes));
                }else if(instructionSeconByte == 0xc2){
                    opd = Tela2.memory.getPalavra(CS+IP++);
                    opd2 = Tela2.memory.getPalavra(CS+IP++);
                    byte1 = Integer.toHexString(opd);
                    byte2 = Integer.toHexString(opd2);
                    bytes = "0x" + byte1 + byte2;
                    Tela2.memory.setPalavra(DX, Integer.decode(bytes));
                }
            break;
            case 0x12:// read opd
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                outputStream = Util.convertIntegerToBinary(Integer.decode(bytes));
                if(inputStream.size()>inputStreamIndex){
                    Tela2.memory.setPalavra(inputStream.get(inputStreamIndex++).intValue(), opd+opd2);
                }else{
                    IP-=2;
                }
            break;
            case 0x08:// write opd
                opd = Tela2.memory.getPalavra(CS+IP++);
                opd2 = Tela2.memory.getPalavra(CS+IP++);
                byte1 = Integer.toHexString(opd);
                byte2 = Integer.toHexString(opd2);
                bytes = "0x" + byte1 + byte2;
                outputStream = Util.convertIntegerToBinary(Integer.decode(bytes));
            break;
            case 0xEE: // hlt
                this.finished = true;
            break;
        }
    }
    
    
    public boolean getFlag(String flag){
        switch(flag){
            case "of":
                return Util.getBit(this.SR,12 );
            case "sf":
                return Util.getBit(this.SR,9 );
            case "zf":
                return Util.getBit(this.SR,8 );
            case "if":
                return Util.getBit(this.SR,7 );
            case "pf":
                return Util.getBit(this.SR,6 );
            case "cf":
                return Util.getBit(this.SR,0 );
            default:
                return false;
        }
    }

    public void setFlag(String flag, boolean set){
        switch(flag){
            case "of":
                 SR = Util.modifyBit(SR, 12, set);
                 break;
            case "sf":
                 SR = Util.modifyBit(SR, 9, set);
                 break;
            case "zf":
                 SR = Util.modifyBit(SR, 8, set);
                 break;
            case "if":
                 SR = Util.modifyBit(SR, 7, set);
                 break;
            case "pf":
                 SR = Util.modifyBit(SR, 6, set);
                 break;
            case "cf":
                 SR = Util.modifyBit(SR, 0, set);
                 break;
        }
    }


    public void input (String input){
        this.inputStream.add(Integer.parseInt(input));
        this.outputStream = input;
        int instruction = Tela2.memory.getPalavra(CS+IP);
        if(instruction==0x12) step();
    }
    
}
