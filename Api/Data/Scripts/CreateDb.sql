USE [BenefitCalculator]
GO
/****** Object:  Trigger [LimitOneSpouseOrPartner]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP TRIGGER IF EXISTS [dbo].[LimitOneSpouseOrPartner]
GO
/****** Object:  StoredProcedure [dbo].[stp_Employees_GetById]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[stp_Employees_GetById]
GO
/****** Object:  StoredProcedure [dbo].[stp_Employees_Get]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[stp_Employees_Get]
GO
/****** Object:  StoredProcedure [dbo].[stp_Dependents_GetById]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[stp_Dependents_GetById]
GO
/****** Object:  StoredProcedure [dbo].[stp_Dependents_GetByEmployee]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[stp_Dependents_GetByEmployee]
GO
/****** Object:  StoredProcedure [dbo].[stp_Dependents_Get]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[stp_Dependents_Get]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dependents]') AND type in (N'U'))
ALTER TABLE [dbo].[Dependents] DROP CONSTRAINT IF EXISTS [FK_Dependents_Employees]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dependents]') AND type in (N'U'))
ALTER TABLE [dbo].[Dependents] DROP CONSTRAINT IF EXISTS [FK_Dependents_DependentTypes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
ALTER TABLE [dbo].[Employees] DROP CONSTRAINT IF EXISTS [DF_Employees_ModifiedDate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
ALTER TABLE [dbo].[Employees] DROP CONSTRAINT IF EXISTS [DF_Employees_CreatedDate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
ALTER TABLE [dbo].[Employees] DROP CONSTRAINT IF EXISTS [DF_Employees_IsActive]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DependentTypes]') AND type in (N'U'))
ALTER TABLE [dbo].[DependentTypes] DROP CONSTRAINT IF EXISTS [DF_DependentTypes_IsActive]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dependents]') AND type in (N'U'))
ALTER TABLE [dbo].[Dependents] DROP CONSTRAINT IF EXISTS [DF_Dependents_ModifiedDate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dependents]') AND type in (N'U'))
ALTER TABLE [dbo].[Dependents] DROP CONSTRAINT IF EXISTS [DF_Dependents_CreatedDate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dependents]') AND type in (N'U'))
ALTER TABLE [dbo].[Dependents] DROP CONSTRAINT IF EXISTS [DF_Dependents_IsActive]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP TABLE IF EXISTS [dbo].[Employees]
GO
/****** Object:  Table [dbo].[DependentTypes]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP TABLE IF EXISTS [dbo].[DependentTypes]
GO
/****** Object:  Table [dbo].[Dependents]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP TABLE IF EXISTS [dbo].[Dependents]
GO
USE [master]
GO
/****** Object:  Database [BenefitCalculator]    Script Date: 9/4/2023 12:54:38 PM ******/
DROP DATABASE IF EXISTS [BenefitCalculator]
GO
/****** Object:  Database [BenefitCalculator]    Script Date: 9/4/2023 12:54:38 PM ******/
CREATE DATABASE [BenefitCalculator]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BenefitCalculator', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BenefitCalculator.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BenefitCalculator_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BenefitCalculator_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BenefitCalculator] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BenefitCalculator].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BenefitCalculator] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BenefitCalculator] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BenefitCalculator] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BenefitCalculator] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BenefitCalculator] SET ARITHABORT OFF 
GO
ALTER DATABASE [BenefitCalculator] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BenefitCalculator] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BenefitCalculator] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BenefitCalculator] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BenefitCalculator] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BenefitCalculator] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BenefitCalculator] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BenefitCalculator] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BenefitCalculator] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BenefitCalculator] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BenefitCalculator] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BenefitCalculator] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BenefitCalculator] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BenefitCalculator] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BenefitCalculator] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BenefitCalculator] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BenefitCalculator] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BenefitCalculator] SET RECOVERY FULL 
GO
ALTER DATABASE [BenefitCalculator] SET  MULTI_USER 
GO
ALTER DATABASE [BenefitCalculator] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BenefitCalculator] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BenefitCalculator] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BenefitCalculator] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BenefitCalculator] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BenefitCalculator] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BenefitCalculator', N'ON'
GO
ALTER DATABASE [BenefitCalculator] SET QUERY_STORE = OFF
GO
USE [BenefitCalculator]
GO
/****** Object:  Table [dbo].[Dependents]    Script Date: 9/4/2023 12:54:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dependents](
	[DependentId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[DependentTypeId] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [datetime] NULL,
	[Relationship] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](15) NULL,
	[ModifiedBy] [nvarchar](15) NULL,
 CONSTRAINT [PK_Dependents] PRIMARY KEY CLUSTERED 
(
	[DependentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DependentTypes]    Script Date: 9/4/2023 12:54:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DependentTypes](
	[DependentTypeId] [int] IDENTITY(0,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Value] [nvarchar](25) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_DependentTypes] PRIMARY KEY CLUSTERED 
(
	[DependentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 9/4/2023 12:54:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](25) NOT NULL,
	[LastName] [nvarchar](25) NOT NULL,
	[DateOfBirth] [datetime] NULL,
	[Salary] [decimal](19, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](15) NULL,
	[ModifiedBy] [nvarchar](15) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dependents] ADD  CONSTRAINT [DF_Dependents_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Dependents] ADD  CONSTRAINT [DF_Dependents_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Dependents] ADD  CONSTRAINT [DF_Dependents_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[DependentTypes] ADD  CONSTRAINT [DF_DependentTypes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Employees_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Employees_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Employees_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[Dependents]  WITH CHECK ADD  CONSTRAINT [FK_Dependents_DependentTypes] FOREIGN KEY([DependentTypeId])
REFERENCES [dbo].[DependentTypes] ([DependentTypeId])
GO
ALTER TABLE [dbo].[Dependents] CHECK CONSTRAINT [FK_Dependents_DependentTypes]
GO
ALTER TABLE [dbo].[Dependents]  WITH CHECK ADD  CONSTRAINT [FK_Dependents_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Dependents] CHECK CONSTRAINT [FK_Dependents_Employees]
GO
/****** Object:  StoredProcedure [dbo].[stp_Dependents_Get]    Script Date: 9/4/2023 12:54:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stp_Dependents_Get]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT	DependentId AS Id, EmployeeId, FirstName, LastName, DateOfBirth, Relationship
		FROM	Dependents d WITH (NOLOCK)
		WHERE	IsActive = 1
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
  
        SELECT  @ErrorMessage = ERROR_MESSAGE(), 
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()        
  
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[stp_Dependents_GetByEmployee]    Script Date: 9/4/2023 12:54:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- stp_Dependents_GetByEmployee 1
CREATE PROCEDURE [dbo].[stp_Dependents_GetByEmployee]
	@EmployeeId INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT	d.DependentId AS Id, d.FirstName, d.LastName, d.DateOfBirth, d.DependentTypeId AS Relationship,
				e.EmployeeId
		FROM	Dependents d WITH (NOLOCK)
				INNER JOIN Employees e WITH (NOLOCK)
					ON D.EmployeeId = e.EmployeeId
				INNER JOIN DependentTypes dt WITH (NOLOCK)
					ON d.DependentTypeId = dt.DependentTypeId
		WHERE	e.EmployeeId = @EmployeeId
				AND d.IsActive = 1
				
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
  
        SELECT  @ErrorMessage = ERROR_MESSAGE(), 
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()        
  
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[stp_Dependents_GetById]    Script Date: 9/4/2023 12:54:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stp_Dependents_GetById]
	@dependentId INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT	DependentId AS Id, FirstName, LastName, DateOfBirth, d.DependentTypeId AS Relationship, d.EmployeeId
		FROM	Dependents d WITH (NOLOCK)
		WHERE	d.DependentId = @dependentId
				AND IsActive = 1
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
  
        SELECT  @ErrorMessage = ERROR_MESSAGE(), 
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()        
  
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[stp_Employees_Get]    Script Date: 9/4/2023 12:54:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stp_Employees_Get]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT EmployeeId AS Id, FirstName, LastName, ROUND(Salary,2) AS Salary, DateOfBirth
		FROM Employees E WITH (NOLOCK)
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
  
        SELECT  @ErrorMessage = ERROR_MESSAGE(), 
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()        
  
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[stp_Employees_GetById]    Script Date: 9/4/2023 12:54:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- stp_Employees_GetById 1
CREATE PROCEDURE [dbo].[stp_Employees_GetById]
	@employeeId INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT	EmployeeId AS Id, FirstName, LastName, ROUND(Salary,2) AS Salary, DateOfBirth
		FROM	Employees e WITH (NOLOCK)
		WHERE	e.EmployeeId = @employeeId
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
        DECLARE @ErrorState INT
  
        SELECT  @ErrorMessage = ERROR_MESSAGE(), 
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()        
  
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/****** Object:  Trigger [dbo].[LimitOneSpouseOrPartner]    Script Date: 9/4/2023 12:54:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[LimitOneSpouseOrPartner]
ON [dbo].[Dependents] 
AFTER INSERT, UPDATE 
AS
BEGIN
  IF EXISTS (
    SELECT 1 
    FROM Dependents d
    INNER JOIN inserted i ON i.EmployeeId = d.EmployeeId
    WHERE i.DependentTypeId = 1 AND d.DependentTypeId = 2
    OR i.DependentTypeId = 2 AND d.DependentTypeId = 1
  )
  BEGIN
    RAISERROR('An employee can only have one spouse or domestic partner', 16, 1); 
    ROLLBACK TRANSACTION;
  END
END
GO
ALTER TABLE [dbo].[Dependents] ENABLE TRIGGER [LimitOneSpouseOrPartner]
GO
USE [master]
GO
ALTER DATABASE [BenefitCalculator] SET  READ_WRITE 
GO
