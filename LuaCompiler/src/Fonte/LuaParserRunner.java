/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Fonte;

/**
 *
 * @author Claudio Big Data
 */
public class LuaParserRunner {
    public static void main(String[] args) {
        if (args.length == 0)
        {
            System.out.println("Passe os arquivo o arquivo como argumento\n"
                    + " <arquivo executavel>");
        }
        else
        {
            System.out.println("Insira o caminho completo do arquivo");
            String nomeDoArquivo = args[0];
            String[] argsLuaParser = {nomeDoArquivo};
            LuaParser.main(argsLuaParser);
            System.out.println("Executado!");
        }
    }
}
