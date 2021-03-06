USE [master]
GO
/****** Object:  Database [kytechtalk]    Script Date: 8/17/2017 9:17:56 AM ******/
CREATE DATABASE [kytechtalk]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'kytechtalk', FILENAME = N'C:\Dev\repos\github\techtalksky\data\mdf\kytechtalk.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'kytechtalk_log', FILENAME = N'C:\Dev\repos\github\techtalksky\data\mdf\kytechtalk_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [kytechtalk] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [kytechtalk].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [kytechtalk] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [kytechtalk] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [kytechtalk] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [kytechtalk] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [kytechtalk] SET ARITHABORT OFF 
GO
ALTER DATABASE [kytechtalk] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [kytechtalk] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [kytechtalk] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [kytechtalk] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [kytechtalk] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [kytechtalk] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [kytechtalk] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [kytechtalk] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [kytechtalk] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [kytechtalk] SET  DISABLE_BROKER 
GO
ALTER DATABASE [kytechtalk] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [kytechtalk] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [kytechtalk] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [kytechtalk] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [kytechtalk] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [kytechtalk] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [kytechtalk] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [kytechtalk] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [kytechtalk] SET  MULTI_USER 
GO
ALTER DATABASE [kytechtalk] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [kytechtalk] SET DB_CHAINING OFF 
GO
ALTER DATABASE [kytechtalk] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [kytechtalk] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [kytechtalk] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [kytechtalk] SET QUERY_STORE = OFF
GO
USE [kytechtalk]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [kytechtalk]
GO
/****** Object:  UserDefinedFunction [dbo].[geometry2json]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[geometry2json]( @geo geometry)
 RETURNS nvarchar(MAX) AS
 BEGIN
 RETURN (
 '{' +
 (CASE @geo.STGeometryType()
 WHEN 'POINT' THEN
 '"type": "Point","coordinates":' +
 REPLACE(REPLACE(REPLACE(REPLACE(@geo.ToString(),'POINT ',''),'(','['),')',']'),' ',',')
 WHEN 'POLYGON' THEN 
 '"type": "Polygon","coordinates":' +
 '[' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@geo.ToString(),'POLYGON ',''),'(','['),')',']'),'], ',']],['),', ','],['),' ',',') + ']'
 WHEN 'MULTIPOLYGON' THEN 
 '"type": "MultiPolygon","coordinates":' +
 '[' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@geo.ToString(),'MULTIPOLYGON ',''),'(','['),')',']'),'], ',']],['),', ','],['),' ',',') + ']'
 WHEN 'MULTIPOINT' THEN
 '"type": "MultiPoint","coordinates":' +
 '[' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@geo.ToString(),'MULTIPOINT ',''),'(','['),')',']'),'], ',']],['),', ','],['),' ',',') + ']'
 WHEN 'LINESTRING' THEN
 '"type": "LineString","coordinates":' +
 '[' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@geo.ToString(),'LINESTRING ',''),'(','['),')',']'),'], ',']],['),', ','],['),' ',',') + ']'
 ELSE NULL
 END)
 +'}')
 END
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[city] [varchar](255) NOT NULL,
	[state] [varchar](255) NOT NULL,
	[population] [int] NOT NULL,
	[geography] [geography] NOT NULL,
	[geometry] [geometry] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Eclipse]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eclipse](
	[geography] [geography] NOT NULL,
	[geometry] [geometry] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[States]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[name] [varchar](255) NOT NULL,
	[abbreviation] [varchar](255) NOT NULL,
	[capital] [varchar](255) NOT NULL,
	[city] [varchar](255) NOT NULL,
	[population] [varchar](255) NOT NULL,
	[area] [varchar](255) NOT NULL,
	[waterarea] [varchar](255) NOT NULL,
	[landarea] [varchar](255) NOT NULL,
	[houseseats] [varchar](255) NOT NULL,
	[statehood] [varchar](255) NOT NULL,
	[group] [varchar](255) NOT NULL,
	[geography] [geography] NOT NULL,
	[geometry] [geometry] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[Build100MileRadius]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Build100MileRadius]
AS
BEGIN
	SET NOCOUNT ON;

	declare @metersPerMile float
	set @metersPerMile = 1609.344

	declare @osheas geography
	set @osheas = geography::STGeomFromText('POINT(-85.724907 38.240768)', 4326);

	select city, state, population, geography,
	geography.STDistance(@osheas) as distance
	into #temp
	from Cities

	select city,state, population, geography, dbo.geometry2json(geometry::STGeomFromWKB(geography.STAsBinary(), 4326)) as json from #temp where distance < 100 * @metersPerMile
	--select city,state, population, geometry::STGeomFromWKB(geography.STAsBinary(), 4326) as json from #temp where distance < 100 * @metersPerMile

END

GO
/****** Object:  StoredProcedure [dbo].[EclipseCities]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EclipseCities]
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

GO
/****** Object:  StoredProcedure [dbo].[KY100]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KY100]
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

GO
/****** Object:  StoredProcedure [dbo].[KY100Points]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KY100Points]
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


	select *, dbo.geometry2json(geometry) as json from #temp where intersects = 1
END

GO
/****** Object:  StoredProcedure [dbo].[StatesAndEclipse]    Script Date: 8/17/2017 9:17:56 AM ******/
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
/****** Object:  StoredProcedure [dbo].[StatesIntersectEclipse]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[StatesIntersectEclipse]
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

GO
/****** Object:  StoredProcedure [dbo].[StatesIntersectEclipseJson]    Script Date: 8/17/2017 9:17:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[StatesIntersectEclipseJson]
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

	select name, dbo.geometry2json(geometry) as json from #temp where [intersect]  = 1
END

GO
USE [master]
GO
ALTER DATABASE [kytechtalk] SET  READ_WRITE 
GO
