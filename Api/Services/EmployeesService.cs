using Api.Dtos.Dependent;
using Api.Dtos.Employee;
using Api.Models;
using Api.Repositories;
using AutoMapper;

namespace Api.Services
{
    public class EmployeesService : IEmployeesService
    {
        private readonly IEmployeesRepository _employeesRepository;
        private readonly IDependentsRepository _dependentsRepository;
        private readonly IMapper _mapper;

        public EmployeesService(IEmployeesRepository employeesRepository, IMapper mapper, IDependentsRepository dependentsRepository)
        {
            _employeesRepository = employeesRepository;
            _mapper = mapper;
            _dependentsRepository = dependentsRepository;
        }

        public async Task<GetEmployeeDto> GetEmployee(int id)
        {
            var employee = await _employeesRepository.GetEmployee(id);
            var dependents = await _dependentsRepository.GetEmployeesDependents(employee.Id);
            employee.Dependents = dependents;

            return _mapper.Map<Employee, GetEmployeeDto>(employee);
        }

        public async Task<IList<GetEmployeeDto>> GetEmployees()
        {
            var employees = await _employeesRepository.GetEmployees();
            var dependents = await _dependentsRepository.GetDependents();
            // needed an efficient way to assign all dependents to their respective
            // employee. First we group them by the employeeId as a key in a dictionary.
            // The value of the dictionary is the list of dependents.
            // Finally we loop the employees and assign the dependents. This way we only
            // have to iterate the loop once as the dependents are already organized by employee.
            var dependentsByEmployee = dependents.GroupBy(d => d.EmployeeId).ToDictionary(g => g.Key, g => g.ToList());
            foreach (var employee in employees)
            {
                if (dependentsByEmployee.TryGetValue(employee.Id, out var depsForEmployee))
                {
                    employee.Dependents = depsForEmployee;
                }
            }
            return _mapper.Map<IList<Employee>, IList<GetEmployeeDto>>(employees);
        }

        public async Task<ICollection<GetDependentDto>> GetEmployeesDependents(int employeeId)
        {
            var dependents = await _dependentsRepository.GetEmployeesDependents(employeeId);
            return _mapper.Map<ICollection<Dependent>, ICollection<GetDependentDto>>(dependents);
        }

        public async Task<GetEmployeeDto> GetEmployeeWithPaychecks(int id)
        {
            // This is a common api problem that can be solved a couple ways.
            // In this case, I chose to re-use the GetEmployee() function.
            // It returns a dto where normally in a service we only convert
            // to dto before returning. There is an extra map here to convert
            // back to a domain object. If this were to test as an issue
            // for instance if performance was an issue, we could deal with
            // it at that point. Possibly create another internal repo or method
            // to return the correct domain object, etc.
            var employeeDto = await GetEmployee(id);
            var employee = _mapper.Map<GetEmployeeDto, Employee>(employeeDto);
            CalculateCalculatePaychecks(employee);

            return _mapper.Map<Employee, GetEmployeeDto>(employee);
        }

        /// <summary>
        /// This method calculates one month of paycheck and one month of benefits cost.
        /// Next it dives these up over 26 payments as evenly as possible. Any leftover
        /// amounts get added to the last check.
        /// </summary>
        /// <param name="employee"></param>
        /// <returns>Paycheck</returns>
        private void CalculateCalculatePaychecks(Employee employee)
        {
            // constants here just for reference, would be removed before PR

            /*
                public const decimal EmployeeBaseCost = 1000;
                public const decimal DependentCost = 600;
                public const decimal EmployeeSalaryThreshold    = 80000;
                public const decimal OverThresholdCost = 0.02m;
             */

            var employeeBaseCost = Constants.EmployeeBaseCost;

            var dependentsCost = 0m;

            // each dependent represents an additional $600 cost per month
            // if dependent is over 50 years old, increase by $200/mo
            foreach (var dependent in employee.Dependents)
            {
                // calculate the age of the dependent
                int age = DateTime.Today.Year - dependent.DateOfBirth.Year;

                // calculate the cost taking age rules into account
                dependentsCost += age > 50 ? Constants.DependentCost + Constants.DependentOverThresholdAgeCost
                                           : Constants.DependentCost;
            }

            // adjust for salaries over the threshold
            var overSalaryThresholdCost = employee.Salary > Constants.EmployeeSalaryThreshold
                                          ? employee.Salary * Constants.EmployeeSalaryOverThresholdCost
                                          : 0;
            // Total benefits cost
            var benefitsTotalAmount = employeeBaseCost + dependentsCost + overSalaryThresholdCost;

            // divide up the earnings over 26 paychecks (rounded)
            var monthlyEarnings = Math.Round(employee.Salary / Constants.TotalNumberOfPaychecksPerYear, 2);
            // divide up the deductions over 26 paychecks (rounded)
            var monthlyBenefitsDeduction = Math.Round(benefitsTotalAmount / Constants.TotalNumberOfPaychecksPerYear, 2);

            // now add these to each paycheck in a 26 paycheck cycle
            for (var i = 0; i < Constants.TotalNumberOfPaychecksPerYear; i++)
            {
                employee.Paychecks.Add(new Paycheck
                {
                    MonthlyEarnings = monthlyEarnings - monthlyBenefitsDeduction,
                    BenefitDeductions = monthlyBenefitsDeduction

                });
            }

            // at this point each check has an equal amount of pay and deduction, but the math 
            // probably wont round perfectly across the 26 payments, so 
            // lets figure out what is left and add it to the earnings and subtract any left over from benefits rounding.

            // take the last payment and 
            employee.Paychecks[Constants.TotalNumberOfPaychecksPerYear - 1].MonthlyEarnings += Math.Round(
                                                employee.Salary - (monthlyEarnings * Constants.TotalNumberOfPaychecksPerYear), 2);


            employee.Paychecks[Constants.TotalNumberOfPaychecksPerYear - 1].BenefitDeductions -= Math.Round(
                                                benefitsTotalAmount - (monthlyBenefitsDeduction * Constants.TotalNumberOfPaychecksPerYear), 2);
        }
    }
}
