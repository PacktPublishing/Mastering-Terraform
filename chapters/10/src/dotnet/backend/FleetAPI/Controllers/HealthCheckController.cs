using Microsoft.AspNetCore.Mvc;

namespace FleetAPI.Controllers
{
    [ApiController]
    [Route("health")]
    public class HealthCheckController : ControllerBase
    {

        private readonly ILogger<HealthCheckController> _logger;

        public HealthCheckController(ILogger<HealthCheckController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetHealthCheck")]
        public IActionResult Get()
        {
            return new OkObjectResult("Healthy");
        }
    }
}