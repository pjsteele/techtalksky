select top 2500 city, state, population, 
[geography].[Lat] as latitude, [geography].[Long] as longitude
from Cities order by population desc