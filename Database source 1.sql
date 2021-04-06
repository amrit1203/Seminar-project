USE [DataSource1]
GO

/** Object:  Table [dbo].[Station_Data]    Script Date: 13-03-2021 16:23:42 **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [DataSource1].[dbo].[Station_Data](
	[Station id] [varchar](50) NOT NULL,
	[Station name] [varchar](max) NOT NULL,
	[Latitude] [real] NOT NULL,
	[Longitude] [real] NOT NULL,
	[Elevation] [real] NOT NULL
) 
GO


alter table [DataSource1].[dbo].[Station_Data]
add constraint pk_station_id primary key clustered([Station id])

GO


USE [DataSource1]
GO

/** Object:  Table [dbo].[Station_Data]    Script Date: 13-03-2021 16:23:42 **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [DataSource1].[dbo].[Weather_data](
	[Station id] [varchar](50) NOT NULL,
	[Date] [date] NOT NULL,
	[prcp] [real] NULL,
	[T_Avg] [int] NULL,
	[T_Min] [int] NULL,
	[T_Max] [int] NULL,
) 
GO

alter table [DataSource1].[dbo].[Weather_data]    
add constraint fk_station_id foreign key([Station id])
    REFERENCES dbo.[Station_data]([Station id]) 
    ON DELETE CASCADE    
    ON UPDATE CASCADE
GO
