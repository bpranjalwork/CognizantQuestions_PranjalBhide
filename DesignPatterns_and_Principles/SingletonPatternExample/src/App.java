public class App {
    public static void main(String[] args) {
        System.out.println("--- Requesting Logger Instance 1 ---");
        Logger logger1 = Logger.getInstance();
        logger1.log("This is the first log message.");

        System.out.println("\n--- Requesting Logger Instance 2 ---");
        Logger logger2 = Logger.getInstance();
        logger2.log("This is the second log message.");

        System.out.println("\n--- Verification ---");

        if (logger1 == logger2) {
            System.out.println("SUCCESS: Both logger1 and logger2 are the exact same instance!");
        } else {
            System.out.println("FAILURE: Different instances were created.");
        }
    }
}