using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JwtAuthApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SecureController : ControllerBase
    {
        [HttpGet("data")]
        [Authorize] // Requires a valid JWT token (Question 2)
        public IActionResult GetSecureData()
        {
            return Ok("This is protected data. You have a valid JWT token!");
        }
    }
}