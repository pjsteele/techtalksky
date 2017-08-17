USE [kytechtalk]
GO

declare @path geometry
set @path = (select top 1 geometry from eclipse)

select name, 
geometry.STIntersects(@path) as [intersect] 
from states 