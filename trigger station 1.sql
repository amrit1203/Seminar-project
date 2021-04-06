USE [DataSource1]
GO

CREATE TRIGGER [dbo].[station_trigger1] 
   ON [dbo].[Station_Data]
   AFTER INSERT 

 AS BEGIN
   SET NOCOUNT ON;

   DECLARE
	  @StationId [varchar](50),
	  @Stationname [varchar](max),
	  @Latitude [real],
	  @Longitude [real],
	  @Elevation [real]

	  SELECT @StationId = i.[Station id],
	         @Stationname = i.[Station name],
	         @Latitude = i.[Latitude],
	         @Longitude = i.[Longitude],
			 @Elevation = i.[Elevation]
	  FROM inserted as i

   IF (NOT EXISTS(
      SELECT [Station id] 
      FROM [Station_data]
      WHERE [Station id] = @StationId)) 

	BEGIN

	  INSERT INTO [Datawarehouse].[dbo].Station(
	  [Station id],
	  [Station Name],
	  [Latitude],
	  [Longitude],
	  [Elevation]
      ) 
      VALUES (@StationId, @Stationname, @Latitude, @Longitude, @Elevation);

	END
 END

  

  
