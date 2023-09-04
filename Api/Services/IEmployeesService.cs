using Api.Dtos.Dependent;
using Api.Dtos.Employee;

namespace Api.Services
{
    public interface IEmployeesService
    {
        Task<GetEmployeeDto> GetEmployee(int id);
        Task<IList<GetEmployeeDto>> GetEmployees();
        Task<ICollection<GetDependentDto>> GetEmployeesDependents(int employeeId);
        Task<GetEmployeeDto> GetEmployeeWithPaychecks(int id);
    }
}
