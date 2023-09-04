using Api.Common.Exceptions;
using Api.Dtos.Dependent;
using Api.Models;
using Api.Services;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
public class DependentsController : ControllerBase
{
    private readonly IDependentsService _dependentsService;

    public DependentsController(IDependentsService dependentsService)
    {
        _dependentsService = dependentsService;
    }

    [SwaggerOperation(Summary = "Get dependent by id")]
    [HttpGet("{id}")]
    public async Task<ActionResult<ApiResponse<GetDependentDto>>> Get(int id)
    {
        try
        {
            var dependent = await _dependentsService.GetDependent(id);
            
            return new ApiResponse<GetDependentDto>
            {
                Data = dependent,
                Success = true
            };
        }
        catch(DependentNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (Exception ex)
        {
            return StatusCode(500, ex.Message);
        }
        

        
    }

    [SwaggerOperation(Summary = "Get all dependents")]
    [HttpGet("")]
    public async Task<ActionResult<ApiResponse<ICollection<GetDependentDto>>>> GetAll()
    {
        var dependent = await _dependentsService.GetDependents();
        var result = new ApiResponse<ICollection<GetDependentDto>>
        {
            Data = dependent,
            Success = true
        };

        return result;
    }
}
