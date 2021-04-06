USE [DataSource2]
GO

/** Object:  Table [dbo].[Station_Data]    Script Date: 13-03-2021 16:23:42 **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [DataSource2].[dbo].[Station](
	[StationId] [varchar](50) NOT NULL,
	[StationName] [varchar](max) NOT NULL,
	[Lat] [real] NOT NULL,
	[Long] [real] NOT NULL,
	[Elevation] [real] NOT NULL,
)
GO


alter table [DataSource2].[dbo].[Station]
add constraint pk_station_id primary key clustered(StationId)
GO


USE [DataSource2]
GO

/** Object:  Table [dbo].[Station_Data]    Script Date: 13-03-2021 16:23:42 **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Weather](
	[StationId] [varchar](50) NOT NULL,
	[Date] [date] NOT NULL,
	[Pres] [real] NULL,
	[TAvg] [int] NULL,
	[TMin] [int] NULL,
	[TMax] [int] NULL,
)
GO

alter table [DataSource2].[dbo].[Weather]    
add constraint fk_station_id foreign key([StationId])
    REFERENCES [DataSource2].[dbo].[Station]([StationId]) 
    ON DELETE CASCADE    
    ON UPDATE CASCADE
GO


