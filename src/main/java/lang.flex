/*
 Vitor Hugo Nascimento Pinto - 201535008
 Weslley Nascimento Araujo - 201535001
*/

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

/* operators */
Identifier = [:lowercase:] ({Char} | "_" | [:digit:])*
TypeName = [:uppercase:][:lowercase:]*
Integer = [:digit:] [:digit:]*
Float = [:digit:]* "." [:digit:][:digit:]*
Literal = "\'" ({Char} | "\\n" | "\\t" | "\\b" | "\\r") "\'"
Char = [:uppercase:] | [:lowercase:]
Boolean = ("true" | "false")
Null = "null"

WhiteSpace     = {LineTerminator} | [ \t\f]
LineTerminator = \r|\n|\r\n

/* comments */
%state COMMENT
%state LINE_COMMENT

%%

<YYINITIAL> {
  {Identifier}                      { return symbol(TOKEN_TYPE.IDENTIFIER); }
  {TypeName}                        { return symbol(TOKEN_TYPE.TYPE_NAME); }
  {Integer}                         { return symbol(TOKEN_TYPE.INTEGER, Integer.parseInt(yytext())); }
  {Float}                           { return symbol(TOKEN_TYPE.FLOAT, Float.parseFloat(yytext())); }
  {Literal}                         { return symbol(TOKEN_TYPE.LITERAL); }
  {Char}                            { return symbol(TOKEN_TYPE.CHAR); }
  {Boolean}                         { return symbol(TOKEN_TYPE.BOOLEAN); }
  {Null}                            { return symbol(TOKEN_TYPE.NULL); }

  {WhiteSpace}                      { /* ignore */ }
  {LineTerminator}                  { /* ignore */ }

  "{-"                              { yybegin(COMMENT); }
  "--"                              { yybegin(LINE_COMMENT); }

  "("                               { return symbol(TOKEN_TYPE.PARENTHESIS_OPEN); }
  ")"                               { return symbol(TOKEN_TYPE.PARENTHESIS_CLOSE); }
  "["                               { return symbol(TOKEN_TYPE.BRACKET_OPEN); }
  "]"                               { return symbol(TOKEN_TYPE.BRACKET_CLOSE); }
  "{"                               { return symbol(TOKEN_TYPE.KEYS_OPEN); }
  "}"                               { return symbol(TOKEN_TYPE.KEYS_CLOSE); }
  ";"                               { return symbol(TOKEN_TYPE.SEMI); }
  "."                               { return symbol(TOKEN_TYPE.DOT); }
  ","                               { return symbol(TOKEN_TYPE.COMMA); }
  "="                               { return symbol(TOKEN_TYPE.EQ); }
  "<"                               { return symbol(TOKEN_TYPE.LESS); }
  "=="                              { return symbol(TOKEN_TYPE.EQEQ); }
  "!="                              { return symbol(TOKEN_TYPE.NOTEQ); }
  "+"                               { return symbol(TOKEN_TYPE.PLUS); }
  "-"                               { return symbol(TOKEN_TYPE.MINUS); }
  "*"                               { return symbol(TOKEN_TYPE.TIMES); }
  "/"                               { return symbol(TOKEN_TYPE.SLASH); }
  "%"                               { return symbol(TOKEN_TYPE.PERCENT); }
  "&&"                              { return symbol(TOKEN_TYPE.EQCEQC); }
  "!"                               { return symbol(TOKEN_TYPE.NOT); }
  ":"                               { return symbol(TOKEN_TYPE.DP); }
  "::"                              { return symbol(TOKEN_TYPE.DPDP); }

}

<COMMENT>{
    "-}"        { yybegin(YYINITIAL); }
    [^"-}"]*    {                     }
}

<LINE_COMMENT>{
    {LineTerminator}    { yybegin(YYINITIAL); }
    ^{LineTerminator}*  {                     }
}

/* error fallback */
[^]                              { throw new Error("Illegal character <" + yytext()+">"); }