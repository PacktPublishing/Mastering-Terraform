using Amazon.Lambda.Core;
using System.Text.Json;
using Amazon.Lambda.ApplicationLoadBalancerEvents;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace FleetAPI;

public class Function
{
    private static readonly string[] Summaries = new[]
    {
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
    };

    /// <summary>
    /// A simple function that takes a string and does a ToUpper
    /// </summary>
    /// <param name="input"></param>
    /// <param name="context"></param>
    /// <returns></returns>
    public ApplicationLoadBalancerResponse FunctionHandler(ApplicationLoadBalancerRequest request, ILambdaContext context)
    {
        var forecasts = Enumerable.Range(1, 5).Select(index => new WeatherForecast
        {
            Date = DateTime.Now.AddDays(index),
            TemperatureC = Random.Shared.Next(-20, 55),
            Summary = Summaries[Random.Shared.Next(Summaries.Length)]
        })
        .ToArray();

        return new ApplicationLoadBalancerResponse
        {
            StatusCode = 200,
            Headers = new Dictionary<string, string>() {
                { "Content-Type", "application/json" },
                { "Access-Control-Allow-Origin", "*" }
            },
            Body = JsonSerializer.Serialize(forecasts)
        };
    }
}
