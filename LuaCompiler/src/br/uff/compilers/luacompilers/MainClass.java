/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.uff.compilers.luacompilers;

import java.io.*;
import java.util.Scanner;

/**
 *
 * @author Claudio Big 
 */
public class MainClass {
    public static void main(String[] args) {
        final int GERAR = 1;
        final int EXECUTAR = 2;
        final int LEXER = 3;
        final int SAIR = 4;
        String ARQUIVO_LEXICO = "/src/br/uff/compilers/luacompilers/lua.jflex";
        String ARQUIVO_SINTATICO = "/src/br/uff/compilers/luacompilers/lua.cup";
        File f = new File("");
        Scanner in = new Scanner(System.in);
        int valor;
        do {
            System.out.println("Escolha uma opção:\n1)Gerar\n2)Executar\n3)Lexer\n4)Sair\nOpção: ");
            valor = in.nextInt();
            switch (valor) {
                case GERAR: 
                    System.out.println("Gerando ***");
                    String sinPath = f.getAbsolutePath()+ARQUIVO_SINTATICO;
                    String lexPath = f.getAbsolutePath()+ARQUIVO_LEXICO;
                    System.out.println(sinPath+"\n"+lexPath);
                    String[] argslexico = {lexPath};
                    String[] argssintatico = {"-parser", "LuaParser", sinPath};
                    jflex.Main.main(argslexico);
                    try {
                        java_cup.Main.main(argssintatico);
                    } catch (Exception ex) {
                        System.out.println("ERRO - Analisador Lexico");
                    }
                    
                    File lexer = new File("LuaParser.java");
                    File sym = new File("sym.java");
                    lexer.renameTo(new File(f.getAbsoluteFile()+"/src/br/uff/compilers/luacompilers/LuaParser.java"));
                    sym.renameTo(new File(f.getAbsoluteFile()+"/src/br/uff/compilers/luacompilers/sym.java"));
                    System.out.println("Gerado!");
                    break;
                case EXECUTAR: 
                    String nomeDoArquivo = f.getAbsolutePath()+"/src/br/uff/compilers/luacompilers/thais.vini";
                    String[] argsLuaParser = {nomeDoArquivo};
                    LuaParser.main(argsLuaParser);
                    System.out.println("Executado!");
                    break;
                case LEXER:
                    String nomeDoArquivoLexer = f.getAbsolutePath()+"/src/br/uff/compilers/luacompilers/thais.vini";
                    String[] argsLuaLexer = {nomeDoArquivoLexer};
                    LuaLexer.main(argsLuaLexer);
                    System.out.println("Executado!");
                    break;
                    
                case SAIR: 
                    System.out.println("Adeus!");
                    break;
                
                default: 
                    System.out.println("Opção não válida!");
                    break;
                
            }
        } while (valor != 4);
    }
}
