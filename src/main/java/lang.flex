%%

%unicode
%line
%column
%class Lexer
%function nextToken
%type Token

%{
  private int ntk;

  public int readedTokens(){
      return ntk;
  }

  private Token symbol(TOKEN_TYPE type) {
    ntk++;
    return new Token(type, yytext(), yyline+1 , yycolumn+1 );
  }

  private Token symbol(TOKEN_TYPE type, Object value) {
    ntk++;
    return new Token(type, value, yyline+1 , yycolumn+1);
  }
%}

%init{
    ntk = 0;
%init}

LineTerminator = \r|\n|\r\n
number = [:digit:] [:digit:]*
Identifier = [:lowercase:]
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]
/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

%%

/* keywords */
<YYINITIAL> "abstract"              { return symbol(TOKEN_TYPE.ABSTRACT); }
<YYINITIAL> "boolean"               { return symbol(TOKEN_TYPE.BOOLEAN); }
<YYINITIAL> "break"                 { return symbol(TOKEN_TYPE.BREAK); }

<YYINITIAL> {
  {Identifier}                      { return symbol(TOKEN_TYPE.IDENTIFIER); }
  {number}                          { return symbol(TOKEN_TYPE.NUM, Integer.parseInt(yytext())); }

  "="                               { return symbol(TOKEN_TYPE.EQ); }
  ";"                               { return symbol(TOKEN_TYPE.SEMI); }
  "*"                               { return symbol(TOKEN_TYPE.TIMES); }
  "=="                              { return symbol(TOKEN_TYPE.EQEQ); }
  "+"                               { return symbol(TOKEN_TYPE.PLUS); }

  {Comment}                         { /* ignore */ }
  {WhiteSpace}                      { /* ignore */ }
}

/* error fallback */
[^]                              { throw new Error("Illegal character <" + yytext()+">"); }