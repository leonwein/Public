import click, json, time, math
import robin_stocks as rh
import numpy
from scipy.stats.stats import pearsonr  
from scipy.stats import spearmanr
import yfinance as yf



    # data = yf.download("SPY AAPL", start="2017-01-01", end="2017-04-30")
    # print(data['Close']['SPY'][3])


    

def main():
    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password'])
    
    stockString = ""
    tick1Prices = []
   

   
    startDate = "2020-01-27"
    endDate = "2021-01-27"


    with open('Stocks') as w:

        symbols = w.read().splitlines()
        
        for i in range(0,len(symbols)):
            stockString += symbols[i] + " "

        data = yf.download(stockString, start = startDate, end = endDate)
        
        
        

        
        
        for i in range(0,len(symbols)):
           
            tick1Prices = data['Close'][symbols[i]]
            # simCo = similarity(symbols[i], symbols[j], testTick1Prices, testTick2Prices)
            backtest(symbols[i], tick1Prices)
    


                
                
                   




def backtest(tick , t1p):

    
    growthwo = 100*(float(t1p[len(t1p)-1])-float(t1p[0]))/float(t1p[0])
    print(growthwo)

   
    



    

def similarity(tick1, tick2, t1p, t2p):
    
    
    list1 = []
    list2 = []
    
    for i in range(0, len(t1p)):
        list1.append((float(t1p[i])-float(t1p[0]))/float(t1p[0]))
        list2.append((float(t2p[i])-float(t2p[0]))/float(t2p[0]))
        
 

    return(spearmanr(list1,list2)[0])


if __name__ == '__main__':
    main()
