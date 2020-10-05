/*
 Vitor Hugo Nascimento Pinto - 201535008
 Weslley Nascimento Araujo - 201535001
*/

public class Token {
    public int l, c;
    public TOKEN_TYPE token_type;
    public String lexeme;
    public Object info;

    public Token(TOKEN_TYPE token_type, String lexeme, Object info, int l, int c) {
        this.l = l;
        this.c = c;
        this.token_type = token_type;
        this.lexeme = lexeme;
        this.info = info;
    }

    public Token(TOKEN_TYPE token_type, String lexeme, int l, int c) {
        this.l = l;
        this.c = c;
        this.token_type = token_type;
        this.lexeme = lexeme;
    }

    public Token(TOKEN_TYPE token_type, Object info, int l, int c) {
        this.l = l;
        this.c = c;
        this.token_type = token_type;
        this.info = info;
    }

    @Override
    public String toString() {
        return token_type + (lexeme == null ? "" :  ": " + lexeme) + (info == null ? "" : ": " + info.toString());
    }
}
