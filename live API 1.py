import requests
import datetime 
import csv
from get_stations import get_us_stations
from contextlib import closing
import codecs
from connection import connection

url = "https://www.ncei.noaa.gov/access/services/data/v1?dataset=daily-summaries"
columns = ['STATION','NAME','PRCP','TAVG','TMAX','TMIN']
date = (datetime.date.today() - datetime.timedelta(days=11)).strftime("%Y-%m-%d")
stations = get_us_stations()

for s in range(0, len(stations), 50):
    params = {'startDate': date,
        'endDate': date,
        'stations': stations[s:  s+50 if s+50 < len(stations) else None],
        'dataTypes': columns, 
        'format':'csv'}

    with closing(requests.get(url = url, params=params, stream=True)) as req:
        url_content = csv.DictReader(codecs.iterdecode(req.iter_lines(), 'utf-8'), delimiter =',', quotechar='"')

        for row in url_content:
            cursor = connection("DataSource1")
            cursor.execute("INSERT INTO DataSource1.dbo.Weather_data VALUES(?, ?, ?, ?, ?, ?)",
                   row["STATION"], 
                   row["DATE"], 
                   row["PRCP"] if row["PRCP"] else 0.0,
                   row["TAVG"] if row["TAVG"] else 0, 
                   row["TMAX"] if row["TMAX"] else 0, 
                   row["TMIN"] if row["TMIN"] else 0)


