CREATE TABLE [dbo].[Cities](
	[city] [varchar](255) NOT NULL,
	[state] [varchar](255) NOT NULL,
	[population] int not null,
	[geography] [geography] NOT NULL,
	[geometry] [geometry] NOT NULL
)