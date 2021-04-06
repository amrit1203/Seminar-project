CREATE TRIGGER [dbo].[station_trg] 
   ON [DataSource1].[dbo].[Weather_data] AFTER INSERT 
 AS BEGIN
   SET NOCOUNT ON;
   DECLARE
	  @StationId [varchar](50),
	  @Date_created [date],
	  @PRCP [real],
	  @T_AVG [int],
	  @T_MIN [int],
	  @T_MAX [int]

      SELECT @StationId = i.[Station id], @Date_created = i.[Date], @PRCP = i.[PRCP],
	         @T_AVG = i.[T_Avg], @T_MIN = i.[T_Min], @T_MAX = i.[T_Max] FROM inserted as i

   IF (EXISTS(SELECT [Station id] FROM [Station_data] WHERE [Station id] = @StationId))  
	BEGIN
	if(NOT EXISTS(SELECT [Date] from [Datawarehouse].[dbo].[Date_dim] WHERE [Date] = @Date_created))
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
      VALUES (@StationId, @Date_created , 'US', @PRCP, @T_AVG, @T_MIN, @T_MAX);

	END
 END
  

  
