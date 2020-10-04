import java.io.FileReader;
import java.io.IOException;

public class Main {
    public static void main(String args[]) {
        try{
            Lexer lexer = new Lexer(new FileReader("sample.txt"));
            Token t = lexer.nextToken();
            while (t != null) {
                System.out.println(t.toString());
                t = lexer.nextToken();
            }
            System.out.println("Total de tokens lidos " + lexer.readedTokens());
        }
        catch (IOException exception){
            System.out.println("Erro na leitura");
        }
    }
}