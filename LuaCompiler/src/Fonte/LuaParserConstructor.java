/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Fonte;

import java.io.File;

/**
 *
 * @author Claudio Big Data
 */
public class LuaParserConstructor {
    public static void main(String[] args) {
        if (args.length == 0 || args.length != 2)
        {
            System.out.println("Passe os arquivos FLEX e CUP como argumento\n"
                    + " <Endereco flex> <Endereco cup>");
        }
        else
        {
            System.out.println("Gerando ***");
            String lexPath = args[0];
            String sinPath = args[1];
            System.out.println(sinPath+"\n"+lexPath);
            String[] argslexico = {lexPath};
            String[] argssintatico = {"-parser", "LuaParser", sinPath};
            jflex.Main.main(argslexico);
            try {
                java_cup.Main.main(argssintatico);
            } catch (Exception ex) {
                System.out.println("ERRO - Analisador Lexico");
            }
            System.out.println("Gerado!");
        }
    }
}
