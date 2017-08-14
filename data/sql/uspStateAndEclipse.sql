USE [kytechtalk]
GO

/****** Object:  StoredProcedure [dbo].[StatesAndEclipse]    Script Date: 8/14/2017 9:26:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[StatesAndEclipse]
AS
BEGIN
	SET NOCOUNT ON;

	create table #temp ([name] varchar(255), [geometry] [geometry])

	insert into #temp
	select name, geometry from states
	insert into #temp
	select 'Eclipse 2017' as name, geometry from eclipse

	select * from #temp
END

GO

