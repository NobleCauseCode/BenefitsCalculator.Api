using Api.Common.Exceptions;
using Api.Models;
using Api.Models.Settings;
using Dapper;
using Microsoft.Extensions.Options;
using System.Data;
using System.Data.SqlClient;

namespace Api.Repositories
{
    public class DependentsRepository : IDependentsRepository
    {
        private readonly AppSettings _appsettings;

        public DependentsRepository(IOptions<AppSettings> appsettings)
        {
            _appsettings = appsettings.Value;
        }

        public async Task<Dependent> GetDependent(int id)
        {
            using (var connection = new SqlConnection(_appsettings.ConnectionString))
            {
                var parameters = new DynamicParameters();
                parameters.Add("@DependentId", id);

                var proc = "stp_Dependents_GetById";
                var results = await connection.QueryFirstOrDefaultAsync<Dependent>(proc, parameters, commandType: CommandType.StoredProcedure);
                if (results is null)
                {
                    throw new DependentNotFoundException("Supplied dependent id was not found, or is not active");
                }
                return results;
            }
        }

        public async Task<ICollection<Dependent>> GetDependents()
        {
            using (var connection = new SqlConnection(_appsettings.ConnectionString))
            {
                var proc = "stp_Dependents_Get";
                var results = await connection.QueryAsync<Dependent>(proc, null, commandType: CommandType.StoredProcedure);
                return results.ToList();
            }
        }

        public async Task<ICollection<Dependent>> GetEmployeesDependents(int employeeId)
        {
            using (var connection = new SqlConnection(_appsettings.ConnectionString))
            {
                var parameters = new DynamicParameters();
                parameters.Add("@EmployeeId", employeeId);

                var proc = "stp_Dependents_GetByEmployee";
                var results = await connection.QueryAsync<Dependent>(proc, parameters, commandType: CommandType.StoredProcedure);

                return results.ToList();
            }
        }
    }
}
