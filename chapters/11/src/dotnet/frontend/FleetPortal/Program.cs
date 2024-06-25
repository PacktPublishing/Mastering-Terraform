using FleetPortal.Data;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);

builder.Configuration.AddEnvironmentVariables();

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddHttpClient();
builder.Services.AddSingleton<FleetPortalBackendConfig>(sp => 
{
    var configuration = sp.GetRequiredService<IConfiguration>();
    var backendEndpoint = configuration.GetValue<string>("BackendEndpoint");

    return new FleetPortalBackendConfig()
    {
        Endpoint = backendEndpoint
    };
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

//app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");
// Make sure we listen to any hostname
var defaultPort = app.Configuration.GetValue<string>("DefaultPort");
app.Urls.Add($"http://*:{defaultPort}");

app.Run();
