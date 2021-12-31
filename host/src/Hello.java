public class Hello {
	static {
		System.loadLibrary("hello");
	}

	private native void print();

	public static void main(String[] args) {
		new Hello().print();

		System.err.println("Hello from Host!");
	}
}
