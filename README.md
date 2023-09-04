# Benefits Calculator Api

####Submitted by: Jeff Noble
| Application | Type | link |
| ---- | ----------- | -----------
| Benefits Calculator Web Application | UI | [Git Repository](https://github.com/NobleCauseCode/BenefitsCalculator.www)
| Benefits Calculator Api Application | API/Db | [Git Repository](https://github.com/NobleCauseCode/BenefitsCalculator.Api)

---

## Prerequisites

##### <span style="color:red">\*\*In order to run this project you will need to setup the database and the api. This is documented below. See above for instructions running the web front end application.</span>

---

## Setup

#### Data Layer Creation

This project uses a Sql Server Database for the data repository.
Scripts are in the data folder in the Api c# project.
You can set yours up as follows:
In Sql Server:

1. Create a new datbase called BenefitCalculator.
2. Click New Query button in Sql Mgmt Studio and past and execute create script /data/Scripts/CreateDb.sql
3. Click New Query button in Sql Mgmt Studio and past and execute create script /data/Scripts/Seed-Data.sql

#### Api

1. Open Api project and run it. Simple right? ;)
