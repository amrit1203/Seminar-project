USE [DataSource2]
GO

CREATE TRIGGER [dbo].[station_trigger1] 
   ON [dbo].[Station]
   AFTER INSERT 

 AS BEGIN
   SET NOCOUNT ON;

   DECLARE
	  @StationId [varchar](50),
	  @StationName [varchar](max),
	  @Lat [real],
	  @Long [real],
	  @Elevation [real]

	  SELECT @StationId = i.[StationId],
	         @StationName = i.[StationName],
	         @Lat = i.[Lat],
	         @Long = i.[Long],
			 @Elevation = i.[Elevation]
	  FROM inserted as i

   IF (NOT EXISTS(
      SELECT [StationId] 
      FROM [Station]
      WHERE [StationId] = @StationId)) 

	BEGIN

	  INSERT INTO [Datawarehouse].[dbo].Station(
	  [Station id],
	  [Station Name],
	  [Latitude],
	  [Longitude],
	  [Elevation]
      ) 
      VALUES (@StationId, @Stationname, @Lat, @Long, @Elevation);

	END
 END

  

  
