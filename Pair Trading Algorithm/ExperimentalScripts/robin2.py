import click, json, time, math
import robin_stocks as rh
import numpy
from scipy.stats.stats import pearsonr  
from scipy.stats import spearmanr

def main():
    content = open('config.json').read()
    config = json.loads(content)
    rh.login(config['username'], config['password'])

    with open('Stocks') as w:

        symbols = w.read().splitlines()
        
        for i in range(0,len(symbols)-2):
            for j in range(i+1,len(symbols)-1):
                simCo = similarity(symbols[i], symbols[j])
                backtest(symbols[i],symbols[j], simCo)
                
                
                   




def backtest(tick1, tick2, sim):
    historyDict1 = rh.stocks.get_stock_historicals(tick1, interval = 'day', span = 'year', bounds = 'regular', info = None)
    historyDict2 = rh.stocks.get_stock_historicals(tick2, interval = 'day', span = 'year', bounds = 'regular', info = None)
    list1 = []
    list2 = []
    
    buySellBack = False
    afterBuy = False
    startLists = False
    highMargin = .25-(sim/1.8)**(2.4)
    if(.23-(sim/1.8)**(2.4) > 0):
        lowMargin = .23-(sim/1.8)**(2.4)
    else:
        lowMargin = .005

    # print(highMargin,lowMargin)
    
    bsFrac = 1
    lastI = 0
    count = 0
    
    

    for i, hist in enumerate(historyDict1, start=0):

        
        
        #print("{}   |   {}".format(100*(list1[i]-list2[i]), hist['begins_at']))
        
        

        if(hist['begins_at'] == '2020-01-27T00:00:00Z'): #'2020-01-27T00:00:00Z'
            #initial buy
            afterBuy = True
            s1Amount = 1 
            s2Amount = float(hist['close_price'])/float(historyDict2[i]['close_price'])
            
            s1 = s1Amount*float(hist['close_price'])
            s2 = s2Amount*float(historyDict2[i]['close_price'])
            initialBuy = s1+s2
            invested = s1+s2
            buyPow = 0
            
            # print("initial buy at: {}".format(initialBuy))
            # print("Bought {} shares of {} at the price of: {}".format(s1Amount, tick1, hist['close_price']))
            # print("Bought {} shares of {} at the price of: {}".format(s2Amount, tick2, historyDict2[i]['close_price']))
            # print("________________")
            lastI = i
            startLists = True
            j = 0
            initIndex = i
            

        if(startLists == True):
            list1.append((float(hist['close_price'])-float(historyDict1[initIndex]['close_price']))/float(historyDict1[initIndex]['close_price']))
            list2.append((float(historyDict2[i]['close_price'])-float(historyDict2[initIndex]['close_price']))/float(historyDict2[initIndex]['close_price']))
 
            if(list1[j]-list2[j] > highMargin and buySellBack == False and afterBuy == True):
                #sell from list1 buy from list2 
                list1Sold = True
                buySellBack = True
                s1 = s1Amount*float(hist['close_price'])-bsFrac*s1Amount*float(hist['close_price'])
                s2 = s2Amount*float(historyDict2[i]['close_price'])+bsFrac*s2Amount*float(historyDict2[i]['close_price'])
                invested = s1+s2
                buyPow += bsFrac*s1Amount*float(hist['close_price']) - bsFrac*s2Amount*float(historyDict2[i]['close_price']) 
                # print(hist['begins_at'])
                # print(100*(list1[j]-list2[j]))
                # print("BUY & SELL")
                # print("Sold {} at the price of: {}".format(tick1, hist['close_price']))
                # print("Bought {} at the price of: {}".format(tick2, historyDict2[i]['close_price']))
                # print("Invested: {}".format(invested))
                # print("Buying Power: {}".format(buyPow))
                # print("Total: {}".format(invested+buyPow))
                # print("Profit: {}".format(invested+buyPow-initialBuy))
                # print(s1Amount*float(historyDict1[i]['close_price']) + s2Amount*float(historyDict2[i]['close_price']) - initialBuy)
                # print(100*list1[j], 100*list2[j])
                # print()
                # print("________________")
                
                count += 1
            elif(list1[j]-list2[j] < -highMargin and buySellBack == False and afterBuy == True):
                #buy from list1 sell from list2
                list1Sold = False
                buySellBack = True
                s1 = s1Amount*float(hist['close_price'])+bsFrac*s1Amount*float(hist['close_price'])
                s2 = s2Amount*float(historyDict2[i]['close_price'])-bsFrac*s2Amount*float(historyDict2[i]['close_price'])
                invested = s1+s2
                buyPow += -bsFrac*s1Amount*float(hist['close_price']) + bsFrac*s2Amount*float(historyDict2[i]['close_price'])
                # print(hist['begins_at'])
                # print(100*(list1[j]-list2[j]))
                # print("BUY & SELL")
                # print("Bought {} at the price of: {}".format(tick1, hist['close_price']))
                # print("Sold {} at the price of: {}".format(tick2, historyDict2[i]['close_price']))
                # print("Invested: {}".format(invested))
                # print("Buying Power: {}".format(buyPow))
                # print("Total: {}".format(invested+buyPow))
                # print("Profit: {}".format(invested+buyPow-initialBuy))
                # print(s1Amount*float(historyDict1[i]['close_price']) + s2Amount*float(historyDict2[i]['close_price']) - initialBuy)
                # print(100*list1[j], 100*list2[j])
                # print("________________")
                
                count += 1
            elif(abs(list1[j]-list2[j]) < lowMargin and buySellBack == True and list1Sold == True and afterBuy == True):
                #buy and sell back 
                buySellBack = False
                s1 = s1Amount*float(hist['close_price'])
                s2 = s2Amount*float(historyDict2[i]['close_price'])
                invested = s1+s2
                buyPow += -bsFrac*s1Amount*float(hist['close_price']) + bsFrac*s2Amount*float(historyDict2[i]['close_price'])
                # print(hist['begins_at'])
                # print(100*(list1[j]-list2[j]))
                # print("BUY & SELL BACK")
                # print("Bought {} at the price of: {}".format(tick1, hist['close_price']))
                # print("Sold {} at the price of: {}".format(tick2, historyDict2[i]['close_price']))
                # print("Invested: {}".format(invested))
                # print("Buying Power: {}".format(buyPow))
                # print("Total: {}".format(invested+buyPow))
                # print("Profit: {}".format(invested+buyPow-initialBuy))
                # print(s1Amount*float(historyDict1[i]['close_price']) + s2Amount*float(historyDict2[i]['close_price']) - initialBuy)
                # print(100*list1[j], 100*list2[j])
                # print("________________")
                
                count += 1
            elif(abs(list1[j]-list2[j]) < lowMargin and buySellBack == True and list1Sold == False and afterBuy == True):
                #buy and sell back 
                buySellBack = False
                s1 = s1Amount*float(hist['close_price'])
                s2 = s2Amount*float(historyDict2[i]['close_price'])
                invested = s1+s2
                buyPow += bsFrac*s1Amount*float(hist['close_price']) - bsFrac*s2Amount*float(historyDict2[i]['close_price']) 
                # print(hist['begins_at'])
                # print(100*(list1[j]-list2[j]))
                # print("BUY & SELL BACK")
                # print("Sold {} at the price of: {}".format(tick1, hist['close_price']))
                # print("Bought {} at the price of: {}".format(tick2, historyDict2[i]['close_price']))
                # print("Invested: {}".format(invested))
                # print("Buying Power: {}".format(buyPow))
                # print("Total: {}".format(invested+buyPow))
                # print("Profit: {}".format(invested+buyPow-initialBuy))
                # print(s1Amount*float(historyDict1[i]['close_price']) + s2Amount*float(historyDict2[i]['close_price']) - initialBuy)
                # print(100*list1[j], 100*list2[j])
                # print("________________")
                
                count += 1
            j+=1
        # print(s1Amount*float(historyDict1[i]['close_price']))
        # print(s2Amount*float(historyDict2[i]['close_price']))
        # print(s1Amount*float(historyDict1[i]['close_price'])+s2Amount*float(historyDict2[i]['close_price']))
        # print()
        lastI = i

        #sell invested
    if buySellBack == False:
        buyPow += s1Amount*float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price']) 
    elif buySellBack == True and list1Sold == True:
        buyPow += s1Amount*float(historyDict1[lastI]['close_price'])-bsFrac*s1Amount*float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price'])+bsFrac*s2Amount*float(historyDict2[lastI]['close_price'])
    elif buySellBack == True and list1Sold == False:
        buyPow += s1Amount*float(historyDict1[lastI]['close_price'])+bsFrac*s1Amount*float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price'])-bsFrac*s2Amount*float(historyDict2[lastI]['close_price'])

    invested = 0

    # print("total profit w/algorithm: {}".format(invested+buyPow-initialBuy))
    # print("annual growth w/algorithm: +%{}".format(100*(invested+buyPow-initialBuy)/initialBuy))
    # print("------------------")
    # print("total profit w/o algorithm: {}".format(s1Amount*float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price']) - initialBuy))
    # print("annual growth w/o algorithm: +%{}".format(100*s1Amount*(float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price'])-initialBuy)/initialBuy))
    # print(count)
    # print(highMargin)
    # print(lowMargin)
    # print(similarity(tick1,tick2))
    growthw = 100*(invested+buyPow-initialBuy)/initialBuy
    growthwo = 100*(s1Amount*float(historyDict1[lastI]['close_price']) + s2Amount*float(historyDict2[lastI]['close_price'])-initialBuy)/initialBuy

    print("{} {}, {}, {}, {}, {}, {}, {}, {}".format(tick1,tick2, count, growthw, growthwo, growthw-growthwo, invested+buyPow-initialBuy, initialBuy, sim))
    



    

def similarity(tick1, tick2):
    historyDict1 = rh.stocks.get_stock_historicals(tick1, interval = 'day', span = 'year', bounds = 'regular', info = None)
    historyDict2 = rh.stocks.get_stock_historicals(tick2, interval = 'day', span = 'year', bounds = 'regular', info = None)
    initPrice1 = float(historyDict1[0]['close_price'])
    initPrice2 = float(historyDict2[0]['close_price'])
    list1 = []
    list2 = []
   
    for i, hist in enumerate(historyDict1, start=0):
        list1.append((float(hist['close_price'])-initPrice1)/initPrice1)
        list2.append((float(historyDict2[i]['close_price'])-initPrice2)/initPrice2)

    return(spearmanr(list1,list2)[0])


if __name__ == '__main__':
    main()