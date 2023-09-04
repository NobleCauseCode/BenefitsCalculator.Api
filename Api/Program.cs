using Api;
using Api.Models.Settings;
using Api.Repositories;
using Api.Services;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);
var appSettingsSection = builder.Configuration.GetSection(Constants.AppSettingsSection);
builder.Services.Configure<AppSettings>(appSettingsSection);

builder.Services.AddAutoMapper(typeof(Program));

// Add services to the container.
builder.Services.AddSingleton<IDependentsService, DependentsService>();
builder.Services.AddSingleton<IEmployeesService, EmployeesService>();
builder.Services.AddSingleton<IDependentsRepository, DependentsRepository>();
builder.Services.AddSingleton<IEmployeesRepository, EmployeesRepository>();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.EnableAnnotations();
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Version = "v1",
        Title = "Employee Benefit Cost Calculation Api",
        Description = "Api to support employee benefit cost calculations"
    });
});

var allowLocalhost = "allow localhost";
builder.Services.AddCors(options =>
{
    options.AddPolicy(allowLocalhost,
        policy => { policy.WithOrigins("http://localhost:3000", "http://localhost"); });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors(allowLocalhost);

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
