USE [Datawarehouse]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Datawarehouse].[dbo].[Station](
	[Station id] [varchar](50) NOT NULL,
	[Station Name] [varchar](MAX) NOT NULL,
	[Latitude] [real] NOT NULL,
	[Longitude] [real] NOT NULL,
	[Elevation] [real] NOT NULL
) 
GO

alter table [Datawarehouse].[dbo].[Station]
add constraint pk_dw_station_id primary key clustered([Station id])
GO




USE [Datawarehouse]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Datawarehouse].[dbo].[Date_dim](
	[Date] [date] NOT NULL,
	[Date_num] [int] NOT NULL,
	[month_num] [int] NULL,
	[year_num] [int] NULL
) 
GO

alter table [Datawarehouse].[dbo].[Date_dim]
add constraint pk_dw_date primary key clustered([Date])
GO

USE [Datawarehouse]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Datawarehouse].[dbo].[FactWeather](
	[Station id] [varchar](50) NOT NULL,
	[Date] [date] NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[PRCP] [real],
	[TAVG] [int],
	[TMIN] [int],
	[TMAX] [int]
) 
GO





/** INSERT INTO DATAWAREHOUSE FACT WEATHER TABLE **/

INSERT INTO [Datawarehouse].[dbo].[FactWeather]
SELECT [Station id]
      ,[Date]
	  ,'US'
      ,[PRCP]
      ,[T_Avg]
      ,[T_Min]
      ,[T_Max]
FROM [DataSource1].[dbo].[Weather_data]

UNION

SELECT [StationId]
       ,[Date]
	   ,'NZ'
	   ,[Pres]
	   ,[TAvg]
	   ,[TMin]
	   ,[TMax]
FROM [DataSource2].[dbo].[Weather]


GO


/** INSERT INTO DATAWAREHOUSE STATION TABLE **/

INSERT INTO [Datawarehouse].[dbo].[Station]
SELECT [Station id],
	[Station Name],
	[Latitude],
	[Longitude],
	[Elevation]
FROM [DataSource1].[dbo].[Station_Data]

UNION

SELECT [StationId],
	[StationName],
	[Lat],
	[Long],
	[Elevation]
FROM [DataSource2].[dbo].[Station]


GO

/** INSERT INTO DATAWAREHOUSE DATE TABLE **/

INSERT INTO [Datawarehouse].[dbo].[Date_dim]
SELECT [Date],
        DATEPART(day, [Date]),
        MONTH([Date]),
        YEAR([Date])
FROM [DataSource1].[dbo].[Weather_Data]

UNION

SELECT [Date],
       DATEPART(day, [Date]),
       MONTH([Date]),
       YEAR([Date])
FROM [DataSource2].[dbo].[Weather]



alter table [Datawarehouse].[dbo].[FactWeather]    
add constraint fk_dw_station_id foreign key([Station id])
    REFERENCES dbo.[Station]([Station id]) 
    ON DELETE CASCADE    
    ON UPDATE CASCADE
GO

alter table [Datawarehouse].[dbo].[FactWeather]    
add constraint fk_dw_date foreign key([Date])
    REFERENCES dbo.[Date_dim]([Date]) 
    ON DELETE CASCADE    
    ON UPDATE CASCADE
GO
