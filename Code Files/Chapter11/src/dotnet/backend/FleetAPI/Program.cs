var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
app.UseSwaggerUI();
app.UseSwagger();

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
app.Urls.Add("http://*:5000");

app.Run();
