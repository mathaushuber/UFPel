import java.util.Scanner;
public class exemplo2_output_generator{

public static void main(String[] args) {
int N;
int counter;
int result;
Scanner scan = new Scanner(System.in);
N = scan.nextInt();
scan.nextLine();

counter = N;
result = 1;
if ((N == 0)) {
result = 1;
}
if ((N > 0)) {
do {
result = (result * counter);
counter = (counter - 1);
} while ((counter > 1));
}
printResult(result);
}

public static int printResult(int value) {
int resultValue;
resultValue = value;
System.out.println(resultValue);
return resultValue;
}

}
