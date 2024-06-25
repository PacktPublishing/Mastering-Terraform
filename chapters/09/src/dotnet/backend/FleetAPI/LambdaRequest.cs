
using System.Text.Json.Serialization;

namespace FleetAPI;

public class LambdaRequest
{
    [JsonPropertyName("requestContext")]
    public string RequestContext { get; set; }
    [JsonPropertyName("httpMethod")]
    public string HttpMethod { get; set; }
    [JsonPropertyName("path")]
    public string Path { get; set; }
    [JsonPropertyName("queryStringParameters")]
    public string QueryStringParameters { get; set; }
    [JsonPropertyName("headers")]
    public IDictionary<string, string> Headers { get; set; }
    [JsonPropertyName("isBase64Encoded")]
    public bool IsBase64Encoded { get; set; }
    [JsonPropertyName("body")]
    public string Body { get; set; }
}