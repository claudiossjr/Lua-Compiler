/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.uff.compilers.luacompilers;

public class Token {
    public String val;

    public Token(String val) {
        this.val = val;
    }

    @Override
    public String toString() {
        return val;
    }
}
