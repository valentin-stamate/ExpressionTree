import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

public class Expression {
	
	private String postfix;
	private Node head;
	
	void evaluate(String exp) {
		convertToPostfix(exp);
		
		System.out.print("Postfix Expression : " + this.postfix + "\n");
		
		Stack<Node> s = new Stack<>();
		Queue<Node> post = new LinkedList<>();
		
		for(int i = 0; i < postfix.length(); i++) {
			char x = postfix.charAt(i);
			Node n = new Node(x);
			
			post.add(n);
		}
		
		while(!post.isEmpty()) {
			Node n = post.poll();
			
			if( isOperand(n.expression) ) {
				s.push(n);
			} else {
				Node head = n;
				Node right = s.pop();
				Node left = s.pop();
				
				head.left = left;
				head.right = right;
				
				this.head = head;
				
				s.push(head);
				
			}
		}
		
	}
	
	private String convertToPostfix(String expression) {
		Queue<Character> infix = new LinkedList<>();
		Queue<Character> postfix = new LinkedList<>();
		Stack<Character> s = new Stack<>();
		
		
		for(int i = 0; i < expression.length(); i++) {
			char c = expression.charAt(i);
			if(c == ' ')
				continue;
			infix.add(c);
		}
		
		
		while(!infix.isEmpty()) {
			char x = infix.poll();
			
			if( isOperand(x) ) {
				postfix.add(x);
			} else if(x == '(') {
				s.push(x);
			} else if(x == ')') {
				while(!s.isEmpty() && s.peek() != '(') {
					postfix.add(s.pop());
				}
				if(!s.isEmpty() && s.peek() != '(') {
					return "Invalid Expression";
				}
				s.pop();
				
			} else {
				while(!s.isEmpty() && priority(x) <= priority(s.peek())) {
					if(s.peek() == '(') {
						return "Invalid Expression";
					}
					postfix.add(s.pop());
					
				}
				s.push(x);
			}
			
		}
		
		while(!s.isEmpty()) {
			if(s.peek() == '(') {
				return "Invalid Expression";
			}
			postfix.add(s.pop());
		}
		
		
		StringBuilder sb = new StringBuilder();
		while(!postfix.isEmpty()) {
			sb.append(postfix.poll());
		}
		
		this.postfix = sb.toString();
		
		return this.postfix;
	}

	
	void showTree() {
		System.out.print("Expression Tree : \n");
		show(this.head);
	}
	void show(Node n) {
		if(n == null) {
			return;
		}
		
		System.out.println(n.expression);
		
		show(n.left);
		show(n.right);
	}
	
	private int priority(char c) {
		if(c == '+' || c == '-') 
			return 1;
		if(c == '*' || c == '/')
			return 2;
		if(c == '^')
			return 3;
		return -1;
	}

	boolean isOperand(char x) {
		String pos = "+-*/^()";
		for(int i = 0; i < pos.length(); i++) {
			if(x == pos.charAt(i)) {
				return false;
			}
		}
		return true;
	}
	
}
