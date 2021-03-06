USE [kytechtalk]
GO
/****** Object:  StoredProcedure [dbo].[EclipseCities]    Script Date: 8/16/2017 4:12:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[EclipseCities]
AS
BEGIN
	SET NOCOUNT ON;

	declare @metersPerMile float
	set @metersPerMile = 1609.344

	declare @path geography
	set @path = (select top 1 geography from Eclipse)
	
	create table #temp (city varchar(255), state varchar(255), [geography] [geography], distance float)

	insert into #temp
	select city, state, geography,
	geography.STDistance(@path)/@metersPerMile as distance
	from Cities

	insert into #temp
	select 'Eclipse 2017 Path' as name, '' as state, @path as geography, 0 as distance 

	select top 250 city, state, geometry::STGeomFromWKB(geography.STAsBinary(), 4326) as geometry, dbo.geometry2json(geometry::STGeomFromWKB(geography.STAsBinary(), 4326)) as json from #temp order by distance


END
