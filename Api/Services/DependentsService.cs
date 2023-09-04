using Api.Dtos.Dependent;
using Api.Models;
using Api.Repositories;
using AutoMapper;

namespace Api.Services
{
    public class DependentsService : IDependentsService
    {
        private readonly IDependentsRepository _dependentsRepository;
        private readonly IMapper _mapper;

        public DependentsService(IDependentsRepository employeesRepository, IMapper mapper)
        {
            _dependentsRepository = employeesRepository;
            _mapper = mapper;
        }



        public async Task<GetDependentDto> GetDependent(int id)
        {
            var dependent = await _dependentsRepository.GetDependent(id);
            return _mapper.Map<Dependent, GetDependentDto>(dependent);
        }

        public async Task<ICollection<GetDependentDto>> GetDependents()
        {
            var dependents = await _dependentsRepository.GetDependents();
            return _mapper.Map<ICollection<Dependent>, ICollection<GetDependentDto>>(dependents);
        }


    }
}
