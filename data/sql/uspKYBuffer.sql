USE [kytechtalk]
GO
/****** Object:  StoredProcedure [dbo].[KY100]    Script Date: 8/16/2017 5:19:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[KY100]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @ky geometry
	set @ky = (select top 1 geometry from States where abbreviation = 'KY')

	create table #temp (city varchar(255), state varchar(255), [geometry] [geometry])

	insert into #temp
	select 'KY' as name ,'' as state, @ky.STBuffer(.5) as geometry

	insert into #temp
	select 'KY' as name ,'' as state, @ky as geometry

	select * from #temp
END
