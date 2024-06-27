using Microsoft.AspNetCore.Mvc;

namespace FleetAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TestController : ControllerBase
    {

        private readonly ILogger<TestController> _logger;

        public TestController(ILogger<TestController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetConnectionString")]
        public string Get()
        {
            string dbConnStr = Environment.GetEnvironmentVariable("DB_CONNECTION_STRING");
            return dbConnStr;
        }
    }
}