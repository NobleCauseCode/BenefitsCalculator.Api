using Api.Models;

namespace Api.Repositories
{
    public interface IDependentsRepository
    {
        Task<Dependent> GetDependent(int id);
        Task<ICollection<Dependent>> GetDependents();
        Task<ICollection<Dependent>> GetEmployeesDependents(int employeeId);
    }
}
