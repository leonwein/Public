import click, json, time, math
import robin_stocks as rh
import numpy
from scipy.stats.stats import pearsonr  
from scipy.stats import spearmanr
import yfinance as yf
import csv




    

def main():
    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password'])
    
    stockString = ""
    tick1Prices = []
    tick2Prices = []
    testTick1Prices = []
    testTick2Prices = []
    # tick1OpenPrices = []
    # tick2OpenPrices = []

    testDate = "2020-2-26"
    startDate = "2020-3-26"
    endDate = "2020-04-26"


    with open('Stocks') as w:

        symbols = w.read().splitlines()
        
        for i in range(0,len(symbols)):
            stockString += symbols[i] + " "

        data = yf.download(stockString, start = startDate, end = endDate)
        data2 = yf.download(stockString, start = testDate, end = startDate)
        csvList = []
        print(data)
        print("Working on it chief!")

        
        
        for i in range(0, len(symbols)-1):
            for j in range(i+1,len(symbols)):

                #print(symbols[i], symbols[j])
                tick1Prices = data['Close'][symbols[i]]
                tick2Prices = data['Close'][symbols[j]]
                testTick1Prices = data2['Close'][symbols[i]]
                testTick2Prices = data2['Close'][symbols[j]]
                

                simCo = similarity(symbols[i], symbols[j], testTick1Prices, testTick2Prices)
                csvList.append(backtest(symbols[i],symbols[j], simCo, tick1Prices, tick2Prices))

    with open('stonks.csv', 'w', newline='') as f:
        write = csv.writer(f)   
        write.writerow(['TICK 1','TICK 2','TRADES #', 'GROWTH W ALGO %', 'GROWTH WO ALGO %', 'GROWTH DIFF', 'PROFIT', 'INITIAL BUY', 'COEFFICIENT'])   
        write.writerow(['','','=SUBTOTAL(1,C5:C130000)', '=SUBTOTAL(1,D5:D130000)', '=SUBTOTAL(1,E5:E130000)', '=SUBTOTAL(1,F5:F130000)', '=SUBTOTAL(1,G5:G130000)', '=SUBTOTAL(1,H5:H130000)', '=SUBTOTAL(1,I5:I130000)']) 
        write.writerow([]) 
        write.writerow([]) 
        write.writerows(csvList)
    


                
                
                   




def backtest(tick1, tick2, sim, t1p, t2p):

    
    
    list1 = []
    list2 = []
    
    buySellBack = False
    highMargin = .25-((sim+1)/2.55)**(5.8)
    if .23-((sim+1)/2.55)**(5.8) > 0:
        lowMargin = .23-((sim+1)/2.55)**(5.8)
    else:
        lowMargin = .005

    # print(highMargin,lowMargin)
    
    bsFrac = 1
    lastI = 0
    count = 0
    

    for i in range(0, len(t1p)-1):

        

        if(i == 0):
            #initial buy
            
            s1Amount = 1 
            s2Amount = float(t1p[i])/float(t2p[i])
            
            s1 = s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])
            initialBuy = s1+s2
            invested = s1+s2
            buyPow = 0
            count += 1
            
        
        list1.append((float(t1p[i])-float(t1p[1]))/float(t1p[1]))
        list2.append((float(t2p[i])-float(t2p[1]))/float(t2p[1]))

        
 
        if(list1[i]-list2[i] > highMargin and buySellBack == False):
            #sell from list1 buy from list2 
            list1Sold = True
            buySellBack = True
            s1 = s1Amount*float(t1p[i])-bsFrac*s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])+bsFrac*s2Amount*float(t2p[i])
            invested = s1+s2
            buyPow += bsFrac*s1Amount*float(t1p[i]) - bsFrac*s2Amount*float(t2p[i]) 
           
            
            count += 1
        elif(list1[i]-list2[i] < -highMargin and buySellBack == False):
            #buy from list1 sell from list2
            list1Sold = False
            buySellBack = True
            s1 = s1Amount*float(t1p[i])+bsFrac*s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])-bsFrac*s2Amount*float(t2p[i])
            invested = s1+s2
            buyPow += -bsFrac*s1Amount*float(t1p[i]) + bsFrac*s2Amount*float(t2p[i]) 
          
            
            count += 1
        elif(abs(list1[i]-list2[i]) < lowMargin and buySellBack == True and list1Sold == True):
            #buy and sell back 
            buySellBack = False
            s1 = s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])
            invested = s1+s2
            buyPow += -bsFrac*s1Amount*float(t1p[i]) + bsFrac*s2Amount*float(t2p[i])
  
            
            count += 1
        elif(abs(list1[i]-list2[i]) < lowMargin and buySellBack == True and list1Sold == False):
            #buy and sell back 
            buySellBack = False
            s1 = s1Amount*float(t1p[i])
            s2 = s2Amount*float(t2p[i])
            invested = s1+s2
            buyPow += bsFrac*s1Amount*float(t1p[i]) - bsFrac*s2Amount*float(t2p[i])  
            
            count += 1

        

        
        lastI = i

    if buySellBack == False:
        buyPow += s1Amount*float(t1p[lastI]) + s2Amount*float(t2p[lastI]) 
    elif buySellBack == True and list1Sold == True:
        buyPow += s1Amount*float(t1p[lastI])-bsFrac*s1Amount*float(t1p[lastI]) + s2Amount*float(t2p[lastI])+bsFrac*s2Amount*float(t2p[lastI])
    elif buySellBack == True and list1Sold == False:
        buyPow += s1Amount*float(t1p[lastI])+bsFrac*s1Amount*float(t1p[lastI]) + s2Amount*float(t2p[lastI])-bsFrac*s2Amount*float(t2p[lastI])

    invested = 0
            
   
    growthw = 100*(invested+buyPow-initialBuy)/initialBuy
    growthwo = 100*(s1Amount*float(t1p[lastI]) + s2Amount*float(t2p[lastI])-initialBuy)/initialBuy

    #print("{} {}, {}, {}, {}, {}, {}, {}, {}".format(tick1,tick2, count, growthw, growthwo, growthw-growthwo, invested+buyPow-initialBuy, initialBuy, sim))
    return([tick1,tick2, count, growthw, growthwo, growthw-growthwo, invested+buyPow-initialBuy, initialBuy, sim])
    



    

def similarity(tick1, tick2, t1p, t2p):
    
    
    list1 = []
    list2 = []
    
    for i in range(1, len(t1p)-1):
        list1.append((float(t1p[i])-float(t1p[1]))/float(t1p[1]))
        list2.append((float(t2p[i])-float(t2p[1]))/float(t2p[1]))
        
 
    #print(t1p)
    #print(spearmanr(list1,list2))
    return(spearmanr(list1,list2)[0])


if __name__ == '__main__':
    main()
