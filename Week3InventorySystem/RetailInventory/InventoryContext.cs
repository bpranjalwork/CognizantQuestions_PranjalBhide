using Microsoft.EntityFrameworkCore;
using System;

namespace RetailInventory
{
    public class InventoryContext : DbContext
    {
        // These DbSets represent the actual tables that will be tracked in MySQL
        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            // Pointing directly to your local MySQL instance
            string connectionString = "server=localhost;database=RetailInventoryDb;user=root;password=Pranjal@123";
            
            // ServerVersion.AutoDetect automatically figures out if you are running MySQL 8.0+
            optionsBuilder.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString));
        }
    }
}