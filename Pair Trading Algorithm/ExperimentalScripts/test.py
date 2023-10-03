import click, json, time, math
import robin_stocks as rh
import numpy
from scipy.stats.stats import pearsonr  
from scipy.stats import spearmanr
import yfinance as yf


def main(): 
    data = yf.download("JPM", start="2017-01-01", end="2017-04-30")
    #tick1 = yf.Ticker("MSFT")
    print(data)
   
if __name__ == '__main__':
    main()