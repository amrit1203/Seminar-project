import requests
import csv
import json
import pandas as pd

def filter():
    col_list1 = ["STATION","NAME","LATITUDE","LONGITUDE","ELEVATION","DATE","PRCP","TAVG","TMAX","TMIN"]
    col_list2 = ["STATION ID","STATION NAME","COUNTRY","LATITUDE","LONGITUDE","ELEVATION","DATE","PRCP","TAVG","TMAX","TMIN"]
   
    URL1="https://www.ncei.noaa.gov/orders/cdo/2465389.csv"
    URL2="https://www.ncei.noaa.gov/orders/cdo/2465339.csv"

    df1 = pd.read_csv("NZ1.csv",usecols=col_list1)
    df2 = pd.read_csv("NZ2.csv",usecols=col_list1)
   

    df1[['STATION NAME','COUNTRY']]= df1['NAME'].str.split(',',expand=True)
    df2[['STATION NAME','COUNTRY']]= df2['NAME'].str.split(',',expand=True) 

   

    df1=df1.rename(columns={"STATION": "STATION ID"}) #renaming columns
    df1=df1.filter(col_list2)
    df1.to_csv(r'd1.csv')

    df2=df2.rename(columns={"STATION": "STATION ID"}) #renaming columns
    df2=df2.filter(col_list2)
    df2.to_csv(r'd2.csv')
    #df2.to_csv(r'd2.json')
    
filter()
