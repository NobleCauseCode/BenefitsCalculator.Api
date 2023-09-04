using Api.Common.Exceptions;
using Api.Dtos.Dependent;
using Api.Dtos.Employee;
using Api.Models;
using Api.Services;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
public class EmployeesController : ControllerBase
{
    private readonly IEmployeesService _employeesService;

    public EmployeesController(IEmployeesService employeesService)
    {
        _employeesService = employeesService;
    }

    [SwaggerOperation(Summary = "Get employee by id")]
    [HttpGet("{id}")]
    public async Task<ActionResult<ApiResponse<GetEmployeeDto>>> Get(int id)
    {
        try
        {
            var employee = await _employeesService.GetEmployee(id);
            var result = new ApiResponse<GetEmployeeDto>
            {
                Data = employee,
                Success = true
            };

            return result;

        }
        catch (EmployeeNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (Exception ex)
        {
            return StatusCode(500, ex.Message);
        }
    }

    [SwaggerOperation(Summary = "Get employee by id")]
    [HttpGet("{id}/paychecks")]
    public async Task<ActionResult<ApiResponse<GetEmployeeDto>>> GetWithPaychecks(int id)
    {
        var employee = await _employeesService.GetEmployeeWithPaychecks(id);
        var result = new ApiResponse<GetEmployeeDto>
        {
            Data = employee,
            Success = true
        };

        return result;
    }


    [SwaggerOperation(Summary = "Get all employees")]
    [HttpGet("")]
    public async Task<ActionResult<ApiResponse<IList<GetEmployeeDto>>>> GetAll()
    {
        // moved this into a sql server database, but left it here commented 
        // for reference durring review. This would normally be removed before 
        // the PR is opened.

        //task: use a more realistic production approach
        //var employees = new List<GetEmployeeDto>
        //{
        //    new()
        //    {
        //        Id = 1,
        //        FirstName = "LeBron",
        //        LastName = "James",
        //        Salary = 75420.99m,
        //        DateOfBirth = new DateTime(1984, 12, 30)
        //    },
        //    new()
        //    {
        //        Id = 2,
        //        FirstName = "Ja",
        //        LastName = "Morant",
        //        Salary = 92365.22m,
        //        DateOfBirth = new DateTime(1999, 8, 10),
        //        Dependents = new List<GetDependentDto>
        //        {
        //            new()
        //            {
        //                Id = 1,
        //                FirstName = "Spouse",
        //                LastName = "Morant",
        //                Relationship = Relationship.Spouse,
        //                DateOfBirth = new DateTime(1998, 3, 3)
        //            },
        //            new()
        //            {
        //                Id = 2,
        //                FirstName = "Child1",
        //                LastName = "Morant",
        //                Relationship = Relationship.Child,
        //                DateOfBirth = new DateTime(2020, 6, 23)
        //            },
        //            new()
        //            {
        //                Id = 3,
        //                FirstName = "Child2",
        //                LastName = "Morant",
        //                Relationship = Relationship.Child,
        //                DateOfBirth = new DateTime(2021, 5, 18)
        //            }
        //        }
        //    },
        //    new()
        //    {
        //        Id = 3,
        //        FirstName = "Michael",
        //        LastName = "Jordan",
        //        Salary = 143211.12m,
        //        DateOfBirth = new DateTime(1963, 2, 17),
        //        Dependents = new List<GetDependentDto>
        //        {
        //            new()
        //            {
        //                Id = 4,
        //                FirstName = "DP",
        //                LastName = "Jordan",
        //                Relationship = Relationship.DomesticPartner,
        //                DateOfBirth = new DateTime(1974, 1, 2)
        //            }
        //        }
        //    }
        //};
        var employees = await _employeesService.GetEmployees();
        var result = new ApiResponse<IList<GetEmployeeDto>>
        {
            Data = employees,
            Success = true
        };

        return result;
    }

    [SwaggerOperation(Summary = "Get employees dependents")]
    [HttpGet]
    [Route("dependents/{employeeId}")]
    public async Task<ActionResult<ApiResponse<ICollection<GetDependentDto>>>> GetEmployeesDependents(int employeeId)
    {
        var dependent = await _employeesService.GetEmployeesDependents(employeeId);
        var result = new ApiResponse<ICollection<GetDependentDto>>
        {
            Data = dependent,
            Success = true
        };

        return result;
    }
}
