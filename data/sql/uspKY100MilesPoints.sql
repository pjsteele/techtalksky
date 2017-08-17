USE [kytechtalk]
GO
/****** Object:  StoredProcedure [dbo].[KY100]    Script Date: 8/17/2017 8:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter PROCEDURE [dbo].[KY100Points]
AS
BEGIN
	SET NOCOUNT ON;

    declare @ky geometry
	set @ky = (select top 1 geometry from States where abbreviation = 'KY')
	
	declare @kyBuffer geometry
	set @kyBuffer = @ky.STBuffer(.5)

	create table #temp (city varchar(255), state varchar(255), [intersects] bit, [geometry] [geometry])

	insert into #temp
	select city, state, [geometry].STIntersects(@kyBuffer) as [intersects], [geometry]  from Cities 

	insert into #temp
	select 'Buffer' as city, '' as state, 1 as [intersects], @kybuffer as [geometry]  


	select * from #temp where intersects = 1
END
