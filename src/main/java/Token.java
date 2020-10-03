public class Token {
    public int l, c;
    public TOKEN_TYPE token_type;
    public String lexeme;
    public Object info;

    public Token(int l, int c, TOKEN_TYPE token_type, String lexeme, Object info) {
        this.l = l;
        this.c = c;
        this.token_type = token_type;
        this.lexeme = lexeme;
        this.info = info;
    }

    public Token(int l, int c, TOKEN_TYPE token_type, String lexeme) {
        this.l = l;
        this.c = c;
        this.token_type = token_type;
        this.lexeme = lexeme;
    }

    public Token(int l, int c, TOKEN_TYPE token_type, Object info) {
        this.l = l;
        this.c = c;
        this.token_type = token_type;
        this.info = info;
    }

    @Override
    public String toString() {
        return "[(" + l + ", " + c + ") \"" + lexeme + "\" : <" + (info == null ? "" :info.toString()) + ">]";
    }
}