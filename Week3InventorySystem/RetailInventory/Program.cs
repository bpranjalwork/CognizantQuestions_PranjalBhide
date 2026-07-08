using System;
using System.Linq;

namespace RetailInventory
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var context = new InventoryContext())
            {
                Console.WriteLine("🔄 Synchronizing database schema...");
                // Automatically creates the database and tables if they don't exist yet
                context.Database.EnsureCreated();
                Console.WriteLine("✅ Database ready!");

                // ---- 1. CREATE OPERATION ----
                if (!context.Categories.Any())
                {
                    Console.WriteLine("\n📥 Seeding sample data into database...");

                    var electronics = new Category { CategoryName = "Electronics" };
                    
                    var prod1 = new Product { Name = "Mechanical Keyboard", Price = 4500.00m, StockQuantity = 25, Category = electronics };
                    var prod2 = new Product { Name = "Wireless Mouse", Price = 1800.00m, StockQuantity = 50, Category = electronics };

                    // Stage the records to be tracked
                    context.Categories.Add(electronics);
                    context.Products.AddRange(prod1, prod2);

                    // Push tracked actions directly down to MySQL in one atomic transaction
                    context.SaveChanges();
                    Console.WriteLine("✅ Data seeded successfully!");
                }

                // ---- 2. READ OPERATION ----
                Console.WriteLine("\n📋 Fetching current inventory profiles:");
                
                var inventoryList = context.Products
                                           .Select(p => new {
                                               p.Name,
                                               p.Price,
                                               p.StockQuantity,
                                               p.Category.CategoryName
                                           })
                                           .ToList();

                foreach (var item in inventoryList)
                {
                    Console.WriteLine($"- [📦 {item.CategoryName}] {item.Name} | Price: ₹{item.Price} | Stock: {item.StockQuantity} left");
                }
            }

            Console.WriteLine("\n🎉 Week 3 Labs 1-4 completed seamlessly!");
        }
    }
}