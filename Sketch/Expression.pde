import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

public class Expression {

	private String postfix;
	private Node head;
	LinkedList<Node> nodeBackup;

	Expression(){
		registerMethod("draw", this);
		nodeBackup = new LinkedList<Node>();
	}
	void draw(){
		drawLines(head);
	}
	void drawLines(Node head){
		Node left = null, right = null;

		try{
			left = head.left;
			right = head.right;
		} catch(Exception e){}

		stroke(255);
    try{line(head.x, head.y, left.x, left.y); drawLines(head.left);} catch(Exception e){}
    try{ line(head.x, head.y, right.x, right.y); drawLines(head.right);} catch(Exception e){}
	}

	void evaluate(String exp) {
		convertToPostfix(exp);

		for(Node n : nodeBackup){
			n.isShowing = false;
		}

		nodeBackup = new LinkedList<Node>();

		Stack<Node> s = new Stack<Node>();
		Queue<Node> post = new LinkedList<Node>();

		for(int i = 0; i < postfix.length(); i++) {
			char x = postfix.charAt(i);
			Node n = new Node(x);
			nodeBackup.add(n);
      n.offset(i * 40);

			post.add(n);
		}

		while(!post.isEmpty()) {
			Node n = post.poll();

			if( isOperand(n.expression) == true ) {
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
		Queue<Character> infix = new LinkedList<Character>();
		Queue<Character> postfix = new LinkedList<Character>();
		Stack<Character> s = new Stack<Character>();


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
		show(this.head, width / 2, 50, 1);
	}
	void show(Node n, int x, int y, int level) {
		if(n == null) {
			return;
		}

		n.x = x;
		n.y = y;

    stroke(20);
    strokeWeight(2);

		int offset = width / 2 / (level * 2);
		show(n.left, x - offset, y + 50, level * 2);
		show(n.right, x + offset, y + 50, level * 2);
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
