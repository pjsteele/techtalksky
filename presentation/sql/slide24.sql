USE [kytechtalk]
GO

Select city, state, population, geography
from Cities

------------------------------------------------

declare @metersPerMile float
set @metersPerMile = 1609.344

declare @osheas geography
set @osheas = geography::STGeomFromText('POINT(-85.724907 38.240768)', 4326);

select city, state, population,
geography.STDistance(@osheas)/@metersPerMile as distance
from Cities