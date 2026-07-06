
package Algorithms_DSA.EcommercePlatform_SearchFunction;

import java.util.Arrays;

public class SearchEngine {

    // 1. Linear Search Implementation
    // Scans each element one by one from start to end
    public static Product linearSearch(Product[] products, String targetId) {
        for (Product product : products) {
            if (product.getProductId().equals(targetId)) {
                return product; // Element found
            }
        }
        return null; // Element not found
    }

    // 2. Binary Search Implementation
    // Repeatedly divides the sorted search interval in half
    public static Product binarySearch(Product[] sortedProducts, String targetId) {
        int low = 0;
        int high = sortedProducts.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int comparison = sortedProducts[mid].getProductId().compareTo(targetId);

            if (comparison == 0) {
                return sortedProducts[mid]; // Element found
            } else if (comparison < 0) {
                low = mid + 1; // Target is in the right half
            } else {
                high = mid - 1; // Target is in the left half
            }
        }
        return null; // Element not found
    }

    public static void main(String[] args) {
        // Setup raw unsorted data
        Product[] inventory = {
                new Product("P105", "Wireless Mouse", "Electronics"),
                new Product("P101", "Mechanical Keyboard", "Electronics"),
                new Product("P104", "Leather Wallet", "Accessories"),
                new Product("P102", "Running Shoes", "Footwear"),
                new Product("P103", "Coffee Mug", "Kitchen")
        };

        String searchTarget = "String P104";

        // --- Execute Linear Search ---
        System.out.println("--- Running Linear Search ---");
        Product resultLinear = linearSearch(inventory, searchTarget);
        System.out.println("Result: " + (resultLinear != null ? resultLinear : "Product Not Found"));

        // --- Execute Binary Search (Requires Data to be Sorted) ---
        System.out.println("\n--- Running Binary Search ---");
        // Creating a copy and sorting it by Product ID
        Product[] sortedInventory = Arrays.copyOf(inventory, inventory.length);
        Arrays.sort(sortedInventory);

        Product resultBinary = binarySearch(sortedInventory, searchTarget);
        System.out.println("Result: " + (resultBinary != null ? resultBinary : "Product Not Found"));
    }
}