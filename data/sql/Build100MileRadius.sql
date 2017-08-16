USE [kytechtalk]
GO
/****** Object:  StoredProcedure [dbo].[Build100MileRadius]    Script Date: 8/16/2017 9:18:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Build100MileRadius]
AS
BEGIN
	SET NOCOUNT ON;

	declare @metersPerMile float
	set @metersPerMile = 1609.344

	declare @osheas geography
	set @osheas = geography::STGeomFromText('POINT(-85.724907 38.240768)', 4326);

	select city, state, population, geography,
	geography.STDistance(@osheas) as distance
	from Cities
END
