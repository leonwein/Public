from pytrends.request import TrendReq

#Connect to google
pytrends = TrendReq(hl='en-US', tz=360)

#Build payload
kw_list = ["Blockchain"]
pytrends.build_payload(kw_list, timeframe='today 5-y', geo='US')

pytrends.interest_over_time()