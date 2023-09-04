using Api.Dtos.Dependent;

namespace Api.Services
{
    public interface IDependentsService
    {
        Task<GetDependentDto> GetDependent(int id);
        Task<ICollection<GetDependentDto>> GetDependents();
        
    }
}
