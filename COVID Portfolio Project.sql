

select *
from [PortfolioProjectCovid-19]..CovidDeaths
order by 3,4

select *
from [PortfolioProjectCovid-19]..CovidDeaths
where continent is not null
order by 3,4

--select *
--from [PortfolioProjectCovid-19]..CovidVaccinations
--order by 3,4


-- Отберем данные, которые будем использовать

select Location, date, total_cases, new_cases, total_deaths, population
from [PortfolioProjectCovid-19]..CovidDeaths
where continent is not null
order by 1,2

select distinct Location 
from [PortfolioProjectCovid-19]..CovidDeaths

-- Общее число случаев заражения vs общее число смертей
-- Посчитаем вероятность смерти в Беларуси

select Location, date, total_cases, total_deaths,
CONVERT(DECIMAL(15, 3), (CONVERT(DECIMAL(15, 3), total_deaths) / CONVERT(DECIMAL(15, 3), total_cases))*100) AS DeathPercentage
from [PortfolioProjectCovid-19]..CovidDeaths
where Location like '%Be%'
and continent is not null
order by 1,2 desc


-- Общее число случаев заражения vs общее число населения
-- Какой процент населения заражен COVID-19

select Location, date, population, total_cases,
CONVERT(DECIMAL(15, 5), (CONVERT(DECIMAL(15, 5), total_cases) / CONVERT(DECIMAL(15, 5), population))*100) AS PercentagePopulationInfected
from [PortfolioProjectCovid-19]..CovidDeaths
--where Location like '%Ch%'
order by 1,2 desc


-- Страны с самым высоким уровнем заражения в сравнении с населением

select location, population, max(total_cases) as HighestInfectionCount,
max(convert(decimal(15,3),total_cases) / convert(decimal(15,3),population)) AS PercentagePopulationInfected
from [PortfolioProjectCovid-19]..CovidDeaths
group by Location, population
order by PercentagePopulationInfected desc


-- Страны с самым высоким показателем смертности на душу населения

select location, max(cast(Total_deaths as decimal(15,0))) as TotalDeathsCount
from [PortfolioProjectCovid-19]..CovidDeaths
where continent is not null
group by Location
order by TotalDeathsCount desc


-- Ситуация по континентам

select continent, max(cast(Total_deaths as decimal(15,0))) as TotalDeathsCount
from [PortfolioProjectCovid-19]..CovidDeaths
where continent is not null
group by continent
order by TotalDeathsCount desc


-- Глобальные цифры

select date, sum(cast(new_cases as decimal(15,3))) as total_cases,
sum(cast(new_deaths as decimal(15,3))) as total_deaths,
sum(cast(new_deaths as decimal(15,3)))/sum(cast(new_cases as decimal(15,3)))*100 as DeathPercentage
from [PortfolioProjectCovid-19]..CovidDeaths
where continent is not null
group by date
having sum(cast(new_deaths as decimal(15,3))) > 0
order by 1,2

select sum(cast(new_cases as decimal(15,3))) as total_cases,
sum(cast(new_deaths as decimal(15,3))) as total_deaths,
sum(cast(new_deaths as decimal(15,3)))/sum(cast(new_cases as decimal(15,3)))*100 as DeathPercentage
from [PortfolioProjectCovid-19]..CovidDeaths
where continent is not null
having sum(cast(new_deaths as decimal(15,3))) > 0
order by 1,2


-- Сравнение общей численности населения с вакцинированными

select dea.continent, dea.location, dea.date, dea.population,
vac.new_vaccinations,
sum(cast(vac.new_vaccinations as decimal(15,0))) over(partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
from [PortfolioProjectCovid-19]..CovidDeaths dea
join [PortfolioProjectCovid-19]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


-- Используем CTE

with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population,
vac.new_vaccinations,
sum(cast(vac.new_vaccinations as decimal(15,0))) over(partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
from [PortfolioProjectCovid-19]..CovidDeaths dea
join [PortfolioProjectCovid-19]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac


-- Временная таблица

drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population,
vac.new_vaccinations,
sum(cast(vac.new_vaccinations as decimal(15,0))) over(partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
from [PortfolioProjectCovid-19]..CovidDeaths dea
join [PortfolioProjectCovid-19]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


-- Создадим вьюшку для сохранения результатов и дальнейшей визуализации

Create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population,
vac.new_vaccinations,
sum(cast(vac.new_vaccinations as decimal(15,0))) over(partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
from [PortfolioProjectCovid-19]..CovidDeaths dea
join [PortfolioProjectCovid-19]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3


select *
from PercentPopulationVaccinated