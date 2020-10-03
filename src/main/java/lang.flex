import java_cup.runtime.*;

%%

%class Lexer
%unicode
%cup
%line
%column
%function nextToken
%type Token

%{
  StringBuffer string = new StringBuffer();

  private int ntk = 0;

  public int readedTokens(){
      return ntk;
  }

  private Token symbol(int type) {
    ntk++;
    return new Symbol(type, yyline+1 , yycolumn+1 );
  }

  private Token symbol(int type, Object value) {
    ntk++;
    return new Symbol(type, yyline+1 , yycolumn+1 , value);
  }
%}

LineTerminator = \r|\n|\r\n
number = [:digit:] [:digit:]*
identifier = [:lowercase:]
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]
/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*
Identifier = [:jletter:] [:jletterdigit:]*
DecIntegerLiteral = 0 | [1-9][0-9]*

%%

/* keywords */
<YYINITIAL> "abstract"              { return symbol(sym.ABSTRACT); }
<YYINITIAL> "boolean"               { return symbol(sym.BOOLEAN); }
<YYINITIAL> "break"                 { return symbol(sym.BREAK); }

<YYINITIAL> {
  {Identifier}                      { return symbol(TOKEN_TYPE.IDENTIFIER); }
  {number}                          { return symbol(TOKEN_TYPE.NUM, Integer.parseInt(yytext())); }
  {DecIntegerLiteral}               { return symbol(TOKEN_TYPE.INTEGER_LITERAL); }
  \"                                { string.setLength(0); yybegin(STRING); }

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