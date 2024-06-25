using FleetPortal.Data;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Threading.Tasks;

namespace FleetPortal.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SwaggerController : ControllerBase
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly FleetPortalBackendConfig _fleetPortalBackendConfig;

        public SwaggerController(IHttpClientFactory httpClientFactory, FleetPortalBackendConfig fleetPortalBackendConfig)
        {
            _httpClientFactory = httpClientFactory;
            _fleetPortalBackendConfig = fleetPortalBackendConfig;
        }

        [HttpGet("swagger.json")]
        public async Task<IActionResult> GetSwaggerJson()
        {
            var httpClient = _httpClientFactory.CreateClient();
            var backendApiUrl = $"https://{_fleetPortalBackendConfig.Endpoint}/swagger/v1/swagger.json";

            var swaggerJson = await httpClient.GetStringAsync(backendApiUrl);

            if (string.IsNullOrEmpty(swaggerJson))
            {
                return NotFound();
            }

            return Content(swaggerJson, "application/json");
        }
    }

}