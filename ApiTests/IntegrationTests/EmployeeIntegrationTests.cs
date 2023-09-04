using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using Api.Dtos.Dependent;
using Api.Dtos.Employee;
using Api.Models;
using Xunit;

namespace ApiTests.IntegrationTests;

public class EmployeeIntegrationTests : IntegrationTest
{
    [Fact]
    public async Task WhenAskedForAllEmployees_ShouldReturnAllEmployees()
    {
        var response = await HttpClient.GetAsync("/api/v1/employees");
        var employees = new List<GetEmployeeDto>
        {
            new()
            {
                Id = 1,
                FirstName = "LeBron",
                LastName = "James",
                Salary = 75420.99m,
                DateOfBirth = new DateTime(1984, 12, 30)
            },
            new()
            {
                Id = 2,
                FirstName = "Ja",
                LastName = "Morant",
                Salary = 92365.22m,
                DateOfBirth = new DateTime(1999, 8, 10),
                Dependents = new List<GetDependentDto>
                {
                    new()
                    {
                        Id = 1,
                        FirstName = "Spouse",
                        LastName = "Morant",
                        Relationship = Relationship.Spouse,
                        DateOfBirth = new DateTime(1998, 3, 3)
                    },
                    new()
                    {
                        Id = 2,
                        FirstName = "Child1",
                        LastName = "Morant",
                        Relationship = Relationship.Child,
                        DateOfBirth = new DateTime(2020, 6, 23)
                    },
                    new()
                    {
                        Id = 3,
                        FirstName = "Child2",
                        LastName = "Morant",
                        Relationship = Relationship.Child,
                        DateOfBirth = new DateTime(2021, 5, 18)
                    }
                }
            },
            new()
            {
                Id = 3,
                FirstName = "Michael",
                LastName = "Jordan",
                Salary = 143211.12m,
                DateOfBirth = new DateTime(1963, 2, 17),
                Dependents = new List<GetDependentDto>
                {
                    new()
                    {
                        Id = 4,
                        FirstName = "DP",
                        LastName = "Jordan",
                        Relationship = Relationship.DomesticPartner,
                        DateOfBirth = new DateTime(1974, 1, 2)
                    }
                }
            }
        };
        await response.ShouldReturn(HttpStatusCode.OK, employees);
    }

    [Fact]
    //task: make test pass
    public async Task WhenAskedForAnEmployee_ShouldReturnCorrectEmployee()
    {
        var response = await HttpClient.GetAsync("/api/v1/employees/1");
        var employee = new GetEmployeeDto
        {
            Id = 1,
            FirstName = "LeBron",
            LastName = "James",
            Salary = 75420.99m,
            DateOfBirth = new DateTime(1984, 12, 30)
        };
        await response.ShouldReturn(HttpStatusCode.OK, employee);
    }

    [Fact]
    //task: make test pass
    public async Task WhenAskedForANonexistentEmployee_ShouldReturn404()
    {
        var response = await HttpClient.GetAsync($"/api/v1/employees/{int.MinValue}");
        await response.ShouldReturn(HttpStatusCode.NotFound);
    }

    [Fact]
    public async Task WhenAskedForAnEmployee_ShouldReturnCorrectPaycheckCalculation()
    {

        //https://localhost:7124/api/v1/Employees/${employeeId}/paychecks
        var response = await HttpClient.GetAsync("/api/v1/employees/1/paychecks");
        var employee = new Employee
        {
            Id = 1,
            FirstName = "LeBron",
            LastName = "James",
            Salary = 75420.99m,
            DateOfBirth = new DateTime(1984, 12, 30)
        };
        CalculatePaycheck(employee);
        await response.ShouldReturn(HttpStatusCode.OK, employee);
    }

    private void CalculatePaycheck(Employee employee)
    {

        decimal employeeBaseCost = 1000;
        decimal dependentCost = 600;
        decimal dependentOverThresholdAgeCost = 200;
        decimal employeeSalaryThreshold = 80000;
        decimal employeeSalaryOverThresholdCost = 0.02m;
        int totalNumberOfPaychecksPerYear = 26;

        var dependentsCost = 0m;

        foreach (var dependent in employee.Dependents)
        {
            int age = DateTime.Today.Year - dependent.DateOfBirth.Year;
            dependentsCost += age > 50 ? dependentCost + dependentOverThresholdAgeCost
                                               : dependentCost;
        }

        var overSalaryThresholdCost = employee.Salary > employeeSalaryThreshold
                                      ? employee.Salary * employeeSalaryOverThresholdCost
                                      : 0;
        var benefitsTotalAmount = employeeBaseCost + dependentsCost + overSalaryThresholdCost;

        var monthlyEarnings = Math.Round(employee.Salary / totalNumberOfPaychecksPerYear, 2);
        var monthlyBenefitsDeduction = Math.Round(benefitsTotalAmount / totalNumberOfPaychecksPerYear, 2);

        // now add these to each paycheck in a 26 paycheck cycle
        for (var i = 0; i < totalNumberOfPaychecksPerYear; i++)
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
        employee.Paychecks[totalNumberOfPaychecksPerYear - 1].MonthlyEarnings += Math.Round(
                                            employee.Salary - (monthlyEarnings * totalNumberOfPaychecksPerYear), 2);


        employee.Paychecks[totalNumberOfPaychecksPerYear - 1].BenefitDeductions -= Math.Round(
                                            benefitsTotalAmount - (monthlyBenefitsDeduction * totalNumberOfPaychecksPerYear), 2);
    }
}

