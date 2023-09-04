using Api.Common.Exceptions;
using Api.Models;
using Api.Models.Settings;
using Dapper;
using Microsoft.Extensions.Options;
using System.Data;
using System.Data.SqlClient;

namespace Api.Repositories
{
    public class EmployeesRepository : IEmployeesRepository
    {
        private readonly AppSettings _appsettings;

        public EmployeesRepository(IOptions<AppSettings> appsettings)
        {
            _appsettings = appsettings.Value;
        }

        public async Task<Employee> GetEmployee(int id)
        {
            using (var connection = new SqlConnection(_appsettings.ConnectionString))
            {
                var parameters = new DynamicParameters();
                parameters.Add("@employeeId", id);

                var proc = "stp_Employees_GetById";
                var results = await connection.QueryFirstOrDefaultAsync<Employee>(proc, parameters, commandType: CommandType.StoredProcedure);
                if (results is null)
                {
                    throw new EmployeeNotFoundException("Supplied dependent id was not found, or is not active");
                }
                return results;
            }
        }

        public async Task<IList<Employee>> GetEmployees()
        {
            using (var connection = new SqlConnection(_appsettings.ConnectionString))
            {
                var proc = "stp_Employees_Get";
                var results = await connection.QueryAsync<Employee>(proc, null, commandType: CommandType.StoredProcedure);
                return results.ToList();
            }
        }
    }
}
