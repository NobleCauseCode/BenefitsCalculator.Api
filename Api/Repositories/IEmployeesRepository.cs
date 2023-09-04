using Api.Models;

namespace Api.Repositories
{
    public interface IEmployeesRepository
    {
        Task<Employee> GetEmployee(int id);
        Task<IList<Employee>> GetEmployees();
    }
}
