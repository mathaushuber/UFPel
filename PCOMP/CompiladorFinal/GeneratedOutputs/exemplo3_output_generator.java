import java.util.Scanner;
public class exemplo3_output_generator{

public static void main(String[] args) {
int choice;
int base;
int height;
int area;
Scanner scan = new Scanner(System.in);
choice = scan.nextInt();
scan.nextLine();

base = scan.nextInt();
scan.nextLine();

height = scan.nextInt();
scan.nextLine();

if ((choice == 1)) {
area = ((base * height) / 2);
System.out.println(area);
}
if ((choice == 2)) {
area = (base * height);
System.out.println(area);
}
}

}
