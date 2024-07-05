
using System.Text.Json.Serialization;

namespace FleetAPI;

public class LambdaResponse
{
    [JsonPropertyName("statusCode")]
    public int StatusCode { get; set; }
    [JsonPropertyName("statusDescription")]
    public string StatusDescription { get; set; }
    [JsonPropertyName("headers")]
    public IDictionary<string, string> Headers { get; set; }
    [JsonPropertyName("body")]
    public string Body { get; set; }
    [JsonPropertyName("isBase64Encoded")]
    public bool IsBase64Encoded { get; set; }
}