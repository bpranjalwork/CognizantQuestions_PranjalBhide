using System;

namespace MyLibrary
{
    // The structure of an Employee
    public class Employee
    {
        public int EmployeeID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public decimal Salary { get; set; }
        public int DepartmentID { get; set; }
    }

    // This is an Interface representing a Database. 
    // We don't have a real database yet, which is why we will fake (Mock) it later!
    public interface IEmployeeRepository
    {
        Employee GetEmployeeById(int id);
    }

    // This is the core business logic class we want to test using NUnit
    public class EmployeeService
    {
        private readonly IEmployeeRepository _repository;

        // Constructor injection: We pass the repository interface here
        public EmployeeService(IEmployeeRepository repository)
        {
            _repository = repository;
        }

        // The method we want to test
        public decimal CalculateBonus(int employeeId, decimal bonusPercentage)
        {
            if (bonusPercentage < 0)
                throw new ArgumentException("Bonus percentage cannot be negative.");

            // Fetch employee from our repository boundary
            var employee = _repository.GetEmployeeById(employeeId);
            
            if (employee == null)
                return 0; // No employee found, no bonus

            // Calculate bonus
            return employee.Salary * (bonusPercentage / 100);
        }
    }
}