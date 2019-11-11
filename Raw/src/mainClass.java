import java.util.Stack;

public class mainClass {

	public static void main(String[] args) {
		
		
		Operation op = new Operation();
		
		op.evaluate("a+b*(c^d-e)^(f+g*h)-i");
		op.showTree();
		
	}
	
	public static void print(Object o) {
		System.out.print(o);
	}

}
