USE [kytechtalk]
GO

/****** Object:  Table [dbo].[Cities]    Script Date: 8/13/2017 3:58:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cities](
	[AREANAME] [varchar](255) NOT NULL,
	[CLASS] [varchar](255) NOT NULL,
	[ST] [varchar](255) NOT NULL,
	[STFIPS] [varchar](255) NOT NULL,
	[PLACEFIP] [varchar](255) NOT NULL,
	[CAPITAL] [varchar](255) NOT NULL,
	[AREALAND] [varchar](255) NOT NULL,
	[AREAWATER] [varchar](255) NOT NULL,
	[POP_CL] [varchar](255) NOT NULL,
	[POP2000] [varchar](255) NOT NULL,
	[WHITE] [varchar](255) NOT NULL,
	[BLACK] [varchar](255) NOT NULL,
	[AMERI_ES] [varchar](255) NOT NULL,
	[ASIAN] [varchar](255) NOT NULL,
	[HAWN_PI] [varchar](255) NOT NULL,
	[OTHER] [varchar](255) NOT NULL,
	[MULT_RACE] [varchar](255) NOT NULL,
	[HISPANIC] [varchar](255) NOT NULL,
	[MALES] [varchar](255) NOT NULL,
	[FEMALES] [varchar](255) NOT NULL,
	[AGE_UNDER5] [varchar](255) NOT NULL,
	[AGE_5_17] [varchar](255) NOT NULL,
	[AGE_18_21] [varchar](255) NOT NULL,
	[AGE_22_29] [varchar](255) NOT NULL,
	[AGE_30_39] [varchar](255) NOT NULL,
	[AGE_40_49] [varchar](255) NOT NULL,
	[AGE_50_64] [varchar](255) NOT NULL,
	[AGE_65_UP] [varchar](255) NOT NULL,
	[MED_AGE] [varchar](255) NOT NULL,
	[MED_AGE_M] [varchar](255) NOT NULL,
	[MED_AGE_F] [varchar](255) NOT NULL,
	[HOUSEHOLDS] [varchar](255) NOT NULL,
	[AVE_HH_SZ] [varchar](255) NOT NULL,
	[HSEHLD_1_M] [varchar](255) NOT NULL,
	[HSEHLD_1_F] [varchar](255) NOT NULL,
	[MARHH_CHD] [varchar](255) NOT NULL,
	[MARHH_NO_C] [varchar](255) NOT NULL,
	[MHH_CHILD] [varchar](255) NOT NULL,
	[FHH_CHILD] [varchar](255) NOT NULL,
	[FAMILIES] [varchar](255) NOT NULL,
	[AVE_FAM_SZ] [varchar](255) NOT NULL,
	[HSE_UNITS] [varchar](255) NOT NULL,
	[VACANT] [varchar](255) NOT NULL,
	[OWNER_OCC] [varchar](255) NOT NULL,
	[RENTER_OCC] [varchar](255) NOT NULL,
	[geography] [geography] NOT NULL,
	[geometry] [geometry] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

