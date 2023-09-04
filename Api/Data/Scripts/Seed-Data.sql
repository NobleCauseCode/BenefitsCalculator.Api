USE [BenefitCalculator]
GO
DELETE FROM [dbo].[Dependents]
GO
DELETE FROM [dbo].[DependentTypes]
GO
DELETE FROM [dbo].[Employees]
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 
GO
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [DateOfBirth], [Salary], [IsActive], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, N'LeBron', N'James', CAST(N'1984-12-30T00:00:00.000' AS DateTime), CAST(75420.99 AS Decimal(19, 2)), 1, CAST(N'2023-09-01T17:10:24.830' AS DateTime), CAST(N'2023-09-01T17:10:24.830' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [DateOfBirth], [Salary], [IsActive], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, N'Ja', N'Morant', CAST(N'1999-08-10T00:00:00.000' AS DateTime), CAST(92365.22 AS Decimal(19, 2)), 1, CAST(N'2023-09-01T17:11:43.537' AS DateTime), CAST(N'2023-09-01T17:11:43.537' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [DateOfBirth], [Salary], [IsActive], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (3, N'Michael', N'Jordan', CAST(N'1963-02-17T00:00:00.000' AS DateTime), CAST(143211.12 AS Decimal(19, 2)), 1, CAST(N'2023-09-02T13:50:09.790' AS DateTime), CAST(N'2023-09-02T13:50:09.790' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[DependentTypes] ON 
GO
INSERT [dbo].[DependentTypes] ([DependentTypeId], [Name], [Value], [IsActive]) VALUES (0, N'None', N'NONE', 1)
GO
INSERT [dbo].[DependentTypes] ([DependentTypeId], [Name], [Value], [IsActive]) VALUES (1, N'Spouse', N'SPOUSE', 1)
GO
INSERT [dbo].[DependentTypes] ([DependentTypeId], [Name], [Value], [IsActive]) VALUES (2, N'Domestic Partner', N'DOMESTICPARTNER', 1)
GO
INSERT [dbo].[DependentTypes] ([DependentTypeId], [Name], [Value], [IsActive]) VALUES (3, N'Child', N'CHILD', 1)
GO
SET IDENTITY_INSERT [dbo].[DependentTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Dependents] ON 
GO
INSERT [dbo].[Dependents] ([DependentId], [EmployeeId], [DependentTypeId], [FirstName], [LastName], [DateOfBirth], [Relationship], [IsActive], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, 2, 1, N'Spouse', N'Morant', CAST(N'1998-03-03T00:00:00.000' AS DateTime), 1, 1, CAST(N'2023-09-02T13:51:15.200' AS DateTime), CAST(N'2023-09-02T13:51:15.200' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Dependents] ([DependentId], [EmployeeId], [DependentTypeId], [FirstName], [LastName], [DateOfBirth], [Relationship], [IsActive], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, 2, 3, N'Child1', N'Morant', CAST(N'2020-06-23T00:00:00.000' AS DateTime), 3, 1, CAST(N'2023-09-02T13:51:56.243' AS DateTime), CAST(N'2023-09-02T13:51:56.243' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Dependents] ([DependentId], [EmployeeId], [DependentTypeId], [FirstName], [LastName], [DateOfBirth], [Relationship], [IsActive], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (3, 2, 3, N'Child2', N'Morant', CAST(N'2021-05-18T00:00:00.000' AS DateTime), 3, 1, CAST(N'2023-09-02T13:52:20.507' AS DateTime), CAST(N'2023-09-02T13:52:20.507' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Dependents] ([DependentId], [EmployeeId], [DependentTypeId], [FirstName], [LastName], [DateOfBirth], [Relationship], [IsActive], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (4, 3, 2, N'DP', N'Jordan', CAST(N'1974-01-02T00:00:00.000' AS DateTime), 2, 1, CAST(N'2023-09-02T13:52:57.653' AS DateTime), CAST(N'2023-09-02T13:52:57.653' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Dependents] OFF
GO
