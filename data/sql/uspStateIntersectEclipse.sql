USE [kytechtalk]
GO
/****** Object:  StoredProcedure [dbo].[StatesIntersectEclipse]    Script Date: 8/14/2017 1:18:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[StatesIntersectEclipse]
AS
BEGIN
	SET NOCOUNT ON;

	declare @path geometry
	set @path = (select top 1 geometry from eclipse)

	create table #temp ([name] varchar(255), [geometry] [geometry], [intersect] bit)

	insert into #temp
	select name, geometry, geometry.STIntersects(@path) as [intersect] from states 

	insert into #temp
	select 'Eclipse 2017' as name, @path as geometry, 1 as [intersect] 

	select * from #temp where [intersect]  = 1
END
