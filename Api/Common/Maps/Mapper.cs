using Api.Dtos.Dependent;
using Api.Dtos.Earnings;
using Api.Dtos.Employee;
using Api.Dtos.Paychecks;
using Api.Models;
using AutoMapper;

namespace Api.Common.Maps
{
    public class Mapper : Profile
    {
        public Mapper()
        {
            CreateMap<Employee,GetEmployeeDto>().ReverseMap();
            CreateMap<Dependent, GetDependentDto>().ReverseMap();
            CreateMap<Paycheck, GetPaycheckDto>();
        }
    }
}
