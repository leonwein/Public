#Uses Pytrends package, see documentation here: https://pypi.org/project/pytrends/
from pytrends.request import TrendReq
from pathlib import Path
import pandas as pd
import math

cfips = pd.read_csv(r'C:\Users\sbsla\OneDrive\Desktop\Stat_222_Proj\DATA\cfips_to_county_name.csv')

#Keywords to scrape
county_level_kws = ['tax', 'loan', 'business', 'rent', 'college', 'apartments', 'office', 'insurance'] #e.g. "XX county tax"
state_level_kws = ['tax', 'loan', 'business', 'rent', 'college', 'apartments', 'office', 'insurance', 'Business plan templates', 'Small business ideas', 'How to start a small business', 'office space for rent', 'website hosting service', 'freelancing', 'side hustle', 'ecommerce'] #e.g. "tax"

#Connect to google
pytrends = TrendReq(hl='en-US', tz=360)

#Build payload
kw_list = ["Santa Barbara County Business"]   #<---------------ENTER SEARCH PHRASE HERE
pytrends.build_payload(kw_list, timeframe='today 5-y', geo='US') #Can specify individual states, e.g. california would be geo='US-CA'

result = pytrends.interest_over_time()

#kw = kw_list[0].replace(' ','_')
#result.to_csv(f'{Path(__file__).parent}\GTrends_{kw}.csv')