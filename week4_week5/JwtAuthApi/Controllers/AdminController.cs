using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JwtAuthApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AdminController : ControllerBase
    {
        [HttpGet("dashboard")]
        [Authorize(Roles = "Admin")] // Requires 'Admin' role (Question 3)
        public IActionResult GetAdminDashboard()
        {
            return Ok("Welcome to the admin dashboard. You are authorized as Admin!");
        }
    }
}