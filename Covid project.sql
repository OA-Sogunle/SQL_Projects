--select the data

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM public."CovidDeaths"
ORDER BY 1,2

--Total cases vs total deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM public."CovidDeaths"
WHERE location like '%Nigeria%'
ORDER BY 1,2

--Total % of death out of the entire population in Nigeria

SELECT (max(total_deaths)/avg(cast(population as integer))*100) as totaldeaths
FROM public."CovidDeaths"
WHERE location like '%Nigeria%'

--Verify the above by getting info separately

SELECT total_deaths, population
FROM public."CovidDeaths"
WHERE location like '%Nigeria%'

--Country with the highest death

SELECT location, (max(total_deaths)/avg(cast(population as bigint))*100) as percentage
FROM public."CovidDeaths"
GROUP BY location
ORDER BY percentage desc

--Total % of covid positive cases in Nigeria

SELECT (max(total_cases)/avg(cast(population as bigint))*100) as percentagepositive
FROM public."CovidDeaths"
WHERE location like '%Nigeria%'

--Total % of covid positive cases in the whole world

SELECT location, (max(total_cases)/avg(cast(population as bigint))*100) as percentagepositive
FROM public."CovidDeaths"
GROUP BY location
ORDER BY percentagepositive desc

--continent wise positive cases

SELECT location, max(total_cases) as total_cases
FROM public."CovidDeaths"
WHERE continent is null
GROUP BY location
ORDER BY total_cases desc

--Daily newcases vs hospitalization vs icu_patients in Nigeria

SELECT date, new_cases, hosp_patients, icu_patients
FROM public."CovidDeaths"
WHERE location like '%Nigeria%'

--Countrywise age > 65

SELECT "CovidDeaths".location, "CovidVaccinations".aged_65_older
FROM "CovidDeaths" 
JOIN "CovidVaccinations" ON "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date

--Countrywise total vaccinated person

SELECT "CovidDeaths".location as country, (max("CovidVaccinations".people_fully_vaccinated)) as fully_vaccinated
FROM "CovidDeaths" 
JOIN "CovidVaccinations" ON "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date
WHERE "CovidDeaths".continent is not null
GROUP BY country
ORDER BY fully_vaccinated