package Algorithms_DSA.EcommercePlatform_SearchFunction;

public class Product implements Comparable<Product> {
    private String productId;
    private String productName;
    private String category;

    public Product(String productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    // Getters for searching and displaying
    public String getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getCategory() {
        return category;
    }

    // Required for sorting products by productId (for Binary Search)
    @Override
    public int compareTo(Product vacancies) {
        return this.productId.compareTo(vacancies.productId);
    }

    @Override
    public String toString() {
        return String.format("[ID: %s | Name: %s | Category: %s]", productId, productName, category);
    }
}