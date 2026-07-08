using System.Collections.Generic;

namespace RetailInventory
{
    // Category Entity
    public class Category
    {
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }

        // Navigation Property: One category maps to many products
        public ICollection<Product> Products { get; set; } = new List<Product>();
    }

    // Product Entity
    public class Product
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public int StockQuantity { get; set; }

        // Foreign Key
        public int CategoryId { get; set; }
        
        // Navigation Property: Each product belongs to one specific category
        public Category Category { get; set; }
    }
}
