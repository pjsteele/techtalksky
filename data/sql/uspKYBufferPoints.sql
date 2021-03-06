USE [kytechtalk]
GO
/****** Object:  StoredProcedure [dbo].[KYBufferPoints]    Script Date: 8/17/2017 9:42:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[KYBufferPoints]
	@all integer
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
	select '' as city, 'KY' as state, 1 as [intersects], @ky as [geometry]  

	insert into #temp
	select '' as city, 'KY Boundary' as state, 1 as [intersects], @kybuffer as [geometry]  

	if @all = 0 select *, dbo.geometry2json(geometry) as json from #temp 
	if @all = 1 select *, dbo.geometry2json(geometry) as json from #temp where intersects = 1

END
