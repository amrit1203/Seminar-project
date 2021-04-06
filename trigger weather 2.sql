CREATE TRIGGER [dbo].[station_trg2] 
   ON [dbo].[Weather] AFTER INSERT 
 AS BEGIN
   SET NOCOUNT ON;
   DECLARE
	  @StationId [varchar](50),
	  @Date_created [date],
	  @PRCP [real],
	  @T_AVG [int],
	  @T_MIN [int],
	  @T_MAX [int]

	  SELECT @StationId = i.[StationId], @Date_created = i.[Date], @PRCP = i.[Pres], @T_AVG = i.[TAvg],
	         @T_MIN = i.[TMin], @T_MAX = i.[TMax] FROM inserted as i

   IF (EXISTS(SELECT [StationId] FROM [Station] WHERE [StationId] = @StationId))
	BEGIN
	  IF(NOT EXISTS(SELECT [Date] from [Datawarehouse].[dbo].[Date_dim] WHERE [Date] = @Date_created))
	  BEGIN
	    INSERT INTO [Datawarehouse].[dbo].[Date_dim](
	    [Date],
	    [Date_num],
	    [month_num],
	    [year_num]
        )
	    VALUES (@Date_created,  DATEPART(day, @Date_created), MONTH(@Date_created), YEAR(@Date_created));
      END
	  INSERT INTO [Datawarehouse].[dbo].[FactWeather](
	  [Station id],
	  [Date],
	  [Country],
	  [PRCP],
	  [TAVG],
	  [TMIN],
	  [TMAX]
      ) 
      VALUES (@StationId, @Date_created, 'NZ', @PRCP, @T_AVG, @T_MIN, @T_MAX);
	  
	END
 END