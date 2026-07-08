using NUnit.Framework;
using Moq;
using MyLibrary;
using System;

namespace MyLibrary.Tests
{
    [TestFixture] // Tells NUnit that this class contains test cases
    public class EmployeeServiceTests
    {
        private Mock<IEmployeeRepository> _mockRepository;
        private EmployeeService _employeeService;

        [SetUp] // Runs before EVERY single test case to set up a fresh state
        public void Setup()
        {
            // 1. Create a fake object (Mock) of our interface
            _mockRepository = new Mock<IEmployeeRepository>();

            // 2. Inject this fake object into our real service
            _employeeService = new EmployeeService(_mockRepository.Object);
        }

        [Test] // Marks this as a basic test case
        public void CalculateBonus_ValidEmployee_ReturnsCorrectBonus()
        {
            // Arrange: Setup data and tell the mock how to behave
            var fakeEmployee = new Employee { EmployeeID = 1, Salary = 5000.00m };
            
            // "When someone calls GetEmployeeById(1), return our fakeEmployee"
            _mockRepository.Setup(repo => repo.GetEmployeeById(1)).Returns(fakeEmployee);

            // Act: Execute the method we are testing
            decimal result = _employeeService.CalculateBonus(1, 10); // 10% bonus on 5000

            // Assert: Verify using NUnit assertions that the result is exactly what we expect
            Assert.That(result, Is.EqualTo(500.00m));
        }

        [Test]
        public void CalculateBonus_EmployeeNotFound_ReturnsZero()
        {
            // Arrange: Tell the mock to return null (no employee found)
            _mockRepository.Setup(repo => repo.GetEmployeeById(999)).Returns((Employee)null);

            // Act
            decimal result = _employeeService.CalculateBonus(999, 10);

            // Assert
            Assert.That(result, Is.EqualTo(0));
        }

        [Test]
        public void CalculateBonus_NegativeBonus_ThrowsArgumentException()
        {
            // Act & Assert: Verify that an error is intentionally thrown when bad values are provided
            Assert.Throws<ArgumentException>(() => _employeeService.CalculateBonus(1, -5));
        }
    }
}